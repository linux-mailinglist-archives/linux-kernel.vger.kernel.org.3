Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CCD59ECC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiHWTru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiHWTq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2107.outbound.protection.outlook.com [40.107.93.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1DADF7C;
        Tue, 23 Aug 2022 11:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahtOnDhWimCab4FpvkhsWT0cZviSmP0CIDFgO5Hc3PoMRgVfxWKPj5N9aKohnEo82pz5GgC9RhCa3V/9pqup9xH/kKijGGu6NxeSbjR3GcJcnbQgZGRAhpes+SB7Htdq9dcxiggVDYlSfNLN43JxPNOtEV1RRC90FEz/Y3ClT2GZtOcGwUbUE4qLZod5m+KLO2O0CnrLmsE1lm9bUoflIJu5rI2Brbo5a/jIGWy7ZS8l/amJtQX5QkckLFH9nRSVf49cXDYLzaNj5OVykmgRY/t7b4q8hKKojspQHIA8+K6wkkQQnjjLAc611PrJjuNyo3qnVPqa1/BQ0KLCrF2XjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3MxHS9V7qKpBqLz3vTgInNDax0zdqf1Q2RMjo7MOWs=;
 b=LtFeDvLWe9GQZUKpr/PSJYwqF/QWsZqNw+UtcenPO8Nu/kYFx2viZ0goDYSyYrlrcPFRjfxrsF+4w+b3bqFUDM/giWsSAH6HJ6hImz9cI7DOyTpnW2FJ4rrXNE8b8OMO53YvkkEf8UI3JEQk5m9ut5rbPYe/J1xu9tebeBUo7+/SSE3jGV9U8E0XidKMEzUVU0/UfAzPlUkt2pKUhMIFjwK64IYerJnpROJpSD2ZRiAs1JZv7H7D58Fvuvztkl+A3+kq3jE2vFsn+94qOXBoxBF0zEl0T1Xq/u9F0fjb4QBQihMQbm/JpXzcxIkb7P9OcOIqQJHWSxE2t4PterI4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3MxHS9V7qKpBqLz3vTgInNDax0zdqf1Q2RMjo7MOWs=;
 b=E/vWaUteZJpE7qK1hYcOmcl0ZRA41m0/QQVJWaHTz9vcbV9sF9aavO9n9CdrSCMT+sFSOKI/5cL319E/0dwgvcA8YqakI5GJqB04sDsgQbcfrWKQxjvDUxGHQwiiqqy1bPToUIaYWpzh7wEBqVcl6h+nuGRGE0k8NAI8Ea+Gnc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BY5PR10MB4228.namprd10.prod.outlook.com
 (2603:10b6:a03:200::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 18:50:34 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee%4]) with mapi id 15.20.5504.028; Tue, 23 Aug 2022
 18:50:34 +0000
Date:   Tue, 23 Aug 2022 11:50:30 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v1 1/1] dt-bindings: phy: ocelot-serdes: convert to YAML
Message-ID: <YwUhdsROCGWLlHLA@colin-ia-desktop>
References: <20220823060052.3921849-1-colin.foster@in-advantage.com>
 <20220823060052.3921849-2-colin.foster@in-advantage.com>
 <ee93aa8a-d704-9d67-ad33-c81654c90ca2@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee93aa8a-d704-9d67-ad33-c81654c90ca2@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52e609b5-8600-4bc9-4dc5-08da85385c83
