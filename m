Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26E24B8C94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiBPPh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:37:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiBPPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:37:57 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2121.outbound.protection.outlook.com [40.107.100.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4516A286B47;
        Wed, 16 Feb 2022 07:37:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAc/owjrhMms5/E2wy+EJt8BmF1Rkjy9BK4VYbDbcUXBmhlr4tFZ6OnhAB0qBQcuhi8jVdZXUKsvHeRi6qzEaZ1qL8ku/+Fqr2HSpq34dsc3/QBV3M/tvv8RZej89kVejZK5/+jdi32mi1Erb84oBpFD7RXdJwVqfEnGYRZ1S6HZ0ntKJuhw+7yPCgEYLdgqN8ufVvnRDZ3gvau+R1PEmMC7It5lOQgY13jddJGxRG6Jhhyk5K/dn/Qf1+1oB9CtpfT0oKlwj2yeHP9ZwdMNJsUu9mGeIZRtRo14tZ3BYXDHKo34kjUdaDY0dZKHUg91UnHfBadWtltgTj78RWUX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dOXtPer5T0R1rp1EOFoHSkBVUbvQ8lj0CMbQf8D2Ak=;
 b=AXDdqC0uiobAxJ3a4NblKHvVYgHZoEOBVr2i/wiXp5OBHaR1G9tOulVqyTl7MIFV5TknJW1eNaZZBwajnmqQXAlt+sYAGk5KL6RzYXEzp40Y3xu6UeIAPkXyZgz8Vfbwzblxs3WRPw/czk7AMw0wcqUXdacfoLw3OC2karqkSpPQvaxKdZYBgAQCGiLJitS8kjTJxDkafdx1J7WldhK3yKa97d3weknziosFRqlXHPGK9iBNwJCDmGnOE5Uc0SCQX/ED/uwbzg2rbS5uT9iZ93t2cPieNbk7LcYkiNSpBw0xIfM7ujJkfimAzXfIIvSHeKERvEOzDt653R+QmYboyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dOXtPer5T0R1rp1EOFoHSkBVUbvQ8lj0CMbQf8D2Ak=;
 b=OYnGMQ2XHGNTiDwN7EmYYYOan2EXm7JB3jCv0A9hcYk46Y8v9Gp1H4iHGMh2uqYnGUox3JYWvUYhi9nwD41Fnmxc4qCD/bV2wQ3muti+4CAdfWAkzDean5dh5mBpAED8S7RTukJtAJn3ZAxdAJ83iURO8KKSkkLKslEdSeEGDM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CH2PR10MB4277.namprd10.prod.outlook.com
 (2603:10b6:610:7b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 15:37:43 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5%6]) with mapi id 15.20.4975.012; Wed, 16 Feb 2022
 15:37:43 +0000
Date:   Wed, 16 Feb 2022 07:37:14 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: ocelot: fix confops resource index
Message-ID: <20220216153714.GA14638@MSI.localdomain>
References: <20220216082020.981797-1-michael@walle.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216082020.981797-1-michael@walle.cc>
X-ClientProxiedBy: MWHPR14CA0070.namprd14.prod.outlook.com
 (2603:10b6:300:81::32) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a9f0b62-5668-44d1-051f-08d9f1624581
