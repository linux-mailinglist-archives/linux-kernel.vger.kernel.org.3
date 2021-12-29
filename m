Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D302481483
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbhL2PkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbhL2PkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:40:14 -0500
X-Greylist: delayed 538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Dec 2021 07:40:13 PST
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de [IPv6:2a01:4f8:c17:c88::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAA8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:40:13 -0800 (PST)
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
        id DD8BF9123B; Wed, 29 Dec 2021 16:31:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
        s=mail; t=1640791872;
        bh=3+cxsWJzcxwxvlgm8JC15q9orIzlvp5B33kSIsTPbvA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZbwYQCZCW3LUexeKdnHHLPSarGo4gcKOPqDEbB7c9soqyLHEfdiucq+aFayk2nd+X
         3bNlF+a85TgNP40vTAVfgUZ+EJxBCN2Qa89yNtkdQkfg96qLruyMf2/LBWRVj+bc5R
         /9du+AR5ECpgY1BTQxrk594VCjYXAoWJeM84sTmU=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        magratgarlick.emantor.de
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from localhost (unknown [IPv6:2001:9e8:2145:1402:c0d3:dbff:fefe:ff70])
        by magratgarlick.emantor.de (Postfix) with ESMTPSA id 3987C909AC;
        Wed, 29 Dec 2021 16:31:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
        s=mail; t=1640791869;
        bh=3+cxsWJzcxwxvlgm8JC15q9orIzlvp5B33kSIsTPbvA=;
        h=From:To:Cc:Subject:Date:From;
        b=E6h0sbTWvJSGKmYmR3cxSM+AycehfQjSMaqkPlfA42julzHJd45aqbuEPNH7AAFxR
         2LwBeMecwo5mnVAhLZyCIzGLzZMY3dCyl9T69jTMaC8ohv2jH5p0X8JRlswY3vjqBM
         SgIjAxMfJhhU0Unxe436eyF1oTAJiR+tGhZhrjCU=
User-agent: mu4e 1.6.10; emacs 27.2
From:   Rouven Czerwinski <rouven@czerwinskis.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Simeon Simeonoff <sim.simeonoff@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Colin Ian King <colin.king@intel.com>
Subject: IOMMU Page Fault with Creative Soundblaster Zx after suspend
Date:   Wed, 29 Dec 2021 16:24:13 +0100
Message-ID: <87mtkjqvgj.fsf@czerwinskis.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With current 5.15.11, my soundblaster Zx is not correctly coming back
from suspend. Dmesg prints:

[Mi Dez 29 16:12:14 2021] [drm] UVD and UVD ENC initialized successfully.
[Mi Dez 29 16:12:14 2021] snd_hda_codec_ca0132 hdaudioC0D1: ca0132 DSP downloaded and running
[Mi Dez 29 16:12:15 2021] [drm] VCE initialized successfully.
[Mi Dez 29 16:12:15 2021] usb 1-5: reset full-speed USB device number 2 using xhci_hcd
[Mi Dez 29 16:12:16 2021] ata1.00: Enabling discard_zeroes_data
[Mi Dez 29 16:12:16 2021] OOM killer enabled.
[Mi Dez 29 16:12:16 2021] Restarting tasks ... done.
[Mi Dez 29 16:12:16 2021] PM: suspend exit
[Mi Dez 29 16:12:16 2021] snd_hda_intel 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000f address=0xdf880000 flags=0x0000]
[Mi Dez 29 16:12:17 2021] igb 0000:08:00.0 enp8s0: igb: enp8s0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX

Where the IOMMU Page Fault looks suspicious. Unbinding and rebinding the
driver using sysfs fixes it, thats the current workaround I have
been using.

Thanks and happy holidays,
Rouven Czerwinski
