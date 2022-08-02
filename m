Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31337587E6A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiHBOxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHBOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:53:20 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2105.outbound.protection.outlook.com [40.107.11.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F131EED3;
        Tue,  2 Aug 2022 07:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gw7I/8RL1DlIYn3uDHEJ1JvuDm5Jtqv0iWRzvQH/x9TuGoq2NUGvxLV2Wg0G4NLsCxm1s2gv+4stg/M79Y45n+t/zu3BhJR5RfSBmHy/+IRFfnY5nVpPAoJpynpVr1xSe4Yb3rX4Wr33oPAEnCX2cSW8fVMQUc6Akq4LnZf3Fx4n9IS6ygPh1hJTmt+o+rdhllReD9V2mS8xoUbJM1OwWafMDyWvcDQZikGvIP1MCafLVBRM3SUidE2FfUmNfUPWcCFw5YSjYHk7iBBQahHC9RhwajutcCdh+ycgJOaBT6QgP1hnxhlU6iH1bJROKDOMAdYsi92SbK01szwd/ymr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69wqrm4l9x0jl5BW2ZMMmQf7K2cdaHpYlq4EJSEojWI=;
 b=X6g8xDBkRR+20MhnzErEkpQr7bdtYyx3jtqZP8zH0VJN8zb+J6B8yTbBCdrFPPVSrfweORU46EfVOce3SVXRt6rDFKRUmwgzjmY10pdU7iI5R1CsP5zxo4TuwoSJx7+gCOta9Be6P/+QoBTKhl7+q3S0sXQnsNQChivULQXXNFVKWNTgdaUSxmfj7Et/p/GXwW1XhYJL2UWgbodbdxLmhtsv0DZITYMGTz7p/cW7dJRjpHYssA4WkhhlfIbwnhWJdBFcT5sHKF4XUDu5brSeh1kHYU7CgH34zwV+uKXxEsAYE/0+eeIlZ6sGZxUIFHKo46znebHcXHNrSRI89xC3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69wqrm4l9x0jl5BW2ZMMmQf7K2cdaHpYlq4EJSEojWI=;
 b=iUu1mIYY2xpxCOvKNfxslHToPm/9hx9/njIYHO8JbG4tMaJsHCVf5WWM/K27RtM7zuboeFO85o0/kzCCCgQjWuIa2H2FLatnbtZPBv1xmcpSOxfRAeXVu8oTZJIHkLWbvaj/pdu3Rjd8cdgah/ZBtI9pnZ/awJcGl2w/xF1zrcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6318.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 2 Aug
 2022 14:53:17 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d82f:88a2:e7df:453a]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d82f:88a2:e7df:453a%6]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 14:53:16 +0000
Date:   Tue, 2 Aug 2022 15:53:14 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v8 29/31] MAINTAINERS: Rust
Message-ID: <20220802155314.0000380e@garyguo.net>
In-Reply-To: <YuiLM6ca8Ih0WiS3@boqun-archlinux>
References: <20220802015052.10452-1-ojeda@kernel.org>
        <20220802015052.10452-30-ojeda@kernel.org>
        <YuiLM6ca8Ih0WiS3@boqun-archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2135ab6-2f4f-4529-9f7c-08da7496bb94
