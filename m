Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FDA542FD7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiFHMHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiFHMHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:07:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A693BBFC;
        Wed,  8 Jun 2022 05:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVZVWEqQ4IsmO72tNH9OJ85UyqStlhi3f9mbtO64mgf9+jDGH+Sg+PUnikmpfwNCzD/WIM+FWnfoLIGEW4Qj5NCXZFFkXE1plY2V6+PjQp3PpODoxSDqZsjAU01LKsjDZHczEA7WUA454JCcNzYi0eC2Qf0bccqbd3waiAIeXyxqgE4QD0BDiKlNvn9lcVj3Mudr0A3HLX6EOAQusInFJKvK4Ihxo/g+MmIdxNLXFaxV5ADg1mtt9vlcpPAlB4vh5Ye6HuSTNWm7Nf7sM9QvKDJKpw8ZibzE/5TlJ7vPeOoABP/ZZITWLj5cXDvzGuXl0yLNlAmOk0V/vDSB3ytgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w3e/7VVxUBygyX9aRAik3EJavzfrnyQIbkeoDh8LPw=;
 b=Mh+KT2E45Zy88DYwfRuIkdfzmfWBXWQRxP3VuFJUIIKvNIaSr3DdzabCRZDJzsDp7G9KLmw89l/wcLU9Cqoe7X/uhYXjpyM+w5krv32tMLfZ2NW/fILe1/OKHjnEmxhVCUTwLplMUgZYIh0JobHDSWOuSR6ZIJoTnw/lT5LYgZyDHIbLBzc5jjf8rgWb7RlS4qLukEnQQPCuYbWqymDT48LZHO+tmkEUT1fVo0zLSt2Drq7vuY36Td8ro7qyiAD/ujMNlBYg+4Y3SRhUzJA8p28aUW496VKhktHhhVxMwNGnqeoBiDAb3vd9fBr8K2StnJVll2ZoImxrJ1PslmLLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w3e/7VVxUBygyX9aRAik3EJavzfrnyQIbkeoDh8LPw=;
 b=Rs1yC4Zefr1yvnaWfd4sw/GQDKU1Euju9Ahj6rpBbayOdDf/dFXCr2C82FCMtU2LBXXgNdepsAxVSJym7k/cMQh0ZiasTMCVbBC57zGF14hXRpmziZ8ZXe1zVlQt56na+0b8XxPIkZfrQLAGHk+kD5sV6+FVcnCr0nPP2o93Qak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DU0PR04MB9275.eurprd04.prod.outlook.com (2603:10a6:10:356::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 12:07:12 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 12:07:12 +0000
Date:   Wed, 8 Jun 2022 15:07:09 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] dt-bindings: arm: freescale: Switch fsl,scu to yaml
Message-ID: <YqCQ7e4Shtz0atDk@abelvesa>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
 <20220607105951.1821519-2-abel.vesa@nxp.com>
 <20220607162801.GA3370683-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607162801.GA3370683-robh@kernel.org>
