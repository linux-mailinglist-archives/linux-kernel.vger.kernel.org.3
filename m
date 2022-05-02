Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DDA516D72
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384269AbiEBJj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384243AbiEBJjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:39:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5174F24BC4;
        Mon,  2 May 2022 02:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSOCIbVjJddPGAjfbJc6mc13byv9/qZm8m+nSF5z0E0NINPMzKG7OR+VeW22TD8QNzxGFMfIrC8D9dsPSUMa8AQbEOZ4L34evTDoQZbWVFCe1t2tNmZaaxu30eo6g/Da52hvKY6t7jvSQwyUN7qn4qWEMvULpLW0KgzOYhu2BM39uqk5eUP2D5LBrbI1l1CGo3X0VfByPH5iwnKfKowxzhmx67SEQ1WwWr5x9vxKiQz3SHjZ9Cn/fSeGFz7pRDwV+jO9VdTtTj9dWVCX3eW9U+WPKP4DxQl9tsV01vMIv/Wmk8URxIjRuIrT2p5UZ4PNBTQj8U9gupgfz6/xoHoE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0beyg+wiykb1y9q6tEXyp474d4DAhFID5OfiHQH2GPs=;
 b=DvtBkqmojwxZ6vUa+XQko17kGke1xd3igVbOa7avGx52kmF+4NRLX9NwuoQ0/kFZwTyKOnDUGWnIiAGPHu1qiH3WXdDswQzo5TBar+CmtupfJv8SPT5ngfGoIEdDV89vpK80lylqBQI1p5XganM6X6OdTJ6bYOkD8zIVkJEFtvl0FwjApdvWrwppLFj6vMR6ZVNsm42Bb0y0OeY8eyfhFjgXtqxQlbiKHCTtBBThcxUFT6k3y46j+6deTKsuHYzfZgN2gqx+wPd67kl8J0AeQehUl5iXrP0wDK0UTWM/RGkFepbpAE1JMdhkIPYPPfHWxx81nD5JjanXzvf7xheB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0beyg+wiykb1y9q6tEXyp474d4DAhFID5OfiHQH2GPs=;
 b=KOwFxAnwW1/8vECRSDgS++go4IpG76MA1hT98kTUUIga8JgBwIxSFk3hdq2eGTilh/OYysDsLX+RPRTuGuHLOPj4JmID3haOMzPHg3JzTlc1VNVmKEo+IT5p07lUerORaqexU8wYxA2UNPNxIWVuDLwyNO22DrYaoxFqKZrNhHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBBPR04MB6123.eurprd04.prod.outlook.com (2603:10a6:10:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 09:35:50 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::78d8:955a:7946:fd78]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::78d8:955a:7946:fd78%6]) with mapi id 15.20.5206.013; Mon, 2 May 2022
 09:35:50 +0000
Date:   Mon, 2 May 2022 12:35:48 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] clk: imx: scu: Use pm_runtime_resume_and_get
 to fix pm_runtime_get_sync() usage
Message-ID: <Ym+l9FiG5byrF9b3@abelvesa>
References: <20220425011117.25093-1-linmq006@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425011117.25093-1-linmq006@gmail.com>
X-ClientProxiedBy: VI1PR0202CA0031.eurprd02.prod.outlook.com
 (2603:10a6:803:14::44) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65d9b82b-46eb-4bd8-999f-08da2c1f24f4
