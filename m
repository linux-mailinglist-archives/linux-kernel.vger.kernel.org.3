Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8933B4822AC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 09:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbhLaIKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 03:10:48 -0500
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:26552 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229667AbhLaIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 03:10:47 -0500
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BV7uLmk032044;
        Fri, 31 Dec 2021 00:10:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=Yzxe3BdKFkx+eU5FX7l3TTBMLlYY3L/Xyz5+9SAIxL4=;
 b=mQ0XROxG0DiyT7vXlhSc4yEdC088t5+q1/UI+2oB7ii/iv2GF9Q587kHLGDW4m1Ghk/M
 /+BDP8DjaPJrN7okH9HzPt0YzEDZN5TthCQAapooQVobxveR9FJzMeGkejEhODyXvSbP
 ry4Dn7YjUtUh1L7652L6OotLBQViNiLM1sAz9ZQM4PfYbY9/oSSohs4BtdzH0NYiwwB4
 kew+U5fpC8We4mub9XQyc/872QxfWQx8Diuf6bq2EstLTU7SKaVzm62bmDbkfutwi8Lc
 J/N6kmZmhQ5D3dbUPoAcP5jrNInH7NlbQf/j78O+UIcAeSTT0gWPcTKRew9HLKsr9Fae KA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3d91q88fug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Dec 2021 00:10:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddAdABzOQaabtrCL5Cl2skK02k2ytJyAEHlVdDz9AslkEq6VwjxTJOR5Hs9oN1+eUsgE/5m6or+WZRt5qf/dyacPdi63nf4a0EEhJi6zZPi0I0FMD7dY5FjRz3vR3iGrWK+qrtSkE5SlEroiR5OmRPwgv8b41wllOSOcs7b155s26ccZQ9RT5iDEaL8TbK+Cat1EDqBvmTSYs1ElxJJ85XNg1JJztrd3inHZwU96fCQv1Oo7zmoxZKFoFPjqoxotwL6EfbZQNgE5L0hASmbpfKM86gYmQ2FeiqN761xtV3fseXK7SZE55pewHic1ZZ0n/QOLBKMtxh3SIUXueW1EMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzxe3BdKFkx+eU5FX7l3TTBMLlYY3L/Xyz5+9SAIxL4=;
 b=aZXerV0nIe2cCSQm/t9yxksBhJExocAKA2GLCFOwX4uHnE8FuJhm1hm/Gzww2GVpkKLvePx+Wag/JkU9rE9jY2TC4vVkEr6UhGY5sloGKU+MO9JMM0AXbM6MmkKW/lK/u/tjpTJFwmRG5keXN9xs3RML4cbVmijW/w3JfN/MZWHb+y34X5EGy9hNjZvxyfiVTKRoFMoBs0YjH7F2C4W/CXVT5m/vxwEyB537a7kdV/ZwHwMpanUIIy4rrKQ27oopfHjwNzPYlmBU1l9jg6ETBYQLxxrBuNtN9eCfHhUQccaIaZHFKsfh/LZXtODecqT6q08MZQr9hmJ9XBqVPnwymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzxe3BdKFkx+eU5FX7l3TTBMLlYY3L/Xyz5+9SAIxL4=;
 b=kM1rGfq9iUyaABA5+K5xl09Ri6829YHIsOizSVNIxTFJAsMkr8wXGu+2GARc0KeuSvwLybO+dhUPg5+HXTPTH+lKby1M9LhiVH4+LUR/7jNoXj5SSY5IOMJBtTZ4JZyfZtn1k0Ug6nmeli1A80k97e4x/AH7+fUrVjwtCDZHiQM=
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by PH7PR19MB5659.namprd19.prod.outlook.com (2603:10b6:510:13f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Fri, 31 Dec
 2021 08:10:16 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%7]) with mapi id 15.20.4844.014; Fri, 31 Dec 2021
 08:10:16 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [EXT] Re: [PATCH] Revert "phy: cadence-torrent: Do not configure
 SERDES if it's already configured"
