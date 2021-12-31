Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9848234A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 11:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhLaKWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 05:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLaKWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 05:22:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FC9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 02:22:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w20so46267332wra.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 02:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlpugDrkjbxKUnYLBcla6CSYhjRVpPctfD23qwxThtU=;
        b=dED7gF7aHiq8ABASqPcdg0xQwbMonz0lYf8jr8cEGIbs3FspFmdLbVazpTRetqA+Yc
         VnVrE7FVT4hTy/F3mtbzakn3F51CzdPC3YaBY50psEDg3Sl9FzR7uLqEafx7qt1PfsCz
         fkEWGY1bILwKP2EPVDOZMwIOI1gbonQSXVklnI9wGPNC7LDl+rZ91jmm4lUSMDDODmJ3
         BNiFKlDaQhmR5yjfKkT1ERnKpYYmJslfvhS4LjvnDm4PWZ1yXbJMwBa0EY6Sy8GNq2y7
         btRg9WDz3DurJEpCJTsCcMJgrOFwNFgceopoW1vJ8N+bxoikK71MGJAcsKyTvJXFvbz1
         hpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlpugDrkjbxKUnYLBcla6CSYhjRVpPctfD23qwxThtU=;
        b=QHAIFKw93806ERAZk+Nst8e04yVQ/q3fXlCILvcWJg80DiZjO7Jh/8VfUDd6svvhud
         TIQBOeIjfqJaZYwaw5BaTGLn2bHFrKQdWptHw/wCzsh/piwL+c1bC/eqDuVOjCA8i+4l
         26KJZHr1aQHeNh996iPN2agy6gNhnZY+a15d5DYOidzfS+CsZ5qFbWBEYyQ0/gV67pjm
         /9v4FrYOJHWI+0OpRjQqsQUQikupkyK9XusUNrzTXELuLGLfvJ54vdyQ345Q2XA8W181
         dMvWfD6abdVwlDB4G4YFjlmFjcNHpfrhd7YbxYxrhdRj0iGlF4u96M6CZEStoCYHgS+S
         ji0w==
X-Gm-Message-State: AOAM530Co1rtNqH+fMijMbLD+a8+dlc72p1sP1E5WHdydJqR31c9f5cI
        iVhFYdm+i5CXI0v2XFvNsH0=
X-Google-Smtp-Source: ABdhPJxxiWAvC3FSUU7cKk1ghI1xuMN+Mx7ahOUETaMd7EqqZSx5PqbDfaV6LAhcvquqdB7XzO4hSA==
X-Received: by 2002:adf:d1cc:: with SMTP id b12mr30571101wrd.282.1640946154906;
        Fri, 31 Dec 2021 02:22:34 -0800 (PST)
Received: from cosmos.lan (77.116.53.251.wireless.dyn.drei.com. [77.116.53.251])
        by smtp.gmail.com with ESMTPSA id d22sm26230509wmq.17.2021.12.31.02.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 02:22:34 -0800 (PST)
From:   Christian Lachner <gladiac@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Christian Lachner <gladiac@gmail.com>
Subject: [PATCH 0/1] ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Master after reboot from Windows
Date:   Fri, 31 Dec 2021 11:21:37 +0100
Message-Id: <20211231102138.3226-1-gladiac@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 hda-verb /dev/snd/hwC2D0 0x20 SET_COEF_INDEX 0x58
 hda-verb /dev/snd/hwC2D0 0x20 SET_PROC_COEF 0x8fd6
 hda-verb /dev/snd/hwC2D0 0x20 SET_COEF_INDEX 0x5f
 hda-verb /dev/snd/hwC2D0 0x20 SET_PROC_COEF 0xa3c5
 hda-verb /dev/snd/hwC2D0 0x20 SET_COEF_INDEX 0x6a
 hda-verb /dev/snd/hwC2D0 0x20 SET_PROC_COEF 0x0232

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

 sound/pci/hda/patch_realtek.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

-- 
2.34.1

