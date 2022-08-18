Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDEF597E30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbiHRFob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 01:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiHRFo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:44:29 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794605A8A0;
        Wed, 17 Aug 2022 22:44:27 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I5607K013724;
        Thu, 18 Aug 2022 05:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Mg4DB2M1kzTxqh5qHqrEHXoaJC+R5TDYoflgz8AsE+8=;
 b=pBiYUZjmY9hFdgFkdofCHTwLAaUoVkVkS+yiC+GilSlo3dInf+u7YUU4dVfi5vAnaLb9
 re+9QA2x6lG6x8RKly2RAPVbxIt/6Faux4rY4BBsgn5kmhVIUaUjqx4GfD+9v+PyLkI5
 aoDYgzuTGc7nstUanRnyX0gjZXelib9avGSinOtsfS4ZZXAzWUF4H6YHM4IceGqB6Zw7
 AaAZ26E8F1k8MiNbx+C9wBgJmNlgw2PZrC46caDSgflWxx0mDbhsWldLVaxpQPqe43+H
 XT6VNi9bXQ+6rx3MQK6qaEeK/RduUqhWNMz01tUogbBdSYjSac2sU2aHtoR6FP54fuhB Vw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j1eyu88et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 05:44:18 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id A581BD2FB;
        Thu, 18 Aug 2022 05:44:16 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 17:44:11 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 17 Aug 2022 17:44:11 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 17:44:10 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ9V0jrhRUCVkFYnnaMj1J25LsweUwU9pm+ZWDsMh4QtufIGxroDmF8AdOOY3760ZN6AduS/p67gQy+VYAUSk7Y6rRvA/Q1xMhIRi82BJW6szCfTtlKxlieq6TNo8nDqZRS9+iyXL4Ub+W8lchh1Xd29+urPgbG6xssIoAce6XzpPOKN6HXsudFqyvDwAB3zvPvlNohND3fW4FfOSh+zGBIBvNipjvyIGRh2gBitC2MsnwSe92SfvnpASQ9F3FhprXGw4B+l0C9YTvG600MvICZAL1LctxYzMpi/8a2k4GDARUSXlxYQ1cUkKDU3eO3AReYb27XTXj44x+7HEqShlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mg4DB2M1kzTxqh5qHqrEHXoaJC+R5TDYoflgz8AsE+8=;
 b=ny6CQVjzsXjRFbDXPCF+13Xyg8YvYgPff6DsEedzmzZkrzrsbuJDdteiFjzI+S4XsJmYX5wiwkPfoXxM/Rvr25nvBIy1f14urnpDB4IAnuvDG4k/C4fsA75JsUj6JyZOBtyOPKDeuoWOmTwmxxuKokMCMYa1O0yuBM2wuSy5WthKbqV83iqYcdj6fD2JVLosLzr4T7baoTvjJ09MdEh+UyCq3giCivLDmHB6IUfEeywDyP6dblc/2E/iWeeZZN5G5IgKowZLqpyZga3Z7x1TGVkwpoEGP//cxn6awGFKsTrN0qvlIrSYpIO3v4xDSatxbdPLw+PV26cyGE2ryrg4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SA1PR84MB3167.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:806:253::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 05:44:09 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 05:44:09 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 10/10] crypto: Kconfig - add submenus
Thread-Topic: [PATCH v2 10/10] crypto: Kconfig - add submenus
Thread-Index: AQHYspAfNEVq9XUVOkGjN60mBqhWxK20FRUAgAADL7A=
Date:   Thu, 18 Aug 2022 05:44:09 +0000
Message-ID: <MW5PR84MB1842481DD734E43C27C5C049AB6D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
 <20220817232057.73643-11-elliott@hpe.com> <Yv3DhH7WkhNPnqMu@sol.localdomain>
