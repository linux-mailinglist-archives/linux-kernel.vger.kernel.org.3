Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7957B4D9EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349614AbiCOP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349612AbiCOP3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:29:10 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643BB7D9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:27:54 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FAFXp0013528;
        Tue, 15 Mar 2022 16:27:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=/pwdAFjyPm5Qz/CsV8kNkhYQhKUDQ19EC0OLBgPXrcY=;
 b=eVycb7+boCGMGWq3fTIg7PG8kw/9lodFpmr/vb48ev0fJgGfHEGRNezEJfsOGgw7S/7v
 S4vxln+DFKtjoQEsYU/nT34ojg8qqo64+Loq0KcJV0E+eO4+rxqlKO8D3LksgCWAhRqI
 C+AijHFVGJBqGhsyR2xwh3A9TNVqmqBjG8Fx8v1jKQYVBJEbbDWh2Nw+lyZL0j83s5Xk
 MoMcL0ktyk0EgoRjSRGaR7CvPufB5FLEYn2KIvkuuV0UAImci0/QSanOi7nmwal6KuYr
 Oon4tIcXKZGLPN9ExL7t8ZqsGuw0TVZqUcdQGKx8iV2sy3KDjkvuGizQZWG/DtCFA9np 8g== 
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2052.outbound.protection.outlook.com [104.47.1.52])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3et63h7drm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 16:27:42 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvP86pwZ9VMq8Tm3zrnFuzFD4ks9U8DDQSwQENge4KnkUNqodJjiJZidvPa71M+peiwjGvjybYFsKQ32A0iK/bMj6UI4FD6We8aSH1QOUmvSRJuze/waXN4qcZielufNlGYBeKQz6dhZSQPrsU2WsmUV/ITKRJCSk1hwcOdgkSKQ2QZsaDCGURVsTbDnqwmBjT7Ck9POjjq4e8dGL1HgO9O+ZhHl0/zsROlEZmp4N0Wa0sQVtRF9Rmb1WnoHh/axJQhoJHcJjB9toFnLzON8lq8ScHj1Y89rUl5TjbZGizlVXVAJ/SuCg+mSbPZpZse1S2flRaarqkJVM4XmCua/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pwdAFjyPm5Qz/CsV8kNkhYQhKUDQ19EC0OLBgPXrcY=;
 b=e+HTtE36ZpiNK9O5xzKd6m15O7/jS8s2LLhA3VVKIm/2fQaHEmbn9YW7F8z4kZeb14ShktYmyq7EaMsJNe0dtgPQ6RIACHaZveguZ9lcPiTLoKfwWvpdoN3F8ZiNgKl9U1EUgyKAD8akZDnSdpLrI7uqBVeLIEVx29e0JnJRL3by+R+ocf/0ixBX/ydq1eaM0jWMID2nSn3NjMQpT4eF9ay4afMP8jW/nLH6lf6HRdXQvonHbpI671B/zLjxVRMh4hPE7sKJuAcBkow6HqucRNxuu+0t2MFAqmHNhj8pwtUqa+ydX7Qbo4vwllvxrrmTp9iUQzP7ONdaxoqJ1llOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:158::12)
 by AM6PR10MB2341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 15:27:40 +0000
Received: from PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d0:cd92:31e:43a0]) by PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d0:cd92:31e:43a0%8]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 15:27:40 +0000
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Daniel Palmer <daniel@0x0f.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: sti: sti_uniperif: Remove driver
Thread-Topic: [PATCH] ASoC: sti: sti_uniperif: Remove driver
Thread-Index: AQHYOEz3Qrd7t7b+7keIJTzYLpkdlazAPfOAgAAFRzCAAD/HAIAAA+8A
Date:   Tue, 15 Mar 2022 15:27:40 +0000
Message-ID: <PAXPR10MB4718531B374721399E9C5D08F1109@PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM>
References: <20220315091319.3351522-1-daniel@0x0f.com>
        <s5h8rtba4to.wl-tiwai@suse.de>
        <PAXPR10MB47185B76D5F38482FB1125A5F1109@PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM>
 <s5hee338etb.wl-tiwai@suse.de>
