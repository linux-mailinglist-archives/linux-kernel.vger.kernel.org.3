Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0422569A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiGGF6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGGF6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:58:04 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E123192C;
        Wed,  6 Jul 2022 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657173483; x=1688709483;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0yz1LCHt0aGhTOraapZKZ5D1T7trqgBin6ZQ+zVDZFE=;
  b=NPbJB3bkL8T9yDPWo1lgbIdlU2DpC4XmFY4WRuC1o9bBKkpx3D9Z3cvO
   JR7kwxt7j+iZNU7BpcutF8/7wD29KVUcfLTtJWwhqdkAIkw1rOTWDZ/T0
   gXlHy6QMuFyRUCZyPRAwTXmuUSywDwrBNrZMpTBA3ZPmlVSBNDx0BDOKL
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 06 Jul 2022 22:58:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 22:58:02 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Jul 2022 22:58:02 -0700
Received: from [10.216.26.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Jul 2022
 22:57:57 -0700
Message-ID: <f6da6595-d3ba-b9f7-e869-041400ae12a7@quicinc.com>
Date:   Thu, 7 Jul 2022 11:27:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 3/3] clk: qcom: lpass: Add support for resets &
 external mclk for SC7280
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <mka@chromium.org>
References: <20220614153306.29339-1-quic_tdas@quicinc.com>
 <20220614153306.29339-4-quic_tdas@quicinc.com>
 <20220615195552.7994AC34115@smtp.kernel.org>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <20220615195552.7994AC34115@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Hi Stephen,

On 6/16/2022 1:25 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2022-06-14 08:33:06)
>> The clock gating control for TX/RX/WSA core bus clocks would be required
>> to be reset(moved from hardware control) from audio core driver. Thus
>> add the support for the reset clocks.
> 
> Why can't this driver remove the clks from hardware control when it
> probes? Does something put the clks into hardware control mode at
> runtime?

Sorry for the delayed response. These bits needs to be updated at 
runtime and this is as per the design requirement. Thus we had to come 
up with reset support for the same.

-- 
Thanks & Regards,
Taniya Das.
