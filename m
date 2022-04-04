Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852134F12F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356855AbiDDKTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355864AbiDDKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:19:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011833C4BE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:17:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m67-20020a1ca346000000b0038e6a1b218aso2798640wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mV7mVvkcvKrPA0nn13aopStte01CanOqiAL16eKUA4c=;
        b=eEiQ9s7qF5YibTbUKy/MVO17ih75uJER5OLQvBIh6WkCZ2Hx/XfTfJuH1uLw0ZeP6D
         e6SVJ0LOkBmnnGUY93BC+YbDeYoX0jW//xcs2LH5PmK6WbU/0lPgldozbDRNUOk2ktGb
         f9Am9EXbBh6lRpYkH0dEh0qlcMnw4HBoC5GnHus95ryzA5rDzBf3CfSu0cT52ZCVUWax
         1o4seEMxji+2rfIxG4XnBnLTc9EObblT+Tv2n9uSMmja7Ke18Td8SHlNktbx/87JB0bH
         XnHHezJjr0FosaYvR1iltDwd6dOxvgXuAGVMw1pk8mhVERnxZu85g7WCA3PT5jcOYEwV
         lmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mV7mVvkcvKrPA0nn13aopStte01CanOqiAL16eKUA4c=;
        b=nLSGeDXlcx70GS8xybH0XMbMc6bqiChZap253+wiJ07wa5eHsPcMte/aSMaIHDQkgq
         jyO3Wd3W1S7hY6a3SiaabshcedxwLjOen2/oJ14+cQbOOLUuYo0jycYLvFz7kdlU/8u6
         CyBnd/rgstfk0HAji225YWaBqdbIshgTOqpMsWIFvQI/HKdH3/qm0JMTLCy4WvrJjprP
         5ahKIOcMY14RxpKMrQOD8aJVQDfWAYPDiv8047JSPgcu7M5do/nCKkW4MTebpIiKmvwp
         o/OKqIReJRjE37iaKaX3aw/4ivI7ByK/QrtDNxIrgJGaidA3KH5HSXpj/LdPrYALbg8P
         413w==
X-Gm-Message-State: AOAM5327z/wZ8AhIfa1/A9sNZ2oUlh2unSqgJKDB/s7jqoSK9vHWJTYa
        8IUW3WcQq/OUA/8eRD/OTKgf5zoxBUwRHA==
X-Google-Smtp-Source: ABdhPJw8n1n3hIBtLNlfwBGHTZN5ZaCMscFe3FPS7MSQV/nHtjlHlvBw+V2b52iPVvUrCGulTok9kw==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr18745633wma.140.1649067449315;
        Mon, 04 Apr 2022 03:17:29 -0700 (PDT)
Received: from lmecxl0524.lme.st.com ([2a04:cec0:10db:48f5:91f6:e01:f00:f0cd])
        by smtp.gmail.com with ESMTPSA id q17-20020adff951000000b00205c1b97ac4sm8919255wrr.20.2022.04.04.03.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 03:17:28 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH] firmware: arm_scmi: fix incorrect type in optee transport
Date:   Mon,  4 Apr 2022 12:17:22 +0200
Message-Id: <20220404101722.27986-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct struct scmi_shared_mem references that should have __iomem
attribute. The issue was reported by kernel test robot:

drivers/firmware/arm_scmi/optee.c:428:20: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct scmi_shared_mem * @@     got struct scmi_shared_mem [noderef] __iomem *shmem @@
drivers/firmware/arm_scmi/optee.c:440:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct scmi_shared_mem [noderef] __iomem *shmem @@     got struct scmi_shared_mem *shmem @@

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/arm_scmi/optee.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 734f1eeee161..bcab9ff73103 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -405,8 +405,8 @@ static int scmi_optee_chan_free(int id, void *p, void *data)
 	return 0;
 }
 
-static struct scmi_shared_mem *get_channel_shm(struct scmi_optee_channel *chan,
-					       struct scmi_xfer *xfer)
+static struct scmi_shared_mem __iomem *get_channel_shm(struct scmi_optee_channel *chan,
+						       struct scmi_xfer *xfer)
 {
 	if (!chan)
 		return NULL;
@@ -419,7 +419,7 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
 				   struct scmi_xfer *xfer)
 {
 	struct scmi_optee_channel *channel = cinfo->transport_info;
-	struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
+	struct scmi_shared_mem __iomem *shmem = get_channel_shm(channel, xfer);
 	int ret;
 
 	mutex_lock(&channel->mu);
@@ -436,7 +436,7 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
 				      struct scmi_xfer *xfer)
 {
 	struct scmi_optee_channel *channel = cinfo->transport_info;
-	struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
+	struct scmi_shared_mem __iomem *shmem = get_channel_shm(channel, xfer);
 
 	shmem_fetch_response(shmem, xfer);
 }
-- 
2.17.1

