Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A434AC28F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443169AbiBGPKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391650AbiBGOyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:54:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15B9C0401C1;
        Mon,  7 Feb 2022 06:54:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6rkVI+9rRe+3/KsjWl0/e6LbNOBgdQqX40hcrfAA3ZSE/OJs45cetV9OF3cwLFdz9uxQFz2AJPMQd6YLgz9cSTNg9nBiNXF5AoU0KKCuRrOhu636HSvTWJgfqdMnkyYvx0IUaTngOzb6eP+BtW2vhcQSjlCQi28gS6xP6s69fAnEJMMYYFSszR1aFOE4WkFO60EWY8U62344UD+z3dAIy0Al55WAbU+lbWRItu1XoPGsF1RrrOKcG2IcMWIZyEqdtNJn/abMVO7jc50r4tzGa1RrWJZKoJ3OHKmxrVramBtv0ObMuqv67au4iCnn9jihqRAkHpxRqCPeRwZ/S0sbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/EsQ2Z706JUUyg+l9K94heo5JrbW6AY6MQTaL3hGZQ=;
 b=nXpwW8DF6VH1Yxc1qjPOhUezHvROfqH5XJAwxru+4guSMRaaFd3YSQXkLbS6A378IX53Tq3pSgSmwrJ2GsjMhWzsE321sQp/QLlRTGtkBk48ndLbvh345JIgI4Cfhx3SOwy3dsw0BzQrz9tUUxohtlkOA+xWR8IdK7b0gKq1Dss6ruPAkccisqzifILoqvMb5cOCHQWBMRvJLiZJ85qzkf/gSyAeAhSEk0MXOg1soee1w397oIbSXHZWsen9Y9CPhEtaqg/P1Cxi5QLci1RCIKeddYQol4anviCg9tInP+d2+TkhnpnynJr66xdgmXoy+Q9RnFo+FNolMrkoOqNuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/EsQ2Z706JUUyg+l9K94heo5JrbW6AY6MQTaL3hGZQ=;
 b=aHMS4sJTYa98k91P4rQHXz45noGdwfA5YKw5fidiE14JSNOPwqhI+PqrXpHivJlVvFhyr0MGOXDGNmBsag9TUcecjobHOMKK7MQbkjvIzFgtmZFoWl+T0X/gJwHyzBrWGes98qmMIE6QAtaGL4xivNTWLhR+Sy8OpnuFHy+mZCVGHZDQ6tM44yqmzjUfjV36L5DXXR8/aQv65ByuLMRbjFUT2FVcLxfppSS7lwTUulAYyvJzFy7RVlIp+x+fvaXDglloNkj47EMiam0P8Shq4D+xMWj1wHVCVQzDd0ti8m0B1cVdYdGtd7AuqPAMfFz9nFeexa4IciR0q3XCxI4ybw==
