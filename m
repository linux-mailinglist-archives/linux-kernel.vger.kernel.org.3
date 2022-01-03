Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704144831AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiACOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiACOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:06:01 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC69C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 06:06:01 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m21so137523493edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 06:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7l1N3XOpZYsurbeAEhyNi3v7swAEPB3pgAvLGm6C2g8=;
        b=KSXmxgR1TNYYPOKYqVk8SrfAl0dva5wUZMGCdceMpDUP71rhz4XCgNL+DJVm58RA1w
         INgZHgmN4WVmN9NDEk0ECUzyN1Zutdevg8mntQ1M4U4zD1rnAVAJBOBLaQJ2RLxTOjHx
         BzvQEn1oEzqvvowzieRYTBnBXYMkK2l0E10/Ot1r700sG/7fDYp2Zq+/K8fKBVET+NKB
         jZuD1Pj+UQVcsatZ/Ib2PX2OCvTsFZZQ2TdT2qrnuY/1wnyDisQN2z9EP/6wwMXnjok0
         2Ahd/Hb10V5pRDjtD/3Bm2GIzZ04jJJZvPGV0zEB59WpaNpFq4S2lEi5H8co1vDszMeo
         97EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7l1N3XOpZYsurbeAEhyNi3v7swAEPB3pgAvLGm6C2g8=;
        b=rWaZaOPLB+rLcUiNO7M4CSr+jYYu3Kn8NO/VBZr9215iKT+6HP99EtLDeKzC+xUojT
         5yRe6badc2wCUjdLUF1qQJHUZALU4UhjmRiX/VhVYCMvMcmsyVMOm2iiMShkMtSB61pu
         0b3uUwXkOzjCkEyGdfnOC18+Jz2WUap35bjV+Ak/s72JPKmA1qt3NZW527qEj8HOMs93
         7X+SmYuWRCKUl22ErVXh0/oafvW6k7CRgJ20LpqIMRtKwr4Q21TQhrWWecj2RAh4brB9
         saB2dmafCAsGVUnJt0BzXUlBN8vLN8+qKAxC5YhEHIGz4BtU327FJjRIQwfaNgwfYQzf
         JkGg==
X-Gm-Message-State: AOAM533F4rztPnp4P6aLwn7EG/PGmRq0dkFSj38EmEaN9jpDTkBgw7Qf
        RHtF8YCK3usm99nbSTFnJG0=
X-Google-Smtp-Source: ABdhPJz9dO+U2IX25lTafqd8SM9pTmNc4D8Sywjzj+Fy4Ev6NgZGXr4X5biNoXH+SQV4fua6mhhdBA==
X-Received: by 2002:a50:9d48:: with SMTP id j8mr45399399edk.192.1641218759995;
        Mon, 03 Jan 2022 06:05:59 -0800 (PST)
Received: from cosmos.lan (77.116.2.39.wireless.dyn.drei.com. [77.116.2.39])
        by smtp.gmail.com with ESMTPSA id k16sm10694297ejk.172.2022.01.03.06.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 06:05:59 -0800 (PST)
From:   Christian Lachner <gladiac@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Christian Lachner <gladiac@gmail.com>
Subject: [PATCH v2 0/1] ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Master after reboot from Windows
Date:   Mon,  3 Jan 2022 15:05:16 +0100
Message-Id: <20220103140517.30273-1-gladiac@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 2 of my patch. It implements suggestions from Takashi Iwai.
Thanks for that! Furthermore, I re-analyzed all the relevant coefs and
removed those that are not actually needed.

===

This patch addresses an issue where after rebooting from Windows into Linux
there would be no audio output.

It turns out that the Realtek Audio driver on Windows changes some coeffs
which are not being reset/reinitialized when rebooting the machine. As a
result, there is no audio output until these coeffs are being reset to
their initial state. This patch takes care of that by setting known-good
(initial) values to the coeffs.

The coeffs were collected via alsa-info, see:
  broken: https://pastebin.com/4bRBSseH
  working: https://pastebin.com/WUTufvZB

I also created a script which fixes the audio at runtime.

 #!/bin/sh
 hda-verb /dev/snd/hwC2D0 0x20 SET_COEF_INDEX 0x1a
 hda-verb /dev/snd/hwC2D0 0x20 SET_PROC_COEF 0x01c1
 hda-verb /dev/snd/hwC2D0 0x20 SET_COEF_INDEX 0x1b
 hda-verb /dev/snd/hwC2D0 0x20 SET_PROC_COEF 0x0202
 hda-verb /dev/snd/hwC2D0 0x20 SET_COEF_INDEX 0x43
 hda-verb /dev/snd/hwC2D0 0x20 SET_PROC_COEF 0x3005

However, obviously, we can and should fix this in the kernel.

We initially relied upon alc1220_fixup_clevo_p950() to fix some pins in the
connection list. However, it also sets coef 0x7 which does not need to be
touched. Furthermore, to prevent mixing device-specific quirks I introduced
a new alc1220_fixup_gb_x570() which is heavily based on
alc1220_fixup_clevo_p950() but does not set coeff 0x7 and fixes the coeffs
that are actually needed instead.

This new alc1220_fixup_gb_x570() is believed to also work for other boards,
like the Gigabyte X570 Aorus Extreme and the newer Gigabyte Aorus X570S
Master. However, as there is no way for me to test these I initially only
enable this new behaviour for the mainboard I have which is the Gigabyte
X570(non-S) Aorus Master.

I tested this patch on the 5.15 branch as well as on master and it is
working well for me.

Christian Lachner (1):
  ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Master
    after reboot from Windows

 sound/pci/hda/patch_realtek.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

-- 
2.34.1

