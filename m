Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1055E302
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243223AbiF1B6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiF1B6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:58:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12411B79B;
        Mon, 27 Jun 2022 18:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6wxhN/bQLZ5VjuB+Q5W89SgI3JDAf3bBOLZobjNFn6VMcycJNQInpoEYV8QTyRlYfVgry6ipyMHElR3rvQqnuO0Cf/5b3DSiNwwlzbAOey6zl5g8KiLW0i0GHRz94F0bw8F2Mwbc5+/vT9I/9zZvvrwpuVVqCl39kIVMcr62S+K8lAMToQVn9vWA9e9tHXiOrdkQmnbbKynaUlVlIBbTGlMTaDaLOkhjs3bdNSPPxilfYeVRUO4WcITqIpJ4OA/JfgT8JcQueJ/+4SDQ6rj/4gssPmWnUCFjj/OtUEymPIfm+hdZsxu2qAZxbq4WIfWZOD8q3zFBEx2BqzeGqH/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zTxochy7KxhzdEvixkHCPlNSZo3M7D1qMhF+fg2S6c=;
 b=RY+7S2Mepbv5AOHOcg0PdsE+dkkXQOAFN5eZOPPFr0q41BN7yATIrsSssbVEuxtzBijvbb0hsixsyQxD0DsuUcMZfquZbXhLSceW3o6fXpca9OxK8pCL3XYGoqp5aF/AxQ6Sh42eog+bgwQt08Kc0vIy1Vwg17026RG8kGE1P4D3y8gPzP0/ZpQzJc5Lys8WrOUW9umPRxT/NV9Zb6UPkpuMEmrRmrbPTTDUW8xmjB0lsC3g6mZVJs5XfkSqGQbnuwYzsNGkRmTihncMFpy0U6UtNx/CICoJA7XLGOLtOvcff7ZusWDsyB9xcjURLK30YABmyk1H+mjK75l5eG10MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zTxochy7KxhzdEvixkHCPlNSZo3M7D1qMhF+fg2S6c=;
 b=PvMEt1iRIWTrP/dCOumdsR9ZGchIhITIZlNRxIXTIswFe3NcigMX5xATjxtxwMZ2uTDTmTINyv334Viggik4JgaqFNV3vbVNB/Ijo2HiDCXP/m7A8Mx1xbgMfj8r7uScZwiL94x9OwJT4DGLnihyE78RZ23zhZMsSvbG5zkAKhuVO7sR7F1/gY8J6ooAo843syyaf/p5wxvG/WJsyYfzJJZ5ihOG2hjL+sLQIT8kKETM/hu9Iq4w9JaHgxOsNCh9YJGIIbElKCURmfEzG8g/A4fuBk879JvPk62UYix0+LS6yLXbyvXXPQhE9VG6KXXBmSwhhR8i5OYh5W5MonugBg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SG2PR06MB3468.apcprd06.prod.outlook.com (2603:1096:4:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 01:57:50 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 01:57:50 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <roger.quadros@nokia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Thread-Topic: [PATCH v2] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Thread-Index: AQHYh3DSTidIVUKmfU2+k/4XOqVQ6a1engoAgAPzy4CAAMrSAIAAuStw
Date:   Tue, 28 Jun 2022 01:57:49 +0000
Message-ID: <HK0PR06MB3202C5E9147EA7E7B91C6B0380B89@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220624021916.318067-1-neal_liu@aspeedtech.com>
 <YrXJss4cTtfenu90@rowland.harvard.edu>
 <HK0PR06MB320272ACB1CA4ADFF8DDABC080B99@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <YrnEli0fdOERpIXe@rowland.harvard.edu>
In-Reply-To: <YrnEli0fdOERpIXe@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1a5d998-80f5-40be-69c8-08da58a99b0c
x-ms-traffictypediagnostic: SG2PR06MB3468:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: katz/wGsz814HqagIMtUacmAPeAKlpQAO+6N1f4SGz7N13m6SMrQJgvmh1YyA3kexQlP6AluYWr0GYciRxDtB85fVuV6rr69FDqJ8lH+lX26VffY+pLyeaEYxTeO1RPLU/+In8dOUB2OtivTU7SrbyC4xo+2QeuVi2yrKMyJj7pypIL1ikZluAyh4AjDABtXIqIm+H+MUX9huo0VOS57nbPKAhzyrVGSraBZlPpLI4LoSxEzvNM+rYw3kzBCqPBNMEUKvKfc5mdfTbU6gCFzmBLczJHyN1Av65ef6yZcAk+aFF4cbxWsYgluuzuNagR76tuY/Ua8qXQIlYTMndyMZ4iJv2op8m6rh80e5swWw+UKhYDeKoboUmbU0MV30KuOXZxw8AC04qG9rnDA1YzrfCt2HYg417uuuBxtu4a3+Wd3vARnKNDQqPSyMaSZir4LobgfP6xaeEIyUue0VnB3aqvosjIUw5PdIXFm0cxqWkZT2YznPWX8XvefUBOeT52EXESuxpluL7QvKdxEqEs8BAntPOI1CgfA2J+5fzwI/zhzDgspd5UvFJ6GjMW5pNHlZGIy26eltJo3j//SczirfQdvib2/59rVRnpWEAzi2ggYrKPIYfXEKO8pEYB8p1kekdZmD7iB7JUala50TqxfbRAuAfPKO8T8LWJpt13aUl1LkFQiE9aigcvSVANrzREfGjWfPFcniOGb5qPgWEhVYzUb0T8HSmaN8At5TGgm4N3K8mngtYw3lrcczqduRx3y7Lxxb8IifH89S+OIHQCJSmUMEjtjSNkRYVEQPa08fSc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39850400004)(346002)(136003)(376002)(52536014)(5660300002)(8936002)(38070700005)(76116006)(26005)(4326008)(33656002)(66476007)(66446008)(8676002)(86362001)(66946007)(64756008)(41300700001)(9686003)(83380400001)(66556008)(6506007)(107886003)(6916009)(7696005)(38100700002)(2906002)(71200400001)(55016003)(54906003)(122000001)(186003)(7416002)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2nEKWb96WrA6Pf9wXrgFmTcfjr7b8bqCf4ymQlemxY9HA1Nzt0iqMYcmQcfN?=
 =?us-ascii?Q?16QJ+w7FMZtfHuYt7EcxmorqIWQRKQlDkRCwRHw/ExjXcSDyXwvObZEC2wWs?=
 =?us-ascii?Q?kpCT24C3pozF8mKq3EbFJ9/0IFHHll/0XTBppFh0dIvhX/LiiyURHnyxP2Lo?=
 =?us-ascii?Q?AYwgC3pqkMaek+eVBEmUMX1BvxrrPVgMQr31FxYqIVjER93cQZRxmLOp9/ez?=
 =?us-ascii?Q?um0iArB1KtOSTbd1ry9PuKEt/rTFfK1BVxJ4LmaPE/7qP1rIC52TrYcRE7AH?=
 =?us-ascii?Q?7Q9e67+xyRE8PyspU1KW0BI6PgJOUOVIvOhg/VnR5iUqBxB8nr4tdjyNlrxH?=
 =?us-ascii?Q?shXefgwuNYaG5sJGpwMeyYUQWAy0iMUheZBNNZL6t2muI6Mjs4BLIHFD7HuC?=
 =?us-ascii?Q?0FfzYWs9PjqBGNX+JSF9dHm1BYgblHxMyTFa7/ebbNbgrlh/Vp3KQ7Nq/nSm?=
 =?us-ascii?Q?Sfmc8apazN5A/g1/663ZxSblp8ZF+F0RdlYpq3W1JxSWF5ZHdnYa9mXqrtg9?=
 =?us-ascii?Q?Xoh4+iU7S9JX1R4JxyXw+iPVZ9IwJ30yDtmgf0jE9y/f3ttG1QWByBcdVu3h?=
 =?us-ascii?Q?VYUFUKWnPnt1Zy4RPH48xocQ84fkbOfG0Meqej2U2y2RXFmxSycnQtI1dOrG?=
 =?us-ascii?Q?k+YiIyjiqqUp4oJFMUU657KFUygrD91usKzXRVscPnPTPtDbcNorJPB04sp1?=
 =?us-ascii?Q?/AFccZkFxyHeBE3G9ZczAGZdstid/Kox78lPdtipEXPSuxPpqNiVZbL30ISU?=
 =?us-ascii?Q?MSfPV+fu8UkatzMuT2pc3gxIqyqGhu+P1eOEwQWxyVnTkwgWLrvC3dzF412Y?=
 =?us-ascii?Q?GXfYZ3vMS8TA3LCjsCOw9frCQlWb3uxzKbqO7i9B/zmM/Eok6p5QaPdG+r43?=
 =?us-ascii?Q?ufc0h1FR7hQ5qaYk4ki+YNon+EbES2AEK0uJP1TR7t1L0z+6QS0Xo7zHa1I5?=
 =?us-ascii?Q?1AbTv8LQMqaz1/hOEpMMp71Q/s7ze/ND65UCBijz/Vb35UIKMDP44UE3qIgp?=
 =?us-ascii?Q?QV4+oQjjr2gUz4Cd52dofXmQjiu8q+bRrb4dTGaGA3wQxdS31KlckIxgZGAP?=
 =?us-ascii?Q?2xad8RdzWPDWJlokY/vxSlWXsnm1YqTNEJQQxoHG4mKVuA0EzDg/JcutM6Vd?=
 =?us-ascii?Q?mjynLdVGVEipZeLwo7GcwEPxY3dElR7OMaidreVkT1QMapi+AhlEr10m09C3?=
 =?us-ascii?Q?LggXPUQDiXddAp8Osu2T7jO+4HOhz6V9sPftswfh8zzWmLPsq0ndQZe6eJWh?=
 =?us-ascii?Q?GkeTibhe3ZtPL84KN/UWO5bDSwRlLTsIq8DWK1GqjWl26XPLKV4rK2gIXst3?=
 =?us-ascii?Q?LA0Q43A8OZJLY+/LyXq+PhL5G52Cfs3fR5nghWnYHgrkoR0K+nyAuhMl9Q//?=
 =?us-ascii?Q?AaWG1fzLhik3owXGfQRUJpumCu5oSrJNigne2ilsaAk9hbPJhnSTmF1x79Oi?=
 =?us-ascii?Q?Ozkk0BCJ5wjzkkYhk5lANLfFBMjr51Dt993PTLFi9gfB2wFWVt+5brsh2TTy?=
 =?us-ascii?Q?ZDz+Kabmtf2UVELfPt+p9aUeNY7bWTo/wJLgqvFIWp9fAc9b5CzOf2Upzf2D?=
 =?us-ascii?Q?QDF8/G2eZ4k00/I8aby0vkHRPUF49DE6avhu19Vm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a5d998-80f5-40be-69c8-08da58a99b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 01:57:49.9877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgFhCMPXLwTndTelfgRINi3jy9MkOFsayL2F942FMKkT7PBXmz9UdcVren/Zdz+WoU62AmESc/mPWL0vgIEpIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3468
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jun 27, 2022 at 02:56:40AM +0000, Neal Liu wrote:
> > > On Fri, Jun 24, 2022 at 10:19:16AM +0800, Neal Liu wrote:
> > > > Add read TOC with format 1 to support CD-ROM emulation with
> > > > Windows OS.
> > > > This patch is tested on Windows OS Server 2019.
> > > >
> > > > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > > > ---
> > > >  drivers/usb/gadget/function/f_mass_storage.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/gadget/function/f_mass_storage.c
> > > > b/drivers/usb/gadget/function/f_mass_storage.c
> > > > index 3a77bca0ebe1..9edf76c22605 100644
> > > > --- a/drivers/usb/gadget/function/f_mass_storage.c
> > > > +++ b/drivers/usb/gadget/function/f_mass_storage.c
> > > > @@ -1209,7 +1209,8 @@ static int do_read_toc(struct fsg_common
> > > > *common, struct fsg_buffhd *bh)
> > > >
> > > >  	switch (format) {
> > > >  	case 0:
> > > > -		/* Formatted TOC */
> > > > +	case 1:
> > > > +		/* Formatted TOC, Session info */
> > >
> > > This comment is a little misleading.  0 is formatted TOC, and 1 is
> > > multi-session info.  The way you wrote it, it looks like the comment
> > > applies to both formats.  Do it like this:
> > >
> > > 	case 0:		/* Formatted TOC */
> > > 	case 1:		/* Multi-session info */
> > >
> >
> > Okay, looks more clear. I'll fix it in next patch.
> >
> > > >  		len =3D 4 + 2*8;		/* 4 byte header + 2 descriptors */
> > > >  		memset(buf, 0, len);
> > > >  		buf[1] =3D len - 2;	/* TOC Length excludes length field */
> > >
> > > It looks like you ignored one of the problems I pointed out in my ear=
lier
> email:
> > >
> > > > When format is 1, the driver is supposed to ignore the start_track
> > > > value.  Your patch does not do this.
> > >
> > > Please fix this.
> > >
> >
> > Do you mean ignore the "start_track > 1" above?
>=20
> Yes, that's what I mean.
>=20
> > Do this check only for format 0? Or format 0 & 2?
>=20
> According to the MMC spec, the Track/Session Number is ignored for format=
 1.
> For format 0 it is valid as a Track Number, and for format 2 it is valid =
as a
> Session Number.  Therefore it should be checked for formats 0 and 2 but n=
ot
> for format 1.
>=20
> Alan Stern

Got it. I'll fix this in next patch, thanks for pointing out.

