Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67468564B0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiGDBGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGDBGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:06:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECC5FA0;
        Sun,  3 Jul 2022 18:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdThVa57+qOfFWsve3tO8hAVFWt9AfU7jW37gicQ3RrJaLbInWP1aolzeOwBhmsVxtNjPVb4zZefk7F/+Myv1OI9ec1DvYco3+tWO2RxDLZZO75DxvDRCCXRIfY5cjrPqcgL7oi7CnwofKvxLZnjLbYnv8uBWn+D5EW3Bc4MpX2+J9F3N5X60JqH6/Rg4JQcd/GfjLGgzZDcAxRKg+37pegEor0FnR7AsNMDrHBoOa6jjbely5Y3pSVDNVGxEC6g5g2WYmFIRhSTEmnBZw+mOmrAyJgMURJHlBqymkbD1TvzsFywPbHLSfsEnxCjCSYxJhS0Z8EQiDB85Ol7cqOAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyayVLGQOErPcjpqwIJLxDeicUBxUg0vBKsBhgdYT+I=;
 b=LDjY7YxT5w3iIe3vLneX1DZ77opdMIuF99toeFeuKgjD0v+xZ9yMrQ8zZl938gWuPZITxPZANWNtC7ZOQsfuE9gss6zUPyUipbaRyxS3SjZFknC+LhfkoUyMEaalJ0/yLgrNt06HeGKeh03Yh5+t/7JToLauEDiummbBw7PIkzLmUnk0tIT4LNX9At1RUHO5YKq9brBIgoBhryWbYcQa91tWm3DqPTe7Ouin8Tqj+gXteTTV6prAGdNr3a1muHe9cGAwCICrmKFQXeQaahpEU+wJw2fi3PXWoKTtPYAlSpImzvwMuSW7NgASTTMtRLttSf6jb0t759kUfvur/A1HMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyayVLGQOErPcjpqwIJLxDeicUBxUg0vBKsBhgdYT+I=;
 b=lTabyF6Ox3GuKY+l5VTifVYYY0x/k07vXnkPW/IsL4+wt4SaZLq8KocWj9fGye52s80UP1i/cUXTPD2W1XLTysGhTdO5R/4+CvcAqlZ8WgdCgT4fflzgyMyXPkfloB8nzh9lBjKNRZGyoobbg6brTTzrhZ0ywalG6N5ZUZkpBYc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8217.eurprd04.prod.outlook.com (2603:10a6:10:244::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 01:05:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 01:05:58 +0000
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
Thread-Index: AQHYe/9crEY3rWec9keuRXe+rnolm61IWbCwgCUyMdA=
Date:   Mon, 4 Jul 2022 01:05:58 +0000
Message-ID: <DU0PR04MB94178BF72EA1EFD64E9B0CE288BE9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
 <20220609125100.3496633-4-peng.fan@oss.nxp.com>
 <DU0PR04MB94170E7DBFEABDCFCAF31DCB88A69@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94170E7DBFEABDCFCAF31DCB88A69@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca585f2a-b507-452f-4324-08da5d595aea
x-ms-traffictypediagnostic: DB9PR04MB8217:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: stng+CMHSKfbfrPoK5EVUa642a+qvvy8gzrZzxj1iklovFiAzEEdeFf8XRzTQHi78uOTBY/M2lkQXEEuweuF5ZwoFe9uTTVUS4iCXbq6+16c2BupkzJFzkyk3M/kSeKY+Gt6CfPn1xOrcyDee+XCKE3EtgywfSFvD7BOACkuaGN14xASll3bJgnuaX/zp74swnr8DVzTc0OHNUeLypYO+2m56AKmJcYYnKRgcViv5R9OBhM//cgpVh/lr58lhtt0qSwcasUlLpStH1Ud6G1ipWCpCeSE5GkuMtAVwaheDCwdLHeVwW8JmCBoc93ejgEt926h1b2stTgETwMrmwaiXg/+G3N05O/96pwANJQieThNxN5WJADg1mBKU2KVNMZISSva/pqOsMJbjSQbwyS0KfCgacdzHl9MCjUOirwrBxZTNwy+90pavQXzjlYRuEaIaaKEOrJHEM4Bj/z9a6cDOAivQXYNmGuqGxepjj2yzF03bb6K/uq4UH/FdQvDI+R7dg8iwPh6ltrFqemoYd90kiFdrzKygbWSRL84RuR0oHu/lpK6tKLd7Q9r/8pX3BZRcNEaguGTLdSk/KvYOU8lKtYldiksQG8ZTRcFqMZkWSKjizZig81mwRRP8sEHBVh+x8iDbm9j2OpYxVKgVsHSAUsSd+h6F8fSzT5ReUbywh1zIfikLW3TO2q7fh1izvk4oSACZF1SDSmC4vJwcLyk+02ZFzdcZR6hYLbHVddS4ZVuxACkS9smsPGZayVqfdvKjm2hbwXmGxUobOWwHPN758KiE7dHMAgaAI54jABUWSYvMff2VMroMCJoojrVwDUB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(186003)(26005)(2906002)(7696005)(6506007)(41300700001)(9686003)(38100700002)(122000001)(86362001)(38070700005)(55016003)(83380400001)(33656002)(76116006)(66946007)(71200400001)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(316002)(52536014)(8936002)(54906003)(110136005)(7416002)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JdnixFvZYsx0bNtophEhBFEF/j1OslblV/PTggccQ4549QhyVWGErUF5BNf+?=
 =?us-ascii?Q?KpZCHkbd9eAKJxcMt//X3VTXdvS1uv2PIZFG2AgJmMcVPimHAZ4ep+xEFUTb?=
 =?us-ascii?Q?yxIQ+Dz7YqFEEtIEWbAnfFP8mk5qOOQjQ/scHpvLAnkJCGwJRGhpRfdCzhSb?=
 =?us-ascii?Q?8eNz8my0YgMP4AP0DlMg847Ul1c9m7bhHhlBFko76g3AFR/Nfm8FOzDvnscz?=
 =?us-ascii?Q?yWYiqFm85LMFbCK0Dx33Qdi3mtvXresOFN1b4W8gXhU6iSpsmviy4qA8eVDx?=
 =?us-ascii?Q?iHcXHjOSJZqUJwDBSBYhPf7Vm76wj9RpgX8B8FwNtcb7PlHYEjn373nF4Cj8?=
 =?us-ascii?Q?wjDRX9XE7kQhCWNX4l/rLDv9+ddYH/4SFU/pAK+LhpelpJzCcLuVl44inaB0?=
 =?us-ascii?Q?NpddMROkD/4PNLQaE9HeVQh8ixbYRuU1rNGy0hfs7Yg5vYRGWbuwfaWHqqK3?=
 =?us-ascii?Q?yrzGTvV4+w0+e+T3d/qRhEo+bdW1Riu8e8v0dp25Fclmmatg832ed/TN4a2S?=
 =?us-ascii?Q?LxCVyh7n77I5tDNe2k08Av6zxPdzVRByI28LqDXqQMM++LyD+D6NMCq/52Ag?=
 =?us-ascii?Q?7tZCfUJtnInt8cjpUbieDIrwnk7coxZ+8sSUnWp3K5yi8mI4cydbkdRF4g9f?=
 =?us-ascii?Q?jIrfsXdmoNTihPFqBL+LT7/pRy5XstDtp2uTP7x4h2CPmmD9Hv8scQvqH8gO?=
 =?us-ascii?Q?EERX7xvZYrq3/CvU5O632KOxpsb1KZga8VtE2YU4nLQQHD+UX5TSpfey7bon?=
 =?us-ascii?Q?75r+upUXj3T+UWksw55LlHd8D7UxapwLhpDMeamIAf8GrYlR1OdHrg7eVldn?=
 =?us-ascii?Q?hAeP+a2e+/dC3ey8b/dHnE1gLZ3o6trL7WWpKCZ7O5xKvf6uy/rGsZ3P4wb7?=
 =?us-ascii?Q?vfTJHhZApgIE7si9x8GJkIi9tdgNdbE2Auzn57ZPwmDMFiXBx7HSCzCS7QId?=
 =?us-ascii?Q?fSfy3yJWB1lSuppdzOwBnPcPgRS6P6aE2RDchHzFziJ3oID0opIRoQ1HIzaW?=
 =?us-ascii?Q?84ZBXW9eUulPxFkNZ4bRlNKgkEX7BqsJPeXEstX07LnwAZaperroT+Yt8M3I?=
 =?us-ascii?Q?T+Kb0YhblyGWDh66OYAN3iOr2Wkbiij6ZWiAOwrjoOxD3LJIlDhqjXJwrsN9?=
 =?us-ascii?Q?dkWzQYFmKfS2jAaltPB/Gpv8ZlfmjdCPXl0WixepN3rx1bHK9mUM/1TitX8B?=
 =?us-ascii?Q?UTRKqbnmCcw66ZVKK0kR0U0R9gJn2GVUMOdNHJeGeRLW2eihyAnZlQvGi3ff?=
 =?us-ascii?Q?bJt/+WhQYRI9Wkvoam2zV0sUXYpBe77KcsMCmf8hNlyolkQzN8d3HS8rm2bH?=
 =?us-ascii?Q?4VnRQFep7EkSISnoRNForOn/I88Dhco0JNiub9yxoXWpOPVVi89QoPY16oK/?=
 =?us-ascii?Q?K0yWAU1WTOKPlICesZdfGYxY57F0tJVlu5Um4oPmmREiYJMojJsw/XRI/+2e?=
 =?us-ascii?Q?HS3m3C2qKz8gQPhroq5cMPR7jMLavHwPl4/nbhhMtd9LdRgZaHQnH8nN5FaL?=
 =?us-ascii?Q?eQbRA8QvRkjPh0QPIb5LG7WRN+hEJduygk4UbDRo9FuexGjwtM4lOFIQ7aVw?=
 =?us-ascii?Q?dCgOvYY+VHliXYjHIdAQj8vKktpJrZJPTjKTmNwQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca585f2a-b507-452f-4324-08da5d595aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 01:05:58.4495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6FqmtjNIUIfgyRvv/4QIC1/IBaZO9xTONyGS1RJkYNk/NXxtBU7JNRtKkqtNkmsCZI8YkfH8G0WhVp7l67JQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8217
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> Subject: RE: [PATCH V4 3/7] clk: export of_clk_bulk_get_all
[Peng Fan]=20

I am going to make a new version of this patchset. Please kindly
a Yes or No with this patch.

Thanks,
Peng.

>=20
> Stephen,
>=20
> > Subject: [PATCH V4 3/7] clk: export of_clk_bulk_get_all
>=20
> Are you fine with this patch?
> Patch 4 "soc: imx: add i.MX93 SRC power domain driver"
> depends on this patch, if you are not happy with patch 3, I still have ti=
me to
> rework patch 4.
>=20
> Thanks,
> Peng.
>=20
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Export of_clk_bulk_get_all, so drivers could use this API.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/clk-bulk.c | 3 ++-
> >  include/linux/clk.h    | 2 ++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c index
> > e9e16425c739..470155856b02 100644
> > --- a/drivers/clk/clk-bulk.c
> > +++ b/drivers/clk/clk-bulk.c
> > @@ -43,7 +43,7 @@ static int __must_check of_clk_bulk_get(struct
> > device_node *np, int num_clks,
> >  	return ret;
> >  }
> >
> > -static int __must_check of_clk_bulk_get_all(struct device_node *np,
> > +int __must_check of_clk_bulk_get_all(struct device_node *np,
> >  					    struct clk_bulk_data **clks)  {
> >  	struct clk_bulk_data *clk_bulk;
> > @@ -68,6 +68,7 @@ static int __must_check of_clk_bulk_get_all(struct
> > device_node *np,
> >
> >  	return num_clks;
> >  }
> > +EXPORT_SYMBOL_GPL(of_clk_bulk_get_all);
> >
> >  void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)  { diff
> > --git a/include/linux/clk.h b/include/linux/clk.h index
> > 39faa54efe88..ca74f4e83d25
> > 100644
> > --- a/include/linux/clk.h
> > +++ b/include/linux/clk.h
> > @@ -372,6 +372,8 @@ int __must_check clk_bulk_get(struct device *dev,
> > int num_clks,  int __must_check clk_bulk_get_all(struct device *dev,
> >  				  struct clk_bulk_data **clks);
> >
> > +int __must_check of_clk_bulk_get_all(struct device_node *np,
> > +				     struct clk_bulk_data **clks);
> >  /**
> >   * clk_bulk_get_optional - lookup and obtain a number of references
> > to clock producer
> >   * @dev: device for clock "consumer"
> > --
> > 2.25.1

