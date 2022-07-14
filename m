Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3C3573FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiGMXB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGMXB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:01:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2128.outbound.protection.outlook.com [40.107.92.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0748C2A95D;
        Wed, 13 Jul 2022 16:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeFHxk7hzETEaLEV3CWyjZNp5VdquVgDNRaViIf22cAQOG8dyEPhkKEVSmCBC65C65ovdxj9OW4I8oabzvhc1iuelOaQz1+AFq/d5xmtLfPDwSijJRtRrC0xi3BOtlKaRdm3GKrIEwAE3gU+GsdFeFSEIsRlz221qmXJkV/7uihUtuoRPBan9N1/WtfV3pdBZ95vw+UXU7dKH4vQVKn0kgQplWFyu6697uK7W2vVku72hPVELrcDfmjxKob7W5pQQ0GrM24IxdZy0UdJC8Rb/Mn9mkEyvPmAa5G076uu2r2ETGlci3ISyXcs4ntvOcnsSi6zYYXP981NXRTxnVwL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtGO7dCmWGNJYrKCoSQ7wdH6hPdcMIvS4Vfk/PDcxXQ=;
 b=nizVfkhQpS4K5eOCnDrgzl3zstNQOffSRLMXuDKBdUMD7SL7HcrIIUj60Wz3MEc9xkK1+bnVT/fmY05JqZUtSKiLvSZT8huII5DdSihiczvxWq4yI/JIY5EHDKIUYW5vGsZ9ddlgx4wA7Ll27Jg9myenWVSN3Xht4tSNjmC/XIHug0F+CwOPSJQHbhBNQr0ZpHaebAJd/blVFRsqhsz/SJxCH0Tlm4hsbJm/1RXQf8ZXNE38EHUQXQOkwOkQ2V7ftrY6iRs2ChYE+qFi4Bitgz2JsVqX9DFzrubd2UNY8HqZb21MaTr/Xkip6kEkmIyVjR71c0LTkQCcdc0v4KPinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtGO7dCmWGNJYrKCoSQ7wdH6hPdcMIvS4Vfk/PDcxXQ=;
 b=X+6oZqKV4NMdsea7ReOy6YV2xOrv2siYOU3H60VWw47HntvfDoNqHV7BJ4hlDrTWPlB/rzQrsn7hRknGUZjdVYoJy/aWSwaJk+SW+VU4nywDESmmyo+5eLQpb1t8OWv/Qwr/nyoWIpcRjdqapoY7hnKKH4VieX2vcuIw4PEtf3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CY5PR10MB6021.namprd10.prod.outlook.com
 (2603:10b6:930:3f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 23:01:51 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e%6]) with mapi id 15.20.5395.020; Wed, 13 Jul 2022
 23:01:50 +0000
Date:   Wed, 13 Jul 2022 23:01:50 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: fix pinconf
Message-ID: <Ys+xTubC2iwetqYS@COLIN-DESKTOP1.localdomain>
References: <20220713225151.1476041-1-robert.marko@sartura.hr>
 <20220713225151.1476041-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713225151.1476041-2-robert.marko@sartura.hr>
