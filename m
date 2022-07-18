Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B154E5781EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbiGRMOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiGRMOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:14:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7681A054
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:14:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPdh-0005d9-6f; Mon, 18 Jul 2022 14:14:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPde-001i3t-V6; Mon, 18 Jul 2022 14:14:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPdd-005xVJ-Tg; Mon, 18 Jul 2022 14:14:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/8] interconnect: Prepare making platform remove callbacks return void
Date:   Mon, 18 Jul 2022 14:14:01 +0200
Message-Id: <20220718121409.171773-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079; h=from:subject; bh=A1o6I6OVHVljeru//hO3heJNwTEoskPv4jVq/tRtPrU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1U5yX+wocJskVFzESoSjYSC+vn/AZDq7N/GEq/7P iSSPhf2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtVOcgAKCRDB/BR4rcrsCUibB/ 47wzVcYBIAkJNgLQcmiGSY2Q/hmyILxPtnC8l3I6ItMfwGWDNsSGrU85nv3M+eyZwJmM6m5OY69WKd Fa7l2eVvJqtGd67ruxhY62HcsWi4vIfRgPxBXGpbCEYO8ciL6F39a283INNAj5Ji5vdR61fP1bPWHK Fdb1XoLU1+RZiabYBX9CVHqw9iTlcigkzF5sSXVx/4HbECAwxn4+H83YHh0v8Kp+RQer7uuWm9cYh6 Pu03j5zzEzG9lNwaWokGEWqQ2/NNxzALHxANDZzVVavN/FpBGOjqeLNd7xBy3bjGUToV71XC1Mw3so mS6a+jj9zfFlaHrhT/3p5UxJT65Vnz
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

today remove callbacks of platform devices return an int. This is unfortunate
because the device core ignores the return value and so the platform code only
emits a warning (and still removes the device).

My longterm quest is to make these remove callbacks return void instead.
This series is a preparation for that, with the goal to make the remove
callbacks obviously always return 0. This way when the prototype of
these functions is changed to return void, the change is straight
forward and easy to review.

Changes since (implict) v1:

 - Also make the icc_provider_del() stub for the CONFIG_INTERCONNECT=n
   case void. Found by Georgi Djakov

Best regards
Uwe

Uwe Kleine-König (8):
  interconnect: imx: Ignore return value of icc_provider_del() in
    .remove()
  interconnect: icc-rpm: Ignore return value of icc_provider_del() in
    .remove()
  interconnect: icc-rpmh: Ignore return value of icc_provider_del() in
    .remove()
  interconnect: msm8974: Ignore return value of icc_provider_del() in
    .remove()
  interconnect: osm-l3: Ignore return value of icc_provider_del() in
    .remove()
  interconnect: sm8450: Ignore return value of icc_provider_del() in
    .remove()
  interconnect: Make icc_provider_del() return void
  interconnect: imx: Make imx_icc_unregister() return void

 drivers/interconnect/core.c           | 10 +++-------
 drivers/interconnect/imx/imx.c        |  4 ++--
 drivers/interconnect/imx/imx.h        |  2 +-
 drivers/interconnect/imx/imx8mm.c     |  4 +++-
 drivers/interconnect/imx/imx8mn.c     |  4 +++-
 drivers/interconnect/imx/imx8mq.c     |  4 +++-
 drivers/interconnect/qcom/icc-rpm.c   |  4 +++-
 drivers/interconnect/qcom/icc-rpmh.c  |  4 +++-
 drivers/interconnect/qcom/msm8974.c   |  4 +++-
 drivers/interconnect/qcom/osm-l3.c    |  4 +++-
 drivers/interconnect/qcom/sm8450.c    |  4 +++-
 include/linux/interconnect-provider.h |  5 ++---
 12 files changed, 32 insertions(+), 21 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

