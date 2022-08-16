Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D75595EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiHPPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiHPPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:08:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C489410A;
        Tue, 16 Aug 2022 08:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dimWYN+yHMiaNa9a5SGPLkrbPZH9uIar1w19cNGRki6Eab3LT5TW0pp1XFhLnsUUFC8ue+dwtiN+93vxOKEz705sr7+rstwwAJlDIUMBA2AOUo4rZkhuo3hYGWlkFdkqMY/wFGDhVo626ZN5QcN24Uj+0wEGn/jJXCCK2zRFtLqOK8eFDWQU2Ui1ckrhE+0pZGezNhDvo8SfEgAIs/ehBAufCjEnQLADlUfWQmI6W4ORc4lpr8Bkbx2DzYaEgxeFKaONODs6WtNZS6xqflckEmLSJsdExldUrdKI5LoEnwVfn6v32KQ+Lz21XUDHUkrpEYryYMqaDnDxH74xDk1otg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8l06BRp3bTneW2TKY8VqZJ1uP/UwNu/bljIfOGaXSg=;
 b=XxIYsnSLpYW0nKOwIp+mcg2OY6sKzwGiYbocWl/1NclHTtjV/1IYqylpeKQfDBSOBCygC0an4Arhg4aV1cR9WWZoNMgrz2QlFdSPxlpBsAL2ZpghS1ZSeuKjXdONxTMr9s6zOxPp5lYqTRqrqnDanNFDLXypSx3wPxhSqZ2K0NrawSoZXh0d/uAC9+8Z5AUl61pGUPkCIgkMf11mxPKFK4Yx2B977S9+cUL5fXpV5/d/CxfizqnkAMtZtGRk+04Mkrp7XUCWgr5chTPLrfYgl7UY12hedgZ5w9h2sBy9c/V0HeYmKf3CnwlKSBl+5OMI49UM/KmW9HJJDz23TwK5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8l06BRp3bTneW2TKY8VqZJ1uP/UwNu/bljIfOGaXSg=;
 b=NUBbQ8NKJWbxZClouL0P/5zq/GTRyufjhm3/rl8oCIkvY8PT7AJtZjR2nUeSrsYpIVWRklde0wTMiGoU25SImNENxoSOs0oNlm/fQIthc0b9bNQokY6zHAm6wS5MuLbc8Su/6Ck8vDcNT98mrvdukaLwjol36CyX3D+j/QZL7pU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 15:05:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%3]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 15:05:48 +0000
