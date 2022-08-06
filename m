Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFAD58B695
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiHFPr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHFPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:47:54 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0236DF24
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 08:47:52 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id q184so5714659oif.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=caXVr+Ow74BLwv+HS14+x281MgD0udLpKluE18as/Ys=;
        b=VHEZu3Cwu4px+UJViXxvzKV7E95aCzJ2aiY9lO4e4RhVGcj9hhN0kP8q7PIw1YTHXF
         kQgxw2z7mU04HilX4dFWC6r8YEcMg72LC2LhvmQQcnKHfcZ0HWrhujw3p1BEq2bUYcaD
         sGb+fh+48bNn37LAHMu2ypIKDguXTHM34Bp5U4VNZl/SQDD89k44So6m+PJp5jFi2WYK
         /Zy130UgYjC59SOmWJr796RPcG+GCLL+0aVE7l1l3yu23VDmgQTODvv/XxtYEtKanUfR
         nXGom+YnrtpXr318v7Izrc8WNL8PxIWWLZJqj5kOhsiO73Walx+QrZr8fcKHBpsggPZD
         HFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=caXVr+Ow74BLwv+HS14+x281MgD0udLpKluE18as/Ys=;
        b=vCROnDHaDOfB/KcDOfp/1XoOb84GmRcFOPh3mJqNyTlYRqyZ1cXn9AdBsFb7qn8cHR
         Wttp5/nXxxK49qB1nbVIB5hTgSIpQIGxjkL5e38wYMyDC6gYaTvV+MaUKp3xw0KxuqnE
         dbsXkiCS19QY55xooVCvjjo1TmVrnNpEupvoMTQgUuRhFP5oGvEjmVQP5Ue6vuiyqDkG
         KmSrFeB8Qn/O95jRgaMtvcUAFyfJtlJHH0yna5oGGbWZKeB251zrFFcGCS8eEDbiIRfd
         JenAlveuAaMvLzJGVD9jRs2HBrbIUtj6AwaiwcU8eyasAMAtNt5f9ZmzECaQwWCLjdqj
         qiJQ==
X-Gm-Message-State: ACgBeo2EuZaMcJDHTGqjPXNLN2koLOi+gA4sSX7avJ8bFXW/qQ1YXae9
        JCeb5kjWBRz9m5ZWgCeC6mpehg==
X-Google-Smtp-Source: AA6agR6y5oy/LUCU35T62Z6S8hBuiVdaT0GXrFkBgxrv4vWOTvfFQraczJvPuKJG5j1mrmffegNVOg==
X-Received: by 2002:a05:6808:1442:b0:342:a346:348e with SMTP id x2-20020a056808144200b00342a346348emr5306009oiv.11.1659800872275;
        Sat, 06 Aug 2022 08:47:52 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p2-20020aca4202000000b00342bd6ad315sm794008oia.33.2022.08.06.08.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 08:47:51 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH] soc: qcom: rpmhpd: Use highest corner until sync_state
Date:   Sat,  6 Aug 2022 08:50:35 -0700
Message-Id: <20220806155035.968340-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases the hardware that the bootloader has left configured
depends on RPMH power domains for their operation up until the point
where the related Linux device driver probes and can inherit that
configuration, or power down the hardware gracefully.

Unfortunately as Linux probes the releavant drivers in sequence there
are periods during the Linux boot flow where either the genpd refcount
will reach 0, or worse where the active performance_state votes does not
meet the requirements of the state that the hardware was left in.

One specific example of this is during boot of e.g. SM8150/SC8180X,
where the display clock controller probes, without any particular
performance state needs (to access its registers). This will drop the
MMCX rail to MIN_SVS, which isn't sufficient to sustain the clock rates
that the later probing MDP is configured to. This results in an
unrecoverable system state.

Handle both these cases by keeping the RPMH power-domais that are
referenced voted for highest state, until sync_state indicates that all
devices referencing the RPMH power-domain driver has been probed.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 092f6ab09acf..494bb6c75ed7 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -39,6 +39,7 @@
  * @res_name:		Resource name used for cmd-db lookup
  * @addr:		Resource address as looped up using resource name from
  *			cmd-db
+ * @state_synced:       Indicator that sync_state has been invoked for the rpmhpd resource
  */
 struct rpmhpd {
 	struct device	*dev;
@@ -54,6 +55,7 @@ struct rpmhpd {
 	bool		enabled;
 	const char	*res_name;
 	u32		addr;
+	bool		state_synced;
 };
 
 struct rpmhpd_desc {
@@ -493,7 +495,13 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
 	unsigned int this_active_corner = 0, this_sleep_corner = 0;
 	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
 
-	to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
+	if (pd->state_synced) {
+		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
+	} else {
+		/* Clamp to highest corner if sync_state hasn't happened */
+		this_active_corner = pd->level_count - 1;
+		this_sleep_corner = pd->level_count - 1;
+	}
 
 	if (peer && peer->enabled)
 		to_active_sleep(peer, peer->corner, &peer_active_corner,
@@ -708,11 +716,36 @@ static int rpmhpd_probe(struct platform_device *pdev)
 	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
 }
 
+static void rpmhpd_sync_state(struct device *dev)
+{
+	const struct rpmhpd_desc *desc = of_device_get_match_data(dev);
+	struct rpmhpd **rpmhpds = desc->rpmhpds;
+	unsigned int corner;
+	struct rpmhpd *pd;
+	unsigned int i;
+
+	mutex_lock(&rpmhpd_lock);
+	for (i = 0; i < desc->num_pds; i++) {
+		pd = rpmhpds[i];
+		if (!pd)
+			continue;
+
+		pd->state_synced = true;
+		if (pd->enabled)
+			corner = max(pd->corner, pd->enable_corner);
+		else
+			corner = 0;
+		rpmhpd_aggregate_corner(pd, corner);
+	}
+	mutex_unlock(&rpmhpd_lock);
+}
+
 static struct platform_driver rpmhpd_driver = {
 	.driver = {
 		.name = "qcom-rpmhpd",
 		.of_match_table = rpmhpd_match_table,
 		.suppress_bind_attrs = true,
+		.sync_state = rpmhpd_sync_state,
 	},
 	.probe = rpmhpd_probe,
 };
-- 
2.35.1

