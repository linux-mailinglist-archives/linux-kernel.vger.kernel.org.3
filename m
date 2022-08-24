Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20F59F927
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiHXMOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbiHXMOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:14:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54646F27C;
        Wed, 24 Aug 2022 05:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMept0s1C76eyHbZAIfyVMg1+zMpeuMTM9t/Ulv9eyTGXxiW1Ia/ARitO7Gw3b5ouaEIOdb4lwjurdbtzWO5D52Zm7s0xKZ3SN9rduLVuQRPeZw3T9Ge3GV5M72sQi6WLMju7EL2Tp9Fjhwk0emJftWfeo4vaSy6tGqgE6Ro9psaFlKafcDg4Z2DyJQX2y205/jnc/Y9PlCA+s7yRXrufdTjcnIsxE378KenZTU0MKZihNiBIjLjAk4GNm3FFMmtAa1vvrhAHZDzEFN6ui8BnloGyGx7urV7g7Rv65TGbqfTLG0WIrG2O0cho8brVabvUHi4G4odGZLP3tJsMNxkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seyCMfUFWU35N0irLFaLEYxuqEUPe373XdL4QcZpFbE=;
 b=kP2u5kt+G6NFV9Q/uVkre8G+zhSpSTNDnzTXHXO79jJUiM8xNchAHhqKULELaR2M12MNE70RV66ZTZ5ZhLRUWjG1QaSJroUd2fF+Joc0f+/HW0ajJvWHDRiuZs+Xbamk0D/yiK2arx8O5FZTAwqYJCkCXxzwXQG9VVNz25jmZjz85RkE87NKrH+m8/VlAByv8kF0zwvCaTW8rPbxQFwxHx7YLbbMyLlyXXCiOM4vqJePZuo3qlxSAcfpLkwmWO4oCAe5zjXQJYy28gbFds3rIzbmDHvN+NCpcSxDIf8nZK7Bik0IpaOAO6/x2IrtoaZwVkEGvxwpeixXtTU6ZBQBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seyCMfUFWU35N0irLFaLEYxuqEUPe373XdL4QcZpFbE=;
 b=va+P6fsiSDDgDyiT4d+93fI3wNIkt9nuCksbBlTYNFvJPwyxVh+RDrrRujazP6ahiGKfnjl8mZevPP2bvRX8frOkGkRG4Bp3oOIBaoXlNQoPzuDvn1TaD5mVJfFFDPQY49y+ZPJ+oYFcxAq0LWJF4wHzG2KJ6q8l23HX/sMVj6ZWwcv1dTE4CrPeL6RgAkubyKejcjQnrGzIYtx3xxQrUBoWlbID2NAtVhPPpyLv0odDnUapXL39gL0+kkQ69bC1W8uX8XxpDks+XVuEYmLNK20aGfH9j0IavLKdAnfMONuoYefSVI+WcQJlzsxEr80R99cw5Bz9JkNtkbt9WjbEJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 12:13:55 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb%4]) with mapi id 15.20.5546.021; Wed, 24 Aug 2022
 12:13:55 +0000