In-Reply-To: <Yv3DhH7WkhNPnqMu@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d59580c-468f-47db-270c-08da80dcac28
x-ms-traffictypediagnostic: SA1PR84MB3167:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eh0XY1LmbN/MFXRRFg0NhmN5dbAZv+m/JqNeyniOQtyUCXIHiEYtz1rok7n5RqvVQhOe1VBg+c6eewDjbowcNrddqi5WtxS7p3NujULk5kbsCHLqFmnENlteGDMcZLN/XgnfuU4/4VxROQw7Co8uzFS1uIR7AGKEQK0zGonnSTivJ1kKIoongAfc+npyOuWMWMOzZRzCB2A7zdatth2xN5kzJGFjff24OK7hNxxLpEKhceb2AJ62KJ+VaxFDnZbatxqT5yCr+sn5tM9hiuuA1DNOcs5N9UpB6uce0K9SHes93MMbgUqDscOzOLujtAGSae1FO+fkfsoZQRqhIki8tG2Ka2RdPgY7mQYxUoFlqhzkpXbqBAulo5g4Q+TKyJqMk8t3MosARbymiAhloclGlTVTu5sNTXeKHdouLovQjbFo9ba405DnPLTy/3Y1E6F+sfraNTMmtLbSUCcj7yVsuLxbAaBsHK26lKC41kRmQ7rOXPzCTyw0mI6S7K/1bL0pePXHOL+YQzIRzocQiDVUftEArEZzH0DxMACIbvUGQzXNtXv6VjpWCl+ziVgOtIqiGKkqlxXfrJ2I0YRwiC5oGnaQiPkDdFSOcJIKMCH1DL9Y+ASob2wNFOHPQ4JUXZejIbdOb8jWEgQTkMGWXtM1xSbNCJT6cRj8M7IFqGDOJgO7kIknLAyfRPnJPWutDZAeCkd87o1tx70wWPBuuaFyFjdFVb8WCrLX8razNxXBIYz1xYQxWNbRLkvN+fBgTPCcYuKeuyWWqNmeX/pCfEM/FQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(39860400002)(376002)(396003)(82960400001)(6916009)(186003)(54906003)(316002)(55016003)(83380400001)(71200400001)(122000001)(38100700002)(6506007)(7696005)(38070700005)(76116006)(53546011)(8676002)(4326008)(66446008)(64756008)(66946007)(66476007)(66556008)(33656002)(2906002)(86362001)(9686003)(41300700001)(478600001)(26005)(8936002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7fKRCyOFsCwSvCdQsqqQ6EfpsAyagMoaNRfGA58PF1PQS83QsNn0oSmtrQ3i?=
 =?us-ascii?Q?1aJ2CZ0uWzIypuzJdz4n97WvQ10lkEiUssjuV9sjLtntaSsj2oTG99QfVZWw?=
 =?us-ascii?Q?BgjlSKOBc4aSF+SVUeHLHc5vzN9K1GgVhqt5qT0xUJbWH2TAG20nk/KFk9fK?=
 =?us-ascii?Q?Dmo2ZOTe8K8JR4d0XK9D/5d57gOzoh2GdePkLxhl0GqNkyAXYtDIK3HBdQ+F?=
 =?us-ascii?Q?5RSzLJbSxqmId3FZs2X5YXfCg438JnIu6pBYSez1bU4wJE/nztBKH7u7rj1K?=
 =?us-ascii?Q?XZ1tlNwV65TlgK+OZAY4z8ldUB3qwWF/iz7Lt4zCZ4aRE0Cd9+U/4wkoBgS+?=
 =?us-ascii?Q?GcxOzyRybVLYkgmP3AS0uMeEPM6/5kBLuskMgJItTfxVU1ylFDUdZs3N5WSq?=
 =?us-ascii?Q?IK1R0yiP9pmPi0SFRPp6PpHlRfzgKZ40SumhE+cw1Zy3fEclJXowCzn4Gl4g?=
 =?us-ascii?Q?qSlrbHqTptW0KNTD+N28qcc0xGS9wVSI5OugNaBqqnO4i6L4c3ViDcEkQrF/?=
 =?us-ascii?Q?HT97zyZkb3ndjfLOTIpA7tpHb9oyIZsRyzd2Bbox6hO6uorrmD5aRbPoHI77?=
 =?us-ascii?Q?5clfVKrfuFI1S2hBBCs0EtH4X3iJxYUbH9BeS7N6Em3nzuCV40pznNj5mpbP?=
 =?us-ascii?Q?HRIDYZ+ST/nKGW72avGGckvHmRHpePZJW23v0XMwMCTPOtlvyGp3UOTDbSsi?=
 =?us-ascii?Q?YTRLPWVkM1VqOHNSWLZ5duDzxFO11SResH0U4asZiemoOh7hp7sADcLBfOBP?=
 =?us-ascii?Q?Og4ePFC/UuUnpbAAtghsSeOC0t3l/OANXaqt9XD5njqVd/RJjxQzXPArRKch?=
 =?us-ascii?Q?MOkKriO5wb0Pak6yQq6UOj1j+HcnD8YG95VlPWzOc7JHZnOr/KQklxCNW02z?=
 =?us-ascii?Q?Zlv1djpb5qvedhyeuc87gzh/VwtaWhK1nLE5OUyIm648x2bMGDHUimOORBfl?=
 =?us-ascii?Q?OIoWyg7BzoHs2MlS31g2nGvnMwa441B1OdhYFZvG0UgskqvmcskQ5u4OYcRk?=
 =?us-ascii?Q?dhwKtwos62iyTSg7h7P3d/JU+ar7W+znuOVhfAyYf4Wmhh9IuHoncDDEHmvP?=
 =?us-ascii?Q?68agBDTCS/XHamZfdTF7JH6JeGnWzjt+FYdEHIvUop7oDL9T/T7sDCgGL1AH?=
 =?us-ascii?Q?Ogfogdn3TbOrE5Q0QFQ8j1gK+c7FC2zBjL6Aqwh+ioMe6hkIFGHSoKfeoavc?=
 =?us-ascii?Q?p0a/mCycnXowHAyxqnTn0c4bnjnSdabiFcJX2m3G+01/1CnZ1p9oEaTxmBn2?=
 =?us-ascii?Q?Zn5vZHQOQ2NrlzJSMy3JF0DHT9g68UlNo2R9EVvVb55/XlN9eIvbU87VIv+t?=
 =?us-ascii?Q?0W7HHY7joEgL7EH8JNpmj9oEfOENNfgwpBHI7R47RoORqkcHYI+Uw6gVhfmP?=
 =?us-ascii?Q?wXtB58MRXCAESABGuxkO4nVIJMGH+5y6ty8NzBGUU7p9UBnmIKk3Dqx0A8yt?=
 =?us-ascii?Q?jx5lNSWEcmsl5AoNaHdr0owIS8/ViJK1Xa0qt8tPoDKPMFOOEK3/yw7JbO1L?=
 =?us-ascii?Q?ydMvTKZ+UWwg7GShNWPq4y2YArNif06yyF77MVklEd2Bg73biU4JtyCaOxE/?=
 =?us-ascii?Q?vIcuKVvzVWugHB0tVcw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d59580c-468f-47db-270c-08da80dcac28
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 05:44:09.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbALselyyMUJsD0XqKrL9C1OiLq6oF+ad+2aomsQ7Kw07IFmwVW/t0UKxXmg0ZZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR84MB3167
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: XtIiRNUkoYTuLFF_HquJrOgbiEP8N8LH
X-Proofpoint-ORIG-GUID: XtIiRNUkoYTuLFF_HquJrOgbiEP8N8LH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=591 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180017
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Wednesday, August 17, 2022 11:44 PM
> To: Elliott, Robert (Servers) <elliott@hpe.com>
> Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 10/10] crypto: Kconfig - add submenus
>=20
> On Wed, Aug 17, 2022 at 06:20:57PM -0500, Robert Elliott wrote:
> > Convert each comment section into a submenu:
> > Cryptographic API
> >     Crypto core or helper
> >     Public-key cryptography
> >     AEAD (Authenticated Encryption with Associated Data) ciphers
> >     Block modes
> >     Hash modes
> >     Digests
> >     Ciphers
> >     Compression
> >     Random Number Generation
> >     User-space interface
>=20
> Thanks for doing this!
>=20
> Some of these proposed categories are confusing.  By "hash mode" you
> mean a mode that operates as a hash, not that uses a hash, right? =20
> (CMAC is included.) =20
> So what is "block mode", then?  And what's the difference between that an=
d
> "ciphers"?  What about modes that use both a hash and a block cipher,
> like Adiantum and HCTR2?  And there is a category for "Ciphers", but then=
 a
