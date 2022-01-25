Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B629C49B93C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1585977AbiAYQu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:50:58 -0500
Received: from mail-co1nam11on2135.outbound.protection.outlook.com ([40.107.220.135]:51424
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1381064AbiAYQrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:47:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdQXH5DKGKGvCsi9qJByscuRXWhE60v9jCvxcu25qmgLA0iYr46fp6cSY4bbHxi9uRQuJ3ksVRTxZF0aMXFtn8J5BvgzkowKSS2Wiod6Z1BitXtbpBt5NZo/4r1j+YsNzuCKB7acPul88mlwCkI9yfkC9HSacqvt4/5XpcfAztkBpojQo5VH9oc9C8n9ohBk1JK1R1xtBjp2b7sNuPFRSpWv4da3tnFySa3A/V+QO/9+k4ss0j1AYaEb0nLStOI/5lI68coO4hPVDklaWk3QPrONgHGAtUlVVd4EezwWGPBHqED7uzRFTKNZTsLDtqIFZzzlIADGX9FzxfFmpsxD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jYi/sep1Kl2Xny7t/UL4JEAB0h8meCxntsKjgThiXg=;
 b=UMyY9i/BcYOqTr5T55sjoBgt0RPZi9mdScH7jBJbPg4cmcMFbZJlOFemamE1Ys4HFcRKB7cKvlKJqucIXA+UpZw7QmvVuSVKe60yu5qXtGptZ8abPD2BwD9vDCYM6TDHYK/rolqsNhe8HKxQ7Hm482nKz5vc34lB+xSHHBCNNiQo3iFQWpRhoJCW2k4bIbBNwgwnBx4M9Gre3V32gvbQ4PghhjoYRXG7zL76c2RidlKEJ4lvtxZsu/FKsJBiHQV/H6L3XCe4cGc231MKvKlPhx5uPoQ7er4JTG5N0w2d22I2vdoqCtmkK1zp0f8jkg/uwHmKeZ4Ux3sfA/HuyocKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jYi/sep1Kl2Xny7t/UL4JEAB0h8meCxntsKjgThiXg=;
 b=SG+5qUM4vIyLX44D6wLVPG/50QubFZ8kZ7NQDELgANGi0BqRMl7f+FzFzHEp9m3eaIllNkmSj9q/3dm8+C6Te/JThVjFDoLt0+wWNnRlTPRaGF3Uas781ax0Z43MrGVXSEa9Mee48eratLZ9IkO3vjXxDjttSKtJUxLT5doNazU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by MWHPR10MB1520.namprd10.prod.outlook.com
 (2603:10b6:300:26::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 16:46:58 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 16:46:58 +0000
Date:   Tue, 25 Jan 2022 08:46:59 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH] pinctrl: microchip-sgpio: Fix support for regmap
Message-ID: <20220125164659.GA31440@COLIN-DESKTOP1.localdomain>
References: <20220125161245.418882-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125161245.418882-1-horatiu.vultur@microchip.com>
X-ClientProxiedBy: MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::28) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf1387cc-775b-4634-f120-08d9e0224d51
X-MS-TrafficTypeDiagnostic: MWHPR10MB1520:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1520D680912578450714F65EA45F9@MWHPR10MB1520.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYP9JLdAvqAlo97mpPhivBdNOcQ74MECn2Lnx6MXVE+Zho6DrSuOsYyoARKnN4ClON+7SX1Y7AO4H6YE592/dR/WiKs5EamZB4PGlWmLVx9MuqukhghhRodC128AAcjMU+P0Ns0XBsMtcPZv2IMhk11ToNwywtHe9mUoDZ/YOFzeWMUHvn2BjENJBlTgpQhY0OCrcI1/8XIPI0wWRSNbqzXRb2MX52wPBOE5/4Zq7WfhOYzCRZvGk1syRlsKlWaxQjH7Wuc3f4qapUOHIrJJ/kGWxdl4ty7qZoShoq28TV58HJaH7CE+X376blgfhCVjh2EEoLBzxvgQgtvaxJqcAGk222oE8bZymtyn3SRqk4Td9xqfK4RADZ2u1ZTGJYpW4WhALDPmRDlM9nvcNiD+zye8COWfiR5DL4I2H1AzoX2ViS+pyg1OaRH54C6tziBVegvDfYk3SVTYKeZvcFL+z4yVQ9x4rBOw8AJY1T24Hpbpu3EEpIMFpYkyRyGanVbz/NuXNxC8pMc4Xioi3j3lWLrQskG0JAwH30D3SduUWSIwoXigeYqIPvNCVZZrnQpxnVXzz6U4Fj3CGRpFzMgLQ4rHH+0y5YqqGFwrnq4coGGeW9nwULE0ZZzcV2NUtbO8Jqu98RiZCka4V5unM1KGETRODAacVNDpA3UznOFo0ZVSGThVZf0MPL62MQER40oo21kASH41yoBrQBZGjHI+ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39840400004)(366004)(42606007)(136003)(316002)(44832011)(33656002)(8676002)(38100700002)(38350700002)(4326008)(86362001)(2906002)(6512007)(83380400001)(186003)(6486002)(508600001)(1076003)(66476007)(26005)(9686003)(66946007)(66556008)(52116002)(6916009)(5660300002)(6506007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iFFtYq8FTJAGTnvRj0ZYIlruEK7/h5dFK090MqCCeMQAZ6xVVc5NFmBoEhDy?=
 =?us-ascii?Q?uRFDqurUIhLNztXCXctLFBICfPHM9NHJZ+VAHl9tFbuO+o68gsDZcqNt43sv?=
 =?us-ascii?Q?2y7/8w9ugGw9IcWyqfNGJ+QFcEN1DU/X/4J0NOu3kDRevs3kBLPmPctTe/34?=
 =?us-ascii?Q?ISqWxrFg5Oml6KIH7mxCA/f+51AZx451lf0L7KFT24rKnkIb07lzmyiMsB/Z?=
 =?us-ascii?Q?XyR1G2as+4oXsts2U+AK5tNfNQH/BLBkkWYrGS2Si5rXpOSgEl1ArskDzrYb?=
 =?us-ascii?Q?gZgVhXMzAJWfFMfRQhfKE/bZ6wx+mXbBrlSe8UwawCKbwdXZlE2EoZcS22Dl?=
 =?us-ascii?Q?Rw29zoVMYuiK6tc8HRQOsJrVm5Tk2Mm42LZxS2KpV4sYOidbpAVG7owGozio?=
 =?us-ascii?Q?ZW1OObLoTCX703L+MsNdgUR4GObgf1yBs1tley4y3ImnmnAqTyyYXZOBiRAU?=
 =?us-ascii?Q?ehLwlAOMYE3oj8voQibreRJh49jcnPq3PvyYEu2fKUjK6YELrEbhujRziZEJ?=
 =?us-ascii?Q?NvmO0nEeR3fL6MnM6KjInLGkaIhg9v5cH3RBC7xYTlNf6XSbBuT2HUYA04or?=
 =?us-ascii?Q?DgrKB2QIfZyeynvdwIvPTO8Fdir82+VH45+CCaPriKoKRVfSnEkTlj7G66VL?=
 =?us-ascii?Q?Ysb1zDz/1DTbWR+j340VcNzneExLncQbL+ep4aiJ/P9ZqC683P17x+5qS+9o?=
 =?us-ascii?Q?44wUesxVpkEUG5XijTsRNnNgjD1vvDFc9NVxpvirAMhkRnecy/ESJv288pwy?=
 =?us-ascii?Q?Cpto/f9l74OE/Vdki3WnfjnYxXxHnjhSDqezxLs1OQNYV4/wvK2b0eSm97bj?=
 =?us-ascii?Q?3cZWWFTl7OIFFBacaMMzqtaUflJUWJ4XtV0yOmKeB7XvKYUFc0t8BwOBcBoA?=
 =?us-ascii?Q?0/Mou5SmF7fRpTjmYebYZUwgUjq3iSin1GWBGT675QvCbS/R2S5wGLP26NQ2?=
 =?us-ascii?Q?gwUn1j906bynbdOY+DQNXpvRkrgrOXFtt+croxjaF9Ts43qcZ2YyE0eZ2uFy?=
 =?us-ascii?Q?6t5QtLD+WpkQwbfe0078UIdH6/jwdNtCLuAuuD/JwUlC6g9XnLziHEQVwRSZ?=
 =?us-ascii?Q?zPJaCVpi/7C7JbIkXbRNlzGfggjas+fMhUIi5lHOsfrgj5qT4Z+ubLI/nqCK?=
 =?us-ascii?Q?ggwmGS+AWbasxAsKEBbT5ZZoqegmZ5vg6OwM5DixBrb+hhyfnOgywvjkYMGK?=
 =?us-ascii?Q?bVXzOxPMTGKpH9Jp6Nu7dcs+kbBVCsZByJi/SoLK7WapNP1dRI52hYOSLvoR?=
 =?us-ascii?Q?BxqGGImbiHxRSPFpvzL0hybI3cZsvrVxblG3SgV6+L2tU2kxU1y4ox1SA+7Q?=
 =?us-ascii?Q?Y9RHvQa9+hNvn1YlnjVPJjULyZZDjv5qgM3zgSO7qHqzBmA5+O2O1jpbQdtT?=
 =?us-ascii?Q?0eBMai0qsh9d4aF9LictxUlxF/apFBqz8zHkovGGH9kHdQuY8XhVWDEuDUUz?=
 =?us-ascii?Q?Zvtfx3Kz+5JU9xe0EdFEddl6vXMT7T9d6fNdHr8utqs7PDb4Pt1QMbvK11OC?=
 =?us-ascii?Q?AiJTW9PEA1nC/z0UgyC9vLDAZ19pu6tbHCRLWXyGQ1ce5emmIdbG7eIDmnPN?=
 =?us-ascii?Q?ObBBlJJ+vGrZvx2NRdrnNIVQC0kVeTls9/UWfMdDFbitcKRU82zQAYZkr1Yr?=
 =?us-ascii?Q?GXiVJB7jSVo/Gr8LU6hnDNkT4Ol0qGIsaG9H/iXoNihSeq7Vo5R8RHp4dwbd?=
 =?us-ascii?Q?bC8hSg=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1387cc-775b-4634-f120-08d9e0224d51
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 16:46:58.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7UQ6fHZc/HlLVwKeQqHlLeC8q39fFyWTATzIhSzHbMUSO930Mm2oagjdzd2p9aR+nnudfaTn6C3RJaaiiUByfvw8eeV0/XrUDOCu7brQ5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1520
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

On Tue, Jan 25, 2022 at 05:12:45PM +0100, Horatiu Vultur wrote:
> Initially the driver accessed the registers using u32 __iomem but then
> in the blamed commit it changed it to use regmap. The problem is that now
> the offset of the registers is not calculated anymore at word offset but
> at byte offset. Therefore make sure to multiply the offset with word size.
> 

Sorry about this one. I see it must have slipped through the cracks
because I had made the same change in my tree. The only difference is I
had copied reg_stride into sgpio_priv instead of making regmap_config
file-scope. For what its worth, with apologies:

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>

> Fixes: 2afbbab45c261a ("pinctrl: microchip-sgpio: update to support regmap")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/pinctrl/pinctrl-microchip-sgpio.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
> index 8e081c90bdb2..2999c98bbdee 100644
> --- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
> +++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
> @@ -98,6 +98,12 @@ static const struct sgpio_properties properties_sparx5 = {
>  	.regoff = { 0x00, 0x06, 0x26, 0x04, 0x05, 0x2a, 0x32, 0x3a, 0x3e, 0x42 },
>  };
>  
> +static const struct regmap_config regmap_config = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 4,
> +};
> +
>  static const char * const functions[] = { "gpio" };
>  
>  struct sgpio_bank {
> @@ -137,7 +143,7 @@ static inline int sgpio_addr_to_pin(struct sgpio_priv *priv, int port, int bit)
>  
>  static inline u32 sgpio_get_addr(struct sgpio_priv *priv, u32 rno, u32 off)
>  {
> -	return priv->properties->regoff[rno] + off;
> +	return (priv->properties->regoff[rno] + off) * regmap_config.reg_stride;
>  }
>  
>  static u32 sgpio_readl(struct sgpio_priv *priv, u32 rno, u32 off)
> @@ -821,11 +827,6 @@ static int microchip_sgpio_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  	u32 __iomem *regs;
>  	u32 val;
> -	struct regmap_config regmap_config = {
> -		.reg_bits = 32,
> -		.val_bits = 32,
> -		.reg_stride = 4,
> -	};
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> -- 
> 2.33.0
> 
