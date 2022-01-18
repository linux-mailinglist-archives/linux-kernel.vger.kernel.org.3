Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDFC492301
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiARJnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:43:39 -0500
Received: from my.chaos-reins.com ([104.248.178.247]:48486 "EHLO
        my.chaos-reins.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiARJni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:43:38 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 04:43:38 EST
Received: (Haraka outbound); Tue, 18 Jan 2022 09:36:01 +0000
Authentication-Results: my.chaos-reins.com;
        auth=pass (login)
Received: from m.chaos-reins.com (21d594ba-beef-4400-bc88-b496d6dacd5a.cloudron [172.18.16.1])
        by my.chaos-reins.com (Haraka/2.8.28) with ESMTPA id 8630A604-7CDC-4F56-BC02-9865974B8D06.1
        envelope-from <d@chaos-reins.com> (authenticated bits=0);
        Tue, 18 Jan 2022 09:36:01 +0000
MIME-Version: 1.0
Date:   Tue, 18 Jan 2022 09:36:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   "Donald Carr" <d@chaos-reins.com>
Message-ID: <e2db335efc02c61f4a4035dd2270e256@chaos-reins.com>
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
To:     "Yu Zhao" <yuzhao@google.com>
Cc:     "Andi Kleen" <ak@linux.intel.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Hillf Danton" <hdanton@sina.com>, "Jens Axboe" <axboe@kernel.dk>,
        "Jesse Barnes" <jsbarnes@google.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Michael Larabel" <Michael@michaellarabel.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Rik van Riel" <riel@surriel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Will Deacon" <will@kernel.org>,
        "Ying Huang" <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
In-Reply-To: <YeaGkZ50n7/mDuJX@google.com>
References: <YeaGkZ50n7/mDuJX@google.com>
 <20220104202227.2903605-1-yuzhao@google.com> <YdSuSHa/Vjl6bPkg@google.com>
 <Yd1Css8+jsspeZHh@google.com>
DKIM-Signature: v=1;a=rsa-sha256;bh=hOtzxRssqC3l7oqL8Wf80/oCWxDs7JXspEQpiCwzMik=;c=relaxed/simple;d=chaos-reins.com;h=from:subject:date:message-id:to:cc:mime-version;s=cloudron;b=IgaPi/pt7BRp7bjlfgUvPiJN7/YwMQCMwsmNETelA7tikFfLy570SUa2bNHmc4quqjevtpMhwUDXzURBvYqJNzY1ROqcKc2c6ZLQ04ELbm4JAkFFawva0U7U81kmDAYKFrN4lAY/5PPvwisV1HrpK4vOvwuSe45R9CPeWA44Hpw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

January 18, 2022 1:21 AM, "Yu Zhao" <yuzhao@google.com> wrote:

> On Tue, Jan 11, 2022 at 01:41:22AM -0700, Yu Zhao wrote:
>=20
>>=20On Tue, Jan 04, 2022 at 01:30:00PM -0700, Yu Zhao wrote:
>> On Tue, Jan 04, 2022 at 01:22:19PM -0700, Yu Zhao wrote:
>>> TLDR
>>> =3D=3D=3D=3D
>>> The current page reclaim is too expensive in terms of CPU usage and i=
t
>>> often makes poor choices about what to evict. This patchset offers an
>>> alternative solution that is performant, versatile and
>>> straightforward.
>>=20
>>=20<snipped>
>>=20
>>>=20Summery
>>> =3D=3D=3D=3D=3D=3D=3D
>>> The facts are:
>>> 1. The independent lab results and the real-world applications
>>> indicate substantial improvements; there are no known regressions.
>>> 2. Thrashing prevention, working set estimation and proactive reclaim
>>> work out of the box; there are no equivalent solutions.
>>> 3. There is a lot of new code; nobody has demonstrated smaller change=
s
>>> with similar effects.
>>>=20
>>>=20Our options, accordingly, are:
>>> 1. Given the amount of evidence, the reported improvements will likel=
y
>>> materialize for a wide range of workloads.
>>> 2. Gauging the interest from the past discussions [14][15][16], the
>>> new features will likely be put to use for both personal computers
>>> and data centers.
>>> 3. Based on Google's track record, the new code will likely be well
>>> maintained in the long term. It'd be more difficult if not
>>> impossible to achieve similar effects on top of the existing
>>> design.
>>=20
>>=20Hi Andrew, Linus,
>>=20
>>=20Can you please take a look at this patchset and let me know if it's
>> 5.17 material?
>>=20
>>=20My goal is to get it merged asap so that users can reap the benefits
>> and I can push the sequels. Please examine the data provided -- I
>> think the unprecedented coverage and the magnitude of the improvements
>> warrant a green light.
>=20
>=20My gratitude to Donald who has been helping test MGLRU since v2:
>=20
>=20Donald Carr (d@chaos-reins.com)
>=20
>=20Founder of Chaos Reins (http://chaos-reins.com), an SF based
> consultancy company specializing in designing/creating embedded
> Linux appliances.

Tested-by: Donald Carr <d@chaos-reins.com>

> Can you please provide your Tested-by tags? This will ensure the credit
> for your contributions.
>=20
>=20Thanks!
