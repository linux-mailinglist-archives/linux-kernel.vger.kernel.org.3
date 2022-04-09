Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB614FA8CB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbiDIN4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiDIN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:56:29 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2047.outbound.protection.outlook.com [40.107.102.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741954757C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dp8txRNfSOjEvS3AED/jnQI6FqZXBBMTdaa9b7nh5bvC5SyPjOMIzXnnLuyGwOvWtZ8OZDfb9PAAG/hsHJglfIrIWo5ZXSqNycLgsnmmHPH0gU1U5n6gfZgp9nxUwQQjKfsW/aOulMKP5uK8/cUJr25kE67kDx/lbGyYvPsKN22ZkzBmrlLzPv0VOPvcgMrctCJo75NzQXE2miD9nOq4muO911QsiQVRJKP9fFVBkg3klwNbRm2/DJXeBibTu+6ujDGhzJuTgs3u0OUeGI3mcciVk6Z2NgFC7KH93jp/4kFGoy2Wd4881isia1MaSy0cnI2BqsqF6xw6i+jtIjrchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOdfg8+fDHMrxFcwbEaPl+vpiKC2hLmjsFuZLQBHiXQ=;
 b=cKn1wYLPIHIbh6uCblUea5t4UgaN8wij+h2cV3lVgdLvd3oVamLZabNjTglvQKyOO1+XkZX1ql6OK1b/CzxXpxdDV3c8IfgyW7WEgvRJv6NmG3N65GlGs1XzH0fM4RPZhcdtzkd3fzBZvY+VKLhM2WZByCyDTXG9MtbOYEME0fONNkQtMBvJyKc5ZAKDdl9J1Fc/sqVg5xsAThJHseOVzsWTo50PZYm3tWUlEIJOhLCQtiTUo9+QrlAA178n536D+yYAqx2E01V1qQkL1kEEKwOBkNhwReW4bMLX7CCMkb953yKPNU53nSIteOgQmpGXL1tZoFrLxgxTSHHZrbi0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOdfg8+fDHMrxFcwbEaPl+vpiKC2hLmjsFuZLQBHiXQ=;
 b=DRy7n78yURwN/ALSkMQFvk+IFoqXKf69mNM63SZXZvD4NWlZPPjjkeNDaLtLM6D3xojZgNTgx7exDVv5fhO22kUGmo/S+aZvFWO0/OI4CteN5LJILqVPdecCHTb6utwvz1+dEriae+ARicho6QjHQJNGGAody0HQi2TPi9rVO5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by BL0PR11MB3505.namprd11.prod.outlook.com (2603:10b6:208:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.27; Sat, 9 Apr
 2022 13:54:19 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::24bd:6fda:ce8c:191d]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::24bd:6fda:ce8c:191d%4]) with mapi id 15.20.5144.028; Sat, 9 Apr 2022
 13:54:19 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Jaehee Park <jhpark1013@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH] staging: wfx: use container_of() to get vif
