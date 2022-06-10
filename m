Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D825460BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348293AbiFJJCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbiFJJCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:02:52 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5961DFC4D;
        Fri, 10 Jun 2022 02:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPLnDQhsqFs2L1cpNJV8KcYDlYPQTe4qnoZo+RqhOpVQL/kt/voSvAjjOlRAmdwTdVXImxH4o1KPkTZvAeagiiVz1egYn0hBiRBimQQz4fSSm1Bv2r9d5D9rwPocHqkpOyqGM6elrVQIUSSDd/yuoHs0VOFA11mZlmWnNq4hxbZQcK+tu+gpKJDxVLAA+C/Xa7njVsR60u60DSykHEFXCSED1uqAp+zVzzOP9YN/jB6uwDh7XZfnC3m352xln5ExPRfSg4pjAh7Nd8llthiZJiSmCHbPytEBD9Sef+OrlJXNTAZtaX8YZDCd2sRp62qeEJKIHQbuUbWoueZzVUKgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxOr93T0PF0Ro6XaU1TULq75SEiXrKhGq6yPdaNau6k=;
 b=XcLCd+9uo6Y/vUWawZ3Fhw6gM+6Lq5Wn9a4Z36hy3f2uKSOszvgsMJnDdpo+6y2usgu+dEDf634fp1/i/xt+yaU3Znh617La3ge/YcXUMBYgwBWMKOpZs+NAHZ0dahTXvS1j1WzT1JFRo2H7/7BnsLk8ii0MI7IuO5/rx2v7vXkiW8mnwbqsHzZNDfe7V+gkrzMom+ISRTaA1mRzXNILZO7aLn2nG5sxoMwBs7F3zx7iaemyzjHv9753a6Az3rR45fiVZXqgGYhme+de/W/CtpWzOmETKnTIr6KOPYCAIx0B9MipMd4f9InvLZH3/AWfh8Qej2siTl/egAf0pwLYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxOr93T0PF0Ro6XaU1TULq75SEiXrKhGq6yPdaNau6k=;
 b=SJUJ86HE5bVCxaH7zXeTWfZ5+Cr8tAY8nINEpkERwJREJjcAdM6vBGxjEAT0C1UDwXrwsXuXtKeRBfsg8qzwgU8OEHFfN1HAzN1btiWSmjDf98XZ8RVB06ztWeDKXOyvDVOCqFhXLc3lSPyoyDcUmKR28ZdeJ72AQmSTzM8zGQU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0401MB2345.eurprd04.prod.outlook.com (2603:10a6:3:1e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 09:02:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Fri, 10 Jun 2022
 09:02:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V4 3/7] clk: export of_clk_bulk_get_all
Thread-Topic: [PATCH V4 3/7] clk: export of_clk_bulk_get_all
Thread-Index: AQHYe/9crEY3rWec9keuRXe+rnolm61IWbCw
Date:   Fri, 10 Jun 2022 09:02:46 +0000
Message-ID: <DU0PR04MB94170E7DBFEABDCFCAF31DCB88A69@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
 <20220609125100.3496633-4-peng.fan@oss.nxp.com>
