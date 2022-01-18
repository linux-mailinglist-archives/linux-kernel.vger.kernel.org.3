Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD724923A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiARKRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:17:06 -0500
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:40068
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237058AbiARKQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:16:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h59XOVekTWHzLbo+SuNe/w0BPw5LDz05n9eJ1GZF55Al5sqwQp+5JvEJ3JVvjIfX1hEO9g4yE5nRm3k5Q5HPDCGx7VyQpbiR4cwjfdJRk5WxyCfR/ZUTX17kFltQfKztHBw4Mu/Dc80QnXqdgVCc7bLaAdg1AAZRHUOKbvmRWBQiI69UJwDItDdcHWDkd3v41oV0VD3w0miOD5jy/0kIGvUQV+ELVghUz83k9cH1YSeyjjEnbV5MlHHWuCBDoDpy5WBzwHKe5gYPK6Y5FbX4ch6kaEWeo1gBwFYOknVelg/33GbD5jIKZB5J6mmI35e2BTAqbzEvH4t2rXQsbeq2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNeHqXEDeHPJ6g9UXl2B7gHSWJZ406vuOYi/3Bf0Qhs=;
 b=BFJmbeIhNiFyA53nkDJA6oF+7bRAIGytJpFquCZefQczUzByYpy2ion2EhSUB1Q/nD2aq6/x3Qma1xE+CQ3rzzeYp8ZsHYC5VDnHGXP3jkIrt3O/WbblQbBFYb9OddCSz1Tm2uDEkt+ZWYmZNrRMSkHX6Lnox5RWeVCb9Fd/k1wsegpFgW675csX2PlxuksJv6thwt03bMv/lVvj/AqHufBVcH1rNQH3pbhm/U1dvcJ7oy6qgmoR3+5ZHZeMfzX8zvNvBy/Z9fi6ncLTz4rwp6wXpJjgWRm/N0DwWiwTQ9kQa9KNHHkhNxblHTAHtde3svqnKOMtFY0lETfDnVN1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNeHqXEDeHPJ6g9UXl2B7gHSWJZ406vuOYi/3Bf0Qhs=;
 b=lquD7uv6fKGLRSSK4cpszhD41ibXHzY3fkjCY0NdFQ+6Ge8QutTa6F6DoN30vXCItqGDMXRiBYoSjj9SCqu1Ip9Os3Y/lTyXkX0AQ+v30stQp4Tehtkzj6BRZiBTeykty/DNKT/mMMW7gHVQ92fUeliETHWb1lvFfTF+i3ztg7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 10:16:54 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 10:16:54 +0000
Date:   Tue, 18 Jan 2022 12:16:52 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, ulf.hansson@linaro.org,
        aisheng.dong@nxp.com, stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, adrian.hunter@intel.com,
        jirislaby@kernel.org, giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v8 4/7] dt-bindings: clock: imx: Add documentation for
 i.MXRT1050 clock
Message-ID: <YeaTlE3RZfUIaLih@abelvesa>
References: <20220111212606.2072669-1-Mr.Bossman075@gmail.com>
 <20220111215415.2075257-1-Mr.Bossman075@gmail.com>
 <20220111215415.2075257-5-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111215415.2075257-5-Mr.Bossman075@gmail.com>
