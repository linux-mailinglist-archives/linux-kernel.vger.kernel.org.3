Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5105C599506
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346532AbiHSGJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346551AbiHSGIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37C5766D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e13so4416674edj.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=G8Fa6mUqYf/+9pmayD/JU97JJ5c1rtwFfoeWsGQuVn0=;
        b=Wa2YE/4iuBwhCxA/2sLMGxafjNWNp8R5Y5GvUjuw9r41tK8Wcx/EKw+2H+1/Veywgc
         LJQ+v73iCinphAmOCiTHHaEKqV/BmvDch1rJUfPEwxvwKNwdrPi+huIrtM6hsfPxL7Xy
         G4M4VWQQtWxc4APJhsQYsWSK8VbHm9A8N6uK9gEIJWWGfMFQTt29abAUXGvjYldp/mVM
         94gjFIMTn7ap2pgpIGqnx52ill0+26zTXJXgcU/wShPvvVBMOYCaaF+IznVZ8dp9H0mm
         o8C017Lq9lLvphIDql/BSULFsWxxtUVWCEcpxQD5tJ7WGxyFvAzt7it8+bgrQSrODYgd
         RbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=G8Fa6mUqYf/+9pmayD/JU97JJ5c1rtwFfoeWsGQuVn0=;
        b=USYaU2QqYob4a2JV1XwrkVGz2ZgIpidLaio9Zs2MeOACMlk1RrPdRhg2zQsnFgf+WE
         bEj5xc2zh95AGZnm5rt2lUKQ4b1lEqlM5BxvjPzJem9b3wbth/os88s72ZqvB3MsD6iN
         XrGOrVsMZahyLOOXfLWirDOODOrzSS7fCSJR2oB8pGYo6TtqeCizpnMiHphSVCXtvZZ1
         MBoHB7WgBwKhjI4LS4gkq6v0A6wVWOVEHU96ubz0pKH4zXmGxPKLwibFLs14EQ5SCAQg
         aHu/QviV8PgW2W5w+JZcxuwqQ5uAGgFdc6LHUu4IrkRvisWP0TOauBFK3PIqc1J48J1a
         VT7A==
X-Gm-Message-State: ACgBeo17hgH0i4mFNrQQmcscfLoXI4n43xSG4TU0gRpE0mvjLVaFcO7c
        IYy5L6zzxGM70+bUwopJzctbpZ0lousSZ12c
X-Google-Smtp-Source: AA6agR6BA7zdNhkAb4nZuW4FclGhlWv4j7pNqcDrjThensw54HFO+0JNP9+6BQjpOTtkHWznXs4rkA==
X-Received: by 2002:a05:6402:d57:b0:445:fba7:422d with SMTP id ec23-20020a0564020d5700b00445fba7422dmr4929146edb.138.1660889303801;
        Thu, 18 Aug 2022 23:08:23 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:23 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 13/19] intel_th: Fix dma_map_sg error check
Date:   Fri, 19 Aug 2022 08:07:55 +0200
Message-Id: <20220819060801.10443-14-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/hwtracing/intel_th/msu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 6c8215a47a60..b49237d56a60 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -931,7 +931,7 @@ static int msc_buffer_contig_alloc(struct msc *msc, unsigned long size)
 
 	ret = dma_map_sg(msc_dev(msc)->parent->parent, msc->single_sgt.sgl, 1,
 			 DMA_FROM_DEVICE);
-	if (ret < 0)
+	if (!ret)
 		goto err_free_pages;
 
 	msc->nr_pages = nr_pages;
-- 
2.34.1

