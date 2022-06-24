Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4C559E55
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiFXQMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFXQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:12:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03FC522DB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AA5EB82941
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AA6C34114
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656087153;
        bh=O+iqYWABxLXR3nslDOJ9FcAnnLxkuwcNK8j0XQt2ho8=;
        h=From:To:Subject:Date:From;
        b=SCB/czPKroWTzWDkp0T5fgJ4+QG7kjYotTo5hZMukYYP/QtLpgKPpZF9RdlpYfoF5
         6IzPz0EkecXVEG/hoNuTj8h+6fWDbaQIJHyIySfsB9PfZK4U2sNSluoCoGuFd67BWD
         lbnS+xEboY96t0iHjV3PL/DKOHS8bvualYWSMnBMVXZhAl2DVcBOBUwrJvxo7S8x4o
         u0Q5glZ1xXtAbdrpuDBuETmzcxTunRhSw0jXiJTIWozwm8DEW8Ci5nkJ45SZoHyBJu
         jXuIG/ltdTdpkmfXgcA0BOdXaGdtgCA5rQWWSDvvcVSBFNpDWNJrQpkK8HHjuTq081
         iJ+f0JHWS+E2Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs/gaudi: enable error interrupt on ARB WDT
Date:   Fri, 24 Jun 2022 19:12:29 +0300
Message-Id: <20220624161229.1874446-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to receive an error interrupt in case the watchdog timer
expires on arbitration event in the queues.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/gaudi/gaudi_masks.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
index acc85d3ed98b..880c57b26c63 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
@@ -444,6 +444,7 @@ enum axi_id {
 
 #define QM_ARB_ERR_MSG_EN_MASK		(\
 					QM_ARB_ERR_MSG_EN_CHOISE_OVF_MASK |\
+					QM_ARB_ERR_MSG_EN_CHOISE_WDT_MASK |\
 					QM_ARB_ERR_MSG_EN_AXI_LBW_ERR_MASK)
 
 #define PCIE_AUX_FLR_CTRL_HW_CTRL_MASK                               0x1
-- 
2.25.1

