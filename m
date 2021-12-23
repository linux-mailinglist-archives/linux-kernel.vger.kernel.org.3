Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663EE47DE13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 04:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346215AbhLWDYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 22:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346189AbhLWDYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 22:24:23 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF1AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 19:24:23 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id k4so3714910pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 19:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=48R3Uu/IbHX0iXPv/VGTpOehS2HTlBUJ2clVFeFdtfY=;
        b=eSlXCNp+XryuMDR1fxU5CfDwvjweikVdL6NlLdCOesb2DtOUNcWcZmXXGEeCk+oqyx
         DztCikPrfKLRs3iOLFHiX6BB7Alw3EsPuQh9U2TEvN+kV5W+Rkq0JevjOoQI0IqBKg95
         AmLzLrpfs7zlazX0D133ldNxr0+ibMpVnWDQyGXfPEW4Nw/s3OZRlRjRoPqeh7GXGU+s
         BiCYkvkWgtKh+v4S1iSS6+ZsVUuuXThb25FsPOmgQ1TTsMdp7FQ+KFNupB2bAO+GZWbd
         ur6uvHWzc65jhnHImcph6k+YQZYs0pR9QEQXBHqyxTpNi2ZtJpHTMvvYV2ATdCBLzusq
         CBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48R3Uu/IbHX0iXPv/VGTpOehS2HTlBUJ2clVFeFdtfY=;
        b=1CgOF0GI5uT+yGBdTdZ0yxwKHAjmrTbGYWmdEYsGmqvYuVydQ3vPteYahH+1DUBWiv
         GtSLOsGVS7ftU8bciOzv0DoujT3XhHfnhfJZv20tTqCWzkx2uhsbXa5OKHvCrb/FzLqM
         YlVCZekYTZeeLR0US3sCQ7FnD97Yfh9y6L5RkMgz+j3BcOEggcnBCoT8rO8SyQZEXvc6
         WhQl7xM9JWVaGzN73xApEjvjUSbiRXxSU1/zayaJma5qblCRDaT8ID+6ooHNPTihYkf0
         QC1tgTR2HAMv6J1x5mrLZMmDruYIe090FZM4Vgus3C2ENpm+a+bmLkEkM1KP+VyeNpNw
         xsAg==
X-Gm-Message-State: AOAM532t5V7fmahJ/lne8g76En2QYaEj7VaRnoFUHNkcWqEWXGkW735n
        NHOi2GHMtGMG0HooesDb+LdEY7Ab5CJDuA==
X-Google-Smtp-Source: ABdhPJxx9Woht889dMPfw8FsF9cSeIOB0xddNj66SXlGSng82of4xDAVY6o1nbRgranplD3U1d2TJA==
X-Received: by 2002:a05:6a00:2356:b0:4ba:f28c:63da with SMTP id j22-20020a056a00235600b004baf28c63damr688932pfj.50.1640229863304;
        Wed, 22 Dec 2021 19:24:23 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d3sm4348622pfv.192.2021.12.22.19.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 19:24:23 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH 2/2] ext4: fast commit may miss tracking unwritten range during ftruncate
Date:   Thu, 23 Dec 2021 11:23:37 +0800
Message-Id: <20211223032337.5198-3-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223032337.5198-1-yinxin.x@bytedance.com>
References: <20211223032337.5198-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If use FALLOC_FL_KEEP_SIZE to alloc unwritten range at bottom, the
inode->i_size will not include the unwritten range. When call
ftruncate with fast commit enabled, it will miss to track the
unwritten range.

Change to trace the full range during ftruncate.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 82f555d26980..1d2ba63874ad 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5423,8 +5423,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 				ext4_fc_track_range(handle, inode,
 					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
 					inode->i_sb->s_blocksize_bits,
-					(oldsize > 0 ? oldsize - 1 : 0) >>
-					inode->i_sb->s_blocksize_bits);
+					EXT_MAX_BLOCKS - 1);
 			else
 				ext4_fc_track_range(
 					handle, inode,
-- 
2.20.1

