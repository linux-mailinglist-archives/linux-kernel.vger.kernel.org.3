Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2F576844
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiGOUhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiGOUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:37:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B964487215
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:37:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3Z-0004t4-Jc; Fri, 15 Jul 2022 22:37:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3X-001BFO-Du; Fri, 15 Jul 2022 22:36:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3W-005Py7-JW; Fri, 15 Jul 2022 22:36:58 +0200
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
Subject: [PATCH 0/8] interconnect: Prepare making platform remove callbacks return void
Date:   Fri, 15 Jul 2022 22:36:44 +0200
Message-Id: <20220715203652.89912-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; h=from:subject; bh=30zNokyf8YZwSDZQy06W7iHbrLyu4dV/qd1gRi70Sj4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi0c+Qsn7Xi1xjD4vKuEnIUbi32DWFn6eT2LpOtDIY +ZSGdXCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtHPkAAKCRDB/BR4rcrsCRZkB/ 9/w/c2Vn2dLfjlz8s0HbijZiKGzYnXhAcfRV12GhRtIJNguQ6J45oGG8Ew0EfRIJXcFACSR7G7PDT5 F5dcYMy+vB0xFytQQC0UB53LPfS5ueMW4z+8yFpBm7ieUo4VUH7GCTAihPOoRVSP+hcMO2rst9SiAd LaHB/4dpx5OJWId4FlzlWDjo6JhrfD3M/5i9WIGzm7ugu5HoJaRcpJvQFKlWkWf3hZckJvYJDOyYyt 589QBqb2cfYagzeY3q+2roA8J8XoVJeVEMoeqd+OppFEnFBh8KLVOZ8RoGecMGNCT2xiVANfUBBXsf ppacJQ82G9nOQJrUvqQUUZWIwWWgY9
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
these functions is changed to return void, the change is straigt forward
and easy to review.

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
 include/linux/interconnect-provider.h |  2 +-
 12 files changed, 31 insertions(+), 19 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