X-ClientProxiedBy: AM6P194CA0031.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::44) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4515e5b-0dcb-4af9-5f1c-08da49476b11
X-MS-TrafficTypeDiagnostic: DU0PR04MB9275:EE_
X-Microsoft-Antispam-PRVS: <DU0PR04MB9275A9A7A086CE1AA4652985F6A49@DU0PR04MB9275.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6Ak0sMsguwA15atGDsFkzLjvmLMy5UUAzymzHTviCGsLBquQGiKJvyoMyGDIHtssoLs6UmJkYvBdTROMV8PoTcz5alj8Yhg0KpXUWCtzdkLyCHTi2xO/5m98mi9cJ5DyTKJqPUGd8Sgq4accWjoKh0YHscwn0LQQ+FLPR3y+tfvdNNSMhIufWnkN6+yEJQWMFgog22ovABpVtDPJmbOwGOuj8dn5W/mISU+JzvndNDKfcLf3FOcfXYB5G1UvjYusklfltqHqMFDiQpH9QUoi5Go89g32/ZETF0URAP4B21vTW6J+0A6Ot29TB4jciHMSGyFJRZfn27HRnV80KzVf+mR9h+1oSkUb0cNMCtNEwkahIjhsfpn5JvahJcY7Xsd+ienKfoO2MCmpK+d6hDEEMLow3wd1kfyJmP8tuLnJie6L7WGdMOdbzutVXfejo5BQnIqVqaRU9pjI8sqcsq4Mz1iHPrWFxOsTD3LqJPrXdekuY54XSczKOwW6s4h+LyEnbPaz6cEd9/93sn3DzQLU1CLBfufradZ5CbGHbRpirAZgGf6hKSvq8nQWqA5mVSIOgl32TT7epwNNFy5f88sdIIGF+zT7XvUcvVXjQpTs3Kk/9G81X8HG2pLK4ePymFv5DJyjhQB4UjCss55V9p7WMPYy+AXYY0Gjie9gM4Eppk9wEQQ7isk5vaR1zgWOaDDm5nkLdieCnrx466fI6IDYXBFbcARzhCR7UL33h66ZlotcEw/DoaqUBor/mq6TwXOcti5xgLMIiif1lVZgROIXQV0JGvlY6vWiuQVVNA/Du0LusoBGS92Xeet//JN1tpD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6486002)(53546011)(4326008)(8676002)(52116002)(316002)(38100700002)(38350700002)(44832011)(86362001)(54906003)(6916009)(9686003)(6512007)(66476007)(83380400001)(508600001)(66946007)(66556008)(186003)(966005)(6506007)(6666004)(8936002)(26005)(33716001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IPIZA0UZcyjGbiyd1KjmGyEPcocQqWD/A9SM/+eP5HAJYwqFRYp++8R64tY7?=
 =?us-ascii?Q?ETabO4apD4XTOyvx3RaAqZ4gL7UOJVh4TUaiVlBoosrzNvulfdZ7/AxjpXzC?=
 =?us-ascii?Q?L01kNw3pncyrEb1SwkgKNGgjnAnmXuVPH9sfUYrM8xex4OUoindJxmz1lBFZ?=
 =?us-ascii?Q?8aj3QU2qj2mmaQTd79CXJPF+zEmio2nonqu+52S5z1BXyPNzlYLF9065B43Y?=
 =?us-ascii?Q?pZpTJ63+M7fbOhMBFd5uRrLACchyO5K8meDmEGGUCkt5nyi7ujwOrii8Lpn5?=
 =?us-ascii?Q?kU9WLgr5LuNYcxfdweVJMYRdLWD/ACxsVOFZUqQU+BSY7aqz6yJGIwIreZVC?=
 =?us-ascii?Q?CE+f91dl58WC1s46We4qKp6t4DbQNhp6OcacYJMxthspiY1Ac8xOcqUht4GB?=
 =?us-ascii?Q?1RS4PMJYqsGzkh4txnaDnJaw24J5o4Sfh/VtHpxJJZ/UZOk4LffQ608aDENk?=
 =?us-ascii?Q?BpJP5CAbEmPmc0V3ZvrQjm2zQrNrY2fHeZxzCr15nsp+p4lnorj6pNIDNUsA?=
 =?us-ascii?Q?BU9grW367oaZhjxgRTijX/fQesYToQLNB4A5FC7umIUYDx4xbHXoHch+NDoo?=
 =?us-ascii?Q?XbeLB6nTFnPW3S8K3HzdnSn5ht5H8bcTBna44jVw68TpV++athb3J/WVOEGj?=
 =?us-ascii?Q?8TLuGVIx0XYMJ88U46nWg+T16XoG87YKQQNj4tojncMjLluSQKx0zZm83rVn?=
 =?us-ascii?Q?71Si8phq3e+0OUusLLdX6GIdVpJHpXUB5cVQJwdoF/VO+O3SmYa8JbMooA/l?=
 =?us-ascii?Q?Fa1e9JV2RddP2tnG3/9ntCVK2IZmyneQdGo4t0isFinIf48pKZpT4PWAMFVo?=
 =?us-ascii?Q?/vsfdn2rT2zlntlXjGo9BFXkG7ElM6UcV6mMsHt4A9Nx7fx2FA4GoH2DCPew?=
 =?us-ascii?Q?qjVoEjwoOnzRVWea1N4LGatCSHvnnFiBznR+TTAOsXIIS937wMIZ8xyaRPAY?=
 =?us-ascii?Q?aH4JX6OC2rtJRThK8mwgq4ywMCjBnatxHR9P6adj+Qi8nOSBNpPudrAkUZ8C?=
 =?us-ascii?Q?eHZsMeGc5aNbhhBEyVA5WmjxK6gX/n2OJkYUCAv+jquMtLx/3zyPzd3IFMp6?=
 =?us-ascii?Q?siGc5Q2OzfYTY0fQD57zIczjRly2FreEboQALQZhkwk52tgZI3iRiJoLpSd6?=
 =?us-ascii?Q?9mfSse9B36/oRJ7N73LVw267AErAidu+ZS7wud8Jy8IRn4kZr+4+xcvZi9FE?=
 =?us-ascii?Q?1zZT9d6F3OkizKsEWtoPUkSjlnkpNimGAP2rSDCVf2oCVnij9kqfNFrlcGre?=
 =?us-ascii?Q?srZDOlgl7oF/wtQ10lAUGCpDH+vSgdCfBJIgfeh664/RaTtaRPDLUT5/KMmZ?=
 =?us-ascii?Q?n6BujzVltdWmGQa6nFo8S1ADwmhDoGeQEI9xZLLbfaq3IJVrzW7iqAdoRR0r?=
 =?us-ascii?Q?RZH6Q4U7oXjkCT+549RMN07OIYG1FLg1IV+smk0+7r5iOnRngYrz2gR+5/7L?=
 =?us-ascii?Q?NFIBpFsdLnkHKzzuTFYG4OgeehM0S9TIxqB5saSl1ousp0ArTu9Dk0ozEOwj?=
 =?us-ascii?Q?rPiLyAHUgWBmqBLkgyeR0WxsVWL2SB488vtz7BkH1r1ZxhDmg2rgZAXy5dLE?=
 =?us-ascii?Q?FQDlqxKg2ak3N5MLShu2XXChFi3JJgatQ83wiNgYSdNxMseoEaDE2CSAKDlQ?=
 =?us-ascii?Q?LeHyX6w5UuKCY2C8fsNdfGI73UFrnpSyA7HMwgCgnA3ygtgtQS8Lzf2G6UIU?=
 =?us-ascii?Q?WixKXdilJftTo3qWxZOUgsqO+L9AsIyLFzrmh1gX1XCGpmWVKXV56xyeN3MV?=
 =?us-ascii?Q?W3xmYyV4oQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4515e5b-0dcb-4af9-5f1c-08da49476b11
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 12:07:11.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xo4UYlrkQ+g3ODdNzo6O8Uv+FlY2ISkFAE37nxQyMNNIvsjZf3tGzbj8jgFd/ebIeWp1k5C4vNOcSk/+SUHmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9275
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-07 10:28:01, Rob Herring wrote:
> On Tue, Jun 07, 2022 at 01:59:42PM +0300, Abel Vesa wrote:
> > This patch actually addds the fsl,scu.yaml which is only for the
> > main SCU node. The child nodes schemas will be split in different
> > yaml files. The old txt file will be removed only after all the
> > child nodes have been properly switch to yaml.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  .../bindings/arm/freescale/fsl,scu.yaml       | 185 ++++++++++++++++++
> >  1 file changed, 185 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml
>
> Looks like an MFD, move to bindings/mfd/. Likewise for all the child
> nodes, move them to appropriate provider directories.
>

