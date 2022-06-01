Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DCB539D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349871AbiFAGcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244910AbiFAGcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:32:07 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB7913EB1;
        Tue, 31 May 2022 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654065125; x=1685601125;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s9gUxig0ok1ngcEsz0djAAmFBWB9OcXhuz4rut5eERE=;
  b=xvj9GQ+ysMFmkPY80QBQKQ3JYwGwXWccRZ9sdUry9UjXcO0YgNfdfkg8
   joq5GwSSxaas3uMGERz2NM8/7HlPURZRBalUaqUOS9E9tMfH4/ISKG4JR
   iz+hJ/Jbt9xVc2bjhndbdTickiVltQPC9NZ+h9bBLFbMcgPVDiRxJprz5
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 31 May 2022 23:32:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 23:32:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 23:32:04 -0700
Received: from [10.216.54.83] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 31 May
 2022 23:31:58 -0700
Message-ID: <4849065c-f743-884e-2afe-d802efde0a99@quicinc.com>
Date:   Wed, 1 Jun 2022 12:01:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 2/3] phy: qcom-snps: Add support for overriding phy
 tuning parameters
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_ppratap@quicinc.com>,
        <quic_vpulyala@quicinc.com>
References: <1654013693-21484-1-git-send-email-quic_kriskura@quicinc.com>
 <1654013693-21484-3-git-send-email-quic_kriskura@quicinc.com>
 <20220601020856.GA20979@hu-pkondeti-hyd.qualcomm.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20220601020856.GA20979@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/1/2022 7:38 AM, Pavan Kondeti wrote:
> On Tue, May 31, 2022 at 09:44:52PM +0530, Krishna Kurapati wrote:
>> Add support for overriding electrical signal tuning parameters for
>> SNPS HS Phy.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 268 +++++++++++++++++++++++++-
>>   1 file changed, 266 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
>> index 5d20378..3a17216 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
>> @@ -52,6 +52,12 @@
>>   #define USB2_SUSPEND_N				BIT(2)
>>   #define USB2_SUSPEND_N_SEL			BIT(3)
>>   
> <snip>
>
>> +static void qcom_snps_hsphy_override_param_update_val(
>> +			const struct override_param_map map,
>> +			s32 dt_val, struct phy_override_seq *seq_entry)
>> +{
>> +	int i;
>> +
>> +	/*
>> +	 * Param table for each param is in increasing order
>> +	 * of dt values. We need to iterate over the list to
>> +	 * select the entry that has equal or the next highest value.
>> +	 */
>> +	for (i = 0; i < map.table_size - 1; i++) {
>> +		if (map.param_table[i].value >= dt_val)
>> +			break;
>> +	}
>> +
>> +	seq_entry->need_update = true;
>> +	seq_entry->offset = map.reg_offset;
>> +	seq_entry->mask = map.param_mask;
>> +	seq_entry->value =  map.param_table[i].reg << __ffs(map.param_mask);
>> +}
>> +
>> +static void qcom_snps_hsphy_read_override_param_seq(struct device *dev)
>> +{
>> +	struct device_node *node = dev->of_node;
>> +	s32 val;
>> +	int ret, i;
>> +	struct qcom_snps_hsphy *hsphy;
>> +	const struct override_param_map *cfg =
>> +		(struct override_param_map *) of_device_get_match_data(dev);
> As mentioned in the previous patch-set, the explicit typecast is not needed.
>
> overall, looks good to me. After fixing the above, feel free to use
>
> Reviewed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
>
> Thanks,
> Pavan
My bad, Thanks for the review Pavan. Will fix it in the next patch.