Thread-Topic: [EXT] Re: [PATCH] Revert "phy: cadence-torrent: Do not configure
 SERDES if it's already configured"
Thread-Index: Adfigy5UG7A+JRfzRGOjQFvgL0E/BwVOokqAAAH7bcAADUvUgAGIhimw
Date:   Fri, 31 Dec 2021 08:10:15 +0000
Message-ID: <PH7PR19MB55620925B3986D5043C50969A0469@PH7PR19MB5562.namprd19.prod.outlook.com>
References: <CH2PR19MB4024BE31FB249744412071F6A0639@CH2PR19MB4024.namprd19.prod.outlook.com>
 <YcQIp3IJ0eki3hY2@matsya>
 <CH2PR19MB4024714657D84812E6F16A77A07E9@CH2PR19MB4024.namprd19.prod.outlook.com>
 <YcRvL85x9Q1dkvRn@matsya>
In-Reply-To: <YcRvL85x9Q1dkvRn@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0b1848e-608b-4c49-9507-08d9cc34fa74
x-ms-traffictypediagnostic: PH7PR19MB5659:EE_
x-microsoft-antispam-prvs: <PH7PR19MB5659DF76FABFFFA5AFD4356DA0469@PH7PR19MB5659.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqi/a7SQ8VtuJitUh77W90jQkoBU7chEptAIppMtuaW2raA2EboqcU91/UYf5Iy/D4gEhYea4Bojck3Gx/oameXDtk92RDTSXt+PTymWjdDxiPxPTMTTdDueBP6r6B8AwZGTEAjw2T65xnfnYU4IZKMVdqsNgjF0HF3qMPJ5FZJVjFhAoJRQmVFlEyBDeExekDkl+YiXrAOmt7soVRDPF6y6HoTIjbYHvoNxK4Tc8EUQM3xSX/yJaCm5dCrqBzqSipSaI9xgq70KNeZGPOAMZju9SMea88Loa25YPERydQEWcw4DdamiL8aoQNkplK8J1Zr6UkanfpIvVSuwHtasykkjMhZucWUlHsFAMrRiqR7gU6NjGe9EPI1FhTu6NUhynvc4o8FrZr8luewqjw3opIZDgGGqzu5tCF7z6ujUbSOSXSC3FyEl60SW2BvuY62Kd6Y8RFKQic4+i3uD6NA+TRlc0jWBBrbggKBVQd28kvlhHFiK/1r6EEZyj3IWG0io+CPVcFVq6LnCoGbjCp6ajSL3U3AHmpicFjrnd1eCc9szUWpm76pviNOmJUm7B/BYcK3IGh5SQ8prFdgisaNhW2azOgAa5hSaEsjQ4Oat7qOcrg6/jq60HRsjNdNYDLVJNkbZFTkA844oYGDAibAf/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(88996005)(6916009)(64756008)(9686003)(66446008)(7696005)(66556008)(8676002)(186003)(6506007)(54906003)(52536014)(66476007)(8936002)(53546011)(4326008)(66946007)(2906002)(55016003)(5660300002)(86362001)(316002)(38100700002)(26005)(33656002)(122000001)(83380400001)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RRw5ILTm/7ScIBjhmFTbQ/3zLkO1H8YYK92Nsmc03WawkKXAsqQ8D99yhvvS?=
 =?us-ascii?Q?CChvtfJ7bGbZJetNZAQOZ921YSMOZd/KVSwbKpHZomLKONJzXrhaqK86vfZm?=
 =?us-ascii?Q?skvcG/QC2tUNiElME3b7h2ObfdyqivSz5CpsPGAz7IQtPviNyh+Y9HxUk3de?=
 =?us-ascii?Q?DZojTq76RQXUZkG3RxUH8ilXLa7FZeTRFfbHDn+6ClOQFIBg5vlL6hreTc6B?=
 =?us-ascii?Q?KARm6pgHBe8Ih1DO6I0JxLuQanvhdE2QFMiVevWUw2qhUGvKJq3+H9zDgGEY?=
 =?us-ascii?Q?UR0G2c2NzbLXu7YaV8Nb0gXwTgp3Oraxyd60vwjG/jDAuVyABBlDmlzptkae?=
 =?us-ascii?Q?85Kr35XrcoWCn+OhZlrKY8WNdqWOV4ZHKjbiS2+VOj8aqI1bTKruK01yGjL8?=
 =?us-ascii?Q?xotXxqIYvfLumhqeNrH2nC/CKRZSYhK8OTt5LC0EGagPNhRudGX5I9hc4lBo?=
 =?us-ascii?Q?+XZcPnlHnV/37NuE7sPs8JWKbz4rCKNvg9DcN53EU63lGJ7YJH4HyQsJ3yYN?=
 =?us-ascii?Q?TQQBDLYbhozvuA55H1gHH7VCIp0QxyNQN4c/Hew8hssKbXr4yde08OmzTqZ2?=
 =?us-ascii?Q?BU1894T7rpNGcwlTAmAmsl8xufIcSEQI5xa/h8iR1FIcDISLPds6Q5O/hQUK?=
 =?us-ascii?Q?MYA1lQTnpphC7jISUB6PpnYaEWoAvH1kyLzzhofBf6I7zgz40N1HDLZxvkmY?=
 =?us-ascii?Q?CY4DXX0dHJTisb1x48gvPyJYlnytZnIj7+JjlVklal2CtDUrzRvUi+w/sP0m?=
 =?us-ascii?Q?wPgSKq+Bym0SIW5F5q4g7NAyB863gVkYYm78Z6k93oM8Z8zBCSQBypOZ1H6p?=
 =?us-ascii?Q?0+Y7z3xF4Y1b2UFMLtd6UCvw9FdBuwZ9MmdOCtSHT05ZNY4nBQ2uIzv65aZv?=
 =?us-ascii?Q?Tkyt+VHaT/EA3jdARvifys6i0kte5wgyCDZxFpuVHysWJpyW635rtOuVZum2?=
 =?us-ascii?Q?grq/QUB2k/0VmbnHBdMq7KZ9j+boAcH+SO/MSBaDzTmpXTo1DsUo/12zV3FY?=
 =?us-ascii?Q?E38w3iLLp5MhvirICJ7PanLYAZ6IJOE2n+nAkwPsAYKclSey+7upJBzni+cI?=
 =?us-ascii?Q?td6jHprDs79drifXwUe5ZjI835FF5OEk+N8IA5XWRmKg1rfQ7XimJWd4Z5Wd?=
 =?us-ascii?Q?/QbqLPHZBe7e0i2GYfUsLUw5QP6Lk+ZXLvmmypyIvwya9k31mC0c55KSFLev?=
 =?us-ascii?Q?Oa4Hj1cakgbyBiw6DsKH//Saks2EjXzWnLLmeGRPz0yK8JXPCaZjKD/w4Cpf?=
 =?us-ascii?Q?0c/Z4JoY3cWxXYHPJ12TojdZIDOYidNtwpTPwuqOVGhpdIF/773o+FYxqhJa?=
 =?us-ascii?Q?bP1r5IrUOha1VSpkNnqA0oGyErejUsZvPSVJ2NyOn5SlQ1GlBpepX63ZmRdM?=
 =?us-ascii?Q?92RcliZd2HQJ1Cwz6JTTYRbZ3scGVnwtSJf6JdDwqucq5NmNDP4VlfHBAPTP?=
 =?us-ascii?Q?JNBJnrzbCsFXnurITxLmYUF5is98cKp5h0jbsVbItXyR01901mseI6JCFVRp?=
 =?us-ascii?Q?YUuWyFYIfSjePK7kFk62Kzww8zZf+Gp0u1HjpUKfi77IL/BYFE6XNwDEYssM?=
 =?us-ascii?Q?eKZF0dlwcUufiZSgfa9iQuwiNMJkW70BwKKkLi8mARrRt7l/0FDC3mLm1jF4?=
 =?us-ascii?Q?gPTn3GBAlifWjEah3I+GsSU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b1848e-608b-4c49-9507-08d9cc34fa74
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2021 08:10:16.0539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tv+OHzbsc/kd9OO+cfVuNecasH3M8yb8zMmf4Oz/DkYHenb1NLY5q5e4eYnYpRR6GFkhjA0bgY9BGZe8T/uqUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5659
X-Proofpoint-ORIG-GUID: mTRMeaai6GO2RMXae_Y13yJKtazJoXI4
X-Proofpoint-GUID: mTRMeaai6GO2RMXae_Y13yJKtazJoXI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-31_03,2021-12-30_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112310037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vinod

