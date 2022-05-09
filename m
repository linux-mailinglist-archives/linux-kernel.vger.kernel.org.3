Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244CD51F2C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiEIDG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiEIDBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:01:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7BD84A1F;
        Sun,  8 May 2022 19:57:37 -0700 (PDT)
X-UUID: 3a3c2e1e4be54fe3a694e0afff2d6725-20220509
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:20ec6cda-f7a8-4273-a94c-e4858e2dea78,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:31
X-CID-INFO: VERSION:1.1.4,REQID:20ec6cda-f7a8-4273-a94c-e4858e2dea78,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:31
X-CID-META: VersionHash:faefae9,CLOUDID:1dd50bb3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:5f03f18dcb27,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 3a3c2e1e4be54fe3a694e0afff2d6725-20220509
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 836006255; Mon, 09 May 2022 10:57:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 9 May 2022 10:57:07 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 May 2022 10:57:06 +0800
Subject: Re: [PATCH v2] scsi: ufs: add clock-scalable property for clk scaling
To:     <j-young.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <alice.chao@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20220507045223.14775-1-powen.kao@mediatek.com>
 <20220507045731.19495-1-powen.kao@mediatek.com>
From:   Po-Wen Kao <powen.kao@mediatek.com>
Message-ID: <5039606d-1dad-2a76-78fc-af416abe4d1e@mediatek.com>
Date:   Mon, 9 May 2022 10:57:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220507045731.19495-1-powen.kao@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update missing cover letter

V2 changes
- Cleaner code path as suggested. e.g. return directly
- Wrap clk_set_rate() with ufshcd_clk_set_rate() to check on "scalable".