Message-ID: <9f5e8abe-7126-ce3b-cab0-29c0b7d3e482@amd.com>
Date:   Tue, 16 Aug 2022 10:05:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4] thunderbolt: thunderbolt: add vendor's NVM formats
Content-Language: en-US
To:     Szuying Chen <chensiying21@gmail.com>, gregkh@linuxfoundation.org,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw, Richard Hughes <rhughes@redhat.com>
References: <20220816105502.9059-1-chensiying21@gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220816105502.9059-1-chensiying21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:610:e6::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 201d4c5a-b480-4341-5a2d-08da7f98cd6d
X-MS-TrafficTypeDiagnostic: SN7PR12MB6765:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roO6eatA27glpBd2busyaSnB2x93AqvtXb4v5BCRsjL+Q3ZPPks/gFxyrP7RMxbWyesEWq+l8WAxcWcY2dHgQwh/3/cs/rYrEkM2vsb8RHERL1NG17AzIkBkP8p/a3fogi5uSkYNd0LN39KscQzximgz0jYq7EZtdQanRUmq0TKS38wEX4uFFW3opbHB43qc1yyTe8CYA4NVzwdDpSG51ssOcxua/yE8kUAgnWk+LkMhXq2RJEmpe88u8oDP22qIMsZGX8dUuPHRld9X/BvpWJsYEkDKIY3Zv1KuWiZ2sTBHK98qyOjAtrp4GSiRRZ8/meFHLNIDvz494ICM5uU/0YRkddKDs3M8C81+eXGUKv+zjEeEKbF0LJttLiACNAV/F+CO09LVO7keIMWekHT9HPFmB14j0fAYCDZ9N77ZADaapjFivwinMP8cyGwA4aenfiRDmEwmXrm95KRNnC+qI8q39C22tHjqx310/z4W3/tAXDbuh+YnUDoVg437nxh5ecB1FbmpTm7abLq4HZwcTMPR4N3Jc329o6jWHDPdct81jMu1W9s2zpCnCkzkaiBOojCu/UjK54cNJnLfTF3c8y06txknW87aJsqVJwfEMNFZg9NikOgCMgsQ8FtZGtgZtxfvH8aw9hWsg6+VbhKQ+TZ4RVcOQLKnmvMYK1UGFiSsyXnZlxTzKA/9T75aAP4d/FJ9G6clCTczrEkDXzO9D6FS7BpmDKyDU6kRazgzRIj2tqNqtwRuONXKlHXU6rzcxHqlrrtL/m+8IimEM8D6w8AwxjIS361PjElcXmlQFsgQ36FOGkytcVQ3Gf3WXKdvJNU4WXohwlFoFfMav7sT9Q+AIM7enIAKh5PeSV5HA1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(38100700002)(478600001)(186003)(8936002)(86362001)(6486002)(966005)(31696002)(66556008)(26005)(53546011)(41300700001)(66476007)(6512007)(66946007)(6506007)(2616005)(316002)(8676002)(4326008)(31686004)(2906002)(7416002)(5660300002)(30864003)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW9BUnZnc2NyTWU2Yzl0NFJpNzFtOTk3ZllROGY1MzlBbENvOHp6ZTEvdjcx?=
 =?utf-8?B?dFI5TFp1ZGlDcHhlSGJBbVc2eFdIUjJzK21MVFlCVUFscXlxeDkrUDBJVlZM?=
 =?utf-8?B?K2d6Zi9wTDlHMlE5cXM1azd2QUw2MFBPZDI5MWtjRk9sc3krMEo2N1lQMEo4?=
 =?utf-8?B?ZElCR3ozUUNkTVREUW9PallCVWozbHVlb2VZNE1PRGpUa2Y5eENydVRtWGZ4?=
 =?utf-8?B?akpRdXl0NDRseEgyQXlmOXBPN2xrb21iV0t1V0dyRE1xZDgwemlWSEZwdHhq?=
 =?utf-8?B?ZUZIS0dxQjNmWDB4RlRUMU9QTFhFUGwzd1pSR2hIakwyYzdMZVZMY25DMVJk?=
 =?utf-8?B?UlN6ZTh6ODBpVTNwT21tRTVkdk0xN2tWSUpkK29HTHZZVzEzYjJmd0o3R3dU?=
 =?utf-8?B?YXdJektvV21KTmRZakhocWpZZWRMaENkaUlUMmpKMmZialo1RkRoaFlhb2NJ?=
 =?utf-8?B?U3o0MFFmblFPT0JjOHBlNEtrNDBDUFMvN2ZTenZ2MnIvVTBqNU1zU2h0WDZZ?=
 =?utf-8?B?Y2JxM3ZDLzcxSm9PS1FaK2hXQjdZNG5ocmN0djRpSTFPUUdHTXVoZXcwQktt?=
 =?utf-8?B?TFhlUTdGYStJK3l5VHVuNFhac0lwaTVQQXJMczcxS1dvUm04cjNUeHZrSlF5?=
 =?utf-8?B?NlVWQjluWDNBeWhjcWFpMGhMeG51aUpmeWdmbW56SzlhSzlLNTVUNHhEdk1n?=
 =?utf-8?B?Ti9ZRVlaMHRnMTltb20wVmdxQ1dxUkJZeVlYaFBrNTlhdE9RdENkNEFsQkRK?=
 =?utf-8?B?VldmMDdORUxGTzFTOVFRUElmdnhRcnZDMyszOVpKWnB3NzlqOCtwNEhTYmtu?=
 =?utf-8?B?RGdGYkNLb1V4VEdDMzVKY2pyc3lxRTV1OW5hS0x0RE8rR1BaaDVqS1VhMzVw?=
 =?utf-8?B?ZThvalZUdGZOZ0pCQlRsRVNFeXZwWUVrVVpYUUpQUGNxMEhTSnVPSVlXZThP?=
 =?utf-8?B?cXBpWUNrUkY3ZkNFM3BJR1RQUGNRVktXRkpobW80MnpteDRhaDFyRkxMdDhJ?=
 =?utf-8?B?SzNoeDEwbkk4RzdHSHdwQURwOFI0dXE0NHp0TGs0R3RIQzNndENQRUZETXAv?=
 =?utf-8?B?SFczN1ZweXU4YXEyMjNGQmo0VmJxa1lEaGMyRnErRTBmbWtTNWNMMmpGZ0Zv?=
 =?utf-8?B?TUprQkpqemdzVXJCcTAwQkR6Tk1FTS8raTVZL1djdnNHSmxBRTVFWTNoYk05?=
 =?utf-8?B?RmR5RTlYV3kweXJTK040SUhYM3djdWZaREZmNkhGUVBWanFvVnFEYjNwT05o?=
 =?utf-8?B?d1NYZ0NFYVJIanpGaXVIdFg1ZVFmNFFIdkRWSzBETC9IWEp6YUJSenFwekcw?=
 =?utf-8?B?RWFoemRRK3JIeUlGdXdFaHArdzJ5OG1WUm5vTWZXNG4xL3RrVW8xYXZ1elli?=
 =?utf-8?B?SWFNUnQ5Q28rSFRDQjg3c0x2ckc1YVJCdHRSMlhQbHdJeWd2T1paczZWTWdV?=
 =?utf-8?B?UWQvSHhPa1NhS0RMaFJRZ2Y0UFJDVWdVTjZDdFp3YUtnRUN2STJyclpqRTd3?=
 =?utf-8?B?b1QzUnRrV1ljb2gxVnljdC8wOUpJQWNiLytRRU5VeGRUZ0R2NWhFZVNwZnk2?=
 =?utf-8?B?Uy9OZ2NtZ3NMVjliVHZyVmdPbWFQclVZdFVoWGIwNk5WUG1CRlo0ckRKSG9o?=
 =?utf-8?B?eUMxZTFFWmRNYUxMcDA3VUxueTlrZy8vZHpDeldkYjljMkoxQkFNTmZYR1dM?=
 =?utf-8?B?U2VkK1kxeFIwbGhXM1FTamFHVmQ4cTJMVVlDY2tHV2hKYzh0dXY5WFRjbDZI?=
 =?utf-8?B?Q28wSFNUYkxGTGliWUp4MDhtN1l0WDYxaVRMVHI5alY3OHhkOG1SdEZtTEhI?=
 =?utf-8?B?NnJmUHBDYklmRTNTN2tCQS9wQ1QzcGJtVk1DZ3ozMWFiSjhlNFZZc1M1cE1S?=
 =?utf-8?B?bVdRb25tQmltUW55Q2xGK2FRUkgrcU5EczlGbnBuRCtKcTEvNEsxcXVrVjFu?=
 =?utf-8?B?U0hhSHk4T0VzclFKUFJVZFRxbk9GODZmR3ZTcUV1eVNTR1ArbHNZS2cxdE40?=
 =?utf-8?B?V1FTL2VZb09xTTZBSXBUa090M0lpKzRBOVBLOGc5S2ZqRURJZ3ppRjlnQlZn?=
 =?utf-8?B?anY2YTdlME8yeis4MGpaeWZkRjdGYjliYmJhc2J5LzQ0WFZvNW1VWkpDazdy?=
 =?utf-8?Q?U9hdomLzDhyoB0ZbxGHWRsH4X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201d4c5a-b480-4341-5a2d-08da7f98cd6d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 15:05:48.5536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rF0fFobevaOJlOIuSJuKUzMOwLyctY4XT5Lw8GmDHSIvg8CKYcy7Qha+h0EctJZrBPBOhwjG+3JnNZMYGDuCIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/2022 05:55, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch add tb_nvm_validate() contain an array that has functions
