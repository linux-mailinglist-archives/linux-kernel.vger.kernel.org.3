Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402FC5838E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiG1GkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiG1Gj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:39:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AEC5C96F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:39:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b133so1120951pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kUZ/dgqC7iw0jhI4uYoWyAcN87LUuqF13JYqIaofqY=;
        b=hTxJbdtJd14HVPheUaqfh98GeNpnBo3mzEF73RKAoFpp+jNZuDAMxRDyKMNSidAYur
         lWqQY/766U1A1JtH3lOY4TzIlJXpOZenWrAFHJlgNMpROvL18TdxgfISIWp3i0Ywll1j
         j6Z+uq/2+NlpnaVM63F+yyb7MYeXg4cwVh15kC0KXxVuPbV5KknP7MNMI1WDeXvG45rR
         72LX1ZOOVRsD0BMe7cAsrhhUMMk8ZoMQYwXKiBkLEwJ+93Ypmw/TCotxWMZMN0kv949x
         Zwxy8sNaYe3oo40Hkzj5VQScEIgTDYo5hgUPhoLcawI+BU+Yzad3YwEPD0tcsne7Nkwv
         ArRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kUZ/dgqC7iw0jhI4uYoWyAcN87LUuqF13JYqIaofqY=;
        b=sbg7O671XTrcdit889lEirlRIThRPrOfOzbbzLjY7LPcyhsaDEE7Lz4AMqgw5sverC
         sIc4wc6kZqeEYzD8gJGh88MtUjthm78qAwoW3SMsKnq6fDj/MixiPc45hAIi1PdQXckr
         6n2wNfX9Fa46Ok5yl4fascMHL+cgYJdPiqwCcCqJ9H4H1oP7xpaMxP8A6IxtADfbrqL/
         rYO1ys3950QsuYeGwKnWKPSVVeNTrpnYaGxD+Iuf0tREEeIYRKGu954JZXlFRs5+k4z/
         gHq5XSWj39aMVyoLdnGOBtwXy2KWI0chArpCvpv6sA+LBfDccrXa4S/IFbvCq1Tv731U
         Egwg==
X-Gm-Message-State: AJIora97iKkZNJ+CaLBpn77kQQCtiCmC9sQk4kR/gkXGAcqU3xrdEWc5
        rmZq6HNCf6AXhw7MZAJz/lQzTA==
X-Google-Smtp-Source: AGRyM1tvBFvRXWWgx31iR7pfQeXgyc4b1FfwvZgr1t5Z3xxZ5QUrFkoWWUhy4aMXTTZ+7pxYqOhPQg==
X-Received: by 2002:a65:57c6:0:b0:415:c329:5d49 with SMTP id q6-20020a6557c6000000b00415c3295d49mr21175206pgr.581.1658990397120;
        Wed, 27 Jul 2022 23:39:57 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090a384100b001f31e91200asm704723pjf.44.2022.07.27.23.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 23:39:56 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Hongbo Yin <yinhongbo@bytedance.com>,
        Tianci Zhang <zhangtianci.1997@bytedance.com>
Subject: [PATCH] ovl: only WARN_ON_ONCE() if dentry is NULL in ovl_encode_fh()
Date:   Thu, 28 Jul 2022 14:38:55 +0800
Message-Id: <20220728063856.72705-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

So let's replace WARN_ON() with WARN_ON_ONCE() to avoid kernel log
flooding.

Reported-by: Hongbo Yin <yinhongbo@bytedance.com>
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Signed-off-by: Tianci Zhang <zhangtianci.1997@bytedance.com>
---
 fs/overlayfs/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 2eada97bbd23..3a8650442aec 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -259,7 +259,7 @@ static int ovl_encode_fh(struct inode *inode, u32 *fid, int *max_len,
 		return FILEID_INVALID;
 
 	dentry = d_find_any_alias(inode);
-	if (WARN_ON(!dentry))
+	if (WARN_ON_ONCE(!dentry))
 		return FILEID_INVALID;
 
 	bytes = ovl_dentry_to_fid(ofs, dentry, fid, buflen);
-- 
2.20.1

