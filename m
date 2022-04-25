Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A18D50D958
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiDYGXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbiDYGW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:22:26 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806956560;
        Sun, 24 Apr 2022 23:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650867563; x=1682403563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V+Ub3lxpzXXNolaOQjddb+a8jZImEgkh7T3+Yn894Ws=;
  b=PhKzSqBy2xzA1oMpwWEbB1873lVTP/9j+O0ierVkWrBUrNzyqs1dGGlM
   +rEwIfn0yONgBCzORBhk2IcNW4HwKndP64UxRqS9tmAZ62Rr4akW9M+iV
   8SKeQNZTvDrBGXh6d2QQDUWQeT28zAtUQ4Mn6OWEgdhaLT2knqMFJZMSG
   p0J6Ap9XYmsoSgRotd4LYV/nRQ0t8IOfxNuGqS89F1hnPqbk+5s2rB1/Z
   GJFn/glWbClQJbwFL3vbiLa6y8TC0OAYR5Ikteb6X+8Jl33HfOstQlQaa
   s+KZIph0INSuwauTfb5/xj6aGbXQwIuPX1GRFGRNYaslIyGaLHpkiL3SW
   g==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="199624030"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 14:19:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6ruLsI77iu5dya2lDgePHO1/BIiW2Nw91mbmZvfhcig+9g4PRi+KcvyZUZqZt5iLB1JemTYFKuspthh/700RqVd7mcfnhdtSjntxK4feXMz8wsCvqkOkiotB0hWWgFcbFBIHF6i2LTnE8loHgRdVuwZDbpphxW211G9X26JYgbTlgA0s3sRNqQa5ePUpdKiFkn//efQI7XyTM5q++qZvCiRuyOc9XxBPz73GFpmqjRLgtgR8YIJdBtdA9KhD2jS0JipPzXLLnb1rpTuUMtmk9XHyfjqOx/q8Wwm+dUfbdoP3sd7noDTbGPynrAMkrcyaVTW2BB5dWyVslIu3q566Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+Ub3lxpzXXNolaOQjddb+a8jZImEgkh7T3+Yn894Ws=;
 b=cZlOp/LiTuqbX6ir2t6Bs3UDwVfkXIe40ariZ/Lsg+BKiJvXew87Ho44/qM+unsx9bTAram+PBXmtLRKgN3XuN/1+Q4B+rIIuR2ycUNmMfBBlPdi4OnZOJuWMybwv7j7FHTwGnfiYcveBmhFrgVTp+67jZVZdtDkIUkUNIB5Z6bRnZ9XyVcGwBZ7FolZ0qI9Ab9LDJkqdbHLUGJb0uON9D4awnSjUUn6+TVCUvzI63O9OPapK1S9O5IgsxEnxvCUcqU+QNbiqog0pgUJ0rg8T20yboI9TZm0wYt1EPA3o6mAjO3wMxer8lMjx+Qe9tsAMSHSr/JSvkfLmafkkTZJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+Ub3lxpzXXNolaOQjddb+a8jZImEgkh7T3+Yn894Ws=;
 b=vh9O3Naze0t83QDmQ75w2lKozBFmeAYrDp/PEHLQzOt7t4yZf1j7dk2H36ZDF87obG7xe9H3bEvD+4hHPQRh6LyMDLhSPDqJGrsAEwEikHCXiOp4P3P2p4/PKMR593CIsBsoqy5Cp7xl5F6v5ELxHwJfPmKf+ILJLzPhoMvJjQs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7632.namprd04.prod.outlook.com (2603:10b6:a03:32d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 06:19:15 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3%3]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 06:19:15 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "keosung.park@samsung.com" <keosung.park@samsung.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/6] scsi: ufshpb: Change sysfs node hpb_stats/rb_*
 prefix to start with rcmd_*
Thread-Topic: [PATCH v3 4/6] scsi: ufshpb: Change sysfs node hpb_stats/rb_*
 prefix to start with rcmd_*
Thread-Index: AQHYWCeybXkeFUmeMUuR/y9hbgwOKq0AJ+rA
Date:   Mon, 25 Apr 2022 06:19:15 +0000
Message-ID: <DM6PR04MB657584CAA010AD7439A129D6FCF89@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220424220713.1253049-1-huobean@gmail.com>
 <20220424220713.1253049-5-huobean@gmail.com>
