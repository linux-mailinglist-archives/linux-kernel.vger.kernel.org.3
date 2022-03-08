Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279FE4D111E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbiCHHiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiCHHht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:37:49 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3393DDCD;
        Mon,  7 Mar 2022 23:36:54 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso1596573pjc.0;
        Mon, 07 Mar 2022 23:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=1O/m30lOLCShHOY1A8XX2vgIfOwS0B8Jqovd6Acndzs=;
        b=W4XYVgxLwKHbbUQ+aUBXJkPLsPX3JtkXREow6Fiba+HR/WyIpmoenvdlRHXOGdyUO6
         iqdFWgg5AiBZknmMYegY6mCSnol7mAf9NawWMrF12d1slobd7IKeWE2iXFXiEjRokKby
         2bM/qznnZfqlJjWds/F+0rKHVuskGSCRk3T/dbU5/N99LvtR8SgScZldqy/Nb+n06fz9
         ttSp7ZIx8JGBCSyKuNERnTP1wIry/uypK466WekRBDus/1uOBy2GG8gvqqOYukl/qF9D
         O6XoeV/Cd5TgSZbDxCNYG3wTlxUhl5K3QNvbHGUi0bYh7T+aSNR3H2TGHqYobZvuvgmx
         8ltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1O/m30lOLCShHOY1A8XX2vgIfOwS0B8Jqovd6Acndzs=;
        b=LvCGNAuQFIm20YUOwVHWUuaJhx9ajumgJOIo9SU6jmiZdaHWilu2S77PiZLEtdMKeA
         PHSp2sjZ0tI+Uey8uLRd40Aan3Piu/QmkS8JdpgGtSwH0vXDmgfjQXLPcygDRbg7EOje
         242ercDJJ8P0eMnU/Yky7jukm8DIMfc1SNLU2XqQaRNF0fdaIikbw5n3b8ejsNheX8S/
         xkWTVWvhB8UfIEeIgduK/tSc2Kc2Ls2DCK1x0BYM4qIeDjH6svUZr0X8Sou4TczTwOJP
         yq5Rpl0Vl0tYVHTSpCrqP77KRCDUVMrzFeYkGbE1ndXt6ugKbZzyoqfH4sG7G8hqeg0R
         Jk3Q==
X-Gm-Message-State: AOAM530uSdS+ap1BlLHdf+0XFS20uYgXpBVS++hrrZTZigT8w45lMrEL
        uUp00fHnbUXLOWj6w1RtS4A=
X-Google-Smtp-Source: ABdhPJw7OrQgdO9XnbyYh9yhEiDA0rSw52X8cVeCvHcqwZfMvRJXQvr3bZXE3t5TM6L5S6+PUXEwkw==
X-Received: by 2002:a17:90b:a41:b0:1bf:72b5:ae95 with SMTP id gw1-20020a17090b0a4100b001bf72b5ae95mr3277128pjb.110.1646725013502;
        Mon, 07 Mar 2022 23:36:53 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id ot13-20020a17090b3b4d00b001bf0b8a1ee7sm1800849pjb.11.2022.03.07.23.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:36:53 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] soc: qcom: smsm: Fix missing of_node_put() in smsm_parse_ipc
Date:   Tue,  8 Mar 2022 07:36:48 +0000
Message-Id: <20220308073648.24634-1-linmq006@gmail.com>
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

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

Fixes: c97c4090ff72 ("soc: qcom: smsm: Add driver for Qualcomm SMSM")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/qcom/smsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
index ef15d014c03a..9df9bba242f3 100644
--- a/drivers/soc/qcom/smsm.c
+++ b/drivers/soc/qcom/smsm.c
@@ -374,6 +374,7 @@ static int smsm_parse_ipc(struct qcom_smsm *smsm, unsigned host_id)
 		return 0;
 
 	host->ipc_regmap = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(host->ipc_regmap))
 		return PTR_ERR(host->ipc_regmap);
 
-- 
2.17.1