Message-ID: <c8450362-ab4b-c45f-17c8-2bd88a61770f@suse.com>
Date:   Wed, 24 Aug 2022 14:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/5] dt-bindings: mfd: sensehat: Add Raspberry Pi Sense
 HAT schema
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Miguel Ojeda <ojeda@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Joel Savitz <jsavitz@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <20220823174158.45579-4-cmirabil@redhat.com>
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20220823174158.45579-4-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af00fa85-9396-4cd4-a86d-08da85ca1d45
X-MS-TrafficTypeDiagnostic: VE1PR04MB7472:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xw8OliUcXDyoP4ByYAwlGOkN8Zx3nTBBtbVzbSQVmnOgl9+DJM+grwT0yhCCbD+6LFFtXvCjjJmQ6g+ki185GR4C/0BXmBdJZ97BKXvVHEGnbshoGXrNz01oA6t4iBHGxLcJ9+rGz33DKtO9o/PUpUcCjIxgS4qa4Pbev5oJ5Avku1/zL3F0QUT4kUuSWOLjPF0CuMuQeMOhCR5FawxALMNVpFShMpxsqpXbeVu5y7JoUfXd8u+mEy3yjPrtqr7iGNx81i0rxkHOpdvdat4s8j15s7E8zN3jxdHzymzHgOTBKjyDNerwXgaogJipTrx4owdahEj0CRBjQF3PBxib0gQ8TWoeC+mr+CdkDzvOVH5L2ajVfX8gTJxg9oHeAXFSitfQjEaon8LZyLH2QKCB0qUzT9XB9TDiIznjs+9gu3JYoiDvFmaSgtZcZB80Bu72lDoPdYgn9t9pahGvJuQGLy7nBordchwscrRSvynWmwrYJ11CQIwOqRvawZbFzduk3uzYurOQsd9gTqw63aSSszgt7BO5V+LP+16tleiDZWYZTuOzVZNFM/pruuevqQZpgc1YYx8ulc9JVh2X0wrVafqau1n2NorEKIyFRoAby+fUCDGeI/3RPPcuDWcox0MD5ULMPrhdrR8MMqy2eD+peX5JVYjROvhp15GBG+qBQz1GAGXYG5mCroHBRCSPITjb79Dt7cg3OvJnmfl6LyvQmjVHIrXT5eAOzuH2rm9VFVSytIVzfjNozn5qgU7hO6I+FJsor8jP1ALjc+tVBWG50e/ZCPJE6YiSQ27AOl92ERdLQVQ65+YQfh3jO68H0jar
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(346002)(39860400002)(376002)(38100700002)(2616005)(86362001)(31696002)(36756003)(186003)(2906002)(54906003)(316002)(5660300002)(8936002)(4326008)(66946007)(7416002)(8676002)(66476007)(66556008)(31686004)(6506007)(41300700001)(966005)(6666004)(26005)(53546011)(6512007)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0MvY0hVZE9FSU5PSGhudTc5YXc1S2c3YU1zcVRONFloK3R4UWJvTXJlVURR?=
 =?utf-8?B?TytuUUtCMzRDdnM2T0Rod25VRVl4Yk9IenFQYy9DL1Q0SWVIYWpQZXpQYnRG?=
 =?utf-8?B?YzBlK3Bkb0NuUGxrYTBkSlQ5OWMxY1kreHZKUzNYZnFKelk0UmptRkxUZ3dM?=
 =?utf-8?B?QzkwU0d5QjdHNk41OFFFMS9jakNGdGptZWZ2dWtFa0U1UGNkaGkxVWFqQjFT?=
 =?utf-8?B?QWkyQkRkNlhLcFdMaEFMZ0hEdjNFWElHWW1hbFVLV2ZCY3NjSXFJUlJLVTh2?=
 =?utf-8?B?RHpTU2NuT3cyWE9qMlU4WmZaSnd3TXN1T0ZtQnRieDdjTDJ3RzV1eDhiaEEv?=
 =?utf-8?B?WFo2OG1jeVg2bUJ2S2wrM3VTVjc2WHRZOFBHNTR1c2FPNnJROURoMmtnWkxp?=
 =?utf-8?B?OGx3K2FhdXdnTU5mZi85M2RhRG1JUS9MbUdwRyt0bHJBRVJXNXVrSGtqVVpF?=
 =?utf-8?B?aXpNME9Qb2I2SUpUUXI2TlQvQkM4elMwcVVCckxnZHZsejhVYVpjc2dQelpK?=
 =?utf-8?B?WHRDaklOam1USzhTaTFVRjlmQ1dMWFlNeUlORitHZDMxVm1DRXJEYmR5TGgx?=
 =?utf-8?B?cHZoSDBIc0lTRUZLa095TmNQZDhLaFFielVaMWI5cHd4c1JPT3AySEZ2Q21m?=
 =?utf-8?B?MEorek9ybmlsa3FjU0J5WnNaWDRXS0Ezc21EOVFPMnVnUDlvUFUwUVNadmdM?=
 =?utf-8?B?UDhySDhOS21SSFUwYk9VZjZ4MzRoaUxWdDk5Y2tlU0RPRWFNai80Y3diVndU?=
 =?utf-8?B?Q2pTNVdjMzNOVG5LNTVCMWNyVG5HSTA4QVJPMVhkNlYxblRCSEhFa01WTXkr?=
 =?utf-8?B?SmpPTzFpOWsrSStqZGhTSHlMdW5XNUFZUzJjdEEvMlI0QlVDaFBiM1hWL2xN?=
 =?utf-8?B?bldBUTluK3lKUHVidzhiMmRWeFRFdmc2aFZMdnI5MmRxYWRqdnlwVnQvNzA3?=
 =?utf-8?B?MFllQldXTy9idG1NaWZsNVV1TldoRUJ2R2pSOXY4Y29UbnFnUmx1NmRBclo4?=
 =?utf-8?B?bmt1bWNYcEZBZW1KeVVLc3dFVDdoVXN6SnlISWFjNWh5dFpObWNvdmJLVWNx?=
 =?utf-8?B?VUF0Qi9yUldYaGw5aHJlcDJxL1dBcCtYM295c25lSUtCajMzekRhUEZTVm5D?=
 =?utf-8?B?UFZpMjlXTHR2cU15bEg0QmRkL2lBQTA2MnJCS2ZWN28rSkZ2Mm5BTGd4Kzhv?=
 =?utf-8?B?QVMzMkhIUy9BSUZBSk9BSC9mOERQL2ExdVM1OE5oMVdLOWd4VGhZYTFHSm5m?=
 =?utf-8?B?WG9MQUZhQ3gydzdxSXJFcW9aSjFsYkZSWFlDRERwZUJHVXZwT0pyT1ZzTnV1?=
 =?utf-8?B?YUU4b2ZUVjV1M0VRMWxGTlJ6VlhNeTJrcnlndElCRklBSER6eTFqWjVYcTBG?=
 =?utf-8?B?cW9RaHJRSS9YMWhEejlBaWtNQ01EbGFMdWRHQWpwNkJRQ1dNWWoxWXI0S05r?=
 =?utf-8?B?MlpUWlh0V3MveWc5aVh5RTQxaDZLeTZBczFoNktoWnVzckhpL0xKaURGOXR1?=
 =?utf-8?B?TS9EdzRHdUdtTUZGMFN3L1MraUl4bGVLczZISENtaEh2SGVZWEVEREtySmJp?=
 =?utf-8?B?L1lxVEFqbElGSkpsRWVtN2FkM3VidlVUdVNSa2xRNldNZ29mbTFvWklzRHI4?=
 =?utf-8?B?dS9nRFVmSXNEcS9zc1ZPQnlRZ2hBNXprNjdOQ09wcVZZOVVqY1BIa3ZDamRN?=
 =?utf-8?B?azhZYUxQclVnL042cUVKSjJvWXFPZ080REtrRS9ESFJOOXZOVjhZUGZhMis4?=
 =?utf-8?B?cVczbUx6M3FwdE1Hdm5pZ1RxNnFjRW80amZ1WVYzZWFWSFZjL2wrUmFUMHQw?=
 =?utf-8?B?ZXprYlVqSGZnOEZ5N21TbWg4QW1oOGtsbVN2c0FaNzk3RTJiaWVTRlFmQThZ?=
 =?utf-8?B?V2wvTzlSV0tCMHBncDZEQyt0YmthckhjR00vNnlrNitIVklOSGM4VmUvbXNq?=
 =?utf-8?B?ZmZGemVveWVvZkVPaVFySlpJa3JjeDdLcDhPTStYU3BvRTgvZlZodG5URE9k?=
 =?utf-8?B?eUVLWG9mMTF5bmhvVVNoczhIK2R3bG92K2ZJRnhndjR4ZENNMHFvSFZZTm0v?=
 =?utf-8?B?Wk1pSW1iV3RrOGFDbTN6REtVODR2S25TQW44N0ZTZGxiWTdwaW85SlVlUmRM?=
 =?utf-8?Q?hbu3DRiGAkyJPwnf0YY/1NPyX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af00fa85-9396-4cd4-a86d-08da85ca1d45
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 12:13:55.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zEyc9Qzyl3zNMFa+wx20/O0ggAIt6FzTPm49/yg/DUu5Qr1bL7bTelr00x7rrMNXbCyPy8VuFmUhfUFr37phA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2022 19:41, Charles Mirabile wrote:
> This patch adds the device tree bindings for the Sense HAT
> and each of its children devices in yaml form.
> 
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