Actually, I think the fsl,scu.yaml makes more sense to be moved to
bindings/firmware.

As for the rest, I'll move them in their appropriate provider directories.

> >
> > diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml
> > new file mode 100644
> > index 000000000000..56728cfaa2e4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml
> > @@ -0,0 +1,185 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/freescale/fsl,scu.yaml
> > +$schema: http://devicetree.org/meta-schemas/core.yaml
> > +
> > +title: NXP i.MX System Controller Firmware (SCFW)
> > +
> > +maintainers:
> > +  - Shawn Guo <shawnguo@kernel.org>
> > +
> > +
> > +description: System Controller Device Node
> > +  The System Controller Firmware (SCFW) is a low-level system function
> > +  which runs on a dedicated Cortex-M core to provide power, clock, and
> > +  resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> > +  (QM, QP), and i.MX8QX (QXP, DX).
> > +  The AP communicates with the SC using a multi-ported MU module found
> > +  in the LSIO subsystem. The current definition of this MU module provides
> > +  5 remote AP connections to the SC to support up to 5 execution environments
> > +  (TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
> > +  with the LSIO DSC IP bus. The SC firmware will communicate with this MU
> > +  using the MSI bus.
> > +  Each mu which supports general interrupt should have an alias correctly
> > +  numbered in "aliases" node.
> > +  e.g.
> > +  aliases {
> > +         mu1 = &lsio_mu1;
> > +  };
> > +
> > +properties:
> > +  $nodename:
> > +    const: 'scu'
>
> blank line between each DT property. Here and throughout the series.
>
> > +  compatible:
> > +    const: fsl,imx-scu
> > +  clock-controller:
> > +    description: |
> > +      Clock controller node that provides the clocks controlled by the SCU
> > +  imx8qx-pd:
>
> power-controller:
>
> > +    description: |
> > +      Power domains controller node that provides the power domains
> > +      controlled by the SCU
> > +  imx8qx-ocotp:
> > +    description: |
> > +      OCOTP controller node provided by the SCU
> > +  iomuxc:
>
> pinctrl:
>
> > +    description: |
> > +      IOMUX controller provided by the SCU
> > +  pinctrl:
> > +    description: |
> > +      Pin controller provided by the SCU
> > +  scu-key:
>
> keys:
>
> > +    description: |
> > +      Keys provided by the SCU
> > +  thermal-sensor:
> > +    description: |
> > +      Thermal sensor provided by the SCU
> > +  rtc:
> > +    description: |
> > +      RTC controller provided by the SCU
> > +  watchdog:
> > +    description: |
> > +      Watchdog controller provided by the SCU
> > +  mbox-names:
>
> Sort properties before child nodes.
>
> > +    description:
> > +      include "gip3" if want to support general MU interrupt.
> > +    minItems: 1
> > +    maxItems: 10
> > +  mboxes:
> > +    description: |
> > +      List of phandle of 4 MU channels for tx, 4 MU channels for
> > +      rx, and 1 optional MU channel for general interrupt.
> > +      All MU channels must be in the same MU instance.
> > +      Cross instances are not allowed. The MU instance can only
> > +      be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
> > +      to make sure use the one which is not conflict with other
> > +      execution environments. e.g. ATF.
> > +      Note:
> > +      Channel 0 must be "tx0" or "rx0".
> > +      Channel 1 must be "tx1" or "rx1".
> > +      Channel 2 must be "tx2" or "rx2".
> > +      Channel 3 must be "tx3" or "rx3".
> > +      General interrupt rx channel must be "gip3".
> > +      e.g.
> > +      mboxes = <&lsio_mu1 0 0
> > +              &lsio_mu1 0 1
> > +              &lsio_mu1 0 2
> > +              &lsio_mu1 0 3
> > +              &lsio_mu1 1 0
> > +              &lsio_mu1 1 1
> > +              &lsio_mu1 1 2
> > +              &lsio_mu1 1 3
> > +              &lsio_mu1 3 3>;
> > +      See Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> > +      for detailed mailbox binding.
>
> The specific mailbox provider is technically outside the scope of this
> binding.
>
> > +    minItems: 1
> > +    maxItems: 10
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - mbox-names
> > +  - mboxes
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/firmware/imx/rsrc.h>
> > +    #include <dt-bindings/input/input.h>
> > +    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> > +
> > +    aliases {
> > +           mu1 = &lsio_mu1;
>
> Not a standard alias. Drop.
>
> > +    };
> > +    lsio_mu1: mailbox@5d1c0000 {
> > +           reg = <0x5d1c0000 0x10000>;
> > +           #mbox-cells = <2>;
> > +    };
>
> No need to show providers in examples.
>
> > +    firmware {
> > +           scu {
> > +                   compatible = "fsl,imx-scu";
> > +                   mbox-names = "tx0", "tx1", "tx2", "tx3",
> > +                                "rx0", "rx1", "rx2", "rx3",
> > +                                "gip3";
> > +                   mboxes = <&lsio_mu1 0 0
> > +                            &lsio_mu1 0 1
> > +                            &lsio_mu1 0 2
> > +                            &lsio_mu1 0 3
> > +                            &lsio_mu1 1 0
> > +                            &lsio_mu1 1 1
> > +                            &lsio_mu1 1 2
> > +                            &lsio_mu1 1 3
> > +                            &lsio_mu1 3 3>;
> > +                   clock-controller {
> > +                            compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
> > +                            #clock-cells = <2>;
> > +                   };
> > +                   iomuxc {
> > +                            compatible = "fsl,imx8qxp-iomuxc";
> > +
> > +                            pinctrl_lpuart0: lpuart0grp {
> > +                                   fsl,pins = <
> > +                                           IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
> > +                                           IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
> > +                                   >;
> > +                            };
> > +                   };
> > +                   imx8qx-ocotp {
> > +                            compatible = "fsl,imx8qxp-scu-ocotp";
> > +                            #address-cells = <1>;
> > +                            #size-cells = <1>;
> > +
> > +                            fec_mac0: mac@2c4 {
> > +                                   reg = <0x2c4 6>;
> > +                            };
> > +                   };
> > +                   pd: imx8qx-pd {
> > +                            compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
> > +                            #power-domain-cells = <1>;
> > +                   };
> > +                   rtc {
> > +                            compatible = "fsl,imx8qxp-sc-rtc";
> > +                   };
> > +                   scu-key {
> > +                            compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
> > +                            linux,keycodes = <KEY_POWER>;
> > +                   };
> > +                   watchdog {
> > +                            compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
> > +                            timeout-sec = <60>;
> > +                   };
> > +                   thermal-sensor {
> > +                            compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> > +                            #thermal-sensor-cells = <1>;
> > +                   };
> > +            };
> > +    };
>
> > +    serial@5a060000 {
> > +            reg = <0x5a060000 0x1000>;
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&pinctrl_lpuart0>;
> > +            clocks = <&uart0_clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
> > +            clock-names = "ipg";
> > +            power-domains = <&pd IMX_SC_R_UART_0>;
> > +    };
>
> Drop this too.
>
> > --
> > 2.34.3
> >
> >