> category at the same level for "AEAD ciphers"?
>
> Some of the naming used in the code is poor, which is unfortunate and
> is not your fault, e.g. crypto_cipher really should be crypto_blockcipher=
.
> But this doesn't need to be carried through in these new menus.

Yeah, those are just the way the existing comment sections were
structured. I'm all for improving the structure.

>=20
> Just brainstorming, how about the following:
>=20
> 	* Block ciphers
> 		=3D> i.e. crypto_cipher algorithms

This could be characterized as algorithms that are length preserving, but=20
only processes one block.

> 	* AEAD (Authenticated Encryption with Associated Data) ciphers
> 		=3D> i.e. crypto_aead algorithms (and templates)

That could be viewed as any algorithm or template that has=20
    output size > input size

> 	* Length-preserving symmetric ciphers
> 		=3D> i.e. crypto_skcipher algorithms (and templates)

That could be viewed as any algorithm or template that processes more
than one block and has:
    output size =3D input size

> 	* Digests and MACs
> 		=3D> i.e. crypto_shash and crypto_ahash algorithms (and templates)

That could be viewed as any algorithm or template with
	output size < input size

There are a lot of digests now (20). We could move the 4 CRC algorithms
into their own category since they're not really cryptographic, which
would make space for the MACs.


> Those 4 categories would replace your 5 categories "AEAD ciphers",
> "Block modes", "Hash modes", "Digests", and "Ciphers".
>=20
> CRYPTO_AUTHENC would go in the AEAD ciphers category, while
> CRYPTO_ESSIV would go in length-preserving symmetric ciphers. =20
> (CRYPTO_ESSIV registers a crypto_aead too, for a weird reason, but that
> is an obscure case not worth worrying about.) CRYPTO_CHACHA would go
> in length-preserving symmetric ciphers since it's a stream cipher.


