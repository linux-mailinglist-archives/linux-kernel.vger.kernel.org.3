Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F6D544123
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiFIBiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiFIBit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:38:49 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AA612E;
        Wed,  8 Jun 2022 18:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhzOjLa8DG/8P7LWNSAtd+tRPkt9mDK4lO7w/JjwSKSSLeJ2TOXjqjnNV6xngk5sAvfwjU9Q0QUJtNf3gfoJbI86HkzxAWRpUuKCwxGnCt0eDSAIty8t0xCm7wa41OaTrtFebwdDJgtlteilN3dKsEvV1AJ2sFxNtj8lzvxdZS8oKWG70UAxrUqLfCkppeuq5qZHDabrRKQx0FzjgcIuBwgwwj2lQAz2ixc4PtxHt3oKOt+/SHDsmuhZDLkWSknI+CUdTD1cqAFHjh2Na2h9CPQJqWk6V+AAHZ5xfI/mtb1Tdt6OJeDoxiEel30T74RT/uMk2Bbk1QXFdI0/5YpNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTJSEg8+ZDcD1h0Lc+1JsV5xkDHgQX3ITpKQMpiG1F0=;
 b=MZSs+V4AH1ex+g7+Y/0bpuTLs+k3IHt8e/ptrpxUjMVavky4BBByh30if9Q+QktSF+7rliy7/vTubEzHWXCn3aqQEkl+gzYhKov3ILb4zMFFtOMZ3mdiohKu8nGBC52vtJuBkQYuPifwCj7Sd7UP4meAk8lYi3d4qXHXJuhn2eFOghuGzHlZGrGaJ+5CSI2pCrGpId/BZixj8QPSPsLP/57f2P8U2hV/fDkjOG3nVPOokIBdjGp3/u2kpySm1CmZwjcLyWSvXHjkEhN4Hd3hKVbDDUyyTceP1vDmyy0pu1ryATo8OCWKN3FVE5XlVlucuI5ANgVfn9JOsYPTThMZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTJSEg8+ZDcD1h0Lc+1JsV5xkDHgQX3ITpKQMpiG1F0=;
 b=oTZwAq6vHXMC5IQ7UP37diPp66yXwUM/4/KKndZLdAETLQCpPcl14g+soWnenmdpBjom1naIGLcl4fHL6odEaHCjgqGb+xtqo9nltV4krj/noMeuki4lbYxAgAgQGzzNiFrMLRNURODVYGsi5grdbbn4t6ZVyuVSKahrwIld4Qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CH0PR08MB6873.namprd08.prod.outlook.com
 (2603:10b6:610:de::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 9 Jun
 2022 01:38:44 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f%6]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 01:38:44 +0000
Date:   Wed, 8 Jun 2022 20:38:42 -0500
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
Subject: Re: [PATCH v2 4/5] dt-bindings: input: Centralize 'linux,input-type'
 definition
Message-ID: <20220609013842.GD191119@nixie71>
References: <20220608211207.2058487-1-robh@kernel.org>
 <20220608211207.2058487-5-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608211207.2058487-5-robh@kernel.org>
X-ClientProxiedBy: SN4PR0701CA0041.namprd07.prod.outlook.com
 (2603:10b6:803:2d::26) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca6c28a9-7d03-40f3-008e-08da49b8ca77
