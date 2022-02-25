Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD84C463F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbiBYN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241277AbiBYN0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:26:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF36202884
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:26:03 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s1so4492252wrg.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZTTitvMl4BhW9A406lvoE4Fj/c8t6In61IqL8slqVUI=;
        b=cwsN/opUX70fDXqxn/6Laujnma4EXoJ0hD2mQ18nGf2L9eFO4CYH5fSLNunZ44SIb3
         ID72YMQiANtYmihD3+gcPdlgc0kpfAhs5vOOO76ebu1RUUtg16sFE7qKo2GSrQeqSWJV
         SvdsefGOfnyIKIBZaNJ3jrYdrAgX5pxdJREN4KNua7VAdaWu9wAq+T6eDTWm7Kr0sWuN
         uBykLT5EiBoOqcmZE5FNl77g658kLZDjGC1pCCbIOy17myboKRAeVJ8dCMRkxX49ayEa
         YODuSAFjRVqvS5urJDjObiYR9wYUl2ieBrAb2oeFkZoZCUynnjtADhQoy75yBw2xMF6+
         hmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZTTitvMl4BhW9A406lvoE4Fj/c8t6In61IqL8slqVUI=;
        b=63KmZrglHuGw20+CwAitb9UEgyvPHN/q/6YYGnMuJGbK2Y/s9z50gEbHlvvXYsWVpY
         xfmCnM5NMzpOEe8uQtMiszTOc70oNAzdsnhWEeKnlnfZu1NK289HrlYxVKkmIU75x2L6
         GTPLuNqu/fTfE5iNrNiGd+72Gylu50zlvTXkNFT/A8ALoLBC3Y5dRt1IZ1taoJfj4erW
         FRwrYxs8ZUlCgGwZuUSUheCMW8c+/fWaTSwrkHDIvVjgd83imj+ukoE2qw/x+NF3EM0z
         T9lLIHI0DM99GzyiIfCRUWkWWMqvNeQG7WpIaUdFzg0//3KGelqMvc0zPWiiqgphrnVU
         gzpA==
X-Gm-Message-State: AOAM531gExwYv8Ryml6bvH2APJjQdp0yHkI0Y7bU8dgmUycsDf360hWD
        3IJH3Xi4CX4CKoCILL0nSHg=
X-Google-Smtp-Source: ABdhPJx3BPtmvEsMtLUXYT54o/4bEHONyVJtzfnEQILOldLSiWb/B/FodVms7+qwOnEPi8GYXaFPxQ==
X-Received: by 2002:adf:a389:0:b0:1ea:95ea:58dc with SMTP id l9-20020adfa389000000b001ea95ea58dcmr6335496wrb.659.1645795561873;
        Fri, 25 Feb 2022 05:26:01 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.58])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm2755634wmp.44.2022.02.25.05.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:26:01 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     ssantosh@kernel.org, krzysztof.kozlowski@canonical.com
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] memory: emif: check the pointer temp in get_device_details()
Date:   Fri, 25 Feb 2022 05:25:52 -0800
Message-Id: <20220225132552.27894-1-baijiaju1990@gmail.com>
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

The pointer temp is allocated by devm_kzalloc(), so it should be
checked for error handling.

Fixes: 7ec944538dde ("memory: emif: add basic infrastructure for EMIF driver")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/memory/emif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 762d0c0f0716..93a79346a11e 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1025,7 +1025,7 @@ static struct emif_data *__init_or_module get_device_details(
 	temp	= devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 	dev_info = devm_kzalloc(dev, sizeof(*dev_info), GFP_KERNEL);
 
-	if (!emif || !pd || !dev_info) {
+	if (!emif || !temp || !dev_info) {
 		dev_err(dev, "%s:%d: allocation error\n", __func__, __LINE__);
 		goto error;
 	}
-- 
2.17.1

