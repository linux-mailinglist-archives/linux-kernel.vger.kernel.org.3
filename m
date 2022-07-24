Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3339557F531
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 15:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiGXNVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 09:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGXNVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 09:21:53 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF7B4A5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 06:21:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d10so8181754pfd.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=yCaTZ6AUan3y8YqGHPIq2wk6gRvHTQrg/g6BBWDxZRk=;
        b=RsTpKwxRBL0QC5O4xnKokcqEbegyKFewsZHh5OTVbkf81jt0TOEqj6cMkuyFdCSnxa
         Xwn1iyXquOPegAcFqa3I2AkdyN7fK90fOpQpuoq5QTwVAQPwRw5h1e+XXPcWm+mK/qfK
         48rwox04Wnqtiidmr7ywkwDHkDZ76EYA6b6plIBPye2zLtjKfk+t+mKBOS7UHDI12//9
         /i2kOvdIBlkr3Ddv3genAar65LdMPCrd0B3IjUOR5fxS6ETlzEJ9LmWUEMF16c+36HXy
         Bn12bPD0CSuqk48m+r4MjWNZ4wKvejYXUFP/pwt5ib+fd13SQ/ELTXhsvJzNIhGXq5mS
         rcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yCaTZ6AUan3y8YqGHPIq2wk6gRvHTQrg/g6BBWDxZRk=;
        b=hmVn/Usg6n8NItqraeCEhqh+IisxHmWfTGFJ5rcXL6UjmHUNSe5V6vlc4xTDc1iw1W
         GMM8Jrqy3sDx2T9+aeKrd81W7fRcbvIgJhpU8KFRYPJegzLe0yXlxuXGaUJNqPLcLGe7
         nitiKjxdF+kZxkD4lADUTpSC6JB1My/08Gq66dUtvahJX1REIOxWQ05UECkJuNhyYq7P
         aZMV0HmJmcOULTrWjK7Bb/QVSYQd79WTCyH9FGMfpJmy3R2oEgla4BGacj7n1STe68kr
         LoQr6f7ZcCA/Gh1MmcUhLVw+dbYyVnp8IGQwxgqTaAv23krZ379vdXMk6XKbsIodLANo
         0Tcg==
X-Gm-Message-State: AJIora8i2/AoeRtQI4kQsfPRFoujU/kZqWbAzmZ88rQrdQAsnxo9P7NK
        O+fY7RySbZY53sVfbA24o5g=
X-Google-Smtp-Source: AGRyM1vIxQlx4B0EXKsDDofEXRxcl+OyFM+qSaqj/+f0s3zA3EqaGrGEWjur9YEbguCnkhZEGf2tXQ==
X-Received: by 2002:a05:6a00:10ca:b0:4f7:5af4:47b6 with SMTP id d10-20020a056a0010ca00b004f75af447b6mr8687114pfu.6.1658668910896;
        Sun, 24 Jul 2022 06:21:50 -0700 (PDT)
Received: from Negi ([68.181.16.133])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016d1e514ec5sm7144017pln.139.2022.07.24.06.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 06:21:50 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Anton Altaparmakov <anton@tuxera.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] ntfs: Ensure $Extend is a directory
Date:   Sun, 24 Jul 2022 06:21:07 -0700
Message-Id: <20220724132107.1163-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes Syzbot bug: kernel BUG in ntfs_lookup_inode_by_name
https://syzkaller.appspot.com/bug?id=32cf53b48c1846ffc25a185a2e92e170d1a95d71

Check whether $Extend is a directory or not( for NTFS3.0+) while loading
system files. If it isn't(as in the case of this bug where the mft record for
$Extend contains a regular file), load_system_files() returns false.

Reported-by: syzbot+30b7f850c6d98ea461d2@syzkaller.appspotmail.com
Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 fs/ntfs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 5ae8de09b271..18e2902531f9 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -2092,10 +2092,15 @@ static bool load_system_files(ntfs_volume *vol)
 	// TODO: Initialize security.
 	/* Get the extended system files' directory inode. */
 	vol->extend_ino = ntfs_iget(sb, FILE_Extend);
-	if (IS_ERR(vol->extend_ino) || is_bad_inode(vol->extend_ino)) {
+	if (IS_ERR(vol->extend_ino) || is_bad_inode(vol->extend_ino) ||
+	    !S_ISDIR(vol->extend_ino->i_mode)) {
+		static const char *es1 = "$Extend is not a directory";
+		static const char *es2 = "Failed to load $Extend";
+		const char *es = !S_ISDIR(vol->extend_ino->i_mode) ? es1 : es2;
+
 		if (!IS_ERR(vol->extend_ino))
 			iput(vol->extend_ino);
-		ntfs_error(sb, "Failed to load $Extend.");
+		ntfs_error(sb, "%s.", es);
 		goto iput_sec_err_out;
 	}
 #ifdef NTFS_RW
-- 
2.17.1

