Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD65A2352
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiHZIli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbiHZIkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:40:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FED3ECC8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:40:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-336c3b72da5so15597007b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=1BCRKzVhOtBrKG/VR6oCKwA2rCN8yts14gxEEpWzTCs=;
        b=LpDUdywQAhULaMYLRcfvjEFdyqICCSbvUhMa1DwrNNBTXZ98htp1qCZwkXePp0+qCP
         fjWkp3GQpIlRivOEyhsVHLsN6eU/KWRz9XFPvbwOinyj0d3mfcx9j2h9IvBFz3Cax1dx
         D+6trm1GmP3wzvlvqtVNSb/Zh1UtxY9xcfwoJ5/Z5nUEZNPNZHtV2V/7VzGIvP8BVwSv
         wLi74SKWq17U0iEorxRpjRSmMMIAGSy47nHgvX2KCsjCfjZjhu9pFdF1ancQdj4wBoLR
         vKVy7pYQN320eHO3HAsMf1AEOpRSt++WrxHCnZDOsPV1hBoLjM5R1WBoNIHhyi+ndYRj
         nn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=1BCRKzVhOtBrKG/VR6oCKwA2rCN8yts14gxEEpWzTCs=;
        b=DoVcj496j7POW+y5rYHy4FXCgMJTnLZutJR/FlmlD0Pm9b/+K8jt/kZRLd8c9UI5e7
         2jseAruVNo/Qu2fwjLUSJAG7IBCLDM1ahlfdwDxvB2cgsmZOoRK+h/LdIhJM8LkUKQmB
         MIxoauIXwnGIiKAA3wZCKtYUjx5zBEB/chjodA8VJgHvBWFkulYfs9GK50Sh52FAL7Fq
         3BztClX1hoVu1I5/7LlcEd41tEtDYPtlMztx54Mp9JyHkTVO4fIlLGZbB+vK6n02J12V
         UjtQbi3KHu8sujt4ol2r66zNux5gaa1szpJIeyTapZa/oPPN6f0LGhqBDYNOztYXyJXd
         AjIQ==
X-Gm-Message-State: ACgBeo1t/+uJf0x6BIJCRLk6GUTTehF0mitD07lNGCmXFGSvlH4eFkp9
        pL9GjuFABzPKFpMFuaRw7TA2rv7ryPs=
X-Google-Smtp-Source: AA6agR6wjESRw5TzQK2Y6xr9dLNT27OzE76bMAt4poVX5d//5QWPL/VdEtum0Cvn2yNc0Zzee+GEEfFEqGs=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:9c82:622c:af33:39f2])
 (user=badhri job=sendgmr) by 2002:a0d:da83:0:b0:329:9c04:fe6d with SMTP id
 c125-20020a0dda83000000b003299c04fe6dmr7700379ywe.196.1661503212667; Fri, 26
 Aug 2022 01:40:12 -0700 (PDT)
Date:   Fri, 26 Aug 2022 01:40:00 -0700
In-Reply-To: <20220826084001.3341215-1-badhri@google.com>
Mime-Version: 1.0
References: <20220826084001.3341215-1-badhri@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826084001.3341215-3-badhri@google.com>
Subject: [PATCH v1 3/4] usb: typec: tcpci_maxim: Export helper function for
 register reads
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 4b6705f3d7b7..af3a7ecab23b 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -68,25 +68,29 @@ static struct max_tcpci_chip *tdata_to_max_tcpci(struct tcpci_data *tdata)
 	return container_of(tdata, struct max_tcpci_chip, data);
 }
 
-static int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
+inline int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
 {
 	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u16));
 }
+EXPORT_SYMBOL_GPL(max_tcpci_read16);
 
-static int max_tcpci_write16(struct max_tcpci_chip *chip, unsigned int reg, u16 val)
+inline int max_tcpci_write16(struct max_tcpci_chip *chip, unsigned int reg, u16 val)
 {
 	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u16));
 }
+EXPORT_SYMBOL_GPL(max_tcpci_write16);
 
-static int max_tcpci_read8(struct max_tcpci_chip *chip, unsigned int reg, u8 *val)
+inline int max_tcpci_read8(struct max_tcpci_chip *chip, unsigned int reg, u8 *val)
 {
 	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u8));
 }
+EXPORT_SYMBOL_GPL(max_tcpci_read8);
 
-static int max_tcpci_write8(struct max_tcpci_chip *chip, unsigned int reg, u8 val)
+inline int max_tcpci_write8(struct max_tcpci_chip *chip, unsigned int reg, u8 val)
 {
 	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u8));
 }
+EXPORT_SYMBOL_GPL(max_tcpci_write8);
 
 static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 {
-- 
2.37.2.672.g94769d06f0-goog

