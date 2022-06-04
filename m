Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CE953D4FB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 05:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiFDDFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 23:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiFDDFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 23:05:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A322ED4D;
        Fri,  3 Jun 2022 20:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX4uhjN2mcpF1nfWOCgBRThnQcCpmrRsdiCEnCdHwB9V9b4vJQ1P2shCs7vxpfRp3+y0lzUkRKL0bwnkzuaZvorBoC3nb9oKCKuqrjdMRON6cGDnp9bEvXG9WP8vgWYRGLYIkXeFRdsVRp9HzsqCNig4xJWGckSl2wBDzXchAY7S7/9DfvEQJHQsaW/OcSbVlvtOEDC94Un4C5RRuajCz1v6T4Df+XY971KWpqBd/B22TntW2jpPnsQPwzXGESNLeUbe9svSOKjpGjUbjyBuYsCBGPBi7zirWnolVdQnjyLTgfW5Dsto8jumpVrmCgedaHys3JDS9xLMmS95dpdqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykrPIEydGS+JR5xS//to/tTCuf83+ap18+w/nTuyGBU=;
 b=UNs6+DfpSZN5VNuLF8e8bRafUpsz/q4MTBb8HfPc+7AobD2j15ecJBu2tyJJLS4yfHKERXizmL4Cyj88KQLvMbDo1FPmtjAyDFTixtBCSv7zexuaV94npnB29Uhn3+79i4Ac0DDgHKC97nyFzD9iYFHu1mqJPkwG4hFmv+9A7Jtyu0qZJgmk5CZ58IONi4dAbaAOcVLZSgi7hNBXSH8v8N8Z8Wx5+OdjQuPjU0rvKaYmoVvTcnao08zr5VUZE+uJxlcHqSG5J6IUJgAwzffOFND+i7EAnapsT2Gm36usm1V7VzzlVMZj8GYTCo9LoCLj2dC5mnVz1Wby7uPhSVdLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykrPIEydGS+JR5xS//to/tTCuf83+ap18+w/nTuyGBU=;
 b=PvreOFyN7XspCuyDxdDQIRXaRXgn0+P3Lzp2XN8M+ouNBI14hATIkfDp8RUnNjO7jrVHGomTn4NayovxgbYv1+rncsGT5Iu+s8aS8QeHLveK3TNvmZiUV7BQcLKiWwosB84yypvViJFcGbImyH1uF+5rxIMA6yLUFqm4Kcpxjfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DM6PR08MB5257.namprd08.prod.outlook.com
 (2603:10b6:5:50::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Sat, 4 Jun
 2022 03:05:02 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f%6]) with mapi id 15.20.5293.020; Sat, 4 Jun 2022
 03:05:01 +0000
Date:   Fri, 3 Jun 2022 22:04:55 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Hansson <newbie13xd@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 1/2] dt-bindings: input: gpio-keys: enforce node
 names to match all properties
Message-ID: <20220604030455.GA12308@nixie71>
References: <20220603101601.542054-1-krzysztof.kozlowski@linaro.org>
 <20220603101601.542054-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603101601.542054-2-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: SN4PR0501CA0037.namprd05.prod.outlook.com
 (2603:10b6:803:41::14) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bb51037-936a-45bb-2da3-08da45d70400
