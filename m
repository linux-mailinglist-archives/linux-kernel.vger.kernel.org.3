Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C04AF08E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiBIMBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiBIMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:01:07 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE52FC001F74;
        Wed,  9 Feb 2022 03:54:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoO1VvbsTPlpIcB1vDEHrIgY55M1ewBXDV0oAOa1mdFcyXUC0bzYJjuVtF8LpEmsRUDLGj2sNgCUtR36zZPSBEScdfY1h2+OZCNrZE3CzHZfmnkoDVn6W7FuTb1RrATltwVo/8yAleV7G/+1UoGyn9CtjTxyBsB/hP0aDPiS03jZT7lwXdtTimS4mTVEZnb1J++umcJBOfz3drYi/DB7Eyu+7VAzjQWi3FB7OLUORk+46XRg+aDwjrFy6AWjuM4EIhqTH2zYt/dBi/MMGuXuhjDzJ9pa7Srs7CB1IMcznfO+02D/TgBdHxf94PC+oDkcBBcE8XFTz6PCj+HX7Jkl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ke+sCCh6Ent23H/RxUVFKDNU2S/FK8FsBS+dbUJQ/4=;
 b=ZDOrdtXaxTPGZdN8Gy6ej6AQem6pZi57inqjJmz0SN/+swUP1Agk+/tORRGRWxCpEkqSZWB36WGpZZaLbaAfPLjVhgSo8UdKozOKj7fidaFyjoju5Noco7LroOMAru/yFrUb2lUsW30S150vQOFrL4vGXJLqvrxaPHx0+19j+lVDVPaxpSDou1+Comw9BDE1aOhjO7I243qsHJ4DuqQ3UWVFObvsOxCBSYb/sMmduS6aoJk4ykS3SNKsMx2tpf4OvcWqEUMtQKaajTcDNwUjLYJOvl372vIVIm/zgYo71BJ9PX/yLrod+6lKkXxU2HB/3pi4riy/MTk99uc0xT68cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ke+sCCh6Ent23H/RxUVFKDNU2S/FK8FsBS+dbUJQ/4=;
 b=SeExwq6ndt5YxV1qmeYYScC28qyvDpE6QqdOv2hKLm6CtjKeaEzGtapIbT9Wg/gsjhi0f86xxypkYH/ato6pXY+NIBirVsG+Dw6owRwaplpwUfisuF26k6jT2YeSdBjp42m3u50PnPk/T0xFHBCpD8aMiU4et9UdAEaH15SBE5M=