X-MS-TrafficTypeDiagnostic: LO0P265MB6318:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHtKKtk7p6i/yxjJ8MKnM5ccKY/iLZSFGR1AoHIzF5fz9m7qRrtdexfowJS2nzwSHS5Zy3oj53wGsvRFDFkfPm65iJ/Anwr+9D1aZtBoXodmDegOrHfX4YHJF4cLFWlahg7niZA81MB3jqvKzK30U8wB2rkDwe/U/Hr90kSIcuy4PA8UM1wrw8T52v0pEhsod7jqEQBTJnzM6ozJwPe2vV+F36d2k0ogRUW0ythcWhH0bWV+Qo2L3V5g2QeJkGkfM78qqXejOlY5A9zzZ0dWVNWS5Zb22BifyytSpCaCDJK/HDy/3MuJuvOZ7pEhSvvxbAYUTlu4vR6W3SynnlQQGbzUmRWU+EYJWwqNn80iQidXtx1IdMYiKbsfHvE3qPaLGJd6mu/RhVMLFFAnZcKTQeCV7eEisKPvx+Lc/HenLpF8MdJjku1gVKpHBGxBNCY4QGyi7hvZC4TTV3KYhUG+cY+iijUnM7NMJDXG1P5LW8vad+dOGO+jb5B4djylG1yov4VpOY5qg+36AcyePTLHmClQBc+AL+O5XFRDz8M4kR17UBYILnVSasKd7/lNtY6ZAaNHJy2NRXfXBTKHZaqkMAVTuOjlpci+GXgjuUmk4BhaapygQqst1mc0j/I3R9hwVtCgE98q8x5EjBwLWnswC6Fy0XUVklk93qkXiAwucxYCqxcjWHyIghoDfnGpMHppcbL7+kxQDu7mrSPZUGzeC9w1eRMLqcmT0vY8KN26mrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39830400003)(346002)(376002)(366004)(6916009)(83380400001)(66946007)(6506007)(4326008)(5660300002)(52116002)(8676002)(38100700002)(66556008)(2906002)(54906003)(6512007)(316002)(6486002)(186003)(66574015)(7416002)(66476007)(478600001)(86362001)(2616005)(36756003)(41300700001)(1076003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WQcAZ6Eg24DLtperO334ONwGHtpsCWMvgsUCxcFi6JsIYDSuwHhrF7iMgW?=
 =?iso-8859-1?Q?b8GfqfdQwsNUCgWa3Zo6tUds5b8Efzy0HXjRPMldaU5ChaCuGEaUbnnniA?=
 =?iso-8859-1?Q?LiwvA+UXGfcD1IXu0i+/r4Zt8a6pjA0sELTv2FpowAHRvv2oYZO6dvFxin?=
 =?iso-8859-1?Q?fBk7gYIX4skezI566DcLnXnbc047ZZ0sUnNyty2FgF24/GC6OPxKdhQJue?=
 =?iso-8859-1?Q?VFHCvHoYKzKLstb3n9N17M3nxS+7rgMRSyX18ZKFni08yQg0pIJc0En+JM?=
 =?iso-8859-1?Q?2GJmNnijWcsAEXgw2kuCul8on78uHOHN03eC1vDntbEKqiuMnJbaRVQBUB?=
 =?iso-8859-1?Q?72RJ055qtaaZBnSQWyJ+DRamqu13j9ZwsYwgfsy9Px9nWdxECB8aqbGn2T?=
 =?iso-8859-1?Q?OQnex9CIXlYWf4GZUcBPTfbe2crga1Bi/oYPstNvVMSnsds+VdwTb9ye8f?=
 =?iso-8859-1?Q?G5ko64F7twCp2GpOjk5L/UUexsryWS+sg6cegmT2f7fLM27JppE27b1Cso?=
 =?iso-8859-1?Q?bpvvLw4RW7vSH+qy/ddjcXqll6+mNVJVqJh57ceo5SDWwWGJpE9Cy+OnzQ?=
 =?iso-8859-1?Q?8eO/GtBfOXIzp4D3glBtjK9T6cfLiGk66FGTompge38aZo47/ZR26rQPk4?=
 =?iso-8859-1?Q?eG0w06J2SPbJF9zzOMNwo00QYNbOYcPeZMUz9aIyl1nSZCQQT3j4QWvlfD?=
 =?iso-8859-1?Q?U74cG+JkNsPecwtuSNrB+qJjjeDGH040TJbRP5cupyBt6ZakOwMKfHYHj/?=
 =?iso-8859-1?Q?7nMCLAxXgOzDCVWGZkB8XKR64aRS+z6K6wfK+nqu0SIxB8pZHvEikBnteQ?=
 =?iso-8859-1?Q?yzyn4dfVpVr9EG/BhdFkoIp86nnr+Lee5itTOxKSc23gjMpw9hO4+no/qt?=
 =?iso-8859-1?Q?5G+WHTLDc2Twb9LYPpXUXv8R984+6Xs6QV44Ude6QqMxh94EgbsYk+LBZR?=
 =?iso-8859-1?Q?PF9svuDc1yYJDP+lg8N4VuSMDG4dFLjVr6VZtkDEGGAAfw64vvqhsaZPKM?=
 =?iso-8859-1?Q?qfoOhKUVWvzEtlVnYBZJo2v2bubTLnrAn+urxX9OojN/b4ez5ikcGA2/T0?=
 =?iso-8859-1?Q?00ab8vt85OWv4mznnkXwPAHDgB4MTokBptZx3MnhX/gEUQ4gYfgliSdEcs?=
 =?iso-8859-1?Q?un9UxpJ9WDio+SHjVj3/na9z12e6LrShkne/2yVsvGn5x3mfL6JiOP1suU?=
 =?iso-8859-1?Q?zreWOHeCZWHhgFlQbtNZlQQ2EesmG9l2NjZAJjBabmI1MOPq5w3A8MCaSM?=
 =?iso-8859-1?Q?RGRX54aN73Tn6fwljOrXoG99d2Z3pT09Gw+aCRLC0RAtZ7j68ZqRvY3cP9?=
 =?iso-8859-1?Q?rCbw/q/uCRG2Mdx8rXZhDE7T5L09BNYefdD4hF6iy074um4RQdygbyej0z?=
 =?iso-8859-1?Q?p78ZMchqLQ0DMnW7msHSIGXvBn431LnsK43RO3XKmZnvdryuovgwP1N1yX?=
 =?iso-8859-1?Q?PZgppCkNfioNrNyOUmBqN2df8fypahcnGLpOMUNsIfA6j8gDCcKB9SUDk+?=
 =?iso-8859-1?Q?VPJFR4jxWTouZTWYhEX/W4vtx20I6aNxmShpBEBshHVnXUQOFDPsymEqsT?=
 =?iso-8859-1?Q?o9xaEg2+Xk7583M+63LisiBjVFAycwvjEPDiHKBFmsMVMyuso7Qndpn1vj?=
 =?iso-8859-1?Q?DIKxR6+iOoGde0kZrtaCDMsgqViCcLhijoK77imE74QDglbPvR3f7Kj5Vg?=
 =?iso-8859-1?Q?F7tS1+/NCR9mzPZlxq0tOtwUIOmHeF1o5S9LvdaI?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b2135ab6-2f4f-4529-9f7c-08da7496bb94
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 14:53:16.8592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HI7PC9EGXXFnia9SBKi4LCm9HwCU7UN6ccw+xiUR+dqcwpa/x0geX7TOeJIXtPBgm1BVtmcP97Sn6kwtQHGGnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 19:25:55 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Tue, Aug 02, 2022 at 03:50:16AM +0200, Miguel Ojeda wrote:
> > Miguel, Alex and Wedson will be maintaining the Rust support.
> >=20
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> > Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
> >  MAINTAINERS | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 64379c699903..a4f90593b59c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17477,6 +17477,21 @@ L:	linux-rdma@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/infiniband/ulp/rtrs/
> > =20
> > +RUST
> > +M:	Miguel Ojeda <ojeda@kernel.org>
> > +M:	Alex Gaynor <alex.gaynor@gmail.com>
> > +M:	Wedson Almeida Filho <wedsonaf@google.com> =20
>=20
> May I join the party and become a reviewer?
>=20
> R: Boqun Feng <boqun.feng@gmail.com>
>=20
> Also given their activities on GitHub, I'd like to encourge Bj=F6rn Roy
> Baron and Gary Guo to become reviewers as well.

Sure! I am happy to help reviewing.=20

R: Gary Guo <gary@garyguo.net>

> Of course, they need to be aware of the possible upcoming email
> volume and sign up themselves ;-)

I've got inbox rules that should sort these items, hopefully :)

Best,
Gary
