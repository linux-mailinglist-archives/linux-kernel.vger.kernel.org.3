Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1645B53D739
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiFDO2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiFDO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:28:15 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2113.outbound.protection.outlook.com [40.107.212.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC79CE1A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 07:28:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4SI9cvjvPvluS00GWQpcFwcJ+GTvtBxNUZZcYPG5WZO+44QygdL5fQKDQ0BWa50EOoeVfW17PLRMu4/IcJnbSFJgQVKDmLe6zFgZXZgFnNYPNkOoLRPVk4pu8Lllo07U/BER0vQcXpqmJJ2RtE59v2UXHMWREl6kKnkbN8z2T/sAUHMe6YXMozzD16sWDUztQ1VA6Nn3g+Ba9d/7E63VtuLv2pgp2eEs5hXTRpkUarkgpaHo210+0lirG2bPFBImnkeyGnAErR0VAu2HT+mSJCqtssuUMh7DZxKXiac4uGGjffJstNE1jy/vE+jwcZooGcKcdtVIwzLgn5OJcdfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUtQaJKHOzfjFIlbZmvCJcUY7KfhMIO1W1VMy7XufQM=;
 b=fqPGKzjuok/fVIpnVFzffVwrcrJCenBKMLCnBYSlDnaZWrYs1GdizUQqZSnE5PDWzRIcMpTiCk0wrYdHtx2A+H0kNItFvGsJhrcIoRDabqH8sDMKDLLx/FVFhwvP/pc3vWnWvAvBxgRBBrQfj3Zjo+7WMomRjNxS6FJMlhqriK8fxEKQF+j8lKeRSclfcr7dFYKVwEuOjSdRN0/LUh978ET8ZUjtPdaXryn2gK/Wrhrwamb94Zpe1DDXNhwxMsZKvEz+scdwQXRulDzJbq5QsjPNIIaaOdWbrR7ascBYEnlnT71iK25woQYFjpXe2KfUrSC4rmWn20D9d+o7Uxef/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUtQaJKHOzfjFIlbZmvCJcUY7KfhMIO1W1VMy7XufQM=;
 b=HnKV0Zw5lhtA213JDnmZGGegsmcbBHOF9zey255v8xdbgfGvtSdhJ1j4/PEAYdYIuQndbBZJUayUype7pjvG6VFUmoE+gaijSnPX6ak21gs5mPZdri8QYfp/n5mgcTPIo76FSWXIXA+KD8gdxUI3Br0xo1qfklZyb40yLp1w73k=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BL1PR21MB3259.namprd21.prod.outlook.com (2603:10b6:208:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.0; Sat, 4 Jun
 2022 14:28:12 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013%9]) with mapi id 15.20.5332.007; Sat, 4 Jun 2022
 14:28:11 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Caroline Subramoney <Caroline.Subramoney@microsoft.com>,
        Richard Wurdack <riwurd@microsoft.com>,
        Nathan Obr <Nathan.Obr@microsoft.com>
Subject: RE: [PATCH v2 2/2] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Topic: [PATCH v2 2/2] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Index: AQHYd3NF/+jpUFe+HkanwU4T2Zlo6a0+D86AgAE7EXA=
Date:   Sat, 4 Jun 2022 14:28:11 +0000
Message-ID: <PH0PR21MB3025781A702070304BB8A282D7A09@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1654278961-81423-1-git-send-email-mikelley@microsoft.com>
 <1654278961-81423-2-git-send-email-mikelley@microsoft.com>
 <Yppfm5n41NEcrRlU@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Yppfm5n41NEcrRlU@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6e9b368a-50ef-4218-941c-a308be03965b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-04T14:10:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53441bc9-f930-48e7-9438-08da4636743b
