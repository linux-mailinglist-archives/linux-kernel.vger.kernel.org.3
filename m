Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6B49D7DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiA0CLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:11:18 -0500
Received: from mail-sgaapc01on2138.outbound.protection.outlook.com ([40.107.215.138]:38881
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231691AbiA0CLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:11:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA632LBbloilmu1ayGdp2fuLWIzwq/dkLoGOZ6G251wk0gYrZRdBcAkD70GB2opl5ZwYNSKloO1iYiWOBqagvgk02wWJJpWEvjYC1QrUAR5uxSpBZbxnbIj05I527rT0Je8O+TH2z9Fm6hs/JNGqihev43F89vhV7YZtu9kLKzPbCtjg+J6+JCJQD3T9erV6IiWivHfAJQlWlS2UIZzjg9Jgd4QbqPX2i0e2/jmbDPlAdA1/obSDbZKR/ibEv7xzLTOUCfelGSxDQBT+zyErTTunwbjHLz4zEuln12fhwNGBkBZqk+UQL26mxoJOLjVmdrya+X3XNsIxggfwFv7TQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF0Cvl6JS9Z+RonNy5q6j0/AGWQdp0Z9d25NA6T+0wI=;
 b=ZqVLnqxF2JxRWjYS31hc5l3tXlAlAnnhJf35GrHepdF3I1QYc7pvM/50W4cTeW9z3O4KLKnJx39/p9jIz8u/JUoVbEzc9AvuJTz1MMgqLl4gQVt10c9kf+VaPJhs/FTW5907Y1azHM3e+EOmOxVdLutGCqZEZVnjOBOqessCyYN7LqhtoLfNFwwWzAQqtotK/liT5rsVBAVbuB9YG2RG1P+L2EkSTQN16rHOyL+fUgC2RxaVaTLCHAoBekkN7tYBgzFKERuBxlW/o4/nko2kQJ6H10nQ99hfgX9yn67TrWDLy1uAebTY6/AzryQv7cb0avSNFgNfFZ4TjOGbHVx4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF0Cvl6JS9Z+RonNy5q6j0/AGWQdp0Z9d25NA6T+0wI=;
 b=UVR1KJIZyyGeAMcB7MjWmMs35Q6gv5KvSpKxdnJIIQPrtw1oM5cY8GM7HGOhHZQzk9NScEIOjwXejbN+L0TmL3YxOFzP7t+i3UVOIruwLsdSbpj8UlLzeKvUUqwKfCfp2cnn+6vwmpq5B/OtvM9DlQys3MNhRZ69fSloS+oEXwlP9xKweP168gh5B41zeGfOV+L9fnUrP8hBIIeOdDXVYrI56yFqXlFDqQAqveMnPMjKTyUoA1C3uJRHrn61gXdaqYeXhjKZUcSd/Ui0IIav+L400rOa21/NN0pWhuT+3uZsikxCB6XbxrycTaw328ICSiVIM0Ijd3Zta2lnosqZ5w==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SI2PR06MB4028.apcprd06.prod.outlook.com (2603:1096:4:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 02:11:10 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 02:11:09 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Thread-Index: AQHYEpzAx/O8KtwQ2kKOB4xKcKk7Uax1IAeAgAD+GuA=
Date:   Thu, 27 Jan 2022 02:11:09 +0000
Message-ID: <HK0PR06MB3202A4690440C2123A2D76D880219@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220126100856.3680716-1-neal_liu@aspeedtech.com>
 <YfEnnWuL1cC6airb@kroah.com>
In-Reply-To: <YfEnnWuL1cC6airb@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26504d23-d97b-4879-442c-08d9e13a4909
x-ms-traffictypediagnostic: SI2PR06MB4028:EE_
x-microsoft-antispam-prvs: <SI2PR06MB4028A8E2863BFD6DBB1D3A0280219@SI2PR06MB4028.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c6ebP8SQZE6Lb03mvny7V1cUgtKatRk3gJkWIHob6HNWp8Qfj9vg/XbMdFV3DM0nrRmeK8X+wMM9v/Ciiu66kgGrdd2kpF+oBGcRIgzt9bJJkRMqvwvp1UeamHPjPF6yPDLTZSLr4WCagJAN8hod+Krsp+rPmjvun/V3tV6reE4qID1vhPnoV/YSkZvX7qY87a3Lji0airUribbRHlibz5j8hzN+WoePaVPGZx6BLDS73KWAFLB/20UUE0r2GzucSaIcd9z3hHpZfvmUjm2Mi9dRm6qFGauKY5sssB3C681aPh62GamlWoi7sRkDyAaF0nfE0fa0uZNqOBMnsuA8Uk36mXSsUcf8jYCjl3B3u4kyizXbuExLTDs5sml6q60s6du5aWK5y3tBu5GZ9lIzUKe/LqVMCqP+Kwy4yNBLwufRmDNA0qoVIdrZNNevN8so38RDwRnGZvcgy7uU683YxLOu8YjY8m/vMyPOb20xsuGmXqbk1LiFTUsKEaZqXgW+PChcGe3UPJud9vfbD4GwETn5kSKH9FH88UsOpFkeySMNKkwYmeL/0aA12Jj30LCi34tsViBWTthp/+zP+xO3YFe1k+Vl2+v6grVTPRCAA5P8ib5r9yOZgI1mvhZ4odDenUX05qUy5QuKnjkUr1miaPlhE7lGT0MXHdsZY8NfiwcsDHXz9+Wt579TI6Ui53ucYq9PRzB2RtivBg7Zg0RzwHK2XVxk6LeGAbCx59nZsjRJDbhrr5tiyk4lN2IPgw5sYmHmzJVs4pHx5/1QGtPqg7HgBqkXUOIC6UI3wHs5vXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(136003)(366004)(396003)(39850400004)(376002)(9686003)(508600001)(83380400001)(53546011)(2906002)(86362001)(26005)(186003)(33656002)(966005)(107886003)(6916009)(316002)(71200400001)(52536014)(66476007)(7696005)(66946007)(122000001)(5660300002)(7416002)(38070700005)(4326008)(38100700002)(54906003)(8676002)(55016003)(66556008)(66446008)(8936002)(64756008)(76116006)(6506007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U2s4jgMpAZRQv9WFhShMntk261KnGdplsSHgXBHWRG2kBMWjakYzj+BaHsgV?=
 =?us-ascii?Q?BZF5WKmOS2nJeRHqEJaM9OyoDrPOPgNmR7o1QyTsPbnMjfPlCe0au6ggbvi1?=
 =?us-ascii?Q?5koNbfrk5UTK8VW+jiN4UAK/Kxss81ymwUgVbb7CHJ1JpqipIHbyXALNkjU2?=
 =?us-ascii?Q?DoZoZCY8m9FnCcpIgRb8nz3MuvvRyyrEFxOQTlh3tXH7iL6a1ehK6R4ngUAq?=
 =?us-ascii?Q?JOOaYdB8DhoxQpdyh/9p6ReqT53FwRdXjWpmOVS2dvvlXxeuMflSjZ+Kh+6X?=
 =?us-ascii?Q?SS5wzKCdqOqpG1SSAvRuDBlZihTj6vr/OAMD6cc39dLiWi6uwmIZh5c8TTAT?=
 =?us-ascii?Q?TVfzTtKHRigC/BWNcTeXC/gLb1RJ8S+VsDN44Auu35ETY/Uf75GeMMmr44RT?=
 =?us-ascii?Q?vu6gPFuWc728XKj7L02J4VlqGEW91gsNjXP27VhlE4VNtDhLAWfPZ3LUy3Zx?=
 =?us-ascii?Q?WBhkj2G0buTLiln/tFkLsudbfrvpqi83HHjfbp5ProyKR/eJ6InBEPlf9siC?=
 =?us-ascii?Q?nsuu5bAv/ZoRjYsa66bLNa9ZhpeECFRKxA4KueoPUWxay75qHPl1JuAWAgTp?=
 =?us-ascii?Q?P7vq8Q3hfMJI8ytDplvFch7Lep2N16OnDqaTA1w4eMVQQMXFtQmM07rpSnE9?=
 =?us-ascii?Q?+EqfaIHSFU3to0A7kpaitAeyrKvxdo5zWMN5NBpxaxeC4cOvMJSdpDI8OHGU?=
 =?us-ascii?Q?g56Epl5XvMUySz04Kkd5yPK97F6e1TD/brQ/+cKrmXJG7G3iAjbRYGUxxKH1?=
 =?us-ascii?Q?+RJCYPKpLSMg2n0eR7wMnK2IYYDoP2MYGWvx/IKaLZRW3l0kip4GFc2peRNA?=
 =?us-ascii?Q?UWgRPnyhHIpcxXZWaTFmZ6kEg+E4jMofjM4qNgwKf+BAeVPU7NmvZwQ4lSQ2?=
 =?us-ascii?Q?81Mntj8TDMNH8ieGVhYHkkaaOSwoJtcrUzrqSjhWQyaVWd/3XZYHeNNFLYEo?=
 =?us-ascii?Q?rmE6mXvFeB+B0XZlfxrqUicNT4Dx189/oc7QSpP4UGYYbsQyEfePOqS7lG8H?=
 =?us-ascii?Q?6Xk5LxBYWRR5JqdyaHrFjgOiR2Dw3LVwjXbSx/it0ATfcbtvMxvZ7erP4KFd?=
 =?us-ascii?Q?IRickXvd1ZIXkSBy6vQfbgSLyliOCrylEzmfjUKDK/MkSyUXIOe2bhFfOZsi?=
 =?us-ascii?Q?YXMi/bhbv0Vz5FPU+XrOwkB1+jd7y16OgYwEjnAqRVxmAE/5FdVS41YCu59l?=
 =?us-ascii?Q?6sOpE2OExoyp6faY+aj2e6pLVkJ+oYLC+iSFvwfYgdUOpLyKhKxTLixkFd+z?=
 =?us-ascii?Q?uFsA7D4P3+BLQYYl2ksohnIKDhbhievpQdYcyK2+cphTxvXQTQLKM9JxVTVP?=
 =?us-ascii?Q?VdQCkPUjbIFEhbyvDRPsTjxTPsy3aQMoLga4PihbhOO6PyLXZqItwuMENoFB?=
 =?us-ascii?Q?HfUtAfEECuz9wdeTpbo9aCxgkoIzkZc2zEbBQCvnjVG6Gi6GcbYZyC8acKLD?=
 =?us-ascii?Q?8cEgjeEXhAyiZtHWakJHIyDUAkK4rZQW/wy/0xKVahRlfY+Okd0hy+01DUkC?=
 =?us-ascii?Q?oxvFArEjp4IsfpwM3czXX6m4ghEs3RIKkSZSyE+c1rACJ43ojBa6gmoC1+09?=
 =?us-ascii?Q?LPau3K8tSDGvW7bKmTfUmlaB5kWJqKgQ4KUM7DDb6Q8Cx9ppktRYGx6WHixM?=
 =?us-ascii?Q?1hrN1NfDrFSXyqIhV46C/RE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26504d23-d97b-4879-442c-08d9e13a4909
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 02:11:09.7145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dk3QRT9zUpau+HdA0H5CVwQvmqi7kUenSQbBT87Mz/FJj6n83pBYOJn4NZNPixNOzWaVf/FiU0wLYrqNaKY5CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, January 26, 2022 6:51 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Felipe Balbi <balbi@kernel.org>; Alan Stern <stern@rowland.harvard.ed=
u>;
> Chen Lin <chen.lin5@zte.com.cn>; Wesley Cheng
> <quic_wcheng@quicinc.com>; Nikita Yushchenko
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
>=20
> Can we have real names here instead of magic numbers?
>=20
> And what commit does this fix?  Is it a regression or has it always never
> worked properly?
>=20
> thanks,
>=20
> greg k-h

This patch fix Windows Server OS installation failure problem.
Since @Roger already sent similar patch fixed, I'll try it.
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=3D=
usb-testing&id=3D89ada0fe669a7abf8777b793b874202a0767a24f
Thanks

-Neal
