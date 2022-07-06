Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFDB567C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiGFDM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiGFDMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:12:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2112.outbound.protection.outlook.com [40.107.94.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B3E1BE8C;
        Tue,  5 Jul 2022 20:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In+XLlIKDxQT8P0zoCW+jkD5nvApJwtd9QIjRJAwpuKkTCfhB8Auhch4X3q1+Csr953r05tKSCIKuFwihxtT2nRfztexbm4OERwTiSH4nWccAn4qMgqtXhCrXHdrZG0NlM1AtdVsbpY+Dt8uVTRSca4k8y0CRje1q0EJ8gy83CkXdHWKME9mLDDeCGGSFiN3AeYx+wC06UbbRgkwI3Qk2Uy5oDFwZKGcOt6m1T9T126ytm8Y9kw292zCF158RXES8e9i70PHYm0oFernv8kDcqg1O7CLQYulS6GKfrzneZHCGKwpRlWwt1zFP+NpJoxVJ8w7NmtN/tQPnvX2sM/8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElQkepXDN1J/yU57KPvK44raCbHSVBcwoibyBNeOti8=;
 b=a2L9hcJHXaapxzV+tz5Car95jv7nnWN+O3avzEN43J7eKVffJ86VAd4o34DqQVTfydzzfFJoA7U7RaoTuv2GBBANtszd3YjtsGW9FfIdWVMcOC+/Ju1r9Z4BmDQo0BJ3WujXfIincNYDXnvxH6iMiSja2On980w3QgLYcB1GcxR/g0IUP4VJj+5Z0yi3Jp4446FL6XmU/MajVSSO2xFtVrPMl8wl0mgprKwBDc4p1mCamyeYXS70BLJh372xtRyNZS54KF0el8OmoO4wbg882ZS/VjXoOHO52WLCXGQLMsGzpA4tv48kDR+6O0Svgmq6WhwyR5kZNC6e3V3nb/st+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElQkepXDN1J/yU57KPvK44raCbHSVBcwoibyBNeOti8=;
 b=q8GPzO1+HPWnXIgfVAbZ3odXbvTLCzLjOxZCwlnGAQWJyIiPoKKIfuMxzPg/dJlEsmb8RAboiE2fbB3YN+s7Zhyu0+adfdoeX3Us4+Irby8wBtmFN1x7qsVgh3vF5TCyzo4nzrwuGwtRqp9+E8tPrPpT2FJZd2ZysAjL1Eyemz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by MW4PR04MB7204.namprd04.prod.outlook.com (2603:10b6:303:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 03:12:18 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 03:12:18 +0000
Date:   Wed, 6 Jul 2022 11:12:13 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Message-ID: <20220706031213.GA2360294@anxtwsw-Precision-3640-Tower>
References: <20220705053657.2340274-1-xji@analogixsemi.com>
 <20220705053657.2340274-2-xji@analogixsemi.com>
 <3e2c2b6b-713b-e613-9712-0b9c6d8ba8cc@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e2c2b6b-713b-e613-9712-0b9c6d8ba8cc@linaro.org>
X-ClientProxiedBy: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a6a726e-57e3-49d5-ac9b-08da5efd5586
X-MS-TrafficTypeDiagnostic: MW4PR04MB7204:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsEWP/XSroFQ33V3BGaoMbhYc+XHTnhBTGKvlCpPMQeyD61xnxcs+vx9OSevI6fTpzQFAcrTKjBj5SyISyzdPec3drx1IAP2lSDXH177ZFuG6UfO1Jr2r+pdAids5yJZra5pHee+QpW8BK+Z+QDZGyS4nzJfFaJzOQZuPUN8ZplK5dM50NOc+xnwMXlIV0uvLcLOURzz54MOr93J6gYJQxpJYQqXUc0oUhqIjrpIarpGIcifOoUdZTToO0gTenOCiQ+A5rfkCUmYjOi9i7SBQBM0Xx+3R7AM4fmy2Z7DnuX+1hWlpsMS6gsJHjrPjAML2xLiUjac8DcMrKZURRbGx/l4Y15BB7maf/NnvIO3pdSFb6qHgh6ajb/RPfD1oYJyldViwlIbpxwQ4kFH6ie1JWFsVkjmSwqsiSu0G3NenkDpfxQM2jsEwAzr7xEoKQ77te0sjXyY5+iiOVwn9EphTpE7CARZ6yjl+VN8hp0gJ+pWaSxhVpCKPQWHRen853LXG7S96RJGhk0sQ/TJyvAaL+LZo/Z+raY5cnNgR0hKLN3U3Ke8TYaeaejh7qURhXTLmO7xjdYc6ABA02oFQa+V6bcfMhgdTwKeA99nX5I7gbFv/Y5FyM8ohB0WmUPFeEUKPFelFVTMEiABt0vjJ3TUiqCEzAf5zdKvAfv7jaSNwfDcJnNVcsXRddVtm7I4ySWdP/GJzhWl7qOg6KeaxaFs/YE79v1uYHV+RxjHRBHNnGKGUzB/W4Vck/hWyA1NDZvCQw8QJbs31/5tjTvUS6rY7rczxdZJa3M5bblOCGG5RSExtATKgJUiQC6NFB6YB1gVNf2PqeCqnS/6las4rvk3n71YZ+8vMgVUprDqWBinsp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(396003)(366004)(39840400004)(45080400002)(316002)(54906003)(6916009)(86362001)(8936002)(5660300002)(4326008)(8676002)(66946007)(66556008)(66476007)(33716001)(9686003)(6512007)(26005)(186003)(1076003)(38100700002)(38350700002)(6486002)(966005)(478600001)(6666004)(55236004)(53546011)(52116002)(6506007)(41300700001)(33656002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZnJNtBBSwcXWf1e1zXZHeqeE10bFD5YRL7nf9Xtq/uA45Nz44mjhp30KEIdG?=
 =?us-ascii?Q?k6uuUp8qQxTSi/wcl2hlPUgWB0nIpb/yjCjO2d7JFjc7DTQBbiwip0fDK3r0?=
 =?us-ascii?Q?LzmAI48wn5uk0Odj4B1MArM9L92ilDDkuI30ItgaMTgMKIrSTu00ZoGOTOff?=
 =?us-ascii?Q?fUnNb9uvWtEglddiwvlKjFfvGbIgXckmLPf4xuUJ2NsiDg3mJJTu7p/hMOlS?=
 =?us-ascii?Q?/htaFNRkWCG/eipTg8Tzdy6z73YjKoMkkMyCAXWiWvZXBDIqf9cOANx5h5Xl?=
 =?us-ascii?Q?0seSmHpYBAoJh4XXXpv105V9n3HzgE29XzEJ/bHCaVOp6g3CEE3A8Tk7ys8I?=
 =?us-ascii?Q?21iygc5jL+QHJBomj2AZnDM4XOZPX86rNzSPjFe3U/uXbz+klEiNVYnFUvhQ?=
 =?us-ascii?Q?11A/LgYppP0B2imW6GEvBrR053Mcwq3jQha8xtDDz+hUg5qJ/CkgZV+ZOm73?=
 =?us-ascii?Q?zeTvlM+Ijy4xj0320dtFV3CkhyT+keZzAeKzQhwQd19B1TysnM8jsbvVc3K2?=
 =?us-ascii?Q?SopJcGY76+j8Yhmp2okomgNur/46MFuSr1tyAFB3ck5L4MlWYL56pvRYC38w?=
 =?us-ascii?Q?f2ETsEQUPKfp3hFnBjGS0yV7glcBezO5TSyP5ducCjoiY85O9TdEiCSplryn?=
 =?us-ascii?Q?VI6p78/iG3jBGNYlDPW8IEYAID9unZ0xnnV+eVE1b1LKfYiMiQeE1Bf3yo5U?=
 =?us-ascii?Q?8FGjp6iWNpYDGOlj3X2NkAe/GVmLYjBqK2733VNbumJeLe7p98StTEipjnsR?=
 =?us-ascii?Q?4fC8BqVzXjPO8XY/BDEFtoP2/AyMavR0/3bUkNT5BSXtgEsspKXRkzc/wqbW?=
 =?us-ascii?Q?agAM3/hx44KF6NnqtpH9qCw+E+Pa4CRGu8gzYV87LCka1q7UrAlmXdpxGld8?=
 =?us-ascii?Q?KP7eMyMpGlpGbkc+lr56/23dkX1gNUu8Fqp8sKQnJCoLGQv8rpmJzuVEj0Lh?=
 =?us-ascii?Q?82eb4e2g6bsuTjDpGnCp7eB0mVgdm9j+njpzMcJXbIheG/D3vii5Sz0W/m/d?=
 =?us-ascii?Q?oqaWXeqSrYZ9MWmndFSBDF8wJDh5Dj8xF1hIK6zzZuJtq3rmIxMgwMWQGwZz?=
 =?us-ascii?Q?bwHRYdRujzPEibGx3LWLjlgZjQ3ZniNLgRs702fdUA0LCqh7E1BEY7+J+fAN?=
 =?us-ascii?Q?m3m4rNUsK2d/AKCk8lf2hwCWTg0M/63JX7+ErVxjUeHytgLBsXMNR9/sWTYO?=
 =?us-ascii?Q?QDgsh3Uo1+eVkiCDyDO9Tpa+e5j0+AjYzertFWlFUuLutnAoUFZXTVkcSnPA?=
 =?us-ascii?Q?iH5i83x27rIWAjVt3e/cHqG/K8KFQfrB6+09nbEdA4YKYL0Sm+40NvSKLJeo?=
 =?us-ascii?Q?ZcyB3KFvXWSqwdpbpuE0FqQ0XOTPgJH9aTt+szaaoqW+zEjNIu03BgK9aAAG?=
 =?us-ascii?Q?ZyG3lcB3mAUp9V4kuk6yDtLCRreDgG7F+mrUovPbvDAnMYRAGg5hLRzDWRoU?=
 =?us-ascii?Q?mw5Yq960UcqQ4ZdNZmr+xI0zNVsOluVBoN7smtfscLloBSyx0O2prNIM6HFD?=
 =?us-ascii?Q?vjRsPyQ92Tj5pGCsbGzHzQU3VI+VszXzWj8JGcTASqsyeT514g6D5I8e+jsC?=
 =?us-ascii?Q?6T7RqlrnGAefTo7BnkwsIXu+Og3+xTnK+9swyHTb?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6a726e-57e3-49d5-ac9b-08da5efd5586
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 03:12:18.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNya4GQL1nGA8WqynOfcowXXPBuTBW+yxFr+47wBaiSTdh1B40T8NX/aVfJGLXVsLWlYI/xXbZ6t7489uZUBkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7204
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof Kozlowski, thanks for your comment, I'll change it in the
next serial.

Thanks,
Xin

On Tue, Jul 05, 2022 at 04:27:28PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 07:36, Xin Ji wrote:
> > Add analogix PD chip anx7411 device binding
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > 
> > ---
> > v12 -> v13 :
> >     1. Drop the quotes for "$id" and "$schema"
> >     2. Remove "allOf" label
> >     3. Change node name from "i2c1" to "i2c"
> >     4. Change node name from "typec" to "usb-typec"
> > ---
> >  .../bindings/usb/analogix,anx7411.yaml        | 76 +++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > new file mode 100644
> > index 000000000000..57429864d499
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: https://nam10.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fusb%2Fanalogix%2Canx7411.yaml%23&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Cbb10f7b74a6d4924d7a108da5e928029%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637926280579332615%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=JfpqaGXa6TUI7iOzxcxOuSaQaMHdoWxqH1fTJCuHi%2Fs%3D&amp;reserved=0
> > +$schema: https://nam10.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Cbb10f7b74a6d4924d7a108da5e928029%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637926280579332615%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=oK3lhKtiDat%2Bm1u7%2BacAImLuxsQ%2BkYTV9TCtZAweK2A%3D&amp;reserved=0
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
> > +        usb-typec: anx7411@2C {
> 
> 1. node name is still not correct.
> 2. lowercase hex, so @2c.
OK
> 
> > +            compatible = "analogix,anx7411";
> > +            reg = <0x2C>;
> 
> lowercase hex
OK
> 
> > +            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-parent = <&gpio0>;
> > +
> > +            typec_con: connector {
> > +                compatible = "usb-c-connector";
> > +                power-role = "dual";
> > +                data-role = "dual";
> > +                try-power-role = "source";
> 
> The DT schema requires ports property and just "port" is not accepted.
OK
> 
> > +
> > +                port {
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
