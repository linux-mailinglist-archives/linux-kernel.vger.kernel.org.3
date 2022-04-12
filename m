Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063A94FD9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351140AbiDLJcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386467AbiDLI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:58:12 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935171010;
        Tue, 12 Apr 2022 01:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfyTDBp5Z1gy1z3ANYdG1Nx039JOLzL+n3NrSCdGEoQwc+tH8h6wGFCyrGETcqkj5sKlz9qVIybAM7ALLrhMHlq3t7z7Ssj0289EvZjyo20Zhwx7tLPb6TCyOO2VpMvPZkKEhhS/pNJ35egmTIOf79RQEgEEZVBJ5VAeDPLUI/Z6WBRzepCxcAYDjyB4dsC2EeOU7z6JH2sYq/1rI4U05uA+/u4wgKY8SeP1cCx0stFbLWD2tvhQenfBw5DU7lrMCz/DxpG4YxTcRbUrbSJiOQDldGPVJDYfWIYu0VG39IBtbgr3fUuPya3yrkX2Nd0Ij/6iRHWflmhU1vLGoqSR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDn5D0tBstNqDtSSyRZBge5I3SlQZpOa2MVxeIuo72U=;
 b=iu41v2sxLSrchx0AocewLL9nXMT6MAWCRRuno1JHOrYAtYM4TkaWFEErzR3BAVpGRf7GjY60sZmyIQaGgzYCHPtOSbCq1oDz+h4celr/dafNReQxBH8VFuN6BZi07PvZ7A6i45nAApYqj/EnW++FDZL9CO02qgiwaNyvNiHD8qpZ6tyvYYXAl4IRr9dz66jG+SjrU4kaI1BXppdT8KbgNlyGwagK7hMTmvwtOftbL6qJnpRFWJOY78tZel9zhtgFyGvgyFCs/oLSmINBYZVVvtIV3+oBtUuUfxRQ3uDKZeo/iyhb0SKy8NSo+OBtCj6cWkN62UZKPJdxPE3CgAhOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDn5D0tBstNqDtSSyRZBge5I3SlQZpOa2MVxeIuo72U=;
 b=rSvON7VwEzqnJTFGmKKODemANxBFzxFSy8XfSlBK+cK8UFWafCBSd2g/nXYTNEnb50Dz5zXc4RhLxfM4zyYLUILVJlriCcIqo0yWTxazo9RK8JXS/Kk0s0obJBoILrHYXOmSl6RgFd5EHz06S1YpT66gDQ5jjb6vmnHsIuTmGXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM5PR04MB3266.eurprd04.prod.outlook.com (2603:10a6:206:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 08:14:04 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 08:14:04 +0000
Date:   Tue, 12 Apr 2022 11:14:03 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 2/2] clk: imx8m: check mcore_booted before register clk
Message-ID: <YlU0y9F2VGXsJDzU@abelvesa>
References: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
 <20220228124112.3974242-2-peng.fan@oss.nxp.com>
 <YlU0JRrInWbCiylZ@abelvesa>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlU0JRrInWbCiylZ@abelvesa>
X-ClientProxiedBy: VI1PR09CA0103.eurprd09.prod.outlook.com
 (2603:10a6:803:78::26) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55e9f48d-4b12-41a4-01a5-08da1c5c68bc
