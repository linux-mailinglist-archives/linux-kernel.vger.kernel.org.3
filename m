Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB904CB179
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbiCBVjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiCBVjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:39:21 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF735DD2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:38:37 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so3556498ooi.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wAluUivNSRI0mrtPJNKUEXcouPOkO+X3IXT465oBrOw=;
        b=ACoMsJ2Mn/SOG3Ze7RxKSgj5WSgeDliONFFe/Zacv8MMyTD+5zX1YRwy8BT2NSTWOv
         vWrDxXwWKD16SLaDbAvoKwM+He8s8J930uuTlPJ5LIdaXe7Ne7x8jW4nv7tohThlKf4g
         ylsLgmIqgkoJ1LbJ6Gj1NS91PpCGn9pewcS1Rs1qkQf24pLPpcpq137W0ae3sBDu2FX0
         Vo4nbzalqW8o0gE2L94prKFRD61N2KwfgYKo2iiKPq7gky7ITNT3sHKESacetDMcSGgU
         vgLwyhSnDu3DLR0IHrBUehjE3hvpo2hRDZ4ZsiWi9H/ss86zr5FNvnaqQ9nXQkjF0cgw
         8Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wAluUivNSRI0mrtPJNKUEXcouPOkO+X3IXT465oBrOw=;
        b=LQHKq1tUQKFuMiuexcDZ8IG28xPBxTCCDg5kXoM9DbU/dAeJrIxngKK2gPAHK0L2Vl
         lstqWiDVYYtl21xLDZ4Z6DXjNArPJqaAeMFQjGgOuCnZzPSPW02uuPKsgHDUj25Ci6/p
         M0A5lue1nqal0tO+XkGcMKii3zI75lSSaBFLubTT1wK7UAHJbnYf0O/6pzmuwM6gTB/w
         nk831A6+omTMkoWLvbTKHBN4M4jFj46bRCDR5Unl+nEbcR1UyIfoBGJtRu3hMWOGqvwz
         /8yWYmmmlRvGG7Q5AhLsJShGC9rwBIMbZhNcKJQkwD+Sw1oiA05k4VUD2Fu0EvE1DmtO
         qI5w==
X-Gm-Message-State: AOAM531Yb5cyHxDNXRFjwhmH5ddMjjcvGaF7s77/qzqrtttgloDY+twe
        lx2y+jJnXhJ9rS4wahYYfwU=
X-Google-Smtp-Source: ABdhPJyXeYXONnVXkUqChLuC1mmm3Ye7mTwg0kIZZfs3SJeTlobZacBugYfKSzTmJSUI2rOxPJD0og==
X-Received: by 2002:a05:6870:54ce:b0:d6:efb6:5fe1 with SMTP id g14-20020a05687054ce00b000d6efb65fe1mr1577880oan.25.1646257117221;
        Wed, 02 Mar 2022 13:38:37 -0800 (PST)
Received: from localhost.localdomain ([181.23.87.56])
        by smtp.gmail.com with ESMTPSA id s12-20020a0568302a8c00b005b010d92dadsm69132otu.69.2022.03.02.13.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:38:36 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 2/2] staging: vchiq_arm: add prototype of function vchiq_platform_init()
Date:   Wed,  2 Mar 2022 18:36:38 -0300
Message-Id: <b74ac90e869f71a98a04b834c4f3b5ab37bb38ea.1646255044.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646255044.git.gascoar@gmail.com>
References: <cover.1646255044.git.gascoar@gmail.com>
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

Fix "no previous prototype" W=1 warning by adding the prototype of the
function vchiq_platform_init().

Note: vchiq_platform_init() is only called once in vchiq_probe(), so
presumably should be static function. However, making the function
static breaks the build.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 2aa46b119a46..d72edaf7e5e9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -122,6 +122,8 @@ vchiq_instance_get_trace(struct vchiq_instance *instance);
 extern void
 vchiq_instance_set_trace(struct vchiq_instance *instance, int trace);
 
+int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state);
+
 #if IS_ENABLED(CONFIG_VCHIQ_CDEV)
 
 extern void
-- 
2.35.1

