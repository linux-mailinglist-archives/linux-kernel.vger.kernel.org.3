Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C35530A81
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiEWHqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiEWHqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:46:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62531838C;
        Mon, 23 May 2022 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653291995; x=1684827995;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=wNhvNy4EX9ZtErtRxG9a+EU8g7TAhkt3FZJsScOkkbM=;
  b=VD1XeiUpuC46bQ4trPeVU+1G7OdSYJbVAkgIdJjgmWAb8/Zf1ucBEmfd
   /GoRzAdccweAsVqMzBA5tvSzlxS1M0w69ail153Tyja403+jyRk0iRrsL
   4xlB7/bXK7I+QBwgO80KaNvL6a2uDcAAZi/WhgmuCO6MaijqdYPg8axoJ
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 May 2022 00:01:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:01:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 00:01:16 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 00:01:12 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <quic_psodagud@quicinc.com>, <eberman@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [RFC 0/3] Add interconnect support to the SCM interface
Date:   Mon, 23 May 2022 12:30:55 +0530
Message-ID: <1653289258-17699-1-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the SMC calls required by remoteproc PAS driver on SM8450 SoCs
get a performance benefit from having a max vote to the crypto->ddr path.
Add support for bandwidth (bw) voting for those SMC calls when the
interconnects property is specified. Marking this as an RFC since the path
could either be specified in the individual remoteprocs or directly in the
scm interface.

Sibi Sankar (3):
  dt-bindings: firmware: qcom-scm: Add interconnects property
  firmware: qcom_scm: Add bw voting support to the SCM interface
  arm64: dts: qcom: sm8450: Add interconnect requirements for SCM

 .../devicetree/bindings/firmware/qcom,scm.txt      |  1 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  1 +
 drivers/firmware/qcom_scm.c                        | 69 ++++++++++++++++++++++
 3 files changed, 71 insertions(+)

-- 
2.7.4