X-MS-TrafficTypeDiagnostic: CH2PR10MB4277:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4277F9891B441EE953073749A4359@CH2PR10MB4277.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKHYmuMqtaYlmRTTEJz0/PVFkB270x3ez1jSPo6GqNYDl9iRUPGRL+tB32fn0WDFpv+JoKP62RfLYVVwB4I/ByNsbqLFanK+o5zr3BMRO29BpVqa2Lotc8iMUc1V998IO2LgQJEeeG4MpSiZh3fKzu5cLSzGHuhOArkOkMd9VuRN/Q/vWyQ9SQSTAWDBtGvGXZGCMLW/R2QSI9FzpsZIWd3dl4iiK02ttlS5wnjCwyycr5NC5YSiBpz0gXaWNVfs/WoIBNCf176O6GdhiokGSM147WGU5RceLYUcIvKoQ3W0MM+tC03kPBVzB5h+TKWC/VpIIz/+YZK2PHhQYYCr2S7ShfohhJuKie/f4PlQBh8Kw5Lfxnjph49gqbjltNjGuGnNkirDnTv9PZdrHtSQxbvkVVqk+9NAFy/Hd/xq11n5elQbfPrWXLlTHrvzoQL/swP3QLfbVTiY8n6RKh13vTo8AxUD74J6+AwU0pKZm4ntgo5QCG9cv1v8Oob9SIZ3n8m7UTJTAke5CdkNJv8Bt5eYRVvCit8E3ycD5qznLURAoGNB95WbFeq2CF97Pw8Xs3Rco+S7q42he/Oh1AYEXZgZA8oDOFX+Q6mMsxfVjyUpxmHe5MdW8S9OksxSDPIa/66ZcTraO8b+YbKdODACFHZZAuV3zpfuxlE8X1+ABb0RInjoNt6q81YL6bkQOXq1wyLHYFYP69CIxAYIzEw9/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(396003)(366004)(136003)(42606007)(39830400003)(346002)(4326008)(83380400001)(66556008)(66476007)(8676002)(66946007)(86362001)(26005)(44832011)(6512007)(186003)(9686003)(1076003)(2906002)(8936002)(6506007)(6666004)(52116002)(33656002)(5660300002)(6916009)(38100700002)(38350700002)(6486002)(316002)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+0A7zFdJrK7SGk7rtH+2QK1AgVsmu3uEhWEHNyvp+RU76Ji8lvj3/N1nmMam?=
 =?us-ascii?Q?juQM7slgAgg4Rw1F3IC49fVJo4qJWlryQndHA8/xy+O6g1JzSDBFzBqThbMB?=
 =?us-ascii?Q?PXr1KmopbSSRcIf6JWPbikqpzevH6lzN2FiV/CF/NuQl51Cnc7WiWRsTd9/F?=
 =?us-ascii?Q?ezB+hcQyGRqR7UpDlPzdueDk6P5YxMxGj7t6o/IgadSlpwh+uPHVd2kqqYYU?=
 =?us-ascii?Q?xqggNqiVbSU3DzKca5sFPt/nsTnwVzdO2vwVQZYlEKKT/c0mj/ZJfUlvFKSz?=
 =?us-ascii?Q?63pnf/uj/ZjJYdeo+ILIICSGbSHR2S6Hox6k9RanmQspHTj/rA8wFP5KA1xL?=
 =?us-ascii?Q?lRDQ+iUnIcH85HOFdElQhxkiOzfwj+Zk/O6HaouV6ppFLL6SpYv66spHXz/V?=
 =?us-ascii?Q?JNje8EBTAcSVIS7fueYh3CoOdSIy+sZ19SUl3SNQS+T+Ld1K3MWLPvVh271I?=
 =?us-ascii?Q?+d4yBDLCklo1G6SIPjnPsDYIs/uDyDI/ePt6MqkrFzqCRFfKVreyRTxwEMKG?=
 =?us-ascii?Q?bLsV3fd/2amLBx1SvKGZQ/YgHbyRHLu9xjKjsSwfDQIDFTbmHRwNl6HOen4o?=
 =?us-ascii?Q?C0d/3GaYQazhpOQMPE2dOB217s3nahu4UHnN7Vk0OSrJTW20rAzVQ1WwhXm8?=
 =?us-ascii?Q?Jd+xZ6lDz0xdF4mv27PueJHiD/jcFSifn1sSb/6mo2cwR5usxjrKGHXiw6kX?=
 =?us-ascii?Q?vGzmBGpwlPJe0FmXqAoUD2wnxSL5jK9UE+2JeavF3Zb7t6Ti9HMZEmtQ21L2?=
 =?us-ascii?Q?wMe/9rXSTuiOFDWRM/xvHWpBQiQGoVeYxQIvXkGKer+5tk5EEG4SXBivP5Oo?=
 =?us-ascii?Q?OyvlLNQZ0l1/HMGORoHWAeaUHrVXbrvsKzLPvN4oIwICaM0Beenr4B5zfeJz?=
 =?us-ascii?Q?MwCmniyGq9igb42XckiTSdBRKjf3IZZ+WuwtNq2Xy6hSYgd93EeRS9JzdJYx?=
 =?us-ascii?Q?/PNSwQ7Qf6SzqsUGreVcbUskTnfM+rfHGPr9NFLflhzKgmJ9plYRHIvffK2r?=
 =?us-ascii?Q?yW4F5G7C+1xQ1KyYWZKcPZcASuHBKP2c3jwwjTsp1qrIEqvI1TgUsDhfMDIN?=
 =?us-ascii?Q?/vWuF0mEKnY/7vC7W8vVW/3dEfa1W7mnY8XwmqX0nqB2bf9neVOw4xrrHQTg?=
 =?us-ascii?Q?Qi0ZcFGib6X/HKb0vxqZwWDPZo+ndtjXXC30RmMFw7RrOPRCOyFFYcZGjp5u?=
 =?us-ascii?Q?ke2AGpc+ZThRO4HMFkDYunX8wGeJk0x9VQNGbreFU8Ti76cYs2IqNn3u27F4?=
 =?us-ascii?Q?vBhLjtJvXAmNMH5nW9mJrdw6QfuL6jlVipbh2nteTHhob6Sqq/WbFB4h33dU?=
 =?us-ascii?Q?GI/LLgMepCT2ZcJBF7wnOyun/KbS0wcFrM213EBw/hyL6tevi3x+Z8jca3lf?=
 =?us-ascii?Q?vtkwhiPW/Im6eFQ41ips3a0w0SNWzoi5nDx43PLZ9XQIEW+BhL6xc8vKRKF6?=
 =?us-ascii?Q?qyZTqE5QCSCy7vvaPjeS1VMck8+g91dHH7W46gKkpQsiMIgtO7nsCfJSvld6?=
 =?us-ascii?Q?aI1LmbRQq6ovfGfzROsAFxfrJnx0ufbOo2S+fBMJVEk7RxfiK4YPKVzceDJu?=
 =?us-ascii?Q?+BLT6ISR5tPfPn9W3i0itg68jJWUemVjnEALvgRT8awgGR0lF81XGMizjEcr?=
 =?us-ascii?Q?jnjbf56irRuEVLWcLT09e7VUk3DHs0DEkBRbrWhxVYpVGr5Xi0sctFWispZp?=
 =?us-ascii?Q?p66yRQ=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9f0b62-5668-44d1-051f-08d9f1624581
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 15:37:42.9495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJVSa4OCmopl+jRRyleeW+188trlY2Q0v67Vc5LUo3+mD3Jiv3lyZv8xzza5aQst4juLrEC5evJUL4f6a/KNOuf/EH9672svRczuchjGRU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, Feb 16, 2022 at 09:20:20AM +0100, Michael Walle wrote:
> Prior to commit ad96111e658a ("pinctrl: ocelot: combine get resource and
> ioremap into single call") the resource index was 1, now it is 0. But 0
> is the base region for the pinctrl block. Fix it.
> I noticed this because there was an error that the memory region was
> ioremapped twice.

My apologies... I missed this and didn't have access to hardware to
test. Thanks for the fix.

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>


> 
> Fixes: ad96111e658a ("pinctrl: ocelot: combine get resource and ioremap into single call")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index 685c79e08d40..a859fbcb09af 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -1892,7 +1892,7 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
>  		.max_register = 32,
>  	};
>  
> -	base = devm_platform_ioremap_resource(pdev, 0);
> +	base = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(base)) {
>  		dev_dbg(&pdev->dev, "Failed to ioremap config registers (no extended pinconf)\n");
>  		return NULL;
> -- 
> 2.30.2
> 
