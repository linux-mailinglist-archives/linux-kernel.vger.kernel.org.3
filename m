Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C0F4DA7AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347400AbiCPCFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiCPCFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:05:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3888C5E171
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJSrSDTMQjuCzTSPCTlRRLWMJNgELtcKhqqO3H8wsUxW0PTF6RzEakNoLfvbMqN+ZVHdGxJv1PTmWKHA2QZTBy51lpn8k/aTGvk5vUcwTfp68z6kNbSCLhxWtYmn7ENzPLy4WdxQO8PZ2ggMY90/YJ2s7pzXWnpfbu+F1Gnz8AzuQ+iSZLQiWs0Iu+tDWS8w34dpESiRtGdhp9uzz8C65ffDqW1p+C13J+ljOiT+jDWVhKwySIQ7eAxRGahmZkVbxdkugSvQfp/947KrVmqSlBwRcTsplc0Y45GQctJVzSwqV85ZM9UuivPfkO7r562LdIa5IcaQmVLkUey2MOpqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdsdADlqaMr5rLrWDYJGV4HH4zZl/yI+qn9F/fweHg0=;
 b=JCdyZOdXIRyY4UTAZ1JG1OiCJFczuggFyJbEPPxY8pbm6qzKc8w+Gc62l2kpCtcw4OAWCXcPHowNl6UGR3cTTCshnvjYbdfbiVm7aLI+4zc2aLU13Vas+ALbppRg7CD2jzaQwrteImKbS6phrz4+Ax5Id9r9QQ8LELKN5LlE3rtS+WWdglQC2ng0XstSxKGxraPowAkrsRPMF2Vi3wpUWbtOcQyxLp34ieRdIxtt0/vueamN3rCRxT+vSAU4WHQ9x2IJLR7gSl94ZrJXb8XGyx+TMTrppdpTS6csCsojUXLmwAoPufDLFEHZJ9TUR9THTQ2Xsh7Ip/jRDThFHXwn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdsdADlqaMr5rLrWDYJGV4HH4zZl/yI+qn9F/fweHg0=;
 b=lCsIU/xYWlzg0zNX8JLzf6yJ4+eILPlNHdlehuU9xhAJ/3TFsd6IyTHaWcDShaJvmw09hKcXtgwIdn683selj/Hrq70musdWYSLKIxVz4vQoRwst1EYlyWt+3UK5W7Y2/3PZLdBEYt6/mmaAgl8KDMiTipaYETO5cO+2KSHClGo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5097.eurprd04.prod.outlook.com (2603:10a6:10:15::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.30; Wed, 16 Mar
 2022 02:03:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 02:03:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "kael_w@qq.com" <kael_w@qq.com>
Subject: RE: [PATCH] mailbox: imx: Fix duplicate field initialization in imx
Thread-Topic: [PATCH] mailbox: imx: Fix duplicate field initialization in imx
Thread-Index: AQHYONcMs2AycHSKKEGu/JeIOsy/wazBQjfg
Date:   Wed, 16 Mar 2022 02:03:49 +0000
Message-ID: <DU0PR04MB9417A00C2F5BA3F8D6F2C7E088119@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220316014128.89315-1-wanjiabing@vivo.com>
In-Reply-To: <20220316014128.89315-1-wanjiabing@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19e184d9-01a1-457a-65e5-08da06f136b2
x-ms-traffictypediagnostic: DB7PR04MB5097:EE_
x-microsoft-antispam-prvs: <DB7PR04MB5097E4E42A62745319BF48DB88119@DB7PR04MB5097.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NsDyZEDoB5DBVo9b79nY5Q8VlyMY87qwHIs6hRtiyROcbFK8z7rjTd6n20Zhq9o94eK2lyzolZn9hnaNE3p65nFV+T4mZf5cVYVwYffs/h69STLIVoAYlm8jiuTf5xrjHoAK8U+LZMhYrtGmsXgPdP7BTjsblNW21EMvBr+6K0dy7GkR7bnTn8vwf82DUlwSzHjzCBDLhrec+D+rkcf877yPtbks4MWjVsgGpb+nhwzoy+xyfD6dHrXESBeqtagmZ/KnvXMbUqZ188g+VmEAkLI1l+yEp5GE1R34XuuRiRrLMuhKS5MSyo03KV0C2+VFDDyyA920nU974Qf9bsrMWh5vrWi/LC2/pKSMLHVZlMImgk/9ZMTJqW9Tta8XkSKJXCkgb8WO9CIr5FVjACsfzjMf2YRXrjLvNhczahxyaplYC4IDkCfcODdmdilh+RqjObcaAYPfF4J4ZevY4jpDg130LEwwJNMOdthCi9ocKxXuRrl/pJZM2YVK2ryybImklL2uGbYJ9xpBPeDie+b7G3atgAFAHbYN2p4QZo/Ar+uXrT5EUGTnxYJtH2kAM86DONzyZr2JjpDCS/WrLFYTcBkFqS22LqqvxiruSEmALjp0tw0fZRqtIHGWe+8n2GyDoETZ+A6xRH4IFDHCDsAb4663HRDbNTT9w+/AGw2PHNXEwC+w+6CQ8NTBX2L7PdDISizMyd34/ggy2nnKoqjg1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(86362001)(4744005)(4326008)(508600001)(44832011)(52536014)(33656002)(38100700002)(2906002)(26005)(55016003)(186003)(83380400001)(122000001)(110136005)(71200400001)(15650500001)(5660300002)(6506007)(7696005)(9686003)(38070700005)(316002)(66446008)(64756008)(76116006)(66476007)(66556008)(66946007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c6DO5s46rsnGX86tTuyv5BKhE1vbnEjyFhH435F6ql03YGeuoaTnA5O0UqfZ?=
 =?us-ascii?Q?vyuKTqZsNcjYWeWP8h8yRRRG3+9BKvq/mnxBDRUbbryesstmotf8dtTVh0Uj?=
 =?us-ascii?Q?wda/DeMVZj/ML+2ydjrHx7646BB2Bb9WJin4qq/Cukmp5ZFqXd65zhOWWle+?=
 =?us-ascii?Q?kEkaeRBsqxoTbqtq4e2W2sCItbZX06tJeQiLrVJuTk/kl+kTlfeetRWHV150?=
 =?us-ascii?Q?ywZiohnl7HVGZh7/gPLs6eiNaG238Qi6BG5vQynI/AkohUmPm55VcSSQimex?=
 =?us-ascii?Q?Kx0RQGD5Q6OXSFAp4RHVR766ll+hy5hq5FAJ//8rQM2KTjW2bIKUmgwpU+91?=
 =?us-ascii?Q?n0sOzKORo6eOqIZeFE2vriV++ccjTPoU8T4Ek128XCCo8x9thLXyJ+uSEcr1?=
 =?us-ascii?Q?B+2utQ5YBT5FHx9jzM3Tn6mAdaYfSEvmFOfz2NZYijeQ/IuVcLxJlsA8tQ/a?=
 =?us-ascii?Q?hDDw982NcEVF/1VbLMsZc1o4hYhvDE5HKyXWlOHMZ9NXtvA540MtIiTcZJAp?=
 =?us-ascii?Q?AA8+EgALBWPYDEd3oB2p+NDXD/ljMcF9ATxOYLR+/cDx3zluvAFHsDT+/yri?=
 =?us-ascii?Q?C4HZK3Tf1mQM8CLdKc1wwW5WcLWdev60QJhdyT5ch9zaf22a1rY+/KCXnhpf?=
 =?us-ascii?Q?sENPQ5uxNahgPDHLQ0rhrI8wbiA6UyJEVpjUhtIa6xLqlDJ0bDlPSPadpsAQ?=
 =?us-ascii?Q?J5wNeP+C5EB5sGri+pwEjStJwgRIu7caInJ6KbCxZXTuC/yVxCzK1T1fbQnp?=
 =?us-ascii?Q?/COVspgxCVQCYJ+X/N553phM7kcJ1N1aD0n6Yyuf3JLzwZnW5xUsPoB7vaOR?=
 =?us-ascii?Q?ZMwuoSKQmc8Jx9eJPR+GLTeBiYnhuFJquYqMsSdsjMs9ktmhy5aZzeQuja8K?=
 =?us-ascii?Q?HKzVT7wSDLWxKmovZvC2PrQYmQLqDWXY/3G5tTVnYbw2PEML+Edtyu5dnJ5i?=
 =?us-ascii?Q?h28B7pjxzu4vtnS0oMcZnMk3Ev7FOdND2Xp1iP/1Hpo72EyeK1j7qTmkse7Y?=
 =?us-ascii?Q?Fx1Yp8NDD1sfWN6+aULPBr55swOI2sRpQ7wHWDUGWdywUoXunIN+LFgmSsVE?=
 =?us-ascii?Q?6LcErQBCprBKvIEJ1d6YayKHtw8ShpbSuFDW7RBcoFjGa2b7lwyR6w+JP0Xw?=
 =?us-ascii?Q?4JR0tl6M3+QniT5r9EY7pJgxX2k17dUFoFEW2lqvbxJUKVhbWzdtpsqiCDxF?=
 =?us-ascii?Q?R/NHdbUJmh0VVOTFEa0FLbxQQJ3m1+Uw54UFUTGKyEykmzwWaSjlkuO5VFgD?=
 =?us-ascii?Q?+ett++9RuJiAeo99IMEN2sK3TW761Q0gaLbIElsZxducgsXyNn3yGt2Tw0Qp?=
 =?us-ascii?Q?n2lsJbcJRqgtuW1PuiVRpYLpo4QUYkUSimDaG40At0/5GXCv1SvR12QsX9L2?=
 =?us-ascii?Q?YJzcvd+3Z8l/+XKKgVRKO44f7E6Mwy6P10cUWhKm9JAfnfzhZkees3877Joa?=
 =?us-ascii?Q?z/2r9MBcYRE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e184d9-01a1-457a-65e5-08da06f136b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 02:03:49.9330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0bwKufhtCir8xYlG88T8dUhL1omBKmO0s6t+IYVQoeM/K7Jx/nozdni1Wb4PtUJAu2J9z9oExfRiC9dr1+4vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] mailbox: imx: Fix duplicate field initialization in imx
>=20
> Fix the following coccicheck warning:
> ./drivers/mailbox/imx-mailbox.c:884:51-52: rxdb: first occurrence line 88=
7,
> second occurrence line 889
>=20
> Fixes: 315d2e562418 ("mailbox: imx: introduce rxdb callback")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/mailbox/imx-mailbox.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.=
c
> index e88f544a1548..df8a785be324 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -886,7 +886,6 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp
> =3D {
>  	.rx	=3D imx_mu_generic_rx,
>  	.rxdb	=3D imx_mu_generic_rxdb,
>  	.init	=3D imx_mu_init_generic,
> -	.rxdb	=3D imx_mu_generic_rxdb,
>  	.type	=3D IMX_MU_V2,
>  	.xTR	=3D 0x200,
>  	.xRR	=3D 0x280,
> --
> 2.35.1