x-ms-traffictypediagnostic: BL1PR21MB3259:EE_
x-microsoft-antispam-prvs: <BL1PR21MB3259295DDB99D04CAF217468D7A09@BL1PR21MB3259.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: agoVgkXzg15U9OkB3OVkgUDVyRYkcDZ4VeNNRCtMII/GsEGYURtq8dAyVXLBSiDkRHstpFiI4BmWWy5uCz5SBz53WaMFb9ePOtQDFt7zrE2/P4febrYtekeHjJGKzzRNyIN9TZKh1PJa8qS1+WwyxBV65fcJqc1M6RssTUK8YENRbJpe7JV4SXZilbDZk8lxWBVh/ixmbIb5jeehYxBTUHqHrhLgn80dO7J/SjnJbY3L/FwbqJjmFLaHYoQvhJSR0Ga3tlzbvqog1xZmi14HMabwuSVSCXfcANi9VB7jJX447Qs6Z2bBL4abAAB9xZhbMnycsaNQi1MNz1H4jloa7ewc5KL4SiBjMWqrsdLTNOI4t3G2cTLXiy3KsBoYsLzqbL4wR58J/6bSqe2tcezYei2W3HRg5+Zri8/FqxsFxOtiey+Zm6aZvf3uslfrYIv6yT6L1aKUShNJlbvLijx4qAEy9aZaK+aduL3xke10v+OX0f8wFor9UF4j8xLlAMvOLGum8c9WV9zNC23ZsPypQQCPY8yDYaufYTjEqSBfaTDy7yrmd09lPnpij29EYUPJDHShgR7XcsWbGgeL0TA48cWuKur0kC3jW/GQNamjDNzMthmPUeWuOrvPhzvUF0pPPyDgO3hNVGZMZJTeYlVZxdhuzX73BRSKynWzkX8Y3SxKuzsim3LDcTxbEsI5h3lqGkw8tuQrgG/5XN/f++sQJJN4ous8GVaGqU7MAeuKs5nhHiAkIV9MZUzD4MTzYh9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(82950400001)(82960400001)(107886003)(8936002)(2906002)(52536014)(33656002)(71200400001)(186003)(38100700002)(6506007)(508600001)(5660300002)(122000001)(7696005)(86362001)(8990500004)(9686003)(26005)(66476007)(66446008)(64756008)(8676002)(66556008)(4326008)(10290500003)(66946007)(76116006)(6916009)(54906003)(38070700005)(55016003)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HeXl8Xet9MCHHX7K7q/y+KCWzYSxhKfD/cULhkwp9k0sF2EKINzp9w+2Cwup?=
 =?us-ascii?Q?y7auYVDRMsu5Vw1Uz/pTZEICyrZEeb6bNvBg+e3kFchw/4QxskAnUl6kfemt?=
 =?us-ascii?Q?XAl0qWY6rjY1UM+bqOvXH0AE1UZUjdiXa4eNeCCo+dib13DbZNy2RziqJp+9?=
 =?us-ascii?Q?L/iswhq6SzMwsZaFvX73u9OJRRG3gJHNhIXEzzb6AJ8ibCFtFxxGi3+KAcvA?=
 =?us-ascii?Q?g7xSR9q76ZTsp2Bufw5iP0zreWgBf1JvepUsuxEmBDyGidS2qyaszFICRkHC?=
 =?us-ascii?Q?arxDIWr+WzwIK5BJwNbJJ1HgID+G8QunVV+CJVgn9p+XOnbt3r7ZZvYFGHYn?=
 =?us-ascii?Q?ELhFOtgfZtg/TU8dplieT4rO3gI11VD6WfjLdIvz0fgi3GAEA9k4TJNz+xOC?=
 =?us-ascii?Q?9iurR6FfyX8Re7Ul/yaq79f7SiiocPgzf4Z5CfFuUiGL9TRNiSKXYDeiMDZF?=
 =?us-ascii?Q?Z3Ifg3ZzWooF+nb05KO0Ml7AxEzOPB9GkzSlakILoO+ve+j15QD9j16lwGqa?=
 =?us-ascii?Q?m7iw/uXfMvJy/6qMPIQ+mMrdj6gMpYWLzbxlC5YhUZmqrqCDFTlXcmwFal7S?=
 =?us-ascii?Q?vLezOxFPQ1lPYWr/oFxxBkvRZfAYSaN7lrP0PEpvLydZu7+UEMQPR9CdVniv?=
 =?us-ascii?Q?SVgZnXMdpIUIns/mPqMcGJCrBDj8qK4TjQ+P0LgfxvR+ggF7jius8MkdM+zG?=
 =?us-ascii?Q?8B3L0ksu7mASzpNVtARrCX49hnyS7hCrK22zIn8gsaSkwasAQVFcrQQLUKov?=
 =?us-ascii?Q?x0Q23nwk20Jl1IAKGbBKGvBde9CcAujo2E2umefKIOnQt/baPQwUxB3FePwm?=
 =?us-ascii?Q?gIcL1rZ/RVxeCbw04GXgf1RHjrXHYJ6F7+0/N5tBOPxH5wRpxQD7yEKFwlBK?=
 =?us-ascii?Q?YxE2hCxzWGwuUh5L3uBpCiUmjo7V/jJyh1891+83w2ixkbH3VtB6AstjPsA5?=
 =?us-ascii?Q?O9HfAmRjvuDkG18AnW6W37tvZ0kEbi9K/AmGYCnsCX5sfQT85O2z7/dh5+0U?=
 =?us-ascii?Q?g1LovqLji1/DHXlj/aeKXBzJ0ryc8G8I6fXjYCrNhLpmK9it55RY4VRSxBOI?=
 =?us-ascii?Q?5qK6xDl6/07KIefRLeWeCgje6hHxZADpUzGIyXX/GpkKooGhpkKW3jJB/eJL?=
 =?us-ascii?Q?qzb+Md+VgTXiwkauq54+klPSuViSrAqaELn8daLOq3ny45cIMOyzLnntRNac?=
 =?us-ascii?Q?K10oKAGjZCmsMH/C1x7xfAPTXOe4UBYtZ+iH+ufLrXqB/p0WTh3Y36n5CO1V?=
 =?us-ascii?Q?VTEqTqSJwYuewuHQgYR3MLEenvaHuU/kyaKCjmXTJ7uEXPj8qdYnRhXdfB7e?=
 =?us-ascii?Q?eD7gm6Ck2r8+yyQhqkxMPCRKaIPe/Wb3U4Z7C4Avg7MVCgYYAG9ueLXJxl0i?=
 =?us-ascii?Q?6Iwja651KJeK08p0lIbxqxh8aqWez8og0SxOsRA7+Wj9ue6PxlR75W+B3xhv?=
 =?us-ascii?Q?5WonMQk8ehqJIcIuffNxvW2BrzCz9EdQRaiBLxsNqdEDDhaHv0ZwpAvJMgVb?=
 =?us-ascii?Q?l2bWaJaAMTEf4fheh8KI5KtrYgPdOCKJxmlA0TTATOdfkY40Q92O1cHs9CSy?=
 =?us-ascii?Q?yEg3yd3enguI27+HYGZq36izqkD5g62foKoF0nQkwtzXxg3aUdOag5ccsuI5?=
 =?us-ascii?Q?xdRVmMYZXkchKaFrJkZBVbrHR2VOGnRVmxRtQ1Urqv9vugqyROhmKe9nWwRu?=
 =?us-ascii?Q?2lHCSs3KRLpeMSqVQL+Uiy1VRHwi2a7zVP/BOp2oBsFqJg7mrGN3RNGd9dD/?=
 =?us-ascii?Q?oq/MxV8HjQuJ6YsSQ7SXcEywt6knEGs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53441bc9-f930-48e7-9438-08da4636743b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2022 14:28:11.8430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/kSABeEA0OmSJGlgTnvz9QapaTmvHKOYYciloQ68bWTfRL/bsFith7YlTFQLPbitgcbDf05v8b/cGesH6PGeLsTvWFRKHf/5lm3Ditx1L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3259
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org> Sent: Friday, June 3, 2022 12:23 PM
>=20
> On Fri, Jun 03, 2022 at 10:56:01AM -0700, Michael Kelley wrote:
>=20
> This series looks good to me. Just one concern below that may amount to
> nothing.
>=20
> > +static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
> > +{
> > +	u32 csts;
> > +
> > +	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
> > +
> > +	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts) !=3D 0 ||
>=20
> The reg_read32() is non-blocking for pcie, so this is safe to call from t=
hat
> driver's irq handler. The other transports block on register reads, thoug=
h, so
> they can't call this from an atomic context. The TCP context looks safe, =
but
> I'm not sure about RDMA or FC.

Good point.  But even if the RDMA and FC contexts are safe, if a
persistent error is reported, the controller is already in trouble and
may not respond to a request to retrieve the CSTS anyway.  Perhaps
we should just trust the AER error report and not bother checking
CSTS to decide whether to do the reset.  We can still check ctrl->state
and skip the reset if there's already one in progress.

>=20
> > +	    nvme_should_reset(ctrl, csts)) {
> > +		dev_warn(ctrl->device, "resetting controller due to AER\n");
> > +		nvme_reset_ctrl(ctrl);
> > +	}
> > +}
> > +
> >  void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
> >  		volatile union nvme_result *res)
> >  {
> >  	u32 result =3D le32_to_cpu(res->u32);
> >  	u32 aer_type =3D result & 0x07;
> > +	u32 aer_subtype =3D (result & 0xff00) >> 8;
>=20
> Since the above mask + shift is duplicated with nvme_handle_aen_notice(),=
 an
> inline helper function seems reasonable.

Yep.  Will do in v3.

Michael