X-MS-TrafficTypeDiagnostic: AM5PR04MB3266:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB3266BDE1AF7F434B511D11BEF6ED9@AM5PR04MB3266.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDeyQ0h400BzsG2e0lLRsuOFskaJm2DTLFbcQOyQlxgMRA4frcdPvc5Dn+3tZ3pfO5GYRrFtfS4o1W2o4rK7swnnQUfax+lGxxoZIQNLcFSrU+NSNOyflSjML0Hkb4p6NGM4fp7FP+yhPKttlbKHZqyLlYMgeva9Wdybou3j0g2q24lQ4xD83mgR6BXoy5WYF/OSZY3IXEJ0wcezhjgBkeO5B9mNnNQm1rbldnxznPIuPctjqpGYrC7YuUXi71Sje/uZH33uoOY6qRlMsPsNRxS/EaUDusGjMeyA784v2eHqULirzuZ7NxLfZfqVlDd+V+wRcLXZRZg/GpcL0kHbBJFIaE50H1Zn+ExPSaWhaOnKm9DTFNxPmY5gnTet2RlXFT3Tir6u3YtoVQo0InLUTguy7KlFQ3KPtrxse1IlocrWJ/sL9eKynLxHD27RzMmsQvjcYwdUTPJAx25FQposfgjAlvrv8S0YRM3G6QZs1ESajeOcO2cYK+OsWMLNcBRo+lJpXzXfhjXdQGkmpAuxZmo6aNtTE8+Rw7yjf4eN3eYxM/qlVBzYz53l7DQ051hsZFkvbB/tuozd/Oh0IKham6zgLAnf/pyW/a3JH4qVduW9tgUCYxmtWAmpN3GnrvIhkHGbg5RVR3539Q2sQxZeIVhtAoDmk7Ufvt09SW8NVnI2vRkPCoemhDvgKBtUH/91ycBEPpBPp9E5gsFMSBfn4Nfk+94y+RDeeok++8pdWYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66556008)(53546011)(4326008)(38100700002)(38350700002)(6862004)(6506007)(66476007)(66946007)(8936002)(6486002)(8676002)(83380400001)(508600001)(33716001)(52116002)(86362001)(2906002)(26005)(186003)(316002)(44832011)(6512007)(9686003)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4pMWS40R1d/IFgQZGeWGuzLEE/l9ibe4YJPtmSfXufh4JgXGWxTd5Sa/lurv?=
 =?us-ascii?Q?Ra4KEGyg7PS1ym1bvd1JoL4GMb0r6qIuS55/1Po8spMg+mZhKWvt4DeqYx5+?=
 =?us-ascii?Q?UDcGYV1n9jXNnnMQjJDBjz0d5JCvvRNRa4BciDlc+OXF8Mv0eqMteW673UXu?=
 =?us-ascii?Q?LiND9g08aTuGrYfoo4J49n7Kf0jX8NZqLnjjemxvcPdh0IIRFH1BrF4PTB/3?=
 =?us-ascii?Q?hwEevBWg7GeYUsUNP8V1kzicAwMV0mOYmcTrezqtyhmGqzCs/0IESO7bUsS9?=
 =?us-ascii?Q?nc2c9GMbhozod8izY+O6MlpYsQzT2ZpYRDk6rirInuZmNcwr85r8MllDt8DA?=
 =?us-ascii?Q?Ytq1qZFqhhAe9jBZNdzDmuQFUehm4Zmap31WHsD19zJq3Zw7wOgnBX5Kktup?=
 =?us-ascii?Q?OlB4yBP/UGyElCHn3crSW26fBKmZpURCBcJErWR8nF1JX62JoottCu7XTCuc?=
 =?us-ascii?Q?vbwTM77Qh1N7JWbIf1vyVwr8I+3m+Ebf2N+KBmLrhi+7Pi9rsqKnwNxbe2pf?=
 =?us-ascii?Q?HwbEzKy2r1aCCObEdXkCXQyi4mbGCYemfM1IERUtTvqex/sW/ALkOIey7G5a?=
 =?us-ascii?Q?aWmsZWdkCEESUjr5JBwq4t6EcJ6PMvULTgLND1+eoti4UlYRUI/ay8mQ27TR?=
 =?us-ascii?Q?FgZ1RAgMuGmg3rvoASbz2wLB266jHzaO1YXvEoCcW0ac5FtBdsG5FRJLDT8i?=
 =?us-ascii?Q?l8b9Uhluk/Ezj+acARz1mXEpYEwlgvScv5tlqiT3PZM55jbVfAraLYnICgoS?=
 =?us-ascii?Q?ON1ZKibaOh3ySsv5IJXkGXlPzb6mB8Z8l9OYr/tV+bedXWq6dzx/QVHsjlaU?=
 =?us-ascii?Q?OkMsSvkx3roEfuENQKMo4BkqUQ7syQPs85SbwuVqRlzbtFulnKGzxknMqDTC?=
 =?us-ascii?Q?dQ8vhWzOPwCfe4n/PwsbJPDh00OltJi4DlHCx3zNZA0Bz1Q1ktVEI4lFiyh7?=
 =?us-ascii?Q?5LA2nRdZS2BqipGbmN6QdF6kHoAyj+cuqo4N1QRNbMGCpyD7c2lvmFT7e2UD?=
 =?us-ascii?Q?OWvDFKWLuStOn23/KtNS4WfQVsO9IjlLXlk9lyuuGui/5JFWVEDCbcmWGsPB?=
 =?us-ascii?Q?TFc/NL9zgLCZAAyFoIBbBt3o+ithKzjO/I8YcJKKnCwvCkMVUtURuOSUANsX?=
 =?us-ascii?Q?SNdhcRGiaJpFN/l4pWz+H/1rOnW8IBydDkBHivFf+u7XDrdiFYleT63mYObt?=
 =?us-ascii?Q?rRngXWYxVWBKn9VUVRvtuYp17vL6jMEp+6T2X5oe9fvGuu70pXY5LUo3b54l?=
 =?us-ascii?Q?a1CSfu+mdno8AoRITB7zvNevbpQELsw2FM/mgLEh5ZNMvn4RhMz43bzXzpbz?=
 =?us-ascii?Q?/Mr4yk3ZiBGgfVKb5LH0Ci0xKiD0PqRwyVGFwo6AmfHB+0VVz0Jg7ENY17RF?=
 =?us-ascii?Q?uGa6m3pW0UqLZT717WZGsmlnuQz7A0vgX3FhvGNnFDv3F9IeBcofETINpSXE?=
 =?us-ascii?Q?lqhM3LK8w/ahnZF0m6y+QvOEvJS6mj+709SeZ7iTuGbxFY8rBTn5jirXkIkp?=
 =?us-ascii?Q?x+mwjF2J+YCZHnZGZELpMXu9lKFnM2b/bidM0KV8fBj22mc/OW5xm2DNCz+q?=
 =?us-ascii?Q?gH20OjZ8wKtM1IFCod/auJr3qftQCzqcaOr7LtD8shBz8d03GChdGuwAIU38?=
 =?us-ascii?Q?c1iIWpCN1X48YmeB6LrMMDhCW9hDNKD9ysjeJSleYdwaXWRMmMIR4Phr+ydt?=
 =?us-ascii?Q?DBxerk/ZvDN2SqkHDwBV7EiRLxFagcbPolMDWpgwnfy7AnKrZkuydOrraKTY?=
 =?us-ascii?Q?S+qyME8iQA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e9f48d-4b12-41a4-01a5-08da1c5c68bc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 08:14:04.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TOlm0WcrUS/gxS1lsMUFkRwVZookAJIfYw8X91GE3n8KBaBVktfVYDMdOMBZYWc1UEycyZqjAw964kcIBNWpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-12 11:11:17, Abel Vesa wrote:
