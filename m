Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88F4B589C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357162AbiBNRfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:35:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357134AbiBNRfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:35:17 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948BC6540F;
        Mon, 14 Feb 2022 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644860109; x=1676396109;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5XlD8vp21eTKSkpNbt94DxzMkq8qEZEWW+TU+APGf4I=;
  b=qyVG0PHTuWbB4FeptwwoG57i23sdo2wLxbD9+Tsl8fCkUYoQdM6DaqO1
   qSGN9m9eQd7/adVm9MZZtfetF6zFKeet03fbDyy1nv4UAszvkd1dyVHus
   gGwNjB7TS9egE4924hLZZFd7oTdt6IAGRdf/wJhZJ9Qk7YfK52vyeUdZG
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Feb 2022 09:35:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 09:35:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 09:35:08 -0800
Received: from [10.216.62.158] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 14 Feb
 2022 09:35:02 -0800
Subject: Re: [PATCH v13 07/10] ASoC: qcom: Add support for codec dma driver
To:     Mark Brown <broonie@kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644832778-16064-1-git-send-email-quic_srivasam@quicinc.com>
 <1644832778-16064-2-git-send-email-quic_srivasam@quicinc.com>
 <YgppMcVjs0KuE5y8@sirena.org.uk>
 <669f2d39-8c14-68b9-6d89-a26e0e2e8857@quicinc.com>
 <YgqBmvAQvh9WRMj+@sirena.org.uk>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <3a13a99d-6b8b-bab5-3adc-fdd2565fc93a@quicinc.com>
Date:   Mon, 14 Feb 2022 23:04:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YgqBmvAQvh9WRMj+@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/2022 9:51 PM, Mark Brown wrote:
Thanks Brown for your time!!!
> On Mon, Feb 14, 2022 at 08:10:20PM +0530, Srinivasa Rao Mandadapu wrote:
>> On 2/14/2022 8:07 PM, Mark Brown wrote:
>>> I only have this patch from both v12 and v13, which were sent very close
>>> together.  Please check what's going on here.
>> As only one patch has update, so sent only one patch. will do resend all
>> patches if needed.
> You should always send all patches in a series, sending only some
> patches at best makes it very difficult to follow what the current
> version of the series is intended to look like.
Okay. Sorry for inconvenience. Resent all patches again.