On 5/7/22 12:57 PM, Po-Wen Kao wrote:
> In clk scaling, clk_set_rate is invoked to set dedicated PLL clk rate
> on scale up and down. On some MTK platform, scaling is only possible
> by switching parent of a mux, therefore we introduce a new
> "clock-scalable" property to gain fine control over which clock rate can
> be scaled by calling clk_set_rate. If a clock is defined as non-scalable,
> clk_set_rate won't be invoked while clki->current_rate is still updated
> if min/max freq is defined. Customized clk operation may be embedded in
> pre/post change of hba->vops->clk_scale_notify.
>
> All clocks in dts without "clock-scalable" property defined are assumed
> scalable and works as usual. There is no neeed to make change on existing
> dts.
>
> To specify scalable property, one may define dts as follow
>
> &ufshci {
>      clocks =
>          <clk1>,
>          <clk2>,
>          ...
>          <clkn>;
>
>      clock-names =
>          "clk1",
>          "clk2",
>          ...
>          "clkn";
>
>      freq-table-hz =
>          <1000 2000>,
>          <0 0>,
>          ...
>          <0 0>;
>
>      clock-scalable =
>          <0
>           0
>           ...
>           0
>          >;
> };
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> ---
>   drivers/scsi/ufs/ufshcd-pltfrm.c | 96 +++++++++++++++++++++++---------
>   drivers/scsi/ufs/ufshcd.c        | 54 +++++++-----------
>   drivers/scsi/ufs/ufshcd.h        |  2 +
>   include/trace/events/ufs.h       | 16 +++---
>   4 files changed, 102 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index 87975d1a21c8..5f95bb519485 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -18,6 +18,56 @@
>   
>   #define UFSHCD_DEFAULT_LANES_PER_DIRECTION		2
>   
> +/**
> + * ufshcd_get_clk_u32_array - Resolve property in dts to u32 array with
> + * shape check.
> + * @hba: per-adapter instance
> + * @propname: name of property
> + * @cols: column count
> + * @rows: calculated row count with given cols
> + * @array: u32 array pointer of property data with propname
> + */
> +static int ufshcd_get_clk_u32_array(struct ufs_hba *hba, const char *propname,
> +				    size_t cols, size_t *rows, u32 **array)
> +{
> +	struct device *dev = hba->dev;
> +	struct device_node *np = dev->of_node;
> +	int len = 0, ret = 0;
> +	int _rows = 0;
> +
> +	if (!of_get_property(np, propname, &len)) {
> +		dev_warn(dev, "%s property not specified.\n", propname);
> +		return -EINVAL;
> +	}
> +
> +	len = len / sizeof(**array);
> +	if (!cols || !len || len % cols != 0) {
> +		dev_warn(dev, "%s property define error.\n", propname);
> +		return -EINVAL;
> +	}
> +	_rows = len / cols;
> +
> +	*array = devm_kcalloc(dev, len, sizeof(**array), GFP_KERNEL);
> +	if (!*array) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = of_property_read_u32_array(np, propname, *array, len);
> +	if (ret) {
> +		dev_err(dev, "%s: error reading array %d\n",
> +			propname, ret);
> +		goto out;
> +	}
> +
> +	*rows = _rows;
> +
> +	return 0;
> +out:
> +	devm_kfree(dev, *array);
> +	return ret;
> +}
> +
>   static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>   {
>   	int ret = 0;
> @@ -27,13 +77,14 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>   	struct device_node *np = dev->of_node;
>   	char *name;
>   	u32 *clkfreq = NULL;
> +	u32 *scalable = NULL;
>   	struct ufs_clk_info *clki;
> -	int len = 0;
>   	size_t sz = 0;
>   
>   	if (!np)
>   		goto out;
>   
> +	/* clock-names */
>   	cnt = of_property_count_strings(np, "clock-names");
>   	if (!cnt || (cnt == -EINVAL)) {
>   		dev_info(dev, "%s: Unable to find clocks, assuming enabled\n",
> @@ -47,37 +98,29 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>   	if (cnt <= 0)
>   		goto out;
>   
> -	if (!of_get_property(np, "freq-table-hz", &len)) {
> -		dev_info(dev, "freq-table-hz property not specified\n");
> +	/* clock-scalable (optional) */
> +	ret = ufshcd_get_clk_u32_array(hba, "clock-scalable", 1, &sz, &scalable);
> +	if (ret) {
> +		dev_warn(dev, "Optional property %s load failed. Assume all clocks scalable.\n",
> +			 "clock-scalable");
> +	} else if (sz != cnt) {
> +		dev_err(dev, "%s len mismatch\n", "clock-scalable");
> +		ret = -EINVAL;
>   		goto out;
>   	}
>   
> -	if (len <= 0)
> +	/* freq-table-hz */
> +	ret = ufshcd_get_clk_u32_array(hba, "freq-table-hz", 2, &sz, &clkfreq);
> +	if (ret) {
> +		dev_err(dev, "Property %s load failed.", "freq-table-hz");
>   		goto out;
> -
> -	sz = len / sizeof(*clkfreq);
> -	if (sz != 2 * cnt) {
> +	} else if (sz != cnt) {
>   		dev_err(dev, "%s len mismatch\n", "freq-table-hz");
>   		ret = -EINVAL;
>   		goto out;
>   	}
>   
> -	clkfreq = devm_kcalloc(dev, sz, sizeof(*clkfreq),
> -			       GFP_KERNEL);
> -	if (!clkfreq) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	ret = of_property_read_u32_array(np, "freq-table-hz",
> -			clkfreq, sz);
> -	if (ret && (ret != -EINVAL)) {
> -		dev_err(dev, "%s: error reading array %d\n",
> -				"freq-table-hz", ret);
> -		return ret;
> -	}
> -
> -	for (i = 0; i < sz; i += 2) {
> +	for (i = 0; i < cnt * 2; i += 2) {
>   		ret = of_property_read_string_index(np,
>   				"clock-names", i/2, (const char **)&name);
>   		if (ret)
> @@ -92,6 +135,7 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>   		clki->min_freq = clkfreq[i];
>   		clki->max_freq = clkfreq[i+1];
>   		clki->name = devm_kstrdup(dev, name, GFP_KERNEL);
> +		clki->scalable = scalable ? !!scalable[i / 2] : true;
>   		if (!clki->name) {
>   			ret = -ENOMEM;
>   			goto out;
> @@ -99,11 +143,13 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>   
>   		if (!strcmp(name, "ref_clk"))
>   			clki->keep_link_active = true;
> -		dev_dbg(dev, "%s: min %u max %u name %s\n", "freq-table-hz",
> -				clki->min_freq, clki->max_freq, clki->name);
> +		dev_dbg(dev, "clk %s: scalable(%u), min(%u), max(%u)\n",
> +			clki->name, clki->scalable, clki->min_freq, clki->max_freq);
>   		list_add_tail(&clki->list, &hba->clk_list_head);
>   	}
>   out:
> +	devm_kfree(dev, scalable);
> +	devm_kfree(dev, clkfreq);
>   	return ret;
>   }
>   
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index eea5af5fa166..8dbae2f73329 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -939,6 +939,11 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
>   		return false;
>   }
>   
> +static inline int ufshcd_clk_set_rate(struct ufs_clk_info *clki, unsigned long rate)
> +{
> +	return clki->scalable ? clk_set_rate(clki->clk, rate) : 0;
> +}
> +
>   /**
>    * ufshcd_set_clk_freq - set UFS controller clock frequencies
>    * @hba: per adapter instance
> @@ -950,6 +955,7 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
>   static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
>   {
>   	int ret = 0;
> +	u32 target_rate = 0;
>   	struct ufs_clk_info *clki;
>   	struct list_head *head = &hba->clk_list_head;
>   
> @@ -958,41 +964,23 @@ static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
>   
>   	list_for_each_entry(clki, head, list) {
>   		if (!IS_ERR_OR_NULL(clki->clk)) {
> -			if (scale_up && clki->max_freq) {
> -				if (clki->curr_freq == clki->max_freq)
> -					continue;
> -
> -				ret = clk_set_rate(clki->clk, clki->max_freq);
> -				if (ret) {
> -					dev_err(hba->dev, "%s: %s clk set rate(%dHz) failed, %d\n",
> -						__func__, clki->name,
> -						clki->max_freq, ret);
> -					break;
> -				}
> -				trace_ufshcd_clk_scaling(dev_name(hba->dev),
> -						"scaled up", clki->name,
> -						clki->curr_freq,
> -						clki->max_freq);
> -
> -				clki->curr_freq = clki->max_freq;
> +			target_rate = scale_up ? clki->max_freq : clki->min_freq;
>   
> -			} else if (!scale_up && clki->min_freq) {
> -				if (clki->curr_freq == clki->min_freq)
> -					continue;
> +			if (!target_rate || clki->curr_freq == target_rate)
> +				continue;
>   
> -				ret = clk_set_rate(clki->clk, clki->min_freq);
> -				if (ret) {
> -					dev_err(hba->dev, "%s: %s clk set rate(%dHz) failed, %d\n",
> -						__func__, clki->name,
> -						clki->min_freq, ret);
> -					break;
> -				}
> -				trace_ufshcd_clk_scaling(dev_name(hba->dev),
> -						"scaled down", clki->name,
> -						clki->curr_freq,
> -						clki->min_freq);
> -				clki->curr_freq = clki->min_freq;
> +			ret = ufshcd_clk_set_rate(clki, target_rate);
> +			if (ret) {
> +				dev_err(hba->dev, "%s: %s clk set rate(%dHz) failed, %d\n",
> +					__func__, clki->name,
> +					target_rate, ret);
> +				break;
>   			}
> +			trace_ufshcd_clk_scaling(dev_name(hba->dev),
> +						 clki->name, scale_up,
> +						 clki->curr_freq,
> +						 target_rate);
> +			clki->curr_freq = target_rate;
>   		}
>   		dev_dbg(hba->dev, "%s: clk: %s, rate: %lu\n", __func__,
>   				clki->name, clk_get_rate(clki->clk));
> @@ -8364,7 +8352,7 @@ static int ufshcd_init_clocks(struct ufs_hba *hba)
>   			ufshcd_parse_dev_ref_clk_freq(hba, clki->clk);
>   
>   		if (clki->max_freq) {
> -			ret = clk_set_rate(clki->clk, clki->max_freq);
> +			ret = ufshcd_clk_set_rate(clki, clki->max_freq);
>   			if (ret) {
>   				dev_err(hba->dev, "%s: %s clk set rate(%dHz) failed, %d\n",
>   					__func__, clki->name,
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 1637f5cc1420..eaa3d6c5b9ab 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -260,6 +260,7 @@ struct ufs_dev_cmd {
>    * @keep_link_active: indicates that the clk should not be disabled if
>   		      link is active
>    * @enabled: variable to check against multiple enable/disable
> + * @scalable: indicates if clk is scalable in clk scaling
>    */
>   struct ufs_clk_info {
>   	struct list_head list;
> @@ -270,6 +271,7 @@ struct ufs_clk_info {
>   	u32 curr_freq;
>   	bool keep_link_active;
>   	bool enabled;
> +	bool scalable;
>   };
>   
>   enum ufs_notify_change_status {
> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
> index 599739ee7b20..780c964e52c2 100644
> --- a/include/trace/events/ufs.h
> +++ b/include/trace/events/ufs.h
> @@ -103,30 +103,30 @@ TRACE_EVENT(ufshcd_clk_gating,
>   
>   TRACE_EVENT(ufshcd_clk_scaling,
>   
> -	TP_PROTO(const char *dev_name, const char *state, const char *clk,
> -		u32 prev_state, u32 curr_state),
> +	TP_PROTO(const char *dev_name, const char *clk,
> +		 bool up, u32 prev_state, u32 curr_state),
>   
> -	TP_ARGS(dev_name, state, clk, prev_state, curr_state),
> +	TP_ARGS(dev_name, clk, up, prev_state, curr_state),
>   
>   	TP_STRUCT__entry(
>   		__string(dev_name, dev_name)
> -		__string(state, state)
>   		__string(clk, clk)
> +		__field(bool, up)
>   		__field(u32, prev_state)
>   		__field(u32, curr_state)
>   	),
>   
>   	TP_fast_assign(
>   		__assign_str(dev_name, dev_name);
> -		__assign_str(state, state);
>   		__assign_str(clk, clk);
> +		__entry->up = up;
>   		__entry->prev_state = prev_state;
>   		__entry->curr_state = curr_state;
>   	),
>   
> -	TP_printk("%s: %s %s from %u to %u Hz",
> -		__get_str(dev_name), __get_str(state), __get_str(clk),
> -		__entry->prev_state, __entry->curr_state)
> +	TP_printk("%s: scaled %s %s from %u to %u Hz",
> +		  __get_str(dev_name), __entry->up ? "up" : "down", __get_str(clk),
> +		  __entry->prev_state, __entry->curr_state)
>   );
>   
>   TRACE_EVENT(ufshcd_auto_bkops_state,