> -----Original Message-----
> From: Vinod Koul [mailto:vkoul@kernel.org]
> Sent: Thursday, December 23, 2021 8:45 PM
> To: Li Chen
> Cc: Kishon Vijay Abraham I; Philipp Zabel; Swapnil Jakhade; linux-
> phy@lists.infradead.org; linux-kernel@vger.kernel.org; Dan Carpenter
> Subject: Re: [EXT] Re: [PATCH] Revert "phy: cadence-torrent: Do not confi=
gure
> SERDES if it's already configured"
>=20
> On 23-12-21, 06:27, Li Chen wrote:
> > Hi, Vinod
> >
> > > -----Original Message-----
> > > From: Vinod Koul [mailto:vkoul@kernel.org]
> > > Sent: Thursday, December 23, 2021 1:27 PM
> > > To: Li Chen
> > > Cc: Kishon Vijay Abraham I; Philipp Zabel; Swapnil Jakhade; linux-
> > > phy@lists.infradead.org; linux-kernel@vger.kernel.org; Dan Carpenter
> > > Subject: [EXT] Re: [PATCH] Revert "phy: cadence-torrent: Do not confi=
gure
> > > SERDES if it's already configured"
> > >
> > > On 26-11-21, 05:06, Li Chen wrote:
> > > > This reverts commit
> > > > b69d39f68419("phy: cadence-torrent: Do not configure SERDES if it's=
 already
> > > configured")
> > >
> > > space between commit id and open brace...
> > >
> > > >
> > > > our soc will hang on any regmap field read before reset.
> > >
> > > okay, in this case the right fix would be to keep track of reset in S=
W
> > > and still skip reset if it is already configured?
> > >
> >
> > I should be grateful if you would give me more details of reset in SW.
>=20
> Store the reset state in a driver variable reset and use that for
> finding already_configured rather than reading a hw value

Sorry for my late reply. From commit d44b4bf49e0b ("phy: cadence-torrent: G=
roup reset APIs and clock APIs "):
> No functional change intended. Group reset APIs and clock APIs in
preparation for adding support to skip configuration if the SERDES
is already configured by bootloader.

So, the already configured detection is to detect configured by bootload an=
d I cannot know its state without reading the hw value from linux driver, s=
o I don't think storing variable reset in sw inside linux driver is the rig=
ht way.

>=20
> >
> > > >
> > > > Signed-off-by: Li Chen <lchen@ambarella.com>
> > > > ---
> > > >  drivers/phy/cadence/phy-cadence-torrent.c | 31 +++++++------------=
----
> > > >  1 file changed, 9 insertions(+), 22 deletions(-)
> > > >
> > > > diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> > > b/drivers/phy/cadence/phy-cadence-torrent.c
> > > > index 415ace64adc5c..e57e0b1523aff 100644
> > > > --- a/drivers/phy/cadence/phy-cadence-torrent.c
> > > > +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> > > > @@ -2031,11 +2031,6 @@ static int cdns_torrent_noop_phy_on(struct p=
hy
> > > *phy)
> > > >  	return 0;
> > > >  }
> > > >
> > > > -static const struct phy_ops noop_ops =3D {
> > > > -	.power_on	=3D cdns_torrent_noop_phy_on,
> > > > -	.owner		=3D THIS_MODULE,
> > > > -};
> > > > -
> > > >  static
> > > >  int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy
> *cdns_phy)
> > > >  {
> > > > @@ -2282,7 +2277,6 @@ static int cdns_torrent_phy_probe(struct
> > > platform_device *pdev)
> > > >  	struct device_node *child;
> > > >  	int ret, subnodes, node =3D 0, i;
> > > >  	u32 total_num_lanes =3D 0;
> > > > -	int already_configured;
> > > >  	u8 init_dp_regmap =3D 0;
> > > >  	u32 phy_type;
> > > >
> > > > @@ -2321,20 +2315,16 @@ static int cdns_torrent_phy_probe(struct
> > > platform_device *pdev)
> > > >  	if (ret)
> > > >  		return ret;
> > > >
> > > > -	regmap_field_read(cdns_phy->phy_pma_cmn_ctrl_1,
> > > &already_configured);
> > > > -
> > > > -	if (!already_configured) {
> > > > -		ret =3D cdns_torrent_reset(cdns_phy);
> > > > -		if (ret)
> > > > -			goto clk_cleanup;
> > > > +	ret =3D cdns_torrent_reset(cdns_phy);
> > > > +	if (ret)
> > > > +		goto clk_cleanup;
> > > >
> > > > -		ret =3D cdns_torrent_clk(cdns_phy);
> > > > -		if (ret)
> > > > -			goto clk_cleanup;
> > > > +	ret =3D cdns_torrent_clk(cdns_phy);
> > > > +	if (ret)
> > > > +		goto clk_cleanup;
> > > >
> > > >  		/* Enable APB */
> > > > -		reset_control_deassert(cdns_phy->apb_rst);
> > > > -	}
> > > > +	reset_control_deassert(cdns_phy->apb_rst);
> > > >
> > > >  	for_each_available_child_of_node(dev->of_node, child) {
> > > >  		struct phy *gphy;
> > > > @@ -2404,10 +2394,7 @@ static int cdns_torrent_phy_probe(struct
> > > platform_device *pdev)
> > > >  		of_property_read_u32(child, "cdns,ssc-mode",
> > > >  				     &cdns_phy->phys[node].ssc_mode);
> > > >
> > > > -		if (!already_configured)
> > > > -			gphy =3D devm_phy_create(dev, child,
> > > &cdns_torrent_phy_ops);
> > > > -		else
> > > > -			gphy =3D devm_phy_create(dev, child, &noop_ops);
> > > > +		gphy =3D devm_phy_create(dev, child, &cdns_torrent_phy_ops);
> > > >  		if (IS_ERR(gphy)) {
> > > >  			ret =3D PTR_ERR(gphy);
> > > >  			goto put_child;
> > > > @@ -2490,7 +2477,7 @@ static int cdns_torrent_phy_probe(struct
> > > platform_device *pdev)
> > > >  		goto put_lnk_rst;
> > > >  	}
> > > >
> > > > -	if (cdns_phy->nsubnodes > 1 && !already_configured) {
> > > > +	if (cdns_phy->nsubnodes > 1) {
> > > >  		ret =3D cdns_torrent_phy_configure_multilink(cdns_phy);
> > > >  		if (ret)
> > > >  			goto put_lnk_rst;
> > > > --
> > > > 2.33.1
> > > >
> > > >
> > > >
> > >
> **************************************************************
> > > ********
> > > > This email and attachments contain Ambarella Proprietary and/or
> Confidential
> > > Information and is intended solely for the use of the individual(s) t=
o whom it
> is
> > > addressed. Any unauthorized review, use, disclosure, distribute, copy=
, or
> print is
> > > prohibited. If you are not an intended recipient, please contact the =
sender by
> > > reply email and destroy all copies of the original message. Thank you=
.
>=20
> You do realize this is not OK in public emails... Pls fix
>=20
> > >
> > > Aha!!!
> > >
> > > Okay destroyed this now!
> > >
> > > --
> > > ~Vinod
> > >
> > >
> ##############################################################
> > > ########
> > > This EXTERNAL email has been scanned by Proofpoint Email Protect serv=
ice.
> >
> > Regards,
> > Li
>=20
> --
> ~Vinod
