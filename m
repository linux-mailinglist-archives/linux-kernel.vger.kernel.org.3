Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7A75A459F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiH2JC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiH2JCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:02:18 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128859278
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661763736; x=1693299736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sXvqC3NC0iezobq4/14TZ5yg0pzb4d7u51pWrLSx6MU=;
  b=Qj7kwVpPNL/OORsdNvZJGUFFmqZkU3KYhkN/NNzA5R5Z5Jf2bSi0FEYn
   7X3KZRByp+hd6OmeFK0uLrVOAin56UJIJV8Wltnm1A62AOe8+a6y1JVp9
   MAKmNUDSP5cP4hwp8ffHYzS4kDB6pgsyHqHPQXcyPev9H3kHYlIoafGTV
   oPvYBDXvtR99GmEQ4p8evNpVNRLEVlk30p4/h2dWRnmmn5GxldI/nq7zw
   9xoiI5uvVT2DE5a7dgVayNwPmLKWvJeepcoozSC5XMHZ6KemDVJxFW5df
   E0c4cmb4FCj5dKzgJOruhOf22id23oWlY8WzNNNxvBPPlvivxIRpnbaUw
   g==;
X-IronPort-AV: E=Sophos;i="5.93,272,1654531200"; 
   d="scan'208";a="314195071"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2022 17:02:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5evPOM01Rkl7SVho2tIERB0JKB2S2GbqthP+hvhpY1rSinJeJdN85eUph6QSP3Ci0raT1tlodg/BbOvfOqhpVLcqig6TgJ7TK0xZWraTBdmP3vtD+xrN3DoYQd043UQntA/S9R8uSPOMOkQlQUnKvCjl4sfsYKNjv9cuzGQAYMiH3OXOvFJIoFZ/0mxrT9/4NQcgHGo3KDUZfHvmiPkURA57nfcId3jrJhKhaL6BuykdYQ4fZKgXr++VvzI9SIl1EIXopNBoR1etpWLmsM+bR5oJo+GdAgG7n8gSNFxgAyYG6+SDqCb0I2Iy1z1abn0YRrJeOJc65wFUhS7UKb8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXvqC3NC0iezobq4/14TZ5yg0pzb4d7u51pWrLSx6MU=;
 b=JxIUVBCHysKU0+BcmORHx9AJ1Rh9R5XBECUGET6N/RHAqYFh51QEVUH40GbImn3fVnv23sc0g01PcBHOCv3qEdNzUYG93X4jzATlpsFhpSJvoJbmtm65D7DVxR84Jrz69Do3Nam8eZe58tFcrolRciQK/BedlioW8mQjNetFjUWtn8YuYjdNwug5F1tphXsk87oVbpFwFqt0jecSE1mI4IZpl6ctm3ONfuakE1GbU4XzSxL7xBzp0Yo+OKkkZr2N47nVdOTDcwOJm24SrCktzzZyX/jKptE1B8X7pHpNHoMu+BMsg44DcLSQe1t6sOHNdG6DkEqPUPWqv/xs5AHlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXvqC3NC0iezobq4/14TZ5yg0pzb4d7u51pWrLSx6MU=;
 b=aL+DD3/yKACAA5FzyHc6gZba1v4ZaEKFLrA0wv5VSBWRQdITRbhYSckclKukzGSuoREspqCKWJ13GkTl/Wkq21Y8vCLmqMs/7xw/dvSCajR7KRdvHSeK4QeV8hwB71KWyMWRM2Ljk/9uLdqIOcj4FQWWpE/+fzc0DDnMl7qeHwA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB4844.namprd04.prod.outlook.com (2603:10b6:5:1f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Mon, 29 Aug 2022 09:02:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 09:02:12 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?iso-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: Remove broken reset
 support
Thread-Topic: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: Remove broken
 reset support
Thread-Index: AQHYu4HGRyRWgtKROkWypuXOBGqHXq3FlQkA
Date:   Mon, 29 Aug 2022 09:02:12 +0000
Message-ID: <20220829090212.vi3jgetghjp4dsga@shindev>
References: <20220829083046.15082-1-pali@kernel.org>
In-Reply-To: <20220829083046.15082-1-pali@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97079b49-ee37-40ed-db4f-08da899d29b7
x-ms-traffictypediagnostic: DM6PR04MB4844:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wLRE9NN6eS9G3dP/WGRkwCm793zOrExP6QuaKkBq+gVhG6WtZcc9Im2+sMrv6ABjcnLLl/zqW6Numlui3HYUChQyMeBTHPI3/zXjUHl+1Qaj4d9GUJapGhC/n/K1Ct+zAvLGZ364DHdTBin8NwhsBcLGzO4zZwlQDkRfp2qf5wgEFhS32+eyc2oNFhVTE83ghGpd2qGhltw/4YsSq9frdZjULf2i3zLJayBTYs/0r3z3/S0K3CLFABfXT3z+ykXbBMTUSaGmum9f6cNWbXkcsQ6gkV6CLanjk7MMWTeNISY79wd6UiIKWB1tDeydJnoP2nXyd7HoGtwoAhzYg/sYW4G3jcF0GVLODPxqwYNz0u0WzoNE7oFbSxWFi3elfqQ815rLIQBZoYIMePP0X0kalBLCYpZZHnlJwds+2pSgEE6oi+C/H4PPBZzo34T++C4MeTI08zmAwUq2jN3nah22j0Hr3Ul/ac0o26Y8SZmHrEQtyYIFhXFHXdQWbzvpx9EV7T6mOkwR2JqZ3YIr5V4Iuik5EZg8hXlZ22Aa607b4g/pkA++jnCtvZhSnPmBBIghXA66rF/Kr5GlEwsOjKQTsx+IygdyYYTCyK9jYpdFwsZ2qpf+sukHKXsr31LtyIzfwNT/1csrl+mxHKBzrMeaqjEWhG25FXAIlGcFU/WRv0TuuEgflyO+J7eSTbr4Oas6JhGNNRkslULI2avBHdCYNs0l9gpdiYqvOyJfYVIFod/VLUzIdWMptvsJCW353vAPLqlPpZSKP1hPsrIx3GEgn8Yl+vNRj71rZoKdStOK2SCTZ0sG/qSaW9ktOF+S66s7AACA3r7E3gAfFhX8ynnPzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(366004)(376002)(136003)(346002)(396003)(478600001)(41300700001)(33716001)(6512007)(91956017)(38070700005)(66476007)(9686003)(6916009)(54906003)(86362001)(8936002)(26005)(6486002)(966005)(316002)(82960400001)(5660300002)(66446008)(4326008)(64756008)(8676002)(76116006)(66946007)(6506007)(66556008)(1076003)(186003)(71200400001)(83380400001)(122000001)(66574015)(44832011)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?77OS0Clqm7BoXRYEXTkT/mRQgl0D1/mMrx14Lhm1bXoYLgVgz0yl4L3NTo?=
 =?iso-8859-1?Q?CTzD+D17RCG4xRGHvEwWdCczf+A/i4cU2F+c/RPlnVwmh/3VYSxL+BoeWq?=
 =?iso-8859-1?Q?EMLhbkkwNJCpTVceFUSqpM1cTFMEQ9dQVbfe2BlWOfjQDfOyBGo3Jt7LvU?=
 =?iso-8859-1?Q?p3TfqbsxkG+jorBgN4qTZvtlsbYeNHrhGlXo0Yr7SCgXaoQ6Qg1DkmPrCk?=
 =?iso-8859-1?Q?pwpJBtDWBbm6kQgvfDO4/OZRZbAXcYS0r821OcZ9Jlr+xCmq4MsAYrb4mj?=
 =?iso-8859-1?Q?MYv55ZHmTFE7trb3Tm5WGjfxIgMx9Jv2Y0IEkkQJSJ7IJf7ZYsV4ye8xHq?=
 =?iso-8859-1?Q?hE8YSvZvCfZ/yWJw7SGtNcGhEmNumpuFq6fWIgQ6dxNDV4h1YpdGU1Ogcy?=
 =?iso-8859-1?Q?vx13DYndF09BI5N3ZPNYHGW2AvkHavDbymRasL4q4w2pMTCTPzaCZCZqpg?=
 =?iso-8859-1?Q?wpPGnmAWF0VX2j3jjmRq4DpkZC//VbG6J6WyJbtSaSBcPSYQXP9IWo/zr2?=
 =?iso-8859-1?Q?ml3QfmYx3U8a/BsQRryd84RXhVajwSrJRUBCL24sRHsN8QuyAm+jXqugRg?=
 =?iso-8859-1?Q?m2YUS/3ADO7qCv5GCrZKKO5Acn6Z+gN28GYU1GeOeuV06MQqUir1L+WoBN?=
 =?iso-8859-1?Q?BWRdGQpNg6xtil4tIUcHgKX/Z+N3dxB4bZvzgrgnTQcUzEIJANz+4wZiCd?=
 =?iso-8859-1?Q?NEqAFttRXNfqPBmkhEaEMCC/tSvWzUOT0buzYd3tSe2NlIlQ3SDoOtiQgk?=
 =?iso-8859-1?Q?AEZeNy0i4MWlRSc20QBl9PcajRn7OQpTjO09aXlipZBFnjf6WutcyX//vU?=
 =?iso-8859-1?Q?R+EbGKmOwsq8FUmDDJrMZvvvwaKqZ9Mif+jRsRoLC6Gu7DblPsiEv0/KYa?=
 =?iso-8859-1?Q?nGyRBDm1de6JmjDP3k78fIwU9j+wmybYOCa/4vH7CpbUia/jLeLNA0kKCD?=
 =?iso-8859-1?Q?LHTZ4PZn4ufE96RccXFHzpv5/D2GRYOrh83cHq19cdQeoQCZ5TsVtQiFow?=
 =?iso-8859-1?Q?/GaA7Ae0O5XFkEUEotisg7/DfaijUX5HGjElSYR6cdETebKcc00dPwsohZ?=
 =?iso-8859-1?Q?zM9/w+bkBMjBisYOzU1dZpTkWSHN1mGLuof4mXP38flKyt50q9bQd225Rm?=
 =?iso-8859-1?Q?f5+HZDP+XXgfLsQJdbFe5G6E//DJSt2Ey812iWv9UyTNGeODoaZn47ldcv?=
 =?iso-8859-1?Q?xAJs7gfQJSc88q4q5cfHMBBJUAqn1v/SSL8HWZYv7Pcug+xtWwLyVxv3xj?=
 =?iso-8859-1?Q?qyZ+GXEimIAha2dwhZv/Tunz7IvwvOaMPW/8GjCElCh4CxgXK+c53lade2?=
 =?iso-8859-1?Q?ex6ug+9JMT5Wtg1SriC111P042++anQoZ64YdcTaL2Se5P6un/XplE3gw2?=
 =?iso-8859-1?Q?PbMZVXVW7lwuYIl3oiyA+nmWdUHTNPHgbAUMZixQcd3T0vprM5M1EWJ3XI?=
 =?iso-8859-1?Q?0Gzj0vM8eXYVuoTPGGThWl7D670RmvL5A2kVIVsReGzeEwTkVi+3pNm2wC?=
 =?iso-8859-1?Q?7eSlnArHMbrj2knOwIHu2ilsJBTEV2axCQ5VAkU7u4YP0Tj/EpksgfftlI?=
 =?iso-8859-1?Q?Av6k9Jy2sl6NumpAmEXmIeqNg8SmixFnF7gDWU4AAnOhQFe7gZlt/PEuF4?=
 =?iso-8859-1?Q?4H/mEs1aQmy9NPNErnEfQK4/arT5l3MUpDfYjcPPRP852lenWgPYujxjdw?=
 =?iso-8859-1?Q?wohTeVGHvO5qw+kOiHc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <24D466551A84AD46924836D2D71AADC3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97079b49-ee37-40ed-db4f-08da899d29b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 09:02:12.8663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m03+doDEsEsWWDLF/WNBeVpTmb4pXXwv0+UmnOuHaXt7cuClm+CyU8lAQ0dy+4gob33UMtsrOftHctazlyEthsdKv3XfV0ZQzIkvNtD+V4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4844
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 29, 2022 / 10:30, Pali Roh=E1r wrote:
> Reset support for SATA PHY is somehow broken and after calling it, kernel
> is not able to detect and initialize SATA disk Samsung SSD 850 EMT0 [1].
>=20
> Reset support was introduced in commit 934337080c6c ("phy: marvell:
> phy-mvebu-a3700-comphy: Add native kernel implementation") as part of
> complete rewrite of this driver. v1 patch series of that commit [2]=A0did
> not contain reset support and was tested that is working fine with
> Ethernet, SATA and USB PHYs without issues too.
>=20
> So for now remove broken reset support and change implementation of
> power_off callback to power off all functions on specified lane (and not
> only selected function) because during startup kernel does not know which
> function was selected and configured by bootloader. Same logic was used
> also in v1 patch series of that commit.
>=20
> This change fixes issues with initialization of SATA disk Samsung SSD 850
> and disk is working again, like before mentioned commit.
>=20
> Once problem with PHY reset callback is solved its functionality could be
> re-introduced. But for now it is unknown why it does not work.
>=20
> [1] - https://lore.kernel.org/r/20220531124159.3e4lgn2v462irbtz@shindev/
> [2] - https://lore.kernel.org/r/20211028184242.22105-1-kabel@kernel.org/
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 934337080c6c ("phy: marvell: phy-mvebu-a3700-comphy: Add native ke=
rnel implementation")
> Cc: stable@vger.kernel.org # v5.18+
> Signed-off-by: Pali Roh=E1r <pali@kernel.org>

Pali, thanks for your care. I confirmed that this patch avoids the error I
reported in the reference [1], and my SSD was detected on my espressobin bo=
ard.
Looks good.

Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Shin'ichiro Kawasaki=