X-MS-TrafficTypeDiagnostic: DM6PR08MB5257:EE_
X-Microsoft-Antispam-PRVS: <DM6PR08MB5257DA4AAD280EF61D7C32CAD3A09@DM6PR08MB5257.namprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOLUhkUwXKdU3JxnG4YPaHPJ/WWMop8e6+q02ixqjS9c6cmeldSxJFJZjJ/NWv+IcZl45/soEfcgPUcbX20mnEGKMmVo3PvYH6eoTBtOFXmtEnovf96NzdBNDL3MN+kJvMpqUqK/5h9w9wcTzQIlqCm7406Zj+RB9b2eiLafGC7esD/QGsS89zLghr6QWUBv6oMDJsXrHwKiPiNtBHrEmte2jso88QrE3qeWkadUyCkJxfFIxDkORlcwl3GG1rlS95GLpDr+eTsB61OojC1C7CNirAIeiDS9w9jXKXiWE3PF4gVzPpnIeCg1Mg9inZVPzazJrHMF6b23UIWMpNLRjxvlPNweifvGUNMsefojpI/RbzPK98+Fpu6AYj5MZyAmLxop+EPtKGLp+jDW6lCItA9ez1hKkZQcT8L9UUMYA1zmraUUcCYWp/C6eTaKwYcJc71dmHkrLW9AqC7Dj2QCMooVAJ+NcwaS7LS91p0qa/8NWagBnC4q7hLyCxPDaKlzczxVAGZ2+qHamSVdv7/jEVDmMfX6t7F7v0KUIxhgrhLCfQJv5JxRO7Nl7L/8yirYPJ7AMuzmcwaq7Yt/+jecovf4i7sOn4t2GkUVbCKJvRAiGoXGFTfPFU8ap73uDECbnjAWRe9Htx2CD3KBuqjHoGwbOEaBurv95rRJq5U+5HNsVExuhuvfV+ZJwZdghPQZBikWwoOg7neHYv6YOatqOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(376002)(366004)(136003)(396003)(346002)(39830400003)(26005)(38350700002)(41300700001)(9686003)(6512007)(8936002)(38100700002)(1076003)(86362001)(316002)(33656002)(2906002)(6506007)(5660300002)(6666004)(186003)(33716001)(6486002)(83380400001)(54906003)(52116002)(66556008)(4326008)(8676002)(6916009)(66946007)(508600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jM6IOViHCwJM0ymS4tKWPGOMa+XKyJ1I0+d2hYYSq4y4xqyTB42Wg0TO2Lq8?=
 =?us-ascii?Q?J7SQyQIj3r6IsLdfsqtO1U6VDKusSo9Tm4RTsdX+EmRvL6Xoj2IyRyDFxQ/M?=
 =?us-ascii?Q?8aNnaLrIw+EgA0FJvq4zuAovh5VFZfJEoXy+31stiGIvrbyQHt86oh6B6+oX?=
 =?us-ascii?Q?8hk3qjXhoboGfZNzy+rpV9AqrByMMuH7FE4IwTdojs5gl//pWLhYGMAgfLnk?=
 =?us-ascii?Q?UphKOC5T02KJ4KlwKIQOcmsTwN41JNYariISC04mT14LYolivMNIJSicY7Yn?=
 =?us-ascii?Q?PIL7hPbtCRu+iEJW/KKZ4Lg2p+zLZEGM/s3Zyk+oVvRImbX3N7GbJKwKr1QP?=
 =?us-ascii?Q?wlF2BAYkIYeqr6B1ByD7zN2XQlKsRqD3oQjvOx86XjuXrI2B0m+32xPeB9IB?=
 =?us-ascii?Q?p4zcMY3HgaVhBcJ34IkaxRx9lV5zj9D5sJsp2BFskFtNHkiA2+pstJDjfiD1?=
 =?us-ascii?Q?Ou1M+lmzkT4zsklNFI+nZK6ZMsQx0Nm9ponzWJeTUK9kKVwfSp5I442+Ve9/?=
 =?us-ascii?Q?fx7wndkjqFYBYnHtTgCt9GENDKj7HAevs3EbIo8Y8X1MoCYelpaJxaYNmsOB?=
 =?us-ascii?Q?EBUkWmy4/RqGfccYm5yQeMBy57z0+sY33tapbTp6F+o1lRCWLzx+NyUbvTd0?=
 =?us-ascii?Q?DiXxbhpjjJ/1Wb8faRwF3UUUrAGDzIWYsnG1P/ii8fhuxBy4AOWcDIABtVX8?=
 =?us-ascii?Q?dPcf+FSNwRAxExEKNDR/KZqoQJ/pyMZhoYYvtlNmuaO+/S8j110snAFznP+d?=
 =?us-ascii?Q?nJyHXRt41hV+RjHPqCqAeG0RwSZNdhHGX0cV3XRdgRvmJPPQrb+LKIZoYkg4?=
 =?us-ascii?Q?vqT/go6pxAFzn11P6m8XCllp4Z2+PkO1SvnGwR3e6TP0cgEHJRwNRHc12Z3+?=
 =?us-ascii?Q?XJHhx6fNR+0FP3ddc5MmKZHGbU6ltjxTUz7hGypkrKqnjexlfb1yE5OiSElt?=
 =?us-ascii?Q?isrAuk5e/pzN5tyyZvDT90H7IgqIb1FfYLYbOXPHhVm32dITau1ax5YY1e6m?=
 =?us-ascii?Q?HuUaL7ifkmr6NWya9jiNh1FqjQDS3wJbuobkYwEw9A3i/FTlm53ddpBGpUpA?=
 =?us-ascii?Q?Hj1OC6LXecM2l5g3+eNR//gCMRHwG3TyHTWTsv/y+Picgkkemx+JbdnAGYBX?=
 =?us-ascii?Q?PJqEco46o9vppI/fd9e4PENs/+CWIAaUt1HztHA20y6VtirSCS9ILXUdYPJV?=
 =?us-ascii?Q?t6HQ+uD9R0g/epu+4aocPTlkMnB0xezuqM1cB4pi9a34vbtYk0kqkT4DSqpC?=
 =?us-ascii?Q?jszG82Q5l5Rfe1vQ7OqcfDD/zLcF+wfxAfoZnSP2tPLwXz9MhHlsprhvaw6A?=
 =?us-ascii?Q?L/HoFBExHJ0m8JlqfDkbp7znwSoFqeZqkHgBDgKlKQ7LMP/U/q1383LrC3BO?=
 =?us-ascii?Q?+c9WFL8cPe2wmZLwKRzyjrfPcV1dk0YZIxF/qqrFlPRPCyyFQDTPyLsb1h8O?=
 =?us-ascii?Q?GsG692h/qRfBCUqDQQYEss6jXYp1ICTD4PT7+BFDSkQpX6O36UFWIAbjbyeR?=
 =?us-ascii?Q?gnXR44nw2Rg28oA+Y56D0NfZsb9L48ykxym6yKurvJu3+CmaIxoXH/b8J4V6?=
 =?us-ascii?Q?38xqQ0VuxTVEf/gAcw2QHA0ggJWniOgWJ/jxiGuCWij5F+JtXL0uUPs0Asyh?=
 =?us-ascii?Q?GlsHibjvGQOrOA68bcRWAY9eYxC929RvN0olzee18f+QWt18UG3M3b13JXtu?=
 =?us-ascii?Q?sb2rDx3iolkGKJ6Va2Rj19pTwEhY+2LTKRDNnTenBq+nWsHp4t9F3zFOvOik?=
 =?us-ascii?Q?USv2QqfeYA=3D=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb51037-936a-45bb-2da3-08da45d70400
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 03:05:01.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDN9K7fG5XsUKo32W1ntBZMkIzK1SQPiyPJpQkpeCc6iBWXobbEtpMCBvng/bw145X7KaSf9VgFpw5SQbLIuVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5257
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Jun 03, 2022 at 12:16:00PM +0200, Krzysztof Kozlowski wrote:
> The gpio-keys DT schema matches all properties with a wide pattern and
> applies specific schema to children.  This has drawback - all regular
> properties are also matched and are silently ignored, even if they are
> not described in schema.  Basically this allows any non-object property
> to be present.
> 
> Enforce specific naming pattern for children (keys) to narrow the
> pattern thus do not match other properties.  This will require all
> children to be named with 'key-' prefix or '-key' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/input/gpio-keys.yaml  | 169 +++++++++---------
>  1 file changed, 83 insertions(+), 86 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> index 93f601c58984..49d388dc8d78 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> @@ -16,92 +16,89 @@ properties:
>        - gpio-keys-polled
>  
>  patternProperties:
> -  ".*":
> -    if:
> -      type: object
> -    then:
> -      $ref: input.yaml#
> -
> -      properties:
> -        gpios:
> -          maxItems: 1
> -
> -        interrupts:
> -          maxItems: 1
> -
> -        label:
> -          description: Descriptive name of the key.
> -
> -        linux,code:
> -          description: Key / Axis code to emit.
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -
> -        linux,input-type:
> -          description:
> -            Specify event type this button/key generates. If not specified defaults to
> -            <1> == EV_KEY.
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -
> -          default: 1
> -
> -        linux,input-value:
> -          description: |
> -            If linux,input-type is EV_ABS or EV_REL then this
> -            value is sent for events this button generates when pressed.
> -            EV_ABS/EV_REL axis will generate an event with a value of 0
> -            when all buttons with linux,input-type == type and
> -            linux,code == axis are released. This value is interpreted
> -            as a signed 32 bit value, e.g. to make a button generate a
> -            value of -1 use:
> -
> -            linux,input-value = <0xffffffff>; /* -1 */
> -
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -
> -        debounce-interval:
> -          description:
> -            Debouncing interval time in milliseconds. If not specified defaults to 5.
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -
> -          default: 5
> -
> -        wakeup-source:
> -          description: Button can wake-up the system.
> -
> -        wakeup-event-action:
> -          description: |
> -            Specifies whether the key should wake the system when asserted, when
> -            deasserted, or both. This property is only valid for keys that wake up the
> -            system (e.g., when the "wakeup-source" property is also provided).
> -
> -            Supported values are defined in linux-event-codes.h:
> -
> -              EV_ACT_ANY        - both asserted and deasserted
> -              EV_ACT_ASSERTED   - asserted
> -              EV_ACT_DEASSERTED - deasserted
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -          enum: [0, 1, 2]
> -
> -        linux,can-disable:
> -          description:
> -            Indicates that button is connected to dedicated (not shared) interrupt
> -            which can be disabled to suppress events from the button.
> -          type: boolean
> -
> -      required:
> -        - linux,code
> -
> -      anyOf:
> -        - required:
> -            - interrupts
> -        - required:
> -            - gpios
> -
> -      dependencies:
> -        wakeup-event-action: [ wakeup-source ]
> -        linux,input-value: [ gpios ]
> -
> -      unevaluatedProperties: false
> +  "^(key|key-[a-z0-9-]+|[a-z0-9-]+-key)$":

Maybe this would be better as:

"^((key|switch|axis)|(key|switch|axis)-[a-z0-9-]+|[a-z0-9-]+-(key|switch|axis))$":

...or perhaps a more efficient version of my counter-proposal.

The reason is because it is confusing to see a lid or dock switch named
as "key-lid", etc.

> +    $ref: input.yaml#
> +
> +    properties:
> +      gpios:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      label:
> +        description: Descriptive name of the key.
> +
> +      linux,code:
> +        description: Key / Axis code to emit.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      linux,input-type:
> +        description:
> +          Specify event type this button/key generates. If not specified defaults to
> +          <1> == EV_KEY.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +        default: 1
> +
> +      linux,input-value:
> +        description: |
> +          If linux,input-type is EV_ABS or EV_REL then this
> +          value is sent for events this button generates when pressed.
> +          EV_ABS/EV_REL axis will generate an event with a value of 0
> +          when all buttons with linux,input-type == type and
> +          linux,code == axis are released. This value is interpreted
> +          as a signed 32 bit value, e.g. to make a button generate a
> +          value of -1 use:
> +
> +          linux,input-value = <0xffffffff>; /* -1 */
> +
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      debounce-interval:
> +        description:
> +          Debouncing interval time in milliseconds. If not specified defaults to 5.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +        default: 5
> +
> +      wakeup-source:
> +        description: Button can wake-up the system.
> +
> +      wakeup-event-action:
> +        description: |
> +          Specifies whether the key should wake the system when asserted, when
> +          deasserted, or both. This property is only valid for keys that wake up the
> +          system (e.g., when the "wakeup-source" property is also provided).
> +
> +          Supported values are defined in linux-event-codes.h:
> +
> +            EV_ACT_ANY        - both asserted and deasserted
> +            EV_ACT_ASSERTED   - asserted
> +            EV_ACT_DEASSERTED - deasserted
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2]
> +
> +      linux,can-disable:
> +        description:
> +          Indicates that button is connected to dedicated (not shared) interrupt
> +          which can be disabled to suppress events from the button.
> +        type: boolean
> +
> +    required:
> +      - linux,code
> +
> +    anyOf:
> +      - required:
> +          - interrupts
> +      - required:
> +          - gpios
> +
> +    dependencies:
> +      wakeup-event-action: [ wakeup-source ]
> +      linux,input-value: [ gpios ]
> +
> +    unevaluatedProperties: false
>  
>  if:
>    properties:
> -- 
> 2.34.1
> 

Kind regards,
Jeff LaBundy
