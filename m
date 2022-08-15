Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6855659340B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiHOR2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiHOR2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:28:34 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F26101C8;
        Mon, 15 Aug 2022 10:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofoxVXQOPT4pGqgq19pq8iepkpWGIEFBC9B24iKDFnbBEsPc/rp76sD6kKsLRw1f0GWRoHqHqjYhxb5DMe99pcV020E4k0VRIZS0E9k1rgFl1E9sF+quS5bqVyNylOBi3ndK93uO2zgTwMIZ2YB+UN93enE2eWC3DTTbxNfuS5uTC6KwEkWwrCy0/VtFD2w+wLWQCgJ35wSEbSHamFsGw0aJh5TWU2j5uQni/p49mMYSyzxHHKsUSi/qInyWg1wVUB9PJuXkd0IU78IhcTD8NZPxWg20VkKJ7ToLr1rZzBw7kxgFmhQuHy0k+SwJboufbSrdh62sAMZI+D+B1cLZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF/StlZs/DsHfc59JAafoUieuieC/PDniMaHDHSPLo0=;
 b=WWAC5emLnh8YMm3ySmGBQnI1jI+hRBR5dTgdTfWQpt5bn78LC/OBjyZFOI6HSKi/d3q0IPRBBDRlVSuBKIXxaABX4DoiL5VOjHqhJkY3MSy0S6+W93USp+uO6ppNpn27w0+k01SAl0AI4gjsEX9kkyNvtYHqRWw/jC15BGY5B5Pt1ZvEzAT21yaM859+XLKFtAcdweOtAxL9LzqVL24dcrRx+G+DgdJ2niMmg53nLAabnhbKfdG27XI/Xk+sayt/0wmBAYl3pDX4muiOL/PDYzM4l6pGA3Gg41uREKQ38q3RbJjTaUtRs9HRmYvT0cc/SksCT4Vagd5F/TS4wDgljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF/StlZs/DsHfc59JAafoUieuieC/PDniMaHDHSPLo0=;
 b=QKX3yJxVZtUnlFfN7L364bYMPAGUNduDPoRfFBQ1iMlk9khY87XErhvbnazXsZs4wDarteyIC//J2q8KUUOMmhRGT5tlFnHuijcEeNmOXOE/QrP7EdIuRAiPK/BTJ/U9NIMWB5fe8+xUPirdNWp/YqjtKJtHpTw3elLF9MTvGQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.23; Mon, 15 Aug
 2022 17:28:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%3]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 17:28:16 +0000