These are the module and driver names in each current section:

Crypto core or helper
          Module: fips
          Module(s): crypto_null
          Module(s): pcrypt
          Driver(s): pcrypt(...)
          Module(s): cryptd
          Driver(s): cryptd(...)
          Module(s): authenc
          Driver(s): authenc(...)
          Module(s): tcrypt

Public-key cryptography
          Module(s): rsa_generic
          Driver(s): rsa-generic
          Module(s): dh_generic
          Driver(s): dh-generic
          Module(s): ecdh_generic
          Driver(s): ecdh-nist-p192-generic, ecdh-nist-p256-generic, ecdh-n=
ist-p384-generic
          Module(s): ecdsa_generic
          Driver(s): ecdsa-nist-p384-generic, ecdsa-nist-p256-generic, ecds=
a-nist-p192-generic
          Module(s): ecrdsa_generic
          Driver(s): ecrdsa-generic
          Module(s): sm2_generic
          Driver(s): sm2-generic
          Module(s): curve25519-generic
          Driver(s): curve25519-generic

AEAD (Authenticated Encryption with Associated Data) ciphers
          Module(s): ccm
          Driver(s): ccm_base(...), rfc4309(...)
          Module(s): gcm
          Driver(s): gcm_base(...), rfc4106(...), rfc4543(...)
          Module(s): chacha20poly1305
          Driver(s): rfc7539(...), rfc7539esp(...)
          Module(s): aegis128
          Driver(s): aegis128-generic
          Module(s): aegis128
          Driver(s): aegis128-simd
          Module(s): seqiv
          Driver(s): seqiv(...)
          Module(s): echainiv
          Driver(s): echainiv(...)
          Module(s): essiv
          Driver(s): essiv(...)

Block modes
          Module(s): cbc
          Driver(s): cbc(...)
          Module(s): cfb
          Driver(s): cfb(...)
          Module(s): ctr
          Driver(s): ctr(...), rfc3686(...)
          Module(s): cts
          Driver(s): cts(...)
          Module(s): ecb
          Driver(s): ecb(...)
          Module(s): lrw
          Driver(s): lrw(...)
          Module(s): ofb
          Driver(s): ofb(...)
          Module(s): pcbc
          Driver(s): pcbc(...)
          Module(s): xts
          Driver(s): xts(...)
          Module(s): keywrap
          Driver(s): kw(...)
          Module(s): nhpoly1305
          Driver(s): nhpoly1305-generic
          Module(s): adiantum
          Driver(s): adiantum(...)

Hash modes
          Module(s): cmac
          Driver(s): cmac(...)
          Module(s): hmac
          Driver(s): hmac(...)
          Module(s): xcbc
          Driver(s): xcbc(...)
          Module(s): vmac
          Driver(s): vmac64(...)

