Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E1652488A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351788AbiELJFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347424AbiELJFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:05:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650425C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:05:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so5684750pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=786wkcJ5s78jewmsUXyg4PXxshc2x0szKJgtpoGXHUo=;
        b=ithI42PXwNMmIlEz7dBqpzyzxm/cCqBccyhHhfDrZpmJfbs5eP1Yrl7cx/si/oy/nf
         VO35554++W2J8DM9xoydkmScEuAbQl6Jujm0Oh1oxvDSmqfKCJOevJs9aIgFHldebge5
         AZTqWaX2cRsCF0tvRwa/YPCjNLXS8BygaCQDtIXCfeETIr6wARUKvHCQcAgHvOPRy+Xd
         Yd5mUObhPjTloEsH4jiOec40AVnIa+gNWGffPMJQnsDoTf8l/bnrCOeZOWJ6s/C8quYS
         4vYH0705aDcBmJDVxU44GmrzqXjrJ1ufkzK7IIjjSpwZRq8r99669Ffg+e9/Z9Qcqrj0
         OeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=786wkcJ5s78jewmsUXyg4PXxshc2x0szKJgtpoGXHUo=;
        b=Nc3MeMHrDnn5hmuRmG7CVgxl82PWNFYbuKQ/Nrgy0UYJN6imVRyeuZ7n+ywPZFA0X/
         zVAWxwg4XV2xGqFzKCR2y2c3iEsEDczA2mqKZVoSiV/q5XofeVuJdDwUhdIT4+J4f+Be
         1OyXVduxRQXnnksnnotWYIymcn6arOjuGvtuFftcRAE725RNjsme2ux1STo0nQtDHKRG
         Vn+/XdVUrTop3qQim86K2mVbBJ/cEzzHZVI+AdQ9agyZ1csNlRTAxx8HDRme9Ly1e+Iv
         SRgnDM+GugrHSVoSdQZiX2nl98fMHYY3v2PD9uu1Y1bwC7hKiLgXdsO2J5clRnt/CboE
         kjvQ==
X-Gm-Message-State: AOAM530WFc9lIS5a1ni788g3X+2C545LZpVdlTMP+jg/yAcH3yv5V1ba
        apUbvJFpiEFrQQV4D07yGB+Xj34oX7iH25SzZzs=
X-Google-Smtp-Source: ABdhPJznixXxd7TIhMalrFNOxaTcW+XdgpSHp/MPzsYMGnqCKSxoAwMSaJ2c1J468jiw6zEI/ykZfA==
X-Received: by 2002:a17:90a:dc0c:b0:1da:125a:ec84 with SMTP id i12-20020a17090adc0c00b001da125aec84mr9772336pjv.137.1652346343680;
        Thu, 12 May 2022 02:05:43 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x13-20020a62fb0d000000b0050dc762813dsm3199054pfm.23.2022.05.12.02.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 02:05:43 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Nick Child <nick.child@ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ammar Faizi <ammarfaizi2@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/xive: Fix refcount leak in xive_spapr_init
Date:   Thu, 12 May 2022 13:05:33 +0400
Message-Id: <20220512090535.33397-1-linmq006@gmail.com>
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

of_find_compatible_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrupt controller")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/sysdev/xive/spapr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 29456c255f9f..503f544d28e2 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -830,12 +830,12 @@ bool __init xive_spapr_init(void)
 	/* Resource 1 is the OS ring TIMA */
 	if (of_address_to_resource(np, 1, &r)) {
 		pr_err("Failed to get thread mgmnt area resource\n");
-		return false;
+		goto err_put;
 	}
 	tima = ioremap(r.start, resource_size(&r));
 	if (!tima) {
 		pr_err("Failed to map thread mgmnt area\n");
-		return false;
+		goto err_put;
 	}
 
 	if (!xive_get_max_prio(&max_prio))
@@ -871,6 +871,7 @@ bool __init xive_spapr_init(void)
 	if (!xive_core_init(np, &xive_spapr_ops, tima, TM_QW1_OS, max_prio))
 		goto err_mem_free;
 
+	of_node_put(np);
 	pr_info("Using %dkB queues\n", 1 << (xive_queue_shift - 10));
 	return true;
 
@@ -878,6 +879,8 @@ bool __init xive_spapr_init(void)
 	xive_irq_bitmap_remove_all();
 err_unmap:
 	iounmap(tima);
+err_put:
+	of_node_put(np);
 	return false;
 }
 
-- 
2.25.1

