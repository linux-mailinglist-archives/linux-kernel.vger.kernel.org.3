Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3614EA99E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiC2Iu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiC2Iuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:50:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD4C49FAF;
        Tue, 29 Mar 2022 01:49:12 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nZ7XJ-0002LE-Ip; Tue, 29 Mar 2022 10:49:09 +0200
Message-ID: <07541714-5d44-dd84-5ab2-a9ce91bba715@leemhuis.info>
Date:   Tue, 29 Mar 2022 10:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Bug 215715 - PCI device (iwlwifi) is not working due to PCI power
 state change issues
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ad13371f-2883-bcf2-a62c-78104bfd615c@leemhuis.info>
In-Reply-To: <ad13371f-2883-bcf2-a62c-78104bfd615c@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1648543752;d606202a;
X-HE-SMSGID: 1nZ7XJ-0002LE-Ip
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.03.22 15:33, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> Rafael, I noticed a regression report in bugzilla.kernel.org that afaics
> nobody acted upon since it was reported about a week ago, that's why I
> decided to forward it to the lists, maintainers, and the author of the
> culprit. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=215715 :
> 
>>  Stefan Gottwald 2022-03-21 13:31:43 UTC
>>
>> Created attachment 300589 [details]
>> dmesg output from error case
>>
>> We got a Elo AIO i2 device which most current BIOS where WiFi was working with Kernel 5.12.x but stopped working since Kernel 5.13.19 and newer (5.17.0-rc5).
>>
>> The kernel error message is:
>>
>> [    3.419766] iwlwifi 0000:01:00.0: can't change power state from D3cold to D0 (config space inaccessible)
>> [    3.419781] iwlwifi 0000:01:00.0: can't change power state from D3cold to D0 (config space inaccessible)
>> [    3.419975] iwlwifi 0000:01:00.0: HW_REV=0xFFFFFFFF, PCI issues?
>> [    3.420911] iwlwifi: probe of 0000:01:00.0 failed with error -5
>>
>> The issue can be solved by adding the iwlwifi driver to the initramfs so it is loaded much earlier and seems to work.
>>
>> To narrow down the issue I did an git bisect between v5.13.18 and v5.13.19 mainline kernel version which got me to following commit which if reverted fix the issue on this device.
>>
>> Reverting commit d0660d8ab123ea471064f0828f290bec9593e16b : PCI: Use pci_update_current_state() in pci_enable_device_flags()
> 
> FWIW, that afaics is d0660d8ab123 ("PCI: Use pci_update_current_state()
> in pci_enable_device_flags()") in mainline.

Sorry, I made a (obvious) cut-n-paste error there: the stable commit
mentioned by the reporter is 14858dcc3b35 ("PCI: Use
pci_update_current_state() in pci_enable_device_flags()") in mainline.

#regzbot introduced: 14858dcc3b35

>> resolve the issue also in the newer kernels. Seems like the function platform_pci_get_power_state is always returning PCI_D3cold on this device also if this is not true.
> 
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?
> 
> Anyway, to get this tracked:
> 
> #regzbot introduced: d0660d8ab123ea471064f0828f290bec9593e16b
> #regzbot from: Stefan Gottwald <gottwald@igel.com>
> #regzbot title: pci/iwlwifi: wifi is not working due to PCI power state
> change issues
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215715
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 