X-MS-TrafficTypeDiagnostic: CH0PR08MB6873:EE_
X-Microsoft-Antispam-PRVS: <CH0PR08MB6873F4ACA625FB8E979003AAD3A79@CH0PR08MB6873.namprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juFHmJs75Z+1mLxr4bv8XqFvEBtkCPMimp1A47hSfVf+0nL3/ru4410RG8/RpgspGJ5Vv88LNqHABu8/oYRe3xTe7ehRWKgUtwQfANvFyVwiVDasv4mR1agX7QlRz4bI9OXk2KcoPYKKCmigocy0UawtDhdWg8Q2rOgV+jdF8L6FCHfAPbLzv3PwLrqJgeUM+ByZPglI2AnVDHPWk8tNod/+Be/PI8BPCLLIjNflunUzT+EcUT1qbCCN/9Ca/aeDuz6icK/XyiC8VKpaeZo/TykYR2d4bjWq61SjNhx/+pVEK+Y7btkJoPXfl4+gthHdlPjORSwrlPRW913lcJiq5rQE9glJgdr1YzEocASgIdFwLLsb1stlxcFKug9m3pBN8pYcFRzHm8JtDNM1b02BRDwEDjxE3QoH5lzjPV6MZYOSGnnRJz5mZSffhKMvKmloAP/IJvE7BF07Ors3B6qiXQZ035qB8F0bPyyHWysJ2oqCUPLnkJrQ0b+3kConqbAzTzTlXC8RUPcZHz/c166yUPifEXe0oOWfmxqh8C2KcIinsBrcSmzoCcWOQaVuYSKXcUoN4UszsCkgNSwngAGsYrbrDw4N4mMJHfTp4puge2SYbz3D65xB9Ah5rRm/GWI+XucRXoRBcs0jPqvIlbtjHQKKaAbvlgv3ho0GOBFQHhTet5J5XK8QzxjLplOmrvwNyPeuEteumseQC5faVwinZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(346002)(396003)(366004)(39830400003)(136003)(86362001)(33656002)(38100700002)(66556008)(54906003)(52116002)(9686003)(33716001)(5660300002)(7416002)(8676002)(26005)(8936002)(316002)(2906002)(6512007)(41300700001)(4326008)(186003)(38350700002)(6916009)(66946007)(66476007)(83380400001)(6506007)(1076003)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BfGss2xg2w3Aa2m9muuI215IRNKoJqu4enVswepCxWA59QFFcuXJFOZ1/MRw?=
 =?us-ascii?Q?bwjzHp25Et42jTC9RXNYCztFmkxi+gjQfWFDihz/10bbZz22ByQKd4AlK8lE?=
 =?us-ascii?Q?TfFLPdnGK0NV5BKmEq8akDI29L2XOFrZ+To1ra3xFpgcDo9py4Ifs3cQ5Avi?=
 =?us-ascii?Q?2y+skQdao2oNa4blUBvAGfgtnYqx6dRyroeyLMZoHuiloGrRMg0FljNBGEod?=
 =?us-ascii?Q?U95NdcW1ansOXeJ4pagxb5cDA6jJMSNct4GaeY5M0/ZD6qMr2zVC+x3xukWr?=
 =?us-ascii?Q?4FUcHJYp1IaKSUOUVPgkiSP9fy5ue/w4alWk8Ar2ZctPuC5xDT2Hk7BV2xQI?=
 =?us-ascii?Q?Dvi0NlAzip6Ry2E6JiSbTcYf1UPfyj2+Riu8VYKg6nCZtS0IwVZAm12MYsqP?=
 =?us-ascii?Q?qBDjv9waIr+CSaJhpP9gaVmHvSZe02jSOuC3LU6vWW7cep8S8dO5NMGotW75?=
 =?us-ascii?Q?Tnu8LfQQIeiv0+Lwqnh9E0nw+KCXj4gld3RbbQluq31qqFUl5+vdYcEkIr/7?=
 =?us-ascii?Q?TfXHhRfYp3VOqLNz2zbzKhayP/d6cRXNkHTGs6MGtCo98oTD6lmog3T4+t2q?=
 =?us-ascii?Q?1ZUj46H55uFYWHyuaNWbroXglDMDfmXFxPAf6IA4icJioNlCags/sq580+k4?=
 =?us-ascii?Q?45PeYnGvXALLGiT+RqB9wpt/jsqFBMgJzAFO9sjbty7V0ElhKqp5m3aPE/LY?=
 =?us-ascii?Q?xXL36c6vaVCd7ylG0smKWyVw51538Aw5MexnV/u3h3g1XQkio7qLn7eg1AmZ?=
 =?us-ascii?Q?PC5wueMK3+tYFJJ+hyQLVZ5jI+qYFOj5UuCBXfvs+aSo1MD/WMcOMp4eynma?=
 =?us-ascii?Q?b7Y159ACU9eIhBefp0wc0tBywF0vwb/apvK5jkft8E/0Nh+SbC9UX5hhs/M3?=
 =?us-ascii?Q?XIkjEsB4KIpahL3rCKrmF/TgGoBuisn+rIFTOfADu6jkNrjjfrzOnGm3P7h9?=
 =?us-ascii?Q?WN+oarDf43Boa8F3pmFN4iHP8ZEnWAWQ92q+jS22qz/CjwXOjci4rH09+2O9?=
 =?us-ascii?Q?rlTbkl5wKTfJJ9thdLJSAT1gpaV5mVhjxRdvaC0ebxeNxvwEGeYcKrDwlA9l?=
 =?us-ascii?Q?4Pt6SYlPAM/41aU+hM4eqj/N4tblZnBKphjN05NOnIbf34N4RlpN1V1sPIGX?=
 =?us-ascii?Q?ACm3OT5dVvVz4e//NsuROBpbl4C4l9rAgNKnQXj/J6kJR7f6vmczDD0lNSpr?=
 =?us-ascii?Q?nn9JpLgHW+Sk4o+kKWQyP8BRSLaY4mdrHQ8CTHVjLSi2kEFhlpgoK0rgXYym?=
 =?us-ascii?Q?ua9jEKgm8UPG07IgQATLzP5lODpQ0h41w69NI4vwBncJ7sieVGF7m9fmp/iM?=
 =?us-ascii?Q?U2SPEN9KatAmVY3ETgXyH4XjMsYShAQI0tnxVOpUYtrI7YJ556XhPt24nLfr?=
 =?us-ascii?Q?UJ5K0ILGihyv05sCjw17E7ldpfy7R/v56aezlbQLYLDs+kr68sFmeBr1eVYI?=
 =?us-ascii?Q?SIOGVhCpPsI7cdvY3dViEAmL3cSVhbXA8cC+pT7amvGybjJt8l/Odoi9415q?=
 =?us-ascii?Q?hA9XlZZ7be/smh6yIBBStQUBrtWipiGo1M1dvi6aLYOTyck0AwGhIk2nfEG6?=
 =?us-ascii?Q?ZXSzi3WG6HWHKROjoSuwU3JJKgE8/fZ2TV2maBMIaxj+RCaQ5Vs8nhIvcd8e?=
 =?us-ascii?Q?Rg3M6l/RbAqKOI+CBKBefxDNvgv8QOMpFmD4mEiZQP1V443JPdJLrFxLRdK0?=
 =?us-ascii?Q?+kwGD1256JRLDv3aHAYengZiOOnzT5HbgB9asbJJ44EYXxHtmESCb5vacIqy?=
 =?us-ascii?Q?3Qysymp8Hg=3D=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6c28a9-7d03-40f3-008e-08da49b8ca77
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 01:38:44.7359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpwexYFicQjHZvCmtCFJ38SoBtBypEzOVJ7ftP1T8TAkMBtzEeBNMFhZ7+8n5DMb3omuQ6MLBc6DcmTl4Z8OPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB6873
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Jun 08, 2022 at 03:12:06PM -0600, Rob Herring wrote:
> Multiple bindings use 'linux,input-type', but there is not a central
> definition and type. Add 'linux,input-type' to input.yaml and update all
> the users to use it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

