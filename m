Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5E8572DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiGMGMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiGMGMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:12:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2115.outbound.protection.outlook.com [40.107.220.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F78DDA9BC;
        Tue, 12 Jul 2022 23:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om/S2dEq7tsOdi8DJCrgw8JjgUJI7G/Lc0Rxe5xWUmBy3NSa/22Hl5XS0wh67yFXtT8b3Oj6J39G1jJvKBQosO4S+MH/LrRcx6EyoTwrT6MloZAayMSpKMcljuEYnjrhtiObncir7MwxtODC6BLr+Rfwbia7BOC0AI7jFF1LZs1vfN5AVcRq986AfY+lWNdb2xFdI41XJ4TFKY6MNhJE9MLTNuNHc6kv6cA6PUOkoJvGwmlAUB4O37u0N+OD074nlmO3dR/GUt21dtOWpNGYx64yaC5h9q8w7nMqMW6x00oEfvCUDpu9HWrm+Y187ryVox8IyHWqhaJlrdQkG8OS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPXPyF94IDydSA03OEzxRNjINvwA1/Jy4Enq3QwlYto=;
 b=ZmmCYIyGy+HxAWjmJ1I0RYUwiXqlU2XeJKZGjK0YUY0TMyJ5JYJOFZc+o4CNN+aeC58IVWa55tBNVHpdYT0dPOfUb6ziGC7gGUbfTuw2aOXZT3X1TO8fk43mumoyBS05Y0MQgAkaBCY6cV9IpCPiYLFDjUZeTVq2JptCj5ieZJKFH5gtq/ej2+CF6bfpWcOe11Zbozr3oEPk/Ptanx2BIOKe4kU6huaaOI1yi1cHxBWtO1PHWW9asy5fE67PyrzAJCdgsNsQXoEj6CqzAitKGmxyCZmXXqaZLPSaLrPWh96QzpuNmNrWRhzHYQkhq2DNmLu+HSogxVHOhMef9YCGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPXPyF94IDydSA03OEzxRNjINvwA1/Jy4Enq3QwlYto=;
 b=l4o967BjHllWZOfyDcMcvqdjIFZjSTS7b56Vrlg1OronGQapVbRFORBxTVR0Ax4KV2BkfviBojW58Tw/oOYF/YsIUpLP6DABflWPjnX8NezCTQe5DTvCyBT+sGJ+MvSK9gNstq52a7Y4wYk1AGPJndS/CWFiKN4Cx6xanXo+pes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM5PR04MB1018.namprd04.prod.outlook.com (2603:10b6:4:3f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 06:12:01 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%5]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:12:01 +0000
Date:   Wed, 13 Jul 2022 14:11:52 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Message-ID: <20220713061152.GA2788915@anxtwsw-Precision-3640-Tower>
References: <20220712090534.2783494-1-xji@analogixsemi.com>
 <20220712090534.2783494-2-xji@analogixsemi.com>
 <a281de26-0900-94b1-c139-f7af27a57d42@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a281de26-0900-94b1-c139-f7af27a57d42@linaro.org>
X-ClientProxiedBy: TYXPR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:403:a::22) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 291e3c3d-891a-4d1d-da98-08da64969939
X-MS-TrafficTypeDiagnostic: DM5PR04MB1018:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1aMGCTyvLJdRO9ehGSojBKRfKU2Gqe0rQU6hECxsdtxpOydkhA3vrAtB00yKx1KJ+42fHUfZzEENXxu1AKcNvYRg8n6T6dS7PlJcGa17En02ZJE3sFUVwuXf+nrAUXmLZm6RJKDHmo1KvFwzuCmY8SUZIQbujeaci8rD/xIA+ZEdQl8axYCD69F4nB1xAFeE8OBcC28WjgEbO3KdxH7LZqpuzXbTsN14VXwlI8FgRg+NbqP8LC4T0Ra2Pk/fZn1BI5zuTx6WbJCFAnnh9PCNFZ/FBTJBGBMaijWk+rcSOt1UCY+c1NWzHLwTO1ZqL45YZS2Rd4cLVVEGo3IkFwbkV16jUvtiINha6saXnDKLRQM385RBF+Zc5tph7IparAa3EyCNDTUB+joub3QNKySQ+1hqTYHOiY17gOQN6bS2TTvmU5UpwvJjZOyvLqrObs5OfMjntIxnPzPpwrCedqb9Ma/bs1Bj5/SdBmZXtsgBf5lpEs1iVQaTVhIXs3AJlRWpT4UVXURITDR11yFt1mczotFLu+mLStH4wUp1x6WglLtInoET1727Ee2yUqabWQ9R4+D1Hq6dnEOXzcqi5EpFFcI4Va3OZIXN38VNKZ/GKIrJBKb+FbI8YQCWIk8Qxbr9PYPzGYEhYmZsTTa/wi5xgDjw5TwV7qSIvJgHXHFqVmL9x/oyb+66JaXysWBuTZRas6Jyl8qbOUzilUVAhk9P1SLVu8FzFUYJNPf6mjrVou5PMrIb5coGugqsOm682qFm3wWjo93usv8oDLaculbcf1SzBIRmji0cK0UKMNuowsb4aVOsmjWkWjdyoHzMgT0+KJaMjc2HJwy1ymFkuJu6Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(366004)(346002)(396003)(39850400004)(6916009)(66946007)(4326008)(66556008)(316002)(6512007)(9686003)(53546011)(52116002)(6666004)(8676002)(186003)(1076003)(41300700001)(45080400002)(6506007)(66476007)(26005)(86362001)(6486002)(33656002)(55236004)(478600001)(38350700002)(38100700002)(33716001)(2906002)(8936002)(966005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ksL9er+uei6GRTlnMW6UDXkJ2P4wZtQOtvhqCKsmzeQYCqmC0D60/9x5RYM9?=
 =?us-ascii?Q?GBOvkriLKo+iMPC2mghc7+U6FnRXPXhO9GSCR6ouZsNPCdptv5uVn9TzWJrn?=
 =?us-ascii?Q?p1Iox0gUn39frW5xJrI339fJDxQVCkyCAYeTvNMNpKIqWmJfoTTliMRtCvrY?=
 =?us-ascii?Q?jQ5lfRt4YChV6hyr/EKd1l+I4gd/4Z5NgUwKCXYbQDfnSEx+m/HTyGTVGPyW?=
 =?us-ascii?Q?yEXgyZHLDGkGes6dJhVla7mmlY79HG4d8EReOgY5ZjmWW979cnInDb7KKlXd?=
 =?us-ascii?Q?RX/7Y8UEyb8XDbtQ4ZK1EFl1LP29WF9h0/mbgN8kMWBKDDQ1e83TDLMTEoqi?=
 =?us-ascii?Q?bqkCIP2BM/Dt9UZw68G4W/VU1A552QLfwJLw+8xzgDSok4Sjh/hvhbImhwjA?=
 =?us-ascii?Q?3jGuKYhMqLtE9ZRQdUbQ3zs9UszK1xHUMyeUux0914xIVhmPSsEnUmWIRv8N?=
 =?us-ascii?Q?xLQl+IQ0dfjfRu/SQiabd98Lxg5/WOwmHaUOhh1Tvt7jWC6Yt0af8eQIRqZy?=
 =?us-ascii?Q?UhagmNNJ9sDNaworO38YY2sLGyhmeZP6RBUoiehF8xDwR1bBQjZF+Ry5oaa2?=
 =?us-ascii?Q?9WOyYIcYYQLVdO8pB/0b5RnpHKhE09LR3+FZjiYoj4DTQhW0C6mhlIEbW4/7?=
 =?us-ascii?Q?5OcFKuTV3ZWZyyQ0XY8hZfzsN2ZjGk3mYsq6lh3I2NGA6yH14pfXuqmUIpHl?=
 =?us-ascii?Q?ZS5zHSw9d16Q9geSfLUWi3nKl1N6WemjC06rw9nzRbZV/kPHlHsEuCfeiyHq?=
 =?us-ascii?Q?5HGnYTLNaC4jkaTOXZ9cf15aTtLFLbGzIhf304vn/6kcM5Zt9UIvvJCW53kz?=
 =?us-ascii?Q?IIMiDccrwQyKGlHrwh0nq1hkRdg5lHMRJOO1ZuV5m+/kCqn7d9VZO6ciOBC9?=
 =?us-ascii?Q?YsFNNg3NUy+QPzf0s+NA2JW7tRDYJ3yEN/e29QOwb01xco0dEx0RiXtcwywW?=
 =?us-ascii?Q?R3d/m0U36iNgvXhwtDPMzA9Ezpm+mk+eY+h3ce4kyIGMYPYAObjl4myK/uOm?=
 =?us-ascii?Q?VEXP4IvfpmmpWU9sYoNo81Pvqg6K0fqAhG0fnMkDh7JrvhMgV1IgCbL8EL+9?=
 =?us-ascii?Q?K9QyL+G1deSpSsJy5pUEevD72ieWMfyJAn2wlx0NvLKrAMNvUDjRKVTBu5w9?=
 =?us-ascii?Q?XG0OB59d1WFrScCCCX0oeBXOq6GlYigfnFnfx4NeBfXlak3l3xoT/y/ybxYq?=
 =?us-ascii?Q?qNVLln8rxG3wIFpgK+UITKUfk7KjS1ele5N31R6OcknDe91O5dZuFPe//m9d?=
 =?us-ascii?Q?CbSujgUmUmSUn0/lG9TS1qZMuGXY7shaOK55DSKjJfK1qaDRotc4t1I7Ovuu?=
 =?us-ascii?Q?lqMX6wZ6Agd1vLSmXQpQ5R7U1nXtxMspYet1SowzSoCYl5YoVML9jfkPn1Fb?=
 =?us-ascii?Q?Uv4xA7FZfv8Nq2LsXnuJukoB4l1mouYXnEw2uq6esOedzYFrF0cTarzW5cCz?=
 =?us-ascii?Q?8wulI8QVBAMcXEtHI45cJRDnllp8u+JObbIkgRmPvtYwRlMmwljo6S9FekmN?=
 =?us-ascii?Q?ceL7NbxX50ac47yF1VvcltH0Su+9oQzB+pxN7mQNeeEn3dLrss4FLS23qwAQ?=
 =?us-ascii?Q?widEYqxBdBpJiUQSB2ELkVzw1EbEq2B0MIoCourU?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291e3c3d-891a-4d1d-da98-08da64969939
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 06:12:00.7892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt5YD2fjxJCa0DmlVwfqywsibipUVlXFeTR/3zWzzrZ+WVGxr+X162CF5h14WLDysF431DLoJHrrNpSJ1aHi8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1018
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 11:38:47AM +0200, Krzysztof Kozlowski wrote:
> On 12/07/2022 11:05, Xin Ji wrote:
> > Add analogix PD chip anx7411 device binding
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > 
> > ---
> > v13 -> v14 :
> >     1. Fix Robot compile error. Fix node name not correct.
> 
> Node name is still not correct.
Hi Krzysztof, I'll add it.
Thanks,
Xin
> 
> >     2. Change HEX to lowercase.
> >     3. Use "ports" property.
> > v12 -> v13 :
> >     1. Drop the quotes for "$id" and "$schema"
> >     2. Remove "allOf" label
> >     3. Change node name from "i2c1" to "i2c"
> >     4. Change node name from "typec" to "usb-typec"
> > 
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  .../bindings/usb/analogix,anx7411.yaml        | 81 +++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > new file mode 100644
> > index 000000000000..bbd071ba338f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: https://nam10.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fusb%2Fanalogix%2Canx7411.yaml%23&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Ccaae32a981aa4c347a8e08da63ea5518%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637932155353583707%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=BGHo5E1W33sWfdhApWzq94%2F5TrDvfQc5lVF%2FSWl2m5A%3D&amp;reserved=0
> > +$schema: https://nam10.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Ccaae32a981aa4c347a8e08da63ea5518%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637932155353583707%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=7wG732uVpVNVjtxm14xiXKweazjop4xRTUe4HRZVTWM%3D&amp;reserved=0
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
> > +    $ref: ../connector/usb-connector.yaml
> > +    description:
> > +      Properties for usb c connector.
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
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        anx7411@2c {
> 
> Use generic node name:
> https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdevicetree-specification.readthedocs.io%2Fen%2Flatest%2Fchapter2-devicetree-basics.html%23generic-names-recommendation&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Ccaae32a981aa4c347a8e08da63ea5518%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637932155353583707%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ACf4IGwVwtO7CsvL%2BYj4bbl%2BG88o5k6PyEyxZCl2as8%3D&amp;reserved=0
> 
> > +            compatible = "analogix,anx7411";
> > +            reg = <0x2c>;
> > +            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-parent = <&gpio0>;
> > +
> > +            typec_con: connector {
> > +                compatible = "usb-c-connector";
> > +                power-role = "dual";
> > +                data-role = "dual";
> > +                try-power-role = "source";
> > +
> > +                ports {
> > +                    #address-cells = <1>;
> > +                    #size-cells = <0>;
> > +                    port@0 {
> > +                        reg = <0>;
> > +                        typec_con_ep: endpoint {
> > +                            remote-endpoint = <&usbotg_hs_ep>;
> > +                        };
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
