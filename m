Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E074F4A628D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbiBARgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:36:21 -0500
Received: from cmo-0000.xspmail.jp ([202.238.198.167]:25301 "EHLO
        cmo-0000.xspmail.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiBARgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:36:20 -0500
Received: from cmr-0001.xspmail.jp ([202.238.198.118])
        by cmo with ESMTP
        id Ex4cniau2wQRREx4lnduW4; Wed, 02 Feb 2022 02:36:19 +0900
Received: from elitebook830 ([IPv6:2409:12:b80:1600:39e1:fc73:9e8c:f6df])
        by cmr with ESMTPA
        id Ex4knFBHbGmxsEx4knJI9p; Wed, 02 Feb 2022 02:36:19
 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iijmio-mail.jp;
        s=x01; t=1643736979; i=henrich@iijmio-mail.jp;
        bh=xdw0itmGCBhhy/h8SDeKCXG31a3FtbYRAcutJpka3hA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=vt8ff5PTtTwNU/FYoH1n+b02kLBl3wHptqj2j4huuFpD1a7hMRQgxR+RkbP4b42mY
         kHIuYrp1LV40dqZno55hXC4LAO7MPhSAqsMuhUEdUKcDJNdcQcRd2ZJdn1xnvM8Dn7
         LcZH4uE9YdQ7MUByyHZkxcSRNnn+nfF83SyfuoXpB8dGtP6J75OZsaZDf54qY00oMw
         NowlCjdvFFVxMR51+aNbxXkdrsXX+hhPxBvSkmvMbBkqXXZ+cKZ/TrkQRw3fXHveT2
         oyeS6BZO37dCLupkPLqsIAYvqwSHjCkha5Irw5olUU7Pqgdj9KIsASzTObvlF+XQYz
         2vxSCz183MIrQ==
Date:   Wed, 2 Feb 2022 02:36:18 +0900
From:   Hideki Yamane <henrich@iijmio-mail.jp>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, henrich@iijmio-mail.jp
Subject: Re: [PATCH RFC 0/4] firmware: Add ZSTD-compressed file support
Message-Id: <20220202023618.2f676b6b319188c470a15e0b@iijmio-mail.jp>
In-Reply-To: <s5h8rv0i8gf.wl-tiwai@suse.de>
References: <20210127154939.13288-1-tiwai@suse.de>
        <YBGeXDTEy8myghot@kroah.com>
        <20220128032213.c93b56aa2ea1c77e34b28290@iijmio-mail.jp>
        <YfLnTm7L3m6jEB+4@kroah.com>
        <20220128093335.e8d01f21c4b930c30f77e08a@iijmio-mail.jp>
        <YfOTHj8oRoxdhX6c@kroah.com>
        <s5h8rv0i8gf.wl-tiwai@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Jan 2022 09:13:36 +0100
Takashi Iwai <tiwai@suse.de> wrote:
> It's totally untested, and it'd be appreciated if
> anyone can confirm that it's working and used.  Then we can happily
> re-submit the patches for the merge.

 I've built it with 5.16.4 based one in Debian experimental repository
 and it seems to work (note: build failure with 5.15.15 in Debian unstable).


 How to check:
  1. compress firmware files under /lib/firmware with zstd
  2. boot with distro kernel that is not enable this feature
  3. Wifi that needs firmware doesn't work as expected (*1)
  4. boot with patched kernel
  5. Wifi works :) (*2)


 logs:

(*1)

 2月 02 02:09:43 elitebook830 kernel: Intel(R) Wireless WiFi driver for Linux
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-36.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: firmware_class: See https://wiki.debian.org/Firmware for information about missing firmware
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-36.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-35.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-35.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-34.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-34.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-33.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-33.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-32.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-32.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-31.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-31.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-30.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-30.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-29.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-29.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-28.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-28.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-27.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-27.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-26.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-26.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-25.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-25.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-24.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-24.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-23.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-23.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-22.ucode (-2)
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-22.ucode failed with error -2
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: minimum version required: iwlwifi-8265-22
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: maximum version supported: iwlwifi-8265-36
 2月 02 02:09:43 elitebook830 kernel: iwlwifi 0000:01:00.0: check git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git


(*2)

 2月 02 02:12:35 elitebook830 kernel: Intel(R) Wireless WiFi driver for Linux
 2月 02 02:12:35 elitebook830 kernel: iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
 2月 02 02:12:35 elitebook830 kernel: usb 3-1.3.2.1.4.2: FTDI USB Serial Device converter now attached to ttyUSB0
 2月 02 02:12:35 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: failed to load iwlwifi-8265-36.ucode (-2)
 2月 02 02:12:35 elitebook830 kernel: firmware_class: See https://wiki.debian.org/Firmware for information about missing firmware
 2月 02 02:12:35 elitebook830 kernel: iwlwifi 0000:01:00.0: firmware: direct-loading firmware iwlwifi-8265-36.ucode
 2月 02 02:12:35 elitebook830 kernel: iwlwifi 0000:01:00.0: loaded firmware version 36.ca7b901d.0 8265-36.ucode op_mode iwlmvm






-- 
Hideki Yamane <henrich@iijmio-mail.jp>
