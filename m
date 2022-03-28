Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E4C4E983C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiC1NfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiC1NfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:35:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6005DB1A;
        Mon, 28 Mar 2022 06:33:31 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nYpUu-0005IN-90; Mon, 28 Mar 2022 15:33:28 +0200
Message-ID: <ad13371f-2883-bcf2-a62c-78104bfd615c@leemhuis.info>
Date:   Mon, 28 Mar 2022 15:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Bug 215715 - PCI device (iwlwifi) is not working due to PCI power
 state change issues
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1648474411;4bf31efa;
X-HE-SMSGID: 1nYpUu-0005IN-90
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

Rafael, I noticed a regression report in bugzilla.kernel.org that afaics
nobody acted upon since it was reported about a week ago, that's why I
decided to forward it to the lists, maintainers, and the author of the
culprit. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=215715 :

>  Stefan Gottwald 2022-03-21 13:31:43 UTC
> 
> Created attachment 300589 [details]
> dmesg output from error case
> 
> We got a Elo AIO i2 device which most current BIOS where WiFi was working with Kernel 5.12.x but stopped working since Kernel 5.13.19 and newer (5.17.0-rc5).
> 
> The kernel error message is:
> 
> [    3.419766] iwlwifi 0000:01:00.0: can't change power state from D3cold to D0 (config space inaccessible)
> [    3.419781] iwlwifi 0000:01:00.0: can't change power state from D3cold to D0 (config space inaccessible)
> [    3.419975] iwlwifi 0000:01:00.0: HW_REV=0xFFFFFFFF, PCI issues?
> [    3.420911] iwlwifi: probe of 0000:01:00.0 failed with error -5
> 
> The issue can be solved by adding the iwlwifi driver to the initramfs so it is loaded much earlier and seems to work.
> 
> To narrow down the issue I did an git bisect between v5.13.18 and v5.13.19 mainline kernel version which got me to following commit which if reverted fix the issue on this device.
> 
> Reverting commit d0660d8ab123ea471064f0828f290bec9593e16b : PCI: Use pci_update_current_state() in pci_enable_device_flags()

FWIW, that afaics is d0660d8ab123 ("PCI: Use pci_update_current_state()
in pci_enable_device_flags()") in mainline.

> resolve the issue also in the newer kernels. Seems like the function platform_pci_get_power_state is always returning PCI_D3cold on this device also if this is not true.

Could somebody take a look into this? Or was this discussed somewhere
else already? Or even fixed?

Anyway, to get this tracked:

#regzbot introduced: d0660d8ab123ea471064f0828f290bec9593e16b
#regzbot from: Stefan Gottwald <gottwald@igel.com>
#regzbot title: pci/iwlwifi: wifi is not working due to PCI power state
change issues
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215715

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

