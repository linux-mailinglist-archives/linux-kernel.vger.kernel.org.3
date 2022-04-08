Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408544F92A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiDHKNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiDHKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:13:39 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96B4ABF47;
        Fri,  8 Apr 2022 03:11:36 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nclaY-0007kr-Mq; Fri, 08 Apr 2022 12:11:34 +0200
Message-ID: <031b72a5-907e-219f-7433-8de3641d7c01@leemhuis.info>
Date:   Fri, 8 Apr 2022 12:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kyle McGrath <kyle.mcgrath@protonmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Regression: Extremely unstable connection on ax200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649412696;c1211c97;
X-HE-SMSGID: 1nclaY-0007kr-Mq
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org that afaics nobody
acted upon since it was reported about a week ago, that's why I decided
to forward it to the lists and all people that seemed to be relevant
here. To quote from https://bugzilla.kernel.org/show_bug.cgi?id=215789 :

>  Kyle McGrath 2022-04-01 14:05:34 UTC
> 
> Created attachment 300678 [details]
> Log of iwlwifi on 5.17
> 
> Recently I updated to the Fedora 36 beta, with the 5.17 kernel. Ever since, I've experienced excessive issues with my Intel AX200 wireless card. Every other aspect of my usage has remained the same (laptop and router both in the same location, same number of devices on the network, etc.)
> 
> Before updating to 5.17, I was able to perform latency-sensitive tasks such as playing online games and use VoIP applications without issue, with acceptable latency. After updating to 5.17 it is at the point where I cannot have an enjoyable match due to constant ping spikes, often to the point where the game will "stutter" or "lock up" every 10 seconds or say, with excessively high ping to go along with this. My VoIP applications have similar issues with calls often being interrupted or distorted.
> 
> I reverted to 5.16.16 and this has alleviated the issue for the time being. I've included journal output from both 5.17 and 5.16 and you can see there are several issues/errors which are not present on 5.16.
> 
> Below is all I get from the journal for iwlwifi under 5.16. I've included 5.17 output as an attachment.
> 
> 
> Apr 01 01:18:06 tarsonis kernel: iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
> Apr 01 01:18:06 tarsonis kernel: iwlwifi 0000:03:00.0: api flags index 2 larger than supported by driver
> Apr 01 01:18:06 tarsonis kernel: iwlwifi 0000:03:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
> Apr 01 01:18:06 tarsonis kernel: iwlwifi 0000:03:00.0: loaded firmware version 67.8f59b80b.0 cc-a0-67.ucode op_mode iwlmvm
> Apr 01 01:18:07 tarsonis kernel: iwlwifi 0000:03:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
> Apr 01 01:18:07 tarsonis kernel: iwlwifi 0000:03:00.0: Detected RF HR B3, rfid=0x10a100
> Apr 01 01:18:07 tarsonis kernel: iwlwifi 0000:03:00.0: base HW address: e0:d4:e8:a5:98:21
> Apr 01 01:18:07 tarsonis kernel: iwlwifi 0000:03:00.0 wlp3s0: renamed from wlan0


Could somebody take a look into this? Or was this discussed somewhere
else already? Or even fixed?

Anyway, to get this tracked:

#regzbot introduced: v5.16..v5.17
#regzbot from: Kyle McGrath <kyle.mcgrath@protonmail.com>
#regzbot title: iwlwifi: Extremely unstable connection on ax200
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215789

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.
