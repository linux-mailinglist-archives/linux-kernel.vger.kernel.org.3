Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13D6532409
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiEXH1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbiEXH1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:27:06 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB332EF1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:27:03 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F315D3F1EB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653377221;
        bh=0rT4bj4pR8OO9Q6o/yjLqXZgacVnXSfmsD8U6qzZ7qY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DXSENph0bPVElsCdge+Nbj9BwKJtFJPIIPWzckwKiQSEUrnuSdUxrieoqfxvZg2BN
         MsR65Uz4y/u1hDpvQD4b6+W9NPJFu84LCNs3hk2NbtwxwP+lM08Mk+e1ZNdf29rr3l
         2dlo9nPtTGlKU54Pfbfs4tB2ZKK7RMfRrXek052acvbREwXs17N6okwtSq3Qk+SS71
         3cLwnIBQlpzDrJwz0D7sYOpnkHW8Q3lderKbeQSvgdqGNkG90pHPBbKnjn3Nhazmm6
         QyTE1vqXz7VDeDgeXs8tifyhPNPLaoePYToLQwG927DW1U2A0k0pOcOZcBEIMXiOuU
         JngSSk2mu7nDg==
Received: by mail-ed1-f71.google.com with SMTP id q12-20020a056402040c00b0042a84f9939dso12193737edv.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0rT4bj4pR8OO9Q6o/yjLqXZgacVnXSfmsD8U6qzZ7qY=;
        b=6c3EeyitT21TrZcGCiLDT56AhIVlxRTyDEKQCb+jnxwUDaBeQxOqg+yK5I3y9pdDzD
         QLGQFG9ooyLCbOFTX81z+NJr5zpwtZ3pWZAeTMmXTBMiO5Sol23+8QG1Zc+Mgt6Axh7B
         PW+wPzEpf1LoO305W5ZDipi1YeKg2uOhSQCPiGuIufFMdVVp2QYshBkOK1bd4+6b6YH+
         TzYFmzvt6M3AbjdhSnnhzdpb+GDDYZQLOvrhubnbUAs6zmi/dLAhe4W/PDiki4x0hSGv
         6z+naIktVHNbUcVjomdLAvkgR/CM5g5yUZX8o/7/hECf96QbmUHisSm+uAKKSSvvnj76
         CNZQ==
X-Gm-Message-State: AOAM530EZ6f63Pof+1HohcaywsYPScd1L72VY9j8XVxtr/Ji/BJL4eRW
        IOODMzJTyahCbCISDGlJvI2bs9eOMIGHDO0DOTKtsK3PbQmEHeE45v9MWnvPGb/YitEWpNvMhOU
        CTJHjGSED/T8JxZyoxUu4G9ZPnud/3aWRnzWbzqHI7Q==
X-Received: by 2002:a17:907:97c9:b0:6fe:bcb1:661d with SMTP id js9-20020a17090797c900b006febcb1661dmr12937547ejc.269.1653377221734;
        Tue, 24 May 2022 00:27:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwg7bLKBJNYM07T/gQbJ4eNVo0EoDmbJCsrFAdy5B7rq+aqBrbvTgbtQnj2FE8gxRVGQr0lOA==
X-Received: by 2002:a17:907:97c9:b0:6fe:bcb1:661d with SMTP id js9-20020a17090797c900b006febcb1661dmr12937534ejc.269.1653377221456;
        Tue, 24 May 2022 00:27:01 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b006f3ef214dd2sm6924353ejw.56.2022.05.24.00.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:27:01 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     ysato@users.sourceforge.jp, uclinux-h8-devel@lists.sourceforge.jp
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 2/2] h8300: Kconfig.cpu: Fix indentation
Date:   Tue, 24 May 2022 09:26:56 +0200
Message-Id: <20220524072656.20152-3-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220524072656.20152-1-juergh@canonical.com>
References: <20220524072656.20152-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/h8300/Kconfig.cpu | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/h8300/Kconfig.cpu b/arch/h8300/Kconfig.cpu
index c30baa0499fc..172e8be0f0c3 100644
--- a/arch/h8300/Kconfig.cpu
+++ b/arch/h8300/Kconfig.cpu
@@ -26,7 +26,7 @@ config ROMKERNEL
 menu "Processor type and features"
 
 choice
-prompt "H8/300 platform"
+	prompt "H8/300 platform"
 
 config H8300_AE3068
 	bool "AE-3068/69"
@@ -89,11 +89,11 @@ config H8S_SIM
 endchoice
 
 config H8300_BUILTIN_DTB
-        string "Builtin DTB"
+	string "Builtin DTB"
 	default ""
 
 config OFFSET
-        hex "Load offset"
+	hex "Load offset"
 	default 0
 
 endmenu
-- 
2.32.0