In-Reply-To: <s5hee338etb.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2022-03-15T14:48:45Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=3d16913d-7ad0-477a-9521-84df019b7ef1;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=2
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_enabled: true
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_setdate: 2022-03-15T15:27:37Z
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_method: Standard
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_name: 23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_siteid: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_actionid: 267f6999-47d5-44fe-948d-7468e02e4b4c
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_contentbits: 0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37d626cd-a03c-4984-c97c-08da069857bd
x-ms-traffictypediagnostic: AM6PR10MB2341:EE_
x-microsoft-antispam-prvs: <AM6PR10MB23412B39AD2F3E0031B1BBF2F1109@AM6PR10MB2341.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FkdhruWeKnI7j2fdZEEwRH8H8xqZhdjHxzNxzzyuscVY1jdrmuvgNfNRIuvpcX0bn6ZMh8o9/k9f7+tn08M4Rqe34sVBf1anpTuYtlB7HBvnWrhuqo3j4eoqmV5eXzhTvWR8YBy7LIvi9qe19/OxCcNPaIxbbarUlwbxz3u0QP6tOjFcUQrAKJZQ9aY9ybafDzUldkYml6GyqgeIkMC0xIKTm9B7E6cOSSHS7BM8aLUmE6j+usoOVIASOHY/YjMxsqX2e55kex8WftI4Lqdg8zQ/9lKonzV+ICmAc9/DSnQM7Cujlo5Dq0uBbfg868U066I0pPxaTCU0+onPGklKGiLhPYmC2kwfApnOr8RyjDHqZnseH8I7sftFOru1Vk+ul9+rZ1pM0W1PeUX+m2SH2cD6/90+HbB+Qj/NEJLquYdDVoFUUD0LMCr49KHSZvaEJthcp3ryDnmgqGiqRs4VyZlam2p+DNaSPh8fUX9Dki/omy7xaI2hFzJzpiPx9awSmLHKYqtaDwxR2Dp+2cpwolq8irOqnJIxusGUFnjkPmwOHNnwrJ5opn8IOg7V3wLpFHhfhNrZv+E4tl7vXLPkVjyF0IGoDNa07FdA8DHyRDpJz+TPDnDEFfgC6af1ypkbOK74XgyPM8xMaEnADOKFQOzFj7fLrUDED+e+wqsRMJzBOTxv2H8dNqAs4YQ03lG91EMD9u87NV0WTeSfGz+zQ5eGdTBaWLCiJ3bGtxcvZjui5aHspKAifFXLTR3N8GW14zaiaebPbcJFPQRKtXyTkTXJYf2YXCHFIvyJrMJLfhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(26005)(9686003)(76116006)(33656002)(86362001)(83380400001)(66946007)(186003)(66446008)(66556008)(66476007)(64756008)(6916009)(54906003)(508600001)(966005)(38100700002)(55016003)(122000001)(71200400001)(2906002)(7696005)(6506007)(53546011)(8676002)(8936002)(52536014)(38070700005)(5660300002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?joNiS7JWHTmC8cbhXHZqOpqzrIjWO+x/XmLGBbAE3KmWm85OgKqWDGerWiFK?=
 =?us-ascii?Q?Nf9APDawvFN0KpM0lxq1Mtes1s7ZMklIAF93FOUt/LE6FE7/k+fD8wpUyQmP?=
 =?us-ascii?Q?yJPjB5amp61azKgpzGpqXesG8KaxwRcvSb+3G5ELzjjKRpy9i6CxpBeiYBGf?=
 =?us-ascii?Q?t0mu2RHBkrsCSR+3LJSG1dWbYzHQRepNIoYjoU7HBOtm5mSikXipOggFIk0z?=
 =?us-ascii?Q?JzQ34f93qtgDNlUsWliyA6o5UDA8xlLwTo9yZtuRlxLinaQCFkeUkdaayM0l?=
 =?us-ascii?Q?+rH2mCBYsRBPWLlEhFiy2RS3ZZ5AnA54+uFhKWqncuh/aM9aoeB7pmp3Uio1?=
 =?us-ascii?Q?xPrkYzy/pMqsXgbxwRBROIvL8TbUONajkiwFOuI61RF0EK9BYhcpL77HOwLR?=
 =?us-ascii?Q?7yt/JCQQZh7u3nTzG8ZLX+PeQ4Y0hxs1lO885GHJALbsqMEX2OMWljvB7bKe?=
 =?us-ascii?Q?1lwNaQiBH/nqVKdE/kcAHvYxodeVXMYkzbKYYDe1hk5BpCLrNTMnXJdSkWxE?=
 =?us-ascii?Q?nL42SCwg7Jlbz1J23UdsjbPXtbJ8cSEvtSyFBm0vLlCdcOI/owWxBJH2MoMP?=
 =?us-ascii?Q?GaP+yPPCArGT2XMSwhLxCB2Zi5Dj3a6LSVwLo59zD6u7Wz5EN/BKcx9RbpdE?=
 =?us-ascii?Q?n+OAiToD22wDZ1TlfsB12AyEq21QZYikXAAIND02RTuSDIxP6n5DtoxoT9FT?=
 =?us-ascii?Q?bwjUOukWDT+4R+tV+Pw3NNFZ0KATKmX88hppzmzSsBa1VsbLHpfakFSYUjUu?=
 =?us-ascii?Q?5KR6clWjfgPjo7e77WDWUcOzc4JVMXkXGIVWLGuFm4Fm1+AQy93CRUysidLy?=
 =?us-ascii?Q?praDiXm1Z670x7k5fvqGrfToS7Wc/n+pOeEvc6+DJiN9uklkd/ZPZmCM0ieE?=
 =?us-ascii?Q?mFHLs8LZvHCybUzVlcpEKX2qTM1ZKagev1WfNvZk4TsnB/V915NQ9MGRPFax?=
 =?us-ascii?Q?s7kEEu4kSz9tt85938nKvn6tPXqyXsPxsZjla58DQ8uMA5ACBi7DHX4vJ1t7?=
 =?us-ascii?Q?G22XnG2kMhIhkqt57KMSW4PIXsg4SfsFC1FT3JTP0UIzMADcMsiiM4GdclQa?=
 =?us-ascii?Q?7bHByLvb8J1iBaL10NFNpSB7VzeNZ99aN8KVCaaPlkzJ8kYTMhuAuiC464IA?=
 =?us-ascii?Q?5d7ngjZbzNtBLttu2B4575M64sf5lNgWjXS2mrBUAa2MwimHzg2fTWPPJ/Kw?=
 =?us-ascii?Q?zuzwnHW4GEVFUIyDUvfK4gM/3WsyGDRJCBlf+VI0uljL0aLqqgh3Du++s5KO?=
 =?us-ascii?Q?UMUlY6f4Jc8nLaG1828meVEpox8Irpzn+PvrYwLhIUFxni5PFks15ehUa6sE?=
 =?us-ascii?Q?CV+YEiZowGGg/z7JRYpCiKJ8m8DPfoOJu0DkJ37nYpn61rCiKFU789p0lqWt?=
 =?us-ascii?Q?oX90ykT8fVZHGQl8Yqi1q5kNA4aXSE88Hy1aNMc1reDwpZCQl+DHlOOu7yXF?=
 =?us-ascii?Q?BtW5t5WkDLo5BSN6PfLNDd7wFp5XMBrD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d626cd-a03c-4984-c97c-08da069857bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 15:27:40.2572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVfkyRhA+W0CjA4pjzZCFdef+xCzZ+GJCLhWOrvRNbGFvHsy5hDCTXIvEbJ7Nwbjyt5g6M+FoZFKVSnkVVJ6ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2341
X-Proofpoint-ORIG-GUID: Zgs1-fj6sa3JCK98BQ7mimZw9xI2p4L3
X-Proofpoint-GUID: Zgs1-fj6sa3JCK98BQ7mimZw9xI2p4L3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=614 suspectscore=0
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




ST Restricted

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: mardi 15 mars 2022 15:35
> To: Arnaud POULIQUEN <arnaud.pouliquen@st.com>
> Cc: Daniel Palmer <daniel@0x0f.com>; broonie@kernel.org; tiwai@suse.com;
> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ASoC: sti: sti_uniperif: Remove driver
>=20
> On Tue, 15 Mar 2022 14:15:20 +0100,
> Arnaud POULIQUEN wrote:
> >
> > Hello,
> >
> >
> > ST Restricted
> >
> > > -----Original Message-----
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Sent: mardi 15 mars 2022 11:28
> > > To: Daniel Palmer <daniel@0x0f.com>
> > > Cc: broonie@kernel.org; tiwai@suse.com; Arnaud POULIQUEN
> > > <arnaud.pouliquen@st.com>; alsa-devel@alsa-project.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH] ASoC: sti: sti_uniperif: Remove driver
> > >
> > > On Tue, 15 Mar 2022 10:13:19 +0100,
> > > Daniel Palmer wrote:
> > > >
> > > > This driver seems to be in the "only good for attracting bot
> > > > generated patches" phase of it's life.
> > > >
> > > > It doesn't seem like anyone actually tested the patches that have
> > > > been applied in the last few years as uni_reader_irq_handler() had
> > > > a dead lock added to it (it locks the stream, then calls
> > > > snd_pcm_stop_xrun() which will also lock the stream).
> > >
> > > Mea culpa, that was an obvious deadlock I overlooked in the patch
> > > series.
> > >
> > > > Seems best just to remove it.
> > > >
> > > > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > > > ---
> > > >  I've never used this driver, don't have the hardware etc.
> > > >  I just noticed that this looks broken when debugging my  own
> > > > driver that uses snd_pcm_stop_xrun() and was looking  at other
> > > > users to see if I was using it wrong and noticed  this was the
> > > > only place that locked the stream before  calling
> > > > snd_pcm_stop_xrun().
> > > >
> > > >  There are probably some other bits of the driver that  should be
> > > > removed but I didn't look that hard.
> > > >
> > > >  TL;DR; This driver seems broken, seems like nobody uses  it.
> > > > Maybe it should be deleted?
> > >
> > > Yeah, that looks dead.
> > >
> >
> > The platform is still used for instance:
> > https://lore.kernel.org/all/1d95209f-9cb4-47a3-2696-7a93df7cdc05@foss.
> > st.com/
> >
> > So please do not remove the driver
>=20
> Ah, it's always good to see a vital sign!
>=20
> > The issue has not been detected because it is related to an error that
> > occurs only when we reach the limit of the platform, with application
> > that stop the stream at same time.
> > So almost no chance to occur.
> >
> > > OTOH, if anyone really wants to keep the stuff, please revert the
> > > commit dc865fb9e7c2251c9585ff6a7bf185d499db13e4.
> >
> > Yes reverting the commit is one solution.
> > The other is to clean-up the snd_pcm_stream_lock/
> > snd_pcm_stream_unlock in the Handler.
>=20
> That would work, but maybe it's safer to keep that lock, as the state cha=
nge
> isn't protected by irq_lock but only implicitly by stream lock in start/s=
top
> callbacks.
=20
You are right, trying to use the snd_pcm_stop_xrun needs deeper update
that could introduce regression.=20
It seems wiser to revert your commit  dc865fb9e7c2 as you propose.

Thanks,
Arnaud

>=20
>=20
> thanks,
>=20
> Takashi
