Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBB552E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349193AbiFUJjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348826AbiFUJjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:39:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7BC275D4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:39:20 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o3aLu-0000JA-E6; Tue, 21 Jun 2022 11:39:18 +0200
Message-ID: <4457efae-2c74-4251-f0db-88cfc833b591@leemhuis.info>
Date:   Tue, 21 Jun 2022 11:39:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Boot stall regression from "printk for 5.19" merge
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
References: <20220619204949.50d9154d@thinkpad>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220619204949.50d9154d@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655804360;0ed4c12f;
X-HE-SMSGID: 1o3aLu-0000JA-E6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 19.06.22 20:49, Marek Behún wrote:
> Hello Linus, Petr, John,
> 
> the series
> https://lore.kernel.org/linux-kernel/YouKQw72H7y9EJQK@alley/
> merged by commit 537e62c865dc ("Merge tag 'printk-for-5.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux")
> 
> and in particular the commit 09c5ba0aa2fc ("printk: add kthread console
> printers")
> 
> causes a regression on arm64 (Marvell CN9130-CRB board) where the
> system boot freezes in most cases (and is unusable until restarted by
> watchdog), or, in some cases boots, but the console output gets mangled
> for a while (the serial console spits garbage characters).
> 
> The stall example:
> 
>   ...
>   [    1.108141] io scheduler mq-deadline registered
>   [    1.108143] io scheduler kyber registered
>   [    1.163484] armada-ap806-pinctrl f06f4000.system-controller:pinctrl: registered pinctrl driver
>   [
> 
> Or another:
> 
>   ...
>   [    1.108155] io scheduler mq-deadline registered
>   [    1.108156] io scheduler kyber registered
>   [    1.162991] armada-ap806-pinctrl f06f4000.system-controller:pinctrl: registered pinctrl driver
>   [    1.163361] armada-cp110-pinctrl f2440000.system-controller:pinctrl: registered pinctrl driver
>   [    1.180827] mv_xor_v2 f0400000.xor: Marvell Version 2 XOR driver
>   [  
> 
> The garbage example:
> 
>   ...
>   [    0.920951] raid6: using neon recovery algorithm
>   [    0.921228] iommu: Default domain type: Translated
>   %
> 
>           gb@k+cFL/[    4.954974] DSA: tree 0 setup
>   [    4.955286] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> 
> I did not have time to look at the contents of the commit yet to try to
> fix it myself, and won't have time for another two weeks. But I thought
> I should let you know now.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced v5.18..v5.19-rc3
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
