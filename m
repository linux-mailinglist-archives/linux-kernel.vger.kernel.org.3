Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9674B5E36
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiBNXXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:23:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBNXXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:23:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5DB13C3B7;
        Mon, 14 Feb 2022 15:23:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmhSK5EvdJvpupyUB3RGq6XYGHrVput4hHCJFgBatqMZ83FEfyq70ZGvT3n0mOTyYyRz8dwkQLfHYHOJ6/L564B50uVZOImj6qJysQJkC783lWU2GuBG4N6n4gwgYoYIljc/mfFRQA85nPIU7AN7w1/GHBa27HDbmHeoy8I2Vn+Jxj7VE0fqxpHiaoXAHmhna7eVrv5PFh1y0/cjdmxd5PUItMiKldEKlc5PEKK58tE5vncPfa6Ewdme+4B/s6xkzndFNG5ACdBg2MLmsoaZ/j7gQS7FCkPaSmJqEgtGuqOVB/+r0voFr6DjpoH5n0SgK/pTO+Mo/99+dh8t8frHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxdzs9bkvfMn7wY+xduUITSPic/i/42/o68/mWbVp2A=;
 b=ZAu02pnE3Bg4+smakVACoCV5yZLm9GMTCoI/++noDwb9R2i5zzdYW63RESNV0EqLnXap9/7sZSE0cZ7yNZByg7iepG1/ZIzW/scLJI7SELoLroqGCxwA3yYW6PRtBS6MvolfDmRzJ8ODg09iRNagFJ5C3ktfQ6Erg+hAPz7DaNHLDPE5OrB4/y7jPfH2gZWkSfsnAu0HkJ9MCD/hfEFVFTNxeczzA1gRsgOIYlpNQWZbqSZkfpwQU0/rRnHiamin9uCXst3MXdXm+JDi3xWFU9cenGi9kuMto+Xg9JRe8FBYk3sl8jQiwxVqq/OqYnIBthwl999F28ERVYDhFX9sxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxdzs9bkvfMn7wY+xduUITSPic/i/42/o68/mWbVp2A=;
 b=H7qgWFHyz3C6zy5fVNBUbeXSQxrklAF29lEvgMAHpv56pmCVM8IRA/VX7xzn2CQFKY9I9Kqoe83nW2b36GUBoOxczkdwQAwOd9twPdSkXCOj/3oBPwCdJQByYvB/pGFlIazs/pWN+VfSyrYhFzhXQJfNkHIbA4fwrHsbVsdpvGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
 by MW5PR08MB8190.namprd08.prod.outlook.com (2603:10b6:303:1ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Mon, 14 Feb
 2022 23:23:37 +0000
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b48c:eec:fcaf:3379]) by SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b48c:eec:fcaf:3379%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 23:23:36 +0000
Date:   Mon, 14 Feb 2022 17:23:29 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 04/15] dt-bindings: pwm: iqs620a: Include generic pwm
 schema
Message-ID: <20220214232329.GA5918@nixie71>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
 <20220214212154.8853-5-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214212154.8853-5-krzysztof.kozlowski@canonical.com>
