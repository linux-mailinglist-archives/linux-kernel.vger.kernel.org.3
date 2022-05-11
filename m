Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211BC523240
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiEKL5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiEKL5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:57:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E2C3CA52
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:57:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s14so1648080plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JuyEEIl+kSH13w3QvsAw78KVrS/aC3OrU8hhY1kBTo8=;
        b=mvV5OR1yn5Gd6XqCzeeWK167aziIFzwu/d7rlxB2BSIfVeOJtsdEvnf0mvw0CZhiZN
         41c3/2PgCfY2XcNIDKpFVPiVB11aspc0gRhdL1JajWoNtC6tpSc/rcOji/Tnq/wFshxi
         /zbc+4zP03jGYSKEp3ItxgFjP6zWTfQhumA0RNN8LUVE5e5i4lqli3aBHMvgg7VQ319m
         x5MTmrJn6L+x9Oda37K//fPtLHwLuVft9/NGfEDlh94wywTNPBEPQz8eJI6Yk36GR2xv
         Myr2oS4wTvmItowq9/Qo4gzB+ZgHJRi1hyjgWgvolDR8REzfknzyNnNoDRnhYNqPHqTA
         GEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JuyEEIl+kSH13w3QvsAw78KVrS/aC3OrU8hhY1kBTo8=;
        b=iri4VLnydnOIa6/Iw0+EJ3dKVUOrui9x5dK5eurPSec2YZHuIcWzeEG+L7zCnI1F03
         X5Y8pRUeVkXzmgvroT0GlcIwVz99S4HHomTewiAgIRTpLJWpuCZ9u5riZIc/EuKhvkEC
         cq05Lp3XemJdHJGsu+Bz6sn51wFPr5t+MSgPtFiRsraP0MjbDe84hNZBXCWK8Bf60kxr
         lQ7EIKSlKS13Qbjm81dDuBIymVVhewLpVo4mDVadQ51QiXFmL6svWdstdaNHoprlmwVp
         XNBJoDViYwzmXVd0H0fpfTVwwrr5SFOLpKeqRoH+mmAQplrCS1YY/x+pN5ufEBhA3Q2C
         iuUg==
X-Gm-Message-State: AOAM532weuuCKdI7sVIAjHOZaXTyTcrIzn8NgvH/ZvBXSi76NhxhU26O
        4SSnQi1JBZfJDarJBtVFJXMt583PzH0GFkNxOfw=
X-Google-Smtp-Source: ABdhPJyQQn3g4evuu1+8KTA+W2K0DNrLUnQqVlb/1fyPhJoqj4ZTGS7rEz/IPNl/xwvoutB9+kCf8A==
X-Received: by 2002:a17:90a:e7cb:b0:1dc:6602:7178 with SMTP id kb11-20020a17090ae7cb00b001dc66027178mr4990519pjb.175.1652270267254;
        Wed, 11 May 2022 04:57:47 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id v3-20020a62a503000000b0050dc7628179sm1533854pfm.83.2022.05.11.04.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:57:46 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] fsi: master-ast-cf: Fix refcount leak in fsi_master_acf_probe
Date:   Wed, 11 May 2022 15:57:39 +0400
Message-Id: <20220511115739.52836-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.

Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/fsi/fsi-master-ast-cf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 24292acdbaf8..3e6cacdc1bfe 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1326,10 +1326,12 @@ static int fsi_master_acf_probe(struct platform_device *pdev)
 		if (IS_ERR(master->cvic)) {
 			rc = PTR_ERR(master->cvic);
 			dev_err(&pdev->dev, "Error %d mapping CVIC\n", rc);
+			of_node_put(np);
 			goto err_free;
 		}
 		rc = of_property_read_u32(np, "copro-sw-interrupts",
 					  &master->cvic_sw_irq);
+		of_node_put(np);
 		if (rc) {
 			dev_err(&pdev->dev, "Can't find coprocessor SW interrupt\n");
 			goto err_free;
-- 
2.25.1

