Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C385368FF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354884AbiE0Wof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiE0Wod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:44:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363EF6F48D;
        Fri, 27 May 2022 15:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXNiVnk0cAksxw+A6X77Ygxrf1xPZCqlC6s5j8yYBLCQaaGSWysW1O1qnBNsROhib6abO9e0kSrukIjlMCTRwr6Gt3VDYndNEAoWwmfSP7WdfUFXTVbTY8n0Dv3VY0oF24EmkJf6AVs61NpY24imhjd6zUBzcRv8kh8F/5DLQUMxhBK7oP32cSyafavgjSvuH3fx9opXxOX99x77Bxj6sHFE8ycWmE97jgJPK0cxNj/uoixC1VbXwrYkxeO1vo+99MtqNXZZBVvJJYi13aLn2bfID412hgs8bTMeY9FRdYlKKqZHm1GU65gBG59auSI+Zai8uRZtJnDDjVxhZgVLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiW6GRWsyCmzpqichW1KqMmj2bJWuOOGumddGVp+sUE=;
 b=kSPTIdjmGOtTrFR0WS7jXHDi73IBy3tIjf107KyABap5QSCDYopX0Cjb/lRGCI+xwN3vAOiIm7kBlKNkjyGLEajxWKtoeQGhYPOksiT7/n5deC/Y7fj6oR0zOmPByC8USrkn60RZ8EZnl42YWnQFyp4fNzIEyHfQ819Aex9Y+sle+akZ/ivBKEBLS14xudSZmUNvLvuKMAqX+KjITjKQlQ0MORSMTaaP1kr9UmL191uCahzjj9oO/+vEdwjZ/4GLLlEcakEDyS9Q2Y8fMmgLavLYeLkHutCkWyBdyb1MiTXw68qbvQyc1eAuhRfjX5ugcv5f51R1uZRyFoQLhdv1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiW6GRWsyCmzpqichW1KqMmj2bJWuOOGumddGVp+sUE=;
 b=vxNZQJ/NALiGuWC1pSRjdmWf6IUHHR1noXE5xUWfgQobxrADxnYk3u5h6WQE5mTxV55hFWsdoHexcmPVS3eoEa8GYrzmLw918krobqYJpGN4yHyeSwS/t7xxT9xEyRN1AyYbc7gAyQKfLoq5KdGAtgXbxwonuj3pl90Ffz/dgq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com (2603:10b6:4:7c::37)
 by BN7PR08MB4260.namprd08.prod.outlook.com (2603:10b6:408::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.19; Fri, 27 May 2022 22:44:30 +0000
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::2cfb:31ad:b481:561]) by DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::2cfb:31ad:b481:561%5]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 22:44:30 +0000
Date:   Fri, 27 May 2022 17:44:21 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] dt-bindings: input: use generic node names
Message-ID: <20220527224401.GA395557@nixie71>
References: <20220524093136.7980-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524093136.7980-1-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: SN7PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:806:121::21) To DM5PR0801MB3767.namprd08.prod.outlook.com
 (2603:10b6:4:7c::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55a2d211-c335-4b7e-9e0a-08da40327621
X-MS-TrafficTypeDiagnostic: BN7PR08MB4260:EE_
X-Microsoft-Antispam-PRVS: <BN7PR08MB42602AA49599629F5CEA142ED3D89@BN7PR08MB4260.namprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnbcqYuc63BlEVAwS+vFtrB+7RzPScKO3qBmFsad8IiJhJpUpkyoDmTWM1E6DRgfVWAUL4l0g1QWHFtOduWYXP4o+aW9Vv1ba+tClMp55DoAEmhDph50P3pY3vNpSF5mXe7DJqPQ5TUli2683BRlKTiizRn6nxfMi1zlM8yeKjwLHOlsrEH4mDAT8e/1BjhMPX0gZ8ZesJAeHQ1qytEBL1BlBrlCvDy4pke9mFHDOe2GSOpPB2N+iU1AN6Ii3LtErtjm7FPkEYSkbrccxZ/XVg7pxWxenyM7UkLYbDhKd0IBZI3UheSh4YmdIwe6bZE+v3PkGtrsr+zUNioBG/ths5KC0XS+s/SdxVJA+rF6C3+11OmJCTD1xsYDvt7Bfs0Yr5UtI+EGMppHLMBzT+qRiQib4PMR5FMZ3a5J/XIlHgq0t9J71i38flne8tQr/wshyUg+czwdA3bVo0hhWowLYM+DuzDtW/4HBNVUzRcobWOP+4r6IRNJwahM9TOq6xMY+bAceOd01sGLPdfmiuay8htOU8bgvCk3DUYwRW1NjSzZnfX6PVj2WnnYlLTXo7dgmMTQrQR8t7YCU1ku/3l7fl9a8l/z9sDTkqzjAT1/h0wHs4BTWfCJcsVos/79H9QjzR+hkHkAOfIcSLMqHOQkl7J45mZZjlBokj3Rf44a6JPR4fgp4iuHiQspmsQkG5cdfGIFzRHmRyFPMX6VSlvB/I5Vbbot8zgbxvHij17UYWPyNpobuiDpB0u5Lf1suEFF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0801MB3767.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(376002)(396003)(366004)(39830400003)(346002)(136003)(33656002)(33716001)(83380400001)(2906002)(6666004)(54906003)(6486002)(5660300002)(508600001)(86362001)(26005)(8936002)(316002)(38100700002)(38350700002)(9686003)(52116002)(1076003)(4326008)(8676002)(6512007)(186003)(6506007)(66476007)(66556008)(41300700001)(66946007)(6916009)(41533002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+QGTKKhFTljV6qxjRSUWtPhTA5QPzlVLFV5k38uPA3hvVwURGZw7Ug7imyBL?=
 =?us-ascii?Q?jz8eRs21EoxdhPLRl1sqwXevmdEdYg2+NZUrdPwgmKHj6fLdnaIRSXuDQCQi?=
 =?us-ascii?Q?A97lgC47rQsqrzBou3A3tR8JIih3W2/QAWe1FEROAk/x2GNMmxmYt6wWExym?=
 =?us-ascii?Q?tiTjom0id00NXsRmC37igXazetMxeBaOmuCh7LiqFOlJqJz4luMQjpFrFPMw?=
 =?us-ascii?Q?83bAY9LO8uN8AO3pXfgkOzFQs14/uzclWbjskwvaYJjz0fym2vHX2ZJh2tNZ?=
 =?us-ascii?Q?B5H91+m58xBfW3QEzL/kaq7wkqOQyzG5mCs0sh3CQHWxlvlgMvzCARH+t+Fv?=
 =?us-ascii?Q?a7x6S9pFlj1rNA+Xq285fNrlbdMqMblIE9kpw8cf/7DKvio1hFGbWJ3Cbz76?=
 =?us-ascii?Q?xXSBNF/gVwszS7S9u76r0EOjTbiw2PC7VzYsMEzeUmxDJ1lABhfVBrCK0qQe?=
 =?us-ascii?Q?00xyG53zYk+R424Q4WuGZH9NRziIPuRzUWRsuy0PHIlRZrN5eqsS1qKimJMW?=
 =?us-ascii?Q?dmMvCWLJ8NYWvqC4/Q+o6XGM7Qdo0rP4/GVzf0yfPKIc7EsH/4/EeK/lai5e?=
 =?us-ascii?Q?4lx92yrzVooLEEcTBBiRNoeUke3kcW7LJPWXtttBmCDP9rHb6xQsFQ7pjvqA?=
 =?us-ascii?Q?G9oNp9/8S1ML6z9qWzrwiOR5GMVPRPu7bpoeSkS6mSnfLoKxa74aLTvqXygI?=
 =?us-ascii?Q?dHPvGSCVCv+GJ56ZKItmOzXDKlUNbXF0TPg/Ig6p09ylghRBu9enItUoUoZ7?=
 =?us-ascii?Q?0fQvqRo3Kc9hq6dzYNOs7+UU6qF2ASRRD+7TayKIUJJb7eiRhc0s0nQnO6CJ?=
 =?us-ascii?Q?DbBR0674RQ+eam9jNPcC58n1+DQNh5Rc8etsOUSEogWkVfZ3QgvnIfYkBDoe?=
 =?us-ascii?Q?5HFxGE0ds/q4eg39zT7dQTTgoYaywReh89zJOSfwFyXOw9KfB1DHRbZPLNqT?=
 =?us-ascii?Q?MsKiBrj7LdjHf0DYAFdVWK4vX/iUwsVaZMdl2oFU78C69M/c7ff982A7mPZQ?=
 =?us-ascii?Q?pG3JSEuIjeVeZovbkwc9lIbMJ3YzGHIf6ifUlZZ73MD0LLUkbOF2AcHXEGZ3?=
 =?us-ascii?Q?en6gMdI7VF9gyECi+wkMjBF0Ns5iQiJ5Qsshh4eJIGBoe8QtScsx8ygRLo8k?=
 =?us-ascii?Q?0VMZlu1aZ5jMuA39mxiJPX0POWk61Rru7S5kR/2eEreBr3lnziXo9MliSx+F?=
 =?us-ascii?Q?SB9O4d0BA0+VxAMmC65FwrSoTEtZ3NobCZyJNhPdKHSjubaIWVteAf4i+zvB?=
 =?us-ascii?Q?y/SoTDSaE+TQU/bMub1ILwBgTh2TMHy6uL2LKcag82T8RyGpjug7ZX1X44Hc?=
 =?us-ascii?Q?gMcv2DHatl7LNH3F9/255Kglx9V/yBUwmKgYKJVMn8n0tlOatu+0HSpQktI8?=
 =?us-ascii?Q?tVuCQLWOO70/CpcrxB4Jrlrm4y2M1binG1aW77N3xbkGWB1k37NZuhPs9uhn?=
 =?us-ascii?Q?CjGnzjAJ5FQEVaGAe4KAmLfqwDRQhQurpfMBs+6zSEV3P7+W1sQcT8YH0kzE?=
 =?us-ascii?Q?MbHtFJk2XsOLcKifbLSb9+XM22wVcG/eEAcygvjr4HDgaoaO/AElIRPxjGAT?=
 =?us-ascii?Q?BrwU0HG7yJ/sV5wjum/aAK8/+nIGWGtXAIQePGnOBO2u5TCClgtcfxDbcYxO?=
 =?us-ascii?Q?3MjmjWeBUAue2XoSP5pEBM+KYUQ/kL/ShgBbjKE2jc/pU0H39mfNUr4mRk/i?=
 =?us-ascii?Q?4LbDztmwcKaHdlL4NySCw3CtrBBcexsoWXuc81NlGsa9rCsqkBfWlKz6R54M?=
 =?us-ascii?Q?75glZfSyGQ=3D=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a2d211-c335-4b7e-9e0a-08da40327621
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0801MB3767.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 22:44:30.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQaDiEWjYtyRXOu9L44D4hOBT4MEpXdoTZA6SY+C5feDsyA5sfoFgMTX0so2gs5Nh+GD+aPy/oF2jCsj8hdhgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4260
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, May 24, 2022 at 11:31:36AM +0200, Krzysztof Kozlowski wrote:
> Devicetree specification expects nodes to have generic names, if
> possible, so replace custom ones with something generic.  For gpio-keys,
> the more popular format is "key-xxx" instead of "xxx-key", so choose the
> first one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/input/fsl,mpr121-touchkey.yaml        | 4 ++--
>  Documentation/devicetree/bindings/input/gpio-keys.yaml        | 4 ++--
>  Documentation/devicetree/bindings/input/iqs269a.yaml          | 2 +-
>  Documentation/devicetree/bindings/input/iqs626a.yaml          | 2 +-

For iqs*a.yaml:

Acked-by: Jeff LaBundy <jeff@labundy.com>

Does there happen to be a list of preferred names based on device
function, or is it simply a matter of what seems to be most common?

>  .../devicetree/bindings/input/microchip,cap11xx.yaml          | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml b/Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml
> index 878464f128dc..5139af287d3e 100644
> --- a/Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml
> +++ b/Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml
> @@ -57,7 +57,7 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        mpr121@5a {
> +        touchkey@5a {
>              compatible = "fsl,mpr121-touchkey";
>              reg = <0x5a>;
>              interrupt-parent = <&gpio1>;
> @@ -77,7 +77,7 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        mpr121@5a {
> +        touchkey@5a {
>              compatible = "fsl,mpr121-touchkey";
>              reg = <0x5a>;
>              poll-interval = <20>;
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> index 7fe1966ea28a..93f601c58984 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> @@ -127,13 +127,13 @@ examples:
>          compatible = "gpio-keys";
>          autorepeat;
>  
> -        up {
> +        key-up {
>              label = "GPIO Key UP";
>              linux,code = <103>;
>              gpios = <&gpio1 0 1>;
>          };
>  
> -        down {
> +        key-down {
>              label = "GPIO Key DOWN";
>              linux,code = <108>;
>              interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> diff --git a/Documentation/devicetree/bindings/input/iqs269a.yaml b/Documentation/devicetree/bindings/input/iqs269a.yaml
> index 9c154e5e1a91..d84d69f5455d 100644
> --- a/Documentation/devicetree/bindings/input/iqs269a.yaml
> +++ b/Documentation/devicetree/bindings/input/iqs269a.yaml
> @@ -475,7 +475,7 @@ examples:
>              #address-cells = <1>;
>              #size-cells = <0>;
>  
> -            iqs269a@44 {
> +            touch@44 {
>                      #address-cells = <1>;
>                      #size-cells = <0>;
>  
> diff --git a/Documentation/devicetree/bindings/input/iqs626a.yaml b/Documentation/devicetree/bindings/input/iqs626a.yaml
> index 0cb736c541c9..dd727befe564 100644
> --- a/Documentation/devicetree/bindings/input/iqs626a.yaml
> +++ b/Documentation/devicetree/bindings/input/iqs626a.yaml
> @@ -751,7 +751,7 @@ examples:
>              #address-cells = <1>;
>              #size-cells = <0>;
>  
> -            iqs626a@44 {
> +            touch@44 {
>                      #address-cells = <1>;
>                      #size-cells = <0>;
>  
> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index d5d6bced3148..96358b12f9b2 100644
> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> @@ -112,7 +112,7 @@ examples:
>        #address-cells = <1>;
>        #size-cells = <0>;
>  
> -      cap1188@28 {
> +      touch@28 {
>          compatible = "microchip,cap1188";
>          interrupt-parent = <&gpio1>;
>          interrupts = <0 0>;
> -- 
> 2.34.1
> 

Kind regards,
Jeff LaBundy