Message-ID: <e49679b9-7b5a-5d97-c63f-a6004af0aaaa@amd.com>
Date:   Mon, 15 Aug 2022 12:28:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Content-Language: en-US
To:     Szuying Chen <chensiying21@gmail.com>, gregkh@linuxfoundation.org,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw, Richard Hughes <rhughes@redhat.com>
References: <20220815041145.35629-1-chensiying21@gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220815041145.35629-1-chensiying21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0396.namprd03.prod.outlook.com
 (2603:10b6:610:11b::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4c00961-bf1d-4a50-63be-08da7ee389a8
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myeg+WzrQV5dQ9utzaNemav3Nhp4k8OZL9xHuq5mAzYa+VFweG3niTy0PBjYYTZ4sgwqR6RHb58RDKLxmf90aQ9Tl9ljBAK+poJLgH5uAaL0y0uTdlfHwVOlCGWaEKtyikttZhaGIzedQwFtcAFkNVFFNMyyd9sel/lmGlsW0zXfhg67SS5uiUKXCLcCfCLEhesY7pd0FBj4YjmDetS6thGIpw4l9QVvLcvRJ05A4yYVT7Yrr6KyTNIBA7/cjLrInshbDyoyS3Lvxo7+X/aa52sX9Xo76O/G7n6cll03RcCdaAqDPZfmGqdQGwY5QMxP6nN0TGaZYhrqnaKHI8yHKoICgDG2cNkQOJSBSDunHVLz4xgKzImoXlQspJ131Fomxo0tS7oR9idvKVLdp1/fi2kz6kO5HZEb3cldLeKEYJgj0GSVSqrM4rJCEoojl6ptv7L3qhfKcNoheMRD234OQWh+2ixMULjiyJR+zP3RfbSouFK+pqvDNCTB5TVuqHltkz2EO5I1mbcKqrSmyiNBRDkXBiBeWaO+SvH7ZU410XJAqgBbVYBHPw3RKOwTOk8pVJ/zQkvUhDqWPLgZld4LT8ai1bIoSWaXr9uIZGKhm62GWuAiy/YUZh+nrOcd1il5mzeYpGC6YD8K/0CoGmQhdilphXI7SkKr7eZuNmpt3a/PsV/IDtM/lghbT/tdRpFDK9OYeDV+A9jE9JT8YSujOWRmWvY7crM0PL4MZeXiEyboGVKZ08Y/xZlM3aw9CiFYWOusCTMZNsYWmoH2+DadhczmV+R+LfKEVRF/LHaU1BEQ7cEKOCzFuPc/al8iRLlsd7O2VUiwEtTw4yK1tPbIeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(31696002)(83380400001)(86362001)(38100700002)(66946007)(8676002)(4326008)(66556008)(66476007)(316002)(2906002)(8936002)(5660300002)(7416002)(26005)(6512007)(6666004)(53546011)(6506007)(2616005)(186003)(41300700001)(478600001)(6486002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJIVDFzV0MyUExDZmhkMGxraTJ3QW92NE5NT1FONlFYK25XYVdDa2xPR0Rt?=
 =?utf-8?B?OGpPbUt2KzNoOVUrLzRYNitzRmNmVllibUJJa08rNWlIZnV5K2F3NXdOcVR2?=
 =?utf-8?B?VzduZnFxWmRWakwzdUhhbDg3STFjZUVSTFlnNFZSRlJJMFRiYWdGZzUrcHZT?=
 =?utf-8?B?YmZpdnd3YnQ0NUp2bFZTSktBSjNjU0ZLOXQzeGFmQTliQS94UkZaOFh6Q1B3?=
 =?utf-8?B?TVFLMWVSL1g3ekl4a09oRVF4V3pDU0hzT0VqOHp0NTZwVnFYWXJFQVY0WHlK?=
 =?utf-8?B?aVNIS0F3QXJxeU0wM0FRREp3ZE93TFJpQUZSUCt1ZEM5bzBFV0dibUNpQ2cz?=
 =?utf-8?B?YmkrT3VaakM2V0pmNUpEY2Z4WWxFd0RleCtSeEN4SWE5SW5OVWdCVkVQU0d4?=
 =?utf-8?B?SW5wUkxtcWZ0SWsvaDFsV1hTRmwxcnBUVlZXVm5HTzlha2YySWgzaVBJbE1l?=
 =?utf-8?B?ZXgwbGIramM0RHkvL00yd21nb0tzd3RWZFZTcXdneGRwZEU4cWE1ZDh1d2to?=
 =?utf-8?B?bitRblYrYXQzZFo1bU9RN1ZEZGo5Yk9uWEYxelE0ZStuM3lpS0VNZVF6aUkx?=
 =?utf-8?B?dStoTmk3dXk1Q2NvWHVxRWNidGVSM3BNdVpDbXlDN0pGQVkyU3F1YnNSSEow?=
 =?utf-8?B?Ym1nOG4vMDVhREdkRzhNZkpBcmpvMnNmNHpyTTIzdjJTRHR2cGpLYzFZcXRm?=
 =?utf-8?B?cjFpOXJqaFE1YkpqZUlGQjkwakQvWmJUVWN6RjB5UFFPS2xhTEdaL2xlQU5r?=
 =?utf-8?B?cDFIT1IraWEvM0F3aC9yUUFVTm1YaFhHUit1ZVNyRHdXbFl4dG53WDZNRFFG?=
 =?utf-8?B?TDAyMmxVVGJtaGdtbWoveEtieGtVWDJwdmR3YWh3K09KZVFhYzVRZWdnZ2lT?=
 =?utf-8?B?dmNZWXZBakVRU0VOZWhydktNRUkwRWplbnJsSmllM1dkR0xLanNrd1kxYWtX?=
 =?utf-8?B?VlF2RG9nRnBtNE02N05jMTlvS3ppWVZldEtINEtyZFJTMWt6WFVyS3pCRmdD?=
 =?utf-8?B?eWx6ZGNsVk0yWSt0a1FxV0pySFVxYkRiMWd3eHhBV1B2QnBIMmlhMnBqWTB6?=
 =?utf-8?B?djhKaG84Z0VPRXZ3ZUNUMVF0bHg0NkV2dEpDN3ZwOExuOTJLVTBYUzVMVGRu?=
 =?utf-8?B?SFkzS244Y2hyUUJZMEc5T0ZzejRJdnJwc3phbTgwSTV0ZkRhbDZPS1VURm1i?=
 =?utf-8?B?dGdSTllmMGJQNVpmWWs2VXczSjJoZ1c2Sktic3JCVjdqSzF5OURsUHVZSGVp?=
 =?utf-8?B?aE80RUFxVFcrYnVDNUl5ekpyd2MvdWRXd2tjV014L3I2S1FSNVoyczJicGh4?=
 =?utf-8?B?MENHNzlLK1lCOGVRcW5XRE9kcXpXMnBCMk5hejdLQ3BFQVVHY0RyREVNNTdj?=
 =?utf-8?B?dDM3c1BocXVzdGl6M3NpZEFlM3FzdnZPUzlzUmk5MmlLQ25adi9QMTU0a25a?=
 =?utf-8?B?cUxORllXS3A5VEtjUjZ6enRmbkFVdmRTWlBpSEQ5emdmVnBIdi9rVWo4UFVi?=
 =?utf-8?B?ZzRTM3B1VGVLMVNNY2RlQmtQYzB6WmMzcE16VTNMT0NGMmkzdnAwWE1tRmpq?=
 =?utf-8?B?WTJ6empGR2lyVitNVk83TDU1V2g0VWN3N0dBbmJoY2RldEFrLytDanRIalBq?=
 =?utf-8?B?UlVldzhSNEhqNGdnZ2hiSDJZdW1KckJyc0RBZENDY2loUXNMV0Q1bytSdnd0?=
 =?utf-8?B?U0RXUnZVWGU3SGF2N0RTaVdjOTJCUm1aL1VQcys3eWNrQkRFSk54WEh0RXEv?=
 =?utf-8?B?THR3ZTQzNXZkK2NFMlRRZWVnenVUUDNyWGgwaXJFbjJtV3EzbVM1RmNpQ01F?=
 =?utf-8?B?NXBlMVZwck5IVTQxOUdJQUprMC85Q3I4RzNMTStVV0lEclVBV2lZRDM3TFh2?=
 =?utf-8?B?Smd4anpncEtWMWF6NUxZbWVqbG40QXRjVk5MWWZkNUZoK1ZZMGpaSGNhMGVp?=
 =?utf-8?B?Zk5EYnN2VXhYU1JLd3RLdUFoeHVUamNSU1dWNnJJblFoZllQNGRjZGs3M291?=
 =?utf-8?B?Y0liMTFTWmt2cDUxRlFLUmJtS2VFNHcvNWZUNkxCZGVMS1hiU25Mc3lZNWZ4?=
 =?utf-8?B?Mi9BVENoVUdjUEJhYlYzRzQ5a1lDeXBVOFBwSUFnOERjY1lTdzgvV0t3ekJO?=
 =?utf-8?Q?ugvaAPjZPFgUZqkla8GoWWJwg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c00961-bf1d-4a50-63be-08da7ee389a8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 17:28:16.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQA7xuKhjga/D2bRAZiQcHr8jgJdVgCpD6C+jNaJhJSxNdGe1mnSMd0n6QTq5jHP1VyQjcCUWqNQfPUU8j7J8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+hughsie for additional comments

Various inline comments below.

On 8/14/2022 23:11, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch add tb_nvm_validate() contain an array that has functions
> pointers to asmedia_nvm_validate().
> And asmedia_nvm_validate() that recognize supported vendor works in one
> of the following cases:
> Case nvm_upgrade: enable nvm's attribute by setting no_nvm_upgrade
> flag to create nvm_authenticate file node.
> Case nvm_add:add active/non-active NVM devices.
> Case nvm_write:update firmware to non-ative NVM device.
> 
> Our patches were through checkpatch.pl. But the file(switch.c.)
> have existed 13 warning before we patch it.

Please feel free to add other patches to the series to clean up 
warnings.  Just because you didn't introduce them doesn't mean you can't 
fix them =)

> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
>   drivers/thunderbolt/nvm.c    | 147 +++++++++++++++++++++++++++++++++++
>   drivers/thunderbolt/switch.c |  17 ++++
>   drivers/thunderbolt/tb.h     |  18 +++++
>   3 files changed, 182 insertions(+)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index b3f310389378..6db2034ec8e5 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -9,11 +9,158 @@
>   #include <linux/idr.h>
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
> +#include <linux/pm_runtime.h>
> 
>   #include "tb.h"
> 
>   static DEFINE_IDA(nvm_ida);
> 
> +static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
> +			      size_t bytes)
> +{
> +	struct tb_nvm *nvm = priv;
> +	struct tb_switch *sw = tb_to_switch(nvm->dev);
> +	int ret;
> +
> +	pm_runtime_get_sync(&sw->dev);
> +	if (!mutex_trylock(&sw->tb->lock)) {
> +		ret = restart_syscall();
> +		goto out;
> +	}
> +	ret = usb4_switch_nvm_read(sw, offset, val, bytes);
> +	mutex_unlock(&sw->tb->lock);
> +
> +out:
> +	pm_runtime_mark_last_busy(&sw->dev);
> +	pm_runtime_put_autosuspend(&sw->dev);
> +
> +	return ret;
> +}
> +
> +static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
> +			       size_t bytes)
> +{
> +	struct tb_nvm *nvm = priv;
> +	struct tb_switch *sw = tb_to_switch(nvm->dev);
> +	int ret;
> +
> +	if (!mutex_trylock(&sw->tb->lock))
> +		return restart_syscall();
> +
> +	/*
> +	 * Since writing the NVM image might require some special steps,
> +	 * for example when CSS headers are written, we cache the image
> +	 * locally here and handle the special cases when the user asks
> +	 * us to authenticate the image.
> +	 */
> +	ret = tb_nvm_write_buf(nvm, offset, val, bytes);
> +	mutex_unlock(&sw->tb->lock);
> +
> +	return ret;
> +}
> +
> +static int asmedia_nvm_validate(struct tb_switch *sw, unsigned int mode)
> +{
> +	struct tb_nvm *nvm;
> +	u32 val;
> +	u32 nvm_size;
> +	int ret = 0;
> +	unsigned int image_size;
> +	const u8 *buf = sw->nvm->buf;
> +
> +	switch (mode) {
> +	case nvm_upgrade:
> +		if (sw->no_nvm_upgrade)
> +			sw->no_nvm_upgrade = false;
> +
> +		break;
> +
> +	case nvm_add:
> +		nvm = tb_nvm_alloc(&sw->dev);
> +		if (IS_ERR(nvm)) {
> +			ret = PTR_ERR(nvm);
> +			break;
> +		}
> +
> +		ret = usb4_switch_nvm_read(sw, NVM_Date, &val, sizeof(val));
> +		if (ret)
> +			break;
> +
> +		nvm->nvm_asm.date = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> +		ret = usb4_switch_nvm_read(sw, NVM_CUSTOMER_ID, &val, sizeof(val));
> +		if (ret)
> +			break;
> +
> +		nvm->nvm_asm.customerID = (((u8)val) << 0x8 | ((u8)(val >> 0x8)));
> +		nvm->nvm_asm.version = (u8)(val >> 0x10);
> +		nvm_size = SZ_512K;
> +		ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
> +		if (ret)
> +			break;
> +
> +		ret = tb_nvm_add_non_active(nvm, NVM_MAX_SIZE, tb_switch_nvm_write);
> +		if (ret)
> +			break;
> +
> +		sw->nvm = nvm;
> +		break;
> +
> +	case nvm_write:
> +		if (!buf) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		image_size = sw->nvm->buf_data_size;
> +		if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
> +		if (!ret)
> +			sw->nvm->flushed = true;
> +
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	if ((mode == nvm_add) && (ret != 0))
> +		tb_nvm_free(sw->nvm);
> +
> +	return ret;
> +}
> +
> +struct tb_nvm_id {
> +	u16 hw_vendor_id;
> +	int (*validate)(struct tb_switch *sw, unsigned int handle);
> +};
> +
> +static const struct tb_nvm_id tb_nvm_vendors[] = {
> +	/* ASMedia software CM firmware upgrade */
> +	{ 0x174c, asmedia_nvm_validate },
> +};
> +
> +/**
> + * tb_nvm_vendor_handle() - support vendor's NVM format
> + * @sw: Thunderbolt switch
> + * @handle: 0:NvmUpgradeSuppport, 1:NvmAdd, 2:NvmWrite
> + */
> +int tb_nvm_validate(struct tb_switch *sw, unsigned int mode)
> +{
> +	int res, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tb_nvm_vendors); i++) {
> +		const struct tb_nvm_id *id = &tb_nvm_vendors[i];
> +
> +		if (id->hw_vendor_id && id->hw_vendor_id != sw->config.vendor_id)
> +			continue;
> +
> +		 res = id->validate(sw, mode);
> +	}
> +	return res;
> +}
> +
>   /**
>    * tb_nvm_alloc() - Allocate new NVM structure
>    * @dev: Device owning the NVM
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 244f8cd38b25..352e64f3dc92 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -114,6 +114,14 @@ static int nvm_validate_and_write(struct tb_switch *sw)
>   	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
>   		return -EINVAL;
> 
> +	/*
> +	 * Vendor's nvm write. If the image has been flushed to the
> +	 * storage are, nvm write is complete.
> +	 */
> +	ret = tb_nvm_validate(sw, nvm_write);
> +	if (sw->nvm->flushed)
> +		return ret;
> +
>   	/*
>   	 * FARB pointer must point inside the image and must at least
>   	 * contain parts of the digital section we will be reading here.
> @@ -390,6 +398,11 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
>   	if (!nvm_readable(sw))
>   		return 0;
> 
> +	/* Vendor's NVM formats add */
> +	ret = tb_nvm_validate(sw, nvm_add);
> +	if (ret)
> +		return ret;
> +
>   	/*
>   	 * The NVM format of non-Intel hardware is not known so
>   	 * currently restrict NVM upgrade for Intel hardware. We may

This comment should be adjusted as after your patch lands both Intel and 
ASMedia formats are known and included.

> @@ -1953,6 +1966,9 @@ static ssize_t nvm_version_show(struct device *dev,
>   		ret = -ENODATA;
>   	else if (!sw->nvm)
>   		ret = -EAGAIN;
> +	/*ASMedia NVM version show format xxxxxx_xxxx_xx */
> +	else if (sw->config.vendor_id == 0x174C)
> +		ret = sprintf(buf, "%06x_%04x_%02x\n", sw->nvm->nvm_asm.date, sw->nvm->nvm_asm.customerID, sw->nvm->nvm_asm.version);

