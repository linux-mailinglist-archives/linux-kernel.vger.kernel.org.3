Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9794E59AC8E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344285AbiHTI0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTI0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:26:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A642D13D73;
        Sat, 20 Aug 2022 01:26:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id jl18so5910169plb.1;
        Sat, 20 Aug 2022 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Dn2qS73bQA0BOB6QqauWx5nVdicgwt0wVWXhw2Mkp2A=;
        b=RwcuIgF5zLlYNJrS0xlItMBbGXi0c1U+vNtKkAxbVGCFyB10DINwcV+XgsA7U7T+Ib
         w9DFtEtmGITwH/DnsHRKohO1KOgVDZ2k8oKJJ+xrOGTxPDI6ynquJytxmGJtOCHc3RFQ
         EC0CkTIvLVXHyCJdzbnX1YXx6q3Pj9QsiSc5CJsgEDETmVQ+ewxljU9W/bkJNfb1pgjS
         dh5e0LYZbhdNak67FmwYYHA9ywNk917p4ACtUMO2pMff3f676dbj+tI7u4uKeWv5mXkV
         jUr7Uu060H/CQH2HhVetMdAg49OIh1nDKAE71+V0GFIZacosnViKTOHycGGK2+MkP1+X
         1JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Dn2qS73bQA0BOB6QqauWx5nVdicgwt0wVWXhw2Mkp2A=;
        b=Bv1qTfoK8LFCBAIei4PVU6qJW0vYfqwa+oXZIIe8XhxVrOQ7Dc6vukWYJIF7b2g4c7
         caGi08u9VgIUepb6Q5uG/s0Y6HHAoX6IzC/6m+pmjSzQNLpoQEOS7ysBPnM5g4y2L4U+
         FwOXY6pMatu4zr9o1N8kdcdz56dn3ZWACKrF5NkBcbOgVYG55cN1xF42E8PG+axYZWTY
         MAJI0o2sxgTSJh0pDG9yrtPZeilnEqRVA3qQGMGv0CKyX3Cnd4Zntx2W2UXqDCONjZM1
         VYiATO5zcFqk5OuHsfUj3oKU97ytXWb9J7N0fV+PSUEFzxOlTsh3jTartHQbC691TbxF
         hVGw==
X-Gm-Message-State: ACgBeo2+3upKiVBk26l1KFmfLyZGOOKutacvKGjIHx3S2cFW6+F1lfuE
        IlKF0W0TQIgVmt4RMXs/53OxJbknxg5yX07q
X-Google-Smtp-Source: AA6agR7GKnDBBB00N8fMol5XAklENQFxrBYZSCo5W0oGyfr30kbl8DeeSUM6j3bRGZk6QWRS4qzIqA==
X-Received: by 2002:a17:90b:4b0c:b0:1f4:ffac:699a with SMTP id lx12-20020a17090b4b0c00b001f4ffac699amr18068530pjb.145.1660983971008;
        Sat, 20 Aug 2022 01:26:11 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id y6-20020a655a06000000b0040ced958e8fsm3881512pgs.80.2022.08.20.01.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 01:26:10 -0700 (PDT)
From:   lily <floridsleeves@gmail.com>
To:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, cgzones@googlemail.com,
        michalorzel.eng@gmail.com, xiujianfeng@huawei.com,
        omosnace@redhat.com, lily <floridsleeves@gmail.com>
Subject: [PATCH v1] selinux/ss/services.c: check the return value of audit_log_start() in security_sid_mls_copy()
Date:   Sat, 20 Aug 2022 01:26:06 -0700
Message-Id: <20220820082606.953886-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function audit_log_start() can fail, so its return value should be
checked against NULL. 

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 security/selinux/ss/services.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index fe5fcf571c56..41d4c4ed93b7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3271,6 +3271,9 @@ int security_sid_mls_copy(struct selinux_state *state,
 				ab = audit_log_start(audit_context(),
 						     GFP_ATOMIC,
 						     AUDIT_SELINUX_ERR);
+				if (!ab)
+					goto out_unlock;
+
 				audit_log_format(ab,
 						 "op=security_sid_mls_copy invalid_context=");
 				/* don't record NUL with untrusted strings */
-- 
2.25.1

