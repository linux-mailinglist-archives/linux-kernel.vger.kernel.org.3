Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272BA544115
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiFIBdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiFIBcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:32:52 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89221CAC0C;
        Wed,  8 Jun 2022 18:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSKnShh5OJLfADtaEbS+9ocacOIPrAoJQNXUQzO94/tZAp+x42y2CkzlYJswQQMbuwqE+cZs5/pOsDp88GBTK6eOVRWsD+9t1/tpEbvy7t0FnLJ1+adoEj3drr1/RkLJOWJFhbYDeM8vn1AVIVTX98BaJpKExoeTAP2NIjexHdTGIN2P/w+dTWp/F7AjEOBjtonMsdCPWgRvYrXqKN1PMLIoh4nTGdHYYrEmSRjBYwafESCWPduX0vUP6mJ7NWJJbBnxyhOhwxJwpcbWKjd8jUzU32cwgcHkXQU/THC0bfMpfaXcmqhgyL5Bfz5QUv36mn4u3i5T3kxdB+1KgLLdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8z7dOD1uze2DTQbl1RzeC8qsElhZlUjqjtuM6yvHik=;
 b=ob23PdHWJztb+x/rxLlDLZuy4UBL7GbJ/S6oqpsm2xS2xj1UYYEnheCTSiiQd+jxPTC5obAU+Nx0vHuiULqVRmwM9NmTUyTFJuFbvuQvq0vHSpY/VgPGOfvKqUUSoJRggvqJwTu3c0NQPoQIZ/JARcQSB+gfODBI6nHhx7BXN+1CMbj4xnC3HZTBH1lp0HYWLrUaChdDaBMdIV7WTDodj88tL/oXzyi3N831Xf0pH3DSQ1j/tBe52CXJWOSSn6xR2Ee8S+2AeewylkqmYdHqKsYDhJbsdrSPS0h5Xr+Lu8XgbDmhiiziZIzZBlIwlEOBbFEeChx/2AE/KYzfuttljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8z7dOD1uze2DTQbl1RzeC8qsElhZlUjqjtuM6yvHik=;
 b=AZ/hacfHt6niI/7jD1UgOWjoBWvvZGgC29jAioypuftRz3JLSgYfnSnLYZcprfGIcvko+nmaLtYRqQX+hpu9TtkHS3Zya0LM+/CGLaIYj1lRk/NyZJKh24zAwJ64A9LGmlXT+huNko6ER0dzouuvQte5IEZLcs0Nux3snkEfR4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SN4PR0801MB3838.namprd08.prod.outlook.com
 (2603:10b6:803:50::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Thu, 9 Jun
 2022 01:32:45 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f%6]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 01:32:45 +0000
Date:   Wed, 8 Jun 2022 20:32:43 -0500
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
Subject: Re: [PATCH v2 2/5] dt-bindings: input: Centralize 'linux,code'
 definition
Message-ID: <20220609013243.GB191119@nixie71>
References: <20220608211207.2058487-1-robh@kernel.org>
 <20220608211207.2058487-3-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608211207.2058487-3-robh@kernel.org>