X-ClientProxiedBy: MW4PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:303:6b::15) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11c1c455-1913-42ad-d104-08da6523abb3
X-MS-TrafficTypeDiagnostic: CY5PR10MB6021:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/BRD/zSWE7aWdzouv8dwgQgHMHGnf2NWvOPRBTGXok+n6pB+nSCODg/Jwi1YYyD7PQRYbh2g+0SjzRHXdJ7Nr8elj9W/jYXhNkb84028WO3xdo4Td3sjZ3hBLuZGMqKqH2aP6LbP6oxC1ViXD7EB7Nk5peZPv5r3kyoIySK6dE1UYaEbD9rZV0h1iYOD4R2axvT6FsurDxLCVA/vMeUU0ID/Hyft+8ACESkdd4NUsOUltS1G04oAQb1msaga+Y9C83BgX2nyHfPuLFY9gEx1XfaZ5+k9nvH6tSkE84w9wvHBUclPpOkuU86Nl7kr6/FwigAhzZI+7WPb/wKS8TeNKlv8N3U9tYtGUgdq1Vq7SyRefsaFBtLSYLsOZAi8f37Cn47t+b5DodmUEeYPTq8c2UZwFEzsKV0NotYsuTWwW6On9a8UU/5QOD2psGoPXOClGdUMcp6q4YCU7RyiA5u95TIbnY04uNslmvty2K3Mhqxr6ASFThix+37/yG/8AB8d2abrZOHB2FgLlTRUzoSysRLsuBcEJ8svrAz99c2pQ5W5xQMlsaVcwZ/s9K02+i4giT0zWeQQA6Qb+dWvz9sY0Wp4yS+rx7KHLyg7IVNuYBd88gAVIU5EKcG5mvp43NE9D/onUituualERu5OhHbpJTzV5ZYnDlAd2Yq1LrLB2dtokqxrMtHXefzMD81ZsXyELbXyEb2/OdFdcdjGqHwFg9oqElRH4QEt6Om99CcBljSuHJSzT+bAD9ht7Pe5iDXHXHclYYKCrEUSQ1DKXWbnJAULpFWEAbrKH0//Bhgtx7BGpEDNMDzD+2CKyg4E/Pyl/gxQC6Bzu6HTC1QfSYkEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39830400003)(396003)(136003)(376002)(346002)(6512007)(6916009)(478600001)(41300700001)(6486002)(316002)(44832011)(966005)(26005)(6506007)(38100700002)(2906002)(4326008)(83380400001)(66476007)(5660300002)(66556008)(8676002)(66946007)(86362001)(186003)(8936002)(9686003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dlLeBlDdv3ARO6MI44x86hPIqdnxPMM1cuglBTuMmOUbaXuiCXNCrGTL4rj8?=
 =?us-ascii?Q?XRVWzyNEAB0Z/+0a3NsL599/JUszf40ZiwocZAlmEG78QYDXQl0cE281idAf?=
 =?us-ascii?Q?eM1Q3aW9gU6t+sV02d2pzLfkBdDDbeF8hyYuqzpIAY6CUKevGOu8QMj5MudO?=
 =?us-ascii?Q?M32/GHzThiwQM7UL0lZJcFxumsd9VxF7XpBAGKn6N9K7hLdg0PQ1bgIx5t/Y?=
 =?us-ascii?Q?5AEZESgheMFahmwxVr85eKBvX0XtKew+P3SKcyVQoiUN68Tuz15AbrYcc9Ds?=
 =?us-ascii?Q?6P/DuPhmjFarLa6GdwIzddHWgb4vsyYWS1vk/qzfOapNV+T4spJ6QD3QUv3p?=
 =?us-ascii?Q?vaaOmB/L6VcsRkidYRNj/5pt2JvGR62F35YzL9Uj7BhrJW75sWZtjBV19UUG?=
 =?us-ascii?Q?uWz2HdDYoq5gQpyFNszB9pt4W2IAUxHczyrW1Zo6JxgeakzGYwYbpabBpFin?=
 =?us-ascii?Q?nbTv5chAPdTZH+D9otzu3UKft+I+iw0jY6vhIKtUBW4y+9g3+94arT1WUfX7?=
 =?us-ascii?Q?3tjqw+BQw1k3b+sKg0EaoRfgcvtDf5a/WwSLq0j0UVtoWqM3VY2axCR2hRTR?=
 =?us-ascii?Q?eJKOAEFavPWR3tBt9po7Tgwe5lzKRCMpoFAWgXCe4MAqr9W6UlrGtqkJW846?=
 =?us-ascii?Q?+9xthrXplBZDcyz5SE181oRJZUtIdy54SSZJiRuaDb2AjJz1Y+u5ws+N7CB0?=
 =?us-ascii?Q?FdTNPypmRBeTDxhHN3YuH/ftrD2Zfadva4KfpkBOzULpX0Qxbwq3sL3lHEZ4?=
 =?us-ascii?Q?UBw3sn3tZfEep5MY31Mwp3mQgZqSE99J6NCTHrOEetHqC32vsfICv9SLgrYv?=
 =?us-ascii?Q?iaxYK5LKJioIG+U0P+bkEhyVQwBgsaqtp4iB4AtHFokjc6r0EsnTlE42UP1i?=
 =?us-ascii?Q?XlKzqjcCUpxuHMKsoQbJmkcCbjrByG0U7aaB31oEzD8/D0gnCVL7lJgXDPo5?=
 =?us-ascii?Q?+/oypljCXlOVOQZi+POLdcIR/WdnzF+lMt/iwiZRlfW+C5fHpCdNPWXqNE6g?=
 =?us-ascii?Q?Ku0td1ZV8M6W0+ddSoLvyKXKjcaMRFi8H2yl8qXiOqI3hMwFFnYZlkbpaMDw?=
 =?us-ascii?Q?uIsaxNi99ozL13nRrYpZ2qBoOQOLFSjCQFXYWL8h/kIh0vpsI8H3jKQmhukz?=
 =?us-ascii?Q?MALWiprE+PeOtFSXqoPxOfn1L6SMScDmMKJnimmsR0w7tUTmbkNlkwKog7Pp?=
 =?us-ascii?Q?SS039krr6wopWUznbpP5+nwAnOVGkbQ84H0cAzaI7joU8EBUQBJQ05R/NxEw?=
 =?us-ascii?Q?w/8d5xAkn/VzleI8Jx+sJ97ckFfxdwtRsnL0+jAp9ioJGcym7X5DbgLpu5Hz?=
 =?us-ascii?Q?Qq32XViB6MWTlog5WAOnjKaag8Ms01+2P1QLfDcUfltbKykJIIOh2QLkyvYx?=
 =?us-ascii?Q?CCzry/DpnUGh/FfeJx0p9ZewTLAk48NoYnObzVS/cnJ6ajFc7oJ8fJ5vcv9X?=
 =?us-ascii?Q?rx+SagDwCFbeP5aMgOaSdSeDBwuSwsoNZwyblJpJOEyfHfTs94HJUkO/N3O5?=
 =?us-ascii?Q?YyutU420oCGH0FdXudFbK/Ytjx7r9gY1NsxQyNtgPTfUft67CSHPnd1tJzZO?=
 =?us-ascii?Q?jin1vLE8lgpLKt1jrVpfBrlwqGcM9u2HO+ZZ2IQOqE85gC0tkUw0GZb2AE9V?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c1c455-1913-42ad-d104-08da6523abb3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 23:01:50.7326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bN7CUIqBMHCekVQ33Orw1vQ3NkbqHOHzW2kvTjMqTnJKSHuALskLrwG8PxaO5Wi0HDqMwe8QfQ/YTW0LZs6OS8WQceru/HAKV74Rzv2deyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6021
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Thu, Jul 14, 2022 at 12:51:51AM +0200, Robert Marko wrote:
> Commit "pinctrl: ocelot: convert pinctrl to regmap" moved to using
> regmap_read/write, however it neglected to also carry out alignment
> to register stride of 4.
> 
> This would cause the following error:
> [    1.720873] pinctrl-ocelot 6110101e0.pinctrl: pin_config_set op failed for pin 34
> [    1.728110] sdhci-sparx5 600800000.mmc: Error applying setting, reverse things back
> 
> So, regmap_read would return -EINVAL as it was being passed address
> of the pin without stride, so for example pin 34 would end up being
> 0x22 in hex.
> 
> Fix this by accouting for the stride in register address.