When doing a v11, maybe decide if you want to split this patch up. This way 
every maintainer (MFD, auxdisplay, input) can take his part of the binding 
description through his tree. Otherwise you will need Acked-by tags from them 
and one maintainer to volunteer, maybe provide a stable tag... Having it split 
up seems easier to me.

Regards,
Matthias

> ---
>   .../raspberrypi,sensehat-display.yaml         | 26 +++++++++
>   .../input/raspberrypi,sensehat-joystick.yaml  | 31 ++++++++++
>   .../bindings/mfd/raspberrypi,sensehat.yaml    | 57 +++++++++++++++++++
>   3 files changed, 114 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
>   create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
>   create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> 
> diff --git a/Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml b/Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
> new file mode 100644
> index 000000000000..0cf59b0a519c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/auxdisplay/raspberrypi,sensehat-display.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raspberry Pi Sensehat Display
> +
> +maintainers:
> +  - Charles Mirabile <cmirabil@redhat.com>
> +  - Joel Savitz <jsavitz@redhat.com>
> +
> +description:
> +  This device is part of the sensehat multi function device.
> +  For more information see ../mfd/raspberrypi,sensehat.yaml.
> +
> +  This device features a programmable 8x8 RGB LED matrix.
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,sensehat-display
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml b/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
> new file mode 100644
> index 000000000000..98b03878a570
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/raspberrypi,sensehat-joystick.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raspberry Pi Sensehat Joystick
> +
> +maintainers:
> +  - Charles Mirabile <cmirabil@redhat.com>
> +  - Joel Savitz <jsavitz@redhat.com>
> +
> +description:
> +  This device is part of the sensehat multi function device.
> +  For more information see ../mfd/raspberrypi,sensehat.yaml.
> +
> +  This device features a five button joystick (up, down,left,
> +  right, click)
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,sensehat-joystick
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> new file mode 100644
> index 000000000000..bc53834fbaa7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/raspberrypi,sensehat.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raspberry Pi Sensehat
> +
> +maintainers:
> +  - Charles Mirabile <cmirabil@redhat.com>
> +  - Joel Savitz <jsavitz@redhat.com>
> +
> +description:
> +  The Raspberry Pi Sensehat is an addon board originally developed
> +  for the Raspberry Pi that has a joystick and an 8x8 RGB LED display
> +  as well as several environmental sensors. It connects via i2c and
> +  a gpio for irq.
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,sensehat
> +
> +  reg:
> +    maxItems: 1
> +
> +  joystick:
> +    $ref: /schemas/input/raspberrypi,sensehat-joystick.yaml#
> +
> +  display:
> +    $ref: /schemas/auxdisplay/raspberrypi,sensehat-display.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - joystick
> +  - display
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      hat@46 {
> +        compatible = "raspberrypi,sensehat";
> +        reg = <0x46>;
> +        display {
> +          compatible = "raspberrypi,sensehat-display";
> +        };
> +        joystick {
> +          compatible = "raspberrypi,sensehat-joystick";
> +          interrupts = <23 IRQ_TYPE_EDGE_RISING>;
> +        };
> +      };
> +    };
