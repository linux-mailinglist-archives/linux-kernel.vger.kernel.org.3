Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88984ED1C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiCaCiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiCaCiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:38:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7672590FC5;
        Wed, 30 Mar 2022 19:36:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w8so22173589pll.10;
        Wed, 30 Mar 2022 19:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IJdXXyb/GkLLA9e58AhYrCbqtG5A+hvlprgfy9C7ST0=;
        b=Kr512raOP2MXtPHF/h/yqp8TJjhFf5c1TsfQH29QQ9/7x0j1Un0PZjLZoTKuz5KpJO
         JRbX6xlw8bAVoALIcwaozRvxQv7KDmk1S7AiNBBk7ZaMoKAs1c0SuYGuteWTmDEIvcts
         MBPm1oZ1jJ6WB5bycbnEYbVVqd3gmtfujU+adRSkAKlDqZdVsI3+vMC7blsTa64n9x5r
         d849LUGNZmwr7Hep1h630ULQiGIbe4AnkPd4/QQBQVBiKueMC7MHQ/97+Efx5zdD5CEO
         UTHlCY957krtpQMg/7bVvziGQcr3Ww9slu53oZAECan+oDHv8zhMBl3R8zd8sZ6FKoK2
         mfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IJdXXyb/GkLLA9e58AhYrCbqtG5A+hvlprgfy9C7ST0=;
        b=5ep0eznsIDAA4mDYNHpxtcBmljxX2KRLMVyad+NccXnr9pYTCMssG/moqd58Srl+b/
         WRsqzuonSC0MpGHxSSfuB6s7Y+hwXBnrrNQuNIFSm23ZPLN4FFFgCQ5D4okiilJcye3v
         bMzu9XKDcQHFcQXOKbNEkOWdwqLpgjy74O3FhGSMFecwbdmDG+64ckNCbneEsvf47Brq
         dGvQa8Tm4TrNe4P22nI8GlEAkO1qkbqELmLQTQxt94ydW3U6pP7rqjln980m3gJrrEAZ
         XYu5v2A/CXQmvMo6XqI1uofKPBCEqb8eu7eN3UDuACFsif/cZdSTZi2fzHO8PXXTbtmY
         Nc9w==
X-Gm-Message-State: AOAM530+eussr++4dgPsu8CZwe0makgBtq3BIXL60BJ+1NwvPL9KMVuQ
        oWshBfZ9ccfja/tqVvKzJhQ=
X-Google-Smtp-Source: ABdhPJwnHK2+B/0xSy67qJM4F2VvfxGA/X2CHseqxeIaVfp1Zxdi1mah3QAzI0HzXPF2oCwn2TxRug==
X-Received: by 2002:a17:90b:4f41:b0:1c7:928d:196e with SMTP id pj1-20020a17090b4f4100b001c7928d196emr3429778pjb.47.1648694175872;
        Wed, 30 Mar 2022 19:36:15 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id bx22-20020a056a00429600b004fa936a64b0sm23569807pfb.196.2022.03.30.19.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:36:15 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v2] opp: use list iterator only inside the loop
Date:   Thu, 31 Mar 2022 10:36:08 +0800
Message-Id: <20220331023608.30497-1-xiam0nd.tong@gmail.com>
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

The list iterator 'new_dev' will point to a bogus position containing
HEAD if any one of these conditions is possible: the list is empty or
no element is found, thus can potentially lead to an invalid memory
access in 'dev = new_dev->dev;'.

As discussed before, we should avoid to use a list iterator variable
outside the loop which is considered harmful[1].

In this case, use a new variable 'iter' as the list iterator, while
use the old variable 'new_dev' as a dedicated pointer to point to the
found entry. And BUG_ON(!new_dev);.

[1]:  https://lkml.org/lkml/2022/2/17/1032

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---

changes since v1:
 - use BUG_ON(!new_dev); instead of return; (Viresh Kumar)

v1: https://lore.kernel.org/lkml/20220331015818.28045-1-xiam0nd.tong@gmail.com/

---
 drivers/opp/debugfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 596c185b5dda..81b2bc4b5f43 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -187,14 +187,18 @@ void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
 static void opp_migrate_dentry(struct opp_device *opp_dev,
 			       struct opp_table *opp_table)
 {
-	struct opp_device *new_dev;
+	struct opp_device *new_dev = NULL, *iter;
 	const struct device *dev;
 	struct dentry *dentry;
 
 	/* Look for next opp-dev */
-	list_for_each_entry(new_dev, &opp_table->dev_list, node)
-		if (new_dev != opp_dev)
+	list_for_each_entry(iter, &opp_table->dev_list, node)
+		if (iter != opp_dev) {
+			new_dev = iter;
 			break;
+		}
+
+	BUG_ON(!new_dev);
 
 	/* new_dev is guaranteed to be valid here */
 	dev = new_dev->dev;
-- 
2.17.1

