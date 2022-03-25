Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6A34E6BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357272AbiCYB2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiCYB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:28:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4063B4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:26:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m18so1681218plx.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+SYc0e9g/e2NgojZUkZRw8h8BXGDytMNN9BdB9Ten6k=;
        b=NjIi4X6s6/CHpJcU1CyCBkQRKN0qkFkGVixQeqmG7EhFyEWBUN27xLTmKwKEJzuvGl
         fM8LrP+OOHyGj6c/hMm+Bol4ruFuVnzVHA1tl8aqjh6BRoV1iFpv5Oz8R4oPsTqCll31
         NIVZWzHJw/mpUkuU1UrDMUjKWG0k46H2SXUX+/waitn7Atz2jo0xyrsTY284zDXMZw3C
         Y4hzf5ivubQ0t30gvC+hQuEA0gxJjs5k6I0/EMkN8F8orJnBhZ0W3wtUdGWlx8D95Qkl
         /DOT1DcjP5eztz68VoAHjLrOVW9+VIoeXPjiXKslWvQedwQ0FeeWgsXOI+zvECqAbc2U
         1kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+SYc0e9g/e2NgojZUkZRw8h8BXGDytMNN9BdB9Ten6k=;
        b=iKoTBKkOqVNuDzw81EIhrINsTdKZsdddt7T+tcgGOB01nF6uscHjWddhGeIYXQUFXM
         XGlGsP1411RgbLUWfTqmjNg8ozMABghohXU+ZRIVIowcG4rhVDFwDZxFX9uX0oYm+ch1
         T49182yHsans3NEH75y2kucRCj9/bUVg0FbUaGAcUNkApOH7FYLRvoH4LAQy9C+RAgFi
         WhcsHLP7YlVTvWuVHelZCRUShesCamNNuSPLAZZhuJc5asXkDoUCwqVVSRVqlrocIcB+
         xtUfAMwgM0eFUTeFuuKb2hGrMUF0n/xd+Df0C4fiawGDqGHxuAv78ITOIRJ7Et87Zjqs
         o2gA==
X-Gm-Message-State: AOAM532CjurF4o92dKeI0NWWrNQ26OMBKLBouPMZodv7OI7tOeexCwfV
        xSDCoMrNxnK9WCmEhMvXC9Y=
X-Google-Smtp-Source: ABdhPJyhXR8P6O2wHa4huE6h/EFstjXQ3srSFIpO/zt19UkXT0kD1guGFuy6yn45l1y8SQNj3+pyrA==
X-Received: by 2002:a17:90b:4f8e:b0:1c7:3652:21bc with SMTP id qe14-20020a17090b4f8e00b001c7365221bcmr21835883pjb.38.1648171591987;
        Thu, 24 Mar 2022 18:26:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56a:d674:140:d261:4ff3:2835])
        by smtp.gmail.com with ESMTPSA id oj16-20020a17090b4d9000b001c709bca712sm11729204pjb.29.2022.03.24.18.26.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2022 18:26:31 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, lucas_tsai@richtek.com,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH 1/2] regulator: rt4831: Add bypass mask to fix set_bypass API work
Date:   Fri, 25 Mar 2022 09:26:16 +0800
Message-Id: <1648171577-9663-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648171577-9663-1-git-send-email-u0084500@gmail.com>
References: <1648171577-9663-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

To use set/get_bypass helper function, bypass mask need to be specified.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/rt4831-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/rt4831-regulator.c b/drivers/regulator/rt4831-regulator.c
index 676b041..8d24b5f 100644
--- a/drivers/regulator/rt4831-regulator.c
+++ b/drivers/regulator/rt4831-regulator.c
@@ -106,6 +106,7 @@ static const struct regulator_desc rt4831_regulator_descs[] = {
 		.vsel_reg = RT4831_REG_VLCM,
 		.vsel_mask = RT4831_VOLT_MASK,
 		.bypass_reg = RT4831_REG_DSVEN,
+		.bypass_mask = RT4831_DSVMODE_MASK,
 		.bypass_val_on = DSV_MODE_BYPASS,
 		.bypass_val_off = DSV_MODE_NORMAL,
 		.owner = THIS_MODULE,
-- 
2.7.4