X-ClientProxiedBy: SN4PR0701CA0014.namprd07.prod.outlook.com
 (2603:10b6:803:28::24) To SJ0PR08MB6544.namprd08.prod.outlook.com
 (2603:10b6:a03:2d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f359ca54-2047-474e-1e0e-08d9f011065b
X-MS-TrafficTypeDiagnostic: MW5PR08MB8190:EE_
X-Microsoft-Antispam-PRVS: <MW5PR08MB81904D9246C9FD4EDEBC7911D3339@MW5PR08MB8190.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0d6/SPUnspYrgZIa5JgTt97xuVgLGgrIo1lrdqE0Uk5fbyrgClDnpjSH7e2LRifLQeDIycK7gxkAyrPB5x3F01oP8UzDWOWTT7LsbgGUbwZwvPRTnf1jotEJDOBFmaMww9Ea8qXoF08pdNGoV28YlMfd3NJU1iNbFs/sbdxxofcUA3GPQ4QHKCGk6R82m5capLN3HGBkgt0z0FXtrWj7eNAkB7gjsKLFcL+pw/Uzw7smMaTN4t9Mwlnek1qCPZa0fGEX/MVnbfMyaO6bi7XekwREb4xGRpeeJFt2GsqXFH4OYqXj9Q+EjzYeD0bejXc1XNgpEP5KSDUtmuEuaZkFYOnNPAhzcwz21T4ps1vGq9WBPMfgwKdmihyrvpIWo0L04riIz4aVSnU//mCqlqU6ATGDSBxSfHIdTB5DdTDGUt6yNhmOVC5kvjhW9t5th+Cb4NQuI0S5q0ke0o0ftD/la9ICGmDkkgO4Ez97MNdo92HYK6Vr/L8cLNqih7DWxN+0+Zx+ZwXBTmxsANqGAqE2e0WOnqmnLHq2w3AbVsOYcdV21Z7DFnzHcJ3OAkxg45rVc8SlcfRc1k9fqofIUnW+3gnPT3KEBG36yq+o+aHjAkj9FqUyXVdYx2qJCFrXIZjJwGtga1r+Cvfv10TKPZhWOOTQSMo8bQeLAVcBH4+wTrtqAWs3xBQRC+KJSl/D7GzR0riKrf/o4B3C8avWLVW2MtFsJke4ezpl2JthIOOnd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR08MB6544.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(376002)(396003)(136003)(39830400003)(346002)(5660300002)(9686003)(6916009)(83380400001)(33656002)(4326008)(66946007)(54906003)(66556008)(8936002)(33716001)(7406005)(66476007)(38100700002)(7416002)(2906002)(186003)(26005)(1076003)(316002)(38350700002)(6512007)(86362001)(508600001)(6486002)(8676002)(52116002)(6666004)(6506007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ogY+BA6gi5y2wPOKb1wb9ztX+uCnX9UjZb5/0CCdxFnFb1fk6y8kowBLvt0f?=
 =?us-ascii?Q?9HRobc90eDzaQ+r+PgG1scjigIkyFLSgfFxQwYm994LGgOvVzXwbcn8sNAAV?=
 =?us-ascii?Q?kX5FGMr5VM4HWTL8O5bOogUxbh9CsWnjaxn+Ffc2J/4KacHecLYNZ6rUnYsc?=
 =?us-ascii?Q?h8dr+rklYrg5q4J+O84m7/8tFj2+hjQBqfeQvCfhJ1co1CgezQlpgM8PQ1ol?=
 =?us-ascii?Q?iDd/n0hyRSvUdRH9IqqPamGTnV5F0qA6pCIY76Y5ESzgkHEgJu87xRVZ/crH?=
 =?us-ascii?Q?miaV/RZpN1sLMDICVhyCdKGqb/mDyb/pdWPbC9/bPGWPnAunRT2cK3e2W2/E?=
 =?us-ascii?Q?iw67mOyP8mqPf0LWluzgfYWt95dzN28uE76BXA5RYuXhqrn1P9+jIuOFpbQQ?=
 =?us-ascii?Q?EQNExZChChKt0jVmqlHLSshFPFvAn4djeP5ZeX3A7IDjGpUaWQg7hVKoGHiB?=
 =?us-ascii?Q?skrQAToYO4FnzcSSdaurTtH+JS1RhkurMg9xOMdtbmZ5UmTejX/2OTiFXD6k?=
 =?us-ascii?Q?Li70B/arQL5eX5UdnollGPNdmuTKN28kOUqU/HMwalsqG2fp3UN2xLEkhNbz?=
 =?us-ascii?Q?+QTVjjstk6yV2nTyOeRYwAmRQnBVVGg5GWaWnwdxsVVg4ty9fA/qHSo9TAQZ?=
 =?us-ascii?Q?brPJslKJacR/UTivIIZ6SS8clbo4sQcbk1L/vy09rHyWd2jz2IiBzG2tcQrr?=
 =?us-ascii?Q?VIBeDXVfsjWEZFSIfrTJOMpgPN9Q+KZZsdzy3ToBz4UlGBoW6FUa89MLme0Q?=
 =?us-ascii?Q?YsLzfaNeQXt5MhHwqLKZHRQjyqJoMQ2K494UnOhCfwuEfY67OkoF7EivcOOH?=
 =?us-ascii?Q?zwgV9lDJ5T8DsFn5PmzrP/ohFSJLRlkftdIdFwB3QPYeaWZ7PRcnGV55p9/j?=
 =?us-ascii?Q?vpT4/UI+xXPVcEhQ6D+/0FESLfGi3XPMW+XF5KMaWEewGNFLFrURHXDPfgFL?=
 =?us-ascii?Q?tDyYlFtm+rrzZXG9TXXCQPHspgFhldTJ1m8685V5DcHLYvaUa/KYMsj69fg0?=
 =?us-ascii?Q?VsD6HpXdAdJd6VN5sfp9yzHar6XtEFEyX4eCl3jcV3PtW+CseNvRNT4h2zd1?=
 =?us-ascii?Q?OkwUGitOef9N3/2zcy4O5QITbFM+DdmNE8LJjtMfTAYhxZCZgX9Jp5idJrzN?=
 =?us-ascii?Q?TN4aEsAXXPYjXlpbEPV3QE2aR4L7aTGNlRfKiPIn3e/cTVMlyT2iWEv8ZTdb?=
 =?us-ascii?Q?puFXD06/sCQEYpaza8CWelB0s1dfRUS20vUQL+tS7FunedGHskbCBNlzS8xr?=
 =?us-ascii?Q?I3hWSupUvBZaewcIt0MoYEV++URmTobmd5qd2H4fLzrGjn228zw15eKE5FZM?=
 =?us-ascii?Q?+AquRLa7+25DmuOONR89E3tbzRlebb0AVFnSILEa0vY7ErGw7fTfWqMLIoGj?=
 =?us-ascii?Q?QRgEgfEfx09v5zZvdlE9Qu7lO3Y/+xPE9KmO/V7pW1Qr7nTwaVu/WeUiy/2M?=
 =?us-ascii?Q?VMPQaD/YUcst9Sl8aqKOU9+4/XGG+Vt3zOcYLr46q6vixQQ4Vti7SkHtnUUr?=
 =?us-ascii?Q?LX43EVN3qqyO8MjdpqIDDhvh4Ujgdy/sfyEqiSLaH89qqSvlXZxQY2ChqCtL?=
 =?us-ascii?Q?X0dVfk9kPoDwDuuNT4TPJ7JQ8SdLT2M7YJxtL/DS0FzMvjRCpD6+kDrkbkpH?=
 =?us-ascii?Q?ldB3tW9nGoEAH8FLbfaD5yE=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f359ca54-2047-474e-1e0e-08d9f011065b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR08MB6544.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 23:23:36.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgk9dNa/J2j9lbhaEm2FP3M3tZQPhi5hK7BuQvwmb6+prAjyF5Sg0/62iQNxSxaeptJhbW2rwDryM6XWkfDFKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR08MB8190
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Feb 14, 2022 at 10:21:43PM +0100, Krzysztof Kozlowski wrote:
> Include generic pwm.yaml schema, which enforces PWM node naming and
> brings pwm-cells requirement.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml b/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
> index 1d7c27be50da..0a46af240d83 100644
> --- a/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
> @@ -15,6 +15,9 @@ description: |
>    Documentation/devicetree/bindings/mfd/iqs62x.yaml for further details as
>    well as an example.
>  
> +allOf:
> +  - $ref: pwm.yaml#
> +
>  properties:
>    compatible:
>      enum:
> @@ -25,7 +28,6 @@ properties:
>  
>  required:
>    - compatible
> -  - "#pwm-cells"
>  
>  additionalProperties: false
>  
> -- 
> 2.32.0
> 

Acked-by: Jeff LaBundy <jeff@labundy.com>

Kind regards,
Jeff LaBundy
