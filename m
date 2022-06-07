Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B241453A4EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352532AbiFAM2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiFAM2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:28:13 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104DF6007D;
        Wed,  1 Jun 2022 05:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654086484; x=1685622484;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hYwv9KiSWJpDdihwb1JCqCMCtB8qTNh2vqckWpz8dK8=;
  b=bRJf59HUxlAl86GYMndO5qrHGoJHiu8970snoGyqFYuj3cPEZebraLyb
   /cBcuNfVFXOtt7X8vLUeFUMJUnuklLnfb1vj7eYJ1mlO6O84dRo14az0C
   IzVkblmhObXAVl5IPZxYrYt92GFGcyL6SOnEmEHJttg2WB7nyca1aV9lO
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Jun 2022 05:28:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 05:28:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 05:28:02 -0700
Received: from [10.216.57.206] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 05:27:57 -0700
Message-ID: <91b75542-8e4c-5b91-bbfd-38ffc456c12e@quicinc.com>
Date:   Wed, 1 Jun 2022 17:57:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3] PCI/ASPM: Update LTR threshold based upon reported max
 latencies
Content-Language: en-US
To:     <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <swboyd@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>, <vidyas@nvidia.com>,
        <kenny@panix.com>
References: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com>
 <1654086232-17055-1-git-send-email-quic_krichai@quicinc.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <1654086232-17055-1-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc kenny, vidya]

On 6/1/2022 5:53 PM, Krishna chaitanya chundru wrote:
> In ASPM driver, LTR threshold scale and value is updating based on
> tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
> LTR threshold scale and value is greater values than max snoop/non-snoop
> value.
>
> Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
> reported snoop/no-snoop values is greather than or equal to
> LTR_L1.2_THRESHOLD value.
>
> Suggested-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>
> I am takking this patch forward as prasad is no more working with our org.
>
> Changes since v2:
> 	- Replaced LTRME logic with max snoop/no-snoop latencies check.
> Changes since v1:
> 	- Added missing variable declaration in v1 patch
> ---
>   drivers/pci/pcie/aspm.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b742..4a15e50 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -465,10 +465,19 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>   	u32 ctl1 = 0, ctl2 = 0;
>   	u32 pctl1, pctl2, cctl1, cctl2;
>   	u32 pl1_2_enables, cl1_2_enables;
> +	int ltr;
> +	u16 max_snoop_lat = 0, max_nosnoop_lat = 0;
>   
>   	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>   		return;
>   
> +	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
> +	if (!ltr)
> +		return;
> +
> +	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
> +	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
> +
>   	/* Choose the greater of the two Port Common_Mode_Restore_Times */
>   	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>   	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> @@ -501,7 +510,18 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>   	 */
>   	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
>   	encode_l12_threshold(l1_2_threshold, &scale, &value);
> -	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> +
> +	/*
> +	 * If the max snoop and no snoop latencies are '0', then avoid updating scale
> +	 * and value.
> +	 *
> +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
> +	 * snoop/no-snoop values is greather than or equal to LTR_L1.2_THRESHOLD value.
> +	 */
> +	if ((max_snoop_lat == 0) && (max_nosnoop_lat == 0))
> +		ctl1 |= t_common_mode << 8;
> +	else
> +		ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>   
>   	/* Some broken devices only support dword access to L1 SS */
>   	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