X-MS-TrafficTypeDiagnostic: DBBPR04MB6123:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB6123BF4F413D5902BDF84000F6C19@DBBPR04MB6123.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnGq93n0Hh35FXMfKk4ss2M1UZlB/G5QvYnFGMmDQVtcO1c+3nuA8c1O4gkPCGQHz3GUOvFlEsM4E1h7H9HmasZs64Jl0HPbwoE8ZFKx/qH1niW3os9WWQiab2mDY2bXuEjdURFJECDKTx6O9Y0bC5BB01nQVB7RDZbCrTwBQayoljsnrOOHIfg5v7sk34LqzC1RhIObd3ikXOexQtoeo9N2NJIwMFUD0MAIK6jClabj5BE+JMjloutoqwGg3tIgRgp900v08zhXp6Qy4+1EB1I3FzG93zTj+RrR9XkbCpWsf9xVrL7EPtggr8Vj40FhRIjy26FHvfVh3dRYgB/kjMez6ZNPGpgnXWpSNiAk+UKAwtejwi6qE1ubq1v6VXplloY0bE9zTZXAxLB6A2nIwETcPH102bfnplNReVW9LzXNZeIrrvETwij6SPTYFXqszbm4O6e78Zd4klpdWT5u7zMaF3+PKN4eKA+yfPTT+jmDMgcz3mPnRr4KYssmJcGGAuxt6WBZ0w/cjzkzrLdG5JPem4DLE04YpWM7+BOERUzKLoUahl+9KCR/I/qUTwWfzIRhhsQ5PnE3Pz4g9eAcoF29hPrzCKWZU+YfHClaLGwx5OjEsFIExQFr7ufgN/N2J3lkEY4T7NIYHXeCZLd6eDM3ZdHL9y61Cy8tnWxh0/Yfro3pAQHc40rRcGbWBHwCsmSDWSIot66SJnXmeViGPiqHlrvFAZ9kGKVBsDkdJhp/xfS6AFZ8JCz+6iJz1xF+wA/d511V8fpBqDxdIid2lOEvaxt4PZyiVrSHth0F9tvM+UTSZwOW2FnQ9cd+54Ol
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(186003)(7416002)(52116002)(6916009)(5660300002)(54906003)(44832011)(8936002)(53546011)(6506007)(83380400001)(6512007)(9686003)(26005)(966005)(6486002)(2906002)(86362001)(316002)(508600001)(66946007)(8676002)(4326008)(66476007)(38100700002)(38350700002)(33716001)(66556008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lOuZk5vm55hKu4hZ09yQ8iOMqOGzSoguP5hNtEkFRGdqxRhohJ85z4HsysFa?=
 =?us-ascii?Q?zepEHPB57t8iz0KfxQdabdPfjFCdoZ37yqLgopHBSKXAJn5L8pfPCk+Q7AAm?=
 =?us-ascii?Q?jYjb6QIlzYZq1N0/+I+cDuYrnC2AHcYFeo/5iXhymiujWXaRPOVEhJ00Igri?=
 =?us-ascii?Q?zF8qPImUjpEIl1A/z1CES0SR3B3gXvdtIJJS8PevUxJ3WgJRAGr6LrForLRX?=
 =?us-ascii?Q?lQJuM1PwqZC/DeYANaJfdmca/Hqg6H8VSz/btI/z++AD7QHSSawCnIYDJkOo?=
 =?us-ascii?Q?az52g5uCuBOoYR/Na+W/s1Vloglj5/WENIckpBHVtK4bHFGM+GcbSBDjQGer?=
 =?us-ascii?Q?ejCswerQLPKbzprRZlPnsfr9Oj+34urmLmXMvB1dMjuKXNxXbsTp7nge12cq?=
 =?us-ascii?Q?+1IxK1k+gfJGQvpe4DN7syetOTd3TIz0Olyp6xI/Kz63q2wY5f6uDy8yJk3x?=
 =?us-ascii?Q?ky+3yl8C9zsAvjh93Pik9YLgSAnfSFBVv/kW75aeifdt59QmwXIhXytk9ryf?=
 =?us-ascii?Q?4odSRcRQ8ONAUTruGmT3k9kRUSYKpaL6xfOkD7RK64Ju/i8dOAiji3uF5lTE?=
 =?us-ascii?Q?A7VYOrjITg+fcXkTrMhd8t3H3yEamFsjCfQ+F3FslknpevngdnRuXazb78/y?=
 =?us-ascii?Q?d0xGjtvsm6TKdmXvdl7EgbPmGl7m3wAbAJChkJkcUTpeV493Ak/2jYtrze12?=
 =?us-ascii?Q?paVcPUJw8GqGTHRbPw6t/Gamc8Z+FENN14s34aYCanCMPni5/Yo/Q0iBcxIA?=
 =?us-ascii?Q?Gm70Y+QtKhvoMfn6x0T+kuzNADn6MepwXod21vvae5F7Z/EPMl3eR9Ryfm+Z?=
 =?us-ascii?Q?9RqLjHj//mjWyJNf+jOnF3cr0hQGOcOR+FrmgqNzv2ZWcWZGeaAAgaJEZBEX?=
 =?us-ascii?Q?xO4Lt6mPJTtdghT0ViCTq2SAUJ9dfSJWYy35YerZn6V9szWsD5Uofx7KeaXA?=
 =?us-ascii?Q?/YzePLR2yhWxT93Z5JRFslJPdlsmuB65iLvcXZq6a7r8t128EYB9BOiZVQnw?=
 =?us-ascii?Q?93UjPOuefe+pSciRn09j7DCWWAVdWr8rd+HnrpCG2Pb722Sq0fnwLDvNac5f?=
 =?us-ascii?Q?N9ke4nms+f4wKbzIs6kDXKyEca54yGASZu6Z9c/jg+vLw/WsSMXegpgHOITK?=
 =?us-ascii?Q?CyLDrwGSs+JGsMG3sJa/I1mvg1XkFvcTb5RUnnKAWEvouHectilocJFuOyPn?=
 =?us-ascii?Q?cEaTrMvHziav0XkAJdEmCaeg55PmiBQE6Dqq9Z73oWW5x1YriBN+paAhpA7O?=
 =?us-ascii?Q?U44NVTQq53qvnuN4+Q12y6aM4aZCPqO+5xhNnYSASHUu96Ax8SF+8wC6N4Rp?=
 =?us-ascii?Q?jbW+7fdjHV2lNLt//+tSlpbrBmA0VsJHYIrAcOrXu9oHzOUOV1afiW3/eFaf?=
 =?us-ascii?Q?FttRpwBU1y0ngAZ+ANSOvps1Zj1dqPdMETkbr39KN+Fak/MgCByl6tw4doHC?=
 =?us-ascii?Q?h0PGYJSfUM+gqkl8rgvITq937tm4pEXoA38qR7xCcHNzTevWmW+wowl27fIh?=
 =?us-ascii?Q?vVJHPrb6e9gPBIJLlA0C1aBdn0tUwc2YMkJinJse/0u7Cr8OsznglNYkhRd2?=
 =?us-ascii?Q?S4onWohdSLzmDLARJhpvt2fEDGAk6NH4YxzXs6S3O2dbvfh5gXvBkBwNtZ/H?=
 =?us-ascii?Q?NFoQnetqoFoif7ZzDQ95ebcYS+65fwp8/GzehA3PfPb4+ubpVSJTGuC83aul?=
 =?us-ascii?Q?reXqBaix+nSeqGfr34mP1+pbF/9tqoLiW4OC+HHqiMRywOR1wHXThIvzM4v/?=
 =?us-ascii?Q?paFt0s2qZg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d9b82b-46eb-4bd8-999f-08da2c1f24f4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 09:35:50.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROTJuLQoD/aFjDP90N40zjpC2wbcunkpuRPP39g3bi8/GHuSXhmsNesznfzbAzUa0YuTpv9lpC5fabr1Qf2vGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-25 09:11:17, Miaoqian Lin wrote:
> If the device is already in a runtime PM enabled state
> pm_runtime_get_sync() will return 1.
>
> Also, we need to call pm_runtime_put_noidle() when pm_runtime_get_sync()
> fails, so use pm_runtime_resume_and_get() instead. this function
> will handle this.
>
> Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied, thanks.

> ---
> changes in v2:
> - change pm_runtime_get_sync to pm_runtime_resume_and_get
> - current check works fine for pm_runtime_resume_and_get() so stay the
> same.
> Link: https://lore.kernel.org/all/20220412065719.17735-1-linmq006@gmail.com/
> ---
>  drivers/clk/imx/clk-scu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index 083da31dc3ea..2044e62980e3 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -528,7 +528,7 @@ static int imx_clk_scu_probe(struct platform_device *pdev)
>  		pm_runtime_use_autosuspend(&pdev->dev);
>  		pm_runtime_enable(dev);
>
> -		ret = pm_runtime_get_sync(dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  		if (ret) {
>  			pm_genpd_remove_device(dev);
>  			pm_runtime_disable(dev);
> --
> 2.17.1
>
