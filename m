Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A79566188
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiGECxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiGECxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:53:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2103.outbound.protection.outlook.com [40.107.94.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16ED12ACB;
        Mon,  4 Jul 2022 19:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIKKxviZwmxHWZ/2Qid+e+NkPhS/WLdbPZGPha/4sSrffX+akRBp0ZeIcZlEb9pObYpl7g9h71XyLUS+7h8dBCsx0QJa5kOyu96bHMpWs/Lpyganag3nkaWkOdRoPV4alzEdnNZ2KvOZinGNU3Re+I7BnMyZfneWY4vbRKdtpoFXNaNj5Sb7B4pttwFYltd0rW65nWCWZGO7XHhG8oQHgITCSRFX65//1NzKbOp5HJhU42kQErdxLwqptzHhwhnk5xVnJmWua3mcKk4qJ1ndbhYpFOvmGLiCRWg/0zdWbR2rINY+u2l9YPxHfnDj75jCPCGzy2jKHZcVleY1Xkn+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf/hPupRF0PDWgRI2Uw96+aA0nOQCwry/vT2AsawAJQ=;
 b=kISz3KG9RQraKBRfetd+4hSQAxLdLDQDdWMg8DgKIMvsvK+sJGNlcQAxLixMA5utVjkXqrXKsAr475HQbE2KluBuDcnJ6Vl6zSjZbu9Xls8lQ3d5ipa0AoCvklebMJCm/PvrOwPoCaA4YKaA3v0dBWvhLYyKsRRlNOQ7SuwBFEFgDA9deBqo/o5rKIBuo5axAfG6VMasN/Wkr9Ije0IoojAKBxrIZItwA+MH0vOEZr/QcUtt+bAXL4GqZOO5gf+h+XQHV2IFP9oYk6B7c9lEpAc3KZu6ZorGMfIzorigMse56Ta6+nQ+ZEGIwiYwvrNs4lHtrQAcFaH2NH4fIp4QVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf/hPupRF0PDWgRI2Uw96+aA0nOQCwry/vT2AsawAJQ=;
 b=rpVvxLN/HaTTAlkQaf93GCeD7ycEWVT1HkXLU2uOMtZ1cgaU8bxOSpsDLvmqw416tYBaQ0SXxcSXlGlJgvR68jZCnFZDVnQOJeDRtRd0OGFm7zGN4NpeEgk7jQoJFgujuVQEVUWJaKLEbE5It/WA4y9eXwNcPthCyrP4lk3uro0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB4137.namprd04.prod.outlook.com (2603:10b6:5:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 02:53:15 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 02:53:15 +0000
Date:   Tue, 5 Jul 2022 10:53:08 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Message-ID: <20220705025308.GA2303286@anxtwsw-Precision-3640-Tower>
References: <20220628044843.2257885-1-xji@analogixsemi.com>
 <20220628044843.2257885-2-xji@analogixsemi.com>
 <f2b16788-32bd-a487-4087-66d876247fdb@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b16788-32bd-a487-4087-66d876247fdb@linaro.org>
X-ClientProxiedBy: TYCP286CA0048.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::11) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e92a87c-c5de-4b97-b73c-08da5e3181ee
X-MS-TrafficTypeDiagnostic: DM6PR04MB4137:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvZfn6L4Jnq6qBqTXIt8SAxFKw1veJN1x6Kx8DjWl5ChRN6oqeO6Rv3VSLWxOGR4xuYVJpzC/PifxFZG2v2d7ZUcW/HcN/TMiVbEx03g0+EkZ1oHpJ4AKiWuBt2oDxluL9Pq3rp/kl2wsAptvhLmoeJmYNWTZVkzR/11iO+Ma9gvI2UJmzT+4LHj08CYEPtWmGssZ49ON+A6hThRgoBtAuCC+bcBryn5/UIgGYrLIM6HmYRKZIcUcgEZrmCmwUFGFGRJUpK5JOFrcPu/FwvwAXL6TPTnT1Ej1Ebg4cnrqsO2C3Xgcmf/58HSU2n5HzBnsoueIzLFJEbaRf/BtNTyThpemPm9o17wind+uxaDn/c6bFUH48ozENaO9ZVk0q4cGat0AGfZerj4Us/fdA9vfHBce0mkshYoWVIwcwGkJquZLlP8fGGHA/guazUEPyF/z/1v8QEQdrMRsbdpd/xFN+NcLd2kRC/xiXc1ePIXbRrOhNi6Jem0LWWs8I0unwROSdwNhhVxFr74qXxCX4hIGvcPR2RaJ7mizaL2vo4Sn8G1JTBKw9tRF/shyt7clLA+ScdLDasLh4PsqRKwh+gXEB/zC5LHeiwd0LfgdekXogwRhGJs/GOpkP5oSCWRe5te5JEAmuWOR0KOzPjzIn1Sk9i42l2kVbKBZUwQ4CMKyG366IyLfpixGCOgoCWWaFP2vFYXjy9bhIIig1KADWMWAoxKml+TRHnt42A2AXrzIR7eNKYSep+7rjXf9rU9GB5ayd1k8fpeqgxoicMD8LYJ1NxkSrG4b4/pmIvX/YWwklphmiBs15ehRZzgQ73N5dUdyEQVXX0h3S53BlHWGQq/hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39840400004)(366004)(136003)(346002)(376002)(396003)(38100700002)(33656002)(66946007)(4326008)(66476007)(316002)(478600001)(8676002)(6486002)(38350700002)(66556008)(54906003)(45080400002)(6512007)(55236004)(26005)(9686003)(53546011)(6916009)(52116002)(33716001)(6666004)(8936002)(41300700001)(6506007)(5660300002)(2906002)(1076003)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YHKpwiIVFglpQ2/ykOEzb4VlKPg5ys+fmWg9mHCzjN0c8eqdSopi44oJFpyu?=
 =?us-ascii?Q?VMvtPoeEGg91w7KmhhiFAI0zFjWRgmLHRR9tbZCB3z+yTtzVVeD0qRnTMj5o?=
 =?us-ascii?Q?1e54D9FmNgc7Yec5RQ+8WQ33xEv5R7bbgFcpGzXQYMoqSaf3l5eyeh6inp0E?=
 =?us-ascii?Q?UdhbUynATC6Z3nvXAqCDcD6/28IEwkVI4htyNm47h7PrIMnkJBtnzMBlfLLb?=
 =?us-ascii?Q?Duiy9l86f+nsn878mdFTNmnDRFXtWSKe8mWEbzL1VEs9FqlI5pRMY22lZa2S?=
 =?us-ascii?Q?uc55tvNrFvosZEZ/uIbyk1LB54+/8fH826zzkIFi680aM/vx0rQja4pGK/89?=
 =?us-ascii?Q?hCI+Q36vlEoPnDL3ma5dWJV4hqa2D8RmlFS7cK2ZA6L2X0ZJXssNYmSBqSIo?=
 =?us-ascii?Q?xFOU0sU4KKTFxUUgtDcxs18AkfzyVpW6yKgyytvHqRBMxY9MTtGoTzEdA60W?=
 =?us-ascii?Q?niQi1GuvweL/ui4nYnjpdSkY14/pZUl9A74k7A3ner4BVX2vLJ+M4FX4xAdK?=
 =?us-ascii?Q?Dh9VkRjLlkxbLtIBlBAKESu34A2YW7EVW+MyvGcvD7XObbUhSBaTh4VeqWxc?=
 =?us-ascii?Q?uktKixbZvE7LgBlon+vITlCAE+9ANziGazYKRPwSM/SbvvSIjF9aNxvRGBLO?=
 =?us-ascii?Q?5XKyjuOBvELLMTj+W/xFCRyXVXDXlUTVfaATirYlK3Z6hUUDT34T99G8N8Oj?=
 =?us-ascii?Q?PdzBkhdUK1z6ejNbAE9X4HbP4877uMKNMnytze7cFC51310Dq59J+/hztp7n?=
 =?us-ascii?Q?2JuC4WzUciIl5QDU09XBHkvLMfo85g1zG3NVmQiXLkhRRXBUQhwUSl49stKd?=
 =?us-ascii?Q?yHBBnuv5QJcrY5NXxbypcAbuVT7I/ad1GRrixgHniilPG205JyjAoI5f0yTu?=
 =?us-ascii?Q?w4fdmwM9e5DmubsyUFEmbD3jR0kfPVfxRgH0nxL5zI2cPL1zaLQ3MHmLx+I3?=
 =?us-ascii?Q?DKUHRtDOPeopxFM1DGjHPbREtnXHjx/3QE8MCtSYVdwPXa1q2jPQ57KlzC/3?=
 =?us-ascii?Q?ynKe0a1U3hetBEfT38dB0EhiwMLhXd5R2yFhSsLykZ8bfOHwg87vOo56CZty?=
 =?us-ascii?Q?3yaFLdh3In/zE6Q1fvE5Ui8JgoVC0a6/FpSG2YXEFEJcNPeZe3gm6u5WK9zW?=
 =?us-ascii?Q?JxwcBVM6qUthR/vRqTtppHyvzTIQzc5CddnBJbH8398yLjgH6CXoHro/ILhC?=
 =?us-ascii?Q?eFXwX59t4td60WclkANDBsLT7O5gTPKWL29HQ1FX+Cmzg+EySznkzR3oYzwy?=
 =?us-ascii?Q?FXPoYKNufMiR9uDsGyBPB12x9nLclYAemneOpWK3P0Lu5oPrMw+L1xOnKX1P?=
 =?us-ascii?Q?ZBnOstK307TvAjgZlFxPeq33CueFIehSFZoqoiz19EXOxeUDjXkVPHtvfjEG?=
 =?us-ascii?Q?uxBBNRbrI+4oMbvrtQdQBzGsm7+ekdsd8jKB8XyHA3HO6SG8Xo199JhBGzjs?=
 =?us-ascii?Q?Zd/ikwC3UDJlLcq6wYmpCUiF3Q1v654EdfTF/6rNjqOpaoCTPApfX5hOe1va?=
 =?us-ascii?Q?OPpAHEYC6lpCAHKpUS+VAPCFRQPbTHaziFq27Kj5BVdZtoOczhXDkTng0S0y?=
 =?us-ascii?Q?acM0wtHbF5tUYAMXDqqo3fLmb+9bMnnDZO4B133Y?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e92a87c-c5de-4b97-b73c-08da5e3181ee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 02:53:15.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hegLdj+0jnVX7ZQNq+UTvy3uf7cJsATminu6tTjG525YR7E3qEnLxelzH3/UJd+SERO3McNoM/D+vCZphXBaCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4137
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof Kozlowski, thanks for comment, I'll fix it in the next
serial.

