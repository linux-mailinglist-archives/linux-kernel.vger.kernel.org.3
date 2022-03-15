Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD17B4D9BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348617AbiCONRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbiCONRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:17:09 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14252B0D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:15:46 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FAEtvS004832;
        Tue, 15 Mar 2022 14:15:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=vkF6ZL1+2SmY3PQK6HChe6LqIcX4Zvk/2SLNralmMSI=;
 b=waFvQja8E1VTuNWw7nJLoTIlqUD3PLBzH5qRTzzW43CFG092TyV8xZS8GTonc34ihK2j
 ybmP4ZeBqL/32IXW3vJdZqdTK2yxbSGx5MR25r8vc6C5gnxTG57rPeIlfuqBS5xXhvYC
 RpRYI3Rq9n82q3dUlNBMBMHT0ldLvyMzIY1sVP+ZIJ2Y4CKok08ZOOaU0SiBhuF0F8Kl
 ZYmSndyWbA013rHmYWDIPrwPQMilw0QBdmmJigjCKc4sXqsw9YDtG312iFWdN80yuRkT
 C83zp7SjybDbxc7l9xzzgk163W+74H1jeBa22SBxT/df1wIvOAEhH1lP2CB68JdYR0Nq dA== 
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3et63hxm9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:15:28 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtE//7hivhTs9Qe7MuWt0GLZUWcPJ/JqGSFoscfXIsLm6OJ1WCfjGk4bPQQqbBr4xYLyCjg2sy9tV70RwFTzyCTXrleNYLpvyHwO9To2RVsZbDjY8Lah8lJjF1dRq+W0QZcX2E++ghtlhcbYDPRWblLBdU6L+HMKBhFpXWBUFGcQErTDijNG//sRuORFLummw0/whgwPvYVfrBm/oY6qtYCYRRDAMiyQ9L+EjrzUBdBDFoiCU8bZ7JBlIeHtmVVPx3PDeaE7HkLZtb3+s/LhXTrRRLV0oQq5JXtLEAaa0JpouIb4jkPW/9Up0qOLR5+tAd2WOIFSZxrmRvjj4doQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkF6ZL1+2SmY3PQK6HChe6LqIcX4Zvk/2SLNralmMSI=;
 b=AC6YTJsrx+cm5+3K1ugAD22siiiVDPYoYgdVhmyErEKmRoEaphDFNkpV+FqdBb4dktuFmjW0uQFfoCxVDd9ZYfQ2WY2kzHEJMZfyJculYP46aU4utDqWTll7blj6a0MaFN+xiH+OE3A6RivFsJh54cwQiSrhC5lmNd3DMcVCOGpQhqA+xX/P+/ap0RQmsDWeGwzfbWFd1kN2yaiMNaec2lWPPHjwusHq1k7ej4bkNpadhmo6dpuWUhgNM9Au7xluBk+BBN1ApTyfc9ULGjqaEnq0zLV7ZaErOtsjXjF3PR/6vAAHVl+brx4EM5UCyWvVplZa5bU5Yzqe2zHwqJVcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:158::12)
 by VI1PR10MB2399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:80::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 13:15:21 +0000
Received: from PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d0:cd92:31e:43a0]) by PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d0:cd92:31e:43a0%8]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 13:15:21 +0000
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
To:     Takashi Iwai <tiwai@suse.de>, Daniel Palmer <daniel@0x0f.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: sti: sti_uniperif: Remove driver
Thread-Topic: [PATCH] ASoC: sti: sti_uniperif: Remove driver
Thread-Index: AQHYOEz3Qrd7t7b+7keIJTzYLpkdlazAPfOAgAAFRzA=
Date:   Tue, 15 Mar 2022 13:15:20 +0000
Message-ID: <PAXPR10MB47185B76D5F38482FB1125A5F1109@PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM>
References: <20220315091319.3351522-1-daniel@0x0f.com>
 <s5h8rtba4to.wl-tiwai@suse.de>
In-Reply-To: <s5h8rtba4to.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2022-03-15T10:46:25Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=f42984c3-5626-4b09-a81c-1f5777bed597;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=2
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_enabled: true
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_setdate: 2022-03-15T13:15:17Z
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_method: Standard
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_name: 23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_siteid: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_actionid: bfb3088c-a596-46a2-9110-f8ad535ae958
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_contentbits: 0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a2c531d-3a93-431d-d57e-08da0685db93
x-ms-traffictypediagnostic: VI1PR10MB2399:EE_
x-microsoft-antispam-prvs: <VI1PR10MB239970D7F5DB963F0C9C8226F1109@VI1PR10MB2399.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z3if9K3rCWePs7EV80IXpn/6Ypjv5eEyzXVYwuwQFy3VSWTG2A99Y2dMh8yac7Gd4TBwpWYvIppBLaTtFCVhfjhojS9wEWZ+bi5XtD3NKjAgwxUd4eqjqhVehN2dpkd+QY0Ltlw8dwsIdXmRyU1kTTpwr6m1nvcEb3qgyuN+cFGaz6SMz4h574RzHpk9R3PhJSMcIxlt4AzFqRsrXcCt3ppPcBcBm7dSCWc+eJGoufCStMl8jffwv2h0Oa/wIvFzrblnqTufswOwbMS9oMYuhlgnzMGRskYbQyrbdBq4mw+zTxwdtvdonI2EC8WvjreVDTNoVfs9Z7RKIECNb7KK9pQ/wRC+SnvwXJbfygHSB0lun/dkVhwQfXJr5Qlpqhap1Z2orLznN4mB9ivVohCE8ikUrk6vGNAobqZkVBaNCiZPT/XkzqGzEyFr3HuY73Z1XhHlpGT6hrVuv/Gp/Ftgon+asEHoQZ67VhSwKDg8yo1/6YijqPVqzQHRuAUCiT7n6fI/eUUTVK69q1z+0HaeNJCSSNxjijiqLetq2PrygtpjmWAJyRVEQN/UObkaCbTY3MBXWhmMSXoCw/D+cnQCudnJyGU239J+sCOCmWyK+2vA8kf+4jVzy30euDixXUX7KEOMJWbRn0dchMHQXtovH6EzBMHEm7es1WVDLqS2tz9MynPQRPj/BJgc59xH2AzdDHc0V/OmE11geX1MRCeDwxHD9wMmMqq3InIre6UAGcyIvZoiFfZpblG78RgQ1Qo81Lah6aXUzkv6J7AaVcdFP8ViB0Hm2rtEibsbBx2aDXQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(8676002)(33656002)(86362001)(52536014)(71200400001)(8936002)(76116006)(38100700002)(66946007)(66556008)(66476007)(66446008)(64756008)(122000001)(4326008)(316002)(110136005)(54906003)(5660300002)(55016003)(9686003)(30864003)(2906002)(7696005)(6506007)(53546011)(966005)(508600001)(83380400001)(186003)(26005)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/i7+VSQNM314dae5QtKf11m/kttwWPrgXVbtprNpBNWfedHrp8sHxHz2Gyty?=
 =?us-ascii?Q?RDYkS2s2JeKN4ZMhVf6WJofGZpq7iDTWpy2F47DvezhEfCxI2ETbfHaacDPc?=
 =?us-ascii?Q?3tEtpPY6Xfppv7rPB8+boTYaUPP/wNGinbl3KDjmlkip3r6XwaXCR6Y+JLRW?=
 =?us-ascii?Q?SFX6Wk3dwssIwAnSQwBmMb8fR74wKgc1OY3HVZByrFxr2A2W1GRKNLgohGqd?=
 =?us-ascii?Q?qlzvl/Tu/RQ5RxmhSAIIcWnLa5xb7VFalHkyxaKqwQeVajyoOOc892Rix5vv?=
 =?us-ascii?Q?A03w1U12vpX+tXVECcdGOvUATYhEhsgilB+1DwkGtP9pC29yY8nYGByYcdyg?=
 =?us-ascii?Q?G/cQ4MjtoNJPSSMA0vrfdqAns2E7k92ZIG6PeCuSfo54urMjLPySQjrdadEi?=
 =?us-ascii?Q?KAIZWf36elghS1vX4jFQkKVgnuA9SFOybTpfakOgxHZujucCv1x/JzL6QJUK?=
 =?us-ascii?Q?5yNi54CqGDXT7aJl2VtJJLn2twecRirieJXw0bKTV+Lq2d85+Lpt8Z7ISO6v?=
 =?us-ascii?Q?m9INP8GFQHbmNVfL5J33tyNMDovFNoW5GunmAc2GYxDXJSBwD/qHyV8P74vu?=
 =?us-ascii?Q?2PvWJY58VALhrIkgcJLzDWAaeCy9QCvdkXYJ5tue26kVht1UPWZJ4pTOHm9Y?=
 =?us-ascii?Q?8BTOhkqYE9L22SuJ1uOx35GIf7/1TU7WaG9wDgDoLlSkFZvTbCn3YX8F3g/d?=
 =?us-ascii?Q?LeeNyHrc+l+BXF+cdsr/vGoNZRPjuD1qSMWctEDUYORRVXtx5wGf8oegBR3U?=
 =?us-ascii?Q?P4XfX7CcpPUB0LTzJ5PRvkdXQQM8kle431YH+lRSpZM65Wvs3zjfwmawLQhN?=
 =?us-ascii?Q?JoTpkFvLKLzw68/18MOFQhVNBL9U2iCWMLWIZ/lwPNcnHCy5JA4fyt00FxUK?=
 =?us-ascii?Q?97QMW8uV0r61AZZQDDaDG8wkOg80LvyRcvjH+Bbh0zVv0FZxp2G0TBI7ylk9?=
 =?us-ascii?Q?4uFcm9NpHaShEbJXvgTpU9otu3y1w+60EV6mnmxHA5YZCpGbD5HQJuABCh5a?=
 =?us-ascii?Q?f6vDV4bmQAQonROIKgXMqLXZoi5rO++ebF9/kcansH0dO9+NY9Fr9YhWTAwC?=
 =?us-ascii?Q?NzQ/Es3acmjSzem6ywFo2jeDxkq8jDna0FpTjTxEBxFTZWwkweWY7raOKuUy?=
 =?us-ascii?Q?o90aIai96c8Oxd3dMLrnXgVgGxTTtOAb/hdEce+jazTlvvrVA6O6NHLamffj?=
 =?us-ascii?Q?KiASpe3ZttoEz+hRdfdb4cAaZW5AFU9YOJRofjM3NhGxQ7jCGedg+CXCaCkn?=
 =?us-ascii?Q?/ILG00w7Q9Gtk5eIGjrse2VfZJrpDX3n8DAkliQG0oW8RZlVl3qaiN2s0z4y?=
 =?us-ascii?Q?9xTd2N51bxdyIPiEW+WNzUZorqH7qUKisqY1vpNuTt7LbwkobVemuw233rzR?=
 =?us-ascii?Q?TJPgcPGpX7K5G8aliEGhlx+o0EUOhmbfOyv48qiq1SsQd3DjXr+xqkl8odQF?=
 =?us-ascii?Q?n08Gf9UBdtiyweVv57QdquQiv0MD4mUT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2c531d-3a93-431d-d57e-08da0685db93
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 13:15:20.8943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKeUXDYBPHGuwsT5IB5JJgXXjCkHJPUbcI1zmbYui5f1Y0N18SkPTeqL0mdRvHZedhRnQWj4EzT+K1WK3Oxysg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2399
X-Proofpoint-ORIG-GUID: evukZXN2FkJ3dwY2V2Bz0qBjqlam8fDh
X-Proofpoint-GUID: evukZXN2FkJ3dwY2V2Bz0qBjqlam8fDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_02,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


ST Restricted

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: mardi 15 mars 2022 11:28
> To: Daniel Palmer <daniel@0x0f.com>
> Cc: broonie@kernel.org; tiwai@suse.com; Arnaud POULIQUEN
> <arnaud.pouliquen@st.com>; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] ASoC: sti: sti_uniperif: Remove driver
>=20
> On Tue, 15 Mar 2022 10:13:19 +0100,
> Daniel Palmer wrote:
> >
> > This driver seems to be in the "only good for attracting bot generated
> > patches" phase of it's life.
> >
> > It doesn't seem like anyone actually tested the patches that have
> > been applied in the last few years as uni_reader_irq_handler()
> > had a dead lock added to it (it locks the stream, then calls
> > snd_pcm_stop_xrun() which will also lock the stream).
>=20
> Mea culpa, that was an obvious deadlock I overlooked in the patch
> series.
>=20
> > Seems best just to remove it.
> >
> > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > ---
> >  I've never used this driver, don't have the hardware etc.
> >  I just noticed that this looks broken when debugging my
> >  own driver that uses snd_pcm_stop_xrun() and was looking
> >  at other users to see if I was using it wrong and noticed
> >  this was the only place that locked the stream before
> >  calling snd_pcm_stop_xrun().
> >
> >  There are probably some other bits of the driver that
> >  should be removed but I didn't look that hard.
> >
> >  TL;DR; This driver seems broken, seems like nobody uses
> >  it. Maybe it should be deleted?
>=20
> Yeah, that looks dead.
>=20

The platform is still used for instance:
https://lore.kernel.org/all/1d95209f-9cb4-47a3-2696-7a93df7cdc05@foss.st.co=
m/

So please do not remove the driver

The issue has not been detected because it is related to an error that=20
occurs only when we reach the limit of the platform, with application
that stop the stream at same time.
So almost no chance to occur.

> OTOH, if anyone really wants to keep the stuff, please revert the
> commit dc865fb9e7c2251c9585ff6a7bf185d499db13e4.
=20
Yes reverting the commit is one solution.
The other is to clean-up the snd_pcm_stream_lock/ snd_pcm_stream_unlock in =
the
Handler.

I will try to address this in few weeks=20

Thanks,
Arnaud

