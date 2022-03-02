Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF13E4C9F71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiCBIjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239890AbiCBIjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:39:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ADE5576C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:38:26 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a5so1279203pfv.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6H6PLOlODlELuUrXrCLYoGeXhxxcGUB9kEy/fShHjn4=;
        b=kGOrPFJKIY2zeFcU6Bd2P7TZK+xqFiHSSY0aFvJaKv9cIpsG2U7WfOIWyPfgPKW0t1
         7TG3A/OoFGobN9N1LfM1tkJ22xS2FqOVBkUry4O75X/IcXg6ZBFwiB1b4YG0RO2+jbkO
         SxB44nqufytorpbdgh3WgaY72Q/fMd3wXEsT5juGljg+xBvYwxny4kcaK+N50Ab60Y6t
         8pOFo9uTJnX3LVpPKLbU33wZj3DhXV5+AaUAgbSZB7KWNjalg+E4EAMxk/wU/aQuE890
         uoJRknbjxvl645OSqL8L8xPvmnsnn3QHd4eQ7mg83FiSwyN6zB5+5Sw+NNDrID0YVfCk
         zeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6H6PLOlODlELuUrXrCLYoGeXhxxcGUB9kEy/fShHjn4=;
        b=BGeRRdtnnWrAenso8IXe5zP/EgfF+bhKpp2+EOMbiAHefWwsub28fLx4BHtUDTRlaC
         q7NEllKXMM3IWTX/dkkixXqnnuAnKe/fUi4MXOOF/2u8mkgm0Ka9mKv8DX1HB5gZVKEk
         WFqSLEgfMtwMJI5QzVT0kMvnffvfPLHKmR71CoKKErN3ORLly6YAQ7DSlWVWi3ckp6HS
         a4QuW6PzIEpXn+wVlmOTWf2XiU+UD02d99CE2EEtR/jMPHPVR7Vc+BUJyvQEt3nxnbVZ
         n7ejFMerugdcMiRheECmdLqqyog7gG8tllpR3N+BBCOVh62aqvnWucyuEwL9bOVdo/Kk
         p3Ug==
X-Gm-Message-State: AOAM532Q/IAXixFs4/YV2Tjv7WWiul9V0giyBJ4iFFdv74Dcp5sOSq4a
        dDA4EGq9alCKqyufynUpAuCKWg==
X-Google-Smtp-Source: ABdhPJzgdFgcCMX/hRjpvLUm5sqK8u+KnVSknTrF5zgAinrtJQ3utZbE65PdsaG5Q1sXGQgiS85mdg==
X-Received: by 2002:a63:8ac2:0:b0:341:1e45:26c with SMTP id y185-20020a638ac2000000b003411e45026cmr25687808pgd.31.1646210306168;
        Wed, 02 Mar 2022 00:38:26 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00071100b004f0f941d1e8sm18705141pfl.24.2022.03.02.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:38:25 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 2/3] sysctl: allow to set extra1 to SYSCTL_ONE
Date:   Wed,  2 Mar 2022 16:37:57 +0800
Message-Id: <20220302083758.32528-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220302083758.32528-1-songmuchun@bytedance.com>
References: <20220302083758.32528-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sysctls only allow to be enabled and cannot be set back to be
disabled. But proc_do_static_key() does not consider this situation,
which set ->extra1 to SYSCTL_ZERO unconditionally. This patch add
the ability to set ->extra1 to SYSCTL_ONE, which will be used in
the next patch.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 64065abf361e..ab3e9c937268 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1631,7 +1631,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.data   = &val,
 		.maxlen = sizeof(val),
 		.mode   = table->mode,
-		.extra1 = SYSCTL_ZERO,
+		.extra1 = table->extra1 == SYSCTL_ONE ? SYSCTL_ONE : SYSCTL_ZERO,
 		.extra2 = SYSCTL_ONE,
 	};
 
-- 
2.11.0