Are you hard-pressed to use this specific format for the string?  I feel 
like it's overloading the definition of a version string quite a bit.

I also worry that userspace has come to expect "major.minor" for this 
and making your string use 2 decimals may mean more deviations for 
userspace too.

Perhaps should you just export it instead as:

"%02x.%06x", sw->nvm->nvm_asm.version, sw->nvm->nvm_asm.date

And move the customer ID into another sysfs file?  I would think this 
fits pretty well with the existing "vendor" or "device" sysfs file 
depending upon it's meaning.

If you do end up having a strong reason for deviating the version string 
format, then I think you should document both what the Intel format is 
(major.minor) and your format explicitly in 
Documentation/admin-guide/thunderbolt.rst.

>   	else
>   		ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);
> 
> @@ -2860,6 +2876,7 @@ int tb_switch_add(struct tb_switch *sw)
>   		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
> 
>   		tb_check_quirks(sw);
> +		tb_nvm_validate(sw, nvm_upgrade);
> 
>   		ret = tb_switch_set_uuid(sw);
>   		if (ret) {
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 5db76de40cc1..7f20f10352d9 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -28,6 +28,22 @@
>   #define NVM_VERSION		0x08
>   #define NVM_FLASH_SIZE		0x45
> 
> +/* ASMedia specific NVM offsets */
> +#define NVM_Date	0x1c
> +#define NVM_CUSTOMER_ID	0x28
> +
> +/* ASMedia specific validation mode */
> +#define nvm_upgrade 0
> +#define nvm_add 1
> +#define nvm_write 2

As all of these values are ASMedia specific, I think the #defines should 
have ASMEDIA in the name.  I know Greg mentioned to roll into an enum, 
and I think you still can but make it something like:

#define ASMEDIA_NVM_DATE	0x1c
#define ASMEDIA_NVM_CUSTOMER_ID	0x28
enum asmeda_nvm_ops {
	ASMEDIA_NVM_UPGRADE = 0,
	ASMEDIA_NVM_ADD = 1,
	ASMEDIA_NVM_WRITE = 2,
};

> +
> +struct nvm_asmedia {
> +	u32 date;
> +	u32 customerID:16;
> +	u32 version:8;
> +	u32 reserved:8;
> +};
> +
>   /**
>    * struct tb_nvm - Structure holding NVM information
>    * @dev: Owner of the NVM
> @@ -57,6 +73,7 @@ struct tb_nvm {
>   	size_t buf_data_size;
>   	bool authenticating;
>   	bool flushed;
> +	struct nvm_asmedia nvm_asm;

Furthermore if you follow my suggestion on how to encode the version you 
can re-use the 'major' and 'minor' members from this struct and don't 
need to deviate in any way from it for your data.

* Major would map to your "version".
* Minor would map to "date".

You could instead then store the customer ID into the switches vendor ID 
or device ID member (whichever makes more sense).

>   };
> 
>   enum tb_nvm_write_ops {
> @@ -736,6 +753,7 @@ static inline void tb_domain_put(struct tb *tb)
>   	put_device(&tb->dev);
>   }
> 
> +int tb_nvm_validate(struct tb_switch *sw, unsigned int mode);
>   struct tb_nvm *tb_nvm_alloc(struct device *dev);
>   int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
>   int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
> --
> 2.34.1
> 
> 

