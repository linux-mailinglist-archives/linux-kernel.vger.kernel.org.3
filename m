Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3C5A27DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245049AbiHZMdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHZMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:33:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC73DAA3A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:33:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p18so1468170plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Y5c37Nq33O3MeYZTEmF4WCceNnuG63z/xmNqaPUq83I=;
        b=PoHycqaPDgldrKy9t2N75OJk/ttEtsLOvZjSHmhwWs8bbOk/1PazMzGAPn2N+akdgL
         6rPdFlO+sY8saU0PfewhQYQizrQrs6ZU/4eumXHO0PPgWSMcK/HTeGECLQtAGg4JB9cX
         3qDfx6NllcunGGXB24WvlNSSNCFU0bC82MK0r/rFs1ceQZrYtv9zNRXlzLDPsY2fydO2
         2PaWkxLbgyLvDxtjMPjLdIQUYpfLIlJNj9N4i5bzk3tCkJ/0Z9h7Nn5rXteFw0rI/KbM
         UVQst+HyV9KtKUKtfCloAcrlfHMMCbs0c8JXqHyT0tvmGiEic86yy8R4lNPsgOCzizm0
         +2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Y5c37Nq33O3MeYZTEmF4WCceNnuG63z/xmNqaPUq83I=;
        b=ErxlEgLIoo7lo+TO1nv3Jy2TdnOpHQnnI1sVzWo1GQGpEUNZm7IH2c5C8z0028n3T4
         GXI/rx5kVy2FkLu/p6TkpnAJjlalT0uM7TRA3OfqWhKP5AEMfy3CfaJABDxvv3fSBq2c
         mzSMdOn2uvYAHmlJYZ5eDng2in1XapvstqH03RycCI7bwOgzLzX8frvpn+iRVsQ8wdQs
         3/tIPavb7nHH7YxBxV1LtxOby7cRVoLv7LxTXFDbBh1RrI+TvC8kgKJgxrWYG0C8tXje
         VH9aHKFrKe5Xak0TqRGp1TUkDeEbuN2GUAbPrOKgtHpdDN8869e3OllQMp4Bxv8S7AF9
         B+iQ==
X-Gm-Message-State: ACgBeo1XzxEyJvtKHpf2xdGfPLgX6Ainw+h+wb6uFk6Eth85n41cXPNc
        f48XE+TrDi019ghsC+HFiHI=
X-Google-Smtp-Source: AA6agR4qi8cTqCo+EZNWH5RRTyKaysnpdpw+ysLAB41QdnvE07HdbDKYOvYUG417VBbdBuYAD9qeNw==
X-Received: by 2002:a17:90b:4c8d:b0:1f5:409b:b017 with SMTP id my13-20020a17090b4c8d00b001f5409bb017mr4318701pjb.52.1661517198452;
        Fri, 26 Aug 2022 05:33:18 -0700 (PDT)
Received: from localhost ([36.112.195.70])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090301cc00b0016bf5557690sm1493439plh.4.2022.08.26.05.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 05:33:18 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com, Anton Altaparmakov <anton@tuxera.com>
Cc:     akpm@linux-foundation.org, chenxiaosong2@huawei.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] ntfs: change check order in ntfs_attr_find
Date:   Fri, 26 Aug 2022 20:32:57 +0800
Message-Id: <20220826123257.3826-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826122735.2690-1-yin31149@gmail.com>
References: <20220826122735.2690-1-yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> Looks like it is improper check order that causes this bug.

Sorry for wrong command.
#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 52615e6090e1..6480cd2d371d 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -594,10 +594,11 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
 	for (;;	a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
 		u8 *mrec_end = (u8 *)ctx->mrec +
 		               le32_to_cpu(ctx->mrec->bytes_allocated);
+		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end)
+			break;
 		u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
 			       a->name_length * sizeof(ntfschar);
-		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
-		    name_end > mrec_end)
+		if (name_end > mrec_end)
 			break;
 		ctx->attr = a;
 		if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
-- 
2.25.1
