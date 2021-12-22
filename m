Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34A947CED3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbhLVJHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbhLVJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:07:24 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6AAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:07:24 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y70so1976166iof.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82q23pf6F79CsGvvyr6VtDk1U+LrvvXzl1yTpgD2qXI=;
        b=NTGfEsaq/Z50NHpLlCHaPzI5WfxbxdMl0ct1kvlbHAL451PDYR5CLpPG8C/Yu0Q6XF
         4TY0pcnpLOSV2brWp2f6Cggcezl4B8gvYNu3WsNWH5CCd51YHXms+wssKTVPwQQt5ciJ
         Uf4YWJwSrCtAB3pD9SrIAWlBSkjz4C1hrP8834IJ6mBua1rks57alNLHh5oXRe9zdFMD
         r58CqFObroiFWZ6Dc9R/N0sSLaKdEAMHYvghxbhzntTnvkO3RClWSUdKvlqKoOdukxa0
         nJMcirQSpxl8vxc3LUTlRigA9UXuRMjVt3eXUwxxnRRIUSsF1IWVf7ylscxcBbZzCLCv
         vT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82q23pf6F79CsGvvyr6VtDk1U+LrvvXzl1yTpgD2qXI=;
        b=ruFUIXbFLUlZhxCVETdkZG8s89flQMiiAgB1QVof9RYfm4V0nBl73cPJsMQsjiEgmc
         K+moJJXvlqxNQbm2cfFb8pT1tLOiMrjleVCD7tRZQPcdoY3cXYSHMPWh6JF72zX4GPTa
         +kz7H5N0qP4ZYp6l2nEJbBsf3i7jaqIScyTFklRWKq9Cz7wqbXn14Aa52o6usYZP+1MB
         aWUnNvriHnvcNtFihtuANXIM1CmJgcLoon7NpqlkD7EuSrjxV+Jgxwdmm0NbBOjW2gdq
         9cBPuOefWhHhI0Z0ql1q8ShzTXm21xeNYrTV3MSxk6EM+JWmHzn1xTEGy8/NBSHphTaD
         Zdpw==
X-Gm-Message-State: AOAM530gRSr2QpL+Vgn6Im4+1qv+3W7piHdyOrgSg5+EX31zmOlObg45
        LjUo+YJg7mH7Jl0m2jJigL2LJCtJGMk=
X-Google-Smtp-Source: ABdhPJyFLxncjijnVuS5KNcjwTO+lXy9IW1Mver2NIeQoTrkbrAtkoVh5HBoMTrpUH0StirNzNuaEA==
X-Received: by 2002:a05:620a:430e:: with SMTP id u14mr1372729qko.286.1640164033021;
        Wed, 22 Dec 2021 01:07:13 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bk25sm1371223qkb.13.2021.12.22.01.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:07:12 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     arnd@arndb.de, benh@kernel.crashing.org, cgel.zte@gmail.com,
        deng.changcheng@zte.com.cn, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, paulus@samba.org, zealci@zte.com.cn
Subject: [PATCH v2] powerpc/cell/axon_msi: replace DEFINE_SIMPLE_ATTRIBUTE with  DEFINE_DEBUGFS_ATTRIBUTE
Date:   Wed, 22 Dec 2021 09:06:55 +0000
Message-Id: <20211222090655.484551-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87h7b1lcvt.fsf@mpe.ellerman.id.au>
References: <87h7b1lcvt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck warning:
./arch/powerpc/platforms/cell/axon_msi.c: 456: 0-23: WARNING: fops_msic
should be defined with DEFINE_DEBUGFS_ATTRIBUTE

DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
imposes some significant overhead as compared to
DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 arch/powerpc/platforms/cell/axon_msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 354a58c1e6f2..362c1efe4180 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -453,7 +453,7 @@ static int msic_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_msic, msic_get, msic_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_msic, msic_get, msic_set, "%llu\n");
 
 void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)
 {
@@ -474,6 +474,6 @@ void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)
 
 	snprintf(name, sizeof(name), "msic_%d", of_node_to_nid(dn));
 
-	debugfs_create_file(name, 0600, arch_debugfs_dir, msic, &fops_msic);
+	debugfs_create_file_unsafe(name, 0600, arch_debugfs_dir, msic, &fops_msic);
 }
 #endif /* DEBUG */
-- 
2.25.1

