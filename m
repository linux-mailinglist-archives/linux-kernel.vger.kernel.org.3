Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7CF49D7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiA0CLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:11:46 -0500
Received: from mail-sgaapc01on2118.outbound.protection.outlook.com ([40.107.215.118]:41708
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231691AbiA0CLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:11:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci5f95oU9DnG5dT852c4I4YwiNYR5aMPmknHagR5Du4P1Y28wqJvCkIRgjVnO9+ZKJofhDyupdivPyqRp8TbM7fThDL7ibOKwQEbr9aqYvHfR0gUj9Jb+MFJSE5HJMnlAabY2XRPBw2Wu7SKCOjbOM5KlrrSul60nXd5SMOJrCLUtzPW7Jh8vufQvwijxV5TNw+j0FPBLzbG+jIZRnskuVNG4IPTGN719bFV3TRzB661aooj5hCxNalPdoyYanzTkL6DHZS1oKb52eOpgdB+U3NbrIVZHXCf/OwNdCR19Auitsen0KpvxOLaKF2q+NpJbjSzpR7z5S9RlN7BplJqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI2apDtkAfC/JE4yARB2Gr5aM5PZabAA78kLxZzmCl0=;
 b=DmZvO+SUz1W7+icazfG+cr81WfIVpEoX418PFUA9ZoNT3PlmQm8bNmpi3y8L6mp8Yag3UKqh5AZquhPqyFIjWndugXby5q04Mp4hwQcWIC2zqF+jss+RAIDNn41ihaBC7R2YMpMuY/CJrRpVNM4LzvoY52yoOgWPXqOh+0B/hNGHh/nKR8bIiuP5zqxPeEbfzXYgtFGv10VGG3O0r+bBvpzzI7BYLWT92KtzKurRsBmYABU0mJAHpkMdHYtJCFGAXjBrGK57+HXwN2Isx2JkygBGEvkgwfBevD+p626fe0wQfyxB+BM1v17uuydP/LD1edN8JOTRT1S5ZcG7GcRx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI2apDtkAfC/JE4yARB2Gr5aM5PZabAA78kLxZzmCl0=;
 b=r+BOo8oSQllKFT2NXcGYud/efdC/J/k2Yf9DLnBtKB/KQLWFYNQzLeH/8NiNhLDjlZKxExQMCuVZWnB7iEcHSThVBNacIqzOZctYtvL8cP4CJgBMNOWrD+MDLwcdjm7jzIhCP/EHpBGrYe+AtKyYgSBbJu0oe32I75EKm8YxOszPRQlzR8naEVu76MvX3wBoPVxJZkEBlqQS0YeYoDDyIlVM1K4SJN01Q9zgcgm0AigeeZb5V48o6wA1O88j8haMeJnvr7lFtpEoWvTrspIZgEvX+VYjQk+akQjCuhMriExlQAgKdh7m9XAHNnsv5y3MnAMEQfpC0omjSG4YH7cIYw==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by PS1PR06MB2648.apcprd06.prod.outlook.com (2603:1096:803:46::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 02:11:40 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 02:11:40 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Lin <chen.lin5@zte.com.cn>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH] usb: gadget: mass_storage: add READ_TOC cmd mask check
Thread-Topic: [PATCH] usb: gadget: mass_storage: add READ_TOC cmd mask check
Thread-Index: AQHYEpzAx/O8KtwQ2kKOB4xKcKk7Uax1doYAgACqmJA=
Date:   Thu, 27 Jan 2022 02:11:40 +0000
Message-ID: <HK0PR06MB3202A514A1CE186A29DFFD8380219@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220126100856.3680716-1-neal_liu@aspeedtech.com>
 <YfFwLDLX5D4dYLTb@rowland.harvard.edu>
In-Reply-To: <YfFwLDLX5D4dYLTb@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f25c6d0c-edfd-405d-45de-08d9e13a5b0e
x-ms-traffictypediagnostic: PS1PR06MB2648:EE_
x-microsoft-antispam-prvs: <PS1PR06MB2648492C2647F42724D49EA480219@PS1PR06MB2648.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:221;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YJDe6S+1gUXMcvNY/lEcLBtVkGf+gVxlkm13XmqeLBRAGAPhYI+h90X5DZ0fh2sy/oF7EOx9FfUDB66fpDVBqIFXG3VGyYmUeNcRiTPTbCQEVeDKzL7DTE/oT5tqKHfzumS9PULKwnPI3Exo91ITK9JrN5LJFNBaYJSb9SInkOQNdmd10utdpJKNesG1Fn74n7fsMKyDeI/pi1zA/a3APGDLmGGyRRhA36IRfgxS29uNNoAOqR+5zC1AkHIq4nL3sxutvB9XL4Ru43EZr1sQRNHcNkb2oWHDcUzbUahRGEO/sjLBF1EHzkTJ/4EsKCxEYlEfS2lwL/dNTFh+YW28PU9NEIDu6x7M4n0VBmi5QYPxhmzyzXlVvP4qzhuxi8yvjUJ2rDRlJdSWilhqrKL5nYZ9/7eModj/Qb6S+tW7c8oCLIFuwEU2YASNBUS4hnRGkg0SQ1tbuk9lq8vZLOJTAl9QleklmWQWMyErsGVFCrrhhqUXblYDAijZdpoRd+h1e2j2c7C0W2uqjzoH/BpGgSfMm4NkipQKA849UESG2mxQsKHaovamkrIXWcyDfyOQB92HxBe3+xsir9IIFbIDkJOjhzrp/9fYHzROgzv3Q2Vm5RurcARCAVEa3ojVCNPWUOMtbx5wQQjWhDk3EZWu6WkwqCrGlcFWqINILJYxeDtpbY1Cr7a0YrtYbmOTafvK9Y5lCFtSyZ987HkBrjWMxiXDfJYAZS9+wUvIfgVowj7y4RT5pur/7+1dBB7+9Duup3ltE3Bd4qQqVTrTLBJXoyulbKC0o81PYNnPlzz6UFo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(39850400004)(376002)(6916009)(26005)(316002)(38100700002)(71200400001)(66946007)(66476007)(4326008)(76116006)(966005)(8676002)(186003)(64756008)(53546011)(8936002)(122000001)(9686003)(5660300002)(54906003)(55016003)(83380400001)(86362001)(508600001)(2906002)(66446008)(33656002)(38070700005)(52536014)(66556008)(6506007)(107886003)(7416002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NufrSatL1cU+j73n2oLUWz6uq6PNWo+Edu6x0RltZFGfkGVQP5ei0lwfPFTh?=
 =?us-ascii?Q?w8EFfo8ZK9bVlNbZKJNXnXkLd/LckuxQxABvroVQH2oFsDbbzlv3u+TH4bNw?=
 =?us-ascii?Q?SCZ5SJZRU4px0G3ZCzVHGdNvvcto39R7T1sOJiUZ4M3tbhNFML07XESaV4Q3?=
 =?us-ascii?Q?RnfE53/v8hkw3uTepnHtZAwsxtt/0/Pa+IV9DCvC23Uc5+2eGG2s5tqO8aoi?=
 =?us-ascii?Q?LvXjDG+YaUJd1kNQuux7EO9QIwLbzddXVv6L4DtKaqHY43MS51KgDdl1RWs0?=
 =?us-ascii?Q?mhOJfj8wEvOvajlJ4bwBmqCnH9Hfp/ZgoP/RgcweKwGyRwU8RCnTE7u5ngfv?=
 =?us-ascii?Q?pNIHVkqGMIcjUkxYOpVbAz+zzkFRH71A17lRRkyi6ZO6aA3fcK8/WxtEEsfY?=
 =?us-ascii?Q?+k2EQDtOb5K5PrZz2DedlcxIK95NtMwko7b9mVMEsh4o+O+fwwBNFzwLe6uJ?=
 =?us-ascii?Q?H9BD1UEsk4SuVMjlKxyuvDPXmyHImDP4ekD411KvLxNdzcqsMO3YTsFFJDdH?=
 =?us-ascii?Q?II4JBp/C9U8qaOzU9qcgS9306Ui+PLgQxH4jkKov73Q28oEcJsU2aRVibpsA?=
 =?us-ascii?Q?ehtT2bieveyCwq+ylRJ18BKfbdqBBdHRIWvCZGz5IU9+x4bxTIcfDc/mNWnL?=
 =?us-ascii?Q?Yjkpte9cG8s/dZVh1f+eoso9a9K1CzuaBeANvsdC3DVxC3xYIy3rt7R1dYF7?=
 =?us-ascii?Q?IqyvR+PRKpoQrr+pkrecbDg7s5pyF07H+c436vUwtPbfCTEH+IWvPIGLQ5Nf?=
 =?us-ascii?Q?0s7vjJs9Ntv7gI1NOvJFXisNYM7NjIBYlGCFR3Uz/o62uKGg21igfEAvO1Zn?=
 =?us-ascii?Q?cVYEUULOH67baKV69j4cIoPa7RWtaO5G3e/QZjVbSZvq/O+ON1XdQQxmon5J?=
 =?us-ascii?Q?lO1J79kkerefrokeurz7nBLoq4gpI+KhCaQqntuIoPua4Kd6ZxgVMkpS/8Qz?=
 =?us-ascii?Q?qk9i5s1zFMPkG0ypbZ76W9bjQFRHPviajVP3mYmuAFQjJ1OPhI+FK+6Gx1i4?=
 =?us-ascii?Q?RSdt+locTHUUiS+9Dd6nPHjuYdA0HxyFY8FXjOUdQJvAJZkQv9owF3C8ux2y?=
 =?us-ascii?Q?yC11Fqos2xfmuYTxojlN3HpbpT9+XWLhZImM9ayDwVa1ait/OcsKOfXlwoed?=
 =?us-ascii?Q?/DS3x9ig9G89ZVNqbIsN2uaaDee5zC52T9DdPw8Dw5nlfrelYD59uRLgfBoq?=
 =?us-ascii?Q?xE1pzbKCHdNH0Qjaha8BOR4ds/NkIwamfN3QDSRh2daurY3OVUYALZR5puan?=
 =?us-ascii?Q?Ujqqv2mxqCdJqI1DYMxV+2P7W6FgJf/TsR0edB4V3YB6SZ4HyesJfIajWQO1?=
 =?us-ascii?Q?6U6oEMgr8ugBAVwdabyP8zUipxrxPvB34kN9YHfNeV66lG+cHFipWdgy5j0C?=
 =?us-ascii?Q?FCYfGEyVphX/VY5BPMVO0jeIPWjcM2VyKN2MJs5mzw4dwlmSNBghYuyhXac6?=
 =?us-ascii?Q?PwxyXTAoEdr8TlgN+SSynvSSuPjADSW6exvqCnzQ6wnBcvivTpp9FbzjCy6v?=
 =?us-ascii?Q?jbbIdi96UuIqwr6o7uhRAEoF2g0l4IL4Uh7rDlGFD2hO+pVY7mH0DSvqI0zw?=
 =?us-ascii?Q?4IMAYGOvCU6e5qogJYAHkIrq4K/lFP8xX90RUQitNsokkoQeLpaB7fC2lvjl?=
 =?us-ascii?Q?fHdHldf7qurb83eVA4o3zvI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25c6d0c-edfd-405d-45de-08d9e13a5b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 02:11:40.0400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tJAC1W5BBEOOwGeBbJStzRhOxu3WmBk8c/il0VIC42ZfpG3lahMnVDGMSjLUgs7qS/3tWQRcQtgosfzOafpSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR06MB2648
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Thursday, January 27, 2022 12:01 AM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Felipe Balbi <balbi@kernel.org>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Chen Lin <chen.lin5@zte.com.cn>; Wesley
> Cheng <quic_wcheng@quicinc.com>; Nikita Yushchenko
> <nikita.yoush@cogentembedded.com>; Cai Huoqing <caihuoqing@baidu.com>;
> linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-aspeed@lists.ozlabs.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH] usb: gadget: mass_storage: add READ_TOC cmd mask
> check
>=20
> On Wed, Jan 26, 2022 at 06:08:56PM +0800, Neal Liu wrote:
> > READ_TOC cmnd[2] specifies Format Field which is defined in SCSI-3
> > spec. Add command mask to avoid marking this sense data as invalid.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/gadget/function/f_mass_storage.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/function/f_mass_storage.c
> > b/drivers/usb/gadget/function/f_mass_storage.c
> > index 46dd11dcb3a8..14d51695b8ae 100644
> > --- a/drivers/usb/gadget/function/f_mass_storage.c
> > +++ b/drivers/usb/gadget/function/f_mass_storage.c
> > @@ -1944,7 +1944,7 @@ static int do_scsi_command(struct fsg_common
> *common)
> >  		common->data_size_from_cmnd =3D
> >  			get_unaligned_be16(&common->cmnd[7]);
> >  		reply =3D check_command(common, 10, DATA_DIR_TO_HOST,
> > -				      (7<<6) | (1<<1), 1,
> > +				      (7<<6) | (1<<1) | (1<<2), 1,
> >  				      "READ TOC");
> >  		if (reply =3D=3D 0)
> >  			reply =3D do_read_toc(common, bh);
>=20
> You've been anticipated:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=
=3Dusb
> -testing&id=3D89ada0fe669a7abf8777b793b874202a0767a24f
>=20
> Alan Stern

Thanks for you info.

-Neal