> pointers to asmedia_nvm_validate().
> And asmedia_nvm_validate() that recognize supported vendor works in one
> of the following cases:
> Case NVM_UPGRADE: enable nvm's attribute by setting no_nvm_upgrade
> flag to create nvm_authenticate file node.
> Case NVM_ADD: add active/non-active NVM devices.
> Case NVM_WRITE: update firmware to non-ative NVM device.
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---Add enum nvm_validate_ops and modify ASMedia NVM Version format.
> ---Repair file(switch.c) has existed warning, but have 7 warn not fixed.

Greg and Mika mentioned some of this already, but when you make a patch 
- it should fix one thing.  Some more detail to help you though:

IOW one patch should fixup any whitespace mistakes, then another 
completely separate patch should include your changes.  When you make 
the patch series you can use with a number argument for how many patches 
to make in your series.  For example if you have 2 fixups followed by 
your new patch it should be:
'git format-patch -3 --subjet-prefix="PATCH v5"'

In addition to checkpatch another good habit is to visually inspect the 
patches beore sending them to ensure they only contain the intended 
changes.  If you made a mistake, you can just use git rebase -i and 
fixup individual patches and then run 'git format-patch' again.

> 
> Note: The three previous submissions accidentally used the same subject
> prefix. This changelog is relative to the most recent submission at
> https://github.com/intel-lab-lkp/linux/commits/Szuying-Chen/thunderbolt-thunderbolt-add-vendor-s-NVM-formats/20220815-121330
> 
>   drivers/thunderbolt/nvm.c    | 148 +++++++++++++++++++++++++++++++++++
>   drivers/thunderbolt/switch.c |  28 ++++++-
>   drivers/thunderbolt/tb.h     |  23 ++++++
>   3 files changed, 196 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index b3f310389378..be8cbcfafb80 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -9,11 +9,159 @@
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
> +
> +	switch (mode) {
> +	case NVM_UPGRADE:
> +		if (sw->no_nvm_upgrade)
> +			sw->no_nvm_upgrade = false;
> +
> +		break;
> +
> +	case NVM_ADD:
> +		nvm = tb_nvm_alloc(&sw->dev);
> +		if (IS_ERR(nvm)) {
> +			ret = PTR_ERR(nvm);
> +			break;
> +		}
> +
> +		ret = usb4_switch_nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
> +		if (ret)
> +			break;
> +
> +		nvm->nvm_asm.major = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> +		ret = usb4_switch_nvm_read(sw, ASMEDIA_NVM_DATE, &val, sizeof(val));
> +		if (ret)
> +			break;
> +
> +		nvm->nvm_asm.minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
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
> +	case NVM_WRITE:
> +		const u8 *buf = sw->nvm->buf;
> +
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
> +	if ((mode == NVM_ADD) && (ret != 0))
> +		tb_nvm_free(sw->nvm);
> +
> +	return ret;
> +}
> +
> +struct tb_nvm_id {
> +	u16 hw_vendor_id;
> +	int (*validate)(struct tb_switch *sw, unsigned int mode);
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
> +	int i;
> +	int res = 0;
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
> index 244f8cd38b25..de380fb5a166 100644
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
> +	ret = tb_nvm_validate(sw, NVM_WRITE);
> +	if (sw->nvm->flushed)
> +		return ret;
> +
>   	/*
>   	 * FARB pointer must point inside the image and must at least
>   	 * contain parts of the digital section we will be reading here.
> @@ -391,10 +399,14 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
>   		return 0;
> 
>   	/*
> -	 * The NVM format of non-Intel hardware is not known so
> -	 * currently restrict NVM upgrade for Intel hardware. We may
> -	 * relax this in the future when we learn other NVM formats.
> +	 * The NVM format of Intel and Asmedia hardware are known so
> +	 * currently restrict NVM upgrade for Intel and Asmedia hardware.
> +	 * We may relax this in the future when we learn other NVM formats.
>   	 */
> +	ret = tb_nvm_validate(sw, NVM_ADD);
> +	if (ret)
> +		return ret;
> +
>   	if (sw->config.vendor_id != PCI_VENDOR_ID_INTEL &&
>   	    sw->config.vendor_id != 0x8087) {
>   		dev_info(&sw->dev,
> @@ -527,6 +539,7 @@ int tb_port_state(struct tb_port *port)
>   {
>   	struct tb_cap_phy phy;
>   	int res;
> +
>   	if (port->cap_phy == 0) {
>   		tb_port_WARN(port, "does not have a PHY\n");
>   		return -EINVAL;
> @@ -556,6 +569,7 @@ int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged)
>   {
>   	int retries = 10;
>   	int state;
> +
>   	if (!port->cap_phy) {
>   		tb_port_WARN(port, "does not have PHY\n");
>   		return -EINVAL;
> @@ -653,6 +667,7 @@ int tb_port_add_nfc_credits(struct tb_port *port, int credits)
>   int tb_port_clear_counter(struct tb_port *port, int counter)
>   {
>   	u32 zero[3] = { 0, 0, 0 };
> +
>   	tb_port_dbg(port, "clearing counter %d\n", counter);
>   	return tb_port_write(port, zero, TB_CFG_COUNTERS, 3 * counter, 3);
>   }
> @@ -875,6 +890,7 @@ static inline bool tb_switch_is_reachable(const struct tb_switch *parent,
>   					  const struct tb_switch *sw)
>   {
>   	u64 mask = (1ULL << parent->config.depth * 8) - 1;
> +
>   	return (tb_route(parent) & mask) == (tb_route(sw) & mask);
>   }
> 
> @@ -1345,6 +1361,7 @@ bool tb_pci_port_is_enabled(struct tb_port *port)
>   int tb_pci_port_enable(struct tb_port *port, bool enable)
>   {
>   	u32 word = enable ? ADP_PCIE_CS_0_PE : 0x0;
> +
>   	if (!port->cap_adap)
>   		return -ENXIO;
>   	return tb_port_write(port, &word, TB_CFG_PORT,
> @@ -1918,6 +1935,7 @@ static ssize_t nvm_authenticate_store(struct device *dev,
>   	struct device_attribute *attr, const char *buf, size_t count)
>   {
>   	int ret = nvm_authenticate_sysfs(dev, buf, false);
> +
>   	if (ret)
>   		return ret;
>   	return count;
> @@ -1953,6 +1971,9 @@ static ssize_t nvm_version_show(struct device *dev,
>   		ret = -ENODATA;
>   	else if (!sw->nvm)
>   		ret = -EAGAIN;
> +	/*ASMedia NVM version show format xxxxxx_xxxxxx */
> +	else if (sw->config.vendor_id == 0x174C)
> +		ret = sprintf(buf, "%06x.%06x\n", sw->nvm->nvm_asm.major, sw->nvm->nvm_asm.minor);

Any reason to need the zero padding?  If not, the existing

ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);

Should work for you too once if/when you expand the members to 32 bit. 
(see comment below)

>   	else
>   		ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);
> 
> @@ -2860,6 +2881,7 @@ int tb_switch_add(struct tb_switch *sw)
>   		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
> 
>   		tb_check_quirks(sw);
> +		tb_nvm_validate(sw, NVM_UPGRADE);
> 
>   		ret = tb_switch_set_uuid(sw);
>   		if (ret) {
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 5db76de40cc1..7f5c8ae731a0 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -28,6 +28,15 @@
>   #define NVM_VERSION		0x08
>   #define NVM_FLASH_SIZE		0x45
> 
> +/* ASMedia specific NVM offsets */
> +#define ASMEDIA_NVM_VERSION	0x28
> +#define ASMEDIA_NVM_DATE	0x1c
> +
> +struct nvm_asmedia {
> +	u32 major;
> +	u32 minor;
> +};
> +
>   /**
>    * struct tb_nvm - Structure holding NVM information
>    * @dev: Owner of the NVM
> @@ -57,6 +66,7 @@ struct tb_nvm {
>   	size_t buf_data_size;
>   	bool authenticating;
>   	bool flushed;
> +	struct nvm_asmedia nvm_asm;

You shouldn't need to include this in the tb_nvm structure.
It already has "minor" and "major" members, so you can just use those ones.

I think it's better to expand those to be 32 bit instead of 8 bit if you 
require the extra 3 bytes instead of make new ones.  It won't harm the 
Intel case to store a byte there.

>   };
> 
>   enum tb_nvm_write_ops {
> @@ -65,6 +75,18 @@ enum tb_nvm_write_ops {
>   	AUTHENTICATE_ONLY = 3,
>   };
> 
> +/*
> + * enum nvm_validate_ops - Nvm upgrade for each vendor
> + * @NVM_UPGRADE: Not prevent NVM upgrade.
> + * @NVM_ADD: Vendor's NVM device add.
> + * @NVM_WRITE: Vendor's NVM write.
> + */
> +enum nvm_validate_ops {
> +	NVM_UPGRADE = 0,
> +	NVM_ADD = 1,
> +	NVM_WRITE = 2,
> +};
> +
>   #define TB_SWITCH_KEY_SIZE		32
>   #define TB_SWITCH_MAX_DEPTH		6
>   #define USB4_SWITCH_MAX_DEPTH		5
> @@ -736,6 +758,7 @@ static inline void tb_domain_put(struct tb *tb)
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