X-ClientProxiedBy: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6ee3221-4c38-46cf-c6c0-08d9da6ba6f4
X-MS-TrafficTypeDiagnostic: AS8PR04MB8657:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8657FEE98066CF2AEBDADC78F6589@AS8PR04MB8657.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2l+GuuAmTq6yvS/lRX7AE5RFhprLYhmZaJGS2P7eYeGKfGT4OfEDyzMCBwpat5RPcRTKTmJCvfnIEoKknVEIhjQfbONzuwj62/42dJffYXj0Z4ZEPwlymNb+Zzr0JvRM/CuPJsBbXwEc/M7cQItK4CNbq7WugCW+9bWuWgCDiUQee6jX/oVHEDTW3IAgrNMOQWDW/xKyMqIKKFkwEHRpdfVWtLrUvjPtJAZ+81UQkYwXdyObAOiQZVYX87efHhrDd7dFEYp1Itm0Z8UNJkmf9SUbInCjs0nE5yye9nQf5ZY3Au69LsMJJqlwkkiwtFO2tIimpnhBfAUGsDO+EorU2IHfgNThVX2Kp8Py0y2ZyQHg29X/Gqae7TZA9t5j/8Gw+UngZ0NCa95lGMPD6MFdugqg+YSQ5w1qKmtZ/XaTSd3YvFXBaigCtDAGSgJuUbDe6trVGGjGe2nXBl2gmlVAXiKXjE0LDgUDYk17P1gPNw4PClZO7diha+zPX/aCvbl3uD7IgtIjGoU+ZQzJNROBQqlEJj7khWy3LCk3PZ+XC6uEKROV9sz2sa8sX+VPvknJvJHLoH8kTtnWPOiH26cErRIXl+eZTbP9LxjQCJ7N0ob23tlhXjA1Qn5+ztAqj64fFyUEAvavHjZuj0hLDiEuz5yrvMXvlUJwWH7ghE7ZyypRLb6VxFq1XR697R26D50gEguzbtDZ4ftkOSDZKEoFkMem/iCOOLa+IFx9IiWjzBWmiIMY8v60O5Efi2tXita+CzcvIbT3AHFAZIHM+vMBl6t2PCYNZKC5iWy66f/CzMZHuwvwuocjFnnv+vrtHH3FtLtaFfGgrjIEllQUzXILRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(83380400001)(316002)(4326008)(6512007)(9686003)(38350700002)(2906002)(186003)(86362001)(33716001)(5660300002)(38100700002)(7416002)(66556008)(8936002)(44832011)(26005)(66476007)(8676002)(66946007)(53546011)(508600001)(966005)(52116002)(6486002)(6916009)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?44E0aExBN7HFq7FhiZbqVWmGdDOse22NPARtJ+nc8mxzZf0oakti9CKDnjY1?=
 =?us-ascii?Q?T84pMa+cIUKi74/K8AOu+dXZ41J2fSdNGhiOdxuXbms8xIIJtOQrqiEDBpjp?=
 =?us-ascii?Q?AuaxYUx7OZU/aApGr/Bpe1560C/fn9bAIg3Jj6cR39+G5w0aqpP4wjxG3yvU?=
 =?us-ascii?Q?E9hxz3Rsns0B6DvsARAMiPLmybFfcbdjmhStpFTXuoEddyS4H5NIakShAxRj?=
 =?us-ascii?Q?8+vEofgBLGMPpbutsPkOmu2JWQ78SlV5qn3AeBnphQEELDDQtYjwi9ZIgU2f?=
 =?us-ascii?Q?vUIs1c0FlZ0ZXOlWrgc67N8BfQcmHXr2wjH5FD9lAw5LMPibb/y/xuf/UjZQ?=
 =?us-ascii?Q?/VI0pZjQ+5dG2M8uZcEh2rXMCfOjVaAwO5thFCNyeVtSXrqMjKiusidzDqFv?=
 =?us-ascii?Q?7UiARg2FGJZeRnnJd25pjerfPR59K6pTH3wLAhq/TIg+uzUAuSAUkFVQimZN?=
 =?us-ascii?Q?wyWNFBVMRDui0Fvyv1lw4o3BcqglxICueHJ0cndAeyS+0Czc/pOJBSDvWXcf?=
 =?us-ascii?Q?IoH9/M+DOIwp6w4F3KB33jW+3s0WTqaZu6GL5fA5DxQ4sMTiGQ6ypGLrDHn3?=
 =?us-ascii?Q?hF0q4xMvWaZxhiehn6FpGdECWObOQlRK0MfQ4KFSGxbevqau6PaOlfIGnYRe?=
 =?us-ascii?Q?z9loqnk2Lu6Hku0jikq4Xpu2Tc9cidZx3VC4SVlkluupamzQlJKNX+GsH+s5?=
 =?us-ascii?Q?TMiFq559g6qdI4zpIEWevwmAPqMRut5OTNaD5Hf33BPRLRHjp+Ka3XSx905Z?=
 =?us-ascii?Q?LPw59PS/xBMgHC85jB1GbvQQagW53y4cYPlyVSpeZRSJNnClUbUfNPyU7tL1?=
 =?us-ascii?Q?YdGp3syhaukGyllIq+TjuaFxGCWwmzr5kILoWZOMygiO9QFXbEsuU/5mXWua?=
 =?us-ascii?Q?1XxzTBHEjjiZX/LlijPOcp0ObQWSDi11zzS+fQOJTxAuttG3BlZYIPninlR+?=
 =?us-ascii?Q?6LAOorP2YS6IpwWZ6+rY2Ny+h3OXFH9dzc05wH+4w2J8sqCSE7BSOjJUM3Zf?=
 =?us-ascii?Q?T2OidRlhIAHCOllBLbCwO1nMxyrgYLq84fiAGWDNaO8ox5O9sAJazKfCWkaw?=
 =?us-ascii?Q?AEhEFRgFkuX5UsGdk4z5m4zMVmF5G3MugoNcmY3/od0LLJkxHup4ANdc1DEo?=
 =?us-ascii?Q?O56GGNLYZ6exBRWgvTtcJuBeaoUhrSL43gH5hf27liXbuY2G08fhwDJnFzUb?=
 =?us-ascii?Q?Mtx6VN0hqj1/DWcRxcHG8jh03jLKTDU7JZ42rdqfooY3aTcYi57hDX3szXHj?=
 =?us-ascii?Q?9LupQfDujhiwskkwh73PDpq+T1L6qejMFP/lBaMxKozzFpc0UFs9S+7v90Dy?=
 =?us-ascii?Q?wCGlHozAUSW3Z58wXQDrRihHta8wN2MwGhxgHqO5KjQG7WJqQ/NHtYofaTSZ?=
 =?us-ascii?Q?+yk7LIQp2iypBkw8Rvoyc5QWbnQHnOP3TdArT1MxgoSXpbvRE0I5XR8N/9SL?=
 =?us-ascii?Q?O0t67iiL+Ee0+HNGXMavYIqcVVBNRKzqFG70zeMccPg2CtpbLZ425gutR0vT?=
 =?us-ascii?Q?C4sKOJzrwE81Rxj7SPi45IdX8RXa1rswBxd6NIlk+Vj1q5Z3KdMwyMzA3Ny5?=
 =?us-ascii?Q?nz/sffQQ7m2yniM9iesKZ3T+YG0YmNEN1+bTb5YrTrYhYHe2NChTXLOGwQS0?=
 =?us-ascii?Q?sgvUs/eZuGjVv0jOTh+Eqxk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ee3221-4c38-46cf-c6c0-08d9da6ba6f4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 10:16:54.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbTPhTiVbo8SsoK0d880dXpOuRc663Hnoaq6Kf8uzYDMcXEmVTBzKYGHq3lLIfPAseXWWW5kycsIfSnIIBGpXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-11 16:54:12, Jesse Taube wrote:
