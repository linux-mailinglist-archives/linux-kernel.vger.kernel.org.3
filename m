Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4484F2ACB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiDEJEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 05:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbiDEISC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:18:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04172B6D1E;
        Tue,  5 Apr 2022 01:06:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso1860398pjh.3;
        Tue, 05 Apr 2022 01:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ePtpQVr2/xAxWdpNXmu4SCKmYKeBJUhhz3S5bqyfLKU=;
        b=gKdeP7q22sW9hJCH0aUS243AOByxsp3wI5iwnh3TVk74XN8M+9MjRyPbsAVg9Nq5l4
         HonIND9/T2b2KZfvWfSqxxWBjlTXafG3ZhAbraokr3ycCd7Bya5/KiTzNWfGlPTut4sg
         6ilYF1x8mFQoM3mqab8tK/alOHLLJBsyBAJXZBZ7RN1fmYhzMMvyY0zl3SEConL8z7lY
         3SMGYih6KH9Fud4dzthL0/AbxMFEfCszxaesBq1H8+SrJQT8qNJAHgDUZ3V1krehKRrd
         sLM5NLwSnpjPiN3Jlm/AA1MhTcYYk9vZZXrCpDlBbsORuZJa1joeOEXGsBaiIKd+DDwi
         Q0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ePtpQVr2/xAxWdpNXmu4SCKmYKeBJUhhz3S5bqyfLKU=;
        b=XZPNCl8QTZCCUK0tET4ZxJVwQyRE/RlqvDwxqjfXnsWUvvVbaj2U5i4Kneagyn9A4b
         24JHx2ZyL3WIuU6oF3uVFqAofZzdng5RSUBnlucXCA14z3vitOVrLIiU3zCoXOrpZg69
         FwknYQtrSijc2Ihczda/B+qhUXLaIBXWmC5UgyPrI8T3k1717EXD5/NIy38n3wgm95cK
         U8tzWDWKOQnhhqwMUcdK4+qp1I8lmd6EYVlW9gPjqzkuk2siDET226hMNNwIitSGogKN
         h2zyO3elXM/O2khRQziRPnumDo714Pj2aGE4+nmrtT2LWCL58a3yjOf/ZLkIzugb7qwe
         q2DA==
X-Gm-Message-State: AOAM533faAQNZJT/qfh+1y+jLxfVc0OhbTUg90T0dCEBa1ptNTqSUU2+
        WmbzJOPpJ7MtMnjqEIoONJvMYakESSYCzQ==
X-Google-Smtp-Source: ABdhPJwoZ4KOfl0YZ3POEkbstpClrBjXowN6NpOPSayJLzlwi3EbD0f6AqVksyI3H8TsyBOJGM+AkQ==
X-Received: by 2002:a17:90b:1bc6:b0:1c7:f32:3aa0 with SMTP id oa6-20020a17090b1bc600b001c70f323aa0mr2764807pjb.168.1649145979009;
        Tue, 05 Apr 2022 01:06:19 -0700 (PDT)
Received: from localhost.localdomain ([183.156.181.188])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b004f140515d56sm14961910pfh.46.2022.04.05.01.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 01:06:18 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     jassisinghbrar@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [RESEND][PATCH] mailbox: remove an unneeded NULL check on list iterator
Date:   Tue,  5 Apr 2022 16:05:56 +0800
Message-Id: <20220405080556.26103-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list iterator is always non-NULL so it doesn't need to be checked.
Thus just remove the unnecessary NULL check.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/mailbox/tegra-hsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index acd0675da681..64eaee089b03 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -799,7 +799,7 @@ static int __maybe_unused tegra_hsp_resume(struct device *dev)
 	struct tegra_hsp_doorbell *db;
 
 	list_for_each_entry(db, &hsp->doorbells, list) {
-		if (db && db->channel.chan)
+		if (db->channel.chan)
 			tegra_hsp_doorbell_startup(db->channel.chan);
 	}
 
-- 
2.17.1