>=20
>=20
> thanks,
>=20
> Takashi
>=20
> >
> >  .../bindings/sound/st,sti-asoc-card.txt       |  164 --
> >  MAINTAINERS                                   |    7 -
> >  sound/soc/sti/Kconfig                         |   12 -
> >  sound/soc/sti/Makefile                        |    5 -
> >  sound/soc/sti/sti_uniperif.c                  |  506 ------
> >  sound/soc/sti/uniperif.h                      | 1416 -----------------
> >  sound/soc/sti/uniperif_player.c               | 1148 -------------
> >  sound/soc/sti/uniperif_reader.c               |  436 -----
> >  8 files changed, 3694 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/sound/st,sti-asoc=
-
> card.txt
> >  delete mode 100644 sound/soc/sti/Kconfig
> >  delete mode 100644 sound/soc/sti/Makefile
> >  delete mode 100644 sound/soc/sti/sti_uniperif.c
> >  delete mode 100644 sound/soc/sti/uniperif.h
> >  delete mode 100644 sound/soc/sti/uniperif_player.c
> >  delete mode 100644 sound/soc/sti/uniperif_reader.c
> >
> > diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.t=
xt
> b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> > deleted file mode 100644
> > index a6ffcdec6f6a..000000000000
> > --- a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> > +++ /dev/null
> > @@ -1,164 +0,0 @@
> > -STMicroelectronics sti ASoC cards
> > -
> > -The sti ASoC Sound Card can be used, for all sti SoCs using internal s=
ti-sas
> > -codec or external codecs.
> > -
> > -sti sound drivers allows to expose sti SoC audio interface through the
> > -generic ASoC simple card. For details about sound card declaration ple=
ase
> refer to
> > -Documentation/devicetree/bindings/sound/simple-card.yaml.
> > -
> > -1) sti-uniperiph-dai: audio dai device.
> > ----------------------------------------
> > -
> > -Required properties:
> > -  - compatible: "st,stih407-uni-player-hdmi", "st,stih407-uni-player-p=
cm-out",
> > -		"st,stih407-uni-player-dac", "st,stih407-uni-player-spdif",
> > -		"st,stih407-uni-reader-pcm_in", "st,stih407-uni-reader-hdmi",
> > -
> > -  - st,syscfg: phandle to boot-device system configuration registers
> > -
> > -  - clock-names: name of the clocks listed in clocks property in the s=
ame
> order
> > -
> > -  - reg: CPU DAI IP Base address and size entries, listed  in same
> > -	 order than the CPU_DAI properties.
> > -
> > -  - reg-names: names of the mapped memory regions listed in regs prope=
rty
> in
> > -	       the same order.
> > -
> > -  - interrupts: CPU_DAI interrupt line, listed in the same order than =
the
> > -		CPU_DAI properties.
> > -
> > -  - dma: CPU_DAI DMA controller phandle and DMA request line, listed i=
n
> the same
> > -	 order than the CPU_DAI properties.
> > -
> > -  - dma-names: identifier string for each DMA request line in the dmas
> property.
> > -	"tx" for "st,sti-uni-player" compatibility
> > -	"rx" for "st,sti-uni-reader" compatibility
> > -
> > -Required properties ("st,sti-uni-player" compatibility only):
> > -  - clocks: CPU_DAI IP clock source, listed in the same order than the
> > -	    CPU_DAI properties.
> > -
> > -Optional properties:
> > -  - pinctrl-0: defined for CPU_DAI@1 and CPU_DAI@4 to describe I2S PIO=
s
> for
> > -	       external codecs connection.
> > -
> > -  - pinctrl-names: should contain only one value - "default".
> > -
> > -  - st,tdm-mode: to declare to set TDM mode for unireader and uniplaye=
r IPs.
> > -	Only compartible with IPs in charge of the external I2S/TDM bus.
> > -	Should be declared depending on associated codec.
> > -
> > -Example:
> > -
> > -	sti_uni_player1: sti-uni-player@8d81000 {
> > -		compatible =3D "st,stih407-uni-player-hdmi";
> > -		#sound-dai-cells =3D <0>;
> > -		st,syscfg =3D <&syscfg_core>;
> > -		clocks =3D <&clk_s_d0_flexgen CLK_PCM_1>;
> > -		reg =3D <0x8D81000 0x158>;
> > -		interrupts =3D <GIC_SPI 85 IRQ_TYPE_NONE>;
> > -		dmas =3D <&fdma0 3 0 1>;
> > -		dma-names =3D "tx";
> > -		st,tdm-mode =3D <1>;
> > -	};
> > -
> > -	sti_uni_player2: sti-uni-player@8d82000 {
> > -		compatible =3D "st,stih407-uni-player-pcm-out";
> > -		#sound-dai-cells =3D <0>;
> > -		st,syscfg =3D <&syscfg_core>;
> > -		clocks =3D <&clk_s_d0_flexgen CLK_PCM_2>;
> > -		reg =3D <0x8D82000 0x158>;
> > -		interrupts =3D <GIC_SPI 86 IRQ_TYPE_NONE>;
> > -		dmas =3D <&fdma0 4 0 1>;
> > -		dma-names =3D "tx";
> > -	};
> > -
> > -	sti_uni_player3: sti-uni-player@8d85000 {
> > -		compatible =3D "st,stih407-uni-player-spdif";
> > -		#sound-dai-cells =3D <0>;
> > -		st,syscfg =3D <&syscfg_core>;
> > -		clocks =3D <&clk_s_d0_flexgen CLK_SPDIFF>;
> > -		reg =3D <0x8D85000 0x158>;
> > -		interrupts =3D <GIC_SPI 89 IRQ_TYPE_NONE>;
> > -		dmas =3D <&fdma0 7 0 1>;
> > -		dma-names =3D "tx";
> > -	};
> > -
> > -	sti_uni_reader1: sti-uni-reader@8d84000 {
> > -		compatible =3D "st,stih407-uni-reader-hdmi";
> > -		#sound-dai-cells =3D <0>;
> > -		st,syscfg =3D <&syscfg_core>;
> > -		reg =3D <0x8D84000 0x158>;
> > -		interrupts =3D <GIC_SPI 88 IRQ_TYPE_NONE>;
> > -		dmas =3D <&fdma0 6 0 1>;
> > -		dma-names =3D "rx";
> > -	};
> > -
> > -2) sti-sas-codec: internal audio codec IPs driver
> > --------------------------------------------------
> > -
> > -Required properties:
> > -  - compatible: "st,sti<chip>-sas-codec" .
> > -	Should be chip "st,stih416-sas-codec" or "st,stih407-sas-codec"
> > -
> > -  - st,syscfg: phandle to boot-device system configuration registers.
> > -
> > -  - pinctrl-0: SPDIF PIO description.
> > -
> > -  - pinctrl-names: should contain only one value - "default".
> > -
> > -Example:
> > -	sti_sas_codec: sti-sas-codec {
> > -		compatible =3D "st,stih407-sas-codec";
> > -		#sound-dai-cells =3D <1>;
> > -		st,reg_audio =3D <&syscfg_core>;
> > -		pinctrl-names =3D "default";
> > -		pinctrl-0 =3D <&pinctrl_spdif_out >;
> > -	};
> > -
> > -Example of audio card declaration:
> > -	sound {
> > -		compatible =3D "simple-audio-card";
> > -		simple-audio-card,name =3D "sti audio card";
> > -
> > -		simple-audio-card,dai-link@0 {
> > -			/* DAC */
> > -			format =3D "i2s";
> > -			dai-tdm-slot-width =3D <32>;
> > -			cpu {
> > -				sound-dai =3D <&sti_uni_player2>;
> > -			};
> > -
> > -			codec {
> > -				sound-dai =3D <&sti_sasg_codec 1>;
> > -			};
> > -		};
> > -		simple-audio-card,dai-link@1 {
> > -			/* SPDIF */
> > -			format =3D "left_j";
> > -			cpu {
> > -				sound-dai =3D <&sti_uni_player3>;
> > -			};
> > -
> > -			codec {
> > -				sound-dai =3D <&sti_sasg_codec 0>;
> > -			};
> > -		};
> > -		simple-audio-card,dai-link@2 {
> > -			/* TDM playback  */
> > -			format =3D "left_j";
> > -			frame-inversion =3D <1>;
> > -			cpu {
> > -				sound-dai =3D <&sti_uni_player1>;
> > -				dai-tdm-slot-num =3D <16>;
> > -				dai-tdm-slot-width =3D <16>;
> > -				dai-tdm-slot-tx-mask =3D
> > -					<1 1 1 1 0 0 0 0 0 0 1 1 0 0 1 1>;
> > -			};
> > -
> > -			codec {
> > -				sound-dai =3D <&sti_sasg_codec 3>;
> > -			};
> > -		};
> > -	};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e127c2fb08a7..9dede78d02c1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18465,13 +18465,6 @@ F:	include/linux/static_call*.h
> >  F:	kernel/jump_label.c
> >  F:	kernel/static_call.c
> >
> > -STI AUDIO (ASoC) DRIVERS
> > -M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > -L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> > -S:	Maintained
> > -F:	Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> > -F:	sound/soc/sti/
> > -
> >  STI CEC DRIVER
> >  M:	Alain Volmat <alain.volmat@foss.st.com>
> >  S:	Maintained
> > diff --git a/sound/soc/sti/Kconfig b/sound/soc/sti/Kconfig
> > deleted file mode 100644
> > index f881da4b6aea..000000000000
> > --- a/sound/soc/sti/Kconfig
> > +++ /dev/null
> > @@ -1,12 +0,0 @@
> > -# SPDX-License-Identifier: GPL-2.0-only
> > -#
> > -# STM SoC audio configuration
> > -#
> > -menuconfig SND_SOC_STI
> > -	tristate "SoC Audio support for STI System-On-Chip"
> > -	depends on SND_SOC
> > -	depends on ARCH_STI || COMPILE_TEST
> > -	select SND_SOC_GENERIC_DMAENGINE_PCM
> > -	help
> > -		Say Y if you want to enable ASoC-support for
> > -		any of the STI platforms (e.g. STIH416).
> > diff --git a/sound/soc/sti/Makefile b/sound/soc/sti/Makefile
> > deleted file mode 100644
> > index 787ccb521298..000000000000
> > --- a/sound/soc/sti/Makefile
> > +++ /dev/null
> > @@ -1,5 +0,0 @@
> > -# SPDX-License-Identifier: GPL-2.0-only
> > -# STI platform support
> > -snd-soc-sti-objs :=3D sti_uniperif.o uniperif_player.o uniperif_reader=
.o
> > -
> > -obj-$(CONFIG_SND_SOC_STI) +=3D snd-soc-sti.o
> > diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.=
c
> > deleted file mode 100644
> > index 34668fe3909d..000000000000
> > --- a/sound/soc/sti/sti_uniperif.c
> > +++ /dev/null
> > @@ -1,506 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > -/*
> > - * Copyright (C) STMicroelectronics SA 2015
> > - * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > - *          for STMicroelectronics.
> > - */
> > -
> > -#include <linux/module.h>
> > -#include <linux/pinctrl/consumer.h>
> > -#include <linux/delay.h>
> > -
> > -#include "uniperif.h"
> > -
> > -/*
> > - * User frame size shall be 2, 4, 6 or 8 32-bits words length
> > - * (i.e. 8, 16, 24 or 32 bytes)
> > - * This constraint comes from allowed values for
> > - * UNIPERIF_I2S_FMT_NUM_CH register
> > - */
> > -#define UNIPERIF_MAX_FRAME_SZ 0x20
> > -#define UNIPERIF_ALLOWED_FRAME_SZ (0x08 | 0x10 | 0x18 |
> UNIPERIF_MAX_FRAME_SZ)
> > -
> > -struct sti_uniperiph_dev_data {
> > -	unsigned int id; /* Nb available player instances */
> > -	unsigned int version; /* player IP version */
> > -	unsigned int stream;
> > -	const char *dai_names;
> > -	enum uniperif_type type;
> > -};
> > -
> > -static const struct sti_uniperiph_dev_data sti_uniplayer_hdmi =3D {
> > -	.id =3D 0,
> > -	.version =3D SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0,
> > -	.stream =3D SNDRV_PCM_STREAM_PLAYBACK,
> > -	.dai_names =3D "Uni Player #0 (HDMI)",
> > -	.type =3D SND_ST_UNIPERIF_TYPE_HDMI
> > -};
> > -
> > -static const struct sti_uniperiph_dev_data sti_uniplayer_pcm_out =3D {
> > -	.id =3D 1,
> > -	.version =3D SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0,
> > -	.stream =3D SNDRV_PCM_STREAM_PLAYBACK,
> > -	.dai_names =3D "Uni Player #1 (PCM OUT)",
> > -	.type =3D SND_ST_UNIPERIF_TYPE_PCM | SND_ST_UNIPERIF_TYPE_TDM,
> > -};
> > -
> > -static const struct sti_uniperiph_dev_data sti_uniplayer_dac =3D {
> > -	.id =3D 2,
> > -	.version =3D SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0,
> > -	.stream =3D SNDRV_PCM_STREAM_PLAYBACK,
> > -	.dai_names =3D "Uni Player #2 (DAC)",
> > -	.type =3D SND_ST_UNIPERIF_TYPE_PCM,
> > -};
> > -
> > -static const struct sti_uniperiph_dev_data sti_uniplayer_spdif =3D {
> > -	.id =3D 3,
> > -	.version =3D SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0,
> > -	.stream =3D SNDRV_PCM_STREAM_PLAYBACK,
> > -	.dai_names =3D "Uni Player #3 (SPDIF)",
> > -	.type =3D SND_ST_UNIPERIF_TYPE_SPDIF
> > -};
> > -
> > -static const struct sti_uniperiph_dev_data sti_unireader_pcm_in =3D {
> > -	.id =3D 0,
> > -	.version =3D SND_ST_UNIPERIF_VERSION_UNI_RDR_1_0,
> > -	.stream =3D SNDRV_PCM_STREAM_CAPTURE,
> > -	.dai_names =3D "Uni Reader #0 (PCM IN)",
> > -	.type =3D SND_ST_UNIPERIF_TYPE_PCM | SND_ST_UNIPERIF_TYPE_TDM,
> > -};
> > -
> > -static const struct sti_uniperiph_dev_data sti_unireader_hdmi_in =3D {
> > -	.id =3D 1,
> > -	.version =3D SND_ST_UNIPERIF_VERSION_UNI_RDR_1_0,
> > -	.stream =3D SNDRV_PCM_STREAM_CAPTURE,
> > -	.dai_names =3D "Uni Reader #1 (HDMI IN)",
> > -	.type =3D SND_ST_UNIPERIF_TYPE_PCM,
> > -};
> > -
> > -static const struct of_device_id snd_soc_sti_match[] =3D {
> > -	{ .compatible =3D "st,stih407-uni-player-hdmi",
> > -	  .data =3D &sti_uniplayer_hdmi
> > -	},
> > -	{ .compatible =3D "st,stih407-uni-player-pcm-out",
> > -	  .data =3D &sti_uniplayer_pcm_out
> > -	},
> > -	{ .compatible =3D "st,stih407-uni-player-dac",
> > -	  .data =3D &sti_uniplayer_dac
> > -	},
> > -	{ .compatible =3D "st,stih407-uni-player-spdif",
> > -	  .data =3D &sti_uniplayer_spdif
> > -	},
> > -	{ .compatible =3D "st,stih407-uni-reader-pcm_in",
> > -	  .data =3D &sti_unireader_pcm_in
> > -	},
> > -	{ .compatible =3D "st,stih407-uni-reader-hdmi",
> > -	  .data =3D &sti_unireader_hdmi_in
> > -	},
> > -	{},
> > -};
> > -MODULE_DEVICE_TABLE(of, snd_soc_sti_match);
> > -
> > -int  sti_uniperiph_reset(struct uniperif *uni)
> > -{
> > -	int count =3D 10;
> > -
> > -	/* Reset uniperipheral uni */
> > -	SET_UNIPERIF_SOFT_RST_SOFT_RST(uni);
> > -
> > -	if (uni->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0) {
> > -		while (GET_UNIPERIF_SOFT_RST_SOFT_RST(uni) && count) {
> > -			udelay(5);
> > -			count--;
> > -		}
> > -	}
> > -
> > -	if (!count) {
> > -		dev_err(uni->dev, "Failed to reset uniperif\n");
> > -		return -EIO;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int
> tx_mask,
> > -			       unsigned int rx_mask, int slots,
> > -			       int slot_width)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *uni =3D priv->dai_data.uni;
> > -	int i, frame_size, avail_slots;
> > -
> > -	if (!UNIPERIF_TYPE_IS_TDM(uni)) {
> > -		dev_err(uni->dev, "cpu dai not in tdm mode\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* store info in unip context */
> > -	uni->tdm_slot.slots =3D slots;
> > -	uni->tdm_slot.slot_width =3D slot_width;
> > -	/* unip is unidirectionnal */
> > -	uni->tdm_slot.mask =3D (tx_mask !=3D 0) ? tx_mask : rx_mask;
> > -
> > -	/* number of available timeslots */
> > -	for (i =3D 0, avail_slots =3D 0; i < uni->tdm_slot.slots; i++) {
> > -		if ((uni->tdm_slot.mask >> i) & 0x01)
> > -			avail_slots++;
> > -	}
> > -	uni->tdm_slot.avail_slots =3D avail_slots;
> > -
> > -	/* frame size in bytes */
> > -	frame_size =3D uni->tdm_slot.avail_slots * uni->tdm_slot.slot_width /=
 8;
> > -
> > -	/* check frame size is allowed */
> > -	if ((frame_size > UNIPERIF_MAX_FRAME_SZ) ||
> > -	    (frame_size & ~(int)UNIPERIF_ALLOWED_FRAME_SZ)) {
> > -		dev_err(uni->dev, "frame size not allowed: %d bytes\n",
> > -			frame_size);
> > -		return -EINVAL;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -int sti_uniperiph_fix_tdm_chan(struct snd_pcm_hw_params *params,
> > -			       struct snd_pcm_hw_rule *rule)
> > -{
> > -	struct uniperif *uni =3D rule->private;
> > -	struct snd_interval t;
> > -
> > -	t.min =3D uni->tdm_slot.avail_slots;
> > -	t.max =3D uni->tdm_slot.avail_slots;
> > -	t.openmin =3D 0;
> > -	t.openmax =3D 0;
> > -	t.integer =3D 0;
> > -
> > -	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
> > -}
> > -
> > -int sti_uniperiph_fix_tdm_format(struct snd_pcm_hw_params *params,
> > -				 struct snd_pcm_hw_rule *rule)
> > -{
> > -	struct uniperif *uni =3D rule->private;
> > -	struct snd_mask *maskp =3D hw_param_mask(params, rule->var);
> > -	u64 format;
> > -
> > -	switch (uni->tdm_slot.slot_width) {
> > -	case 16:
> > -		format =3D SNDRV_PCM_FMTBIT_S16_LE;
> > -		break;
> > -	case 32:
> > -		format =3D SNDRV_PCM_FMTBIT_S32_LE;
> > -		break;
> > -	default:
> > -		dev_err(uni->dev, "format not supported: %d bits\n",
> > -			uni->tdm_slot.slot_width);
> > -		return -EINVAL;
> > -	}
> > -
> > -	maskp->bits[0] &=3D (u_int32_t)format;
> > -	maskp->bits[1] &=3D (u_int32_t)(format >> 32);
> > -	/* clear remaining indexes */
> > -	memset(maskp->bits + 2, 0, (SNDRV_MASK_MAX - 64) / 8);
> > -
> > -	if (!maskp->bits[0] && !maskp->bits[1])
> > -		return -EINVAL;
> > -
> > -	return 0;
> > -}
> > -
> > -int sti_uniperiph_get_tdm_word_pos(struct uniperif *uni,
> > -				   unsigned int *word_pos)
> > -{
> > -	int slot_width =3D uni->tdm_slot.slot_width / 8;
> > -	int slots_num =3D uni->tdm_slot.slots;
> > -	unsigned int slots_mask =3D uni->tdm_slot.mask;
> > -	int i, j, k;
> > -	unsigned int word16_pos[4];
> > -
> > -	/* word16_pos:
> > -	 * word16_pos[0] =3D WORDX_LSB
> > -	 * word16_pos[1] =3D WORDX_MSB,
> > -	 * word16_pos[2] =3D WORDX+1_LSB
> > -	 * word16_pos[3] =3D WORDX+1_MSB
> > -	 */
> > -
> > -	/* set unip word position */
> > -	for (i =3D 0, j =3D 0, k =3D 0; (i < slots_num) && (k < WORD_MAX); i+=
+) {
> > -		if ((slots_mask >> i) & 0x01) {
> > -			word16_pos[j] =3D i * slot_width;
> > -
> > -			if (slot_width =3D=3D 4) {
> > -				word16_pos[j + 1] =3D word16_pos[j] + 2;
> > -				j++;
> > -			}
> > -			j++;
> > -
> > -			if (j > 3) {
> > -				word_pos[k] =3D word16_pos[1] |
> > -					      (word16_pos[0] << 8) |
> > -					      (word16_pos[3] << 16) |
> > -					      (word16_pos[2] << 24);
> > -				j =3D 0;
> > -				k++;
> > -			}
> > -		}
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -/*
> > - * sti_uniperiph_dai_create_ctrl
> > - * This function is used to create Ctrl associated to DAI but also pcm=
 device.
> > - * Request is done by front end to associate ctrl with pcm device id
> > - */
> > -static int sti_uniperiph_dai_create_ctrl(struct snd_soc_dai *dai)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *uni =3D priv->dai_data.uni;
> > -	struct snd_kcontrol_new *ctrl;
> > -	int i;
> > -
> > -	if (!uni->num_ctrls)
> > -		return 0;
> > -
> > -	for (i =3D 0; i < uni->num_ctrls; i++) {
> > -		/*
> > -		 * Several Control can have same name. Controls are indexed
> on
> > -		 * Uniperipheral instance ID
> > -		 */
> > -		ctrl =3D &uni->snd_ctrls[i];
> > -		ctrl->index =3D uni->id;
> > -		ctrl->device =3D uni->id;
> > -	}
> > -
> > -	return snd_soc_add_dai_controls(dai, uni->snd_ctrls, uni->num_ctrls);
> > -}
> > -
> > -/*
> > - * DAI
> > - */
> > -int sti_uniperiph_dai_hw_params(struct snd_pcm_substream *substream,
> > -				struct snd_pcm_hw_params *params,
> > -				struct snd_soc_dai *dai)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *uni =3D priv->dai_data.uni;
> > -	struct snd_dmaengine_dai_dma_data *dma_data;
> > -	int transfer_size;
> > -
> > -	if (uni->type =3D=3D SND_ST_UNIPERIF_TYPE_TDM)
> > -		/* transfer size =3D user frame size (in 32-bits FIFO cell) */
> > -		transfer_size =3D snd_soc_params_to_frame_size(params) / 32;
> > -	else
> > -		transfer_size =3D params_channels(params) *
> UNIPERIF_FIFO_FRAMES;
> > -
> > -	dma_data =3D snd_soc_dai_get_dma_data(dai, substream);
> > -	dma_data->maxburst =3D transfer_size;
> > -
> > -	return 0;
> > -}
> > -
> > -int sti_uniperiph_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fm=
t)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -
> > -	priv->dai_data.uni->daifmt =3D fmt;
> > -
> > -	return 0;
> > -}
> > -
> > -static int sti_uniperiph_suspend(struct snd_soc_component *component)
> > -{
> > -	struct sti_uniperiph_data *priv =3D
> snd_soc_component_get_drvdata(component);
> > -	struct uniperif *uni =3D priv->dai_data.uni;
> > -	int ret;
> > -
> > -	/* The uniperipheral should be in stopped state */
> > -	if (uni->state !=3D UNIPERIF_STATE_STOPPED) {
> > -		dev_err(uni->dev, "%s: invalid uni state( %d)\n",
> > -			__func__, (int)uni->state);
> > -		return -EBUSY;
> > -	}
> > -
> > -	/* Pinctrl: switch pinstate to sleep */
> > -	ret =3D pinctrl_pm_select_sleep_state(uni->dev);
> > -	if (ret)
> > -		dev_err(uni->dev, "%s: failed to select pinctrl state\n",
> > -			__func__);
> > -
> > -	return ret;
> > -}
> > -
> > -static int sti_uniperiph_resume(struct snd_soc_component *component)
> > -{
> > -	struct sti_uniperiph_data *priv =3D
> snd_soc_component_get_drvdata(component);
> > -	struct uniperif *uni =3D priv->dai_data.uni;
> > -	int ret;
> > -
> > -	if (priv->dai_data.stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> > -		ret =3D uni_player_resume(uni);
> > -		if (ret)
> > -			return ret;
> > -	}
> > -
> > -	/* pinctrl: switch pinstate to default */
> > -	ret =3D pinctrl_pm_select_default_state(uni->dev);
> > -	if (ret)
> > -		dev_err(uni->dev, "%s: failed to select pinctrl state\n",
> > -			__func__);
> > -
> > -	return ret;
> > -}
> > -
> > -static int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct sti_uniperiph_dai *dai_data =3D &priv->dai_data;
> > -
> > -	/* DMA settings*/
> > -	if (priv->dai_data.stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> > -		snd_soc_dai_init_dma_data(dai, &dai_data->dma_data, NULL);
> > -	else
> > -		snd_soc_dai_init_dma_data(dai, NULL, &dai_data->dma_data);
> > -
> > -	dai_data->dma_data.addr =3D dai_data->uni->fifo_phys_address;
> > -	dai_data->dma_data.addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> > -
> > -	return sti_uniperiph_dai_create_ctrl(dai);
> > -}
> > -
> > -static const struct snd_soc_dai_driver sti_uniperiph_dai_template =3D =
{
> > -	.probe =3D sti_uniperiph_dai_probe,
> > -};
> > -
> > -static const struct snd_soc_component_driver sti_uniperiph_dai_compone=
nt
> =3D {
> > -	.name =3D "sti_cpu_dai",
> > -	.suspend =3D sti_uniperiph_suspend,
> > -	.resume =3D sti_uniperiph_resume
> > -};
> > -
> > -static int sti_uniperiph_cpu_dai_of(struct device_node *node,
> > -				    struct sti_uniperiph_data *priv)
> > -{
> > -	struct device *dev =3D &priv->pdev->dev;
> > -	struct sti_uniperiph_dai *dai_data =3D &priv->dai_data;
> > -	struct snd_soc_dai_driver *dai =3D priv->dai;
> > -	struct snd_soc_pcm_stream *stream;
> > -	struct uniperif *uni;
> > -	const struct of_device_id *of_id;
> > -	const struct sti_uniperiph_dev_data *dev_data;
> > -	const char *mode;
> > -	int ret;
> > -
> > -	/* Populate data structure depending on compatibility */
> > -	of_id =3D of_match_node(snd_soc_sti_match, node);
> > -	if (!of_id->data) {
> > -		dev_err(dev, "data associated to device is missing\n");
> > -		return -EINVAL;
> > -	}
> > -	dev_data =3D (struct sti_uniperiph_dev_data *)of_id->data;
> > -
> > -	uni =3D devm_kzalloc(dev, sizeof(*uni), GFP_KERNEL);
> > -	if (!uni)
> > -		return -ENOMEM;
> > -
> > -	uni->id =3D dev_data->id;
> > -	uni->ver =3D dev_data->version;
> > -
> > -	*dai =3D sti_uniperiph_dai_template;
> > -	dai->name =3D dev_data->dai_names;
> > -
> > -	/* Get resources and base address */
> > -	uni->base =3D devm_platform_get_and_ioremap_resource(priv->pdev, 0,
> &uni->mem_region);
> > -	if (IS_ERR(uni->base))
> > -		return PTR_ERR(uni->base);
> > -
> > -	uni->fifo_phys_address =3D uni->mem_region->start +
> > -				     UNIPERIF_FIFO_DATA_OFFSET(uni);
> > -
> > -	uni->irq =3D platform_get_irq(priv->pdev, 0);
> > -	if (uni->irq < 0)
> > -		return -ENXIO;
> > -
> > -	uni->type =3D dev_data->type;
> > -
> > -	/* check if player should be configured for tdm */
> > -	if (dev_data->type & SND_ST_UNIPERIF_TYPE_TDM) {
> > -		if (!of_property_read_string(node, "st,tdm-mode", &mode))
> > -			uni->type =3D SND_ST_UNIPERIF_TYPE_TDM;
> > -		else
> > -			uni->type =3D SND_ST_UNIPERIF_TYPE_PCM;
> > -	}
> > -
> > -	dai_data->uni =3D uni;
> > -	dai_data->stream =3D dev_data->stream;
> > -
> > -	if (priv->dai_data.stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> > -		ret =3D uni_player_init(priv->pdev, uni);
> > -		stream =3D &dai->playback;
> > -	} else {
> > -		ret =3D uni_reader_init(priv->pdev, uni);
> > -		stream =3D &dai->capture;
> > -	}
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	dai->ops =3D uni->dai_ops;
> > -
> > -	stream->stream_name =3D dai->name;
> > -	stream->channels_min =3D uni->hw->channels_min;
> > -	stream->channels_max =3D uni->hw->channels_max;
> > -	stream->rates =3D uni->hw->rates;
> > -	stream->formats =3D uni->hw->formats;
> > -
> > -	return 0;
> > -}
> > -
> > -static const struct snd_dmaengine_pcm_config dmaengine_pcm_config =3D =
{
> > -	.prepare_slave_config =3D snd_dmaengine_pcm_prepare_slave_config,
> > -};
> > -
> > -static int sti_uniperiph_probe(struct platform_device *pdev)
> > -{
> > -	struct sti_uniperiph_data *priv;
> > -	struct device_node *node =3D pdev->dev.of_node;
> > -	int ret;
> > -
> > -	/* Allocate the private data and the CPU_DAI array */
> > -	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > -	if (!priv)
> > -		return -ENOMEM;
> > -	priv->dai =3D devm_kzalloc(&pdev->dev, sizeof(*priv->dai), GFP_KERNEL=
);
> > -	if (!priv->dai)
> > -		return -ENOMEM;
> > -
> > -	priv->pdev =3D pdev;
> > -
> > -	ret =3D sti_uniperiph_cpu_dai_of(node, priv);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	dev_set_drvdata(&pdev->dev, priv);
> > -
> > -	ret =3D devm_snd_soc_register_component(&pdev->dev,
> > -					      &sti_uniperiph_dai_component,
> > -					      priv->dai, 1);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	return devm_snd_dmaengine_pcm_register(&pdev->dev,
> > -					       &dmaengine_pcm_config, 0);
> > -}
> > -
> > -static struct platform_driver sti_uniperiph_driver =3D {
> > -	.driver =3D {
> > -		.name =3D "sti-uniperiph-dai",
> > -		.of_match_table =3D snd_soc_sti_match,
> > -	},
> > -	.probe =3D sti_uniperiph_probe,
> > -};
> > -module_platform_driver(sti_uniperiph_driver);
> > -
> > -MODULE_DESCRIPTION("uniperipheral DAI driver");
> > -MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
> > -MODULE_LICENSE("GPL v2");
> > diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
> > deleted file mode 100644
> > index 2a5de328501c..000000000000
> > --- a/sound/soc/sti/uniperif.h
> > +++ /dev/null
> > @@ -1,1416 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0-only */
> > -/*
> > - * Copyright (C) STMicroelectronics SA 2015
> > - * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > - *          for STMicroelectronics.
> > - */
> > -
> > -#ifndef __SND_ST_AUD_UNIPERIF_H
> > -#define __SND_ST_AUD_UNIPERIF_H
> > -
> > -#include <linux/regmap.h>
> > -
> > -#include <sound/dmaengine_pcm.h>
> > -
> > -/*
> > - * Register access macros
> > - */
> > -
> > -#define GET_UNIPERIF_REG(ip, offset, shift, mask) \
> > -	((readl_relaxed(ip->base + offset) >> shift) & mask)
> > -#define SET_UNIPERIF_REG(ip, offset, shift, mask, value) \
> > -	writel_relaxed(((readl_relaxed(ip->base + offset) & \
> > -	~(mask << shift)) | (((value) & mask) << shift)), ip->base + offset)
> > -#define SET_UNIPERIF_BIT_REG(ip, offset, shift, mask, value) \
> > -	writel_relaxed((((value) & mask) << shift), ip->base + offset)
> > -
> > -/*
> > - * UNIPERIF_SOFT_RST reg
> > - */
> > -
> > -#define UNIPERIF_SOFT_RST_OFFSET(ip) 0x0000
> > -#define GET_UNIPERIF_SOFT_RST(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? \
> > -		readl_relaxed(ip->base + UNIPERIF_SOFT_RST_OFFSET(ip)) : 0)
> > -#define SET_UNIPERIF_SOFT_RST(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_SOFT_RST_OFFSET(ip))
> > -
> > -/* SOFT_RST */
> > -#define UNIPERIF_SOFT_RST_SOFT_RST_SHIFT(ip) 0x0
> > -#define UNIPERIF_SOFT_RST_SOFT_RST_MASK(ip) 0x1
> > -#define SET_UNIPERIF_SOFT_RST_SOFT_RST(ip) \
> > -	SET_UNIPERIF_BIT_REG(ip, \
> > -		UNIPERIF_SOFT_RST_OFFSET(ip), \
> > -		UNIPERIF_SOFT_RST_SOFT_RST_SHIFT(ip), \
> > -		UNIPERIF_SOFT_RST_SOFT_RST_MASK(ip), 1)
> > -#define GET_UNIPERIF_SOFT_RST_SOFT_RST(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_SOFT_RST_OFFSET(ip), \
> > -		UNIPERIF_SOFT_RST_SOFT_RST_SHIFT(ip), \
> > -		UNIPERIF_SOFT_RST_SOFT_RST_MASK(ip))
> > -
> > -/*
> > - * UNIPERIF_FIFO_DATA reg
> > - */
> > -
> > -#define UNIPERIF_FIFO_DATA_OFFSET(ip) 0x0004
> > -#define SET_UNIPERIF_DATA(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_FIFO_DATA_OFFSET(ip))
> > -
> > -/*
> > - * UNIPERIF_CHANNEL_STA_REGN reg
> > - */
> > -
> > -#define UNIPERIF_CHANNEL_STA_REGN(ip, n) (0x0060 + (4 * n))
> > -#define GET_UNIPERIF_CHANNEL_STA_REGN(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_CHANNEL_STA_REGN(ip, n))
> > -#define SET_UNIPERIF_CHANNEL_STA_REGN(ip, n, value) \
> > -	writel_relaxed(value, ip->base + \
> > -			UNIPERIF_CHANNEL_STA_REGN(ip, n))
> > -
> > -#define UNIPERIF_CHANNEL_STA_REG0_OFFSET(ip) 0x0060
> > -#define GET_UNIPERIF_CHANNEL_STA_REG0(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_CHANNEL_STA_REG0_OFFSET(ip))
> > -#define SET_UNIPERIF_CHANNEL_STA_REG0(ip, value) \
> > -	writel_relaxed(value, ip->base +
> UNIPERIF_CHANNEL_STA_REG0_OFFSET(ip))
> > -
> > -#define UNIPERIF_CHANNEL_STA_REG1_OFFSET(ip) 0x0064
> > -#define GET_UNIPERIF_CHANNEL_STA_REG1(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_CHANNEL_STA_REG1_OFFSET(ip))
> > -#define SET_UNIPERIF_CHANNEL_STA_REG1(ip, value) \
> > -	writel_relaxed(value, ip->base +
> UNIPERIF_CHANNEL_STA_REG1_OFFSET(ip))
> > -
> > -#define UNIPERIF_CHANNEL_STA_REG2_OFFSET(ip) 0x0068
> > -#define GET_UNIPERIF_CHANNEL_STA_REG2(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_CHANNEL_STA_REG2_OFFSET(ip))
> > -#define SET_UNIPERIF_CHANNEL_STA_REG2(ip, value) \
> > -	writel_relaxed(value, ip->base +
> UNIPERIF_CHANNEL_STA_REG2_OFFSET(ip))
> > -
> > -#define UNIPERIF_CHANNEL_STA_REG3_OFFSET(ip) 0x006C
> > -#define GET_UNIPERIF_CHANNEL_STA_REG3(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_CHANNEL_STA_REG3_OFFSET(ip))
> > -#define SET_UNIPERIF_CHANNEL_STA_REG3(ip, value) \
> > -	writel_relaxed(value, ip->base +
> UNIPERIF_CHANNEL_STA_REG3_OFFSET(ip))
> > -
> > -#define UNIPERIF_CHANNEL_STA_REG4_OFFSET(ip) 0x0070
> > -#define GET_UNIPERIF_CHANNEL_STA_REG4(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_CHANNEL_STA_REG4_OFFSET(ip))
> > -#define SET_UNIPERIF_CHANNEL_STA_REG4(ip, value) \
> > -	writel_relaxed(value, ip->base +
> UNIPERIF_CHANNEL_STA_REG4_OFFSET(ip))
> > -
> > -#define UNIPERIF_CHANNEL_STA_REG5_OFFSET(ip) 0x0074
> > -#define GET_UNIPERIF_CHANNEL_STA_REG5(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_CHANNEL_STA_REG5_OFFSET(ip))
> > -#define SET_UNIPERIF_CHANNEL_STA_REG5(ip, value) \
> > -	writel_relaxed(value, ip->base +
> UNIPERIF_CHANNEL_STA_REG5_OFFSET(ip))
> > -
> > -/*
> > - *  UNIPERIF_ITS reg
> > - */
> > -
> > -#define UNIPERIF_ITS_OFFSET(ip) 0x000C
> > -#define GET_UNIPERIF_ITS(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_ITS_OFFSET(ip))
> > -
> > -/* MEM_BLK_READ */
> > -#define UNIPERIF_ITS_MEM_BLK_READ_SHIFT(ip) 5
> > -#define UNIPERIF_ITS_MEM_BLK_READ_MASK(ip) \
> > -	(BIT(UNIPERIF_ITS_MEM_BLK_READ_SHIFT(ip)))
> > -
> > -/* FIFO_ERROR */
> > -#define UNIPERIF_ITS_FIFO_ERROR_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 0 : 8)
> > -#define UNIPERIF_ITS_FIFO_ERROR_MASK(ip) \
> > -	(BIT(UNIPERIF_ITS_FIFO_ERROR_SHIFT(ip)))
> > -
> > -/* DMA_ERROR */
> > -#define UNIPERIF_ITS_DMA_ERROR_SHIFT(ip) 9
> > -#define UNIPERIF_ITS_DMA_ERROR_MASK(ip) \
> > -	(BIT(UNIPERIF_ITS_DMA_ERROR_SHIFT(ip)))
> > -
> > -/* UNDERFLOW_REC_DONE */
> > -#define UNIPERIF_ITS_UNDERFLOW_REC_DONE_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 : 12)
> > -#define UNIPERIF_ITS_UNDERFLOW_REC_DONE_MASK(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? \
> > -		0 : (BIT(UNIPERIF_ITS_UNDERFLOW_REC_DONE_SHIFT(ip))))
> > -
> > -/* UNDERFLOW_REC_FAILED */
> > -#define UNIPERIF_ITS_UNDERFLOW_REC_FAILED_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 : 13)
> > -#define UNIPERIF_ITS_UNDERFLOW_REC_FAILED_MASK(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? \
> > -		0 : (BIT(UNIPERIF_ITS_UNDERFLOW_REC_FAILED_SHIFT(ip))))
> > -
> > -/*
> > - *  UNIPERIF_ITS_BCLR reg
> > - */
> > -
> > -/* FIFO_ERROR */
> > -#define UNIPERIF_ITS_BCLR_FIFO_ERROR_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 0 : 8)
> > -#define UNIPERIF_ITS_BCLR_FIFO_ERROR_MASK(ip) \
> > -	(BIT(UNIPERIF_ITS_BCLR_FIFO_ERROR_SHIFT(ip)))
> > -#define SET_UNIPERIF_ITS_BCLR_FIFO_ERROR(ip) \
> > -	SET_UNIPERIF_ITS_BCLR(ip, \
> > -		UNIPERIF_ITS_BCLR_FIFO_ERROR_MASK(ip))
> > -
> > -#define UNIPERIF_ITS_BCLR_OFFSET(ip) 0x0010
> > -#define SET_UNIPERIF_ITS_BCLR(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_ITS_BCLR_OFFSET(ip))
> > -
> > -/*
> > - *  UNIPERIF_ITM reg
> > - */
> > -
> > -#define UNIPERIF_ITM_OFFSET(ip) 0x0018
> > -#define GET_UNIPERIF_ITM(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_ITM_OFFSET(ip))
> > -
> > -/* FIFO_ERROR */
> > -#define UNIPERIF_ITM_FIFO_ERROR_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 0 : 8)
> > -#define UNIPERIF_ITM_FIFO_ERROR_MASK(ip) \
> > -	(BIT(UNIPERIF_ITM_FIFO_ERROR_SHIFT(ip)))
> > -
> > -/* UNDERFLOW_REC_DONE */
> > -#define UNIPERIF_ITM_UNDERFLOW_REC_DONE_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 : 12)
> > -#define UNIPERIF_ITM_UNDERFLOW_REC_DONE_MASK(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? \
> > -		0 : (BIT(UNIPERIF_ITM_UNDERFLOW_REC_DONE_SHIFT(ip))))
> > -
> > -/* UNDERFLOW_REC_FAILED */
> > -#define UNIPERIF_ITM_UNDERFLOW_REC_FAILED_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 : 13)
> > -#define UNIPERIF_ITM_UNDERFLOW_REC_FAILED_MASK(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? \
> > -		0 : (BIT(UNIPERIF_ITM_UNDERFLOW_REC_FAILED_SHIFT(ip))))
> > -
> > -/*
> > - *  UNIPERIF_ITM_BCLR reg
> > - */
> > -
> > -#define UNIPERIF_ITM_BCLR_OFFSET(ip) 0x001c
> > -#define SET_UNIPERIF_ITM_BCLR(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_ITM_BCLR_OFFSET(ip))
> > -
> > -/* FIFO_ERROR */
> > -#define UNIPERIF_ITM_BCLR_FIFO_ERROR_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 0 : 8)
> > -#define UNIPERIF_ITM_BCLR_FIFO_ERROR_MASK(ip) \
> > -	(BIT(UNIPERIF_ITM_BCLR_FIFO_ERROR_SHIFT(ip)))
> > -#define SET_UNIPERIF_ITM_BCLR_FIFO_ERROR(ip) \
> > -	SET_UNIPERIF_ITM_BCLR(ip, \
> > -		UNIPERIF_ITM_BCLR_FIFO_ERROR_MASK(ip))
> > -
> > -/* DMA_ERROR */
> > -#define UNIPERIF_ITM_BCLR_DMA_ERROR_SHIFT(ip) 9
> > -#define UNIPERIF_ITM_BCLR_DMA_ERROR_MASK(ip) \
> > -	(BIT(UNIPERIF_ITM_BCLR_DMA_ERROR_SHIFT(ip)))
> > -#define SET_UNIPERIF_ITM_BCLR_DMA_ERROR(ip) \
> > -	SET_UNIPERIF_ITM_BCLR(ip, \
> > -		UNIPERIF_ITM_BCLR_DMA_ERROR_MASK(ip))
> > -
> > -/*
> > - *  UNIPERIF_ITM_BSET reg
> > - */
> > -
> > -#define UNIPERIF_ITM_BSET_OFFSET(ip) 0x0020
> > -#define SET_UNIPERIF_ITM_BSET(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_ITM_BSET_OFFSET(ip))
> > -
> > -/* FIFO_ERROR */
> > -#define UNIPERIF_ITM_BSET_FIFO_ERROR_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 0 : 8)
> > -#define UNIPERIF_ITM_BSET_FIFO_ERROR_MASK(ip) \
> > -	(BIT(UNIPERIF_ITM_BSET_FIFO_ERROR_SHIFT(ip)))
> > -#define SET_UNIPERIF_ITM_BSET_FIFO_ERROR(ip) \
> > -	SET_UNIPERIF_ITM_BSET(ip, \
> > -		UNIPERIF_ITM_BSET_FIFO_ERROR_MASK(ip))
> > -
> > -/* MEM_BLK_READ */
> > -#define UNIPERIF_ITM_BSET_MEM_BLK_READ_SHIFT(ip) 5
> > -#define UNIPERIF_ITM_BSET_MEM_BLK_READ_MASK(ip) \
> > -	(BIT(UNIPERIF_ITM_BSET_MEM_BLK_READ_SHIFT(ip)))
> > -#define SET_UNIPERIF_ITM_BSET_MEM_BLK_READ(ip) \
> > -	SET_UNIPERIF_ITM_BSET(ip, \
> > -		UNIPERIF_ITM_BSET_MEM_BLK_READ_MASK(ip))
> > -
> > -/* DMA_ERROR */
> > -#define UNIPERIF_ITM_BSET_DMA_ERROR_SHIFT(ip) 9
> > -#define UNIPERIF_ITM_BSET_DMA_ERROR_MASK(ip) \
> > -	(BIT(UNIPERIF_ITM_BSET_DMA_ERROR_SHIFT(ip)))
> > -#define SET_UNIPERIF_ITM_BSET_DMA_ERROR(ip) \
> > -	SET_UNIPERIF_ITM_BSET(ip, \
> > -		UNIPERIF_ITM_BSET_DMA_ERROR_MASK(ip))
> > -
> > -/* UNDERFLOW_REC_DONE */
> > -#define UNIPERIF_ITM_BSET_UNDERFLOW_REC_DONE_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 : 12)
> > -#define UNIPERIF_ITM_BSET_UNDERFLOW_REC_DONE_MASK(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? \
> > -		0 :
> (BIT(UNIPERIF_ITM_BSET_UNDERFLOW_REC_DONE_SHIFT(ip))))
> > -#define SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_DONE(ip) \
> > -	SET_UNIPERIF_ITM_BSET(ip, \
> > -		UNIPERIF_ITM_BSET_UNDERFLOW_REC_DONE_MASK(ip))
> > -
> > -/* UNDERFLOW_REC_FAILED */
> > -#define UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 : 13)
> > -#define UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED_MASK(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? \
> > -		0 :
> (BIT(UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED_SHIFT(ip))))
> > -#define SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED(ip) \
> > -	SET_UNIPERIF_ITM_BSET(ip, \
> > -		UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED_MASK(ip))
> > -
> > -/*
> > - * UNIPERIF_CONFIG reg
> > - */
> > -
> > -#define UNIPERIF_CONFIG_OFFSET(ip) 0x0040
> > -#define GET_UNIPERIF_CONFIG(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_CONFIG_OFFSET(ip))
> > -#define SET_UNIPERIF_CONFIG(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_CONFIG_OFFSET(ip))
> > -
> > -/* PARITY_CNTR */
> > -#define UNIPERIF_CONFIG_PARITY_CNTR_SHIFT(ip) 0
> > -#define UNIPERIF_CONFIG_PARITY_CNTR_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_PARITY_CNTR(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_PARITY_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_PARITY_CNTR_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_PARITY_CNTR_BY_HW(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_PARITY_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_PARITY_CNTR_MASK(ip), 0)
> > -#define SET_UNIPERIF_CONFIG_PARITY_CNTR_BY_SW(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_PARITY_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_PARITY_CNTR_MASK(ip), 1)
> > -
> > -/* CHANNEL_STA_CNTR */
> > -#define UNIPERIF_CONFIG_CHANNEL_STA_CNTR_SHIFT(ip) 1
> > -#define UNIPERIF_CONFIG_CHANNEL_STA_CNTR_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_CHANNEL_STA_CNTR(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_CHANNEL_STA_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_CHANNEL_STA_CNTR_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_CHANNEL_STA_CNTR_BY_SW(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_CHANNEL_STA_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_CHANNEL_STA_CNTR_MASK(ip), 0)
> > -#define SET_UNIPERIF_CONFIG_CHANNEL_STA_CNTR_BY_HW(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip),    \
> > -		UNIPERIF_CONFIG_CHANNEL_STA_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_CHANNEL_STA_CNTR_MASK(ip), 1)
> > -
> > -/* USER_DAT_CNTR */
> > -#define UNIPERIF_CONFIG_USER_DAT_CNTR_SHIFT(ip) 2
> > -#define UNIPERIF_CONFIG_USER_DAT_CNTR_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_USER_DAT_CNTR(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_USER_DAT_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_USER_DAT_CNTR_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_USER_DAT_CNTR_BY_HW(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_USER_DAT_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_USER_DAT_CNTR_MASK(ip), 1)
> > -#define SET_UNIPERIF_CONFIG_USER_DAT_CNTR_BY_SW(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_USER_DAT_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_USER_DAT_CNTR_MASK(ip), 0)
> > -
> > -/* VALIDITY_DAT_CNTR */
> > -#define UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_SHIFT(ip) 3
> > -#define UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_VALIDITY_DAT_CNTR(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_BY_SW(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_MASK(ip), 0)
> > -#define SET_UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_BY_HW(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_MASK(ip), 1)
> > -
> > -/* ONE_BIT_AUD_SUPPORT */
> > -#define UNIPERIF_CONFIG_ONE_BIT_AUD_SHIFT(ip) 4
> > -#define UNIPERIF_CONFIG_ONE_BIT_AUD_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_ONE_BIT_AUD(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_ONE_BIT_AUD_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_ONE_BIT_AUD_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_ONE_BIT_AUD_DISABLE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_ONE_BIT_AUD_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_ONE_BIT_AUD_MASK(ip), 0)
> > -#define SET_UNIPERIF_CONFIG_ONE_BIT_AUD_ENABLE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_ONE_BIT_AUD_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_ONE_BIT_AUD_MASK(ip), 1)
> > -
> > -/* MEMORY_FMT */
> > -#define UNIPERIF_CONFIG_MEM_FMT_SHIFT(ip) 5
> > -#define UNIPERIF_CONFIG_MEM_FMT_MASK(ip) 0x1
> > -#define VALUE_UNIPERIF_CONFIG_MEM_FMT_16_0(ip) 0
> > -#define VALUE_UNIPERIF_CONFIG_MEM_FMT_16_16(ip) 1
> > -#define GET_UNIPERIF_CONFIG_MEM_FMT(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_MEM_FMT_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_MEM_FMT_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_MEM_FMT(ip, value)	\
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_MEM_FMT_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_MEM_FMT_MASK(ip), value)
> > -#define SET_UNIPERIF_CONFIG_MEM_FMT_16_0(ip)   \
> > -	SET_UNIPERIF_CONFIG_MEM_FMT(ip, \
> > -		VALUE_UNIPERIF_CONFIG_MEM_FMT_16_0(ip))
> > -#define SET_UNIPERIF_CONFIG_MEM_FMT_16_16(ip) \
> > -	SET_UNIPERIF_CONFIG_MEM_FMT(ip, \
> > -		VALUE_UNIPERIF_CONFIG_MEM_FMT_16_16(ip))
> > -
> > -/* REPEAT_CHL_STS */
> > -#define UNIPERIF_CONFIG_REPEAT_CHL_STS_SHIFT(ip) 6
> > -#define UNIPERIF_CONFIG_REPEAT_CHL_STS_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_REPEAT_CHL_STS(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_REPEAT_CHL_STS_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_REPEAT_CHL_STS_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_REPEAT_CHL_STS_ENABLE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_REPEAT_CHL_STS_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_REPEAT_CHL_STS_MASK(ip), 0)
> > -#define SET_UNIPERIF_CONFIG_REPEAT_CHL_STS_DISABLE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_REPEAT_CHL_STS_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_REPEAT_CHL_STS_MASK(ip), 1)
> > -
> > -/* BACK_STALL_REQ */
> > -#define UNIPERIF_CONFIG_BACK_STALL_REQ_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 7 : -1)
> > -#define UNIPERIF_CONFIG_BACK_STALL_REQ_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_BACK_STALL_REQ(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_BACK_STALL_REQ_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_BACK_STALL_REQ_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_BACK_STALL_REQ_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_BACK_STALL_REQ_MASK(ip), 0)
> > -#define SET_UNIPERIF_CONFIG_BACK_STALL_REQ_ENABLE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_BACK_STALL_REQ_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_BACK_STALL_REQ_MASK(ip), 1)
> > -
> > -/* FDMA_TRIGGER_LIMIT */
> > -#define UNIPERIF_CONFIG_DMA_TRIG_LIMIT_SHIFT(ip) 8
> > -#define UNIPERIF_CONFIG_DMA_TRIG_LIMIT_MASK(ip) 0x7F
> > -#define GET_UNIPERIF_CONFIG_DMA_TRIG_LIMIT(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_DMA_TRIG_LIMIT_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_DMA_TRIG_LIMIT_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_DMA_TRIG_LIMIT(ip, value) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_DMA_TRIG_LIMIT_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_DMA_TRIG_LIMIT_MASK(ip), value)
> > -
> > -/* CHL_STS_UPDATE */
> > -#define UNIPERIF_CONFIG_CHL_STS_UPDATE_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 16 : -1)
> > -#define UNIPERIF_CONFIG_CHL_STS_UPDATE_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_CHL_STS_UPDATE(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip),  \
> > -		UNIPERIF_CONFIG_CHL_STS_UPDATE_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_CHL_STS_UPDATE_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_CHL_STS_UPDATE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_CHL_STS_UPDATE_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_CHL_STS_UPDATE_MASK(ip), 1)
> > -
> > -/* IDLE_MOD */
> > -#define UNIPERIF_CONFIG_IDLE_MOD_SHIFT(ip) 18
> > -#define UNIPERIF_CONFIG_IDLE_MOD_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_IDLE_MOD(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_IDLE_MOD_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_IDLE_MOD_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_IDLE_MOD_DISABLE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_IDLE_MOD_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_IDLE_MOD_MASK(ip), 0)
> > -#define SET_UNIPERIF_CONFIG_IDLE_MOD_ENABLE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_IDLE_MOD_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_IDLE_MOD_MASK(ip), 1)
> > -
> > -/* SUBFRAME_SELECTION */
> > -#define UNIPERIF_CONFIG_SUBFRAME_SEL_SHIFT(ip) 19
> > -#define UNIPERIF_CONFIG_SUBFRAME_SEL_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_SUBFRAME_SEL(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_SUBFRAME_SEL_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_SUBFRAME_SEL_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_SUBFRAME_SEL_SUBF1_SUBF0(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_SUBFRAME_SEL_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_SUBFRAME_SEL_MASK(ip), 1)
> > -#define SET_UNIPERIF_CONFIG_SUBFRAME_SEL_SUBF0_SUBF1(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_SUBFRAME_SEL_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_SUBFRAME_SEL_MASK(ip), 0)
> > -
> > -/* FULL_SW_CONTROL */
> > -#define UNIPERIF_CONFIG_SPDIF_SW_CTRL_SHIFT(ip) 20
> > -#define UNIPERIF_CONFIG_SPDIF_SW_CTRL_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_SPDIF_SW_CTRL(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_SPDIF_SW_CTRL_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_SPDIF_SW_CTRL_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_SPDIF_SW_CTRL_ENABLE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_SPDIF_SW_CTRL_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_SPDIF_SW_CTRL_MASK(ip), 1)
> > -#define SET_UNIPERIF_CONFIG_SPDIF_SW_CTRL_DISABLE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_SPDIF_SW_CTRL_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_SPDIF_SW_CTRL_MASK(ip), 0)
> > -
> > -/* MASTER_CLKEDGE */
> > -#define UNIPERIF_CONFIG_MSTR_CLKEDGE_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 24 : -1)
> > -#define UNIPERIF_CONFIG_MSTR_CLKEDGE_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CONFIG_MSTR_CLKEDGE(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_MSTR_CLKEDGE_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_MSTR_CLKEDGE_MASK(ip))
> > -#define SET_UNIPERIF_CONFIG_MSTR_CLKEDGE_FALLING(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_MSTR_CLKEDGE_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_MSTR_CLKEDGE_MASK(ip), 1)
> > -#define SET_UNIPERIF_CONFIG_MSTR_CLKEDGE_RISING(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CONFIG_OFFSET(ip), \
> > -		UNIPERIF_CONFIG_MSTR_CLKEDGE_SHIFT(ip), \
> > -		UNIPERIF_CONFIG_MSTR_CLKEDGE_MASK(ip), 0)
> > -
> > -/*
> > - * UNIPERIF_CTRL reg
> > - */
> > -
> > -#define UNIPERIF_CTRL_OFFSET(ip) 0x0044
> > -#define GET_UNIPERIF_CTRL(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_CTRL_OFFSET(ip))
> > -#define SET_UNIPERIF_CTRL(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_CTRL_OFFSET(ip))
> > -
> > -/* OPERATION */
> > -#define UNIPERIF_CTRL_OPERATION_SHIFT(ip) 0
> > -#define UNIPERIF_CTRL_OPERATION_MASK(ip) 0x7
> > -#define GET_UNIPERIF_CTRL_OPERATION(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_OPERATION_SHIFT(ip), \
> > -		UNIPERIF_CTRL_OPERATION_MASK(ip))
> > -#define VALUE_UNIPERIF_CTRL_OPERATION_OFF(ip) 0
> > -#define SET_UNIPERIF_CTRL_OPERATION_OFF(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_OPERATION_SHIFT(ip), \
> > -		UNIPERIF_CTRL_OPERATION_MASK(ip), \
> > -		VALUE_UNIPERIF_CTRL_OPERATION_OFF(ip))
> > -#define VALUE_UNIPERIF_CTRL_OPERATION_MUTE_PCM_NULL(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 1 : -1)
> > -#define SET_UNIPERIF_CTRL_OPERATION_MUTE_PCM_NULL(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_OPERATION_SHIFT(ip), \
> > -		UNIPERIF_CTRL_OPERATION_MASK(ip), \
> > -		VALUE_UNIPERIF_CTRL_OPERATION_MUTE_PCM_NULL(ip))
> > -#define VALUE_UNIPERIF_CTRL_OPERATION_MUTE_PAUSE_BURST(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 2 : -1)
> > -#define SET_UNIPERIF_CTRL_OPERATION_MUTE_PAUSE_BURST(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_OPERATION_SHIFT(ip), \
> > -		UNIPERIF_CTRL_OPERATION_MASK(ip), \
> > -
> 	VALUE_UNIPERIF_CTRL_OPERATION_MUTE_PAUSE_BURST(ip))
> > -#define VALUE_UNIPERIF_CTRL_OPERATION_PCM_DATA(ip) 3
> > -#define SET_UNIPERIF_CTRL_OPERATION_PCM_DATA(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_OPERATION_SHIFT(ip), \
> > -		UNIPERIF_CTRL_OPERATION_MASK(ip), \
> > -		VALUE_UNIPERIF_CTRL_OPERATION_PCM_DATA(ip))
> > -/* This is the same as above! */
> > -#define VALUE_UNIPERIF_CTRL_OPERATION_AUDIO_DATA(ip) 3
> > -#define SET_UNIPERIF_CTRL_OPERATION_AUDIO_DATA(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_OPERATION_SHIFT(ip), \
> > -		UNIPERIF_CTRL_OPERATION_MASK(ip), \
> > -		VALUE_UNIPERIF_CTRL_OPERATION_AUDIO_DATA(ip))
> > -#define VALUE_UNIPERIF_CTRL_OPERATION_ENC_DATA(ip) 4
> > -#define SET_UNIPERIF_CTRL_OPERATION_ENC_DATA(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_OPERATION_SHIFT(ip), \
> > -		UNIPERIF_CTRL_OPERATION_MASK(ip), \
> > -		VALUE_UNIPERIF_CTRL_OPERATION_ENC_DATA(ip))
> > -#define VALUE_UNIPERIF_CTRL_OPERATION_CD_DATA(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 5 : -1)
> > -#define SET_UNIPERIF_CTRL_OPERATION_CD_DATA(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_OPERATION_SHIFT(ip), \
> > -		UNIPERIF_CTRL_OPERATION_MASK(ip), \
> > -		VALUE_UNIPERIF_CTRL_OPERATION_CD_DATA(ip))
> > -#define VALUE_UNIPERIF_CTRL_OPERATION_STANDBY(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 : 7)
> > -#define SET_UNIPERIF_CTRL_OPERATION_STANDBY(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_OPERATION_SHIFT(ip), \
> > -		UNIPERIF_CTRL_OPERATION_MASK(ip), \
> > -		VALUE_UNIPERIF_CTRL_OPERATION_STANDBY(ip))
> > -
> > -/* EXIT_STBY_ON_EOBLOCK */
> > -#define UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 : 3)
> > -#define UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_SHIFT(ip), \
> > -		UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_MASK(ip))
> > -#define SET_UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_OFF(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_SHIFT(ip), \
> > -		UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_MASK(ip), 0)
> > -#define SET_UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_ON(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_SHIFT(ip), \
> > -		UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_MASK(ip), 1)
> > -
> > -/* ROUNDING */
> > -#define UNIPERIF_CTRL_ROUNDING_SHIFT(ip) 4
> > -#define UNIPERIF_CTRL_ROUNDING_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CTRL_ROUNDING(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_ROUNDING_SHIFT(ip), \
> > -		UNIPERIF_CTRL_ROUNDING_MASK(ip))
> > -#define SET_UNIPERIF_CTRL_ROUNDING_OFF(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_ROUNDING_SHIFT(ip), \
> > -		UNIPERIF_CTRL_ROUNDING_MASK(ip), 0)
> > -#define SET_UNIPERIF_CTRL_ROUNDING_ON(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_ROUNDING_SHIFT(ip), \
> > -		UNIPERIF_CTRL_ROUNDING_MASK(ip), 1)
> > -
> > -/* DIVIDER */
> > -#define UNIPERIF_CTRL_DIVIDER_SHIFT(ip) 5
> > -#define UNIPERIF_CTRL_DIVIDER_MASK(ip) 0xff
> > -#define GET_UNIPERIF_CTRL_DIVIDER(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_DIVIDER_SHIFT(ip), \
> > -		UNIPERIF_CTRL_DIVIDER_MASK(ip))
> > -#define SET_UNIPERIF_CTRL_DIVIDER(ip, value) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_DIVIDER_SHIFT(ip), \
> > -		UNIPERIF_CTRL_DIVIDER_MASK(ip), value)
> > -
> > -/* BYTE_SWAP */
> > -#define UNIPERIF_CTRL_BYTE_SWP_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 13 : -1)
> > -#define UNIPERIF_CTRL_BYTE_SWP_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CTRL_BYTE_SWP(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_BYTE_SWP_SHIFT(ip), \
> > -		UNIPERIF_CTRL_BYTE_SWP_MASK(ip))
> > -#define SET_UNIPERIF_CTRL_BYTE_SWP_OFF(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_BYTE_SWP_SHIFT(ip), \
> > -		UNIPERIF_CTRL_BYTE_SWP_MASK(ip), 0)
> > -#define SET_UNIPERIF_CTRL_BYTE_SWP_ON(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_BYTE_SWP_SHIFT(ip), \
> > -		UNIPERIF_CTRL_BYTE_SWP_MASK(ip), 1)
> > -
> > -/* ZERO_STUFFING_HW_SW */
> > -#define UNIPERIF_CTRL_ZERO_STUFF_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 14 : -1)
> > -#define UNIPERIF_CTRL_ZERO_STUFF_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CTRL_ZERO_STUFF(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_ZERO_STUFF_SHIFT(ip), \
> > -		UNIPERIF_CTRL_ZERO_STUFF_MASK(ip))
> > -#define SET_UNIPERIF_CTRL_ZERO_STUFF_HW(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_ZERO_STUFF_SHIFT(ip), \
> > -		UNIPERIF_CTRL_ZERO_STUFF_MASK(ip), 1)
> > -#define SET_UNIPERIF_CTRL_ZERO_STUFF_SW(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_ZERO_STUFF_SHIFT(ip), \
> > -		UNIPERIF_CTRL_ZERO_STUFF_MASK(ip), 0)
> > -
> > -/* SPDIF_LAT */
> > -#define UNIPERIF_CTRL_SPDIF_LAT_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 16 : -1)
> > -#define UNIPERIF_CTRL_SPDIF_LAT_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CTRL_SPDIF_LAT(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_SPDIF_LAT_SHIFT(ip), \
> > -		UNIPERIF_CTRL_SPDIF_LAT_MASK(ip))
> > -#define SET_UNIPERIF_CTRL_SPDIF_LAT_ON(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_SPDIF_LAT_SHIFT(ip), \
> > -		UNIPERIF_CTRL_SPDIF_LAT_MASK(ip), 1)
> > -#define SET_UNIPERIF_CTRL_SPDIF_LAT_OFF(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_SPDIF_LAT_SHIFT(ip), \
> > -		UNIPERIF_CTRL_SPDIF_LAT_MASK(ip), 0)
> > -
> > -/* EN_SPDIF_FORMATTING */
> > -#define UNIPERIF_CTRL_SPDIF_FMT_SHIFT(ip) 17
> > -#define UNIPERIF_CTRL_SPDIF_FMT_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CTRL_SPDIF_FMT(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_SPDIF_FMT_SHIFT(ip), \
> > -		UNIPERIF_CTRL_SPDIF_FMT_MASK(ip))
> > -#define SET_UNIPERIF_CTRL_SPDIF_FMT_ON(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_SPDIF_FMT_SHIFT(ip), \
> > -		UNIPERIF_CTRL_SPDIF_FMT_MASK(ip), 1)
> > -#define SET_UNIPERIF_CTRL_SPDIF_FMT_OFF(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_SPDIF_FMT_SHIFT(ip), \
> > -		UNIPERIF_CTRL_SPDIF_FMT_MASK(ip), 0)
> > -
> > -/* READER_OUT_SELECT */
> > -#define UNIPERIF_CTRL_READER_OUT_SEL_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 18 : -1)
> > -#define UNIPERIF_CTRL_READER_OUT_SEL_MASK(ip) 0x1
> > -#define GET_UNIPERIF_CTRL_READER_OUT_SEL(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_READER_OUT_SEL_SHIFT(ip), \
> > -		UNIPERIF_CTRL_READER_OUT_SEL_MASK(ip))
> > -#define SET_UNIPERIF_CTRL_READER_OUT_SEL_IN_MEM(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_READER_OUT_SEL_SHIFT(ip), \
> > -		UNIPERIF_CTRL_READER_OUT_SEL_MASK(ip), 0)
> > -#define SET_UNIPERIF_CTRL_READER_OUT_SEL_ON_I2S_LINE(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_READER_OUT_SEL_SHIFT(ip), \
> > -		UNIPERIF_CTRL_READER_OUT_SEL_MASK(ip), 1)
> > -
> > -/* UNDERFLOW_REC_WINDOW */
> > -#define UNIPERIF_CTRL_UNDERFLOW_REC_WINDOW_SHIFT(ip) 20
> > -#define UNIPERIF_CTRL_UNDERFLOW_REC_WINDOW_MASK(ip) 0xff
> > -#define GET_UNIPERIF_CTRL_UNDERFLOW_REC_WINDOW(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_UNDERFLOW_REC_WINDOW_SHIFT(ip), \
> > -		UNIPERIF_CTRL_UNDERFLOW_REC_WINDOW_MASK(ip))
> > -#define SET_UNIPERIF_CTRL_UNDERFLOW_REC_WINDOW(ip, value) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_CTRL_OFFSET(ip), \
> > -		UNIPERIF_CTRL_UNDERFLOW_REC_WINDOW_SHIFT(ip), \
> > -		UNIPERIF_CTRL_UNDERFLOW_REC_WINDOW_MASK(ip),
> value)
> > -
> > -/*
> > - * UNIPERIF_I2S_FMT a.k.a UNIPERIF_FORMAT reg
> > - */
> > -
> > -#define UNIPERIF_I2S_FMT_OFFSET(ip) 0x0048
> > -#define GET_UNIPERIF_I2S_FMT(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_I2S_FMT_OFFSET(ip))
> > -#define SET_UNIPERIF_I2S_FMT(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_I2S_FMT_OFFSET(ip))
> > -
> > -/* NBIT */
> > -#define UNIPERIF_I2S_FMT_NBIT_SHIFT(ip) 0
> > -#define UNIPERIF_I2S_FMT_NBIT_MASK(ip) 0x1
> > -#define GET_UNIPERIF_I2S_FMT_NBIT(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_NBIT_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_NBIT_MASK(ip))
> > -#define SET_UNIPERIF_I2S_FMT_NBIT_32(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_NBIT_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_NBIT_MASK(ip), 0)
> > -#define SET_UNIPERIF_I2S_FMT_NBIT_16(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_NBIT_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_NBIT_MASK(ip), 1)
> > -
> > -/* DATA_SIZE */
> > -#define UNIPERIF_I2S_FMT_DATA_SIZE_SHIFT(ip) 1
> > -#define UNIPERIF_I2S_FMT_DATA_SIZE_MASK(ip) 0x7
> > -#define GET_UNIPERIF_I2S_FMT_DATA_SIZE(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_MASK(ip))
> > -#define SET_UNIPERIF_I2S_FMT_DATA_SIZE_16(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_MASK(ip), 0)
> > -#define SET_UNIPERIF_I2S_FMT_DATA_SIZE_18(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_MASK(ip), 1)
> > -#define SET_UNIPERIF_I2S_FMT_DATA_SIZE_20(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_MASK(ip), 2)
> > -#define SET_UNIPERIF_I2S_FMT_DATA_SIZE_24(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_MASK(ip), 3)
> > -#define SET_UNIPERIF_I2S_FMTL_DATA_SIZE_28(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_MASK(ip), 4)
> > -#define SET_UNIPERIF_I2S_FMT_DATA_SIZE_32(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_DATA_SIZE_MASK(ip), 5)
> > -
> > -/* LR_POL */
> > -#define UNIPERIF_I2S_FMT_LR_POL_SHIFT(ip) 4
> > -#define UNIPERIF_I2S_FMT_LR_POL_MASK(ip) 0x1
> > -#define VALUE_UNIPERIF_I2S_FMT_LR_POL_LOW(ip) 0x0
> > -#define VALUE_UNIPERIF_I2S_FMT_LR_POL_HIG(ip) 0x1
> > -#define GET_UNIPERIF_I2S_FMT_LR_POL(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_LR_POL_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_LR_POL_MASK(ip))
> > -#define SET_UNIPERIF_I2S_FMT_LR_POL(ip, value) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_LR_POL_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_LR_POL_MASK(ip), value)
> > -#define SET_UNIPERIF_I2S_FMT_LR_POL_LOW(ip) \
> > -	SET_UNIPERIF_I2S_FMT_LR_POL(ip, \
> > -		VALUE_UNIPERIF_I2S_FMT_LR_POL_LOW(ip))
> > -#define SET_UNIPERIF_I2S_FMT_LR_POL_HIG(ip) \
> > -	SET_UNIPERIF_I2S_FMT_LR_POL(ip, \
> > -		VALUE_UNIPERIF_I2S_FMT_LR_POL_HIG(ip))
> > -
> > -/* SCLK_EDGE */
> > -#define UNIPERIF_I2S_FMT_SCLK_EDGE_SHIFT(ip) 5
> > -#define UNIPERIF_I2S_FMT_SCLK_EDGE_MASK(ip) 0x1
> > -#define GET_UNIPERIF_I2S_FMT_SCLK_EDGE(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_SCLK_EDGE_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_SCLK_EDGE_MASK(ip))
> > -#define SET_UNIPERIF_I2S_FMT_SCLK_EDGE_RISING(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_SCLK_EDGE_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_SCLK_EDGE_MASK(ip), 0)
> > -#define SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_SCLK_EDGE_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_SCLK_EDGE_MASK(ip), 1)
> > -
> > -/* PADDING */
> > -#define UNIPERIF_I2S_FMT_PADDING_SHIFT(ip) 6
> > -#define UNIPERIF_I2S_FMT_PADDING_MASK(ip) 0x1
> > -#define UNIPERIF_I2S_FMT_PADDING_MASK(ip) 0x1
> > -#define VALUE_UNIPERIF_I2S_FMT_PADDING_I2S_MODE(ip) 0x0
> > -#define VALUE_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(ip) 0x1
> > -#define GET_UNIPERIF_I2S_FMT_PADDING(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_PADDING_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_PADDING_MASK(ip))
> > -#define SET_UNIPERIF_I2S_FMT_PADDING(ip, value) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_PADDING_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_PADDING_MASK(ip), value)
> > -#define SET_UNIPERIF_I2S_FMT_PADDING_I2S_MODE(ip) \
> > -	SET_UNIPERIF_I2S_FMT_PADDING(ip, \
> > -		VALUE_UNIPERIF_I2S_FMT_PADDING_I2S_MODE(ip))
> > -#define SET_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(ip) \
> > -	SET_UNIPERIF_I2S_FMT_PADDING(ip, \
> > -		VALUE_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(ip))
> > -
> > -/* ALIGN */
> > -#define UNIPERIF_I2S_FMT_ALIGN_SHIFT(ip) 7
> > -#define UNIPERIF_I2S_FMT_ALIGN_MASK(ip) 0x1
> > -#define GET_UNIPERIF_I2S_FMT_ALIGN(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_ALIGN_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_ALIGN_MASK(ip))
> > -#define SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_ALIGN_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_ALIGN_MASK(ip), 0)
> > -#define SET_UNIPERIF_I2S_FMT_ALIGN_RIGHT(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_ALIGN_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_ALIGN_MASK(ip), 1)
> > -
> > -/* ORDER */
> > -#define UNIPERIF_I2S_FMT_ORDER_SHIFT(ip) 8
> > -#define UNIPERIF_I2S_FMT_ORDER_MASK(ip) 0x1
> > -#define GET_UNIPERIF_I2S_FMT_ORDER(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_ORDER_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_ORDER_MASK(ip))
> > -#define SET_UNIPERIF_I2S_FMT_ORDER_LSB(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_ORDER_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_ORDER_MASK(ip), 0)
> > -#define SET_UNIPERIF_I2S_FMT_ORDER_MSB(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_ORDER_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_ORDER_MASK(ip), 1)
> > -
> > -/* NUM_CH */
> > -#define UNIPERIF_I2S_FMT_NUM_CH_SHIFT(ip) 9
> > -#define UNIPERIF_I2S_FMT_NUM_CH_MASK(ip) 0x7
> > -#define GET_UNIPERIF_I2S_FMT_NUM_CH(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_NUM_CH_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_NUM_CH_MASK(ip))
> > -#define SET_UNIPERIF_I2S_FMT_NUM_CH(ip, value) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_NUM_CH_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_NUM_CH_MASK(ip), value)
> > -
> > -/* NO_OF_SAMPLES_TO_READ */
> > -#define UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ_SHIFT(ip) 12
> > -#define UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ_MASK(ip) 0xfffff
> > -#define GET_UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ_MASK(ip))
> > -#define SET_UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ(ip, value) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_I2S_FMT_OFFSET(ip), \
> > -		UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ_SHIFT(ip), \
> > -		UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ_MASK(ip),
> value)
> > -
> > -/*
> > - * UNIPERIF_BIT_CONTROL reg
> > - */
> > -
> > -#define UNIPERIF_BIT_CONTROL_OFFSET(ip)  \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 :
> 0x004c)
> > -#define GET_UNIPERIF_BIT_CONTROL(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_BIT_CONTROL_OFFSET(ip))
> > -#define SET_UNIPERIF_BIT_CONTROL(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_BIT_CONTROL_OFFSET(ip))
> > -
> > -/* CLR_UNDERFLOW_DURATION */
> > -#define UNIPERIF_BIT_CONTROL_CLR_UNDERFLOW_DURATION_SHIFT(ip) 0
> > -#define UNIPERIF_BIT_CONTROL_CLR_UNDERFLOW_DURATION_MASK(ip)
> 0x1
> > -#define GET_UNIPERIF_BIT_CONTROL_CLR_UNDERFLOW_DURATION(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_BIT_CONTROL_OFFSET(ip), \
> > -
> 	UNIPERIF_BIT_CONTROL_CLR_UNDERFLOW_DURATION_SHIFT(ip), \
> > -
> 	UNIPERIF_BIT_CONTROL_CLR_UNDERFLOW_DURATION_MASK(ip))
> > -#define SET_UNIPERIF_BIT_CONTROL_CLR_UNDERFLOW_DURATION(ip) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_BIT_CONTROL_OFFSET(ip), \
> > -
> 	UNIPERIF_BIT_CONTROL_CLR_UNDERFLOW_DURATION_SHIFT(ip), \
> > -
> 	UNIPERIF_BIT_CONTROL_CLR_UNDERFLOW_DURATION_MASK(ip), 1)
> > -
> > -/* CHL_STS_UPDATE */
> > -#define UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE_SHIFT(ip) 1
> > -#define UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE_MASK(ip) 0x1
> > -#define GET_UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_BIT_CONTROL_OFFSET(ip), \
> > -		UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE_SHIFT(ip), \
> > -		UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE_MASK(ip))
> > -#define SET_UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE(ip) \
> > -	SET_UNIPERIF_BIT_REG(ip, \
> > -		UNIPERIF_BIT_CONTROL_OFFSET(ip), \
> > -		UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE_SHIFT(ip), \
> > -		UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE_MASK(ip), 1)
> > -
> > -/*
> > - * UNIPERIF_STATUS_1 reg
> > - */
> > -
> > -#define UNIPERIF_STATUS_1_OFFSET(ip) 0x0050
> > -#define GET_UNIPERIF_STATUS_1(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_STATUS_1_OFFSET(ip))
> > -#define SET_UNIPERIF_STATUS_1(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_STATUS_1_OFFSET(ip))
> > -
> > -/* UNDERFLOW_DURATION */
> > -#define UNIPERIF_STATUS_1_UNDERFLOW_DURATION_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 : 0)
> > -#define UNIPERIF_STATUS_1_UNDERFLOW_DURATION_MASK(ip) 0xff
> > -#define GET_UNIPERIF_STATUS_1_UNDERFLOW_DURATION(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_STATUS_1_OFFSET(ip), \
> > -		UNIPERIF_STATUS_1_UNDERFLOW_DURATION_SHIFT(ip), \
> > -		UNIPERIF_STATUS_1_UNDERFLOW_DURATION_MASK(ip))
> > -#define SET_UNIPERIF_STATUS_1_UNDERFLOW_DURATION(ip, value) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_STATUS_1_OFFSET(ip), \
> > -		UNIPERIF_STATUS_1_UNDERFLOW_DURATION_SHIFT(ip), \
> > -		UNIPERIF_STATUS_1_UNDERFLOW_DURATION_MASK(ip),
> value)
> > -
> > -/*
> > - * UNIPERIF_CHANNEL_STA_REGN reg
> > - */
> > -
> > -#define UNIPERIF_CHANNEL_STA_REGN(ip, n) (0x0060 + (4 * n))
> > -#define GET_UNIPERIF_CHANNEL_STA_REGN(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_CHANNEL_STA_REGN(ip, n))
> > -#define SET_UNIPERIF_CHANNEL_STA_REGN(ip, n, value) \
> > -	writel_relaxed(value, ip->base + \
> > -			UNIPERIF_CHANNEL_STA_REGN(ip, n))
> > -
> > -/*
> > - * UNIPERIF_USER_VALIDITY reg
> > - */
> > -
> > -#define UNIPERIF_USER_VALIDITY_OFFSET(ip) 0x0090
> > -#define GET_UNIPERIF_USER_VALIDITY(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_USER_VALIDITY_OFFSET(ip))
> > -#define SET_UNIPERIF_USER_VALIDITY(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_USER_VALIDITY_OFFSET(ip))
> > -
> > -/* VALIDITY_LEFT_AND_RIGHT */
> > -#define UNIPERIF_USER_VALIDITY_VALIDITY_LR_SHIFT(ip) 0
> > -#define UNIPERIF_USER_VALIDITY_VALIDITY_LR_MASK(ip) 0x3
> > -#define GET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_USER_VALIDITY_OFFSET(ip), \
> > -		UNIPERIF_USER_VALIDITY_VALIDITY_LR_SHIFT(ip), \
> > -		UNIPERIF_USER_VALIDITY_VALIDITY_LR_MASK(ip))
> > -#define SET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(ip, value) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_USER_VALIDITY_OFFSET(ip), \
> > -		UNIPERIF_USER_VALIDITY_VALIDITY_LR_SHIFT(ip), \
> > -		UNIPERIF_USER_VALIDITY_VALIDITY_LR_MASK(ip), \
> > -		value ? 0x3 : 0)
> > -
> > -/*
> > - * UNIPERIF_DBG_STANDBY_LEFT_SP reg
> > - */
> > -#define UNIPERIF_DBG_STANDBY_LEFT_SP_OFFSET(ip) 0x0150
> > -#define UNIPERIF_DBG_STANDBY_LEFT_SP_SHIFT(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 : 0)
> > -#define UNIPERIF_DBG_STANDBY_LEFT_SP_MASK(ip) \
> > -	((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 0 :
> 0xFFFFFF)
> > -#define GET_UNIPERIF_DBG_STANDBY_LEFT_SP(ip) \
> > -	GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_DBG_STANDBY_LEFT_SP_OFFSET(ip), \
> > -		UNIPERIF_DBG_STANDBY_LEFT_SP_SHIFT(ip), \
> > -		UNIPERIF_DBG_STANDBY_LEFT_SP_MASK(ip))
> > -#define SET_UNIPERIF_DBG_STANDBY_LEFT_SP(ip, value) \
> > -	SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_DBG_STANDBY_LEFT_SP_OFFSET(ip), \
> > -		UNIPERIF_DBG_STANDBY_LEFT_SP_SHIFT(ip), \
> > -		UNIPERIF_DBG_STANDBY_LEFT_SP_MASK(ip), value)
> > -
> > -/*
> > - * UNIPERIF_TDM_ENABLE
> > - */
> > -#define UNIPERIF_TDM_ENABLE_OFFSET(ip) 0x0118
> > -#define GET_UNIPERIF_TDM_ENABLE(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_TDM_ENABLE_OFFSET(ip))
> > -#define SET_UNIPERIF_TDM_ENABLE(ip, value) \
> > -	writel_relaxed(value, ip->base + UNIPERIF_TDM_ENABLE_OFFSET(ip))
> > -
> > -/* TDM_ENABLE */
> > -#define UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip) 0x0
> > -#define UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip) 0x1
> > -#define GET_UNIPERIF_TDM_ENABLE_EN_TDM(ip) \
> > -		GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_TDM_ENABLE_OFFSET(ip), \
> > -		UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip), \
> > -		UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip))
> > -#define SET_UNIPERIF_TDM_ENABLE_TDM_ENABLE(ip) \
> > -		SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_TDM_ENABLE_OFFSET(ip), \
> > -		UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip), \
> > -		UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip), 1)
> > -#define SET_UNIPERIF_TDM_ENABLE_TDM_DISABLE(ip) \
> > -		SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_TDM_ENABLE_OFFSET(ip), \
> > -		UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip), \
> > -		UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip), 0)
> > -
> > -/*
> > - * UNIPERIF_TDM_FS_REF_FREQ
> > - */
> > -#define UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip) 0x011c
> > -#define GET_UNIPERIF_TDM_FS_REF_FREQ(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip))
> > -#define SET_UNIPERIF_TDM_FS_REF_FREQ(ip, value) \
> > -	writel_relaxed(value, ip->base + \
> > -			UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip))
> > -
> > -/* REF_FREQ */
> > -#define UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip) 0x0
> > -#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_8KHZ(ip) 0
> > -#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_16KHZ(ip) 1
> > -#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_32KHZ(ip) 2
> > -#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_48KHZ(ip) 3
> > -#define UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip) 0x3
> > -#define GET_UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ(ip) \
> > -		GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
> > -		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
> > -		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip))
> > -#define SET_UNIPERIF_TDM_FS_REF_FREQ_8KHZ(ip) \
> > -		SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
> > -		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
> > -		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
> > -		VALUE_UNIPERIF_TDM_FS_REF_FREQ_8KHZ(ip))
> > -#define SET_UNIPERIF_TDM_FS_REF_FREQ_16KHZ(ip) \
> > -		SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
> > -		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
> > -		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
> > -		VALUE_UNIPERIF_TDM_FS_REF_FREQ_16KHZ(ip))
> > -#define SET_UNIPERIF_TDM_FS_REF_FREQ_32KHZ(ip) \
> > -		SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
> > -		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
> > -		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
> > -		VALUE_UNIPERIF_TDM_FS_REF_FREQ_32KHZ(ip))
> > -#define SET_UNIPERIF_TDM_FS_REF_FREQ_48KHZ(ip) \
> > -		SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
> > -		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
> > -		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
> > -		VALUE_UNIPERIF_TDM_FS_REF_FREQ_48KHZ(ip))
> > -
> > -/*
> > - * UNIPERIF_TDM_FS_REF_DIV
> > - */
> > -#define UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip) 0x0120
> > -#define GET_UNIPERIF_TDM_FS_REF_DIV(ip) \
> > -	readl_relaxed(ip->base + UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip))
> > -#define SET_UNIPERIF_TDM_FS_REF_DIV(ip, value) \
> > -		writel_relaxed(value, ip->base + \
> > -			UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip))
> > -
> > -/* NUM_TIMESLOT */
> > -#define UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_SHIFT(ip) 0x0
> > -#define UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_MASK(ip) 0xff
> > -#define GET_UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT(ip) \
> > -		GET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip), \
> > -		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_SHIFT(ip), \
> > -		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_MASK(ip))
> > -#define SET_UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT(ip, value) \
> > -		SET_UNIPERIF_REG(ip, \
> > -		UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip), \
> > -		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_SHIFT(ip), \
> > -		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_MASK(ip),
> value)
> > -
> > -/*
> > - * UNIPERIF_TDM_WORD_POS_X_Y
> > - * 32 bits of UNIPERIF_TDM_WORD_POS_X_Y register shall be set in 1 sho=
t
> > - */
> > -#define UNIPERIF_TDM_WORD_POS_1_2_OFFSET(ip) 0x013c
> > -#define UNIPERIF_TDM_WORD_POS_3_4_OFFSET(ip) 0x0140
> > -#define UNIPERIF_TDM_WORD_POS_5_6_OFFSET(ip) 0x0144
> > -#define UNIPERIF_TDM_WORD_POS_7_8_OFFSET(ip) 0x0148
> > -#define GET_UNIPERIF_TDM_WORD_POS(ip, words) \
> > -	readl_relaxed(ip->base +
> UNIPERIF_TDM_WORD_POS_##words##_OFFSET(ip))
> > -#define SET_UNIPERIF_TDM_WORD_POS(ip, words, value) \
> > -		writel_relaxed(value, ip->base + \
> > -		UNIPERIF_TDM_WORD_POS_##words##_OFFSET(ip))
> > -/*
> > - * uniperipheral IP capabilities
> > - */
> > -
> > -#define UNIPERIF_FIFO_SIZE		70 /* FIFO is 70 cells deep */
> > -#define UNIPERIF_FIFO_FRAMES		4  /* FDMA trigger limit in
> frames */
> > -
> > -#define UNIPERIF_TYPE_IS_HDMI(p) \
> > -	((p)->type =3D=3D SND_ST_UNIPERIF_TYPE_HDMI)
> > -#define UNIPERIF_TYPE_IS_PCM(p) \
> > -	((p)->type =3D=3D SND_ST_UNIPERIF_TYPE_PCM)
> > -#define UNIPERIF_TYPE_IS_SPDIF(p) \
> > -	((p)->type =3D=3D SND_ST_UNIPERIF_TYPE_SPDIF)
> > -#define UNIPERIF_TYPE_IS_IEC958(p) \
> > -	(UNIPERIF_TYPE_IS_HDMI(p) || \
> > -		UNIPERIF_TYPE_IS_SPDIF(p))
> > -#define UNIPERIF_TYPE_IS_TDM(p) \
> > -	((p)->type =3D=3D SND_ST_UNIPERIF_TYPE_TDM)
> > -
> > -/*
> > - * Uniperipheral IP revisions
> > - */
> > -enum uniperif_version {
> > -	SND_ST_UNIPERIF_VERSION_UNKNOWN,
> > -	/* SASG1 (Orly), Newman */
> > -	SND_ST_UNIPERIF_VERSION_C6AUD0_UNI_1_0,
> > -	/* SASC1, SASG2 (Orly2) */
> > -	SND_ST_UNIPERIF_VERSION_UNI_PLR_1_0,
> > -	/* SASC1, SASG2 (Orly2), TELSS, Cannes */
> > -	SND_ST_UNIPERIF_VERSION_UNI_RDR_1_0,
> > -	/* TELSS (SASC1) */
> > -	SND_ST_UNIPERIF_VERSION_TDM_PLR_1_0,
> > -	/* Cannes/Monaco */
> > -	SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0
> > -};
> > -
> > -enum uniperif_type {
> > -	SND_ST_UNIPERIF_TYPE_NONE	=3D 0x00,
> > -	SND_ST_UNIPERIF_TYPE_HDMI	=3D 0x01,
> > -	SND_ST_UNIPERIF_TYPE_PCM	=3D 0x02,
> > -	SND_ST_UNIPERIF_TYPE_SPDIF	=3D 0x04,
> > -	SND_ST_UNIPERIF_TYPE_TDM	=3D 0x08
> > -};
> > -
> > -enum uniperif_state {
> > -	UNIPERIF_STATE_STOPPED,
> > -	UNIPERIF_STATE_STARTED,
> > -	UNIPERIF_STATE_STANDBY,
> > -	UNIPERIF_STATE_UNDERFLOW,
> > -	UNIPERIF_STATE_OVERFLOW =3D UNIPERIF_STATE_UNDERFLOW,
> > -	UNIPERIF_STATE_XRUN
> > -};
> > -
> > -enum uniperif_iec958_encoding_mode {
> > -	UNIPERIF_IEC958_ENCODING_MODE_PCM,
> > -	UNIPERIF_IEC958_ENCODING_MODE_ENCODED
> > -};
> > -
> > -enum uniperif_word_pos {
> > -	WORD_1_2,
> > -	WORD_3_4,
> > -	WORD_5_6,
> > -	WORD_7_8,
> > -	WORD_MAX
> > -};
> > -
> > -struct uniperif_iec958_settings {
> > -	enum uniperif_iec958_encoding_mode encoding_mode;
> > -	struct snd_aes_iec958 iec958;
> > -};
> > -
> > -struct dai_tdm_slot {
> > -	unsigned int mask;
> > -	int slots;
> > -	int slot_width;
> > -	unsigned int avail_slots;
> > -};
> > -
> > -struct uniperif {
> > -	/* System information */
> > -	enum uniperif_type type;
> > -	int underflow_enabled; /* Underflow recovery mode */
> > -	struct device *dev;
> > -	int id; /* instance value of the uniperipheral IP */
> > -	int ver; /* IP version, used by register access macros */
> > -	struct regmap_field *clk_sel;
> > -	struct regmap_field *valid_sel;
> > -	spinlock_t irq_lock; /* use to prevent race condition with IRQ */
> > -
> > -	/* capabilities */
> > -	const struct snd_pcm_hardware *hw;
> > -
> > -	/* Resources */
> > -	struct resource *mem_region;
> > -	void __iomem *base;
> > -	unsigned long fifo_phys_address;
> > -	int irq;
> > -
> > -	/* Clocks */
> > -	struct clk *clk;
> > -	int mclk;
> > -	int clk_adj;
> > -
> > -	/* Runtime data */
> > -	enum uniperif_state state;
> > -
> > -	struct snd_pcm_substream *substream;
> > -
> > -	/* Specific to IEC958 player */
> > -	struct uniperif_iec958_settings stream_settings;
> > -	struct mutex ctrl_lock; /* For resource updated by stream and
> controls*/
> > -
> > -	/*alsa ctrl*/
> > -	struct snd_kcontrol_new *snd_ctrls;
> > -	int num_ctrls;
> > -
> > -	/* dai properties */
> > -	unsigned int daifmt;
> > -	struct dai_tdm_slot tdm_slot;
> > -
> > -	/* DAI callbacks */
> > -	const struct snd_soc_dai_ops *dai_ops;
> > -};
> > -
> > -struct sti_uniperiph_dai {
> > -	int stream;
> > -	struct uniperif *uni;
> > -	struct snd_dmaengine_dai_dma_data dma_data;
> > -};
> > -
> > -struct sti_uniperiph_data {
> > -	struct platform_device *pdev;
> > -	struct snd_soc_dai_driver *dai;
> > -	struct sti_uniperiph_dai dai_data;
> > -};
> > -
> > -static __maybe_unused const struct snd_pcm_hardware uni_tdm_hw =3D {
> > -	.info =3D SNDRV_PCM_INFO_INTERLEAVED |
> SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > -		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
> > -		SNDRV_PCM_INFO_MMAP_VALID,
> > -
> > -	.formats =3D SNDRV_PCM_FMTBIT_S32_LE |
> SNDRV_PCM_FMTBIT_S16_LE,
> > -
> > -	.rates =3D SNDRV_PCM_RATE_CONTINUOUS,
> > -	.rate_min =3D 8000,
> > -	.rate_max =3D 48000,
> > -
> > -	.channels_min =3D 1,
> > -	.channels_max =3D 32,
> > -
> > -	.periods_min =3D 2,
> > -	.periods_max =3D 10,
> > -
> > -	.period_bytes_min =3D 128,
> > -	.period_bytes_max =3D 64 * PAGE_SIZE,
> > -	.buffer_bytes_max =3D 256 * PAGE_SIZE
> > -};
> > -
> > -/* uniperiph player*/
> > -int uni_player_init(struct platform_device *pdev,
> > -		    struct uniperif *player);
> > -int uni_player_resume(struct uniperif *player);
> > -
> > -/* uniperiph reader */
> > -int uni_reader_init(struct platform_device *pdev,
> > -		    struct uniperif *reader);
> > -
> > -/* common */
> > -int sti_uniperiph_dai_set_fmt(struct snd_soc_dai *dai,
> > -			      unsigned int fmt);
> > -
> > -int sti_uniperiph_dai_hw_params(struct snd_pcm_substream *substream,
> > -				struct snd_pcm_hw_params *params,
> > -				struct snd_soc_dai *dai);
> > -
> > -static inline int sti_uniperiph_get_user_frame_size(
> > -	struct snd_pcm_runtime *runtime)
> > -{
> > -	return (runtime->channels * snd_pcm_format_width(runtime->format)
> / 8);
> > -}
> > -
> > -static inline int sti_uniperiph_get_unip_tdm_frame_size(struct uniperi=
f *uni)
> > -{
> > -	return (uni->tdm_slot.slots * uni->tdm_slot.slot_width / 8);
> > -}
> > -
> > -int  sti_uniperiph_reset(struct uniperif *uni);
> > -
> > -int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int
> tx_mask,
> > -			       unsigned int rx_mask, int slots,
> > -			       int slot_width);
> > -
> > -int sti_uniperiph_get_tdm_word_pos(struct uniperif *uni,
> > -				   unsigned int *word_pos);
> > -
> > -int sti_uniperiph_fix_tdm_chan(struct snd_pcm_hw_params *params,
> > -			       struct snd_pcm_hw_rule *rule);
> > -
> > -int sti_uniperiph_fix_tdm_format(struct snd_pcm_hw_params *params,
> > -				 struct snd_pcm_hw_rule *rule);
> > -
> > -#endif
> > diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_p=
layer.c
> > deleted file mode 100644
> > index 2ed92c990b97..000000000000
> > --- a/sound/soc/sti/uniperif_player.c
> > +++ /dev/null
> > @@ -1,1148 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > -/*
> > - * Copyright (C) STMicroelectronics SA 2015
> > - * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > - *          for STMicroelectronics.
> > - */
> > -
> > -#include <linux/clk.h>
> > -#include <linux/mfd/syscon.h>
> > -
> > -#include <sound/asoundef.h>
> > -#include <sound/soc.h>
> > -
> > -#include "uniperif.h"
> > -
> > -/*
> > - * Some hardware-related definitions
> > - */
> > -
> > -/* sys config registers definitions */
> > -#define SYS_CFG_AUDIO_GLUE 0xA4
> > -
> > -/*
> > - * Driver specific types.
> > - */
> > -
> > -#define UNIPERIF_PLAYER_CLK_ADJ_MIN  -999999
> > -#define UNIPERIF_PLAYER_CLK_ADJ_MAX  1000000
> > -#define UNIPERIF_PLAYER_I2S_OUT 1 /* player id connected to I2S/TDM TX
> bus */
> > -
> > -/*
> > - * Note: snd_pcm_hardware is linked to DMA controller but is declared =
here
> to
> > - * integrate  DAI_CPU capability in term of rate and supported channel=
s
> > - */
> > -static const struct snd_pcm_hardware uni_player_pcm_hw =3D {
> > -	.info =3D SNDRV_PCM_INFO_INTERLEAVED |
> SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > -		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
> > -		SNDRV_PCM_INFO_MMAP_VALID,
> > -	.formats =3D SNDRV_PCM_FMTBIT_S32_LE |
> SNDRV_PCM_FMTBIT_S16_LE,
> > -
> > -	.rates =3D SNDRV_PCM_RATE_CONTINUOUS,
> > -	.rate_min =3D 8000,
> > -	.rate_max =3D 192000,
> > -
> > -	.channels_min =3D 2,
> > -	.channels_max =3D 8,
> > -
> > -	.periods_min =3D 2,
> > -	.periods_max =3D 48,
> > -
> > -	.period_bytes_min =3D 128,
> > -	.period_bytes_max =3D 64 * PAGE_SIZE,
> > -	.buffer_bytes_max =3D 256 * PAGE_SIZE
> > -};
> > -
> > -/*
> > - * uni_player_irq_handler
> > - * In case of error audio stream is stopped; stop action is protected =
via PCM
> > - * stream lock to avoid race condition with trigger callback.
> > - */
> > -static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
> > -{
> > -	irqreturn_t ret =3D IRQ_NONE;
> > -	struct uniperif *player =3D dev_id;
> > -	unsigned int status;
> > -	unsigned int tmp;
> > -
> > -	spin_lock(&player->irq_lock);
> > -	if (!player->substream)
> > -		goto irq_spin_unlock;
> > -
> > -	snd_pcm_stream_lock(player->substream);
> > -	if (player->state =3D=3D UNIPERIF_STATE_STOPPED)
> > -		goto stream_unlock;
> > -
> > -	/* Get interrupt status & clear them immediately */
> > -	status =3D GET_UNIPERIF_ITS(player);
> > -	SET_UNIPERIF_ITS_BCLR(player, status);
> > -
> > -	/* Check for fifo error (underrun) */
> > -	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(player))) {
> > -		dev_err(player->dev, "FIFO underflow error detected\n");
> > -
> > -		/* Interrupt is just for information when underflow recovery */
> > -		if (player->underflow_enabled) {
> > -			/* Update state to underflow */
> > -			player->state =3D UNIPERIF_STATE_UNDERFLOW;
> > -
> > -		} else {
> > -			/* Disable interrupt so doesn't continually fire */
> > -			SET_UNIPERIF_ITM_BCLR_FIFO_ERROR(player);
> > -
> > -			/* Stop the player */
> > -			snd_pcm_stop_xrun(player->substream);
> > -		}
> > -
> > -		ret =3D IRQ_HANDLED;
> > -	}
> > -
> > -	/* Check for dma error (overrun) */
> > -	if (unlikely(status & UNIPERIF_ITS_DMA_ERROR_MASK(player))) {
> > -		dev_err(player->dev, "DMA error detected\n");
> > -
> > -		/* Disable interrupt so doesn't continually fire */
> > -		SET_UNIPERIF_ITM_BCLR_DMA_ERROR(player);
> > -
> > -		/* Stop the player */
> > -		snd_pcm_stop_xrun(player->substream);
> > -
> > -		ret =3D IRQ_HANDLED;
> > -	}
> > -
> > -	/* Check for underflow recovery done */
> > -	if (unlikely(status &
> UNIPERIF_ITM_UNDERFLOW_REC_DONE_MASK(player))) {
> > -		if (!player->underflow_enabled) {
> > -			dev_err(player->dev,
> > -				"unexpected Underflow recovering\n");
> > -			ret =3D -EPERM;
> > -			goto stream_unlock;
> > -		}
> > -		/* Read the underflow recovery duration */
> > -		tmp =3D
> GET_UNIPERIF_STATUS_1_UNDERFLOW_DURATION(player);
> > -		dev_dbg(player->dev, "Underflow recovered (%d LR clocks
> max)\n",
> > -			tmp);
> > -
> > -		/* Clear the underflow recovery duration */
> > -
> 	SET_UNIPERIF_BIT_CONTROL_CLR_UNDERFLOW_DURATION(player);
> > -
> > -		/* Update state to started */
> > -		player->state =3D UNIPERIF_STATE_STARTED;
> > -
> > -		ret =3D IRQ_HANDLED;
> > -	}
> > -
> > -	/* Check if underflow recovery failed */
> > -	if (unlikely(status &
> > -		     UNIPERIF_ITM_UNDERFLOW_REC_FAILED_MASK(player))) {
> > -		dev_err(player->dev, "Underflow recovery failed\n");
> > -
> > -		/* Stop the player */
> > -		snd_pcm_stop_xrun(player->substream);
> > -
> > -		ret =3D IRQ_HANDLED;
> > -	}
> > -
> > -stream_unlock:
> > -	snd_pcm_stream_unlock(player->substream);
> > -irq_spin_unlock:
> > -	spin_unlock(&player->irq_lock);
> > -
> > -	return ret;
> > -}
> > -
> > -static int uni_player_clk_set_rate(struct uniperif *player, unsigned l=
ong rate)
> > -{
> > -	int rate_adjusted, rate_achieved, delta, ret;
> > -	int adjustment =3D player->clk_adj;
> > -
> > -	/*
> > -	 *             a
> > -	 * F =3D f + --------- * f =3D f + d
> > -	 *          1000000
> > -	 *
> > -	 *         a
> > -	 * d =3D --------- * f
> > -	 *      1000000
> > -	 *
> > -	 * where:
> > -	 *   f - nominal rate
> > -	 *   a - adjustment in ppm (parts per milion)
> > -	 *   F - rate to be set in synthesizer
> > -	 *   d - delta (difference) between f and F
> > -	 */
> > -	if (adjustment < 0) {
> > -		/* div64_64 operates on unsigned values... */
> > -		delta =3D -1;
> > -		adjustment =3D -adjustment;
> > -	} else {
> > -		delta =3D 1;
> > -	}
> > -	/* 500000 ppm is 0.5, which is used to round up values */
> > -	delta *=3D (int)div64_u64((uint64_t)rate *
> > -				(uint64_t)adjustment + 500000, 1000000);
> > -	rate_adjusted =3D rate + delta;
> > -
> > -	/* Adjusted rate should never be =3D=3D 0 */
> > -	if (!rate_adjusted)
> > -		return -EINVAL;
> > -
> > -	ret =3D clk_set_rate(player->clk, rate_adjusted);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	rate_achieved =3D clk_get_rate(player->clk);
> > -	if (!rate_achieved)
> > -		/* If value is 0 means that clock or parent not valid */
> > -		return -EINVAL;
> > -
> > -	/*
> > -	 * Using ALSA's adjustment control, we can modify the rate to be up
> > -	 * to twice as much as requested, but no more
> > -	 */
> > -	delta =3D rate_achieved - rate;
> > -	if (delta < 0) {
> > -		/* div64_64 operates on unsigned values... */
> > -		delta =3D -delta;
> > -		adjustment =3D -1;
> > -	} else {
> > -		adjustment =3D 1;
> > -	}
> > -	/* Frequency/2 is added to round up result */
> > -	adjustment *=3D (int)div64_u64((uint64_t)delta * 1000000 + rate / 2,
> > -				     rate);
> > -	player->clk_adj =3D adjustment;
> > -	return 0;
> > -}
> > -
> > -static void uni_player_set_channel_status(struct uniperif *player,
> > -					  struct snd_pcm_runtime *runtime)
> > -{
> > -	int n;
> > -	unsigned int status;
> > -
> > -	/*
> > -	 * Some AVRs and TVs require the channel status to contain a correct
> > -	 * sampling frequency. If no sample rate is already specified, then
> > -	 * set one.
> > -	 */
> > -	if (runtime) {
> > -		switch (runtime->rate) {
> > -		case 22050:
> > -			player->stream_settings.iec958.status[3] =3D
> > -						IEC958_AES3_CON_FS_22050;
> > -			break;
> > -		case 44100:
> > -			player->stream_settings.iec958.status[3] =3D
> > -						IEC958_AES3_CON_FS_44100;
> > -			break;
> > -		case 88200:
> > -			player->stream_settings.iec958.status[3] =3D
> > -						IEC958_AES3_CON_FS_88200;
> > -			break;
> > -		case 176400:
> > -			player->stream_settings.iec958.status[3] =3D
> > -
> 	IEC958_AES3_CON_FS_176400;
> > -			break;
> > -		case 24000:
> > -			player->stream_settings.iec958.status[3] =3D
> > -						IEC958_AES3_CON_FS_24000;
> > -			break;
> > -		case 48000:
> > -			player->stream_settings.iec958.status[3] =3D
> > -						IEC958_AES3_CON_FS_48000;
> > -			break;
> > -		case 96000:
> > -			player->stream_settings.iec958.status[3] =3D
> > -						IEC958_AES3_CON_FS_96000;
> > -			break;
> > -		case 192000:
> > -			player->stream_settings.iec958.status[3] =3D
> > -
> 	IEC958_AES3_CON_FS_192000;
> > -			break;
> > -		case 32000:
> > -			player->stream_settings.iec958.status[3] =3D
> > -						IEC958_AES3_CON_FS_32000;
> > -			break;
> > -		default:
> > -			/* Mark as sampling frequency not indicated */
> > -			player->stream_settings.iec958.status[3] =3D
> > -						IEC958_AES3_CON_FS_NOTID;
> > -			break;
> > -		}
> > -	}
> > -
> > -	/* Audio mode:
> > -	 * Use audio mode status to select PCM or encoded mode
> > -	 */
> > -	if (player->stream_settings.iec958.status[0] &
> IEC958_AES0_NONAUDIO)
> > -		player->stream_settings.encoding_mode =3D
> > -			UNIPERIF_IEC958_ENCODING_MODE_ENCODED;
> > -	else
> > -		player->stream_settings.encoding_mode =3D
> > -			UNIPERIF_IEC958_ENCODING_MODE_PCM;
> > -
> > -	if (player->stream_settings.encoding_mode =3D=3D
> > -		UNIPERIF_IEC958_ENCODING_MODE_PCM)
> > -		/* Clear user validity bits */
> > -		SET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(player, 0);
> > -	else
> > -		/* Set user validity bits */
> > -		SET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(player, 1);
> > -
> > -	/* Program the new channel status */
> > -	for (n =3D 0; n < 6; ++n) {
> > -		status  =3D
> > -		player->stream_settings.iec958.status[0 + (n * 4)] & 0xf;
> > -		status |=3D
> > -		player->stream_settings.iec958.status[1 + (n * 4)] << 8;
> > -		status |=3D
> > -		player->stream_settings.iec958.status[2 + (n * 4)] << 16;
> > -		status |=3D
> > -		player->stream_settings.iec958.status[3 + (n * 4)] << 24;
> > -		SET_UNIPERIF_CHANNEL_STA_REGN(player, n, status);
> > -	}
> > -
> > -	/* Update the channel status */
> > -	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
> > -		SET_UNIPERIF_CONFIG_CHL_STS_UPDATE(player);
> > -	else
> > -		SET_UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE(player);
> > -}
> > -
> > -static int uni_player_prepare_iec958(struct uniperif *player,
> > -				     struct snd_pcm_runtime *runtime)
> > -{
> > -	int clk_div;
> > -
> > -	clk_div =3D player->mclk / runtime->rate;
> > -
> > -	/* Oversampling must be multiple of 128 as iec958 frame is 32-bits */
> > -	if ((clk_div % 128) || (clk_div <=3D 0)) {
> > -		dev_err(player->dev, "%s: invalid clk_div %d\n",
> > -			__func__, clk_div);
> > -		return -EINVAL;
> > -	}
> > -
> > -	switch (runtime->format) {
> > -	case SNDRV_PCM_FORMAT_S16_LE:
> > -		/* 16/16 memory format */
> > -		SET_UNIPERIF_CONFIG_MEM_FMT_16_16(player);
> > -		/* 16-bits per sub-frame */
> > -		SET_UNIPERIF_I2S_FMT_NBIT_32(player);
> > -		/* Set 16-bit sample precision */
> > -		SET_UNIPERIF_I2S_FMT_DATA_SIZE_16(player);
> > -		break;
> > -	case SNDRV_PCM_FORMAT_S32_LE:
> > -		/* 16/0 memory format */
> > -		SET_UNIPERIF_CONFIG_MEM_FMT_16_0(player);
> > -		/* 32-bits per sub-frame */
> > -		SET_UNIPERIF_I2S_FMT_NBIT_32(player);
> > -		/* Set 24-bit sample precision */
> > -		SET_UNIPERIF_I2S_FMT_DATA_SIZE_24(player);
> > -		break;
> > -	default:
> > -		dev_err(player->dev, "format not supported\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Set parity to be calculated by the hardware */
> > -	SET_UNIPERIF_CONFIG_PARITY_CNTR_BY_HW(player);
> > -
> > -	/* Set channel status bits to be inserted by the hardware */
> > -	SET_UNIPERIF_CONFIG_CHANNEL_STA_CNTR_BY_HW(player);
> > -
> > -	/* Set user data bits to be inserted by the hardware */
> > -	SET_UNIPERIF_CONFIG_USER_DAT_CNTR_BY_HW(player);
> > -
> > -	/* Set validity bits to be inserted by the hardware */
> > -	SET_UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_BY_HW(player);
> > -
> > -	/* Set full software control to disabled */
> > -	SET_UNIPERIF_CONFIG_SPDIF_SW_CTRL_DISABLE(player);
> > -
> > -	SET_UNIPERIF_CTRL_ZERO_STUFF_HW(player);
> > -
> > -	mutex_lock(&player->ctrl_lock);
> > -	/* Update the channel status */
> > -	uni_player_set_channel_status(player, runtime);
> > -	mutex_unlock(&player->ctrl_lock);
> > -
> > -	/* Clear the user validity user bits */
> > -	SET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(player, 0);
> > -
> > -	/* Disable one-bit audio mode */
> > -	SET_UNIPERIF_CONFIG_ONE_BIT_AUD_DISABLE(player);
> > -
> > -	/* Enable consecutive frames repetition of Z preamble (not for HBRA)
> */
> > -	SET_UNIPERIF_CONFIG_REPEAT_CHL_STS_ENABLE(player);
> > -
> > -	/* Change to SUF0_SUBF1 and left/right channels swap! */
> > -	SET_UNIPERIF_CONFIG_SUBFRAME_SEL_SUBF1_SUBF0(player);
> > -
> > -	/* Set data output as MSB first */
> > -	SET_UNIPERIF_I2S_FMT_ORDER_MSB(player);
> > -
> > -	if (player->stream_settings.encoding_mode =3D=3D
> > -
> 	UNIPERIF_IEC958_ENCODING_MODE_ENCODED)
> > -		SET_UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_ON(player);
> > -	else
> > -		SET_UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_OFF(player);
> > -
> > -	SET_UNIPERIF_I2S_FMT_NUM_CH(player, runtime->channels / 2);
> > -
> > -	/* Set rounding to off */
> > -	SET_UNIPERIF_CTRL_ROUNDING_OFF(player);
> > -
> > -	/* Set clock divisor */
> > -	SET_UNIPERIF_CTRL_DIVIDER(player, clk_div / 128);
> > -
> > -	/* Set the spdif latency to not wait before starting player */
> > -	SET_UNIPERIF_CTRL_SPDIF_LAT_OFF(player);
> > -
> > -	/*
> > -	 * Ensure iec958 formatting is off. It will be enabled in function
> > -	 * uni_player_start() at the same time as the operation
> > -	 * mode is set to work around a silicon issue.
> > -	 */
> > -	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
> > -		SET_UNIPERIF_CTRL_SPDIF_FMT_OFF(player);
> > -	else
> > -		SET_UNIPERIF_CTRL_SPDIF_FMT_ON(player);
> > -
> > -	return 0;
> > -}
> > -
> > -static int uni_player_prepare_pcm(struct uniperif *player,
> > -				  struct snd_pcm_runtime *runtime)
> > -{
> > -	int output_frame_size, slot_width, clk_div;
> > -
> > -	/* Force slot width to 32 in I2S mode (HW constraint) */
> > -	if ((player->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) =3D=3D
> > -		SND_SOC_DAIFMT_I2S)
> > -		slot_width =3D 32;
> > -	else
> > -		slot_width =3D snd_pcm_format_width(runtime->format);
> > -
> > -	output_frame_size =3D slot_width * runtime->channels;
> > -
> > -	clk_div =3D player->mclk / runtime->rate;
> > -	/*
> > -	 * For 32 bits subframe clk_div must be a multiple of 128,
> > -	 * for 16 bits must be a multiple of 64
> > -	 */
> > -	if ((slot_width =3D=3D 32) && (clk_div % 128)) {
> > -		dev_err(player->dev, "%s: invalid clk_div\n", __func__);
> > -		return -EINVAL;
> > -	}
> > -
> > -	if ((slot_width =3D=3D 16) && (clk_div % 64)) {
> > -		dev_err(player->dev, "%s: invalid clk_div\n", __func__);
> > -		return -EINVAL;
> > -	}
> > -
> > -	/*
> > -	 * Number of bits per subframe (which is one channel sample)
> > -	 * on output - Transfer 16 or 32 bits from FIFO
> > -	 */
> > -	switch (slot_width) {
> > -	case 32:
> > -		SET_UNIPERIF_I2S_FMT_NBIT_32(player);
> > -		SET_UNIPERIF_I2S_FMT_DATA_SIZE_32(player);
> > -		break;
> > -	case 16:
> > -		SET_UNIPERIF_I2S_FMT_NBIT_16(player);
> > -		SET_UNIPERIF_I2S_FMT_DATA_SIZE_16(player);
> > -		break;
> > -	default:
> > -		dev_err(player->dev, "subframe format not supported\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Configure data memory format */
> > -	switch (runtime->format) {
> > -	case SNDRV_PCM_FORMAT_S16_LE:
> > -		/* One data word contains two samples */
> > -		SET_UNIPERIF_CONFIG_MEM_FMT_16_16(player);
> > -		break;
> > -
> > -	case SNDRV_PCM_FORMAT_S32_LE:
> > -		/*
> > -		 * Actually "16 bits/0 bits" means "32/28/24/20/18/16 bits
> > -		 * on the left than zeros (if less than 32 bytes)"... ;-)
> > -		 */
> > -		SET_UNIPERIF_CONFIG_MEM_FMT_16_0(player);
> > -		break;
> > -
> > -	default:
> > -		dev_err(player->dev, "format not supported\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Set rounding to off */
> > -	SET_UNIPERIF_CTRL_ROUNDING_OFF(player);
> > -
> > -	/* Set clock divisor */
> > -	SET_UNIPERIF_CTRL_DIVIDER(player, clk_div / (2 *
> output_frame_size));
> > -
> > -	/* Number of channelsmust be even*/
> > -	if ((runtime->channels % 2) || (runtime->channels < 2) ||
> > -	    (runtime->channels > 10)) {
> > -		dev_err(player->dev, "%s: invalid nb of channels\n", __func__);
> > -		return -EINVAL;
> > -	}
> > -
> > -	SET_UNIPERIF_I2S_FMT_NUM_CH(player, runtime->channels / 2);
> > -
> > -	/* Set 1-bit audio format to disabled */
> > -	SET_UNIPERIF_CONFIG_ONE_BIT_AUD_DISABLE(player);
> > -
> > -	SET_UNIPERIF_I2S_FMT_ORDER_MSB(player);
> > -
> > -	/* No iec958 formatting as outputting to DAC  */
> > -	SET_UNIPERIF_CTRL_SPDIF_FMT_OFF(player);
> > -
> > -	return 0;
> > -}
> > -
> > -static int uni_player_prepare_tdm(struct uniperif *player,
> > -				  struct snd_pcm_runtime *runtime)
> > -{
> > -	int tdm_frame_size; /* unip tdm frame size in bytes */
> > -	int user_frame_size; /* user tdm frame size in bytes */
> > -	/* default unip TDM_WORD_POS_X_Y */
> > -	unsigned int word_pos[4] =3D {
> > -		0x04060002, 0x0C0E080A, 0x14161012, 0x1C1E181A};
> > -	int freq, ret;
> > -
> > -	tdm_frame_size =3D
> > -		sti_uniperiph_get_unip_tdm_frame_size(player);
> > -	user_frame_size =3D
> > -		sti_uniperiph_get_user_frame_size(runtime);
> > -
> > -	/* fix 16/0 format */
> > -	SET_UNIPERIF_CONFIG_MEM_FMT_16_0(player);
> > -	SET_UNIPERIF_I2S_FMT_DATA_SIZE_32(player);
> > -
> > -	/* number of words inserted on the TDM line */
> > -	SET_UNIPERIF_I2S_FMT_NUM_CH(player, user_frame_size / 4 / 2);
> > -
> > -	SET_UNIPERIF_I2S_FMT_ORDER_MSB(player);
> > -	SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(player);
> > -
> > -	/* Enable the tdm functionality */
> > -	SET_UNIPERIF_TDM_ENABLE_TDM_ENABLE(player);
> > -
> > -	/* number of 8 bits timeslots avail in unip tdm frame */
> > -	SET_UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT(player,
> tdm_frame_size);
> > -
> > -	/* set the timeslot allocation for words in FIFO */
> > -	sti_uniperiph_get_tdm_word_pos(player, word_pos);
> > -	SET_UNIPERIF_TDM_WORD_POS(player, 1_2, word_pos[WORD_1_2]);
> > -	SET_UNIPERIF_TDM_WORD_POS(player, 3_4, word_pos[WORD_3_4]);
> > -	SET_UNIPERIF_TDM_WORD_POS(player, 5_6, word_pos[WORD_5_6]);
> > -	SET_UNIPERIF_TDM_WORD_POS(player, 7_8, word_pos[WORD_7_8]);
> > -
> > -	/* set unip clk rate (not done vai set_sysclk ops) */
> > -	freq =3D runtime->rate * tdm_frame_size * 8;
> > -	mutex_lock(&player->ctrl_lock);
> > -	ret =3D uni_player_clk_set_rate(player, freq);
> > -	if (!ret)
> > -		player->mclk =3D freq;
> > -	mutex_unlock(&player->ctrl_lock);
> > -
> > -	return 0;
> > -}
> > -
> > -/*
> > - * ALSA uniperipheral iec958 controls
> > - */
> > -static int  uni_player_ctl_iec958_info(struct snd_kcontrol *kcontrol,
> > -				       struct snd_ctl_elem_info *uinfo)
> > -{
> > -	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_IEC958;
> > -	uinfo->count =3D 1;
> > -
> > -	return 0;
> > -}
> > -
> > -static int uni_player_ctl_iec958_get(struct snd_kcontrol *kcontrol,
> > -				     struct snd_ctl_elem_value *ucontrol)
> > -{
> > -	struct snd_soc_dai *dai =3D snd_kcontrol_chip(kcontrol);
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *player =3D priv->dai_data.uni;
> > -	struct snd_aes_iec958 *iec958 =3D &player->stream_settings.iec958;
> > -
> > -	mutex_lock(&player->ctrl_lock);
> > -	ucontrol->value.iec958.status[0] =3D iec958->status[0];
> > -	ucontrol->value.iec958.status[1] =3D iec958->status[1];
> > -	ucontrol->value.iec958.status[2] =3D iec958->status[2];
> > -	ucontrol->value.iec958.status[3] =3D iec958->status[3];
> > -	mutex_unlock(&player->ctrl_lock);
> > -	return 0;
> > -}
> > -
> > -static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
> > -				     struct snd_ctl_elem_value *ucontrol)
> > -{
> > -	struct snd_soc_dai *dai =3D snd_kcontrol_chip(kcontrol);
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *player =3D priv->dai_data.uni;
> > -	struct snd_aes_iec958 *iec958 =3D  &player->stream_settings.iec958;
> > -	unsigned long flags;
> > -
> > -	mutex_lock(&player->ctrl_lock);
> > -	iec958->status[0] =3D ucontrol->value.iec958.status[0];
> > -	iec958->status[1] =3D ucontrol->value.iec958.status[1];
> > -	iec958->status[2] =3D ucontrol->value.iec958.status[2];
> > -	iec958->status[3] =3D ucontrol->value.iec958.status[3];
> > -
> > -	spin_lock_irqsave(&player->irq_lock, flags);
> > -	if (player->substream && player->substream->runtime)
> > -		uni_player_set_channel_status(player,
> > -					      player->substream->runtime);
> > -	else
> > -		uni_player_set_channel_status(player, NULL);
> > -
> > -	spin_unlock_irqrestore(&player->irq_lock, flags);
> > -	mutex_unlock(&player->ctrl_lock);
> > -
> > -	return 0;
> > -}
> > -
> > -static struct snd_kcontrol_new uni_player_iec958_ctl =3D {
> > -	.iface =3D SNDRV_CTL_ELEM_IFACE_PCM,
> > -	.name =3D SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
> > -	.info =3D uni_player_ctl_iec958_info,
> > -	.get =3D uni_player_ctl_iec958_get,
> > -	.put =3D uni_player_ctl_iec958_put,
> > -};
> > -
> > -/*
> > - * uniperif rate adjustement control
> > - */
> > -static int snd_sti_clk_adjustment_info(struct snd_kcontrol *kcontrol,
> > -				       struct snd_ctl_elem_info *uinfo)
> > -{
> > -	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
> > -	uinfo->count =3D 1;
> > -	uinfo->value.integer.min =3D UNIPERIF_PLAYER_CLK_ADJ_MIN;
> > -	uinfo->value.integer.max =3D UNIPERIF_PLAYER_CLK_ADJ_MAX;
> > -	uinfo->value.integer.step =3D 1;
> > -
> > -	return 0;
> > -}
> > -
> > -static int snd_sti_clk_adjustment_get(struct snd_kcontrol *kcontrol,
> > -				      struct snd_ctl_elem_value *ucontrol)
> > -{
> > -	struct snd_soc_dai *dai =3D snd_kcontrol_chip(kcontrol);
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *player =3D priv->dai_data.uni;
> > -
> > -	mutex_lock(&player->ctrl_lock);
> > -	ucontrol->value.integer.value[0] =3D player->clk_adj;
> > -	mutex_unlock(&player->ctrl_lock);
> > -
> > -	return 0;
> > -}
> > -
> > -static int snd_sti_clk_adjustment_put(struct snd_kcontrol *kcontrol,
> > -				      struct snd_ctl_elem_value *ucontrol)
> > -{
> > -	struct snd_soc_dai *dai =3D snd_kcontrol_chip(kcontrol);
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *player =3D priv->dai_data.uni;
> > -	int ret =3D 0;
> > -
> > -	if ((ucontrol->value.integer.value[0] <
> UNIPERIF_PLAYER_CLK_ADJ_MIN) ||
> > -	    (ucontrol->value.integer.value[0] >
> UNIPERIF_PLAYER_CLK_ADJ_MAX))
> > -		return -EINVAL;
> > -
> > -	mutex_lock(&player->ctrl_lock);
> > -	player->clk_adj =3D ucontrol->value.integer.value[0];
> > -
> > -	if (player->mclk)
> > -		ret =3D uni_player_clk_set_rate(player, player->mclk);
> > -	mutex_unlock(&player->ctrl_lock);
> > -
> > -	return ret;
> > -}
> > -
> > -static struct snd_kcontrol_new uni_player_clk_adj_ctl =3D {
> > -	.iface =3D SNDRV_CTL_ELEM_IFACE_PCM,
> > -	.name =3D "PCM Playback Oversampling Freq. Adjustment",
> > -	.info =3D snd_sti_clk_adjustment_info,
> > -	.get =3D snd_sti_clk_adjustment_get,
> > -	.put =3D snd_sti_clk_adjustment_put,
> > -};
> > -
> > -static struct snd_kcontrol_new *snd_sti_pcm_ctl[] =3D {
> > -	&uni_player_clk_adj_ctl,
> > -};
> > -
> > -static struct snd_kcontrol_new *snd_sti_iec_ctl[] =3D {
> > -	&uni_player_iec958_ctl,
> > -	&uni_player_clk_adj_ctl,
> > -};
> > -
> > -static int uni_player_startup(struct snd_pcm_substream *substream,
> > -			      struct snd_soc_dai *dai)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *player =3D priv->dai_data.uni;
> > -	unsigned long flags;
> > -	int ret;
> > -
> > -	spin_lock_irqsave(&player->irq_lock, flags);
> > -	player->substream =3D substream;
> > -	spin_unlock_irqrestore(&player->irq_lock, flags);
> > -
> > -	player->clk_adj =3D 0;
> > -
> > -	if (!UNIPERIF_TYPE_IS_TDM(player))
> > -		return 0;
> > -
> > -	/* refine hw constraint in tdm mode */
> > -	ret =3D snd_pcm_hw_rule_add(substream->runtime, 0,
> > -				  SNDRV_PCM_HW_PARAM_CHANNELS,
> > -				  sti_uniperiph_fix_tdm_chan,
> > -				  player,
> SNDRV_PCM_HW_PARAM_CHANNELS,
> > -				  -1);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	return snd_pcm_hw_rule_add(substream->runtime, 0,
> > -				   SNDRV_PCM_HW_PARAM_FORMAT,
> > -				   sti_uniperiph_fix_tdm_format,
> > -				   player, SNDRV_PCM_HW_PARAM_FORMAT,
> > -				   -1);
> > -}
> > -
> > -static int uni_player_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> > -				 unsigned int freq, int dir)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *player =3D priv->dai_data.uni;
> > -	int ret;
> > -
> > -	if (UNIPERIF_TYPE_IS_TDM(player) || (dir =3D=3D SND_SOC_CLOCK_IN))
> > -		return 0;
> > -
> > -	if (clk_id !=3D 0)
> > -		return -EINVAL;
> > -
> > -	mutex_lock(&player->ctrl_lock);
> > -	ret =3D uni_player_clk_set_rate(player, freq);
> > -	if (!ret)
> > -		player->mclk =3D freq;
> > -	mutex_unlock(&player->ctrl_lock);
> > -
> > -	return ret;
> > -}
> > -
> > -static int uni_player_prepare(struct snd_pcm_substream *substream,
> > -			      struct snd_soc_dai *dai)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *player =3D priv->dai_data.uni;
> > -	struct snd_pcm_runtime *runtime =3D substream->runtime;
> > -	int transfer_size, trigger_limit;
> > -	int ret;
> > -
> > -	/* The player should be stopped */
> > -	if (player->state !=3D UNIPERIF_STATE_STOPPED) {
> > -		dev_err(player->dev, "%s: invalid player state %d\n", __func__,
> > -			player->state);
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Calculate transfer size (in fifo cells and bytes) for frame count =
*/
> > -	if (player->type =3D=3D SND_ST_UNIPERIF_TYPE_TDM) {
> > -		/* transfer size =3D user frame size (in 32 bits FIFO cell) */
> > -		transfer_size =3D
> > -			sti_uniperiph_get_user_frame_size(runtime) / 4;
> > -	} else {
> > -		transfer_size =3D runtime->channels * UNIPERIF_FIFO_FRAMES;
> > -	}
> > -
> > -	/* Calculate number of empty cells available before asserting DREQ */
> > -	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0) {
> > -		trigger_limit =3D UNIPERIF_FIFO_SIZE - transfer_size;
> > -	} else {
> > -		/*
> > -		 * Since SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0
> > -		 * FDMA_TRIGGER_LIMIT also controls when the state switches
> > -		 * from OFF or STANDBY to AUDIO DATA.
> > -		 */
> > -		trigger_limit =3D transfer_size;
> > -	}
> > -
> > -	/* Trigger limit must be an even number */
> > -	if ((!trigger_limit % 2) || (trigger_limit !=3D 1 && transfer_size % =
2) ||
> > -	    (trigger_limit >
> UNIPERIF_CONFIG_DMA_TRIG_LIMIT_MASK(player))) {
> > -		dev_err(player->dev, "invalid trigger limit %d\n",
> > -			trigger_limit);
> > -		return -EINVAL;
> > -	}
> > -
> > -	SET_UNIPERIF_CONFIG_DMA_TRIG_LIMIT(player, trigger_limit);
> > -
> > -	/* Uniperipheral setup depends on player type */
> > -	switch (player->type) {
> > -	case SND_ST_UNIPERIF_TYPE_HDMI:
> > -		ret =3D uni_player_prepare_iec958(player, runtime);
> > -		break;
> > -	case SND_ST_UNIPERIF_TYPE_PCM:
> > -		ret =3D uni_player_prepare_pcm(player, runtime);
> > -		break;
> > -	case SND_ST_UNIPERIF_TYPE_SPDIF:
> > -		ret =3D uni_player_prepare_iec958(player, runtime);
> > -		break;
> > -	case SND_ST_UNIPERIF_TYPE_TDM:
> > -		ret =3D uni_player_prepare_tdm(player, runtime);
> > -		break;
> > -	default:
> > -		dev_err(player->dev, "invalid player type\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	if (ret)
> > -		return ret;
> > -
> > -	switch (player->daifmt & SND_SOC_DAIFMT_INV_MASK) {
> > -	case SND_SOC_DAIFMT_NB_NF:
> > -		SET_UNIPERIF_I2S_FMT_LR_POL_LOW(player);
> > -		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_RISING(player);
> > -		break;
> > -	case SND_SOC_DAIFMT_NB_IF:
> > -		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(player);
> > -		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_RISING(player);
> > -		break;
> > -	case SND_SOC_DAIFMT_IB_NF:
> > -		SET_UNIPERIF_I2S_FMT_LR_POL_LOW(player);
> > -		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(player);
> > -		break;
> > -	case SND_SOC_DAIFMT_IB_IF:
> > -		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(player);
> > -		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(player);
> > -		break;
> > -	}
> > -
> > -	switch (player->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > -	case SND_SOC_DAIFMT_I2S:
> > -		SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(player);
> > -		SET_UNIPERIF_I2S_FMT_PADDING_I2S_MODE(player);
> > -		break;
> > -	case SND_SOC_DAIFMT_LEFT_J:
> > -		SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(player);
> > -		SET_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(player);
> > -		break;
> > -	case SND_SOC_DAIFMT_RIGHT_J:
> > -		SET_UNIPERIF_I2S_FMT_ALIGN_RIGHT(player);
> > -		SET_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(player);
> > -		break;
> > -	default:
> > -		dev_err(player->dev, "format not supported\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	SET_UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ(player, 0);
> > -
> > -
> > -	return sti_uniperiph_reset(player);
> > -}
> > -
> > -static int uni_player_start(struct uniperif *player)
> > -{
> > -	int ret;
> > -
> > -	/* The player should be stopped */
> > -	if (player->state !=3D UNIPERIF_STATE_STOPPED) {
> > -		dev_err(player->dev, "%s: invalid player state\n", __func__);
> > -		return -EINVAL;
> > -	}
> > -
> > -	ret =3D clk_prepare_enable(player->clk);
> > -	if (ret) {
> > -		dev_err(player->dev, "%s: Failed to enable clock\n", __func__);
> > -		return ret;
> > -	}
> > -
> > -	/* Clear any pending interrupts */
> > -	SET_UNIPERIF_ITS_BCLR(player, GET_UNIPERIF_ITS(player));
> > -
> > -	/* Set the interrupt mask */
> > -	SET_UNIPERIF_ITM_BSET_DMA_ERROR(player);
> > -	SET_UNIPERIF_ITM_BSET_FIFO_ERROR(player);
> > -
> > -	/* Enable underflow recovery interrupts */
> > -	if (player->underflow_enabled) {
> > -		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_DONE(player);
> > -		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED(player);
> > -	}
> > -
> > -	ret =3D sti_uniperiph_reset(player);
> > -	if (ret < 0) {
> > -		clk_disable_unprepare(player->clk);
> > -		return ret;
> > -	}
> > -
> > -	/*
> > -	 * Does not use IEC61937 features of the uniperipheral hardware.
> > -	 * Instead it performs IEC61937 in software and inserts it directly
> > -	 * into the audio data stream. As such, when encoded mode is selected=
,
> > -	 * linear pcm mode is still used, but with the differences of the
> > -	 * channel status bits set for encoded mode and the validity bits set=
.
> > -	 */
> > -	SET_UNIPERIF_CTRL_OPERATION_PCM_DATA(player);
> > -
> > -	/*
> > -	 * If iec958 formatting is required for hdmi or spdif, then it must b=
e
> > -	 * enabled after the operation mode is set. If set prior to this, it
> > -	 * will not take affect and hang the player.
> > -	 */
> > -	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
> > -		if (UNIPERIF_TYPE_IS_IEC958(player))
> > -			SET_UNIPERIF_CTRL_SPDIF_FMT_ON(player);
> > -
> > -	/* Force channel status update (no update if clk disable) */
> > -	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
> > -		SET_UNIPERIF_CONFIG_CHL_STS_UPDATE(player);
> > -	else
> > -		SET_UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE(player);
> > -
> > -	/* Update state to started */
> > -	player->state =3D UNIPERIF_STATE_STARTED;
> > -
> > -	return 0;
> > -}
> > -
> > -static int uni_player_stop(struct uniperif *player)
> > -{
> > -	int ret;
> > -
> > -	/* The player should not be in stopped state */
> > -	if (player->state =3D=3D UNIPERIF_STATE_STOPPED) {
> > -		dev_err(player->dev, "%s: invalid player state\n", __func__);
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Turn the player off */
> > -	SET_UNIPERIF_CTRL_OPERATION_OFF(player);
> > -
> > -	ret =3D sti_uniperiph_reset(player);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	/* Disable interrupts */
> > -	SET_UNIPERIF_ITM_BCLR(player, GET_UNIPERIF_ITM(player));
> > -
> > -	/* Disable clock */
> > -	clk_disable_unprepare(player->clk);
> > -
> > -	/* Update state to stopped and return */
> > -	player->state =3D UNIPERIF_STATE_STOPPED;
> > -
> > -	return 0;
> > -}
> > -
> > -int uni_player_resume(struct uniperif *player)
> > -{
> > -	int ret;
> > -
> > -	/* Select the frequency synthesizer clock */
> > -	if (player->clk_sel) {
> > -		ret =3D regmap_field_write(player->clk_sel, 1);
> > -		if (ret) {
> > -			dev_err(player->dev,
> > -				"%s: Failed to select freq synth clock\n",
> > -				__func__);
> > -			return ret;
> > -		}
> > -	}
> > -
> > -	SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(player);
> > -	SET_UNIPERIF_CTRL_ROUNDING_OFF(player);
> > -	SET_UNIPERIF_CTRL_SPDIF_LAT_OFF(player);
> > -	SET_UNIPERIF_CONFIG_IDLE_MOD_DISABLE(player);
> > -
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL_GPL(uni_player_resume);
> > -
> > -static int uni_player_trigger(struct snd_pcm_substream *substream,
> > -			      int cmd, struct snd_soc_dai *dai)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *player =3D priv->dai_data.uni;
> > -
> > -	switch (cmd) {
> > -	case SNDRV_PCM_TRIGGER_START:
> > -		return uni_player_start(player);
> > -	case SNDRV_PCM_TRIGGER_STOP:
> > -		return uni_player_stop(player);
> > -	case SNDRV_PCM_TRIGGER_RESUME:
> > -		return uni_player_resume(player);
> > -	default:
> > -		return -EINVAL;
> > -	}
> > -}
> > -
> > -static void uni_player_shutdown(struct snd_pcm_substream *substream,
> > -				struct snd_soc_dai *dai)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *player =3D priv->dai_data.uni;
> > -	unsigned long flags;
> > -
> > -	spin_lock_irqsave(&player->irq_lock, flags);
> > -	if (player->state !=3D UNIPERIF_STATE_STOPPED)
> > -		/* Stop the player */
> > -		uni_player_stop(player);
> > -
> > -	player->substream =3D NULL;
> > -	spin_unlock_irqrestore(&player->irq_lock, flags);
> > -}
> > -
> > -static int uni_player_parse_dt_audio_glue(struct platform_device *pdev=
,
> > -					  struct uniperif *player)
> > -{
> > -	struct device_node *node =3D pdev->dev.of_node;
> > -	struct regmap *regmap;
> > -	struct reg_field regfield[2] =3D {
> > -		/* PCM_CLK_SEL */
> > -		REG_FIELD(SYS_CFG_AUDIO_GLUE,
> > -			  8 + player->id,
> > -			  8 + player->id),
> > -		/* PCMP_VALID_SEL */
> > -		REG_FIELD(SYS_CFG_AUDIO_GLUE, 0, 1)
> > -	};
> > -
> > -	regmap =3D syscon_regmap_lookup_by_phandle(node, "st,syscfg");
> > -
> > -	if (IS_ERR(regmap)) {
> > -		dev_err(&pdev->dev, "sti-audio-clk-glue syscf not found\n");
> > -		return PTR_ERR(regmap);
> > -	}
> > -
> > -	player->clk_sel =3D regmap_field_alloc(regmap, regfield[0]);
> > -	player->valid_sel =3D regmap_field_alloc(regmap, regfield[1]);
> > -
> > -	return 0;
> > -}
> > -
> > -static const struct snd_soc_dai_ops uni_player_dai_ops =3D {
> > -		.startup =3D uni_player_startup,
> > -		.shutdown =3D uni_player_shutdown,
> > -		.prepare =3D uni_player_prepare,
> > -		.trigger =3D uni_player_trigger,
> > -		.hw_params =3D sti_uniperiph_dai_hw_params,
> > -		.set_fmt =3D sti_uniperiph_dai_set_fmt,
> > -		.set_sysclk =3D uni_player_set_sysclk,
> > -		.set_tdm_slot =3D sti_uniperiph_set_tdm_slot
> > -};
> > -
> > -int uni_player_init(struct platform_device *pdev,
> > -		    struct uniperif *player)
> > -{
> > -	int ret =3D 0;
> > -
> > -	player->dev =3D &pdev->dev;
> > -	player->state =3D UNIPERIF_STATE_STOPPED;
> > -	player->dai_ops =3D &uni_player_dai_ops;
> > -
> > -	/* Get PCM_CLK_SEL & PCMP_VALID_SEL from audio-glue-ctrl SoC reg
> */
> > -	ret =3D uni_player_parse_dt_audio_glue(pdev, player);
> > -
> > -	if (ret < 0) {
> > -		dev_err(player->dev, "Failed to parse DeviceTree\n");
> > -		return ret;
> > -	}
> > -
> > -	/* Underflow recovery is only supported on later ip revisions */
> > -	if (player->ver >=3D SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
> > -		player->underflow_enabled =3D 1;
> > -
> > -	if (UNIPERIF_TYPE_IS_TDM(player))
> > -		player->hw =3D &uni_tdm_hw;
> > -	else
> > -		player->hw =3D &uni_player_pcm_hw;
> > -
> > -	/* Get uniperif resource */
> > -	player->clk =3D of_clk_get(pdev->dev.of_node, 0);
> > -	if (IS_ERR(player->clk)) {
> > -		dev_err(player->dev, "Failed to get clock\n");
> > -		return PTR_ERR(player->clk);
> > -	}
> > -
> > -	/* Select the frequency synthesizer clock */
> > -	if (player->clk_sel) {
> > -		ret =3D regmap_field_write(player->clk_sel, 1);
> > -		if (ret) {
> > -			dev_err(player->dev,
> > -				"%s: Failed to select freq synth clock\n",
> > -				__func__);
> > -			return ret;
> > -		}
> > -	}
> > -
> > -	/* connect to I2S/TDM TX bus */
> > -	if (player->valid_sel &&
> > -	    (player->id =3D=3D UNIPERIF_PLAYER_I2S_OUT)) {
> > -		ret =3D regmap_field_write(player->valid_sel, player->id);
> > -		if (ret) {
> > -			dev_err(player->dev,
> > -				"%s: unable to connect to tdm bus\n",
> __func__);
> > -			return ret;
> > -		}
> > -	}
> > -
> > -	ret =3D devm_request_irq(&pdev->dev, player->irq,
> > -			       uni_player_irq_handler, IRQF_SHARED,
> > -			       dev_name(&pdev->dev), player);
> > -	if (ret < 0) {
> > -		dev_err(player->dev, "unable to request IRQ %d\n", player-
> >irq);
> > -		return ret;
> > -	}
> > -
> > -	mutex_init(&player->ctrl_lock);
> > -	spin_lock_init(&player->irq_lock);
> > -
> > -	/* Ensure that disabled by default */
> > -	SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(player);
> > -	SET_UNIPERIF_CTRL_ROUNDING_OFF(player);
> > -	SET_UNIPERIF_CTRL_SPDIF_LAT_OFF(player);
> > -	SET_UNIPERIF_CONFIG_IDLE_MOD_DISABLE(player);
> > -
> > -	if (UNIPERIF_TYPE_IS_IEC958(player)) {
> > -		/* Set default iec958 status bits  */
> > -
> > -		/* Consumer, PCM, copyright, 2ch, mode 0 */
> > -		player->stream_settings.iec958.status[0] =3D 0x00;
> > -		/* Broadcast reception category */
> > -		player->stream_settings.iec958.status[1] =3D
> > -					IEC958_AES1_CON_GENERAL;
> > -		/* Do not take into account source or channel number */
> > -		player->stream_settings.iec958.status[2] =3D
> > -					IEC958_AES2_CON_SOURCE_UNSPEC;
> > -		/* Sampling frequency not indicated */
> > -		player->stream_settings.iec958.status[3] =3D
> > -					IEC958_AES3_CON_FS_NOTID;
> > -		/* Max sample word 24-bit, sample word length not indicated
> */
> > -		player->stream_settings.iec958.status[4] =3D
> > -
> 	IEC958_AES4_CON_MAX_WORDLEN_24 |
> > -					IEC958_AES4_CON_WORDLEN_24_20;
> > -
> > -		player->num_ctrls =3D ARRAY_SIZE(snd_sti_iec_ctl);
> > -		player->snd_ctrls =3D snd_sti_iec_ctl[0];
> > -	} else {
> > -		player->num_ctrls =3D ARRAY_SIZE(snd_sti_pcm_ctl);
> > -		player->snd_ctrls =3D snd_sti_pcm_ctl[0];
> > -	}
> > -
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL_GPL(uni_player_init);
> > diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_r=
eader.c
> > deleted file mode 100644
> > index 136059331211..000000000000
> > --- a/sound/soc/sti/uniperif_reader.c
> > +++ /dev/null
> > @@ -1,436 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > -/*
> > - * Copyright (C) STMicroelectronics SA 2015
> > - * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > - *          for STMicroelectronics.
> > - */
> > -
> > -#include <sound/soc.h>
> > -
> > -#include "uniperif.h"
> > -
> > -#define UNIPERIF_READER_I2S_IN 0 /* reader id connected to I2S/TDM TX
> bus */
> > -/*
> > - * Note: snd_pcm_hardware is linked to DMA controller but is declared =
here
> to
> > - * integrate unireader capability in term of rate and supported channe=
ls
> > - */
> > -static const struct snd_pcm_hardware uni_reader_pcm_hw =3D {
> > -	.info =3D SNDRV_PCM_INFO_INTERLEAVED |
> SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > -		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
> > -		SNDRV_PCM_INFO_MMAP_VALID,
> > -	.formats =3D SNDRV_PCM_FMTBIT_S32_LE |
> SNDRV_PCM_FMTBIT_S16_LE,
> > -
> > -	.rates =3D SNDRV_PCM_RATE_CONTINUOUS,
> > -	.rate_min =3D 8000,
> > -	.rate_max =3D 96000,
> > -
> > -	.channels_min =3D 2,
> > -	.channels_max =3D 8,
> > -
> > -	.periods_min =3D 2,
> > -	.periods_max =3D 48,
> > -
> > -	.period_bytes_min =3D 128,
> > -	.period_bytes_max =3D 64 * PAGE_SIZE,
> > -	.buffer_bytes_max =3D 256 * PAGE_SIZE
> > -};
> > -
> > -/*
> > - * uni_reader_irq_handler
> > - * In case of error audio stream is stopped; stop action is protected =
via PCM
> > - * stream lock  to avoid race condition with trigger callback.
> > - */
> > -static irqreturn_t uni_reader_irq_handler(int irq, void *dev_id)
> > -{
> > -	irqreturn_t ret =3D IRQ_NONE;
> > -	struct uniperif *reader =3D dev_id;
> > -	unsigned int status;
> > -
> > -	spin_lock(&reader->irq_lock);
> > -	if (!reader->substream)
> > -		goto irq_spin_unlock;
> > -
> > -	snd_pcm_stream_lock(reader->substream);
> > -	if (reader->state =3D=3D UNIPERIF_STATE_STOPPED) {
> > -		/* Unexpected IRQ: do nothing */
> > -		dev_warn(reader->dev, "unexpected IRQ\n");
> > -		goto stream_unlock;
> > -	}
> > -
> > -	/* Get interrupt status & clear them immediately */
> > -	status =3D GET_UNIPERIF_ITS(reader);
> > -	SET_UNIPERIF_ITS_BCLR(reader, status);
> > -
> > -	/* Check for fifo overflow error */
> > -	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(reader))) {
> > -		dev_err(reader->dev, "FIFO error detected\n");
> > -
> > -		snd_pcm_stop_xrun(reader->substream);
> > -
> > -		ret =3D IRQ_HANDLED;
> > -	}
> > -
> > -stream_unlock:
> > -	snd_pcm_stream_unlock(reader->substream);
> > -irq_spin_unlock:
> > -	spin_unlock(&reader->irq_lock);
> > -
> > -	return ret;
> > -}
> > -
> > -static int uni_reader_prepare_pcm(struct snd_pcm_runtime *runtime,
> > -				  struct uniperif *reader)
> > -{
> > -	int slot_width;
> > -
> > -	/* Force slot width to 32 in I2S mode */
> > -	if ((reader->daifmt & SND_SOC_DAIFMT_FORMAT_MASK)
> > -		=3D=3D SND_SOC_DAIFMT_I2S) {
> > -		slot_width =3D 32;
> > -	} else {
> > -		switch (runtime->format) {
> > -		case SNDRV_PCM_FORMAT_S16_LE:
> > -			slot_width =3D 16;
> > -			break;
> > -		default:
> > -			slot_width =3D 32;
> > -			break;
> > -		}
> > -	}
> > -
> > -	/* Number of bits per subframe (i.e one channel sample) on input. */
> > -	switch (slot_width) {
> > -	case 32:
> > -		SET_UNIPERIF_I2S_FMT_NBIT_32(reader);
> > -		SET_UNIPERIF_I2S_FMT_DATA_SIZE_32(reader);
> > -		break;
> > -	case 16:
> > -		SET_UNIPERIF_I2S_FMT_NBIT_16(reader);
> > -		SET_UNIPERIF_I2S_FMT_DATA_SIZE_16(reader);
> > -		break;
> > -	default:
> > -		dev_err(reader->dev, "subframe format not supported\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Configure data memory format */
> > -	switch (runtime->format) {
> > -	case SNDRV_PCM_FORMAT_S16_LE:
> > -		/* One data word contains two samples */
> > -		SET_UNIPERIF_CONFIG_MEM_FMT_16_16(reader);
> > -		break;
> > -
> > -	case SNDRV_PCM_FORMAT_S32_LE:
> > -		/*
> > -		 * Actually "16 bits/0 bits" means "32/28/24/20/18/16 bits
> > -		 * on the MSB then zeros (if less than 32 bytes)"...
> > -		 */
> > -		SET_UNIPERIF_CONFIG_MEM_FMT_16_0(reader);
> > -		break;
> > -
> > -	default:
> > -		dev_err(reader->dev, "format not supported\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Number of channels must be even */
> > -	if ((runtime->channels % 2) || (runtime->channels < 2) ||
> > -	    (runtime->channels > 10)) {
> > -		dev_err(reader->dev, "%s: invalid nb of channels\n", __func__);
> > -		return -EINVAL;
> > -	}
> > -
> > -	SET_UNIPERIF_I2S_FMT_NUM_CH(reader, runtime->channels / 2);
> > -	SET_UNIPERIF_I2S_FMT_ORDER_MSB(reader);
> > -
> > -	return 0;
> > -}
> > -
> > -static int uni_reader_prepare_tdm(struct snd_pcm_runtime *runtime,
> > -				  struct uniperif *reader)
> > -{
> > -	int frame_size; /* user tdm frame size in bytes */
> > -	/* default unip TDM_WORD_POS_X_Y */
> > -	unsigned int word_pos[4] =3D {
> > -		0x04060002, 0x0C0E080A, 0x14161012, 0x1C1E181A};
> > -
> > -	frame_size =3D sti_uniperiph_get_user_frame_size(runtime);
> > -
> > -	/* fix 16/0 format */
> > -	SET_UNIPERIF_CONFIG_MEM_FMT_16_0(reader);
> > -	SET_UNIPERIF_I2S_FMT_DATA_SIZE_32(reader);
> > -
> > -	/* number of words inserted on the TDM line */
> > -	SET_UNIPERIF_I2S_FMT_NUM_CH(reader, frame_size / 4 / 2);
> > -
> > -	SET_UNIPERIF_I2S_FMT_ORDER_MSB(reader);
> > -	SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(reader);
> > -	SET_UNIPERIF_TDM_ENABLE_TDM_ENABLE(reader);
> > -
> > -	/*
> > -	 * set the timeslots allocation for words in FIFO
> > -	 *
> > -	 * HW bug: (LSB word < MSB word) =3D> this config is not possible
> > -	 *         So if we want (LSB word < MSB) word, then it shall be
> > -	 *         handled by user
> > -	 */
> > -	sti_uniperiph_get_tdm_word_pos(reader, word_pos);
> > -	SET_UNIPERIF_TDM_WORD_POS(reader, 1_2, word_pos[WORD_1_2]);
> > -	SET_UNIPERIF_TDM_WORD_POS(reader, 3_4, word_pos[WORD_3_4]);
> > -	SET_UNIPERIF_TDM_WORD_POS(reader, 5_6, word_pos[WORD_5_6]);
> > -	SET_UNIPERIF_TDM_WORD_POS(reader, 7_8, word_pos[WORD_7_8]);
> > -
> > -	return 0;
> > -}
> > -
> > -static int uni_reader_prepare(struct snd_pcm_substream *substream,
> > -			      struct snd_soc_dai *dai)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *reader =3D priv->dai_data.uni;
> > -	struct snd_pcm_runtime *runtime =3D substream->runtime;
> > -	int transfer_size, trigger_limit, ret;
> > -
> > -	/* The reader should be stopped */
> > -	if (reader->state !=3D UNIPERIF_STATE_STOPPED) {
> > -		dev_err(reader->dev, "%s: invalid reader state %d\n",
> __func__,
> > -			reader->state);
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Calculate transfer size (in fifo cells and bytes) for frame count =
*/
> > -	if (reader->type =3D=3D SND_ST_UNIPERIF_TYPE_TDM) {
> > -		/* transfer size =3D unip frame size (in 32 bits FIFO cell) */
> > -		transfer_size =3D
> > -			sti_uniperiph_get_user_frame_size(runtime) / 4;
> > -	} else {
> > -		transfer_size =3D runtime->channels * UNIPERIF_FIFO_FRAMES;
> > -	}
> > -
> > -	/* Calculate number of empty cells available before asserting DREQ */
> > -	if (reader->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
> > -		trigger_limit =3D UNIPERIF_FIFO_SIZE - transfer_size;
> > -	else
> > -		/*
> > -		 * Since SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0
> > -		 * FDMA_TRIGGER_LIMIT also controls when the state switches
> > -		 * from OFF or STANDBY to AUDIO DATA.
> > -		 */
> > -		trigger_limit =3D transfer_size;
> > -
> > -	/* Trigger limit must be an even number */
> > -	if ((!trigger_limit % 2) ||
> > -	    (trigger_limit !=3D 1 && transfer_size % 2) ||
> > -	    (trigger_limit >
> UNIPERIF_CONFIG_DMA_TRIG_LIMIT_MASK(reader))) {
> > -		dev_err(reader->dev, "invalid trigger limit %d\n",
> > -			trigger_limit);
> > -		return -EINVAL;
> > -	}
> > -
> > -	SET_UNIPERIF_CONFIG_DMA_TRIG_LIMIT(reader, trigger_limit);
> > -
> > -	if (UNIPERIF_TYPE_IS_TDM(reader))
> > -		ret =3D uni_reader_prepare_tdm(runtime, reader);
> > -	else
> > -		ret =3D uni_reader_prepare_pcm(runtime, reader);
> > -	if (ret)
> > -		return ret;
> > -
> > -	switch (reader->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > -	case SND_SOC_DAIFMT_I2S:
> > -		SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(reader);
> > -		SET_UNIPERIF_I2S_FMT_PADDING_I2S_MODE(reader);
> > -		break;
> > -	case SND_SOC_DAIFMT_LEFT_J:
> > -		SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(reader);
> > -		SET_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(reader);
> > -		break;
> > -	case SND_SOC_DAIFMT_RIGHT_J:
> > -		SET_UNIPERIF_I2S_FMT_ALIGN_RIGHT(reader);
> > -		SET_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(reader);
> > -		break;
> > -	default:
> > -		dev_err(reader->dev, "format not supported\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Data clocking (changing) on the rising/falling edge */
> > -	switch (reader->daifmt & SND_SOC_DAIFMT_INV_MASK) {
> > -	case SND_SOC_DAIFMT_NB_NF:
> > -		SET_UNIPERIF_I2S_FMT_LR_POL_LOW(reader);
> > -		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_RISING(reader);
> > -		break;
> > -	case SND_SOC_DAIFMT_NB_IF:
> > -		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(reader);
> > -		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_RISING(reader);
> > -		break;
> > -	case SND_SOC_DAIFMT_IB_NF:
> > -		SET_UNIPERIF_I2S_FMT_LR_POL_LOW(reader);
> > -		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(reader);
> > -		break;
> > -	case SND_SOC_DAIFMT_IB_IF:
> > -		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(reader);
> > -		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(reader);
> > -		break;
> > -	}
> > -
> > -	/* Clear any pending interrupts */
> > -	SET_UNIPERIF_ITS_BCLR(reader, GET_UNIPERIF_ITS(reader));
> > -
> > -	SET_UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ(reader, 0);
> > -
> > -	/* Set the interrupt mask */
> > -	SET_UNIPERIF_ITM_BSET_DMA_ERROR(reader);
> > -	SET_UNIPERIF_ITM_BSET_FIFO_ERROR(reader);
> > -	SET_UNIPERIF_ITM_BSET_MEM_BLK_READ(reader);
> > -
> > -	/* Enable underflow recovery interrupts */
> > -	if (reader->underflow_enabled) {
> > -		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_DONE(reader);
> > -		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED(reader);
> > -	}
> > -
> > -	/* Reset uniperipheral reader */
> > -	return sti_uniperiph_reset(reader);
> > -}
> > -
> > -static int uni_reader_start(struct uniperif *reader)
> > -{
> > -	/* The reader should be stopped */
> > -	if (reader->state !=3D UNIPERIF_STATE_STOPPED) {
> > -		dev_err(reader->dev, "%s: invalid reader state\n", __func__);
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Enable reader interrupts (and clear possible stalled ones) */
> > -	SET_UNIPERIF_ITS_BCLR_FIFO_ERROR(reader);
> > -	SET_UNIPERIF_ITM_BSET_FIFO_ERROR(reader);
> > -
> > -	/* Launch the reader */
> > -	SET_UNIPERIF_CTRL_OPERATION_PCM_DATA(reader);
> > -
> > -	/* Update state to started */
> > -	reader->state =3D UNIPERIF_STATE_STARTED;
> > -	return 0;
> > -}
> > -
> > -static int uni_reader_stop(struct uniperif *reader)
> > -{
> > -	/* The reader should not be in stopped state */
> > -	if (reader->state =3D=3D UNIPERIF_STATE_STOPPED) {
> > -		dev_err(reader->dev, "%s: invalid reader state\n", __func__);
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Turn the reader off */
> > -	SET_UNIPERIF_CTRL_OPERATION_OFF(reader);
> > -
> > -	/* Disable interrupts */
> > -	SET_UNIPERIF_ITM_BCLR(reader, GET_UNIPERIF_ITM(reader));
> > -
> > -	/* Update state to stopped and return */
> > -	reader->state =3D UNIPERIF_STATE_STOPPED;
> > -
> > -	return 0;
> > -}
> > -
> > -static int  uni_reader_trigger(struct snd_pcm_substream *substream,
> > -			       int cmd, struct snd_soc_dai *dai)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *reader =3D priv->dai_data.uni;
> > -
> > -	switch (cmd) {
> > -	case SNDRV_PCM_TRIGGER_START:
> > -		return  uni_reader_start(reader);
> > -	case SNDRV_PCM_TRIGGER_STOP:
> > -		return  uni_reader_stop(reader);
> > -	default:
> > -		return -EINVAL;
> > -	}
> > -}
> > -
> > -static int uni_reader_startup(struct snd_pcm_substream *substream,
> > -			      struct snd_soc_dai *dai)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *reader =3D priv->dai_data.uni;
> > -	unsigned long flags;
> > -	int ret;
> > -
> > -	spin_lock_irqsave(&reader->irq_lock, flags);
> > -	reader->substream =3D substream;
> > -	spin_unlock_irqrestore(&reader->irq_lock, flags);
> > -
> > -	if (!UNIPERIF_TYPE_IS_TDM(reader))
> > -		return 0;
> > -
> > -	/* refine hw constraint in tdm mode */
> > -	ret =3D snd_pcm_hw_rule_add(substream->runtime, 0,
> > -				  SNDRV_PCM_HW_PARAM_CHANNELS,
> > -				  sti_uniperiph_fix_tdm_chan,
> > -				  reader,
> SNDRV_PCM_HW_PARAM_CHANNELS,
> > -				  -1);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	return snd_pcm_hw_rule_add(substream->runtime, 0,
> > -				   SNDRV_PCM_HW_PARAM_FORMAT,
> > -				   sti_uniperiph_fix_tdm_format,
> > -				   reader, SNDRV_PCM_HW_PARAM_FORMAT,
> > -				   -1);
> > -}
> > -
> > -static void uni_reader_shutdown(struct snd_pcm_substream *substream,
> > -				struct snd_soc_dai *dai)
> > -{
> > -	struct sti_uniperiph_data *priv =3D snd_soc_dai_get_drvdata(dai);
> > -	struct uniperif *reader =3D priv->dai_data.uni;
> > -	unsigned long flags;
> > -
> > -	spin_lock_irqsave(&reader->irq_lock, flags);
> > -	if (reader->state !=3D UNIPERIF_STATE_STOPPED) {
> > -		/* Stop the reader */
> > -		uni_reader_stop(reader);
> > -	}
> > -	reader->substream =3D NULL;
> > -	spin_unlock_irqrestore(&reader->irq_lock, flags);
> > -}
> > -
> > -static const struct snd_soc_dai_ops uni_reader_dai_ops =3D {
> > -		.startup =3D uni_reader_startup,
> > -		.shutdown =3D uni_reader_shutdown,
> > -		.prepare =3D uni_reader_prepare,
> > -		.trigger =3D uni_reader_trigger,
> > -		.hw_params =3D sti_uniperiph_dai_hw_params,
> > -		.set_fmt =3D sti_uniperiph_dai_set_fmt,
> > -		.set_tdm_slot =3D sti_uniperiph_set_tdm_slot
> > -};
> > -
> > -int uni_reader_init(struct platform_device *pdev,
> > -		    struct uniperif *reader)
> > -{
> > -	int ret =3D 0;
> > -
> > -	reader->dev =3D &pdev->dev;
> > -	reader->state =3D UNIPERIF_STATE_STOPPED;
> > -	reader->dai_ops =3D &uni_reader_dai_ops;
> > -
> > -	if (UNIPERIF_TYPE_IS_TDM(reader))
> > -		reader->hw =3D &uni_tdm_hw;
> > -	else
> > -		reader->hw =3D &uni_reader_pcm_hw;
> > -
> > -	ret =3D devm_request_irq(&pdev->dev, reader->irq,
> > -			       uni_reader_irq_handler, IRQF_SHARED,
> > -			       dev_name(&pdev->dev), reader);
> > -	if (ret < 0) {
> > -		dev_err(&pdev->dev, "Failed to request IRQ\n");
> > -		return -EBUSY;
> > -	}
> > -
> > -	spin_lock_init(&reader->irq_lock);
> > -
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL_GPL(uni_reader_init);
> > --
> > 2.35.1
> >
> >