Date:   Sat, 09 Apr 2022 15:54:09 +0200
Message-ID: <1911301.taCxCBeP46@pc-42>
Organization: Silicon Labs
In-Reply-To: <20220408222102.GB2511628@jaehee-ThinkPad-X1-Extreme>
References: <20220407204128.GA1810425@jaehee-ThinkPad-X1-Extreme> <alpine.DEB.2.22.394.2204081149360.2196@hadrien> <20220408222102.GB2511628@jaehee-ThinkPad-X1-Extreme>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR0P264CA0142.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::34) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5c6713c-576f-468f-ac79-08da1a307152
X-MS-TrafficTypeDiagnostic: BL0PR11MB3505:EE_
X-Microsoft-Antispam-PRVS: <BL0PR11MB3505943993FA9EF4CB9D5CF693E89@BL0PR11MB3505.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: naZaTA2n6luxr+UKEj/pJSHqrPi1RvmC1Y38Y6iuq7TD4TnqhfLK3mX6HRaVqTkuofUFxJtk3EBGJW9U/XwTbohonSYsAfzaPejhY/boYUWOlBgfeO9W+rKaEJktns8EmKcn9nIC0zA05ovtKrqWTb9ANNbJY8eCgH1aPz+N/BNqdQDsK2dPtelrjEXaE7PxmTKV2aqRf656eCc9el6WHOQsmAe745xD7AjaFpgMJyhO8nqn73B8KoeylBtL24cGbveo810Fhm2Xx7KuFgJiJzkC0fG46mN7P3W+Xf38pCE67oi7vnNFaZjaeZTEqTHGMmtCh9pf0yzZzb+SBh0JLGYQ1ztJaE1Gkl1a2QIvdPoM7R4/Tjz7tFibykt5B/wOsrtsmIJ4ygpOjA2BpRIbOnalJE9XHXG2dMwTuCCy3lqrGMQ6zwg64lpWc9pFpJlRg5g6tr47BSWJ3VNjDszHwEQDnYF1WOmR113HCcmzOJHbbU/15pA4lj17HSnY9sQQFBxBkRj1qUnAv9L2SF4bwLby+HB0Rk5M+lJpLRRqtkmHYQJWJiwFlzqssAxkZ8BDE3IPqoB9z3772pdMBZXlAsz92rAY8c/tvmzlk/JVlAZuTPgR4CyWQgHYADggV/r7PIZAcf8MW0Y+mXhDaPT6Yo6vvJju1E68jRoWI9ngqGJBJGiherFNx9gPuIbzObhci0QHjhHZoc1CkUmHyTEWCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(36916002)(52116002)(9686003)(6506007)(6512007)(83380400001)(186003)(33716001)(8936002)(4326008)(8676002)(2906002)(5660300002)(66476007)(6486002)(508600001)(66946007)(54906003)(66556008)(110136005)(316002)(66574015)(86362001)(38100700002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LfTcAI5Z+h3FufnpPslT2GH/byFEgI9Q64k36EgECBsZ7Qk7Id0aSmECVL?=
 =?iso-8859-1?Q?0UiApJAYZ7L2qKIKtDVsMIBzVQxAkq7bU+X49DqVm/INROndGHSFM0iSLb?=
 =?iso-8859-1?Q?hPb6HzSHxaZFYdlYte6D6iF8dC0esbiwOuALvQlDsxugw7dgNx91uwvped?=
 =?iso-8859-1?Q?4o0lktKMkJGVk5+n7D9ZOL1EVEkz/ScCm3+s1cyjzh8meE1xZi4+xi0UkC?=
 =?iso-8859-1?Q?8OJaRZnA8U5AAOyMehaRxa7yOocg8eKwg7CXRzVwJkUE56CK/ippDvAgY+?=
 =?iso-8859-1?Q?xC6PxQpcbp3d8MDqryzEGIhjllRF/3WGAQ4weNP1Iw1RjPgxtzjE9xVL8X?=
 =?iso-8859-1?Q?JTP2N3lj7ZTEW/4xJGYvd/hF/i4jTDsxQQXuLR2Oxn3IHlsv8acBMzEuLn?=
 =?iso-8859-1?Q?ZHZSsFA7U+lUx5weihAMHI/wTsPonElgn86SolmKv/GrsvA9W9T2HGj4W1?=
 =?iso-8859-1?Q?ZIogbQnoGxuPaukY0DqRwRlkds+/TXkysAX5w/GKT84hrKPrQdCG49u2TW?=
 =?iso-8859-1?Q?pj59Khrat+3Xa6Q696cAnW/RVhlFztMSzZTH83lTIIsw618Xe07YERKmk4?=
 =?iso-8859-1?Q?QkE7d3CY5v3WKSMHxLeblnoout39Pdsp6QOO2JB5L/nnACSbWYJuKNLyfy?=
 =?iso-8859-1?Q?gk4V05MKU0Q4AV7Hz3qPjaFWuEZpToCaDMBMy80y8gObAbI3Jz32GiWU5j?=
 =?iso-8859-1?Q?RhdgCJHf4NRcDzsexNg9UW9UN1jDvMPGZ5KlcOnWSKLMviHQn1hcks5/Rd?=
 =?iso-8859-1?Q?Q96yEXoctKgDXC7rfwZ3zLvNLUUSYeG6fXzaecbr5eD6aYlR7JQTrGU1m3?=
 =?iso-8859-1?Q?gWe+Myueojuc2rXpV/EMu60QbUhfryFlAfGsc7e92Si4QTi7eM5PLCvJ5q?=
 =?iso-8859-1?Q?YU8msh+cqfOpPky6jjLTcuVcek+IgFoxVYUuWeR4sjL20W4TFL8ETAQ9pY?=
 =?iso-8859-1?Q?GH8v9ylWRQvzMvWNVAlQgKNOi/r6DR7eVo8+PxsKp7CCsEBFaKizoSafQk?=
 =?iso-8859-1?Q?GZI2O4xjuKXQ1WFkkMax2G4/onSHYWJzr/BJMO0bvxOeqiJ44YSWQxmVon?=
 =?iso-8859-1?Q?NYJchX4l7i0ES2YVd5pYBQQ3Km4KuaDvMl5YTTKRFHfKhmDtWqKghUp5Dr?=
 =?iso-8859-1?Q?V9iQoiRTLzBYii5ZXO4d8X6F5VOXrQ8LzIidQV55tVWOP54SKVEdY2Yv/2?=
 =?iso-8859-1?Q?XDlsBry5hXooJ41sreXq8JRBUwYuO6aP5wDrDqN0e7N7YTX9VnhxpS56y/?=
 =?iso-8859-1?Q?Btqm6GLskIvgYbF6ZScsgrXrGa0jbPchymHbhzqC//IuSRXHHNHRPfqtKg?=
 =?iso-8859-1?Q?tE2B6e0BflEvh2aIeZCoRGapb4ESw9dra8Lkxlrml9KPKx/C6Cg2z8uqPL?=
 =?iso-8859-1?Q?lbyM+YExO8sWZOArqLJJ3g+gxfU+S4LO8GEbNFUnvXWgwhC7BJ55EvtqsX?=
 =?iso-8859-1?Q?yuuEddaobzlUuphCe1BX+R+JZg8y1lwuSIOlFXqbcqW5QrVG/RbCKUu8rS?=
 =?iso-8859-1?Q?PKL6M9ojAdckYcqA8G4397CbO2Ah9FiUweJmLrArBy1In0ZnTmPVPYTtIH?=
 =?iso-8859-1?Q?dp15RipnQyRo/91nyaS+061lvwF/SjvAQArzLbuhvYQiSSjZw4FaVOHgcN?=
 =?iso-8859-1?Q?m5btF5bBKYVANsB5PSNRb3c4KpISx2rcitAfxx7GAaY10aRS3QvVCl0tPR?=
 =?iso-8859-1?Q?SK1615JF/ZHzYd8xk66nLlQqi81qJLJal+CnZm3CC/HcP1Tdj+MNRKeIDb?=
 =?iso-8859-1?Q?Beh8XC0bAK6eEIS1V+pxlJo4sMHyDoOAY5+DNpmgvH39rO9Lb6FTZIpY28?=
 =?iso-8859-1?Q?hRF/dHEjY3OrAtiaZ5HS2Dep/kKsB0aDqwU97CVOSyrNYU0B2lV2kUJQf8?=
 =?iso-8859-1?Q?ri?=
X-MS-Exchange-AntiSpam-MessageData-1: yCVt7BnEQ+KISA==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c6713c-576f-468f-ac79-08da1a307152
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2022 13:54:19.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzIDpsu+mUa0LLHCVDtofcqv+kOsbNo7bmvbDrj5drFUTm6+ujJqlDyHSetwNwqES+6MBCJc0fhvatcv08mOHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3505
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 9 April 2022 00:21:02 CEST Jaehee Park wrote:
> On Fri, Apr 08, 2022 at 11:49:49AM +0200, Julia Lawall wrote:
> > On Thu, 7 Apr 2022, Jaehee Park wrote:
> >
> > > Use container_of() to get vif. This improves the code in two ways:
> > > [1] it speeds up the compilation because container_of() saves steps t=
o
> > > retrieve vif (the representation of ieee80211_vif), and
> >
> > I don't understand this part.
> >
> > julia
> >
>=20
> Thank you for your message. I revised the commit message (below)--
> I hope it makes it clearer. I'm open to suggestions as well!
>=20
> Currently, upon virtual interface creation, wfx_add_interface() stores
> a reference to the corresponding struct ieee80211_vif in private data,
> for later usage. This is not needed when using the container_of
> construct. This construct already has all the info it needs to retrieve
> the reference to the corresponding struct from the offset that is
> already available, inherent in container_of(), between its type and
> member inputs (struct ieee80211_vif and drv_priv, respectively).
> Remove vif (which was previously storing the reference to the struct
> ieee80211_vif) from the struct wfx_vif, define a macro
> wvif_to_vif(wvif) for container_of(), and replace all wvif->vif with
> the newly defined container_of construct.
>=20
> Sorry if I'm putting out more information than was asked for:
> Diagram is worth a thousand words; this one is made by Stefano when
> he was explaining the container_of() construct:
>=20
> .-----------------------------------.
> |  .------------------------------. |
> '->| struct ieee80211_vif         | |
>    |------------------------------| |
>    | 1                            | |
>    | 2                            | |
>    |  .--------------------------.| |
>    | 3| struct wfx_vif drv_priv   | |
>    |  |---------------------------| |
>    |  | ...                       | |
>    |  |                           | |
>    |  | struct ieee80211_vif *vif---'
>    '------------------------------'
> In this example, the offset is 3.
> What I want to convey here is the compiler already knows the offset
> of drv_priv within struct ieee80211_vif by using the container_of()
> construct. So, it doesn't need to do extra work.

Wow, nice ascii art :)

I think that Julia has not understand why you said it "speeds up the
compilation". I think you meant "speeds up the execution", don't you?



--=20
J=E9r=F4me Pouiller


