Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6456521D84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbiEJPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345559AbiEJPJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:09:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0054B1EC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652193694; x=1683729694;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N8drDJX7EjyPxyYIr/6B3eFepmHr9YPwLFJHcd7Dioo=;
  b=DC2cWzhaCxZJlXxKxTHswoa4WmFs258/mAjaknvrwPsIL83RN2PulNsB
   1cawQyuqP38szuzZV2ykYKajk+i+Mpuizs+anH33Zge3aCcq+HJd/s0qw
   6HJmtiDZrIMMNpwKksst09eNvL6hbJoUSbMjJZj91FF3HY4k8NzHZjnLo
   qNYejGL355n7/mmfuooB1BQaipeFR2nyIm7hPoRC29Fd790nuSmcPFTcJ
   UmCGS578UGsmckV8Tzhs7zr0EdlJ8jfBPogGs0yLytTxqZ9iJrXhYdQH1
   ExvzConkZ0F3JIFHjPuYQAQDSnOkHWTB1NAojYxswYiConrmgLpoalYc0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266982132"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="266982132"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:41:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="565671977"
Received: from fangy-mobl.ger.corp.intel.com (HELO [10.252.50.83]) ([10.252.50.83])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:41:09 -0700
Message-ID: <12bebc80-b792-5739-0d9d-ef1466a9b2aa@linux.intel.com>
Date:   Tue, 10 May 2022 16:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: Linux regressions report for mainline [2022-05-09] (was: Linux
 5.18-rc6)
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
 <165209064657.193515.10163777181547077546@leemhuis.info>
 <CAHk-=wj0gHsG6iw3D8ufptm9a_dvTSqrrOFY9WopObbYbyuwnA@mail.gmail.com>
 <54664f6a-b046-1330-e794-cb533e942a94@redhat.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <54664f6a-b046-1330-e794-cb533e942a94@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 09-05-2022 om 21:04 schreef Hans de Goede:
> Hi,
>
> On 5/9/22 19:20, Linus Torvalds wrote:
>> On Mon, May 9, 2022 at 3:47 AM Regzbot (on behalf of Thorsten
>> Leemhuis) <regressions@leemhuis.info> wrote:
>>> Hi Linus! Here's a quick compilation of open reports about regressions in
>>> 5.18-rc that I'm currently aware of; most of the reports are quite
>>> recent and there afaics is nothing that looks particularly worrisome.
>> Well, the Intel GPU issue seems likely to cause problems for lots of people:
>>
>>> [ *NEW* ] drm/i915: BYT rendering broken due to "Remove short-term pins from execbuf, v6"
>>> -----------------------------------------------------------------------------------------
>>> https://linux-regtracking.leemhuis.info/regzbot/regression/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
>>> https://lore.kernel.org/dri-devel/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
>>>
>>> By Hans de Goede; 0 days ago; 2 activities, latest 0 days ago.
>>> Introduced in b5cfe6f7a6e1 (v5.18-rc1)
>>>
>>> Recent activities from: Tvrtko Ursulin (1), Hans de Goede (1)
>> Although it looks possible that it mainly affects old chipsets (ie the
>> two reports are for a Bay Trail chip and a Core 2 Duo chip - I have no
>> idea how they compare).
>>
>> That probably means there are a lot of machines out there, but likely
>> not the kind that most kernel developers will be testing, so not a ton
>> of reports until it hits distro kernels etc.
>>
>> It looks like Maarten is already involved.
> This is being tracked here:
> https://gitlab.freedesktop.org/drm/intel/-/issues/5806
>
> I've just tested a patch from Maarten which fixes things for me,
> so hopefully we can get this resolved soon.
>
> Regards,
>
> Hans
>
Hey,

I'm still waiting on feedback on the last patch there, can you test it?

That should be the real fix most likely, waiting for binding to complete before using the vma.

~Maarten

