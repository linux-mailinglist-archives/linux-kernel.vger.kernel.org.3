Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC35A5AE5F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiIFKx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiIFKwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:52:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630547CB75
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662461495; x=1693997495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZIlf7HqOeFAgRzXrb5xa4uQw2/fxHahz6jxflXIU67k=;
  b=yJ+VYEIceJc5EEQzCxkyH0o0h6K0KrJBlYwxbvACinyJor8S3XA3q/S4
   9zE2d3aGx5q8bWrlS3ItTeSUapObQfacYjfcmYg2gI+M4zm8X4yv6FQJP
   zhKaWkkbJNSdnqbMXmbPYA4NEQY7oQzVmZC1VrCnTiW3U0ntlLH+QaObe
   IdoQG3PwRY5LjrmAoLE2+06ag1SLZziwXew2S3SY91fizXDn+kfMY53F4
   bQhGgbEjw6rFMSTbwwQ9k1uy8NLyc6/mIGoriJv6i/OmVcOTXSWnE0NdZ
   vcMJ6L0a4bOBNOBGTHPoB+WSm+l63x1GuMqRfmQIClFwWls1Bzhw5Cnuu
   g==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="172553047"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 03:51:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 03:51:32 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 6 Sep 2022 03:51:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL/S8+IglE0BYclRT3lexDhisupJ2cYndCQVs1ZoSmhiy6Qel/cnhonh2BLXKRmzxWPb5/u9wnKypD2OYjOcgvmfAb5hJCRjLKx8CZmqthVqPoLyvvxOCp9H92oMWrI7wAqKHB5smSiv+KqCWMjWYUyhz5lEUJLK37k0YGb4nKdodYVAuVAbx+5dyzwtbtQt7w8agMVXjBq1ktq7ZBrXHQn+auHIlKSN6x4CqpqHvMlDv5mKMJZIhNwphKDjDYP+tr5J5E2Cikc8XQllNL/C2fa/jCrv1wlm70nIe1uNoUUC15hWHQwFLhtpjgznP6yFEJQxqDucPiAayVQQ7wlrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIlf7HqOeFAgRzXrb5xa4uQw2/fxHahz6jxflXIU67k=;
 b=Yv3YW8Yf5n6Avle/symqMpZZK9SZuicJZ+zE1h7t8Tn8JeukzRxAvdy/JcxpdgAuaYeMgVDXtczihgxid9vVa63DgblIcyVuhWaUU2e6Za+xa5dr+X+e/r8YZv45d5TBvOVWZvzIoLdeRLldTtCmICMbSLLsIWdlsY9ne7GkiXP+kiYMZ6MKkCsyRkITTNX08nDkECcKurUZHN+yN+N0B0Aw25/dAlcCuQvM3FBDcWU81QUtMUTdjKstMoTVT/B30cPVfMdj/HB0qZRILAFNBS4ujpaP6g/5lydWGi43+K6o6OHQaZf6swHvBGIngb30dffn2C2tdRQP/Dc1MdDslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIlf7HqOeFAgRzXrb5xa4uQw2/fxHahz6jxflXIU67k=;
 b=HlXfhT6/dmhFnfHGQrdlqF1bmSVxc6Tez4HIh2EAb7R4Wy2nTOmgAWMuZXe/du8c6v7DAZS/LHxturJBHArGLT7TG0uW3Yps5oenjt3FzTm1hyTesJVokrWhZgUhXebQ1rXNHCXsEt49SJiXKNVjq5ddM2w8BuDzwCcWIaeJg60=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by MN0PR11MB5962.namprd11.prod.outlook.com (2603:10b6:208:371::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 10:51:27 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5588.014; Tue, 6 Sep 2022
 10:51:27 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kbuild-all@lists.01.org>,
        <lkp@intel.com>
Subject: RE: [PATCH char-misc-next] misc: microchip: pci1xxxx: Include depends
 on PCI & select AUXILIARY_BUS  in the Kconfig file to resolve build issues.
Thread-Topic: [PATCH char-misc-next] misc: microchip: pci1xxxx: Include
 depends on PCI & select AUXILIARY_BUS  in the Kconfig file to resolve build
 issues.
Thread-Index: AQHYwc2Wz/vfuMYxNkeHoGmUy3dGSq3SNaAw
Date:   Tue, 6 Sep 2022 10:51:27 +0000
Message-ID: <BN8PR11MB366883CBCAA52E31350F95ADE97E9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220906083555.475103-1-kumaravel.thiagarajan@microchip.com>
 <YxcJjNwL3/TxYhPc@kroah.com>
In-Reply-To: <YxcJjNwL3/TxYhPc@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 287bbc12-2f8f-40f4-84e1-08da8ff5bfc0
x-ms-traffictypediagnostic: MN0PR11MB5962:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xcIGuvw4dnyTkKMCWoINAjZ8z/pMO43rD8gyHoDXvUesjLQX0SayuqAjjyA8w/72i8K5LzEiJei/8LEm0YKFL9n3IHdgUE3S7Ks6l4X80R60G0oJ0cSVfglG8V0uw7lb+GTvgO/Ir2TJRDdEe4UG5epf32b/FVLK9mz7jmv0TqyQ0YO8y8n0bLjOrnQG5DsUJVKv5Ni4JeXPeFZVAgUhbWRrXUYQmWJ/xyaNsGsfray+fNE0Ur4kNwNioZTkaPevrYLng0FaUkRbvTjkAS7uzG3HqHNypHfteq5/nEbS6x9xqTfkS/tZ5F7l50dPy+4RwlmX++c5hAKMRfRVjSLrOVHjaI/eOdpOEN+z1E2+Gc6r63KeRYH315mkrxGqiEvMVgmn/yQNM3VD4LB9b5JBXDnQW+Zcr9K71evsMXlwwUvMmSDtnK2TOkPDY8Ch5dIAbV++i5I8Kmfk+kUSdxr8X/5sEar7ZCC79EVW34uhAotCcFvC7tHExJcL/chwAJUUk/8k/MSSLwnGFpbuvy2Cr5RPgNj8RpvpxLrF7GHo7QBIqwy+iavuPKXPdqY2eRZ59pPK80WsafWfW97imz+8jNRRGIYLUAbBHzcqp6FZJmEbvSWyTi43OpTeat+1q9DbScQEWXYBQAbuqqLSXmmQahgrVKEPNHxxFiMH6iEtznuGXWJ6ZkeHY1PedKdcfNzjaX6YKKPXWTmBAw1SaRGU0Uf8oC6j5GE7ERKe+Fl1QoLnbecZ0Xi8UBei7/oss47+lqVHWiZxSsZrLWdB4LUXJCGFAtHt4U0bAoV+thX/jXZrDRTezU5F/1605mtUXyQe5fG5rCrgV/57sAM5t5qVeakJ3WVE4wfF3hWAY5RFTf4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(376002)(396003)(366004)(53546011)(26005)(186003)(122000001)(38100700002)(38070700005)(83380400001)(9686003)(66476007)(8936002)(5660300002)(52536014)(4326008)(64756008)(66556008)(76116006)(55016003)(86362001)(66946007)(2906002)(33656002)(6506007)(8676002)(478600001)(71200400001)(7696005)(316002)(66446008)(41300700001)(6916009)(54906003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JO2dwtQS+u0Qvvrcl+K2j2mQCyH2hmScUKdy4ULTDyoaXpl1KZumciW2xI2U?=
 =?us-ascii?Q?fFGBpiG0x0OQsX9YibvxImC3lyCw7km8R/s3cy6c4kyvyoEXvs8Rjb4BPMBM?=
 =?us-ascii?Q?Ieco4bay1JIufJInF90102k+ZzRjeAZUxjJeUp/FGQAqbY9dVzTkew1GNPuu?=
 =?us-ascii?Q?nD/tKzqFKJP87t6pp2TtkYq/IOeb+WAD0aupN0Ia6+dBFmO5C3SHJ1p60U/0?=
 =?us-ascii?Q?kLbb8fiBIdgdPMLEELz3HPRH9zlAbkJ3YuE96qiKE9fBB3+ZSFN2x3XSZMbk?=
 =?us-ascii?Q?TvPr+Yzl4iPQdeMt/149yxlHW1MnG6m8Qz/9KNNzYeMcBYOSW2+GW50n5OH5?=
 =?us-ascii?Q?KsdX0EpCyliptd6Q0io6eZMLGtJP3kWxCBkBjKQ+Q+/UXX3PyG7JBe961637?=
 =?us-ascii?Q?TOCBRk5GmpcgU7GBWu8gF6XI7epnsbAkEo3JBC1fb8kr1YsSHa9lVUkLkf7j?=
 =?us-ascii?Q?wa7e4YJHjTYQsjpM4F62ReARhDpetviPdTG3PysXGf+Gkzd62YTPqRZTEF1z?=
 =?us-ascii?Q?MJ0quEK8L8IZhADO8IeGegL/1OvPF9pJhZ0QQ6VVauR0BbAqT8dw7HJDyl9i?=
 =?us-ascii?Q?IryTYMW1lxucZlrB0CENkJqH01nYkdoyvRhaJR2TBGHcqhh2ReJ1dDRsafZb?=
 =?us-ascii?Q?ClpyPRdBBlwwAnb48JAdZJPw4DBJltFR5aB98llHhV1FWevXmaOiagKkzDiP?=
 =?us-ascii?Q?FKh5RTtdAqdPRlVgKzu96doTurqycPiaW8Yg9YFuwNam0mP2h1/Qtq9EoQOZ?=
 =?us-ascii?Q?A+4HlON6aUctzVthdjodNMpsnvYSOzPoYWRtE+nmZNeTnWojIseBjsnFseke?=
 =?us-ascii?Q?Z8Wnu6mH+6Z29nFAmqQNKmjmNwAH42t2VNiz4IHPcC4WepZWbbzDhBEPZKO0?=
 =?us-ascii?Q?qCj8AmOu7gGInKO9Irw1ZZtCQLCRX1ht+9SrIkBShZ4Jk+O63bDV4lE8Se/L?=
 =?us-ascii?Q?rIQVGPbImFwDRIPeEE0h4ab3hj5xkbbhVxJnqR3FrPu8rv2CfxO3QlQDBCzK?=
 =?us-ascii?Q?Md5iA+DEHtkd/I/2geKzOSVdOYlSe6CLNOr6Z14Dinl9QxO3OOlSH7JHJFIC?=
 =?us-ascii?Q?Vk+hX8qnppAJnUX2r1JXyR5lNXYkxZAkQ89Tl3YTT6Ubwmg0A2MvdSvzxOfF?=
 =?us-ascii?Q?8X/lH8cb3k3Yw63KS/Mml7FhfNM2W40oo/5wBO+4LwrNzdSZxxMQ4rPjkgng?=
 =?us-ascii?Q?lFpgPVrjGdEFs/zZ32OzB9+VkHVXa/1Quq6yjUWNm4PJCrgPL/SqckEK+/va?=
 =?us-ascii?Q?EIPsbGWW2DG/Y77btVOfZ9uOhoeLCryR8ZzA6cD8BgK42xd81KZrNoOsJkN0?=
 =?us-ascii?Q?RbQBrNsolabdUDD1veC7guY5Jllvq1i0sEC67stg2uVKO9hYg3squ11KrX29?=
 =?us-ascii?Q?A5VXd7K9ZY1N643ZGQyiIBGH/+wtHYrX0JcXh/9pSWGWybwvz1YoL1VRMh/6?=
 =?us-ascii?Q?Mse9lh7sCbLKfQDBFGSc2oGaCXVVPoNScLUYr0rfFz0M2vsQ7uLeVHRRhjPa?=
 =?us-ascii?Q?x6ubibJxy/oEdB9hxojjXUbMahJxy2aulWO6yz+5qUc9SAgYf3qB9/UKth2E?=
 =?us-ascii?Q?wXfy72kojJuZ00IN9jvlF8wOY8VWqp0ry/QdfWxXKFYfvVkBp0gCpRlKTaN6?=
 =?us-ascii?Q?Ouo3r9QgCz2epQkSAY+kVZc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287bbc12-2f8f-40f4-84e1-08da8ff5bfc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 10:51:27.2858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHIQcFi+ez8CobVSxEkbf/Z7GtRJKZuKBxRc10C1yr1exlAJGaCl/COQo3EZ+y4gYAySY8BK4oB3KZFJETtg1EvoZUh5jWkj1viJUkmxSjzqGAMdvmvTwSKTYErw1HQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5962
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, September 6, 2022 2:19 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Cc: linux-kernel@vger.kernel.org; kbuild-all@lists.01.org; lkp@intel.com
> Subject: Re: [PATCH char-misc-next] misc: microchip: pci1xxxx: Include
> depends on PCI & select AUXILIARY_BUS in the Kconfig file to resolve buil=
d
> issues.
>=20
>=20
> Your subject line is way too long :(
I have tried to make it a little shorter.

>=20
>=20
> On Tue, Sep 06, 2022 at 02:05:55PM +0530, Kumaravel Thiagarajan wrote:
> > Some build errors were reported by kernel test robot <lkp@intel.com>
> > on the char-misc-next branch. This add-on patch will fix the errors.
>=20
> You should list the errors here so that we know what they are.
Ok. This is taken care of in v2.

>=20
> >
> > Fixes: 393fc2f5948fd340d016a9557eea6e1ac2f6c60c
>=20
> As per the kernel documentation, this should be:
> Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus drive=
r for
> the PIO function in the multi-function endpoint of pci1xxxx device.")
Ok. This is taken care of in v2.

>=20
> Can you fix this up and send a v2?
I have sent you the v2 but just now noticed that I did not include v1 -> V2=
 change history. I am really sorry about that.

Thank You.

Regards,
Kumaravel