> On 22-02-28 20:41:12, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > If mcore_booted is true, ignore the clk root gate registration and
> > this will simplify AMP clock management and avoid system hang unexpectly
> > especially Linux shutdown clk used by mcore.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  None
> >
> >  drivers/clk/imx/clk-composite-8m.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> > index 2dfd6149e528..b16c2c0ea9f6 100644
> > --- a/drivers/clk/imx/clk-composite-8m.c
> > +++ b/drivers/clk/imx/clk-composite-8m.c
> > @@ -223,14 +223,19 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
> >  	div->lock = &imx_ccm_lock;
> >  	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
> >
> > -	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> > -	if (!gate)
> > -		goto fail;
> > -
> > -	gate_hw = &gate->hw;
> > -	gate->reg = reg;
> > -	gate->bit_idx = PCG_CGC_SHIFT;
> > -	gate->lock = &imx_ccm_lock;
> > +	/* skip registering the gate ops if M4 is enabled */
> > +	if (mcore_booted) {
> > +		gate_hw = NULL;
>
> Lets have the gate_hw set to NULL when declared and get rid of this if
> case.
>

On a second thought, no need to resend, I'll squash this in myself.

> > +	} else {
>
> And then lets do here:
>
> 	if (!mcore_booted) {
> > +		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> > +		if (!gate)
> > +			goto fail;
> > +
> > +		gate_hw = &gate->hw;
> > +		gate->reg = reg;
> > +		gate->bit_idx = PCG_CGC_SHIFT;
> > +		gate->lock = &imx_ccm_lock;
> > +	}
> >
>
> Would look a bit cleaner this way.
>
> With that done:
>
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
>
> >  	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> >  			mux_hw, mux_ops, div_hw,
> > --
> > 2.25.1
> >
