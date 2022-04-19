Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C715063BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347910AbiDSFKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbiDSFKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:10:02 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366DB20190;
        Mon, 18 Apr 2022 22:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650344841; x=1681880841;
  h=from:to:cc:subject:date:message-id;
  bh=GdTiCrZbPfX19PSnyI6txSuLTMmt+h3YnRZA1pn6xpo=;
  b=s+XWdRNYeSSFV8ErztHPsulc9O2/QtTo8ggu3Rk2MlcLNJFjxNblXl5+
   q1WGCLw7otFFU+o2VrdCMEwCDQpo6JL/5W+TwVMDmwJOZwhHgsbIQ/G34
   yFcBQQJ9pfaBVxjlhbPWerUIsx6OLaCLSjyxdSfmQohGnVqyWsxsyEcZ1
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 22:07:21 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 Apr 2022 22:07:19 -0700
X-QCInternal: smtphost
Received: from hu-dikshita-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.13])
  by ironmsg01-blr.qualcomm.com with ESMTP; 19 Apr 2022 10:37:03 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 7F22F434D; Tue, 19 Apr 2022 10:37:02 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     linux-arm-msm@vger.kernel.org, ezequiel@collabora.com,
        stanimir.varbanov@linaro.org, quic_vgarodia@quicinc.com,
        quic_majja@quicinc.com, quic_jdas@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v5 0/2] Introduce Intra-refresh type control
Date:   Tue, 19 Apr 2022 10:36:41 +0530
Message-Id: <1650344803-6884-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add a new intra-refresh type control for encoders.
this can be used to specify which intra refresh to be enabled, random, cyclic or none.

Change since v0:
 Dropped INTRA_REFRESH_TYPE_NONE as it was not needed.
 Intra refresh period value as zero will disable the intra  refresh.

Change since v1:
 Updated the control name for better undestanding.
 Also updated the documentation accordingly.

Change since v2:
 Updated the venus driver implementation as well to use the  correct control name. Missed in v2.

Change since v3:
 Addressed comments from Hans in v4l2 patch.
 Enabled the support for cyclic intra refresh in venus driver.

Change since v4:
 fixed typos in v4l2 patch.
 fix mask value in venus driver patch (Hans).

Thanks,
Dikshita


Dikshita Agarwal (2):
  media: v4l2-ctrls: Add intra-refresh type control
  venus: venc: Add support for intra-refresh mode

 .../userspace-api/media/v4l/ext-ctrls-codec.rst    | 22 ++++++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h           |  1 +
 drivers/media/platform/qcom/venus/venc.c           |  6 +++++-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |  8 ++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  9 +++++++++
 include/uapi/linux/v4l2-controls.h                 |  5 +++++
 6 files changed, 50 insertions(+), 1 deletion(-)

-- 
2.7.4

