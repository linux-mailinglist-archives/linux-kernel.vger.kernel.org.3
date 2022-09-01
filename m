Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A005A5A9D56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiIAQng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiIAQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:43:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC56E89CF9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:43:29 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 78so3402978pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cotescu.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=+MkbZeortxQsFFb3QQQ/6yOnlElUjOUUAdTneds9S/g=;
        b=Yi3qQWXQld7GifWFSyf2+wlSJoXpMQUs6QF67d9NCot+k2sJDyTcsGh2jnUlvI40rX
         JkIrFUB3u/0yioztq0FiYI0Gexlsa4zseoTjZkwwBLe2fawoS6dqYxDT9CDstRBId6Zn
         GIW++ezcFm8aveJONc9FKl3C35ZyOoW0GgF5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=+MkbZeortxQsFFb3QQQ/6yOnlElUjOUUAdTneds9S/g=;
        b=hMiZ4TzxIQ4O1hiBLFaaP1rCmfCDfuj/L75TBCAq0czwJY9f4+cjVPqwEEQm3YEpeD
         luptAmE2ch2gZaUsX/CU4H+cO9VFrD+a3w6RI/dxrmydyQGDGKTgqLlkZpsSDT5dI95c
         Fugu3Q2zRustdn7LgH6vUobKmrXNGewLCvfR9+cHNmOqZiZwNFNc5ANyl3T4DaI65Xbn
         RMpkWetj6UwPvoGKahQnHlIhJbfaAoWjuPWShxR+a7Tw94RuiN/nUrHQf6f1RBQuNXCG
         N54ofNFVQQIWO4kTcJ6u3QlFaZRP13jqKNPH5RGB4W4ITjQYrwwGcN66eupnhYtvdcew
         VVcg==
X-Gm-Message-State: ACgBeo3X0vK+M39Ug8dPaMa4BUj4ivrUBkU6GJa5dFAhjPiWP3snAM1a
        LYAvZgG7kMtbAmTtUWIHn5TDCVsvu6rajkQyYpj4zuMd1qBe0A==
X-Google-Smtp-Source: AA6agR6jG3lZ8kw6yTLOHiV2R0HbM3mX9wYwSHGM2YPH7GxXHHuQu1YOEqbjXte93XScV0DKbO4ZbpR8Qeyta7sdF24=
X-Received: by 2002:a05:6a00:16c1:b0:520:6ede:24fb with SMTP id
 l1-20020a056a0016c100b005206ede24fbmr32154532pfc.7.1662050608839; Thu, 01 Sep
 2022 09:43:28 -0700 (PDT)
MIME-Version: 1.0
From:   Radu Cotescu <radu-likes-to-code@cotescu.com>
Date:   Thu, 1 Sep 2022 18:43:18 +0200
Message-ID: <CALmVdU7jbxNHtODRVXaFTt=fzS1w_G+Nm5EGKuyzpERdPAHMsw@mail.gmail.com>
Subject: [hidraw] help with debugging the module on Linux 4.4.180+ on Synology
 DSM 7
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please excuse me if this message would be better suited to a different
list (linux-usb, linux-input ?!).

I would need hidraw available on my Synology device running DSM 7.
Since Synology doesn't provide the module by default, I downloaded the
Linux kernel source files from Synology, compiled the module myself
and installed it (modprobe). If I run modinfo I get the following
output:

sudo modinfo hidraw
filename:       /lib/modules/hidraw.ko
license:        GPL
depends:
vermagic:       4.4.180+ SMP mod_unload

BTW, I had to manually use module_init / module_exit to have the
module run its hidraw_init function. I have no clue why the __init
macro didn't work in this case (not a C developer).

However, when I plug in a USB device that should be recognised via
hidraw, I only see hiddev listed:

[1022952.762352] usb 1-1: new full-speed USB device number 20 using xhci_hcd
[1022952.906233] usb 1-1: ep 0x81 - rounding interval to 64
microframes, ep desc says 80 microframes
[1022952.916192] usb 1-1: ep 0x1 - rounding interval to 64
microframes, ep desc says 80 microframes
[1022952.926479] drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 0
[1022952.927386] drivers/hid/usbhid/hid-core.c: submitting ctrl urb:
Get_Report wValue=0x0100 wIndex=0x0000 wLength=64
[1022952.928132] Get empty minor:104
[1022952.931914] hid-generic 0003:16D6:0007.0003: hiddev0: USB HID
v1.11 Device [JABLOTRON ALARMS JA-82T PC Interface] on
usb-0000:00:15.0-1/input0

lsusb reports the following:
lsusb -i
|__usb1          1d6b:0002:0404 09  2.00  480MBit/s 0mA 1IF  (Linux
4.4.180+ xhci-hcd xHCI Host Controller 0000:00:15.0) hub
  |__1-1         16d6:0007:0100 00  2.00   12MBit/s 100mA 1IF
(JABLOTRON ALARMS JA-82T PC Interface 00000000)
  1-1:1.0         (IF) 03:00:00 2EPs () usbhid

Obviously no /dev/hidraw* device is created and /sys/class/hidraw is
empty. Any pointers on how I could figure out what's wrong?

Thanks,
Radu