Received: from DM6PR12MB3563.namprd12.prod.outlook.com (2603:10b6:5:11a::19)
 by MN2PR12MB4637.namprd12.prod.outlook.com (2603:10b6:208:3e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Mon, 7 Feb
 2022 14:54:00 +0000
Received: from DM6PR12MB3563.namprd12.prod.outlook.com
 ([fe80::5125:d2ad:cbef:fcd4]) by DM6PR12MB3563.namprd12.prod.outlook.com
 ([fe80::5125:d2ad:cbef:fcd4%7]) with mapi id 15.20.4909.019; Mon, 7 Feb 2022
 14:54:00 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Subject: RE: [PATCH 6/6] spi: tegra210-quad: combined sequence mode
Thread-Topic: [PATCH 6/6] spi: tegra210-quad: combined sequence mode
Thread-Index: AQHYGbI5hON+MFM3SE2C51fYICcN6ayDbjeAgATDdiA=
Date:   Mon, 7 Feb 2022 14:54:00 +0000
Message-ID: <DM6PR12MB35630A9020EC4B309D877086C32C9@DM6PR12MB3563.namprd12.prod.outlook.com>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
 <1643970576-31503-7-git-send-email-kyarlagadda@nvidia.com>
 <Yf0zkdS2nqHOZjMG@sirena.org.uk>
In-Reply-To: <Yf0zkdS2nqHOZjMG@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b652b184-cc3c-4139-0ba5-08d9ea49acf2
x-ms-traffictypediagnostic: MN2PR12MB4637:EE_
x-microsoft-antispam-prvs: <MN2PR12MB46377E2B3898948C2A6DF79DC32C9@MN2PR12MB4637.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jRf5PLPQOwRl17zMv90TEXo13DEA8QouWjY62ruw47QcxBf3eyorsORWmFsYn1v/njdJvs1ouBNG3fWb4bW4q/oURPBPkWL1sJHI3xwK/oJR/AbexKOIErjtq69AYLc1Q8RaFJIfP7J/rdKdv78BIrqkwI4iVn63bkIubQ9umm+kZ32bcBGI1UcQ8wCPtSOoBUNa/xe1JbdphQSVgA4665ARxEwHS9jq4QWIi2nYhWfbcKpFpySAbFhaYJNmew1b48BOcya86Zl3/bntXek2qlA1NfcVSoe+uXPayMbLUfXC/vst/jYWt/OiEm3hZrlIb/ZyuonFlMFLR7764CAz39eZiSjTnAplGjCiQ2jOVsXtj8XKvtuH56x+a8xbaKyEgdPjTuD/KnfiRIyg4gVl+bSSyzQAItsbqPIe84fO7JiaxhqhRO7SpaAMj6Jr0mSqyztM2ljZOIhvrWj6hAkz1fyvKdPMPMc1Sb/boWEmJl7McTmQjo4ebL670U1zCbL8l8JjbS9YK9iRwQU9SzbeIpgyCVchzksYiSzZm36u9ZN7Eh5cbyDKfaCSu/TP4SJiapHmA+2XHJ/tm8Nl9+5QhBat0R6qZhgB22G0MxWQadhHhUfOFSkUKjFWTwcV0pgmssO04fjb9HLfnFTjTN2Nxra0V4/YvEebo7NKrp1Q0na84kCYef3Us7dpei3HRsWGYs/KeMTU0ji046EsKHbE6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3563.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(38070700005)(6916009)(5660300002)(54906003)(52536014)(9686003)(316002)(186003)(26005)(83380400001)(53546011)(66476007)(66946007)(66556008)(64756008)(66446008)(76116006)(8936002)(8676002)(7696005)(6506007)(508600001)(122000001)(86362001)(33656002)(38100700002)(4326008)(55236004)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AdenHaSRwvGysu9/gID0iARI0ru8uFUB2Lnfc8cSztj6u6ijZ49orjEui/k4?=
 =?us-ascii?Q?V5VQSXcub08s8DLdpEEmp+sOHNik0QsWzUHE4Ai2d1iTy0TKESO/dNVDUnXy?=
 =?us-ascii?Q?2Ia0kQTvWMRq+ZvmztYJm6JtI+4aTPr5a7s88tiR2WDJ0pbUyIGhiZfxf0ND?=
 =?us-ascii?Q?DIAl+OvB7mralXceDdhSohiXyQUjlX5vitzlrgRYSaHh2gZ4Ln/vJhAuLuMd?=
 =?us-ascii?Q?k9ayOKqN3vUFbgWznUmyRR9fdyscMMOT55Rbs3HNnid0wWvKXfTA/Y5rG2sI?=
 =?us-ascii?Q?skT1bBZCTcxa+8CWOt6nYNCEbVC95lgUTfIBBiNMuHRyq0VVeehOqNKs+qrR?=
 =?us-ascii?Q?wkKk3T+9VVSKmjBHmW56GAKP32wq6tZcoHHS5aPUFxyJPW3WfuqRH8l2w7fj?=
 =?us-ascii?Q?sEOOFYvGUjc4ZKinsGd5n2wRXWpxWriV8Es2XL5I5sAABKS9fsjJuRVm5q01?=
 =?us-ascii?Q?TYfUfzNjBTCYzZ1DcoKfFnuk8yEaLiCUkHDyVUVvrxxH5RLkbAPRUXLooIiv?=
 =?us-ascii?Q?6URNAN4y2VkLcP1RKosbSV5F4aiOlWLqIr/gRblmznXP0QS428jKLYJHAkVt?=
 =?us-ascii?Q?aDltOTdXWbM6EUfNYYgWE+ilaULjTzqpRizXOBzAch4Kkd9pwga21u9urXy2?=
 =?us-ascii?Q?oUoseD8DSzsnxth850x81ljX89vXTH0jYCvTNB7VtTiLR9ZonWYmfQY8AIMU?=
 =?us-ascii?Q?r13biGYiTVAsbWXgJDed8XVr+zh+Yil0qhHRoL/FGE5hckhdg1ZHkQH4Wa4J?=
 =?us-ascii?Q?bm6TAA1Bfj65MQb7PLK1fhmOSZ1DU9/MFbSoX0LZvbj1eLfJ6lbva4ZqUyEV?=
 =?us-ascii?Q?cj2p8Ll6lnpJne93OsT1fGZ/I9t0FO4fjXsF6xEDF18w0z2F5TimqoOrD7l3?=
 =?us-ascii?Q?Tg0+gn2brMcXrL3KzL/YIcnVbK4UamdHSUaAJWMc9fgiEkbuClSJuIcmcuBI?=
 =?us-ascii?Q?Q7NqJaVF9866+cjPQaQsSof0dXkKpAKHe546mmb+rrhdC77jRrdT9K+xyYix?=
 =?us-ascii?Q?nmrv+vgSAtXC1z+k+XfxHb6sfR4WobU7v+pmdDEtYcNmGX03obt5ZAu9frUf?=
 =?us-ascii?Q?HgyhEfn3dkXhzznoHU3kJKCqdiOUlYdkPKqI7SsQH850LQD1Q1Tuo9+eO4Dl?=
 =?us-ascii?Q?MO8boCMqY/jEXQ/syn2mz7skMbiVqxf26brHCFnGT5YaAArkAWh+ZA/u9n/M?=
 =?us-ascii?Q?TQ1OvPbup7VVULU06r5oe+MGYT7eC7OYiHMxX+rLcJqHZPkwLmfDrklTWybv?=
 =?us-ascii?Q?M1eCWVsR3Iyt6nboqLBu0HCyzo1gDBFZSZovnnI8z+ce3AVK0dmPoOIWB9aA?=
 =?us-ascii?Q?3Vn8GI56BJEKeS9SmxTbKiMzvlmbgMciW7lf2icb+XfFC3B5UgeuHV7nuNja?=
 =?us-ascii?Q?A1UnoNpz9SpwzgvVbDepvFlExYOByXKaHNQIDK38F4LUxawFaP3v++c/2Im7?=
 =?us-ascii?Q?8dcM57c9bQyEWeO82VUC5j2iGkNvgQ1DRdg1WtZgG2DTqGk6dg3xAnry4kYd?=
 =?us-ascii?Q?MgqAK0YMJ0FSN3wEu33cSDZFNDW2ENcMkoqjjQBOKwwfnbHTEIiZgl4Y0NKL?=
 =?us-ascii?Q?ptEWHzzzf7ILYk1pJJ5SBB/4hvYe/BQWIAGTCS9mkXn+7YKD7eCLg6CddPki?=
 =?us-ascii?Q?kVYCcEROxDgvnBxlxufT/mE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3563.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b652b184-cc3c-4139-0ba5-08d9ea49acf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 14:54:00.3910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zy+nxxLp+UvpsfBTOLqR0LGmNCXGezG4jvDRLEoJObFltey6ZtnCkHaEHF+ryS82TkBlR4ezjvXezx2CIw8EIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4637
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: 04 February 2022 19:39
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>;
> linux-spi@vger.kernel.org; linux-tegra@vger.kernel.org; Sowjanya Komatine=
ni
> <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>;
> robh+dt@kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; p.zabel@pengutronix.de
> Subject: Re: [PATCH 6/6] spi: tegra210-quad: combined sequence mode
>=20
> On Fri, Feb 04, 2022 at 03:59:36PM +0530, Krishna Yarlagadda wrote:
>=20
> > +	/* Process individual transfer list */
> > +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> > +		if (transfer_phase =3D=3D CMD_TRANSFER) {
>=20
> > +		} else if (transfer_phase =3D=3D ADDR_TRANSFER) {
>=20
> > +		} else {
>=20
> Looks like you're writing a switch statement here...
Yes. This can be switch statement.
>=20
> > +			/* X1 SDR mode */
> > +			cmd_config =3D tegra_qspi_cmd_config(false, 0,
> > +							   xfer->len);
> > +			cmd_value =3D *((const u8 *)(xfer->tx_buf));
> > +
> > +			len =3D xfer->len;
>=20
> > +			/* X1 SDR mode */
> > +			addr_config =3D tegra_qspi_addr_config(false, 0,
> > +							     xfer->len);
> > +			address_value =3D *((const u32 *)(xfer->tx_buf));
>=20
> > +			/* Program Command, Address value in register */
> > +			tegra_qspi_writel(tqspi, cmd_value,
> QSPI_CMB_SEQ_CMD);
> > +			tegra_qspi_writel(tqspi, address_value,
> > +					  QSPI_CMB_SEQ_ADDR);
> > +			/* Program Command and Address config in register
> */
> > +			tegra_qspi_writel(tqspi, cmd_config,
> > +					  QSPI_CMB_SEQ_CMD_CFG);
> > +			tegra_qspi_writel(tqspi, addr_config,
> > +					  QSPI_CMB_SEQ_ADDR_CFG);
>=20
> It looks like the command and address have to be specific lengths?  If th=
at's the
> case then
Cmd  and address are configurable to a limit. Will add min and max check.
>=20
> > +	if (cdata->is_cmb_xfer && transfer_count =3D=3D 3)
> > +		ret =3D tegra_qspi_combined_seq_xfer(tqspi, msg);
> > +	else
> > +		ret =3D tegra_qspi_non_combined_seq_xfer(tqspi, msg);
>=20
> This check needs to be more specific.  But like I said in reply to the bi=
nding
> patch I don't see why we can't just pattern match on the data without req=
uiring
> a property here, we'd need to check that the message is suitable no matte=
r
> what.
There is no real-world use case we encountered so far preventing us stick t=
o pattern.
But this was to avoid any corner case where there could be 3 different tran=
sfers sent in single msg.