Sorry for the bug. Horaitu found this as well and recently submitted
patches:

https://patchwork.ozlabs.org/project/linux-gpio/patch/20220713193750.4079621-3-horatiu.vultur@microchip.com/

The second patch in his set fixes both of these issues (reg_stride and
max_register).

> 
> Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index 84bfbe649b67..a71145367b15 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -1327,7 +1327,9 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
>  	if (info->pincfg) {
>  		u32 regcfg;
>  
> -		ret = regmap_read(info->pincfg, pin, &regcfg);
> +		ret = regmap_read(info->pincfg,
> +				  pin * regmap_get_reg_stride(info->pincfg),
> +				  &regcfg);
>  		if (ret)
>  			return ret;
>  
> @@ -1359,14 +1361,18 @@ static int ocelot_pincfg_clrsetbits(struct ocelot_pinctrl *info, u32 regaddr,
>  	u32 val;
>  	int ret;
>  
> -	ret = regmap_read(info->pincfg, regaddr, &val);
> +	ret = regmap_read(info->pincfg,
> +			  regaddr * regmap_get_reg_stride(info->pincfg),
> +			  &val);
>  	if (ret)
>  		return ret;
>  
>  	val &= ~clrbits;
>  	val |= setbits;
>  
> -	ret = regmap_write(info->pincfg, regaddr, val);
> +	ret = regmap_write(info->pincfg,
> +			   regaddr * regmap_get_reg_stride(info->pincfg),
> +			   val);
>  
>  	return ret;
>  }
> -- 
> 2.36.1
> 
