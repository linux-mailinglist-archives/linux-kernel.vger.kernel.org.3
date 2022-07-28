Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D934583E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiG1Ltv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiG1Ltr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:49:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470C2691E1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:49:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pw15so1625697pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FuGo2hGCGa82jk275UGlQ/lMBHWW+gC0TJ/OSJFNVVg=;
        b=FTKOAJsOgk6g90cTCOXS+Q0GEu2Eh/zcFwc4Kl3pJny2BfESLuzfyKZcN4Sh+KfTD5
         oTYH8gTgLno9nNaCmGySvu80n4iTRTArslvqls6yRLLW5CIUCXxfxeZyRKF5/5GOXMFi
         M2XiaesdcoWVKi33w2bh9QyR8cxY+QNSNufUGse+I8Us5zSfvx4fKKgePwvXprVXZecy
         4Go9fu/YdhOgdRyY0VGLN17DRtIuP+XDds4Cjp6hrOUWTedVVJmJGSO4897NQOfqG9Ih
         yQ2V99H1NuLoNLNoK13w30v/fCGdJVs8HwjPru2BrBKZylJbjS5IW/5gfZ/HxvlJ7/gC
         1UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FuGo2hGCGa82jk275UGlQ/lMBHWW+gC0TJ/OSJFNVVg=;
        b=7SLkgwAAmMdcHe80X5IfaJYhwAsyuoheNDFl4ZV4ne8OIATZMsuQbks+wWwQsD6Oim
         UHgKvvzFQInDohNXc/gGX+J1xYna7sJRPRQVr4/9ge38HhndRL5kT6NltvEBoUlvS/Vf
         fFgaUjGg/vWXTJk4wCsUlcxJR3i+0CgT5IaqOVu8C83yb43eeo33JLaOUvv3ejiC+1bh
         gks2XK24sFURSG259dCvwcbRkL5u0feXkcN6rKTMHSMk8dE3ZJJLwckeQXSHF/aCvWWe
         OMo9s9NyTQ7uMKeKWi0vQNfNuje1auuTDAcNqblFY/0suLfV9wqmE0kZ0WJczigpYjhh
         +x4w==
X-Gm-Message-State: AJIora9qn9Z17k6lhfifyHLRB1gjqmH5+UFgSRZo0vB40df11iRFdHX4
        pC5NuS19CFSZEIzEBR06BijuFA==
X-Google-Smtp-Source: AGRyM1vRx4Ytrd2vFeDMnd3OtaGgG6/z+Iwyu3C5PKp8GWsE/nyxpX848go4H8AyshSw+bjyqFsQ5w==
X-Received: by 2002:a17:90b:1d12:b0:1f1:8d48:abaa with SMTP id on18-20020a17090b1d1200b001f18d48abaamr10158277pjb.96.1659008985827;
        Thu, 28 Jul 2022 04:49:45 -0700 (PDT)
Received: from bogon.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id f4-20020a62db04000000b005251fc16ff8sm477419pfg.220.2022.07.28.04.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:49:45 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Hongbo Yin <yinhongbo@bytedance.com>,
        Tianci Zhang <zhangtianci.1997@bytedance.com>
Subject: [PATCH v2] ovl: drop WARN_ON() dentry is NULL in ovl_encode_fh()
Date:   Thu, 28 Jul 2022 19:49:15 +0800
Message-Id: <20220728114915.91021-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some code paths cannot guarantee the inode have any dentry alias. So
WARN_ON() all !dentry may flood the kernel logs.

For example, when an overlayfs inode is watched by inotifywait (1), and
someone is trying to read the /proc/$(pidof inotifywait)/fdinfo/INOTIFY_FD,
at that time if the dentry has been reclaimed by kernel (such as
echo 2 > /proc/sys/vm/drop_caches), there will be a WARN_ON(). The
printed call stack would be like:

    ? show_mark_fhandle+0xf0/0xf0
    show_mark_fhandle+0x4a/0xf0
    ? show_mark_fhandle+0xf0/0xf0
    ? seq_vprintf+0x30/0x50
    ? seq_printf+0x53/0x70
    ? show_mark_fhandle+0xf0/0xf0
    inotify_fdinfo+0x70/0x90
    show_fdinfo.isra.4+0x53/0x70
    seq_show+0x130/0x170
    seq_read+0x153/0x440
    vfs_read+0x94/0x150
    ksys_read+0x5f/0xe0
    do_syscall_64+0x59/0x1e0
    entry_SYSCALL_64_after_hwframe+0x44/0xa9

So let's drop WARN_ON() to avoid kernel log flooding.

Reported-by: Hongbo Yin <yinhongbo@bytedance.com>
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Signed-off-by: Tianci Zhang <zhangtianci.1997@bytedance.com>
---
 fs/overlayfs/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 2eada97bbd23..e065a5b9a442 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -259,7 +259,7 @@ static int ovl_encode_fh(struct inode *inode, u32 *fid, int *max_len,
 		return FILEID_INVALID;
 
 	dentry = d_find_any_alias(inode);
-	if (WARN_ON(!dentry))
+	if (!dentry)
 		return FILEID_INVALID;
 
 	bytes = ovl_dentry_to_fid(ofs, dentry, fid, buflen);
-- 
2.20.1