Thanks,
Xin


On Wed, Jun 29, 2022 at 12:12:29PM +0200, Krzysztof Kozlowski wrote:
> On 28/06/2022 06:48, Xin Ji wrote:
> > Add analogix PD chip anx7411 device binding
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  .../bindings/usb/analogix,anx7411.yaml        | 76 +++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > new file mode 100644
> > index 000000000000..c5c6d5a9dc17
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: "https://nam10.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fusb%2Fanalogix%2Canx7411.yaml%23&amp;data=05%7C01%7Cxji%40analogixsemi.com%7C3da117aa187343f9f18908da59b7e50c%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637920943621030352%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=RiPhqeKC%2FZjJYcybauOd47OgSmEXtqxoz%2BPc8nwcbAo%3D&amp;reserved=0"
> > +$schema: "https://nam10.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cxji%40analogixsemi.com%7C3da117aa187343f9f18908da59b7e50c%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637920943621030352%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=uCZMyAOdxsFcpDyn8c6WBwrs0Zraw3hloFZw6SjzXTA%3D&amp;reserved=0"
> 
> Drop the quotes from both places.
OK
> 
> > +
> > +title: Analogix ANX7411 Type-C controller bindings
> > +
> > +maintainers:
> > +  - Xin Ji <xji@analogixsemi.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - analogix,anx7411
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  connector:
> > +    type: object
> > +
> > +    allOf:
> > +      - $ref: ../connector/usb-connector.yaml
> 
> additionalProperties: false
> (on the level of allOf)
OK
> 
> > +
> > +    properties:
> > +      compatible:
> > +        const: usb-c-connector
> > +
> > +      power-role: true
> > +
> > +      data-role: true
> > +
> > +      try-power-role: true
> > +
> > +    required:
> > +      - compatible
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - connector
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c1 {
> 
> "i2c"
OK
> 
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        typec: anx7411@2C {
> 
> generic node name, so maybe usb-typec?
> 
> If fixed, keep Rob's Rb comment.
OK
> 
> > +            compatible = "analogix,anx7411";
> > +            reg = <0x2C>;
> > +            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-parent = <&gpio0>;
> > +
> > +            typec_con: connector {
> > +                compatible = "usb-c-connector";
> > +                power-role = "dual";
> > +                data-role = "dual";
> > +                try-power-role = "source";
> > +
> > +                port {
> 
> I think usb-c-connector requires "ports" node, doesn't it?
Not sure, I just follow the example, as the driver code test OK, I'll
keep this define
> 
> > +                    typec_con_ep: endpoint {
> > +                        remote-endpoint = <&usbotg_hs_ep>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > +...
> 
> 
> Best regards,
> Krzysztof
