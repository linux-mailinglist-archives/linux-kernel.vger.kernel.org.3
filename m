Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633804959B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378652AbiAUGBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378603AbiAUGBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:01:33 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36931C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 22:01:33 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id z10so8847120qkf.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 22:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kuArtjaPTmOPdIiKrss07b+j2mZfFfYV+Yk+2Q5thaY=;
        b=ZrISea7edJPy2ZsjkPR4PtDRyXWh5CmUW1GXdTRJoY3xOQYMGxcrbblXTS7Ofwe7zN
         RwIJADlf3CHvgFC8kVWuo8vxVcu7z2ecL9ZHVn4zP9+WAnpveGx77O3SbCLkhcJGjK5e
         I/dGhGWQ1DefrbTj3tx+uJrhfSgl5DA/yOxa9MwNar+A18snjISuNU/hW7XidzadKBuA
         kjvoTG4FNUtvtBLaNW6tKuO6YWrVJlQdJQdd8xcuROyEGPt52hzWmL2lqP41FHrVbOZp
         vhi34FJ8KBx1Ntj7VWw7c06OH4x78bA4Zkcgt9PTsJhdbwM6crbNBZ115hDAyCitjO+a
         zGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kuArtjaPTmOPdIiKrss07b+j2mZfFfYV+Yk+2Q5thaY=;
        b=XHPD1FyDDqbvDMdBK6LY2aeYW8s5xcFRPWnGBx0bI3jSjrCea/u/5U0sgK2CWdtAJA
         FwJA7x6p0Hne/iSL3IQ3ihCyBpj9WyeWrLA6FmFDZQ3AygxrIEjRuUpXyJ8nNckuVv2a
         n58u26z9OPGHE/v/RYM189f06ujQ40iOM50yCkZzqNkBl2uXRg12nd+BCX1obnqv0f1/
         JOxtjyRNxVL/fgU50AUo16/NV2tI/WVS+nB5HEIl1nNH7LrIXkGLwtV+MOAoQ3a3GkJy
         SRJJHNIBNFnkEyKahryhsIT24Zzw8DGlJv7gubZHYEYNU2dSHKbfxKgLu9GDiZXKaumJ
         XjuA==
X-Gm-Message-State: AOAM533SmLBesRMs8RvmV2pThnJw4O5dp+F36hoWlzRTumS977UxTytX
        4mzHhUcqYQA0Is7rCG4ujTqyiSn4eq0=
X-Google-Smtp-Source: ABdhPJwsKWvGQXWohgcIutSnGbz0mYKIPdC29ugMxH0lrql4MlOX703nnFWVvI5t5sjyPGJ7Sax1mg==
X-Received: by 2002:a05:620a:2698:: with SMTP id c24mr1763523qkp.262.1642744892338;
        Thu, 20 Jan 2022 22:01:32 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c7sm2611515qtd.24.2022.01.20.22.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 22:01:31 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     rpeterso@redhat.com
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] GFS2: move sleep outside the spinlock
Date:   Fri, 21 Jan 2022 06:01:22 +0000
Message-Id: <20220121060122.998512-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Don't sleep with spinlock held, so move it outside critical section.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 fs/gfs2/lock_dlm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 50578f881e6d..e43b33b115b4 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -942,14 +942,15 @@ static int control_mount(struct gfs2_sbd *sdp)
 		if (sdp->sd_args.ar_spectator) {
 			fs_info(sdp, "Recovery is required. Waiting for a "
 				"non-spectator to mount.\n");
+			spin_unlock(&ls->ls_recover_spin);
 			msleep_interruptible(1000);
 		} else {
 			fs_info(sdp, "control_mount wait1 block %u start %u "
 				"mount %u lvb %u flags %lx\n", block_gen,
 				start_gen, mount_gen, lvb_gen,
 				ls->ls_recover_flags);
+			spin_unlock(&ls->ls_recover_spin);
 		}
-		spin_unlock(&ls->ls_recover_spin);
 		goto restart;
 	}
 
-- 
2.25.1