Received: from AM9PR04MB8555.eurprd04.prod.outlook.com (2603:10a6:20b:436::16)
 by DB8PR04MB5867.eurprd04.prod.outlook.com (2603:10a6:10:ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 11:54:35 +0000
Received: from AM9PR04MB8555.eurprd04.prod.outlook.com
 ([fe80::5df9:5bf0:7ac1:a793]) by AM9PR04MB8555.eurprd04.prod.outlook.com
 ([fe80::5df9:5bf0:7ac1:a793%9]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 11:54:35 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 devicetree] Revert "arm64: dts: freescale: Fix
 'interrupt-map' parent address cells"
Thread-Topic: [PATCH v2 devicetree] Revert "arm64: dts: freescale: Fix
 'interrupt-map' parent address cells"
Thread-Index: AQHYHavOPbZu9PMKMUmW4tdJWP+49w==
Date:   Wed, 9 Feb 2022 11:54:35 +0000
Message-ID: <20220209115434.7ej5btlnbe5wbyz2@skbuf>
References: <20211214135852.2934670-1-vladimir.oltean@nxp.com>
 <20211231181350.qwfnrwvdfnfssdjt@skbuf>
 <c5b9cec617100b891b7fceaee8655ba8@kernel.org> <20220103113043.GA14690@dragon>
In-Reply-To: <20220103113043.GA14690@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9c01952-b3a4-4d34-2ae1-08d9ebc2f170
x-ms-traffictypediagnostic: DB8PR04MB5867:EE_
x-microsoft-antispam-prvs: <DB8PR04MB58675AB63918E8FEE4BD35DCE02E9@DB8PR04MB5867.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGN2QwC3RNMqIgIxNlXQ5KHJi3cFvJIKJ2mlZtMm5MroX/Ev683Sa+HKegdtV3/2vT2rg1DvX4fxssEZn0kA32GEOl6OiygDcIeo1H6WIVQ38+aE3M7Rya5Cz8NKRkTv//e2ChBFJdhKqHdq96mxDqeoJ8q1IqBOM5Reys6E7nQ0VSGmM95ihb9tyiS4/D18Grhrj/bcNFtdC/K+7BJ0PdKePipT4OD54DGv0gFSqMUkAWVZYdJV+hbIja3z2xDNJfxpsQSZAzTUeykf7iHcFjFVN42xhH87SriYtisuDPTzVlBr+lLR5Kmh3xFFDgufqmggrhch7ZbBFXFiVcPz7dK5QeCCCGYAOi5WAUk0AdVaT3Erk1I9jmJw+Ub6HRIgg7CkGX/Q9PElGyVJDRqk1NfXlmh+0RwylXPGcmXTOMZCNr6vdNFAc3FbwqHjeiwCB7O90QOCtvqgfqLDvk4HHns3ehlL9m1+jn1YcD2Ph3aLs41y8heBl5Rxit9wJ9aG6cMhRu24Z2zewDWzWaYBflIj9mctgaKEClFeX4wEdPIhw7k6kosygrAueJmDeULhwdADZWJLMMJD+HVQKznjU1gkPJo6nciNmzDBXgEPLkcdZzihlC8g7eLs4EkjpazYDtDtHSiIXdxjnXP5tUS95y39lZAJbNv1KaRifI8TFMhSIoC6A2bdP70B+Q0XE1Dw4mx8bgMlIJJQvVR9qFdT1sYYDjgxtCCK4XmSLTFIBqFeqSYNvUmsAduMfOugrS5cvFBVXDfTn/GZj7+EeMb9ZRb5ML4TWiUbYlvqfQRclClp3i28xK1yoWR5a5DzT6Aj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(26005)(186003)(38070700005)(966005)(2906002)(6486002)(508600001)(33716001)(122000001)(38100700002)(4001150100001)(1076003)(44832011)(53546011)(316002)(54906003)(9686003)(6512007)(86362001)(6506007)(8936002)(5660300002)(83380400001)(91956017)(71200400001)(66946007)(64756008)(66476007)(76116006)(66556008)(4326008)(8676002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iv8ltNfqD7p/IHjBnxE4MVc9jXp0xB5mdxGea2sasnjYlTZOnXGMgBv4wi9L?=
 =?us-ascii?Q?TiFBAwaRkFe1gRANmsUtSPU1w0DJpfkGE8Bc/imB70S7F82U4PFaWvTb6FD2?=
 =?us-ascii?Q?s424MBsGsDv++BmldsHBuW0bS/IliKlT4xb6S4jXpx0z4tt5hBufFOQepWRU?=
 =?us-ascii?Q?BdaL8slqQY/rgLTjpg0/haz8HBc6MxZV9cVVIW43WPWlTUvexL24O4dfY0dr?=
 =?us-ascii?Q?6hhS0FO8K24158Mro9P6sNg/hM6Z7cBb8YEhRTCrZJn6aA2vULvQ0+M8iqED?=
 =?us-ascii?Q?3LAH2A2jb7kZFFx2mybhshq3dt4qy3iGIcsh3wW7/EGW3Kr/bngIWaOVQIGc?=
 =?us-ascii?Q?SWpHJFE3DNPv7nUnOrfvFLnh+ZOTuSavjuWxpiPUOTTUM4TV/nlBcR2CAxSD?=
 =?us-ascii?Q?6bZuB2jDZ7bcyZN/clNnSHADi/LbRhNi+Ar14PcWa1S+5TlPS7a2dDSzAKs8?=
 =?us-ascii?Q?GQp0FSif//MSRd+5xDV+WjFw67ZJfHWrISWYuRy4OdSch0gJvvnzaP8Ax3wO?=
 =?us-ascii?Q?pj3bvmoso1s2QtE67BHXOm1A52srpIX05dFfbC0YBWF/MqUv/8eaBKI6IErR?=
 =?us-ascii?Q?y7maDKAQ/rX3HKrp0+VWv+HgGiky1OhK/U9RSncPY4KYj3CI9RGJu581xRu1?=
 =?us-ascii?Q?dMt1yxAvat3TH7fiwrMmiZcgA9sv08fEwpa/hdh5Swvv34IcqWiwwN2Kzoe/?=
 =?us-ascii?Q?daYGtE16+wTi/IhhQxmUt7rV30pO1Kp7CdgJE4g+MVKr20iyZlD01e971aeb?=
 =?us-ascii?Q?Dt6D80nBuRpCO8BRSoBRI+g/tObO03rJtvjC/bSIExW0IN8PMYu4EuVY5Nnm?=
 =?us-ascii?Q?NctcLhXw6lmfZ7hyhgyk0T+08hn2Mlu9DCmW2Xft9pO5/C4n58zMGFvYGCSY?=
 =?us-ascii?Q?e3mCVoYnJn11IgDXTZ9gncCPrVJu97EWBYOJguOBh/lt4vbUvUalZEor7Dk/?=
 =?us-ascii?Q?9cmHrtDrW79GN3SvQIn/xHvkbU6KiHchUyDvA3iij2E1HJf87gjqSzKJ2Km0?=
 =?us-ascii?Q?vEMY3lbwNQ1u0hkuPej2Fduut9Rv0y52n2PYhFmXdVMBgUtI6AtOMdAOcpPk?=
 =?us-ascii?Q?Gytpva84RQnyD3t8+xBTjTtMqksi9hxz2wuzFTKhVw2BRoobxONRMpoBg7rs?=
 =?us-ascii?Q?xxe60kj+HkYNQNzI4GzStOfJ/lXbBLwp0LJ6L91v5MU/6IifPJimfvj/SVaT?=
 =?us-ascii?Q?S7vm3+zKCxlo2M7jINtVvNI8Fg7uQq+ZP1U8Mmm3Qj3xATJVk71yy5pUtGJa?=
 =?us-ascii?Q?ocay6/51vz5BXhHku9c/O/VSITjsFun/0mPK0KO0QGTpoPp8aVAjDkWUcfAa?=
 =?us-ascii?Q?ha4ivSx2VVtWQ7E6p5OXq0bXwc/4zGhC8nNqXTyHSUMAjzjBER+XaPJ2KZET?=
 =?us-ascii?Q?WtIJqWiGTdFylYitB6M7X8LM/k1c9Nf2dA57jVFvsg6eDCmEUciTYyEN7fx1?=
 =?us-ascii?Q?macNLeaMjlbJQaAo8549DPXNINn08zrZncilUYiRtAvZVxMzJ+rZbPXtnIIP?=
 =?us-ascii?Q?ehpzws6T2TG5+Vsl7iFZRGaeeuohxlk1wEC0H7Yaq1xog/WsasPvwY0SCtMs?=
 =?us-ascii?Q?fG+6hpNJZ+k09DF59rAAlwtiqpgO4tkZl5DGEOYrE0jS6Rs6ee3olI63i96m?=
 =?us-ascii?Q?TnLyXvIQ0fTGBfvc/eGvbM4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C069321DF29084D93A6439C93D596F8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c01952-b3a4-4d34-2ae1-08d9ebc2f170
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 11:54:35.5228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c48eZaqz3AJ15hjd0jUN+lrkw3WlxcrQtP60pOu/pLCIFbTC9e7I9SK577PGUZSPrb22mow/y+P7zWhSIeIujw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5867
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 07:30:44PM +0800, Shawn Guo wrote:
> On Sun, Jan 02, 2022 at 01:08:28PM +0000, Marc Zyngier wrote:
> > On 2021-12-31 18:13, Vladimir Oltean wrote:
> > > Hello,
> > >=20
> > > On Tue, Dec 14, 2021 at 03:58:52PM +0200, Vladimir Oltean wrote:
> > > > This reverts commit 869f0ec048dc8fd88c0b2003373bd985795179fb. That
> > > > updated the expected device tree binding format for the ls-extirq
> > > > driver, without also updating the parsing code (ls_extirq_parse_map=
)
> > > > to the new format.
> > > >=20
> > > > The context is that the ls-extirq driver uses the standard
> > > > "interrupt-map" OF property in a non-standard way, as suggested by
> > > > Rob Herring during review:
> > > > https://lore.kernel.org/lkml/20190927161118.GA19333@bogus/
> > > >=20
> > > > This has turned out to be problematic, as Marc Zyngier discovered
> > > > through commit 041284181226 ("of/irq: Allow matching of an
> > > > interrupt-map
> > > > local to an interrupt controller"), later fixed through commit
> > > > de4adddcbcc2 ("of/irq: Add a quirk for controllers with their own
> > > > definition of interrupt-map"). Marc's position, expressed on multip=
le
> > > > opportunities, is that:
> > > >=20
> > > > (a) [ making private use of the reserved "interrupt-map" name in a
> > > >     driver ] "is wrong, by the very letter of what an interrupt-map
> > > >     means. If the interrupt map points to an interrupt controller,
> > > >     that's the target for the interrupt."
> > > > https://lore.kernel.org/lkml/87k0g8jlmg.wl-maz@kernel.org/
> > > >=20
> > > > (b) [ updating the driver's bindings to accept a non-reserved name =
for
> > > >     this property, as an alternative, is ] "is totally pointless.
> > > > These
> > > >     machines have been in the wild for years, and existing DTs will=
 be
> > > >     there *forever*."
> > > > https://lore.kernel.org/lkml/87ilvrk1r0.wl-maz@kernel.org/
> > > >=20
> > > > Considering the above, the Linux kernel has quirks in place to deal
> > > > with
> > > > the ls-extirq's non-standard use of the "interrupt-map". These quir=
ks
> > > > may be needed in other operating systems that consume this device
> > > > tree,
> > > > yet this is seen as the only viable solution.
> > > >=20
> > > > Therefore, the premise of the patch being reverted here is invalid.
> > > > It doesn't matter whether the driver, in its non-standard use of th=
e
> > > > property, complies to the standard format or not, since this proper=
ty
> > > > isn't expected to be used for interrupt translation by the core.
> > > >=20
> > > > This change restores LS1088A, LS2088A/LS2085A and LX2160A to their
> > > > previous bindings, which allows these systems to continue to use
> > > > external interrupt lines with the correct polarity.
> > > >=20
> > > > Fixes: 869f0ec048dc ("arm64: dts: freescale: Fix 'interrupt-map'
> > > > parent address cells")
> > > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > > ---
> > > > v1->v2: remove the other 9 patches that rename "interrupt-map" to
> > > >         "fsl,extirq-map", at Marc's suggestion.
> > >=20
> > > Could this patch be considered for merging in v5.16? The problem is
> > > going to be quite a bit more severe and tricky to fix otherwise. Than=
ks.
> >=20
> > FWIW:
> >=20
> > Acked-by: Marc Zyngier <maz@kernel.org>
> >=20
> > Rob, Shawn, can you please queue this as an urgent fix for 5.16?
>=20
> I would rather leave this to Rob, as I haven't heard anything from him
> on this reverting (on his commit).
>=20

Could this patch be queued up as a fix for v5.16 and v5.17?

Ioana