X-ClientProxiedBy: SN7P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::30) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b83db288-757d-4acd-ac50-08da49b7f463
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3838:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0801MB3838552D2327DDE3A8701E6ED3A79@SN4PR0801MB3838.namprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3DMD4ii2FP+ktQEBS3V9C0MbxVS2b8Hmqzg0nGr7scvz4oiW7Xqszt1dFB+Hq2+DswRt50Wowza43BJQVSTCf9LT6Aig+tps8lJpI6olhwrCzsqvswU+ndJxdA2cZrJStHJiqZi7AJWBGZT5eAGhu6wHCAL6ETtU/x86CcVwpsaVYjjr4jrAebiYGtWlCVhorRja0Ciqh6MDx5kuybkAgJj/OhVTEJOaw9nhOHB7FfcWNmF3FLokVkyy5rKKL0iUpQDlMmWqlyZ2dKo266mIs8I53x8jzNrHTuaQ7NOHb0ZdVqsVaqskcdqNoabx178+r85KL/8UNY9bGOjnpKH55iM9up1nEnn/nP56jcKFGHhMUhtv+kyhYwLJl5wI9FrGjWXECn7XY1+eo3nTeDIYv+BvwXZKBafHqgnKJmxGcRI9/5XBtrCV6TRtzi7haVcZEBycUxyVJVmpdfqLayfSDiEsvZFbRorgM7l74GD9hjlz23UZdsMy1OZUuijko+obhWRZX2DmMrpCxL9xrPcELLSOHIZBtC0nQvygoegxpY+I6ivJnBItlKpcflTKGR672S7nAQ1fjkLFoPLdUX9EZ3ubUZfpq/xkV8eif+9V0VktR8pAA5aZunQLR9ZVVj05FcDsxttAtEOEB2cf/PGZ6M1Wi0nT82wgJPVMFWCGmgGQb6QFqb5DJg5pKLOO2HATDv5Z4jTtPAw/DGTY/yu6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(346002)(366004)(136003)(39830400003)(396003)(41300700001)(38350700002)(38100700002)(7416002)(508600001)(83380400001)(66556008)(1076003)(66476007)(52116002)(2906002)(33656002)(6506007)(8936002)(186003)(6486002)(86362001)(26005)(5660300002)(33716001)(9686003)(6512007)(316002)(6916009)(54906003)(8676002)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7s2kaVDyP7TPqPiiN4s1OpXP6gYy8YnQrIzp3IE8DCIQKvjIP8tWEHzwecK?=
 =?us-ascii?Q?KvD4kwHO9hyl307CHr4H5vzSGFkQFkVKWMLk/FoS+5jx8VfUFDkvYaKGzH9e?=
 =?us-ascii?Q?MjSeuW6cWSQz5gqHAHBmpQQnqTTHH80rwFGZEZNsV7/s2Xl8NoRSgXJwVFed?=
 =?us-ascii?Q?IMrG2EwzKgSMSR/CPvXTedp66vkWJktCC0iEqilAkBLSN4DXcgrraDgX1P8a?=
 =?us-ascii?Q?HPtAyy6QryljYPnnsROa7WFVIGCV0jCUXywkurrccYpFqocviM5NilfeufU8?=
 =?us-ascii?Q?jyRQUETugoQvzbnNKLG2T6BP7WaLFRrEAiEHUmLh0uR2JpoE4Z6S5sPBykIK?=
 =?us-ascii?Q?ZQIadnnpjYxfe4OSCnCb5OPcy+Lcf18izyHxSefo7fXI7IfOeE21Qj4KVsBt?=
 =?us-ascii?Q?uFhHIJ6I2bf1fbx3cgtt+uz3sMvzI+uUyRRbizi+AjfT3lH1KVsInT9pXHmL?=
 =?us-ascii?Q?KoBTjX5t/TI89kPgTj0PCMlMTqp26X2BxRev5IOcDXBfXkB3KtaYzpxIzc7W?=
 =?us-ascii?Q?5lXzmwwdOZMXILTLxx66qs4cy2hEttZLMryp9b4V1gLl2oG2A+kPztAduNoo?=
 =?us-ascii?Q?oxb4OV2I6TYZ0akRlegPu+As38LKpJrROY+382ufZaIeoPgdZ98zXr/cTJEo?=
 =?us-ascii?Q?j9XiXwo88aSUI5Nutbi+yXQzcYR198kg9LNg4mAtkxwTXiCAH2gSrqiaomoY?=
 =?us-ascii?Q?BA/CZ4YqTEOB5zTrYv4E+r7+UmAlMT/FatUIth1aUZSPuoPwLb4KpPUwJWKj?=
 =?us-ascii?Q?k6BLbRNBbSDYElYKggay/bWeN9bbapYpV0vqpNW9CahDn8xPcVOqt53tpU2C?=
 =?us-ascii?Q?M8FRPfIN0co5AX5b0V8N+TuFe4pKgcMNvNr8vo818fvrPJxynSaNhe8puHEt?=
 =?us-ascii?Q?L/bpI4IUX0dS8k6YogPwoGjUf5W1346ZTGOnkwM8jw9DfGJmAVyYbkUSaLY/?=
 =?us-ascii?Q?UkElgkhOa5sarwghodCDNOIjqkiEW2LR5a+Z3gHoDdTUETRaxcOhFbKYfFEc?=
 =?us-ascii?Q?x5bRaa6vfdudPB34PnXMC+UJuZXmlr/SiVtwE0o4Vlb4tWZLaga6ci4j48Lo?=
 =?us-ascii?Q?Sy2lJazCb3Pu2Kd8pMshl5eU5KWwixD+/gMDTFn6UPkD7MqB7/5gL8jUtoX7?=
 =?us-ascii?Q?fWNoqyzsJkI0lqBA6bx+c056n3u+3FOGOFMK29NDnWDD+yiRitLifC7l3zTS?=
 =?us-ascii?Q?raiE3bRZ7XwhfpW2VdvjkYigXrstBhooFzD0ICFaOAQdewjPP+f8z1q9TggV?=
 =?us-ascii?Q?5yz4Le6XfAJJ6Xg86wDhh38lSKbkZIaHl2IM/2w/dMttcjfXxB5N45Zn9tiu?=
 =?us-ascii?Q?gCX6YvbobbSH19YoNwwWwbrHQOl3hkBBosLW4AKd8RrQ0jYLBXSA3wp62PzP?=
 =?us-ascii?Q?crrEhkbDzRdGpKrqqf3jGSPVV0v1uodSX6J1df6LWcu7Gjk+R/2hjyK53Cib?=
 =?us-ascii?Q?dRTDAmkZX8nQsDcI5BN+aYM48ltJhNzMiYAVFGB8c9ZDsH7Zl4h96DSjWTMh?=
 =?us-ascii?Q?QpAMuaJ6ylLozeYTNmQypMKXIK8czRIlBaGaW/A0w0JcTW4sN3vQpfOk7+k5?=
 =?us-ascii?Q?rYchwBYzS1kE7Q+2tGSCi2aDH3TyRi0ADY9h+L+ASpJniVNVCZcKqNoPJu6l?=
 =?us-ascii?Q?QzO82v1An+HTCgzXYLNKKiF/ytxyh3Aa5n/OVmU0d9SbjdAUZ8YC9QZPiUCs?=
 =?us-ascii?Q?puZDZ4TJH/hyq3E6KE8fa2BVSUEbcG0XOgWSYy60gOUrMXnpECLibPVcXAti?=
 =?us-ascii?Q?PBzNPpCC2A=3D=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83db288-757d-4acd-ac50-08da49b7f463
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 01:32:45.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +j3PTMITsNLgSLOLT5HEW9tQryB0EO5k/EvHkG4Ad57JEO+AUchJ1vCGoMLXjwJIVbGGCC+5GiNHwSr8iFkt6Q==
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

