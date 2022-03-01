Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518F4C8FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiCAQL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiCAQL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:11:26 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF513DDE;
        Tue,  1 Mar 2022 08:10:44 -0800 (PST)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 221G3f5g031000;
        Tue, 1 Mar 2022 16:10:38 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3ehpny81th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 16:10:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZjoWnUCxWNU6VFCksetvafqS67wgSx9j1PzZZMZliO3npaV2S6XJjCog34mpwPC8TCWMGiojR1iNTaAnxAud98KEwZFMzqkE3SUMZistxBWz8vzELHHtdVu5hrRaVeFV1o7bbwgd9v7fUVmj49tFfWyinnhkJ+LZdhQxJWw+USBG5SSON00NhqHxsXL7j/tK2IaC7yp3xYszrWh4oL0U1MvycevshODeJ0Mm34cQ7RGVE6vaRlwkqAORKKYTBwFkE+dQaMiREgc1q8CgWB7Yp58DeQJsfR7XUQQjJdgnOAqzwtImIR3Nqc5z5yhDTU8beb0vQkBWZRVSV21REqccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk0l36ETdlc2ZOfqQEike19YUbhmQG1032cDQpsdM4M=;
 b=T0ZIwvri2r/WSXCpFwB/ujyK4Gbzo7CGQVBSt3tpe0ba+BKFw4i3zxwnB5lE2KFx52ffiv9J8KCLTO1S2dS9SdqfCE4rQWD1481d9TV+yVLyGAtf9AKAQ+0cDcP91u3uIfOLRSfnRmT6XoxBcb8GVJMj9dcvViM6FXeXI29k6jkagGX7urb94tJkplZZU5eXVoT5rv/O1SrYJkkUXUivTv1ujuFF4XyUZzXFE4UT8EB5AuphcMg8HYii9MdLUa1vP1Ts98CN5ISAt+AjfcP8R1GIhneZkpvvt7Zci/mN9aMlfJM2HxGez8o02O81SywVwd4cyPI/xKPV4/k8Td+ktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk0l36ETdlc2ZOfqQEike19YUbhmQG1032cDQpsdM4M=;
 b=jJWxmfXq+RPy8Pa9OBYGw6EE9X3YSUiA99OFGbyPPsZ+RxbJjHgbJX1izQi+rgMGNx4CkScDrJBIa4GV24aME+zsQwMx8HnhVUIzRmZ1aThRFlJec+zEIqkd2SNNR4XcLSDrtta0haHf53FGk9bJon/16uTsH7djZ26qwl2TGiiGMZFJsxuF9qxmzh3PVwXv1eKFGU4d6bnq1bkUhoHFc/iqlN+nE+gFAVCTuib/pCfapS/HiTJCWhpQk0u8fO17nERTFjeJ30S1GOBkRlfHBuO700aQu8F2d7G6uB9GCUG7zReGW5lRacaiODU7nz9t/0RBxSBuWF1aDaDLhcgB4w==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by VI1PR03MB4256.eurprd03.prod.outlook.com (2603:10a6:803:5d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 16:10:34 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.5017.026; Tue, 1 Mar 2022
 16:10:34 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Topic: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Index: AQHYJ0gzI98NnKSQaEaZikv/1tAERayfaB6AgABVqICAABNVgIACyvOAgAC3jwCAB2uVAA==
Date:   Tue, 1 Mar 2022 16:10:34 +0000
Message-ID: <20220301161034.GA78066@EPUAKYIW015D>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <20220222110003.GC21915@e120937-lin> <20220222160637.yn6pru4nfgwih23j@bogus>
 <20220222171549.GA2194063@EPUAKYIW015D>
 <20220224115443.fwhczfvm3cfwoim7@bogus>
 <alpine.DEB.2.22.394.2202241424110.239973@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2202241424110.239973@ubuntu-linux-20-04-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 042bb5a1-003c-45d4-2b85-08d9fb9e0487
x-ms-traffictypediagnostic: VI1PR03MB4256:EE_
x-microsoft-antispam-prvs: <VI1PR03MB42565DA626999A3B92004137E3029@VI1PR03MB4256.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbMfJEdTsOXsvlzlA62eXKHReVcbpce38ns6WVCVvAQeAss3w63S54IsRTUwHT5SnnJQytsprEqa4xzBu6xv2x6k2uAEyz0xZdZP0f06uLdIi16/0ZThn/YcoQGWMbq77qQmuDbtL7CAKOjNamDQFAaKgJ9VfwbB0hiC8oDIBcp0k28JujJP5WsMannKQ2EeHJ0G2w0Tp4HQzlVbZ5ikcdaFKUQ5j98/GBdlIJycu8LDe24bm/p8vV/XeUooQHr9uiBcjTVcDm8Ks7WS5ifK4H12cywXjreBnf7xH0egPucgGDDvYHMrr2EGA3z3IvV23ncw2bGFAVM2d6NNV1jQoia8A9CaYDMcT8LBsTJHUi9nPaaHj907OeMka9DF9Jw8A8sOY76nEikTgbVztcNPljlEyPfE3h9FDxcNK6p9SeqwzzbMQnEnUPWxnnC6BKQOXyYcVj5NWy+CuviOmwqWAGvU8HIn/onuja8VIrBSnUW2VweM1Rif3pwid7mR/TFWt8k07YItCtdbGgwrFH6ZRlaereTCcWzHbLSyRgz0O/K+K4A5PrpJQOM7e8gTKD9Yq7eWCJnYKlBz20OWIQHUVNo9usCT3w6FP2Q6qLozECYQj6/i07FpmWjsCn2kJEDoTQGhDfXQwA3dqAV5j+iu7XMbDL8vU1NiRWXjGGoY9z28wkWaC9UBPXRjyc1b+XdjrIooDwbJNaDpE/YXo4oKog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(91956017)(76116006)(66946007)(66556008)(66476007)(6506007)(64756008)(66446008)(8676002)(4326008)(6512007)(33716001)(122000001)(2906002)(38070700005)(9686003)(6916009)(316002)(54906003)(508600001)(38100700002)(8936002)(55236004)(186003)(86362001)(1076003)(26005)(5660300002)(33656002)(6486002)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X9m4e2+LKvU/O9bca9yUeqXbxtuPgB6TxqFqiMkE98ZXInvQch/2jiSQ/cZq?=
 =?us-ascii?Q?oqiMO6pxPodg5eqZMzKxcbHrbaUrQA8Ka8UvQ8gXNaztGss77lYi5xmzr9kC?=
 =?us-ascii?Q?+Ho+C6kdYx01IngzEK3v0hOC0td7eeaOaskQDBVYcYYGbwjgUhFEaHhNzT4P?=
 =?us-ascii?Q?1Z4jTTcfxpQs0u/JJ22lj3Xehs0ii1jjkYxp2Z5MA1dS+Jwv6lLGdoqGzUG4?=
 =?us-ascii?Q?xXFNiPihLkiDlLkn14OQctunrKVFSGPIcIYFFb+cCwQNlh8+OG2EDt42+31G?=
 =?us-ascii?Q?eZXJA57oiZOWSYG6KWqXsR/qfRx6s7wCgiZchjW7dob1L3DigdmTNy8UQI3M?=
 =?us-ascii?Q?w0CPFWrSr5LJVouPQKgzEFkFTciAl72axwBHSReVl0uEBEszn515k7WEVEIC?=
 =?us-ascii?Q?PH6wnwGtL1tw3EpyJuBvl6uGdWX8a5z/kWjbleM4v1B98kwFTBhzxShwOsDg?=
 =?us-ascii?Q?ZQh5lAeF77PD78XQV67KS7Dh2k2ECazTZJDMPoVuXxvi+TT2I/sYtRolRQ/+?=
 =?us-ascii?Q?SC0QH+a6vLsBvtNuZNLUsbvt1xcx5uw19coTV4R9ljHsemeVwyLg+Ajy8rcj?=
 =?us-ascii?Q?ObDLqouyC5H97KuVBFkDeJw02WFZQ/0r2mHa04+I75wwzt2171d3hko83Y9b?=
 =?us-ascii?Q?rRFiV09Ooztl5JmJZgAd+ihjfa6LqQNEIV0VbW7Hpq5E4TQDBMNCrzJqS1Sw?=
 =?us-ascii?Q?L8Eeu6oVmxcGlG5/JEdQOEF8Ktw1OPgCLarWjveAv53V/vfHdldtVlxTUv75?=
 =?us-ascii?Q?tr4Ji717oUjCaaHvpJMEWAZQZ8HGNBKVPCDlrX4UdNJNDtLhAYB2sGldMlC8?=
 =?us-ascii?Q?sKmlMAiw3ASzfk/w175UO88d/W6exxxaFlI2CNaKftqhMupDMfShl2u2cglJ?=
 =?us-ascii?Q?1OgCOOR4NMPq7ZZxZGCdFdfFFqrjorwySen6RY5AXg/BxNQSShP0IV0M4pLI?=
 =?us-ascii?Q?eIW/F0PYLb0yVYLuUMGym6w2/R15ZKKmy3Hxbyt6Z1b828OW4rGXUjph3E6b?=
 =?us-ascii?Q?QcSTaDIw+Js/ubPoCM1hjjupZ3+E6onxXW784Lh+hrmcaV7EUWLr4eNzhhLd?=
 =?us-ascii?Q?qGYQdPtg/tiYCN+6gwDtwAWLzyhZDifwI6Z8bpLIznorq5jyyd5AIcr+E5NC?=
 =?us-ascii?Q?QfKBaRVm9zuHb7icsP2uMDvR5PWrrB4U+DQGIb9Ohv7ha+HM3h+YxPYlye1U?=
 =?us-ascii?Q?hQjWjv6gsQFHcW+7z91Ek7i6AXBnzhCziYoZwSkBpmF2L17ejKGm4YsFQIJm?=
 =?us-ascii?Q?RyZzqD1OHsqr6jrTX4FXZHCpnZV7h5A2X+pIOL7dfmXSWbyxYPvMytJXSq38?=
 =?us-ascii?Q?E5R8EVksUxNGMEVEaqyM272obMxrdC1Y5hz3H3BfhZRCWW6T5+E1zikk9j6l?=
 =?us-ascii?Q?91zXtDZ8cxt9KhXjbmvJpCRCS3bZ1k9avw92zpaxiQ6hDFQasuD2LLizX5Tl?=
 =?us-ascii?Q?j2haNhV1azb+uccbr3Nm7NywGckJH5lZZqsHsAlPz2ZUtcFsf5SyLS9shWpY?=
 =?us-ascii?Q?K6VLCq4QWpE8RrWjIm/emJ5nv7R/Qp8dxckTC0eqF0ESp5SsUnTCeWZdhanS?=
 =?us-ascii?Q?/tLnsMR5QWDZoXhewQCwuhISRGSqTyPkGt/MVkSXb/ooeOHlow1eBbuZdoqV?=
 =?us-ascii?Q?bmM0YtumIhCt9MbRXUO/mWUgQyvrmS+c+JmmK9ViHqYg/ZQWy+HZWy3YOa7f?=
 =?us-ascii?Q?nrNBJRrmTSFG+tnFEQlGWQOA0Yg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <424EF99A9B8AA04B91771A3356958C75@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042bb5a1-003c-45d4-2b85-08d9fb9e0487
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 16:10:34.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aM+g1MD6KbyB7aUxitJVZYvC3rnoDCKsJcVxDQT1EP82U4fuTbwjbe5BqyuFWntieJd/zcG4P/JbxsNj3f1QQKOkgqvOjY62TGEoyI401xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4256
X-Proofpoint-GUID: zbueCTtkv7wctb0BZcnm-yJfypE3pQve
X-Proofpoint-ORIG-GUID: zbueCTtkv7wctb0BZcnm-yJfypE3pQve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefano,

On Thu, Feb 24, 2022 at 02:51:42PM -0800, Stefano Stabellini wrote:
> On Thu, 24 Feb 2022, Sudeep Holla wrote:
> > On Tue, Feb 22, 2022 at 05:15:49PM +0000, Oleksii Moisieiev wrote:
> > > Hi Sudeep,
> > >=20
> > > On Tue, Feb 22, 2022 at 04:06:37PM +0000, Sudeep Holla wrote:
> > > > Hi Oleksii,
> > > >=20
> > > > My initial feedback on this. And thanks Cristian for making it so e=
asy as
> > > > you have covered most of the things in depth(which I might have not=
 done
> > > > myself that well)
> > > >=20
> > > > On Tue, Feb 22, 2022 at 11:00:03AM +0000, Cristian Marussi wrote:
> > > > > On Mon, Feb 21, 2022 at 05:26:46PM +0000, Oleksii Moisieiev wrote=
:
> > > > > > Introducing new parameter called scmi_devid to the device-tree =
bindings.
> > > > > > This parameter should be set for the device nodes, which has
> > > > > > clocks/power-domains/resets working through SCMI.
> > > >=20
> > > > I prefer you had given more details on your usage model here instea=
d of
> > > > pointing to the other Xen thread as it helps for someone without mu=
ch
> > > > background on Xen or your use-case to review this.
> > > >=20
> > > Let me describe the process in few words:
> > > We implemented a new feature, called SCI-mediator in Xen.
> > > The proposed implementation allows Guests to communicate with the Fir=
mware using SCMI
> > > protocol with SMC as a transport. Other implementation are also
> > > possible, such as SCMI-Mailbox, SCPI-mailbox etc.
> > >=20
> > > In this feature Xen is the Trusted Agent, which receives the followin=
g
> > > information in Xen device-tree:
> > > 1) All channels should be described, each channel defined as
> > > arm,scmi-shmem node;
> > > 2) Scmi node arm,scmi-smc with protocols description;
> >=20
> > Sounds good so far.
> >=20
> > > 3) scmi-devid should be set in nodes, which works through SCMI.
> > >
> >=20
> > Why is this needed for Guest OS, you need not populate this if Guest OS
> > is not required to use it, right ? If it is needed just by Xen hypervis=
or,
> > lets talk about that and why it is bad idea to mix that with general
> > SCMI bindings.
>=20
> I'll try to help Oleksii by answering here, I hope I am not off the mark
> :-)

I appreciate it.

>=20
> I think Sudeep is right, scmi-devid is not needed by the guest OS.
>=20

I agree. I think this should be handled by Xen.

Best regards,
Oleksii.=