In-Reply-To: <20220609125100.3496633-4-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efe676cc-20cc-4a5f-d129-08da4abffcd3
x-ms-traffictypediagnostic: HE1PR0401MB2345:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <HE1PR0401MB234570C32D8C45861893E66EC9A69@HE1PR0401MB2345.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8f018csCnYfAMpuEmd7915W8MAEG2buWoIFZsq5KCSEtzObkz4+8hBXqclZS2J/XFZy5vt8Fzk/UCW1B/WEVozIgIF6JZcs7lxwPcZlHawLkgc4MxPKz9V3t7XdMaqTpoLFwnNfHRxXr6Gi3cs/y3CnK7WcbkNAMYuu21lsIk4IBDgfZkoliZ6Utmpnam7RRDdxgjocotwLFfTWNd1Z8DueVVqRZJXkJiWuTj00mbfFL0rqrsdGa69Y8b/ZKGTiPZdt/BbXzbLOKlelZWb8IbvcBCwxVsncxdca9xe97Q1SN7SRUhKR0RhOO4Nv4SRsPHAqOEPF34ZZJd3OFwaoPXERIXCxTmJdsgP465O5mnbUO+JwlVnNGOMqwifB6F1iTTOwZu2PuKhumxNp3KZo0VuaUaIvDDiPrzQDqYWF+6HRfwQYtpGz8DVElGxaCJNgHpVgpGKUdqpbvNmb6VwGgmX1zXakzi2JLLyOJtwNjGAMaW8zQ+HrH4l33dJd+VMY+y5EnKjJCdWRZK1Ldcg+mS9oOQ1SqkOqt49nSg+aONZ8Gs9cXFEpn7mEFy+Npms397Pc7wiCVfZuCuS17xOo5ZGIgaytyyrZY/oawAEGYztzncd6gOBqUHMOiuXT469bHvcNj7kHTf6qFnvYRAxoLokx5mY2xmEVfB3iL+SQkWKCAtrHGJWd0nQFk3XF9039y/NyJ/3dBUDeEU66ZoHKeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(2906002)(66946007)(9686003)(26005)(86362001)(508600001)(71200400001)(6506007)(7696005)(5660300002)(7416002)(55016003)(186003)(52536014)(83380400001)(8936002)(38100700002)(76116006)(66476007)(54906003)(110136005)(66556008)(64756008)(66446008)(4326008)(8676002)(38070700005)(122000001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mIrGSgN/222zM7TI77xg0/eUX5cIJI4aZQcWUAXgzEOGEwPYYEJntusZkSl1?=
 =?us-ascii?Q?/yuhbE1cnQYZgRk1E0fdsgwbaV1FQUCWh/alHQisz5CABJy3YpJ7qHqDOTVE?=
 =?us-ascii?Q?N9r/5oKABxwboIyDH5Xb4scojTzLUI73XXCI3ywBqqqfJQexiwjybVASfDHQ?=
 =?us-ascii?Q?kwbE9r+Mw4IfwqjDz+/N/eJdqhp2zvgGHmEOzuzs8JPZ36wqF6vk8KocKTkE?=
 =?us-ascii?Q?ViyaFBFNgX1gtgu0rKkb/C2XVKWO4abhIJwj9GUS0rNq/dD/ryZ3QkydSvUi?=
 =?us-ascii?Q?laMw4SNPZYIBOg9LorS2ktM47gcPSoO0LBDffi3Ow4DbmwKZbdMktHiWEztz?=
 =?us-ascii?Q?GgF1cjM6FHoeeT4gxoP4nsG0GL2UiVj7jkOKVoR+L/vwP775L6FHGQS9Z8rc?=
 =?us-ascii?Q?r6Fk9SGHO9LDPYNLXKM4SQZDXdhdP+c4FystgbjM4dy7crvuELMmxX5U6FHr?=
 =?us-ascii?Q?NFHr5Pwsu4A656p0kkh44HafQUiRXn6N33Gbccw+Uj7tWxkSXr032HjhXzUQ?=
 =?us-ascii?Q?4PKatif6TOXdV4cwcWiCMWBCN6T7SPV5PgCzKOBxh78Y+k+jCvHWVqxsRzl7?=
 =?us-ascii?Q?gE7Mpfvnm3u8KaJbtleDGxqvEEeVZOgWMmKKo5WTqM292eAxtNoiD65IoclA?=
 =?us-ascii?Q?A7o5J+i0FC4zoxVVHWgJGnacib7ayF9b+nW545txtwWqtvbnRtVjVCgWV9a4?=
 =?us-ascii?Q?tgs/PBYlwWujOn+PGX1DTvB1HVoSN+r2rGbMdNaFr6jR8jPElIeOcpwiCNi7?=
 =?us-ascii?Q?92u4rEFIUgUz4Y+bZhpkoKqLnVJ2cLS/DsN3A5E1GBE4UlSgTUD1D0baXrf5?=
 =?us-ascii?Q?sETu64tzZp1WZfMSzbzaORnIuOyVBC1oHOH2EwMa2TsFSg7+oiGr1PzvjoQv?=
 =?us-ascii?Q?3jzzUGc/tN2NL/ls7Nvzv7kPIroK9sqCKw7tdCOKk+KuXr/NkloFxRnQNT6Q?=
 =?us-ascii?Q?DBfeSF/IPWkzeHjLZwP6X/FG5ir1zWZfTlJg0nOMSXrD7EUB2ZMRmbBPXXbG?=
 =?us-ascii?Q?7Vpq9wfb6fK854HAkRiSgaSeuZY9S8fIS6Qqkxv7/ycMLB3Uhz6zheNTTYWh?=
 =?us-ascii?Q?vnHC6Qiu2/L8ezAH/B3vBGJSi3U3PZL1CL7xK4ryskDmPE8HQ4z8txkGEG+v?=
 =?us-ascii?Q?LJ+Uuce/wpq2+co2lluhqycRqh65isULYhyZZF/1UTq8iQ3qRFaCuSdZNL3K?=
 =?us-ascii?Q?jCcE2QQNEWp/bxui0heo5ozYTAsfaFqXhM7mcAtTrGk+orr3GiXHabMisw+9?=
 =?us-ascii?Q?QIciWj5oLfjow3pTNmSWfZa4EZmASZDmDzfQf6SeRj65yjf54/HsNG7oSzS2?=
 =?us-ascii?Q?Q11+142i7iAGUwN2hB0rwrV6pwdAP3wGy7NYE/cc/l9uoYXHruudBKPWEPWl?=
 =?us-ascii?Q?I75oGTOksODSoiDOXYmEeA/SMk1GU55D5N5go+9PvBTi4nfhl0FL8ZVaX6CQ?=
 =?us-ascii?Q?MzS6+bGmyqgJ7RtADBmmIErX88ujNSroPfuxUw7CfB7OEYxDNrCYq3KkEyem?=
 =?us-ascii?Q?L/O3ah6PcsC6t92N5y3Azlr3BBrk77J4wjECEVD9zvHG1uUGtDUhGw/+a7/9?=
 =?us-ascii?Q?hMtN9eEZPCG6/KW5XLvZ+exjR+ZG1MGPEbNuifS6DIiqkIPu35dTPLr35ofR?=
 =?us-ascii?Q?8r7BLgPTroOxKsrwdlajyFxC1e4edmLsh3uyMZEy6jLIHL/M/vUYwFbt+bJ3?=
 =?us-ascii?Q?Bnu9exsFkTU+sBozINqqo15W0+wKFtw1XgusQ8lM67dGykRqGhcbu6tsqCDU?=
 =?us-ascii?Q?DrtfvzhwIQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe676cc-20cc-4a5f-d129-08da4abffcd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 09:02:46.7139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwWhjmvd4kE6rk7NUObHvL7l2Xa6/zWWDrAq4lfHemeiN4iTw1/21DsHnqTXAfar2PAIrFlIsssgVKsEA2iRHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2345
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

> Subject: [PATCH V4 3/7] clk: export of_clk_bulk_get_all

Are you fine with this patch?
Patch 4 "soc: imx: add i.MX93 SRC power domain driver"
depends on this patch, if you are not happy with patch 3,
I still have time to rework patch 4.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Export of_clk_bulk_get_all, so drivers could use this API.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk-bulk.c | 3 ++-
>  include/linux/clk.h    | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c index
> e9e16425c739..470155856b02 100644
> --- a/drivers/clk/clk-bulk.c
> +++ b/drivers/clk/clk-bulk.c
> @@ -43,7 +43,7 @@ static int __must_check of_clk_bulk_get(struct
> device_node *np, int num_clks,
>  	return ret;
>  }
>=20
> -static int __must_check of_clk_bulk_get_all(struct device_node *np,
> +int __must_check of_clk_bulk_get_all(struct device_node *np,
>  					    struct clk_bulk_data **clks)
>  {
>  	struct clk_bulk_data *clk_bulk;
> @@ -68,6 +68,7 @@ static int __must_check of_clk_bulk_get_all(struct
> device_node *np,
>=20
>  	return num_clks;
>  }
> +EXPORT_SYMBOL_GPL(of_clk_bulk_get_all);
>=20
>  void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)  { diff --gi=
t
> a/include/linux/clk.h b/include/linux/clk.h index 39faa54efe88..ca74f4e83=
d25
> 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -372,6 +372,8 @@ int __must_check clk_bulk_get(struct device *dev, int
> num_clks,  int __must_check clk_bulk_get_all(struct device *dev,
>  				  struct clk_bulk_data **clks);
>=20
> +int __must_check of_clk_bulk_get_all(struct device_node *np,
> +				     struct clk_bulk_data **clks);
>  /**
>   * clk_bulk_get_optional - lookup and obtain a number of references to c=
lock
> producer
>   * @dev: device for clock "consumer"
> --
> 2.25.1