X-MS-TrafficTypeDiagnostic: BY5PR10MB4228:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzymYpldN4D5OGtkNdhb5EgA6/Y0RL+YspfPB9wKSj0LaiTRTY3oAL+iTvzXCYyctCq72Nqzj+d5CAaVY5e62ZWZ1gzeun6z0Q1xVNF+kDFSsVSsx2RRarQnXPvGCqC8HyCOVI4G7bx2hgKJuBGvTiBNudUNrkBbrjYp6Vw+CWgsjMcI20oxelAhyU3fYqpb7ZxC3zxnf/tHw1eUQEK+RvqQ58tgq9X7SKFAbAz0P3i6lBvz/6fQ2dfDWuV1EvVzWjp1fCSpJoc6aqVpUm3jLo3US+KLZPW+7QLwhAXYRloQXlPuHpR/wOSCQpPNA1aXHT9owEFvGD4h33jo4qYbdDLWtEn6DuEEAv5wbyWmZcaDZooVdjCpF+djjjCFg2CQSfnihURTlp0Z3tQmsrViPWY2E3T0wCNNuotEsjsMN5MbIjmvhv+gc3RJ0dxzrc570UzJeK4FSxO8QqZaH58gEDno7o8H7XHADvHUyqcoOlU8ZzN1v/vfTw8JK0lJ0Yrw7+tQ50bktjTbS0D7zqsVOorGAwmiYLPFikSr4Kqq3mj1YQT8ZN7lxpcyOLwhLunW9CnwBKdq+6d55I1Mft3ZCDzbT4Qq8f4rfBc3DY0/R3A34tkqYNUNcausMG6S82kTDFzv6GfNR9+NCBy0JA72M3NUbq2E/Fozww6ByQoi0XZD7ikMo5Gsjt2aWsJAhblVdLLQCeuM60CxHM/cVKlQsy3HnYZ6zjXL3N7W0RRniI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(366004)(396003)(39830400003)(346002)(6666004)(33716001)(478600001)(2906002)(53546011)(966005)(6486002)(6512007)(66476007)(5660300002)(4326008)(7416002)(9686003)(66556008)(38100700002)(26005)(66946007)(8676002)(316002)(6916009)(83380400001)(41300700001)(44832011)(86362001)(186003)(6506007)(8936002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QncPyAe/oDfPfxwAuAJo9rmtF0BJSt8dImyt32tAWKyyxlK2wqMYLMfDu+k8?=
 =?us-ascii?Q?yDg2VebyUdF6AGsMz1lYdl28FeK78Gs/ELrkm60SDUZzIX7uYGURZGGf7hsq?=
 =?us-ascii?Q?QStig7+OkPnZiHxLmNWzFCXPsp8xdaogz/hVfvG4rIg7IsEmsjNTONDH+K6s?=
 =?us-ascii?Q?crjg5QNOi1OWv0AHFzQigVe4QQR3YT3EBYew69LZwpqzxjdWGXEr/yS3ceds?=
 =?us-ascii?Q?RQKt2j6qsi7MkSHE9exvQidlt/Ml3mUfC3kJe5ek1eIlWaAyF7Lyp8dMNfyl?=
 =?us-ascii?Q?om+VUp7tdcKJUILI3uL6J2XiIpiihdz5iYfGShle8tswREDedxnxC72g4eEN?=
 =?us-ascii?Q?cgGJ7W7Ibb02XWlWnWn0MYiTKoTuCmkg7e75FZSJ+Xl702UJwIUy8K7ayVzX?=
 =?us-ascii?Q?bFBkkiVbDq6XTeNcv6TcnW6vYGr9Hlcw4LAwJpH+m0tWhTSFYBu1xgB4GfDM?=
 =?us-ascii?Q?erku7XDkHdjbY/XY7BJeX9iDM+JjvE7CaVg9mo4UHSevIHotFnmOkfxUd+ZA?=
 =?us-ascii?Q?sYMidsyI5nl9Ams6bXvtFuv5nHMMemRF7NwXZPTJL/Dzw8swLf+sGN4tLaKa?=
 =?us-ascii?Q?1yOeldhPEhZnnIm+Qg1shNATRH4gn3dyFsILFdQmga7wQufp/vftBecDS6Q7?=
 =?us-ascii?Q?2JJYB1vrmYwIZeJ8p3PCSouw/+8BnPlY2Sg4uAb7UcoJiJRfNJXeJb95JNvc?=
 =?us-ascii?Q?Epg00ycxPn/DrWR5PBj37aLo5yghcBFc/d7KahEOgAYGNp+tNOY+jeMxKPdD?=
 =?us-ascii?Q?+cQPrGh5iwq28FjTUuKBJnMOvh+MJ6YWW4EULNVrb9H3UaJ5f2LoUHB2NfOP?=
 =?us-ascii?Q?IB2xHrR1WwBrlXRkZoQgx2FlQt5nKV4cqBi1B/ydTcE0RVag9+/Z00OPi6SY?=
 =?us-ascii?Q?7lbLCwQB8u2vT3sjtDwSLbk0kTMfrvcGZ1VwZCJzRKYhC3yjNiEwnU6zbiJu?=
 =?us-ascii?Q?LrwiothD4594pd7VM1qfVaBYqqOYyuRCTIJhw4dbnGxzHn82KMxrAAc3WhiA?=
 =?us-ascii?Q?g2kbvbuF5liRtjHPjkc2+aN17DNTLRmudfCD09wgw1IVInt75BjyiZqMU4qM?=
 =?us-ascii?Q?lo7pQStKbM7FgR0vtLv48SoG1w2IhIVm4xFV4Wp5gF6xjVTfaxctmwQnzFm4?=
 =?us-ascii?Q?jxlzVQsCOaZkNbyMqsTYe1IzwlyXfmCJADK1owpgEFG4+XmOiPjjrefWLfks?=
 =?us-ascii?Q?KenCb/kBpvDDUwk47APeYvQqRPZwQnOT/WyvGlCRprDGUnftxY4isK1Hibdl?=
 =?us-ascii?Q?QZH++VtNLM8IptCrutZTL3OBDEwdCG5HDBnPJC3pWtptIICAEew9issNwQGd?=
 =?us-ascii?Q?kAris7xbW4bq9aVqppjClqB05SIyua80RAEXEcTs2JVOZc5x1fXnMy5AVV8h?=
 =?us-ascii?Q?Lk7/ySqQR/hMS2egsvSG9CZQ5yqxZVRvrCOJJ9gKArNlv0ABY33RTKVqQ6z3?=
 =?us-ascii?Q?VM5psGFccHZv1hhhIJ2ZjaUFzepgCTtYe9lbHEkXMx0NhVjWPvMh9gWyVhsl?=
 =?us-ascii?Q?y6/SoWNbkuKwgj4iCxFwoMd0VfpMhMuNT5Cot4gp69irqFvDLdZOUQ4XAtND?=
 =?us-ascii?Q?W2FlyJtyDm/z4/AFAavuU244hg5jL4pKhUc8JfEv/4yZPia3OeGyf3MsD1qo?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e609b5-8600-4bc9-4dc5-08da85385c83
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 18:50:34.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmzWjP9pT2hGDPrv6OEx4PeXQt1fMLiD1kicxYal8x68Vp75HZSw2rJ93512n9kNtUqxD5gxrrTU7Rkhvenz0IRr2SQir40UEBa4ZHfBRbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the feedback! I'll make these changes for v2. I'm out next
week and don't want to send-and-run, so it might be the following week
when I get around to it.

On Tue, Aug 23, 2022 at 11:36:29AM +0300, Krzysztof Kozlowski wrote:
> On 23/08/2022 09:00, Colin Foster wrote:
> > Convert the phy-ocelot-serdes device tree binding to the new YAML format.
> > 
> > Additionally, add the file to MAINTAINERS since the original file didn't
> > exist.
> > 
> > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > ---
> >  .../bindings/phy/phy-ocelot-serdes.txt        | 43 -------------
> >  .../bindings/phy/phy-ocelot-serdes.yaml       | 61 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  3 files changed, 62 insertions(+), 43 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
> 
> Filename based on compatible, so
> mscc,vsc7514-serdes.yaml
> 
> > 
> 
> 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
> > new file mode 100644
> > index 000000000000..0666974d886a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/phy-ocelot-serdes.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microsemi Ocelot SerDes muxing driver
> 
> s/driver//
> 
> Bindings are for hardware, not for Linux drivers.
> 
> > +
> > +maintainers:
> > +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> > +  - UNGLinuxDriver@microchip.com
> > +
> > +description: |
> > +  On Microsemi Ocelot, there is a handful of registers in HSIO address
> > +  space for setting up the SerDes to switch port muxing.
> > +
> > +  A SerDes X can be "muxed" to work with switch port Y or Z for example.
> > +  One specific SerDes can also be used as a PCIe interface.
> > +
> > +  Hence, a SerDes represents an interface, be it an Ethernet or a PCIe one.
> > +
> > +  There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
> > +  half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G supports
> > +  10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
> > +
> > +  Also, SERDES6G number (aka "macro") 0 is the only interface supporting
> > +  QSGMII.
> > +
> > +  This is a child of the HSIO syscon ("mscc,ocelot-hsio", see
> > +  Documentation/devicetree/bindings/mips/mscc.txt) on the Microsemi Ocelot.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mscc,vsc7514-serdes
> 
> Missing blank line
> 
> > +  "#phy-cells":
> > +    const: 2
> > +    description: |
> > +      from the generic phy bindings, must be 2. 
> 
> Skip first sentence, it's obvious.
> 
> The first number
> > +      defines the input port to use for a given SerDes macro. The
> > +      second defines the macro to use. They are defined in
> > +      dt-bindings/phy/phy-ocelot-serdes.h
> > +
> > +required:
> > +  - compatible
> > +  - "#phy-cells"
> 
> Missing additionalProperties: false
> 
> Base your YAML on example-schema.
> 
> > +
> > +examlpes:
> 
> Typo.
> 
> 
> > +  - |
> > +    serdes: serdes {
> > +      compatible = "mscc,vsc7514-serdes";
> > +      #phy-cells = <2>;
> > +    };
> > +
> > +    ethernet {
> > +      port1 {
> > +        phy-handle = <&phy_foo>;
> > +        /* Link SERDES1G_5 to port1 */
> > +        phys = <&serdes 1 SERDES1G_5>;
> > +      };
> > +    };
> 
> Skip consumer examples in provider bindings. They're obvious.
> 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 714fd8b45e5a..10dd3c6ad6ad 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13481,6 +13481,7 @@ M:	UNGLinuxDriver@microchip.com
> >  L:	linux-mips@vger.kernel.org
> >  S:	Supported
> >  F:	Documentation/devicetree/bindings/mips/mscc.txt
> > +F:	Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
> >  F:	Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
> >  F:	Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> >  F:	arch/mips/boot/dts/mscc/
> 
> 
> Best regards,
> Krzysztof