> From: Jesse Taube <mr.bossman075@gmail.com>
> 
> Add DT binding documentation for i.MXRT1050 clock driver.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Applied, thanks.

> ---
> V1->V2:
> * Replace macros with values
> V2->V3:
> * Remove anatop
> * Use lpuart not gpt
> * include imxrt1050-clock.h
> * 2 space tabs to 4
> * Remove oneOf enum
> * Change maxItems to 2
> V3->V4:
> * Nothing done
> V4->V5:
> * Remove extra newline
> * Rename ccm to clock-controller
> * Change minItems to const
> * Change minItems to description
> * Rename file to add 1050
> * Change commit description to just 1050
> V5->V6:
> * Add maxItems for clocks description
> V6->V7:
> * Nothing done
> V7->V8:
> * Nothing done
> ---
>  .../bindings/clock/imxrt1050-clock.yaml       | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml b/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
> new file mode 100644
> index 000000000000..35fd08c143f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/imxrt1050-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Clock bindings for Freescale i.MXRT
> +
> +maintainers:
> +  - Giulio Benetti <giulio.benetti@benettiengineering.com>
> +  - Jesse Taube <Mr.Bossman075@gmail.com>
> +
> +description: |
> +  The clock consumer should specify the desired clock by having the clock
> +  ID in its "clocks" phandle cell. See include/dt-bindings/clock/imxrt*-clock.h
> +  for the full list of i.MXRT clock IDs.
> +
> +properties:
> +  compatible:
> +    const: fsl,imxrt1050-ccm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  clocks:
> +    description: 24m osc
> +    maxItems: 1
> +
> +  clock-names:
> +    const: osc
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imxrt1050-clock.h>
> +
> +    clks: clock-controller@400fc000 {
> +        compatible = "fsl,imxrt1050-ccm";
> +        reg = <0x400fc000 0x4000>;
> +        interrupts = <95>, <96>;
> +        clocks = <&osc>;
> +        clock-names = "osc";
> +        #clock-cells = <1>;
> +    };
> +
> +    lpuart1: serial@40184000 {
> +        compatible = "fsl,imxrt1050-lpuart";
> +        reg = <0x40184000 0x4000>;
> +        interrupts = <20>;
> +        clocks = <&clks IMXRT1050_CLK_LPUART1>;
> +        clock-names = "ipg";
> +    };
> -- 
> 2.34.1
>
