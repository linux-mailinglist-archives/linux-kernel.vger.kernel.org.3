Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE6053B79A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiFBLJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiFBLJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:09:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9D6DF8B;
        Thu,  2 Jun 2022 04:09:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u18so4261310plb.3;
        Thu, 02 Jun 2022 04:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljficFq1TqFxNaV2DG3n6rqDMBYzY/gkLq9ouzEtTaQ=;
        b=jT+T3JHRJceQAjGn40OoIF8zldPKDKs+vXpivUThmbTV6l7HJEVQqfSiVyyUKxcIRA
         V1HV7307/DOObfVUmwyeawW8JmDNoQ6kbipK6x3akH6tSKydRJA3mWBRNpsvAPWLK8GR
         MyepNKbmiN70nrV7QO1BMSjFbFB1DSWDwQhTbpvdlMwuRcvFHCiChKokjBSTND5DZAb4
         qdYPxztobSEv4XYQAkx5sdWwLTx5gtO93vEBCmqH2OjmG2K4gzG/8p7IUvq6l+BlM+rK
         KtdJDmheNHCUlz1jO3BE4BcBmGINHcsEhvTbRHgmH1wLO/MmskeHXPYbo4W1pIqIdzJA
         iB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljficFq1TqFxNaV2DG3n6rqDMBYzY/gkLq9ouzEtTaQ=;
        b=y55h19+Gv1D/Kw47jqUysBxxNQSvgz3Ul5CgzQxGaCG3GUls5Mpv78K/zNhJKkjPaK
         5NfkiI8MTVNzYgAiDslFMrOKIRP9mLlmIlncNB5WU7qvQBIIYoAKbEgc7PPyKsIRdu7V
         cQvT4LrOpYpXEUC0BO9hgTE+yw2R0++QjUbEN4OmG33uuDhkineUXIhisMagtL2Hph8e
         mUtJxDB80dCexj8SsFfxPo3iy+VHBd2CnQ6KUrd9WX8EdaIehFfeeCUTsl1WVfeon2iH
         T6KmhbJPw7PYhOvhMkzhhQ1VFwkAa91ZlBGTv1tyvkGuKJjgAJBb/N4zoDyIGTL4Q5zj
         oXeg==
X-Gm-Message-State: AOAM531fCzFa4r7sCtXwkUCZvm5CdgmOQ6X9G8iDl9j8YsndTNyPx2AP
        LGH/lQITj7fvEYHskbEAmFFEAd4cJnREbXtqHxo=
X-Google-Smtp-Source: ABdhPJxnuVXQZP/neu33d1v8iS5bCLA/4Mw1vTXrJFlvdHEk2teNKvhgpMW7hCkYRlQXPUs/CSXBeQ==
X-Received: by 2002:a17:902:b698:b0:158:faee:442f with SMTP id c24-20020a170902b69800b00158faee442fmr4447431pls.75.1654168140661;
        Thu, 02 Jun 2022 04:09:00 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id h15-20020a17090a470f00b001df51dd0c93sm5694200pjg.1.2022.06.02.04.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 04:09:00 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vitaly Bordug <vitb@kernel.crashing.org>,
        Stefan Roese <sr@denx.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] usb: host: Fix refcount leak in ehci_hcd_ppc_of_probe
Date:   Thu,  2 Jun 2022 15:08:49 +0400
Message-Id: <20220602110849.58549-1-linmq006@gmail.com>
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

Fixes: 796bcae7361c ("USB: powerpc: Workaround for the PPC440EPX USBH_23 errata [take 3]")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/host/ehci-ppc-of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
index 6bbaee74f7e7..28a19693c19f 100644
--- a/drivers/usb/host/ehci-ppc-of.c
+++ b/drivers/usb/host/ehci-ppc-of.c
@@ -148,6 +148,7 @@ static int ehci_hcd_ppc_of_probe(struct platform_device *op)
 		} else {
 			ehci->has_amcc_usb23 = 1;
 		}
+		of_node_put(np);
 	}
 
 	if (of_get_property(dn, "big-endian", NULL)) {
-- 
2.25.1

