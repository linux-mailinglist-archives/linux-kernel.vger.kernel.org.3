Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846065ACE95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiIEJMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiIEJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:12:10 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE9A2C679;
        Mon,  5 Sep 2022 02:12:08 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2859BWsh054217;
        Mon, 5 Sep 2022 04:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662369092;
        bh=xPTLqrQR3yIKqIqKWHosRsUm1HcTbEMKjHEpKqe7jKM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=IXJ3+JlrONZZR2/GyHWJvowE4mQLyoL8k0yMJpEF4ofq2pVY02HEiKhr+nf+hjkgw
         7z+vnMEkminkShYBDlldmCE0NnawGzdVY3CPbEF7tslF8TLORQpavO2KKGCzwVwkI+
         jrysfoNv9IBPF7Ds2AkPRVEyy//UfaKhC4tmChi8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2859BWQ7099534
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Sep 2022 04:11:32 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 5 Sep
 2022 04:11:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 5 Sep 2022 04:11:31 -0500
Received: from [10.24.69.114] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2859BRHR065852;
        Mon, 5 Sep 2022 04:11:28 -0500
Message-ID: <49d1959e-88ae-c605-aafc-ca9819c4f85c@ti.com>
Date:   Mon, 5 Sep 2022 14:41:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 6/6] remoteproc: pru: add support for configuring GPMUX
 based on client setup
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <s-anna@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <rogerq@kernel.org>,
        <grygorii.strashko@ti.com>, <vigneshr@ti.com>, <kishon@ti.com>,
        <robh@kernel.org>
References: <20220607045650.4999-1-p-mohan@ti.com>
 <20220607045650.4999-7-p-mohan@ti.com> <20220719161625.GB3393732@p14s>
From:   Md Danish Anwar <a0501179@ti.com>
In-Reply-To: <20220719161625.GB3393732@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 19/07/22 21:46, Mathieu Poirier wrote:
> On Tue, Jun 07, 2022 at 10:26:50AM +0530, Puranjay Mohan wrote:
>> From: Tero Kristo <t-kristo@ti.com>
>>
>> Client device node property ti,pruss-gp-mux-sel can now be used to
>> configure the GPMUX config value for PRU.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> [s-anna@ti.com: simplify the pru id usage]
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>> ---
>> V4->v5
>> * This patch was included in v4 and had some checkpatch errors that have
>>   been resolved in v5
>> ---
>>  drivers/remoteproc/pru_rproc.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
>> index 2977eb50631b..f2c6c55f0f20 100644
>> --- a/drivers/remoteproc/pru_rproc.c
>> +++ b/drivers/remoteproc/pru_rproc.c
>> @@ -123,6 +123,7 @@ struct pru_private_data {
>>   * @dbg_single_step: debug state variable to set PRU into single step mode
>>   * @dbg_continuous: debug state variable to restore PRU execution mode
>>   * @evt_count: number of mapped events
>> + * @gpmux_save: saved value for gpmux config
>>   */
>>  struct pru_rproc {
>>  	int id;
>> @@ -141,6 +142,7 @@ struct pru_rproc {
>>  	u32 dbg_single_step;
>>  	u32 dbg_continuous;
>>  	u8 evt_count;
>> +	u8 gpmux_save;
>>  };
>>  
>>  static inline u32 pru_control_read_reg(struct pru_rproc *pru, unsigned int reg)
>> @@ -250,6 +252,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
>>  	struct device *dev;
>>  	const char *fw_name;
>>  	int ret;
>> +	u32 mux;
>>  
>>  	try_module_get(THIS_MODULE);
>>  
>> @@ -273,6 +276,22 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
>>  
>>  	mutex_unlock(&pru->lock);
>>  
>> +	ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
>> +	if (ret) {
>> +		dev_err(dev, "failed to get cfg gpmux: %d\n", ret);
>> +		goto err;
>> +	}
>> +
>> +	ret = of_property_read_u32_index(np, "ti,pruss-gp-mux-sel", index,
>> +					 &mux);
>> +	if (!ret) {
>> +		ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
>> +		if (ret) {
>> +			dev_err(dev, "failed to set cfg gpmux: %d\n", ret);
>> +			goto err;
>> +		}
>> +	}
>> +
>>  	if (pru_id)
>>  		*pru_id = pru->id;
>>  
>> @@ -310,6 +329,7 @@ void pru_rproc_put(struct rproc *rproc)
>>  
>>  	pru = rproc->priv;
>>  
>> +	pruss_cfg_set_gpmux(pru->pruss, pru->id, pru->gpmux_save);
>>  	pru_rproc_set_firmware(rproc, NULL);
>>
> 
>   CC      drivers/remoteproc/pru_rproc.o
> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c: In function ‘pru_rproc_get’:
> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:279:8: error: implicit declaration of function ‘pruss_cfg_get_gpmux’ [-Werror=implicit-function-declaration]
>   279 |  ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
>       |        ^~~~~~~~~~~~~~~~~~~
> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:288:9: error: implicit declaration of function ‘pruss_cfg_set_gpmux’ [-Werror=implicit-function-declaration]
>   288 |   ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
>       |         ^~~~~~~~~~~~~~~~~~~
> 
> I get this on both rproc-next and today's linux next.  

This patch is dependent on the series [2] Introduce PRU platform consumer API
https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/
as the api pruss_cfg_get_gpmux calls the api pruss_cfg_read and the api
pruss_cfg_set_gpmux calls the api pruss_cfg_update which are implemented by the
patch "soc: ti: pruss: Add pruss_cfg_read()/update() API" in the above series.

This error is coming as the dependent patch needs the patch "soc: ti: pruss:
Add pruss_cfg_read()/update() API" to be applied for compilation.

Thanks,
Danish.

> 
>>  	mutex_lock(&pru->lock);
>> -- 
>> 2.17.1
>>
