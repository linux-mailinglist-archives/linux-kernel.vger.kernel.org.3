Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD3544119
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiFIBen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiFIBek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:34:40 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52D21AF6EC;
        Wed,  8 Jun 2022 18:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INXeP93aqp5MaWuhD+NT2x2l4x8bvghgy2YTiqBVrH8gTFG5g/btWIzNRtTd+00renzhGeXMxLso3cTt99yLIWGtR468Yyu27vFjZldfFbIhOmO5DS9I9lUkSfv2IzXU0dMVwxEbutrnqd65E9zXNU63Y0jfpazqpX/imNwqkPimgvHMyCHr0D6rZSh5tVoNaq4CntS0Pts541uxLAD6MK+t7eJD3D4x+8SiuXEi06wwWSkmXk7yUTm81r0OkDHr7/8JJZUU1U5ig8YL2klFAO2BtpAczR0wv/2+v9IrLOfjy2RZKwz6ZIi+UrZhlSA95i2X25367ij78Nore+8Rag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWVG6KcFC6R+U9pEjlO855iOkShVQhVEhiSVS5u6P1I=;
 b=iY+BVKwjWUfahW+6ZaexV0Krw2c05G44Vkvv5nGOrAlHG1r9JPKD7AjZ5ALfv+4YHpFBLdMz5D4/GIGzfbb/70Ig6kYBy9ak94ypuX6v2FFxR6fHcNhWnDJgHvEJAdi1kBJDa1jXCrjqoVoa67XzUIJw9empw1KiJ7NiM+P8M1oRQdf7zNZrxIWKSoZjrUURANulTA745QGJ3xrddninHVoYKot2RS+3loGJxWob9oITBnx0IVkohPPsNcn6Uw5+fKroD0K0VatT3F/51AJUMmtg7AAeQI0OV9GL3DA9y5dDKmurJD89VM/mACdE+DIz2484yTUqXgPgGX9ABlz9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWVG6KcFC6R+U9pEjlO855iOkShVQhVEhiSVS5u6P1I=;
 b=hVoCUWGoxnKKtUa/CBmvPA4hF7QarnTkPk1b0vO5p/mH0KpcaVRFKBaiFqjSpcLzL7uGQAEOrgQzTMTb3Rs8DRdrRtBo5/FTvJbN/mmqCU0Lzb1VEptkwljzLe+618TovA5+NCbFrEaAOaqYykQPJxBh0t/jJzlw+Uu7S5OpGmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SN4PR0801MB3838.namprd08.prod.outlook.com
 (2603:10b6:803:50::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Thu, 9 Jun
 2022 01:34:38 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f%6]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 01:34:38 +0000
Date:   Wed, 8 Jun 2022 20:34:36 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: input: Use common 'linux,keycodes'
 definition
Message-ID: <20220609013436.GC191119@nixie71>
References: <20220608211207.2058487-1-robh@kernel.org>
 <20220608211207.2058487-4-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608211207.2058487-4-robh@kernel.org>