In-Reply-To: <20220424220713.1253049-5-huobean@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a650e54-10e0-4a6f-ec5e-08da26838605
x-ms-traffictypediagnostic: SJ0PR04MB7632:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB7632859ADE5A7E8ED3ECF59CFCF89@SJ0PR04MB7632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8T/hRYZybnuryd+sFfQkrJeXHhO+L0ZOkHsWwAc/nIxqpLQJL8ZZyinHT3Tx4Rb8uEgJ0GFotHZ/LIDaPGJ0lKwCDk6N3gU1dZKifW14RQCvikNVzBP0IwRMxFSsTA0tT2cQrOp2Dp3fvG8/AR7pIw9bsSvx3ybeumq6cYTcfJcPP4lWtgMSP7vs6kSEpQ20Y+kK05acLoOPutiIsZkMbCTQpib+Ojq1MbB5VBESX1uu/3cOzFCJtPDGQZWz4sR3zlM7Q1D7mmYh5zVy28Zjxzc9BA75AiwVIhdlwLH3ekIxtJmFW/rq16nNJ6LOprl0hFWg4E7zJGXR+iuTzOIW91DcUiC8OnJ83kLJY7LTxBIq0pBpAVhvQ1gVKjRpHzx9CvWx45JHbyRtMRajB/6fo6PlmfCLMqfEYkq1EuHfTig4UurYOUZgeMBX6okGcdUlbgxQKi156e3rVx5UAJxfxrJ601hqLpLakYaGfSEawXI7SXRqIZ/Bkl/01i6Tp+jbFNkyRfT2xZiLzrbQ1raiXMc7MNZbkvuGnNf0ZsXVMKEIKORrSXcILtk5ICAYizPuVom0FBBswpt7I8lpnkj2HnrM2PphYUWr7h4tkyxGX6q2mqygwCGDu6BgeJhAfuHO7xZRimMxaKo1zjKDvkTM41V9wEg9Z188poyiE/Ei9fz3fgXk57IQHqEsEDGOiBIfuQXQUDrJEqOk0bL7kw3B56ScTjkPAwYnshJFnf+UmnA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(55016003)(110136005)(4326008)(86362001)(82960400001)(921005)(186003)(54906003)(316002)(38100700002)(38070700005)(7416002)(66946007)(52536014)(4744005)(66556008)(66446008)(64756008)(2906002)(76116006)(66476007)(8676002)(508600001)(7696005)(6506007)(5660300002)(71200400001)(8936002)(9686003)(33656002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EUug+/NeZ82sgKjXtqG0vjab/H6S6mIUZp7A0BYtLLokyn1YXUtJw8CDSEFM?=
 =?us-ascii?Q?pg2jVv2yoEwN+KOACPONfsI8PcnoDMDsqNT+FsPhTbF8Nqfo52nUo7PUj/76?=
 =?us-ascii?Q?2V+ogtIRngGCW3L9WsBe8AWbipWHnF9y1kGJvMGLIFdH9TayxnVCtxHsR6f2?=
 =?us-ascii?Q?rfj5NZIyqEHjjE89eTR7hCCweCALcTx4aFPMPVXhJdezsTt3y6cgFI2exM9j?=
 =?us-ascii?Q?1EW1fx0/Y+cEaslNdPTnN4F44IhxpL8sOnTIWkHldTSOmX57pFafqaZuluBi?=
 =?us-ascii?Q?ULtDstozxi58qE1580ENSz7jUyLPNpNYntEGMW2Ybkmp1JFoiPygF8W0gH8X?=
 =?us-ascii?Q?07dKtRzrUqsTbFrfDFvLMw8Kuatp4i6B9xuLil6Up+1/GR06WXev3+fOv3Rd?=
 =?us-ascii?Q?3DjE00k4beYQaFNhHLOSh36C0QH9fliZxZL29fXlk3jweJcxmvAHxt+uYn9s?=
 =?us-ascii?Q?rQquO7Ncb00PZ3g6GIUmsOeU3rXPvGXzGRYZBd5qrxN3RPKEpKnLJhCDO0cs?=
 =?us-ascii?Q?Qc9xKorxY1I1Y+k2kemlFJLprA4hJ3Ay9pdrK2mERahFAu69rt2ChIm5e8t2?=
 =?us-ascii?Q?C26Fzwg+GLvmWj1nyLq96UOeRPdbsCUIeJyadKny7C+1agGPPMVJU3SHfuBp?=
 =?us-ascii?Q?xBTpy5QdjLw3ce8Jin4Tfm9cAnsNNc7IYVL/M/41fOp24Qh82tBRhIa8/Cl0?=
 =?us-ascii?Q?K4FAW+KojtxjEG2POUVNa1h3+6KiU0DOahUa6Yo7Xfxfo9/w0JubgLWG8CK6?=
 =?us-ascii?Q?H1uyfyBlfl0ynRHfa7ABsnJceWgS8cFSJYhwOjxd2neRC0LL2sAYESaEiTRj?=
 =?us-ascii?Q?Eo+FeQ8bq/HlDmf0cqKFZBTOVciNLx3ZYzI45FIv2bvYD3D/zddkq256nIOS?=
 =?us-ascii?Q?12fAjQs2oCWavGZU5WuDL3X6UFfsfjD8oysLU9Ep8cj5yQxr3+9h5uwEIG0z?=
 =?us-ascii?Q?g/MEmcT2MuE+M/3obuqcrSU6aP9a8zMZ4jnKom1HckM+lEuYsUUaMDE+pkIC?=
 =?us-ascii?Q?k1qzST/0NnnmxKaJZtY0/tLfStOF/Qo7QYhjhIUDkYU8ghKUaz5zfIyo1CBO?=
 =?us-ascii?Q?41381UXu1g2gZCRqRpSfDRlDdTUwAVOhYqcPgfacSf2UdwyBRK2bnbOf35eE?=
 =?us-ascii?Q?lx5coDjDrfUQNcHJVr3HVoXCUme5RDQXwKbPjtWqjZLsruwBHvYchiixwPV4?=
 =?us-ascii?Q?R8iKNIQk+SJcAzcZ4mUoACQ0ZrS7h/c72lfSCPnLPuH/VWB2KX21iZ5f1Bj+?=
 =?us-ascii?Q?kdEMCBseB6HqlkVAHgkTx++8uD2ZD4gYscOZwdAL6kwsUy1OtKdQMDXijMSX?=
 =?us-ascii?Q?suoAflclWFveNlSN2bGsKK5njWo+JlEMVG/jOPA5tGajti+PI5YWCYhd9a5P?=
 =?us-ascii?Q?+oK2c9Mb2wlXixfiwWXCPcU0K37OKzOKDkkB16ZyBOLfF1FRvUKgY1LUt+pp?=
 =?us-ascii?Q?p4YI7a6oPcD4aVA4tkYpDBVhD6jiEB4gY3Ah0khC1hnZVAIcjYquc2xvhtQF?=
 =?us-ascii?Q?EwVP12gmQM4iI/XJkr2HNCaZpyzX+VS6fUzcSNennBvXSdSvyqWrdqZq2Q55?=
 =?us-ascii?Q?Z7AwQPlYqntJCcxdLYmniYk5x/+wx+nm3O2J87pYjtGSYrDoEtd6W/yaY3Nm?=
 =?us-ascii?Q?i4A4AkuIut2lDPp3sBDVvTenKYknYwbPygRbkEr01SUD65hOHWBWa4TXbnh0?=
 =?us-ascii?Q?gpVTeQtH/Q7SyuNt2WaJL1I8ejQZSz3gsPb5ONt22nlJ3c711lo0NQmTTG/J?=
 =?us-ascii?Q?VSovfqBWfQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a650e54-10e0-4a6f-ec5e-08da26838605
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 06:19:15.6827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niIfv0/hFa7dyFho4rBWBjyg2/qWkZw220y99e1Ih+zTTALxA4lcVJ2ojwFQuM+X8wv2+BkHDUk55CNKunlw5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7632
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bean Huo <beanhuo@micron.com>
>=20
> According to the documentation of the sysfs nodes rb_noti_cnt, rb_active_=
cnt
> and rb_inactive_cnt, they are all related to HPB recommendation in UPIU
> response packet. I don't know what 'rb' refers to, I think 'rcmd'
> (recommendation) should be the correct abbreviation.
rb stands for READ-BUFFER

>=20
> Change the sysfs documentation about these sysfs nodes to highlight what
> they mean under different HPB control modes.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
I don't think it is allowed to change the kernel's ABI.

Thanks,
Avri
