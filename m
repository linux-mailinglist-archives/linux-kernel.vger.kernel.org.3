Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6A5AACE1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiIBKyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiIBKyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:54:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FC4C9270
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 03:54:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l3so1450402plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WSGy8JuZtB1pyuGGOt6vRdCmNn8tUcEetPk/ksDWFKg=;
        b=Wj3S/q7B8Gan3S/BUil/w1zgXVJgnGZFk9DY1ISEhRX861a+dI0bbLwUDboeK2nyuT
         yM5H76yRuyhNLXxo1C660kdYsaztfOoO9BZ+8ELAEIfJ6Aq0F+BHuTYjwaJKjMmA0xgj
         kHEoHkFiLt9ddVs8O64lALk2NfhPMvuppzWIxQ4C4EhoZjrdd7qXztHP8omLekIx3N0W
         +VoBU8A1tyCi0YC9aFZfxTDLlMxzu6WB6Nl9r1CaPTpvYe3m0vg4py1LGrC/yNvBbTUZ
         qsRk1ymGudIMCyOT/rPjinnAVFIAgv/wzUPE7IsZ5F91eSpAoOYZQylS2tWaWURFB7Ue
         JY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WSGy8JuZtB1pyuGGOt6vRdCmNn8tUcEetPk/ksDWFKg=;
        b=WvFZISesESsaNTYsqlBD1MbOSZxtRiRjYFcb1csxBMw91fQgJ/NhP+mRWH/CbZtNTd
         B/J8fdiNX398bFbWilr7/HKdn9dgZzPvIBHHJa1MoPaEKgsn6mfxS/6/MPug3u+v77z7
         wN2WA7zE5tnxwKu6Bs8JzQGCqAVWpCoopjkUK/tDoEcQ6BLrBvjlPntVWdIWvEwwND8j
         m6SlhuX8lsWuwKndy7UiRb4F6riQ/gziE4E+3pkgYpOKA1ibwMKMxlnIn5Vs303VEnns
         bMza7uJB7b7+boEWfXcJlRlMixz5CIv4RYdQY5SpIj3T56MXiFjCM5QkdWVqsElzM8Op
         R8gg==
X-Gm-Message-State: ACgBeo1U08FLBZIg8RypR85tfULI/EcK6ivzlBx1CTQW8HYR3d9vZPkI
        6vu8NVUx/+38kpfdDLDa6wsB9Q==
X-Google-Smtp-Source: AA6agR5rfCKb3/V3WdTz2E14dB38FL7AQ1K7gvNoL25/1KczOhYLVFusGaVaI7dDwk3q3G4USKLfkw==
X-Received: by 2002:a17:90a:cb14:b0:1fd:c964:f708 with SMTP id z20-20020a17090acb1400b001fdc964f708mr4194965pjt.62.1662116052125;
        Fri, 02 Sep 2022 03:54:12 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e4-20020a63d944000000b0041b29fd0626sm1128681pgj.88.2022.09.02.03.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 03:54:11 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V2 1/5] erofs: add 'domain_id' mount option for on-demand read sementics
Date:   Fri,  2 Sep 2022 18:53:01 +0800
Message-Id: <20220902105305.79687-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902105305.79687-1-zhujia.zj@bytedance.com>
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce 'domain_id' mount option to enable shared domain sementics.
In which case, the related cookie is shared if two mountpoints in the
same domain have the same data blob. Users could specify the name of
domain by this mount option.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index cfee49d33b95..fe435d077f1a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -76,6 +76,7 @@ struct erofs_mount_opts {
 #endif
 	unsigned int mount_opt;
 	char *fsid;
+	char *domain_id;
 };
 
 struct erofs_dev_context {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3173debeaa5a..d01109069c6b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -440,6 +440,7 @@ enum {
 	Opt_dax_enum,
 	Opt_device,
 	Opt_fsid,
+	Opt_domain_id,
 	Opt_err
 };
 
@@ -465,6 +466,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
 	fsparam_string("device",	Opt_device),
 	fsparam_string("fsid",		Opt_fsid),
+	fsparam_string("domain_id",	Opt_domain_id),
 	{}
 };
 
@@ -568,6 +570,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 			return -ENOMEM;
 #else
 		errorfc(fc, "fsid option not supported");
+#endif
+		break;
+	case Opt_domain_id:
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+		kfree(ctx->opt.domain_id);
+		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
+		if (!ctx->opt.domain_id)
+			return -ENOMEM;
+#else
+		errorfc(fc, "domain_id option not supported");
 #endif
 		break;
 	default:
@@ -695,6 +707,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
 	ctx->opt.fsid = NULL;
+	ctx->opt.domain_id = NULL;
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
@@ -838,6 +851,7 @@ static void erofs_fc_free(struct fs_context *fc)
 
 	erofs_free_dev_context(ctx->devs);
 	kfree(ctx->opt.fsid);
+	kfree(ctx->opt.domain_id);
 	kfree(ctx);
 }
 
@@ -892,6 +906,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
+	kfree(sbi->opt.domain_id);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -1044,6 +1059,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (opt->fsid)
 		seq_printf(seq, ",fsid=%s", opt->fsid);
+	if (opt->domain_id)
+		seq_printf(seq, ",domain_id=%s", opt->domain_id);
 #endif
 	return 0;
 }
-- 
2.20.1

