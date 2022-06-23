Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D99557872
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiFWLJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiFWLI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:08:57 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150047.outbound.protection.outlook.com [40.107.15.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352B14B857;
        Thu, 23 Jun 2022 04:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmevyHc/gvxdsF9KgRz/Qc24FBdc7FrSqft4ozUzS9qN75JcwlMhd4LAKu77BvyHxkEyHdcmpgCga/OqNUTet7zJbzoV2SxnT+THYOnWIvBrcSRiiETod033NHfvfN/o5CBu26XtP71F+tCgzMBu7VgXxlUdnWl1r0FO/V13J+vWTII3rf7h6QhS74ELVWvh2QLgPtB0QAtCIlz0JSOKfQd+sanQoVCZtT08xYKTRE/mO/LspiWBNC2PWplcksn8CDvsjhFULkc4mX303lZ4LUMiGBuKlWBhOkFjTMOmSr/0M5CtDh12y72nA2UfmCEITKMjQ5WXG5pekz3WtJUusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qaU618toocpr3tkx5w/cQdPMjqL2Lj0eZb33b0D0/w=;
 b=eVCZVb50GK3GpGA1t+d/RYIABmFcw1vsVkXjaK9+U5wnr1kneeEdjfCJ0PKmVxrqP2MCItijafThXem8zQaGIdo0jak2nRhgywC7Omk/CMmOcDR+vo4x3PE1sedM7Vf566hCxIsUX5JuPU0l88rnx3MGkUrk6oIHK+DOsSUcddVjTRtgYytz/B4UCJxoAQ7T6bLAXePv1cZStUnA8u95+X6l5QKw1mb3/2xIaUTHRUw3n8KUs8+3FyBKHO999ta/ujD+DvUQi6fChqBZMt+36oG3eeg9BA4534QTtYxCFJb3N392KoVwKz6BNyvVEzRp96TKSqXTqXG8YOZPe+F56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qaU618toocpr3tkx5w/cQdPMjqL2Lj0eZb33b0D0/w=;
 b=ny8de3ZHEm2Re++6y6N++rQFSvSjcmK2KQDXkgX7s7AQVtPw9PolyksXyNOoJ+oH7DhB9SlBx4HAS2I/BiIog8uwtN3DAvigD58gdZkmqjUXufbPTl0HauKZY4rExZINNuJX8mBltLWOOafcJ32lo0hhC48W2/rtj61FHoH5TdI=
Received: from AM6PR04MB5334.eurprd04.prod.outlook.com (2603:10a6:209:50::28)
 by VI1PR04MB5744.eurprd04.prod.outlook.com (2603:10a6:803:e4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 11:08:53 +0000
Received: from AM6PR04MB5334.eurprd04.prod.outlook.com
 ([fe80::99e:6ee:d17:e114]) by AM6PR04MB5334.eurprd04.prod.outlook.com
 ([fe80::99e:6ee:d17:e114%5]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 11:08:53 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>,
        "+horia.geanta@nxp.com" <+horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] crypto: caam - drop unexpected word 'for' in
 comments
Thread-Topic: [EXT] [PATCH] crypto: caam - drop unexpected word 'for' in
 comments
Thread-Index: AQHYhuvAVru4alL4Ekeu4mkmAqO4g61c1T0A
Date:   Thu, 23 Jun 2022 11:08:53 +0000
Message-ID: <AM6PR04MB53341F90195C0E472F7868FDE7B59@AM6PR04MB5334.eurprd04.prod.outlook.com>
References: <20220623102536.34573-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220623102536.34573-1-jiangjian@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0ccbadf-2aa7-4f52-049c-08da5508c249
x-ms-traffictypediagnostic: VI1PR04MB5744:EE_
x-microsoft-antispam-prvs: <VI1PR04MB5744C908EC003D604A89B007E7B59@VI1PR04MB5744.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1sYBYdFwgv+YkQJNaFFWrINP9FV0Cnvs6YYwde3ZI96+xo1AUyPHyKileK/SbACNEPUOcWPIXA9mEvHhMEtxzVWSiYMYx4K8OwljXTqOrK8hlJWaaPC1gCc/0z1iFMy+g+IW2LM0dWmnhOU5B9FKnQA4J0tuaLFOPfYvQCwMFD6rL+AaPiQTZzholI7PP3zj97QM+rqmrGP0cFevB2151XsEdsAoLsB2UFRMA6+A6PW3/Q1DZUK/LsFa4uauJD7bEUQ3ZZ79cSSIixzFiOeW5Uf3uuAFKMMxeLh87cMr9/ihfGXCdIf2d7DXlKJk1GLiBKT4ifX5xbwRHNeiRV2PdEj/ohYYeRPVKtOoyGQt9k0gf6jfepa0pckeLMUPsSsu3LuVpRrgkwk2XPsKSyN1TZkBSDfIMeY+Xxj4bTAXkJVbqj8tYcbnp/Kw5X+AuoI1UEZXtP3wM/isS8Cu7JLtd8CHsHf2Qh5o+bqrMo0QP6xA8wZy549X5Y4TKto06JNc3A2ff0sUcx0kOfru3pVQV4oYAooMhL7gTJCVoBglt12UyxxR0ROpPjEn79BMm26pF7sdjTV43OM1tGG6IzD6cng6TzMRQNjCraE5/OrNPn8MtVx23clKHMEu27bAxAHfnjqC3ac4VkdJGB5RPffuPthXzRjZzJTdnzYhdlumJrAViHp0H8HOMitowOtryzTStSpknCgzP5X8YrSB0vD25U0rp7B+JN1H26yccy2kcFagQyT9pwVFkR4EqNGPtdi3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5334.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(53546011)(8936002)(26005)(7696005)(478600001)(38070700005)(52536014)(6506007)(122000001)(55236004)(41300700001)(2906002)(9686003)(44832011)(55016003)(83380400001)(5660300002)(38100700002)(66946007)(33656002)(86362001)(71200400001)(186003)(8676002)(316002)(54906003)(110136005)(76116006)(66476007)(4326008)(66446008)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JDxat9VtFZlkSGwO82ENrryS/MH3YYD9b/xMVJcsIpDiegjSizu8+1oKWMcA?=
 =?us-ascii?Q?UuPCGwarz0RzUrTILix7EuZEgUUXv9qFUgHqAQgA9sIc8CM2pVVTPvEOfbvD?=
 =?us-ascii?Q?J/jpUWb+6Eql5zspF4wMXIjllAMQuHA0AJWlKvk5QVaOCpYRLNJ06fVVZ2lp?=
 =?us-ascii?Q?rDyK+C3AsuJHDJv5fBEZ58o97ZcMjsNpme29m18/yITb6oPzweDJ+G5nWlJI?=
 =?us-ascii?Q?/eiR6BGEiz372Q4JrPNxgVmxsWhrW8nd4PnZKV2hlC6ixe6uH5nabiMx1Rk4?=
 =?us-ascii?Q?1MI2NinlK+AqeguvC0U6D4KGrGChQLeXaHJoVACVj2SlmZq/13Tky7r0g1le?=
 =?us-ascii?Q?0uJ3GjXedTIsGICxsnb4HbFt1g0fSjBWeKO27L18bCgZiXqZzItMxquFjWZG?=
 =?us-ascii?Q?DQpATq1C2Xyjml8jWwBbvM7xnOpNnhUaOY6wFMQZ1SonLWOMYkmOp5NECae3?=
 =?us-ascii?Q?7JpNmcgUdS51xVLFDoqvgGvNG+J8ro7Bu5x5C5HvAT8hxUCV7cO0njQa3DKe?=
 =?us-ascii?Q?3sbC0mTyFZt+xurHHEXQeQ4xFoMgYT5xSWplYn/uX8UVnr6kpyirLpFmdsQd?=
 =?us-ascii?Q?45mawI6dJ0AjeF+YQ1O/g2DfR4YyBpamUCSbKTAZXFvp4ZAdnWU9+DM7tj04?=
 =?us-ascii?Q?mMkDEvElcIxhku3Ta/zP0gOL6z9bFPO2NfF6gYPXMvYYEH66dv3pC9nI/Msk?=
 =?us-ascii?Q?jXwTmR3cz5Bq8gkCMd8u9zzzWw+NA7UIRQf2OkxA0Uo4gtYyYpX0vfWwXDQP?=
 =?us-ascii?Q?5iEFC8bH3/Kq5FWS9+QFaV+GHwi8/U8S7yA8MsOo/DfKXeTMdN78THo7fT+O?=
 =?us-ascii?Q?LV+cC7N4yEr0YZl+DFF+7CrSUy3lKZn34pvseJMR4KnS/tvLdjY7nkBDxXzq?=
 =?us-ascii?Q?yWwmLZb3OP3c69v0z8iAlg7kS09av2ciBXbQZ0HHznVXq7RCZmIK8SneV5jr?=
 =?us-ascii?Q?ozcEML44176bXdV69DTRHTeagp8wj8t8eg8WGhnylARF3IdGG1HKudDV7cKT?=
 =?us-ascii?Q?uWHgGuc05ZLcVVJh8La9zGkf9uC1fI5pmBOxbpaGlcQiS8rRNT9aJNVx01jp?=
 =?us-ascii?Q?7CeAjaLPr2PrrOmxJgG0lBIYgltom91EVNhijJBVALK5acAdcmMneXr/V7Y9?=
 =?us-ascii?Q?610gMsieDZx2os/p5l9/bWaGt3LhykIJqUM0/lccCEhP3mQn7Nm31+Y0i1XW?=
 =?us-ascii?Q?afGDkKJ/KbM5h6vHq10fy+zMFvmablQuKsu1vctMiXULwP+yQgFAli8sXNRd?=
 =?us-ascii?Q?ZmKRXzcSlQra7gVAdOb0GPWZQUrM7yIdiFwJfaI4/njOV7Wd25tGCKsfwxLG?=
 =?us-ascii?Q?maKPezJYTxphCTQ9cFrhqO6gHthiGTtvb/qhwTaXM+T7Sj0zaMz84VstaAYa?=
 =?us-ascii?Q?k/rFrW/kEFXW+bwmD2K4IAhKhu1+qFUJOF4n6HgyXEZ5f9MUZlK0bXrbP1yM?=
 =?us-ascii?Q?xOXdAJLRrJZqahQadATXNqKU0CXP1XnTjWtOMP+wbAsIkxMzbNs9CUm6WyKz?=
 =?us-ascii?Q?CwrCx0KChApuN0yUDubYfV8wyf4LeUYQqbqtM0fNBJkvQh0y0BIgznK9WxnG?=
 =?us-ascii?Q?5ZBO9x2CWZ12E9KwZB/H9lNqejPJ+Yyh+UlwJpre?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5334.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ccbadf-2aa7-4f52-049c-08da5508c249
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 11:08:53.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jI8Ikk3J007g8guYV/z7hlaOUemnaD3slyhjiHUxpgc78+DqhFGyRS+7uD+iYcT1/YxJI1hjsKVgm2H+mzpzgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5744
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Jiang Jian <jiangjian@cdjrlc.com>
> Sent: Thursday, June 23, 2022 3:56 PM
> To: +horia.geanta@nxp.com; Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav
> Jain <gaurav.jain@nxp.com>; herbert@gondor.apana.org.au;
> davem@davemloft.net
> Cc: linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Jiang Jia=
n
> <jiangjian@cdjrlc.com>
> Subject: [EXT] [PATCH] crypto: caam - drop unexpected word 'for' in comme=
nts
>=20
> Caution: EXT Email
>=20
> there is an unexpected word 'for' in the comments that need to be dropped
>=20
> file - drivers/crypto/caam/caamhash_desc.c
> line - 25
>=20
> *              must be false for for ahash first and digest
>=20
> changed to:
>=20
> *              must be false for ahash first and digest
>=20
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/crypto/caam/caamhash_desc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/crypto/caam/caamhash_desc.c
> b/drivers/crypto/caam/caamhash_desc.c
> index 78383d77da99..619564509936 100644
> --- a/drivers/crypto/caam/caamhash_desc.c
> +++ b/drivers/crypto/caam/caamhash_desc.c
> @@ -22,7 +22,7 @@
>   * @ctx_len: size of Context Register
>   * @import_ctx: true if previous Context Register needs to be restored
>   *              must be true for ahash update and final
> - *              must be false for for ahash first and digest
> + *              must be false for ahash first and digest
>   * @era: SEC Era
>   */
>  void cnstr_shdsc_ahash(u32 * const desc, struct alginfo *adata, u32 stat=
e,
> --
> 2.17.1

