Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF754DE64D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 06:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbiCSFh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 01:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiCSFhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 01:37:54 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2CA2E842F;
        Fri, 18 Mar 2022 22:36:32 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5ae905.dynamic.kabel-deutschland.de [95.90.233.5])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4862061EA1923;
        Sat, 19 Mar 2022 06:36:30 +0100 (CET)
Message-ID: <58404396-2dea-5e4d-1fcd-186730ee23c9@molgen.mpg.de>
Date:   Sat, 19 Mar 2022 06:36:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: ucsi_acpi: probe of USBC000:00 fails with ioremap error
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <b9b00e0e-9182-783d-ae30-d67d778ae060@molgen.mpg.de>
 <YjSZIT6p/QL5T1QJ@kuha.fi.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YjSZIT6p/QL5T1QJ@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: +Kai-Heng, +Hans]

Dear Heikki,


Am 18.03.22 um 15:37 schrieb Heikki Krogerus:

> On Fri, Mar 18, 2022 at 01:36:37PM +0100, Paul Menzel wrote:

>> On a Dell Precision 3540, Linux 5.16.12 reports an ioremap error:
>>
>>      [    0.000000] Linux version 5.16.0-4-amd64 (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.2.0-18) 11.2.0, GNU ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT Debian 5.16.12-1 (2022-03-08)
>>      [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.16.0-4-amd64 root=UUID=c9342a55-b747-4442-b2f4-bc03eb7a51cf ro quiet noisapnp log_buf_len=2M cryptomgr.notests btusb.enable_autosuspend=y random.trust_cpu=on
>>      […]
>>      [    0.000000] DMI: Dell Inc. Precision 3540/0M14W7, BIOS 1.15.0 12/08/2021
>>      […]
>>      [   24.230968] videodev: Linux video capture interface: v2.00
>>      [   24.237747] ioremap error for 0x78e31000-0x78e32000, requested 0x2, got 0x0
>>      [   24.238100] ucsi_acpi: probe of USBC000:00 failed with error -12
>>      […]
>>      $ sudo more /proc/iomem
>>      […]
>>      78a04000-78ea2fff : ACPI Non-volatile Storage
>>        78e31000-78e31fff : USBC000:00
>>      […]
>>
>> This seems to happen on a lot of Dell devices, cf. bug 199741 (ioremap error
>> on Dell XPS 9370) [1].
> 
> I'm not sure if this helps, but I'm going to change the ioremap() call
> to memremap() soon in any case in this driver. Can you test the
> attached patch?

Thank you very much for the instant reply and patch. Unfortunately, the 
device is in active use by a user, so I do not think I am going to able 
able to test it. I had hoped that the Dell client Linux kernel team 
could help out, or that the Intel Linux folks have access to recent Dell 
devices internally. Maybe Kai-Heng or Hans have an idea.


Kind regards,

Paul


PS: If there is a way to test this with a QEMU VM by passing through 
some devices, I should be able to test that, as it does not involve a 
system reboot.
