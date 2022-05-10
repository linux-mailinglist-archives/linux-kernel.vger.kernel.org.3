Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21D85213BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241021AbiEJLc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241018AbiEJLcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:32:08 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A224F0CC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:28:07 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1noO1z-0003eV-DR; Tue, 10 May 2022 13:27:55 +0200
Message-ID: <ff841fdc-4db7-7a3d-8caf-d0cddd0dfa31@leemhuis.info>
Date:   Tue, 10 May 2022 13:27:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Link: tag and links to submission and reports (was: Re: [GIT pull]
 core/urgent for v5.18-rc6)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <165201148069.536527.1960632033331546251.tglx@xen13>
 <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1652182088;cbc44195;
X-HE-SMSGID: 1noO1z-0003eV-DR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.05.22 20:00, Linus Torvalds wrote:
> On Sun, May 8, 2022 at 5:05 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> A single bugfix for the PASID management code, which freed the PASID too
>> early. The PASID needs to be tied to the mm lifetime, not to the address
>> space lifetime.
> 
> So I have to once more complain about the -tip tree "Link:" usage.

Many thx for reminding people about the tag.  FWIW, that's a problem in
a lot or subsystems and makes my regression tracking efforts hard, as my
tracking bot relies on the 'Link:' tag. If it's missing I thus have to
manually search if patches were posted or committed to fix a regression,
which makes the tracking hard and annoying. :-/

> Again, the commit has a link to the patch *submission*, which is
> almost entirely useless. There's no link to the actual problem the
> patch fixes.

It seems quite a few developers are under the impressions that "Link:"
is just for the patch submission and not to be used for other things.
That's why some people invented other tags. I see "BugLink" quite often
these days, but there are also other tags in use (some drm people used
"References:" for a while).

Do we care? Should we try to clean this up while making things a bit
more straight forward at the same time by making it more obvious what a
link is actually about? I once suggested we use something like
* "Submitted:" or "Posted:" for the patch submission
* "Reported:" or "BugLink:" for any reports that lead to the

That would leave "Link:" ambiguous and usable for anything else (and b4
likely could be fixed easily to set a different tag; but sure, there
would be a transition period).

But there was not much feedback on the idea. Do you think I should pick
up this again? Or is this something I should bring up during this years
kernel summit?

> [...]
> Put another way: I can see that
>     Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>

With a "Reported:" tag like mentioned above we could stop using
"Reported-by:" if we wanted to reduce the overhead (or make it
optional). But OTOH I guess it's a bad idea, as having this in there
will motivate some people to submit reports. And is good for stats reg.
syzbot and 0-day (but I guess those could be generated from proper
links, too).

BTW: Documentation/process/5.Posting.rst states '''Be careful in the
addition of tags to your patches: only Cc: is appropriate for addition
without the explicit permission of the person named.''' Is that actually
true? A lot of people seem to set "Reported-by:" without getting
explicit permission. If that is fine I'd prepare a patch to fix the docs.

Ciao, Thorsten