For *iqs*.yaml:

Acked-by: Jeff LaBundy <jeff@labundy.com>

> ---
>  .../devicetree/bindings/input/azoteq,iqs7222.yaml  |  1 -
>  .../devicetree/bindings/input/gpio-keys.yaml       |  7 +------
>  Documentation/devicetree/bindings/input/input.yaml | 14 ++++++++++++++
>  .../devicetree/bindings/input/iqs626a.yaml         |  4 ----
>  4 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
> index 5ea10fe7ffe9..a13bd3e41dd3 100644
> --- a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
> +++ b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
> @@ -471,7 +471,6 @@ patternProperties:
>            linux,code: true
>  
>            linux,input-type:
> -            $ref: /schemas/types.yaml#/definitions/uint32
>              enum: [1, 5]
>              default: 1
>              description:
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> index cd07107fd5ed..6b49b1afdd95 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> @@ -36,12 +36,7 @@ patternProperties:
>            description: Key / Axis code to emit.
>  
>          linux,input-type:
> -          description:
> -            Specify event type this button/key generates. If not specified defaults to
> -            <1> == EV_KEY.
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -
> -          default: 1
> +          default: 1  # EV_KEY
>  
>          linux,input-value:
>            description: |
> diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
> index e3701a0bc500..17512f4347fd 100644
> --- a/Documentation/devicetree/bindings/input/input.yaml
> +++ b/Documentation/devicetree/bindings/input/input.yaml
> @@ -31,6 +31,17 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      maximum: 0x2ff
>  
> +  linux,input-type:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 1   # EV_KEY
> +      - 2   # EV_REL
> +      - 3   # EV_ABS
> +      - 5   # EV_SW
> +    description:
> +      Specifies whether the event is to be interpreted as a key, relative,
> +      absolute, or switch.
> +
>    poll-interval:
>      description: Poll interval time in milliseconds.
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -47,4 +58,7 @@ properties:
>        reset automatically. Device with key pressed reset feature can specify
>        this property.
>  
> +dependencies:
> +  linux,input-type: [ "linux,code" ]
> +
>  additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/input/iqs626a.yaml b/Documentation/devicetree/bindings/input/iqs626a.yaml
> index 008959f2d425..4df27646c980 100644
> --- a/Documentation/devicetree/bindings/input/iqs626a.yaml
> +++ b/Documentation/devicetree/bindings/input/iqs626a.yaml
> @@ -491,16 +491,12 @@ patternProperties:
>            linux,code: true
>  
>            linux,input-type:
> -            $ref: /schemas/types.yaml#/definitions/uint32
>              enum: [1, 5]
>              description:
>                Specifies whether the event is to be interpreted as a key (1) or
>                a switch (5). By default, Hall-channel events are interpreted as
>                switches and all others are interpreted as keys.
>  
> -        dependencies:
> -          linux,input-type: ["linux,code"]
> -
>          additionalProperties: false
>  
>      dependencies:
> -- 
> 2.34.1
> 

Kind regards,
Jeff LaBundy
