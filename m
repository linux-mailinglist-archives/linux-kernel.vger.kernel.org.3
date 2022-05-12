Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9612152431F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbiELDNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiELDNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:13:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B9966AEF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:13:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d25so3599345pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awueREtst5v5/t4VnngT5Elxk/Ya6/NhiGCRe0UTBoU=;
        b=jlaXssIcZdJBL4nrI4f5qoQkSPk4evc9Z3ZMYSIkANTEEWHFqoqBucZzb7zTzg+Sbw
         Npn/t+qQ9orb9TrIYBvIW6ktC6gWC58UAil4GjM6ijq1wgyeLem+IcX5ZfhnK5Ord2Nm
         RBvpKlI2p3dv0w320/gr2JnRxEtM9uVgGKa/gZh+UBajM0DOWMN7GRZ5q1/yS/6a2oTO
         IuB3jhPTO9kwGErXEKCyNo77Zj6v2Rmg6IGyGb2nqOS/Kr0mCGNtsiriPHE5tVR8bzB1
         C0pdbMRtlFOM0jTX5cBL2lqvZXmVr4JrKrQP6NbxOi9VMkeid6aPSbQg0Ox+dOofqJHQ
         SZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awueREtst5v5/t4VnngT5Elxk/Ya6/NhiGCRe0UTBoU=;
        b=1QT2fNYowmsIQ2tTDV1PwaosQWt4f+BRqftJXJzg7rh+fnKl6oNULyaO/wNlYqkvqM
         aWB03QSzB4jRYFuAx8Zqg+qD6YNn9nqBFCqflYZjESBX2hVIfKKedPBji51rXQGtTlMi
         KUx7+Htd+q4POK8j8w77UKZRhjzvyejg37r2FAnKB1cfe6q4yYIhj1JkFDrXyEBXrzqB
         dmzZMRg+7jQGgXO8UIUppV7H/iBKkGY4LzXbe8y+VMN6f5ic3mEPMEc7bKQtXt59yeiY
         2mpdh771+MGNmJ8TIRJaQ3bD7qHx9v3n0pX9n1M2791WXeF5kgP2scG+/7wmnrlyQ45H
         VILw==
X-Gm-Message-State: AOAM533ZS+9YBhnejKL4iT6hrbggfd0QGZVKyD1sRVdXpJuWanqIex9D
        avPTKTYeI40d+76apydM7tQ=
X-Google-Smtp-Source: ABdhPJzVndRIBoKoHgahvtkJmW9JfoS1gBrPEX8MirlKdiUGx0ZJqb5z6p4F7ww7lgJcc6276Qmxbg==
X-Received: by 2002:a63:6b04:0:b0:3db:33c:497a with SMTP id g4-20020a636b04000000b003db033c497amr7812515pgc.346.1652325188602;
        Wed, 11 May 2022 20:13:08 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id m2-20020a170902db0200b0015e8d4eb2bbsm2623000plx.261.2022.05.11.20.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:13:08 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <rob.herring@calxeda.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: highbank: Fix refcount leak in highbank_init
Date:   Thu, 12 May 2022 07:12:58 +0400
Message-Id: <20220512031259.56459-1-linmq006@gmail.com>
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

Fixes: 220e6cf7b793 ("ARM: add Highbank core platform support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-highbank/highbank.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index db607955a7e4..af9488854fe3 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -142,6 +142,7 @@ static void __init highbank_init(void)
 	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
 	sregs_base = of_iomap(np, 0);
 	WARN_ON(!sregs_base);
+	of_node_put(np);
 
 	pm_power_off = highbank_power_off;
 	highbank_pm_init();
-- 
2.25.1

