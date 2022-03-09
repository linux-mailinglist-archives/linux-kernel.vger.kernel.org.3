Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591344D2BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiCIJXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiCIJX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:23:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5820C2DF9;
        Wed,  9 Mar 2022 01:22:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m22so1838635pja.0;
        Wed, 09 Mar 2022 01:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kBC32u2ogQlH4HEXRWs9S+Rg6olRvmlFhO2KCjmnIcg=;
        b=RrtidET1m5TLgd0yHXsgj6NxmHQvuSQHbhT729edKluDynumIV4TuE7jEh84pismxv
         6UIh5/uY+u8MKLJSIDrunE0DxnowSTPj9T2GX+QQGMCGxbqVsw0uy1iu+8/qSSbFJ53D
         pbVkIFzCYXKo9eNC+XT5Z+9SHhQysu2bIhjD5JhwkoG9qkD+BOUieeiBD+e8k1WtWNW7
         DEUR6zqLpX6U1upYKNriDW5zCjoaU9g0tR5wSsHTLhRa87avElWzjE9PE/G8+mm2qI/Z
         cCoX61Wu3gZ0KXZB8lhMr19QPojuV2G/ppNlfD22dFv2x038V6ge35jkTEGEKWuSSFuo
         SNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kBC32u2ogQlH4HEXRWs9S+Rg6olRvmlFhO2KCjmnIcg=;
        b=FhtVhvxGGtHNgalgLZArm5TPiY3brghWeLKoAxqsTYz3zrvw2rYCGpULUIcMFwSJXj
         jGNfjNY6P6P45MjBNTBMuKbw2y2CoYpHXyQVk1lnAZhV6fNGv7IYcOxej5zpiStHs1wP
         82Gyjns5VYHjLZvrR/5UzQZu1UDuaY2S5nKkqfEPFS/g7v4GiQ4U7T5Repc/uTHMX2Wn
         EqqfnzJYpT0yAFzQcbJebv0n3VhO3l5e6x60RvJKdwl1wSHW8iOmzSSXHVIGKt56Fi8e
         8I68wTH/1AAfojZVXz3qKZj6bk4gdeRZk2FFaHDG0JItXpD0VQAXMf+WSSUDiTYWBTD/
         1dDg==
X-Gm-Message-State: AOAM5337XhXIAiKh5ZNY+N8x292WWazd1VU31fCdXYl6n3FdJdTq/PXX
        oECWIJ9beqIaANayd4MW3sNgxhjKfme8LV12bAN0Mg==
X-Google-Smtp-Source: ABdhPJyieel0AiUVEPltiT/fQejzCzNmgj7kH0pTVTYL/XXGSm7DXmoFDD3auujWgDGUtF2WD8QyfQ==
X-Received: by 2002:a17:90b:314:b0:1be:dc22:62f2 with SMTP id ay20-20020a17090b031400b001bedc2262f2mr9347868pjb.102.1646817750778;
        Wed, 09 Mar 2022 01:22:30 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id d4-20020aa78e44000000b004f6aaa184c9sm2003574pfr.71.2022.03.09.01.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:22:30 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] rtc: gamecube: Fix refcount leak in gamecube_rtc_read_offset_from_sram
Date:   Wed,  9 Mar 2022 09:22:25 +0000
Message-Id: <20220309092225.6930-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() function returns a node pointer with
refcount incremented, We should use of_node_put() on it when done
Add the missing of_node_put() to release the refcount.

Fixes: 86559400b3ef ("rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/rtc/rtc-gamecube.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index f717b36f4738..18ca3b38b2d0 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -235,6 +235,7 @@ static int gamecube_rtc_read_offset_from_sram(struct priv *d)
 	}
 
 	ret = of_address_to_resource(np, 0, &res);
+	of_node_put(np);
 	if (ret) {
 		pr_err("no io memory range found\n");
 		return -1;
-- 
2.17.1