Digests
          Module(s): crc32c_generic
          Driver(s): crc32c-generic
          Module(s): crc32_generic
          Driver(s): crc32-generic
          Module(s): crct10dif_generic
          Driver(s): crct10dif-generic
          Module(s): crc64_rocksoft_generic
          Driver(s): crc64-rocksoft-generic

          Module(s): blake2b
          Driver(s): blake2b-160-generic, blake2b-256-generic, blake2b-384-=
generic, blake2b-512-generic
          Module(s): blake2s_generic
          Driver(s): blake2s-128-generic, blake2s-160-generic, blake2s-224-=
generic, blake2s-256-generic
          Module(s): ghash-generic
          Driver(s): ghash-generic
          Module(s): poly1305_generic
          Driver(s): poly1305-generic
          Module(s): md4
          Driver(s): md4-generic
          Module(s): md5
          Driver(s): md5-generic
          Module(s): michael_mic
          Driver(s): michael_mic-generic
          Module(s): rmd160
          Driver(s): rmd160-generic
          Module(s): sha1_generic
          Driver(s): sha1-generic
          Module(s): sha256_generic
          Driver(s): sha224-generic, sha256-generic
          Module(s): sha512_generic
          Driver(s): sha384-generic, sha512-generic
          Module(s): sha3_generic
          Driver(s): sha3-224-generic, sha3-256-generic, sha3-384-generic, =
sha3-512-generic
          Module(s): sm3_generic
          Driver(s): sm3-generic
          Module(s): streebog_generic
          Driver(s): streebog256-generic, streebog512-generic
          Module(s): wp512
          Driver(s): wp256-generic, wp384-generic, wp512-generic
          Module(s): xxhash_generic
          Driver(s): xxhash64-generic

Ciphers
          Module(s): aes_generic
          Driver(s): aes-generic
          Module(s): aes_ti
          Driver(s): aes-fixed-time
          Module(s): anubis
          Driver(s): anubis-generic
          Module(s): arc4
          Driver(s): ecb(arc4)-generic
          Module(s): blowfish_generic
          Driver(s): blowfish-generic
          Module(s): blowfish_common
          Module(s): camellia_generic
          Driver(s): camellia-generic
          Module(s): cast_common
          Module(s): cast5_generic
          Driver(s): cast5-generic
          Module(s): cast6_generic
          Driver(s): cast6-generic
          Module(s): des_generic
          Driver(s): des-generic, des3_ede-generic
          Module(s): fcrypt
          Driver(s): fcrypt-generic
          Module(s): khazad
          Driver(s): khazad-generic
          Module(s): chacha_generic
          Driver(s): chacha20-generic, xchacha20-generic, xchacha12-generic
          Module(s): seed
          Driver(s): seed-generic
          Module(s): serpent_generic
          Driver(s): serpent-generic
          Module(s): sm4_generic
          Driver(s): sm4-generic
          Module(s): tea
          Driver(s): tea-generic, xtea-generic, xeta-generic
          Module(s): twofish_generic
          Driver(s): twofish-generic
          Module(s): twofish_common

Compression
          Module(s): deflate
          Driver(s): deflate-generic, deflate-scomp, zlib-deflate-scomp
          Module(s): lzo, lzo-rle
          Driver(s): lzo-generic, lzo-scomp, lzo-rle-generic, lzo-rle-scomp
          Module(s): 842
          Driver(s): 842-generic, 842-scomp
          Module(s): lz4
          Driver(s): lz4-generic, lz4-scomp
          Module(s): lz4hc
          Driver(s): lz4hc-generic, lz4hc-scomp
          Module(s): zstd
          Driver(s): zstd-generic, zstd-scomp

Random Number Generation
          Module(s): ansi_cprng
          Driver(s): ansi_cprng, fips_ansi_cprng
#         Driver(s): drbg_[pr|nopr]_hmac_sha[1,256,384,512]
          Driver(s): drbg_[pr|nopr]_sha[1,256,384,512]
          Driver(s): drbg_[pr|nopr][_ctr_aes[128,192,256]
          Module(s): jitterentropy_rng
          Driver(s): jitterentropy_rng

User-space interface
          Module(s): algif_hash
          Module(s): algif_skcipher
          Module(s): algif_rng
          Module(s): algif_aead