X-ClientProxiedBy: SA9P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::26) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0c11c20-7d5c-4f46-2212-08da49b837a0
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3838:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0801MB3838424D2A5FB4E42D447139D3A79@SN4PR0801MB3838.namprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGcToJdo7IJL1wItxgxAlZVQ5kJT//oruqWH+d//aTOJTgIplkM4EUJ7TO/oAQogZZEfqsic9t59nLKqR4arhTMBckp7FD4hLEcrSBs2dXP05AQUe+XGQemiQu2e8/KFFMGgqHhi/MRVKTgRhtg9mIgYT81uBgpW6amTTyiWQA+d7AgnVczHURShz3s92u37/LrBQRB9UAfLXpxKGDhLl1S0pEiNVkEwVL3h/sSWPk9YdLG+iVPlRM+DkSgjjm2ksQepsxW8k3FbaFy3OuLphSblEXjCfxx1JnwP9zRQpNzR9ZLT8BfJnOYxp9DFQRGh2XxhCBh7EO22AwJtl+lMe19oWUs+QHvsJJN3Y661+4LIS4NCzRQyou95C3KOhPTTt9mSY1opLhz16FrZuFSxYXUZdehkYh65Kkc9ryP65r0syocd19Enbz1GBS7lL19zIhPpfwk2XrkQw7OlQmZ9UOmPr6M5idmxdgYgr02HJXWIwFRUyDfuswqY3jmickU5WbAO8fyLCiPeEi4bZQvpP+mf9YYVAqpH2nHzCSYIzhET7OecOw9/Kfq4Gny3OaOoRRSRPk4VjdH2JkhUfBBmW25bACx+QgaCe3lNnVJ6VmrObsGBodFFkHVR3bEnmwsfb4Mo0Ha8Vxf5hgCRDYxrbR1VSZ9bZ+jcz6YOUkaN57HslGiTW/7aj7Ww8+nKOUcyFjioUqT0lDjR9oSmK1SKhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(346002)(366004)(136003)(39830400003)(396003)(41300700001)(38350700002)(38100700002)(7416002)(508600001)(83380400001)(66556008)(1076003)(66476007)(52116002)(2906002)(33656002)(6506007)(8936002)(186003)(6486002)(86362001)(26005)(5660300002)(33716001)(9686003)(6512007)(316002)(6916009)(54906003)(8676002)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TZiha1IuIsafJpcvKEXP7+PsNioEZG2mk/Xbw6dqshkKfxWqCvzGgYqLwAH5?=
 =?us-ascii?Q?XNsva+0+1Bs5vvVH0dPl1plyQHwBcyGalEGZQSboji93bOWUd+Og9BFViaxN?=
 =?us-ascii?Q?D892vVjm4N+1jWegDH9DZfG52/38Cso2oTSK/LIMOSTKLuixtxypmOS11J1Y?=
 =?us-ascii?Q?AmYmYou1PwP6lINNqkx6X+Dd9+X4E99RXigCIuqhJSWwFVjTxYFutG92HoSV?=
 =?us-ascii?Q?akeIPN5Cxd1B17ngxM0UZ3sdM3WvETR2MvkyJBLiXn6hu2ER0aOpWyV4frFw?=
 =?us-ascii?Q?BLuZrHlT+ckLtsk7SItEBt3P/PA3JAiTy+3STKE1APQtne0mafQ/BuluyuTF?=
 =?us-ascii?Q?Ik8dSJSi7uq0LyQFZ5X0EtUT+rwc74WZ8jrCdXUhWfDrhKNewagwo1AbIja9?=
 =?us-ascii?Q?h+o74kBIXJSJT/ht3X2oo2nZHj4dsUMKRY+N6hliP3yCuZF1++NT0uOIMscW?=
 =?us-ascii?Q?VZ0gH+kteBJAsc0n+RMID/PF5nDiEEJmXfRZ54yzVW65Uj9ZDWKWhOWDsYXO?=
 =?us-ascii?Q?tp6h7vHpJcm9KZCZ9VpOMoCxGmCiwRkyqHYwoIGdax9hvtsp3+gyt1BCrABm?=
 =?us-ascii?Q?XBCWCqNbRaPPsrkA+HysJWdjkv/0DWVez3Qf8LFuHAzTyi+aHUmGG1ASF2jf?=
 =?us-ascii?Q?8LmtSzeX/nIbadcoUE23lr09XI1GV5Kmi4eA8FiLFLqOSIry304/wDjL5fBv?=
 =?us-ascii?Q?Z6GzwclgfFigVOrsJeb+lceBb5ho0g1BZ5wKhp8T9rQx65BXwco0IjVT1omD?=
 =?us-ascii?Q?aKKHNiCUYS6H7uSiycs4ryEFPu6saCwtjxVHYbT0U8yVEFF54BVLQrwcLO98?=
 =?us-ascii?Q?1AzA4h7Q6BHJ570UreaKlUVp0DgI4P1hBFSEfZ0t2Td8kcdApSYsrbkkd9ZS?=
 =?us-ascii?Q?oTY3RUi5b0pBpdb+mOBKlFVxD6A3VokXx/20CV2S30iEWlfAd0XzkBV+QBzT?=
 =?us-ascii?Q?/wuCMQw1FPtOZAly9+hvziDnNVCe83h0kkCrdYZ8BsaIHzJi3niFAeeNZcfn?=
 =?us-ascii?Q?R4yZrqreUBhA3xWWhEJNKkOKnQud7UaCkKjMS5CEcHEH155FtIDW9Mhg5vMb?=
 =?us-ascii?Q?8Cn9xqiE85ytzHccCVYYSjkgoiel6KWfKzKBCYuB8iCPxBpe07GNCtjALBIJ?=
 =?us-ascii?Q?PnfmAg566DtTrsHIUjl6md4mk1NO7R1hwuFS4jcJDzNCTU89zgELE0QglTkW?=
 =?us-ascii?Q?cRlxQWnFqrBbIC+5Z9cgZHqo+CqWpD1mWx10IvXPfKG+JTm4ymHQ+bXme4Ig?=
 =?us-ascii?Q?n1sUPsVjy5jVlZrlUpUbRSHOvybIkqrKYdX399vjrY9yEegS9D7BulSM9+Ll?=
 =?us-ascii?Q?wlM738QFfe1ShfIZPUZeZnsNMyRY4Gr1XIJaZduCfEHEyW2nBs5X72xaTs46?=
 =?us-ascii?Q?KyjeKufo8f62YsZP4SJZqaHJOx3S7Mnhp1O60TRaQ/TaTmQoWCPfEUT+0KSu?=
 =?us-ascii?Q?H8SuMpitH8+rAEcxPNLmXHP7VTx8hSvNpm+y9VYPKDtQcDOKNnqz3ul5eL24?=
 =?us-ascii?Q?FhniGcW1W90cfh6Ru2/g6WuiLBjHD+hl8JxU3Aj8QndLy+80dHN8ElNl86kJ?=
 =?us-ascii?Q?RIRVzGHsOaMtOMoODpY+AFz3FIOdL+KzVCs8KvaEc88DYQNgs+tHIsbIMlgm?=
 =?us-ascii?Q?S8Qc6OkEsG76ZNv9Uuny9dRLWvggjG94do3r4re727Wmlao9uALCp8MrlTs9?=
 =?us-ascii?Q?1ap0Rxer3Ss+qdirNCqo1TgYT1k7JGLQyeLG3VBEGeoRq+sOnz6g73a0bn8X?=
 =?us-ascii?Q?0/YfV+LHng=3D=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c11c20-7d5c-4f46-2212-08da49b837a0
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 01:34:38.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJYhCf+Vw6ifLMYQokRz+qisB8+BErngvlV63uYdAp6g1ZZ20KAUzPbXMeEQLDg+nxT2tlNWaEpHt4lcDKxz+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB3838
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Jun 08, 2022 at 03:12:05PM -0600, Rob Herring wrote:
> The common input schema, input.yaml, already defines 'linux,keycodes'
> property. Update the users to use it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Jeff LaBundy <jeff@labundy.com>

