Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CCC558D20
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiFXCLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiFXCLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:11:20 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B04506DB;
        Thu, 23 Jun 2022 19:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByjWm9vWDHZw2hPKd3yR0mXguB2vDuuTE5tVwQWOQuvjxpKMDlmtzTe4kwGLiRsqTqdsopwb30z8Ai/dXrcgnUH3FLwQxUiNQ5OJQweiJ5aYgdrQNuvwXfvV8kYjwJ8olC7AYq8ykcjITTjdVGCs4dm4bIwOH4UzeSGqTTK5TzYpdXsygnaZlcSmVaTuBNqUXWTvQGyN2pWejLZkGoSV4dEE6ZklArQfElRNPQAOQxcH6o8xMeB4u6DzggUEh0vbdBoJ7dnB4D4cOnh3tKe3JP5FxivL6u+syntJWaxkLCq2j/mLLiClsAcyFU7Wr6tog13yJUvsXkP6hBhMmzTZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN14z4VoSw3b22MCQ82jnhgUrkQW9rG5NISQs4+t6ao=;
 b=AjMd7u7UFdbaU0AoLJJ+G86cYzsax6OvkUGQJxr/hRBhAS2KiPoNOoO+BKq5od9f8eotw8AvOtYath0ViZEv6BT7qyIZwQ9t2OOl4Cj+qiE18zUrNS+ne0YcY/zhDIYGXsxS6KkAt4WpGcTyN4DXuKOLtU1f9dTdnn3T7r8vKf3dDijepN3lyKUaQaoI0xjf+OCIDutuSDAvvwD6fID6IAHSdWdQndl/azcuRyQiVpmA0eby5PB0oNb3wo0pDkHcrr/dxEfR0FiwQqNeZqzc8Bd1eenmVljnuMM9Foc4lXcu96PsF0J2gv2DJ/nFNRW/yHfjRLAXqoWUH39bBKzwUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN14z4VoSw3b22MCQ82jnhgUrkQW9rG5NISQs4+t6ao=;
 b=J853vQsRYMn8DF/AZwkcNfdKN5PRXHBN5ZyZHT1ASTjuS8pGqKMjH4qHOe/OuSZtKHxGT59Kg9w7bne3pOjnQSEYd1I62rfQBmrhRByjOehND0vyXmIvgVTwjjJFqcY12WYrm/W1HDWRkbGUUqROD1H5FFiCvxFb6CEf12tRKb5A/n0VcNQ8ype11d5s2h1mWWWfjwtBmpM70uH83sZikPmQjuSaM9B40JCoTp53T5JWZA09jaRRp3v1yid/G/MpTFVUZ5UTweM927XMFLw48LjO3wl4JldBDOAjiyz7E+AoFsFcKUZGTY/MLOBt7R24F9KsejZjR+GCFSfOz0rcjw==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB3089.apcprd06.prod.outlook.com (2603:1096:203:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 24 Jun
 2022 02:11:09 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:11:09 +0000
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
Subject: RE: [PATCH RESEND] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Thread-Topic: [PATCH RESEND] usb: gadget: f_mass_storage: Make CD-ROM
 emulation works with Windows OS
Thread-Index: AQHYhq3rzhxyDFo2ik6AmHo1KwAqPK1dEz8AgAC9vcA=
Date:   Fri, 24 Jun 2022 02:11:09 +0000
Message-ID: <HK0PR06MB3202F448E528F2047E1C3B1080B49@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220623030405.1922980-1-neal_liu@aspeedtech.com>
 <YrR9PrjBXGV5O6bq@rowland.harvard.edu>
In-Reply-To: <YrR9PrjBXGV5O6bq@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 585a9bae-f9b8-4963-e5a4-08da5586ce05
x-ms-traffictypediagnostic: HK0PR06MB3089:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /xIhgBPZKqY7HeQylnURpITqmMXZembH2d8ix5pypZBu/PwEM9SC+vLMsD3cjVH0qpB/3UufRdjCYugZAG/jrsT8pltDzaeIrB7v3rgJKZRi6uJflKK1tcUIWrKRmzU+T66UDINvHgT54pnzUBACFDSLtgxFVK0wKO9WJhsLbVR3eITz8Ndu4wT54i1DSpLzNd/3ODxTvPWcZkrMO/DLJM0LTwTZ5RHkpEgdQooFm+OZwHQ87jj1AdCcCU0p0YKkYazYdC0BaV0QANWhuhCTb5bi3EclDXAB8vL0sTaa7M8llqv9kt0CCOzOpEdPYzCT7DBcIu1JIKRTTdGzElpEcEsrJ7bsoLjJp0/9fBjqs+/rv/0+hRwd0NItTQdEYNK9zn1ENWqO7uB9+HeBbvSebV3Va95JO4SDlCoubq21u7F7uAlYdBHlUEB2G1fBgkltqgy8g82C52/zaOWqw4mLKKrH/MQYT7QYydn4GIlwsoCthRruW6uvktEW1geroulP2M/ZCD05T399R1kxTm0ojZd+TWShTOkOIyLwHinOMd0YLcrfNfpsFoW/YR2M82rFKM9+Gh/YjyJ2vxzlLKT+HEuwk74t5yeE96PVGexQUMEwuMont3YZEEx+D/7JreNrlXHnq3uWy46T3vX7YgyZdCpUnzexLMlz2syw7El+F5HmmbXb5dqoU8msfVTVHyY7pWqhtaBbXcNy2aDivoeOZQf0iQ3go2lthrRV8eomeEgJfT2AiFhthNFnr3D5PxOl3wLJG75qfmA0EiuAZoc1c2U07alfV7EuTdUhPlmxH5A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39850400004)(346002)(376002)(366004)(64756008)(4326008)(66446008)(7416002)(52536014)(33656002)(71200400001)(6916009)(8676002)(66946007)(76116006)(66476007)(66556008)(55016003)(316002)(83380400001)(2906002)(26005)(107886003)(5660300002)(478600001)(9686003)(186003)(41300700001)(86362001)(54906003)(8936002)(38100700002)(38070700005)(6506007)(122000001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E3lTgepvzf17iDinqXSTefKLLQi1PrhgGE1Id+WbZrLtXEXlYm9+10p2mPXa?=
 =?us-ascii?Q?ECW5+MiJfW1cKIoode15F5WahqnnbRI1tcblLgHXjnGAR0RRwqy8BxLcqh94?=
 =?us-ascii?Q?xoUKX2vVWGKsrPT60nS5NP0t/cPkg3TgbC/KsChPTu1/BH+pnkPS8AH2CB8u?=
 =?us-ascii?Q?xX40B/Ybrg++aPdVl+vi1D/AQEWYoQbn2LDNRl5KOXYHdgzP3VL0UQnFhxCh?=
 =?us-ascii?Q?m6s7piy4GBnn8LM9AVcbcA/ccRjbbmnKKKZ7hCRHev0nSPXmbWMtTMuWkBgm?=
 =?us-ascii?Q?Q/WlCZHThdvovets9PwaEG4ooyJSGLtcy4pI+Ys5FvuDKrJk9Ru577Em/r2d?=
 =?us-ascii?Q?XbgdLkJlOD7DjnYpBuxWztfpGwN2xkSbQG9+4Sg3je4GeVXJSlhLrv9DNUr5?=
 =?us-ascii?Q?SqYhNN3ndiD3B4/XpmXG4NF/LObEbHVFGAZCDam1K9iej5kFc6DorlECzbuH?=
 =?us-ascii?Q?mX5qEyKJhn7MM7Lrpti4RkiB1GsRTQubvGi8sV7YPKt7tY9N64BSjxutdNlD?=
 =?us-ascii?Q?4YaR7/EkoJj2v70a6niXkRh/bUHjbsjTVIV151Xub0odafGIAUXoZH4eiyRW?=
 =?us-ascii?Q?QLbW/nX1UavCQamfNyZejRR/RYGESD96fH1yhKOpztAV3iAweZ30xpC0uBwH?=
 =?us-ascii?Q?mMSz3BWcCuSyakihkF38gSbu1AadwgzrzSq56WQWIpRCB9FPlSQk2syt5uzZ?=
 =?us-ascii?Q?Bd2rhUE15FgEcQNzAbxPSjvS4QoX5HTW9RA1QP5itqhHzLDMufSe9xlayfPe?=
 =?us-ascii?Q?fRYdiAzFlJF2JWRpGUjdjzJvPnblpY80UAvONiTMwvsj4KLnPU2jnxobStSu?=
 =?us-ascii?Q?okeq9/QhU6dfsOpCpJqdET5Yp7x9Vr6ElHCRzFYkqp4PWCc90kCSak7ZR/i8?=
 =?us-ascii?Q?yOB+VeTixmvrbfkDF5Q5zJ/gQFfkuV+8dksHmeWUO+O+Ipby4JzU6Wh/SAdw?=
 =?us-ascii?Q?28L+TemDiUxKPYgqn9sdUgLE+CjvJvGNgnLzxk19Cez9oOBNbII2Rmhcd7O2?=
 =?us-ascii?Q?OGm12G8P0N1H/N+MX1ivN+2N3kkZIGgwcSwMK/6rpTbNpWwCX2Kdqx7W8d/b?=
 =?us-ascii?Q?fTF4yT2xqah+H6dj2IFm5NNlw1hLQgKb56Mm6K9t3YPdh/A90mdZi03rbDNh?=
 =?us-ascii?Q?QXShptnCLn30wClFQqdN2rOEbxc+qEd6irAMIyUopdZaXYz8DRqOtesp4ZWt?=
 =?us-ascii?Q?ctLo726irA1osKHlfGs5R9Imtqyn0IcyEmLUn3S5Nr0jwTDZMBY4j/VK9UX9?=
 =?us-ascii?Q?QskYw56fG6HhxBO1nATBnxyt+2Jqz/ruerDw9ea9z4mbtB9vGBKtE5TarkKi?=
 =?us-ascii?Q?6yJ3VP9xjJRYfTo/n21i4oYjpHvLpf7O5Puy33tSPCT48wJeh4BTXjih/hZB?=
 =?us-ascii?Q?iNLHZlaf2wtViTDnkzCDT2oqs4iurT4ZgrrHfpsxpECsLgZxB6zOpUKVQk2d?=
 =?us-ascii?Q?QnaJKt0bxB0UvJJR//m4Igo9kTFgwgJ4ONxAJQxoRmiA0/8f7Pdnfe2Q4w8d?=
 =?us-ascii?Q?D+Cj765HjskJmKmnYhVsYdLQ/Cj7g2zdenJrgLx5GRd4AZFhTCNL9sPE5dLV?=
 =?us-ascii?Q?1PXaS/OUsxF2+7/Q/xPcKY7CZ4OmPsBFHSn2ZkFA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585a9bae-f9b8-4963-e5a4-08da5586ce05
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 02:11:09.6349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wbS5Ua9KpK95+8pfWx8MOAHr9No5COQ2gQi0c9PeIRCg+I1BMj73oKnB744iT2+2tEft/MZL1m7HgP/ODjNBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 23, 2022 at 11:04:05AM +0800, Neal Liu wrote:
> > Add read TOC with format 2 to support CD-ROM emulation with Windows
> > OS.
> > This patch is tested on Windows OS Server 2019.
>=20
> This description says "format 2", but the patch actually adds code for th=
e case
> where format is 1.  This sort of mistake is not acceptable.

Sorry for typo. I'll update it for next patch.

>=20
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/gadget/function/f_mass_storage.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/gadget/function/f_mass_storage.c
> > b/drivers/usb/gadget/function/f_mass_storage.c
> > index 3a77bca0ebe1..3c2a5f1e8b66 100644
> > --- a/drivers/usb/gadget/function/f_mass_storage.c
> > +++ b/drivers/usb/gadget/function/f_mass_storage.c
> > @@ -1209,6 +1209,7 @@ static int do_read_toc(struct fsg_common
> > *common, struct fsg_buffhd *bh)
> >
> >  	switch (format) {
> >  	case 0:
> > +	case 1:
> >  		/* Formatted TOC */
> >  		len =3D 4 + 2*8;		/* 4 byte header + 2 descriptors */
> >  		memset(buf, 0, len);
>=20
> When format is 1, the driver is supposed to ignore the start_track value.=
  Your
> patch does not do this.
>=20
> The default case in this switch statement has a comment saying that
> Mutil-session is not supported.  As a result of this change, it now _is_
> supported.  The patch needs to update that comment.

Okay, thanks for pointing out. I'll update it as well.

