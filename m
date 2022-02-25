Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD57C4C42E8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbiBYK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbiBYK5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:57:12 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C092DF1;
        Fri, 25 Feb 2022 02:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645786599; x=1677322599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G9dzvbF/4cH2J4t8oHKAF2cRlYPFFAbxeUqSbhr+27A=;
  b=JInRLXDn36ODut3iKnDPKiqhRJcoE7HYoaogB8Qjt3A3Y3Ze7vm7Qtvh
   xuvJaMfFDYVhBI/dFexnnWm3SyY+RBLpgSnTQerIO8tVnWVb9fYyU/fwC
   iWP+ab36fIhxGvhT8N+QTMBtAprxCCd31d+0v4dQzS5B3FFh0oTc30BQE
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Feb 2022 02:56:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 02:56:37 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 02:56:37 -0800
Received: from [10.216.25.108] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 25 Feb
 2022 02:56:31 -0800
Message-ID: <206b65f8-90ba-e15d-d7b7-dce0a01fe936@quicinc.com>
Date:   Fri, 25 Feb 2022 16:26:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] ASoC: codecs: Add power domains support in digital
 macro codecs
Content-Language: en-US
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
References: <1645708759-8833-1-git-send-email-quic_srivasam@quicinc.com>
 <Yhfhgrvl38WcNOFu@sirena.org.uk>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Yhfhgrvl38WcNOFu@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2/25/2022 1:20 AM, Mark Brown wrote:
Thanks for your time Brown!!!
> On Thu, Feb 24, 2022 at 06:49:19PM +0530, Srinivasa Rao Mandadapu wrote:
>
>> +	l_pds->macro_pd = dev_pm_domain_attach_by_name(dev, "macro");
>> +	if (IS_ERR_OR_NULL(l_pds->macro_pd))
>> +		return NULL;
> Shouldn't there also be a DT binding update for the users?
Okay. Will send dt-bindings patch too.