> ---
>  Documentation/devicetree/bindings/input/iqs626a.yaml     | 2 +-
>  Documentation/devicetree/bindings/input/iqs62x-keys.yaml | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/iqs626a.yaml b/Documentation/devicetree/bindings/input/iqs626a.yaml
> index e645521da8ba..008959f2d425 100644
> --- a/Documentation/devicetree/bindings/input/iqs626a.yaml
> +++ b/Documentation/devicetree/bindings/input/iqs626a.yaml
> @@ -510,6 +510,7 @@ patternProperties:
>  
>    "^trackpad-3x[2-3]$":
>      type: object
> +    $ref: input.yaml#
>      description:
>        Represents all channels associated with the trackpad. The channels are
>        collectively active if the trackpad is defined and inactive otherwise.
> @@ -678,7 +679,6 @@ patternProperties:
>            Specifies the raw count filter strength during low-power mode.
>  
>        linux,keycodes:
> -        $ref: /schemas/types.yaml#/definitions/uint32-array
>          minItems: 1
>          maxItems: 6
>          description: |
> diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> index e677e31fe8fe..0aa951f0ab92 100644
> --- a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> @@ -9,6 +9,9 @@ title: Azoteq IQS620A/621/622/624/625 Keys and Switches
>  maintainers:
>    - Jeff LaBundy <jeff@labundy.com>
>  
> +allOf:
> +  - $ref: input.yaml#
> +
>  description: |
>    The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function sensors
>    feature a variety of self-capacitive, mutual-inductive and Hall-effect sens-
> @@ -30,7 +33,6 @@ properties:
>        - azoteq,iqs625-keys
>  
>    linux,keycodes:
> -    $ref: /schemas/types.yaml#/definitions/uint32-array
>      minItems: 1
>      maxItems: 16
>      description: |
> -- 
> 2.34.1
> 

Kind regards,
Jeff LaBundy
