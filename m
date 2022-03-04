Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176A54CD18D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbiCDJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbiCDJpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:45:35 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20070.outbound.protection.outlook.com [40.107.2.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C9C15A220;
        Fri,  4 Mar 2022 01:44:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu64ODmPhZhMQPb3/50i6ZU4ftyq680RtohJYsFWB8tEGzJGdS89Jaqk3tJMJvECFqTbA4MfLWh4cl2apqdm/BtidqHZN41BsfvSxIHkhdZV9oYOW3PjpJnv6eahl+dGiKuNM2Yv+uIQXvyKryvsrUVHwZFmKzomQUJ3IlJm07VxYJ6v4Uw3eOaD0jGWANqYjRFE8LcSoXPRBmVURnRhyrVMPzjZohxbWCYnVVAejbreOlvkdyTIEGrrQxv+S2oQ2prgJKMyKnDwB37wrHjD+0moUQiFRIpaPdOhQ+wu/wXB8H/rSnJ+ACoABl6KYjLv/WcT1bar0dmLrstghsSEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzGNw6TkifY7YdOw5Fo4TIeCRoZYKlq0tY5/Avjy9v4=;
 b=NZavNuW79W7WOGND+3DW5XK4PXo/xWvEiGGIVB3aG245UJprnYLmyHm6mdgiJclZAP3iMSQ0tbcjBM80jdMIiKA/TPYJgNPurgEnd+tHhwTkD4EFUQBTdX2rZPzG/PVQ/2dsYJ0Cs8gRiH0PJ+FyLq/txh0A8/xMaASmvt8P12m2j5wQJAnB2bbwtfb1Tvc5mjxq/+cHQjvX9uoLHD1cAjWAjSMrOXO/fuDM8JjlL/cz61U/WufVclWTqxKfE8ECDfBgNxnKakfWsN1BRmTkZGLnyBFHU9xtjGM07RzewrRG5v/OWNEoqYubtDo6agA6aVaICCZMSF/82XFyhFAocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzGNw6TkifY7YdOw5Fo4TIeCRoZYKlq0tY5/Avjy9v4=;
 b=EUmk1G5snwv1OaELqSaVwJG0X0+3iK0c1t/dBrZxvqb8POtUiGa6YexJuZql5oYP5nNRbk7UVYfEMZDp9PDdRo8jhc4LzDIi2a2lzNfUTcrW3h43QURB9GhTErh61tLL4VQRYXLBLhRYgXhCVgjDz6DiLqQv/Tz7aoN6DBGI3Gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM0PR04MB5585.eurprd04.prod.outlook.com (2603:10a6:208:133::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 09:44:44 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 09:44:44 +0000
Date:   Fri, 4 Mar 2022 11:44:42 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: clk: imx: add git tree and dt-bindings files
Message-ID: <YiHfinMkAQIAQBci@abelvesa>
References: <20220216132214.258865-1-abel.vesa@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216132214.258865-1-abel.vesa@nxp.com>
X-ClientProxiedBy: VI1PR0102CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::35) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6017a88b-ad4f-45a8-cad8-08d9fdc39cca
X-MS-TrafficTypeDiagnostic: AM0PR04MB5585:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB55852B7405A5476088C05B42F6059@AM0PR04MB5585.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voOjt3zB2zPUYbxlShKZLgMmZvG4KqEZhJph7+jubW5IiDZ3NwhAeHhb0d2jnviRbslU2nRuTwiDTHAiZ4Riw7xfLJpoRiYrlnrfluKbbEvS2LlaMVsdRJlFXVSEWuqMdn1TJ6N6Qq86xc5HkBBGHmqQV4MCo3z/63EOCmpaQY4b5NFOXu3kLQweLcNJvJDnhNaHjOrHs4k7yYW1ga2ytNHRSi4++rQGE0NqvjRYHLrs5RDmmPPj21eO0k1RRydO0UqlxcC/aZBCUfECHnhDnxYPsJydZrbTWK6101KDW6e3ZFjlXGC0jlR7KOudhDeEf9EApDHQpWiL0aJ1jtee4MozKKCg//jsy0yXl7wxjCC0zVZcO/OlHDTrhwTr7T0dK3DZoRjmYMNVVUJTvHibgYsJ9nEbChT9+D5cJ+eZRSQNTgmxMSzfuXSpu1RKY85Uf5DkvwBfieJOAWqvlY63dVNuVfGf4xYYTSlsYRFzZHZ6i3/NTDyfHq5Q9JbqyRspOhfdv5+qaUbvSUrijB283G7VktI5rcxI72OJpRvo2kBMmCAJ28lVylJo726ly2XLF+0PxDWfyNUogl1y3rtr+aBcjH8Ao1UJamNRDhUD9crAijMdMCUWzdiDSTYVXg8yztgiDJYDsuPEg8i9zbHbq0k3wfz5XJ+3V+e/WYviyH3o9gfMW3D0KZEisuH52eQGL7+h8qdfehA70d9P+apkjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6916009)(54906003)(83380400001)(38100700002)(508600001)(8936002)(8676002)(66946007)(6486002)(66476007)(66556008)(316002)(4744005)(44832011)(4326008)(5660300002)(2906002)(6512007)(186003)(53546011)(6506007)(52116002)(26005)(38350700002)(86362001)(9686003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOXjBrXoueAw2OCdePD0/bryGNVjJDhtqXPHLIfE8iMDKop5uop9dmOyG9Mt?=
 =?us-ascii?Q?WhDX0QUi9Q8M7mMRJn/CEuWgjOBd5ZfpLYKPyq9UluY9B9Z1sihMrkcHzbOL?=
 =?us-ascii?Q?Dtar02jPEhj/SKhIccvjazjadXIK4hdo7ll+7SfXHGTtJ4jr4XtZ5IjrFtSu?=
 =?us-ascii?Q?MBuUCDCgJMReN+9wZHL8ZNW19jcF5cCTjjq1OvJ8pygZXTfIrV8QnG7pGQrJ?=
 =?us-ascii?Q?bqiQ2Ie6crZAwHusOcdpmHF5QuRkPn+kAm5scK3cDCxOge7yrg5bvTT1XxPw?=
 =?us-ascii?Q?cSfgmEGiII3g423/J2PRhomu2hhMva6HYKb4mlFVn6eomSG+y+yNSd1TvmhI?=
 =?us-ascii?Q?EH+jad7BNSBveQh+k9on4g4qiPL7UPkUHL5uuju9qUYSuBPlKsw+u0rhIRwK?=
 =?us-ascii?Q?bGfbO8F0DiuqfV/3mF+eadHPB+PvAxhBtNmODBEfDAFhth9sxVw5W0zFvvH3?=
 =?us-ascii?Q?zwnXuNNbTuJQ3uzG/A6k4abuILseclzkicockaMUzzJJkaer6V2ICPlvLlWZ?=
 =?us-ascii?Q?UdXo7ADdbYE92P8XHg1MTZnxXf2/1TpUzPEtKzp5GDDFELCReLkqAoTEymUS?=
 =?us-ascii?Q?c0g3mAH7p7Dfs0Zkc+xHXc9XKyiBQXUnwsApSWFX11IOMJ6Nph8eNpHk9P1p?=
 =?us-ascii?Q?tTvo11q+K5SmTFSU7OOGMVo4Te+XSYKuIa0wankAGzlDfLO1nW+jitC0fOKv?=
 =?us-ascii?Q?K28lz0F87N2tVREb9SFRqeue7CD3gHAy3vojBTrgy4i/l1CtRFrIErMDH1zZ?=
 =?us-ascii?Q?LU7QM+mthRxoavs19JyLuddCJdx6dUroaPdIOXXEWPoEGDg0wDqIlGNb/Fq9?=
 =?us-ascii?Q?WbCK3pE5wj7WI9TzCL/VP/3PHLW/e2E4SCgpIFui0WpPbmXrQsY0s1lzU1Cu?=
 =?us-ascii?Q?OvQ4fVHoHmYYhgxiEFF+Il1o6IEG9lXBU/aYv2F/PpF44kDpfqlX9MRwCftI?=
 =?us-ascii?Q?YiuckaY9M2vy9A7VeJgmtH1qbun6HzGGEGBtt6yLUhQUZIWgKJyFIZJL97Vy?=
 =?us-ascii?Q?/pXSUE0X51/eLrOdrtKGFkltoCZSjfT3/2NjoYpGNFjLSpED+exNWkvLh79D?=
 =?us-ascii?Q?17LHajWbm+lcIKbNB7FWVhK66zVv5uypia0wVRftYJN2BWLwNHIOGsp096Bg?=
 =?us-ascii?Q?wbcDBGxTHclXdT0a9R0jsydRa6ErpsZFY/RQUOXHg3akTYu7HIueuZQAgesH?=
 =?us-ascii?Q?0Q0vQyNg+6gEWihjpgppqGwQRqShwSNvLQ3dTRKRhVzt0FjQDFvubmAnz30w?=
 =?us-ascii?Q?s0sieVtE7xhbIco5BbOMgdBi4Dky7yQvsAvrUuMQ8Fj5/YRT8UW4I1brYNok?=
 =?us-ascii?Q?r1PHF549ppljj14BK5QJ3+XPxnN7n8gcWx3xeKhvMoKJbRZ2bV5/QtEW9Yv6?=
 =?us-ascii?Q?B/GBi4KxPN2Rq517QtM3W/RGuORrXIT98fxO53HsiR2CTLM+mwNXXN7XzvaZ?=
 =?us-ascii?Q?PZnVF6IkMd5M3kKOBf9/63Jw8Lfcx1ZH1Jp+6xtJX+qA7QKUYUN3tOJxDrb3?=
 =?us-ascii?Q?5settjkFCWpDkfUNaTPKTSU/bu+hNEx2/lIbRqueamBqyc8SJ48EuTrk6Lh2?=
 =?us-ascii?Q?EbxME6j6kGjJHfuj48b1x/PvKlPbfg973a2tonCRfW3iYgrDA+DlXhIAzAKE?=
 =?us-ascii?Q?eQMSliaxDR3IvBGIo2LbaGA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6017a88b-ad4f-45a8-cad8-08d9fdc39cca
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 09:44:44.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UYGIST+owPisrduOzN8r05bhQ2b2feboZvVJjMQXNXu0V6+niTQgIxCQ9gvuEsSe4QgZbApJvbZhpJYuzw4LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-16 15:22:14, Abel Vesa wrote:
> The i.MX clocks dt-bindings are going through the same tree as
> the drivers, so add them to the same entry. Also add the git
> tree and branch used.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Stephen, will you be picking up this yourself ?

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66aa3a589f6a..277d5626702a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13954,7 +13954,10 @@ M:	Abel Vesa <abel.vesa@nxp.com>
>  L:	linux-clk@vger.kernel.org
>  L:	linux-imx@nxp.com
>  S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
> +F:	Documentation/devicetree/bindings/clock/imx*
>  F:	drivers/clk/imx/
> +F:	include/dt-bindings/clock/imx*
>  
>  NXP i.MX 8MQ DCSS DRIVER
>  M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> -- 
> 2.34.1
>
