Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6925542DD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349822AbiFVGUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351231AbiFVGUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:20:07 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6672F038
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:20:06 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l81so19930556oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfXx6OUKFv9lmYSVpe2VK14vOIkFTYrGx9cnZE6j00U=;
        b=AGQIifcv8IatjKKtZ3ZMuhDS9M2f66qXt8yHD288muU7dZJUf4BOrGbRfAVqyk6YyC
         8uazsNnQH0aC28zkPMZbidyAmunqgVSvMPOto1S5wE3cT1CofMcjgTgVmu16iwG4Ugoe
         P9wTJgqUdkWoGzQko+bztqQr+kX5pXm0PN1q6m4gZTUjsDy4Zl3wXQ+0vg8zHXlgUlJw
         z7BMgQmgmYsHqHt4y0VlSPnVrG6pvRd9aSdiDpcIrCulCEXp9xCTPbpU2ABPb19PQ0wG
         3oHeSQM4Q2mOr5xbEb3pa8ah/n/CvUWwt9RF1AUIy5nO0r4CVuvezhj/Sj0YfnrROHW/
         4yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfXx6OUKFv9lmYSVpe2VK14vOIkFTYrGx9cnZE6j00U=;
        b=N1QIgdPirMpedGfI1gqwZD1KQHzqiBQz3E2ZsTgxNA2c6bv1sJzNN8uIv2axcYaemw
         qxET/frFo/8fsc33W+Fk7nZX1pjsuLdHiVDbJSnFEAEj5ENCyUqRdRnat8VgSe85Lffr
         4AK8CuFnfBZGnWXydhDbg8ldIvZ9MwLRNeA2/SV7AZ8rrmIb1QHgbn/fe+juDnQMP8VR
         aKPC9MliVM/+vRMVrRju/xdo/J0DnoBZRQxpz/5Q1rHHmhGU0S+ZUS9fgw5LdWoaK/u6
         ebmV2Vp7mqgKut2VBpTG/OlMCDEdAd2XMc3BEVWNBcniuDEZ3q5e/8GR7ZbG010+e2i9
         kfTw==
X-Gm-Message-State: AOAM532sNYA/fMJAk4TajzIaVtnPBimVkDgWS+GAdmQSdyOsYGWjAwS8
        bChVhaC60Arvy0Md02QdKBw=
X-Google-Smtp-Source: ABdhPJzCjeLA9cCnRN3/icCZ/qlUASsHUXDJZLuDcSQ8MxM5IWVv6OwxilT7vDLmaYrC42SPOZInRA==
X-Received: by 2002:aca:b305:0:b0:32f:17cb:63c0 with SMTP id c5-20020acab305000000b0032f17cb63c0mr19988245oif.142.1655878805547;
        Tue, 21 Jun 2022 23:20:05 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id n5-20020a4ab345000000b0035eb4e5a6d6sm10961544ooo.44.2022.06.21.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:20:05 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 3/4] memblock tests: set memblock_debug to enable memblock_dbg() messages
Date:   Wed, 22 Jun 2022 01:19:31 -0500
Message-Id: <fe34452209f54287023ccacd666eade81ecd9a24.1655878337.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655878337.git.remckee0@gmail.com>
References: <cover.1655878337.git.remckee0@gmail.com>
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

If Memblock simulator was compiled with MEMBLOCK_DEBUG=1, set
memblock_debug to 1 so that memblock_dbg() will print debug information
when memblock functions are tested in Memblock simulator.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/internal.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index 94b52a8718b5..c2a492c05e0c 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -2,6 +2,13 @@
 #ifndef _MM_INTERNAL_H
 #define _MM_INTERNAL_H
 
+/*
+ * Enable memblock_dbg() messages
+ */
+#ifdef MEMBLOCK_DEBUG
+static int memblock_debug = 1;
+#endif
+
 struct page {};
 
 void memblock_free_pages(struct page *page, unsigned long pfn,
-- 
2.34.1

