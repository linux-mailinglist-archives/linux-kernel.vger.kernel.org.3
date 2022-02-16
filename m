Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0014B7E39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbiBPC7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:59:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbiBPC6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:58:52 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE642BB29;
        Tue, 15 Feb 2022 18:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644980322; x=1676516322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iRdJ0ff50RqMWLZhZC7oy82tRtOID/wxTQAFSPki4bM=;
  b=j5TNk1ePXavRMSISqzHkRFTxOZ/kKu8KFEn+B2QfJwSUciwBOQr6aRg3
   tBeZAdg3mKAczibBi5hYSdbiewiGNxLLPWzv5TNmuxRlvla9s2FmnGBKa
   sSSF857hLwU6pKQgpy49x5kOatE518XGYh9xBjtXRQas2bFGKmwC8u1o0
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Feb 2022 18:58:41 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:58:41 -0800
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 18:58:40 -0800
Date:   Tue, 15 Feb 2022 18:58:39 -0800
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Satya Priya <quic_c_skakit@quicinc.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>
Subject: Re: [PATCH V6 3/6] mfd: pm8008: Add mfd cell struct to register LDOs
Message-ID: <20220216025839.GA28938@hu-gurus-sd.qualcomm.com>
References: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644915231-7308-4-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1644915231-7308-4-git-send-email-quic_c_skakit@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 02:23:48PM +0530, Satya Priya wrote:
>  static const struct of_device_id pm8008_match[] = {
> -	{ .compatible = "qcom,pm8008", },
> -	{ },
> +	{ .compatible = "qcom,pm8008", .data = (void *)PM8008_INFRA},
> +	{ .compatible = "qcom,pm8008-regulators", .data = (void *)PM8008_REGULATORS},

Typo perhaps: Please set the last element of this array to the sentinel value NULL.
        {},

>  };
> +MODULE_DEVICE_TABLE(of, pm8008_match)

Missing a semicolon at the end.

>  
>  static struct i2c_driver pm8008_mfd_driver = {
>  	.driver = {
