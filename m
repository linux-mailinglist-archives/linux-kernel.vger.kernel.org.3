Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62034ACDCB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345830AbiBHBMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344290AbiBHBAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:00:42 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0152BC0612A4;
        Mon,  7 Feb 2022 17:00:41 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cn6so11266121edb.5;
        Mon, 07 Feb 2022 17:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTGRbwlc2wTEYrwUQpON9SLosHIdDZCHpfCw94mlpzY=;
        b=WgMfcs+p3R5Y+RdipgsuX3NYA4JuPvS3OWO/Zqwk7yhvpsq06d0Bgf9S+8SizIysAN
         n3L42HeIJGL8wR01vQv49bl1yZ3Od5CWNVId6j+CKn57L70mCswqgU/0MWqk3IgH9zgU
         dJFMTfT0uWmnomAl5nlUTGMAaP/nvza/Cc33/XMqQe3sbADlbOHeRgk6Pp9iAg2SmwXJ
         vcOdCGwXcwVK+Nslb1IPRsJtKDcQUdOh90wQQGET1JU/7xZoYG286nc0NZEcuXJY4zx5
         j480bSR/QJufeZepIyfVGJAtnx02zcId4ZQSTqunPmELxqIu5f9DB/W9YBHrPPgNlcNI
         u0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTGRbwlc2wTEYrwUQpON9SLosHIdDZCHpfCw94mlpzY=;
        b=y+3HCnMoaOOy26wl3krJ6i06VBMIgEHXTahU8Mm3oJ3YIy46I/y7fl4PdjzwWJCHtA
         X5/iomIdjji3ezayLD1nUK51XWuHDQTuAXfeI6P/yZqqfU6Xs1W6pxpc91ZGiqCmZNkb
         eY1eTc56nVcKA86jXog8OBCZt/o2wuPYq2mYewApnyZPffB12Q7e9yyOap+03yZAs6p9
         xiCd9lkhL9hfpfoa71v1xhL4pWhzDJdHYg4ZABckB+7q7MMkIXgrcG6ya88mhrsFWVpm
         6MXLoEwN29vOKk5kp4t1LCJdLKwh/55zaGp+RMjMBPVkfj53NwZiqs+e1fPofLDlfRNy
         Vhvw==
X-Gm-Message-State: AOAM531ZT2U4AxXW0ufV51krDZ+Q5sqgmrwXcpCsWdU/h7DpjMweTaxp
        jkE5FuEIzdb/DvbZsVpRpv7ler6UDcm5gWWJAUY=
X-Google-Smtp-Source: ABdhPJy9W8AXR7U1Azwfja2RBr5nCZOBH6CzUaJwggVEZNIR5PiJ6S+5H1CdMXLGXidM290sUntvYg==
X-Received: by 2002:aa7:c917:: with SMTP id b23mr2083443edt.118.1644282040519;
        Mon, 07 Feb 2022 17:00:40 -0800 (PST)
Received: from localhost (92.40.202.227.threembb.co.uk. [92.40.202.227])
        by smtp.gmail.com with ESMTPSA id p19sm4197644ejc.42.2022.02.07.17.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 17:00:40 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: ingenic: Allow specifying common clock flags
Date:   Tue,  8 Feb 2022 01:00:46 +0000
Message-Id: <20220208010048.211691-2-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208010048.211691-1-aidanmacdonald.0x0@gmail.com>
References: <20220208010048.211691-1-aidanmacdonald.0x0@gmail.com>
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

Provide a flags field for clocks under the ingenic-cgu driver,
which can be used to set generic common clock framework flags
on the created clocks. For example, the CLK_IS_CRITICAL flag
is needed for some clocks (such as CPU or memory) to stop them
being automatically disabled.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/clk/ingenic/cgu.c | 2 +-
 drivers/clk/ingenic/cgu.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index af31633a8862..861c50d6cb24 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -660,7 +660,7 @@ static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
 	ingenic_clk->idx = idx;
 
 	clk_init.name = clk_info->name;
-	clk_init.flags = 0;
+	clk_init.flags = clk_info->flags;
 	clk_init.parent_names = parent_names;
 
 	caps = clk_info->type;
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index bfc2b9c38a41..147b7df0d657 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -136,6 +136,7 @@ struct ingenic_cgu_custom_info {
  * struct ingenic_cgu_clk_info - information about a clock
  * @name: name of the clock
  * @type: a bitmask formed from CGU_CLK_* values
+ * @flags: common clock flags to set on this clock
  * @parents: an array of the indices of potential parents of this clock
  *           within the clock_info array of the CGU, or -1 in entries
  *           which correspond to no valid parent
@@ -161,6 +162,8 @@ struct ingenic_cgu_clk_info {
 		CGU_CLK_CUSTOM		= BIT(7),
 	} type;
 
+	unsigned long flags;
+
 	int parents[4];
 
 	union {
-- 
2.34.1