On Wed, Jun 08, 2022 at 03:12:04PM -0600, Rob Herring wrote:
> Multiple bindings use 'linux,code', but there is not a central
> definition and type. Add 'linux,code' to input.yaml and update all the
> users to use it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

For *iqs*.yaml:

Acked-by: Jeff LaBundy <jeff@labundy.com>

> ---
>  .../devicetree/bindings/input/adc-joystick.yaml   |  2 +-
>  .../input/allwinner,sun4i-a10-lradc-keys.yaml     |  5 ++---
>  .../devicetree/bindings/input/azoteq,iqs7222.yaml |  7 ++-----
>  .../devicetree/bindings/input/gpio-keys.yaml      |  1 -
>  .../devicetree/bindings/input/input.yaml          |  8 ++++++++
>  .../devicetree/bindings/input/iqs269a.yaml        | 15 ++++++---------
>  .../devicetree/bindings/input/iqs626a.yaml        |  5 ++---
>  .../devicetree/bindings/input/iqs62x-keys.yaml    |  5 ++---
>  .../devicetree/bindings/input/max77650-onkey.yaml |  8 ++++----
>  9 files changed, 27 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> index 2ee04e03bc22..64d961458ac7 100644
> --- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
> +++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> @@ -45,6 +45,7 @@ additionalProperties: false
>  patternProperties:
>    "^axis@[0-9a-f]+$":
>      type: object
> +    $ref: input.yaml#
>      description: >
>        Represents a joystick axis bound to the given ADC channel.
>        For each entry in the io-channels list, one axis subnode with a matching
> @@ -57,7 +58,6 @@ patternProperties:
>          description: Index of an io-channels list entry bound to this axis.
>  
>        linux,code:
> -        $ref: /schemas/types.yaml#/definitions/uint32
>          description: EV_ABS specific event code generated by the axis.
>  
>        abs-range:
> diff --git a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
> index 3399fc288afb..9700dc468b25 100644
> --- a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
> @@ -44,14 +44,13 @@ properties:
>  patternProperties:
>    "^button-[0-9]+$":
>      type: object
> +    $ref: input.yaml#
>      properties:
>        label:
>          $ref: /schemas/types.yaml#/definitions/string
>          description: Descriptive name of the key
>  
> -      linux,code:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        description: Keycode to emit
> +      linux,code: true
>  
>        channel:
>          $ref: /schemas/types.yaml#/definitions/uint32
> diff --git a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
> index a3a1e5a65306..5ea10fe7ffe9 100644
> --- a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
> +++ b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
> @@ -421,6 +421,7 @@ patternProperties:
>      patternProperties:
>        "^event-(prox|touch)$":
>          type: object
> +        $ref: input.yaml#
>          description:
>            Represents a proximity or touch event reported by the channel.
>  
> @@ -467,11 +468,7 @@ patternProperties:
>                The IQS7222B does not feature channel-specific timeouts; the time-
>                out specified for any one channel applies to all channels.
>  
> -          linux,code:
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -            description:
> -              Numeric key or switch code associated with the event. Specify
> -              KEY_RESERVED (0) to opt out of event reporting.
> +          linux,code: true
>  
>            linux,input-type:
>              $ref: /schemas/types.yaml#/definitions/uint32
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> index 7fe1966ea28a..cd07107fd5ed 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> @@ -34,7 +34,6 @@ patternProperties:
>  
>          linux,code:
>            description: Key / Axis code to emit.
> -          $ref: /schemas/types.yaml#/definitions/uint32
>  
>          linux,input-type:
>            description:
> diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
> index 43d2f299c332..e3701a0bc500 100644
> --- a/Documentation/devicetree/bindings/input/input.yaml
> +++ b/Documentation/devicetree/bindings/input/input.yaml
> @@ -23,6 +23,14 @@ properties:
>        minimum: 0
>        maximum: 0x2ff
>  
> +  linux,code:
> +    description:
> +      Specifies a single numeric keycode value to be used for reporting
> +      button/switch events. Specify KEY_RESERVED (0) to opt out of event
> +      reporting.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 0x2ff
> +
>    poll-interval:
>      description: Poll interval time in milliseconds.
>      $ref: /schemas/types.yaml#/definitions/uint32
> diff --git a/Documentation/devicetree/bindings/input/iqs269a.yaml b/Documentation/devicetree/bindings/input/iqs269a.yaml
> index 9c154e5e1a91..c22f8f27913a 100644
> --- a/Documentation/devicetree/bindings/input/iqs269a.yaml
> +++ b/Documentation/devicetree/bindings/input/iqs269a.yaml
> @@ -370,6 +370,7 @@ patternProperties:
>      patternProperties:
>        "^event-prox(-alt)?$":
>          type: object
> +        $ref: input.yaml#
>          description:
>            Represents a proximity event reported by the channel in response to
>            a decrease in counts. Node names suffixed with '-alt' instead corre-
> @@ -396,14 +397,13 @@ patternProperties:
>              default: 10
>              description: Specifies the threshold for the event.
>  
> -          linux,code:
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -            description: Numeric key or switch code associated with the event.
> +          linux,code: true
>  
>          additionalProperties: false
>  
>        "^event-touch(-alt)?$":
>          type: object
> +        $ref: input.yaml#
>          description: Represents a touch event reported by the channel.
>  
>          properties:
> @@ -421,14 +421,13 @@ patternProperties:
>              default: 4
>              description: Specifies the hysteresis for the event.
>  
> -          linux,code:
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -            description: Numeric key or switch code associated with the event.
> +          linux,code: true
>  
>          additionalProperties: false
>  
>        "^event-deep(-alt)?$":
>          type: object
> +        $ref: input.yaml#
>          description: Represents a deep-touch event reported by the channel.
>  
>          properties:
> @@ -446,9 +445,7 @@ patternProperties:
>              default: 0
>              description: Specifies the hysteresis for the event.
>  
> -          linux,code:
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -            description: Numeric key or switch code associated with the event.
> +          linux,code: true
>  
>          additionalProperties: false
>  
> diff --git a/Documentation/devicetree/bindings/input/iqs626a.yaml b/Documentation/devicetree/bindings/input/iqs626a.yaml
> index 0cb736c541c9..e645521da8ba 100644
> --- a/Documentation/devicetree/bindings/input/iqs626a.yaml
> +++ b/Documentation/devicetree/bindings/input/iqs626a.yaml
> @@ -449,6 +449,7 @@ patternProperties:
>      patternProperties:
>        "^event-(prox|touch|deep)(-alt)?$":
>          type: object
> +        $ref: input.yaml#
>          description:
>            Represents a proximity, touch or deep-touch event reported by the
>            channel in response to a decrease in counts. Node names suffixed with
> @@ -487,9 +488,7 @@ patternProperties:
>                Specifies the hysteresis for the event (touch and deep-touch
>                events only).
>  
> -          linux,code:
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -            description: Numeric key or switch code associated with the event.
> +          linux,code: true
>  
>            linux,input-type:
>              $ref: /schemas/types.yaml#/definitions/uint32
> diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> index 77fe3b545b35..e677e31fe8fe 100644
> --- a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> @@ -89,15 +89,14 @@ properties:
>  patternProperties:
>    "^hall-switch-(north|south)$":
>      type: object
> +    $ref: input.yaml#
>      description:
>        Represents north/south-field Hall-effect sensor touch or proximity
>        events. Note that north/south-field orientation is reversed on the
>        IQS620AXzCSR device due to its flip-chip package.
>  
>      properties:
> -      linux,code:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        description: Numeric switch code associated with the event.
> +      linux,code: true
>  
>        azoteq,use-prox:
>          $ref: /schemas/types.yaml#/definitions/flag
> diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.yaml b/Documentation/devicetree/bindings/input/max77650-onkey.yaml
> index 3a2ad6ec64db..48edc0c8c1dd 100644
> --- a/Documentation/devicetree/bindings/input/max77650-onkey.yaml
> +++ b/Documentation/devicetree/bindings/input/max77650-onkey.yaml
> @@ -16,15 +16,15 @@ description: |
>    The onkey controller is represented as a sub-node of the PMIC node on
>    the device tree.
>  
> +allOf:
> +  - $ref: input.yaml#
> +
>  properties:
>    compatible:
>      const: maxim,max77650-onkey
>  
>    linux,code:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    description:
> -      The key-code to be reported when the key is pressed. Defaults
> -      to KEY_POWER.
> +    default: 116  # KEY_POWER
>  
>    maxim,onkey-slide:
>      $ref: /schemas/types.yaml#/definitions/flag
> -- 
> 2.34.1
> 

Kind regards,
Jeff LaBundy
