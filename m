Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD624B1A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346351AbiBKAbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:31:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbiBKAbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:31:19 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE3A559A;
        Thu, 10 Feb 2022 16:31:19 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n17so9561351iod.4;
        Thu, 10 Feb 2022 16:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WY+F15RwKoXSBs81n7QT8FqeoZ2/vRqemIDQ19p9hAY=;
        b=UhDGPTTGkCv7nd2i/RxSPH4PnVPZlxYLGSFCnJ4+jnU1zbj0n8l7wVAyCdZZNe4xg1
         RVezAL9rFr1cDpujwWZ19coQQzwOQ8jqEuPUM3RTAzcJoTLbeUwPZxQnnTk2s9EjgDdM
         bqVuyPRCfRizMtazcb6ZHcm0of8H+1Zpq3KZTY7y9b1Vd/FvIUupHM5PwEvYk6iZsPa0
         a48amFL3lBebCekA448n7zpKvMPr2J4GBSKGH1TkLOozoIK4f04NbEsPJFzZsffvrz5n
         jMJwjmBLyd8kN79M7JlB19hF4boCL26IuZBs/TGBiu1lOedGjl0eKRMxhP7Dz44nOEaU
         hgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WY+F15RwKoXSBs81n7QT8FqeoZ2/vRqemIDQ19p9hAY=;
        b=7VjKq2vZENiURrW8qW0FOxjZavzg9aYsvFJg2Utla7K0OYpKwOb2HYpbM1XUbmGsSA
         vZcDtBgeuL/d5SF/2PxrJ68rcXwUafmwPh9F+NJNtmH3hT79mw3PVqJtt8kEsACY1hvO
         V3+tn4wswC+dRxXtxQdwIR8Wt2kZCEwHMTO9+qsigXnW724aZdcdSiuz5ShqEXkJBs0I
         y1YU40zrG+wOK0wh1Jsn93LOb90hN8d5DWBLTqny+qAbRilUJsj0S4Qs4iEflHE+DWsi
         lECQ+isgmgESsjeCi5oQCOILGtPkaLyHXyyNWhh3W5iKxvI8k3v5iSbWkM1trZYFe7uo
         07RA==
X-Gm-Message-State: AOAM533aB6ECqKOCq1/+rXkkjGRQqrG/raeFRKiKg8sqnxMDoKnXjfYS
        t5Gr5DWTVicDwAaFjufSXbM=
X-Google-Smtp-Source: ABdhPJyJf8DICiugARTyGxQTO41WkKOMQOz8THqG4YLlZKUdSd+jbMzkeB9uqKFDGytPzQQRKnntPQ==
X-Received: by 2002:a05:6602:26ce:: with SMTP id g14mr5175279ioo.137.1644539478920;
        Thu, 10 Feb 2022 16:31:18 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id w19sm13031570iov.16.2022.02.10.16.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:31:18 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 45/49] ACPI: replace nodes__weight with nodes_weight_ge for numa
Date:   Thu, 10 Feb 2022 14:49:29 -0800
Message-Id: <20220210224933.379149-46-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

acpi_map_pxm_to_node() calls nodes_weight() to compare the weight
of nodemask with a given number. We can do it more efficiently with
nodes_weight_eq() because conditional nodes_weight may stop
traversing the nodemask earlier, as soon as condition is (or is not)
met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 3b818ab186be..fe7a7996f553 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -67,7 +67,7 @@ int acpi_map_pxm_to_node(int pxm)
 	node = pxm_to_node_map[pxm];
 
 	if (node == NUMA_NO_NODE) {
-		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
+		if (nodes_weight_ge(nodes_found_map, MAX_NUMNODES))
 			return NUMA_NO_NODE;
 		node = first_unset_node(nodes_found_map);
 		__acpi_map_pxm_to_node(pxm, node);
-- 
2.32.0

