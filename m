Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC67D573128
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiGMIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiGMIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:32:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2139.outbound.protection.outlook.com [40.107.220.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6588E71BFC;
        Wed, 13 Jul 2022 01:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv9vbEsl2ZBunVjdTFEXx92agW6LlkcedXERy/YtDtUekwgbjYyfJmFrjc6HB1oEUjpo5PBrV0oRCdG0cLcf87oeHjpSCV9oYL2awYAfOCDcEDzFSyDQ+SwMRdvyF7MUs/+To4pYhsEJISfo3xcKVuUs9nPvGL3XpR8g3S476puFl6/1QwRWDX1DRkl0+WuerxtNtXfisYORKX+atcGBTHFwlErITNRkUryphG66oYPdXTrhHjCNaeqgul5GpcutmXvaCPCX9ObMDtuvbr6LE3Z/mbEuZCPD1XibxvKXxneBEy1aOhIKZ2AmYUhFvorAqyIzplLEuOAXzEIkDb9MRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMnONLkrCU8bR+xFzKK/3nFfT1r9Shur0CI8YnsF8n0=;
 b=XUoKCe8DHarcQuJQPgtstr78BAdDYJWb9l97JJD+zg0WYjzd8gvdgLjVqjAuuUdOQ+vzZ1lKmz8kyvJr5z5h76xNo0P3ivzYNVk5rUHECqwoXVrrCeEKVqbkz8bfajqKL/kFQsLsRNpqw3jslYWshyLa0PRnV/RaxPcd7Jqm5MsM3iIFRBWEDpRrC70soryM+zGnS8fXOMKr1i9HVZhFZL585ozGKzV75zx3huWGz1iEXylb93/obc9/wvLxkJX66JUA43XNCqJQY4Ec2A3DKNPafTS6vAgZgzE7f2KPzxdGU8bSOw6OHix+XCFNTLQbHqw4yw4aijzZqOm71EVZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMnONLkrCU8bR+xFzKK/3nFfT1r9Shur0CI8YnsF8n0=;
 b=FLfTH6QnRG3TxDQb5pxRq6aVzRgj8tXGYW29I0OFdfYH19phy3jDwk2lnxBxdYvyQnQK3lz3ui8GgTLFfRQJMXws/ygMA2PThIDVo3FykDlQ4Ri/hoHARoXKB0S79umbZz0L3gKTAWaXIP/B6qn2Vz6X6G7l2w95p5IuCoC15m8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB5340.namprd04.prod.outlook.com (2603:10b6:5:109::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 08:32:24 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%6]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 08:32:24 +0000
Date:   Wed, 13 Jul 2022 16:32:16 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v17 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Message-ID: <20220713083216.GA2789798@anxtwsw-Precision-3640-Tower>
References: <20220713072943.2789612-1-xji@analogixsemi.com>
 <1cbe0b48-c472-2bd8-9153-6ef0412adefe@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbe0b48-c472-2bd8-9153-6ef0412adefe@linaro.org>
X-ClientProxiedBy: TYCPR01CA0128.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::20) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 796d41c3-eeb6-477f-c2cc-08da64aa3618
X-MS-TrafficTypeDiagnostic: DM6PR04MB5340:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6R7/sqR5YS67ZRWSFHuri2J8nosZdbi185LsN9fMm1wgRqqbU1ngi2qbWdRWL5p4OCWCKA/C/sNu+Igg+lkZ5Qu8hAncilW4RUv2CI6JwXIEqjIGHWAGkeM3UuyJ8CkJKcOELKqYZ5k7kw1fBaSB+1m6kDeDwE1V+AJfGdiPbEUP4H0pUX3GN8gc+eTbcOu9zfMy3FlfFW/C09g+Mar6kh1RnBUhZLRQgWKNaZnGcSSzqH7pszZAIHiIVTmlmDU0UggC/Aie946J+UtLIDtKIvLDeE/1tYR4JD72BRCBMjUHyUiFfbWv0Cug3yIbGOLiYAYocbGDCB6LHFFsTB6bBzPDWRrMbtS1PXzgnTTEQSSmGtvGbaQFqFUM/h0pOqYiO6HC5mYw5hWtyXE67MSRR4jaLoUUWqve6lNE0zdYseCgXBztvqXTVVXWbJ8HCAOB28FH/ICTdvbB9SlElDizlWiCG81oz6JgBol9Qh7JC6Wu9bzqCuN9+mHiYgf/ZWaDrjzVm6JX/bhHJIgXCvEg720iOafR754NHm5qHPQThMe+IbKqZlT8+nSQIz+VbVtP4NlywuSl/L1lGrKxcDU+FJCOh8EZ+86/eC2jprPK+9j7GB0tyF6uBOO9kuyCA35DZ17UghQCIA1NMM2R5ENQU8UdlENy4ODFj4GJtVIzv/zROU0NiU1DvLuEBZpeBZx7kHUbLj1W1WDa6l3tjtKJJ9iVM+UnBq9bG555n8ipz0e2Sd1yBsUs6FqZsVJNjsRmuPs+UMsLmC9qrTBPMPcYPzGLnySUZZJHP9doiw0fkm6znqW/rRSq0uE/5xmzTjtKd8wsNoPjBOcvpBsKsldLdWjRIlsJ9MaOiy736nNZKJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39850400004)(376002)(136003)(346002)(366004)(186003)(55236004)(6666004)(6916009)(316002)(53546011)(54906003)(52116002)(6506007)(33716001)(478600001)(8676002)(38350700002)(966005)(1076003)(4326008)(41300700001)(66556008)(66946007)(66476007)(8936002)(86362001)(2906002)(5660300002)(45080400002)(9686003)(6512007)(26005)(6486002)(33656002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/2XXakxC+gtz8Ky6bEeLCYqRP5XZwjtDXgl8rCxggT16qt31oiYkdvdGIje/?=
 =?us-ascii?Q?5Qx+9/N+493FFjJUC8KN7nx71EaFGSyfBviAeR28Af/7uPhGDIE7UebG7+GM?=
 =?us-ascii?Q?MqdNFHmYBisqbQ+JDlWFvc3dyt+vGzYRtBiUcWVr66YoBrSBH/aEQEowzm+r?=
 =?us-ascii?Q?SXTkhdFRKTSpbYc9g0kTbgNwyrQXIR/EWpMjZJDkNnnyzG181O7E6/uuMp4H?=
 =?us-ascii?Q?I8SYFycDQMid0sgDKgKY/nk3oXTnk6Sld7L7jQW7zsFr30vxbZwpGsEeIvqo?=
 =?us-ascii?Q?u7M1oRMVvQdTTspB8REHHpZ20ou3hXV8cw+9jDnO0IxZYo5QSwNp0Clqxtl1?=
 =?us-ascii?Q?vczJcqgm5tth2+kWyv5230SUvw44mgR5yAe9AqCrqlZFQlcKJ47YfejWz6F1?=
 =?us-ascii?Q?vmH5utDoaVdHPQSqXqkYKsoIvff7wTX+tuAK5nHKJG/A5YGRc6FNQzbieIy+?=
 =?us-ascii?Q?HHBlf/KmroCqjiG606j/mO/5NN+nq5E4VJbGFbCIKd0XE09jbicn3Z11wKGA?=
 =?us-ascii?Q?PmLSVtOdqU+h/ocZLINpT3AW78aOcp2Jj1NnIk/8cC9aDIdlb/rUAY+uzfLW?=
 =?us-ascii?Q?U5f07qJ9MBvEk+vrAImyPOHDmUGTnd3J0oEK0Hh35f6R7Xa+sWmZf5Cd6uld?=
 =?us-ascii?Q?F/kz31PXReYpp8Tmc0LvapDijOZ7q6bioLMqqnWoGk42lao2ivK575gY+gQy?=
 =?us-ascii?Q?lgawii9PhELcsp4NhjBiT/y6dHPxWIcshuekqG+jnDIeeaiL0nVPnTpv5iil?=
 =?us-ascii?Q?ONnTY2hwgcffk2N+Z61ihzQCAMUOpkvSn0X4mblqjaof/Nx7ofDlSFN1pMRA?=
 =?us-ascii?Q?oKgpg84Vdk/TyGF1G1dUf9+/R/a3gpjUmMLzcHLbFty0gbC1UFwdMrhiFFat?=
 =?us-ascii?Q?BqPYMJE5gJxb+cH3HQtT2LnlDsbV16wjdpYe+sBN7rYf2RB7VxzXd+3UzU7Z?=
 =?us-ascii?Q?5FLpNkqAZ/tet4D7/ged+pVzgu0MDh65iOItoguVsITRzFLoqJtBoKHCXVY1?=
 =?us-ascii?Q?YjUrz4+CDirubrrMjeL9Gg7gsTXvJ1v0nTW0bjy602I/juz+5vEsOXbqiujQ?=
 =?us-ascii?Q?pH4FGtAvGr9G/yV5RiOf8gwoz98A8po7fkloyfJBjZHkS7xFUkV7ATreCgTD?=
 =?us-ascii?Q?UcGvUwEPXrdxPRZZHdA276yyxelquE2PYo7wRX7Vl99jXhN3qwI078NNcJiV?=
 =?us-ascii?Q?CLM07wTZfYfoWb7UTV0p6Ul0DTIk5NS38PcitVf2wOC+BogFE767wBXJx0tD?=
 =?us-ascii?Q?Q178mIh+oQkSiZpF+lomwxi/BC4QCk1tcsqMaVOx20Sw3BRyW8r6bt+nu0I8?=
 =?us-ascii?Q?R3VDWFrAeuvn1PcN0P1McaNLFYGyXfwb6z/J6rImMlidqKlYWOm6yOe6CY0C?=
 =?us-ascii?Q?DNLqxpdA1BPUrQ8tr1T4PNctZRYVZsOpCYCcc7tFR3Vhv4dRpACQYywKAL1l?=
 =?us-ascii?Q?6Btkw4SkOW74vVJqTqqSSyZbekMBDMUskZbpw6onoFOZXU1DVZp7WC0dIyxx?=
 =?us-ascii?Q?eE+BVs81xc5/A18Abjf/jqdr9oFw5XDRHTU9IAnpJZapltGQtB756cpbfff7?=
 =?us-ascii?Q?NeU+LzzNH2arMME3c4q4pCEELKr5o61hO2nTy0D3?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796d41c3-eeb6-477f-c2cc-08da64aa3618
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 08:32:24.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjc9DjH0v0Sg+YGFuLdkX0Ip2L+bDSctHRSqFdsDakrGzGnp1e2Y0KPZGzwoK6CWFyBKu0mWhgCVeGaMt1l13Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5340
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 10:25:55AM +0200, Krzysztof Kozlowski wrote:
> On 13/07/2022 09:29, Xin Ji wrote:
> > Add analogix PD chip anx7411 device binding
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > 
> > ---
> > v16 -> v17 : Add node name "usb_typec"
> > v15 -> v16 : No changes
> > v14 -> v15 : No changes
> > v13 -> v14 :
> >     1. Fix Robot compile error. Fix node name not correct.
> >     2. Change HEX to lowercase.
> >     3. Use "ports" property.
> > v12 -> v13 :
> >     1. Drop the quotes for "$id" and "$schema"
> >     2. Remove "allOf" label
> >     3. Change node name from "i2c1" to "i2c"
> >     4. Change node name from "typec" to "usb-typec"
> > ---
> >  .../bindings/usb/analogix,anx7411.yaml        | 81 +++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > new file mode 100644
> > index 000000000000..60aac5765320
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: https://nam10.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fusb%2Fanalogix%2Canx7411.yaml%23&amp;data=05%7C01%7Cxji%40analogixsemi.com%7C56773c30348841ded78d08da64a9519d%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637932975639786406%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=NEKPMjT9Hxp6uUsnYA%2BnrdVWedWovkV4bls%2BjYQQoDA%3D&amp;reserved=0
> > +$schema: https://nam10.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cxji%40analogixsemi.com%7C56773c30348841ded78d08da64a9519d%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637932975639786406%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=YD4mavtim6InAbpjgHYVzw74RNZTOpyXRkzKqPUVPjY%3D&amp;reserved=0
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
> > +        usb_typec: anx7411@2c {
> 
> Node name is still specific.
> https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdevicetree-specification.readthedocs.io%2Fen%2Flatest%2Fchapter2-devicetree-basics.html%23generic-names-recommendation&amp;data=05%7C01%7Cxji%40analogixsemi.com%7C56773c30348841ded78d08da64a9519d%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637932975639786406%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=x4UcIH%2BppZdbgsXf%2FPfvpjyUuvyVZB2tTNQqaXg0iXY%3D&amp;reserved=0
> make it "typec".
Hi Krzysztof, OK, I'll change it
Thanks,
Xin
> 
> Best regards,
> Krzysztof
