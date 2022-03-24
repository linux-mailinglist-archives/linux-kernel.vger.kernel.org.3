Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441BE4E5F49
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348504AbiCXH02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiCXH01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:26:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D187A986F5;
        Thu, 24 Mar 2022 00:24:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t1so4550528edc.3;
        Thu, 24 Mar 2022 00:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UusJwPTvawwqw4B13062bzCvDRIa/PfzdX6rZ/h/ofQ=;
        b=BB/x7LbNUE8nHL64NA5MPWmuQTYC0FQt/zHFjd1px6EmZeQg9A8d9798/hSq21tR0h
         nkXZuo1YJcGC0N7KHdSZ0rH5Av6kBrOL1EDEeQVTBIhOisgr80e83O7jx3wqJDg8j0SU
         KautTEldNJTsFB/BzKiQW4Yx+WF3FypcXGApTqWh7JT6FCrRDin6k3ufHwa6U/Jxobsw
         8RzBVUqbGcJeqXQOLh+SjRMQupj9Y2AwEmNisvQwStZ+kzCQ+PVYIPp9uAiRPX00QQ0Z
         sY4Wbpf4tpCUBsaYF/sGB/xEBhBKE+1RmwTVwQeprQB0V69KvA4FXpc9Zg1kP3pQs7RT
         oNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UusJwPTvawwqw4B13062bzCvDRIa/PfzdX6rZ/h/ofQ=;
        b=XZz1owOAClExae8lG4LiOq6XL/7DDvbVrNpjWfpmDzsscSpa3yHq7B865922qraodw
         ySxFRHmcUnblkkZFv71ESBglvAXFRbAtKPK5YT+obHbFbN7TkQkJobLZrFAEGxo2yPuJ
         DkTJw6wUDf1bX2i4xhjtKsx9BEF9DqKaSUY+OMOqtFyWBVjhlLqVfW+sHk1RfXhg7Bb1
         Q6No3NzGvQe50vycJiQvVvtn7m7moQqbjNEma2GVSXF0ysUY9Qql8ddKq/CToPUk+PDn
         4CkQ1hQH2+Kc9qPxtYgoLB+OBBn5aRGD+2r8NFa6EqAaOaaGqbMei+gCO2L7kWvP3rho
         sxAg==
X-Gm-Message-State: AOAM531LN2mvmsPKtJV7AAOOlbJaT0rx0F3s78fohIpWU+AyhfadvlJ1
        dm1Uzv3XprheCQKVt8vkN/o=
X-Google-Smtp-Source: ABdhPJwtG3kiR6DehJZXY4TNL89bSww86qN8khEh2LznICWoqF4hkhvsQAkiKwIR1EqiDKaIKIxIsA==
X-Received: by 2002:a50:cfc4:0:b0:413:b19d:d9c0 with SMTP id i4-20020a50cfc4000000b00413b19dd9c0mr5077856edk.384.1648106694346;
        Thu, 24 Mar 2022 00:24:54 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id ep16-20020a1709069b5000b006daa26de2fbsm759578ejc.153.2022.03.24.00.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:24:54 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] soc: qcom: pdr: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:24:35 +0100
Message-Id: <20220324072435.63070-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/soc/qcom/pdr_interface.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index fc580a3c4336..0034af927b48 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -304,24 +304,23 @@ static void pdr_indication_cb(struct qmi_handle *qmi,
 					      notifier_hdl);
 	const struct servreg_state_updated_ind *ind_msg = data;
 	struct pdr_list_node *ind;
-	struct pdr_service *pds;
-	bool found = false;
+	struct pdr_service *pds = NULL, *iter;
 
 	if (!ind_msg || !ind_msg->service_path[0] ||
 	    strlen(ind_msg->service_path) > SERVREG_NAME_LENGTH)
 		return;
 
 	mutex_lock(&pdr->list_lock);
-	list_for_each_entry(pds, &pdr->lookups, node) {
-		if (strcmp(pds->service_path, ind_msg->service_path))
+	list_for_each_entry(iter, &pdr->lookups, node) {
+		if (strcmp(iter->service_path, ind_msg->service_path))
 			continue;
 
-		found = true;
+		pds = iter;
 		break;
 	}
 	mutex_unlock(&pdr->list_lock);
 
-	if (!found)
+	if (!pds)
 		return;
 
 	pr_info("PDR: Indication received from %s, state: 0x%x, trans-id: %d\n",

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

