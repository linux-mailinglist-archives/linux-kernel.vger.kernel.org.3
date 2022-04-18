Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266C1504CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbiDRGhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiDRGhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:37:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BE618E32
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650263663; x=1681799663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VYyOyydQC6iPGsv2R19Jfrm0YeFfIgmNBy8S393+lw4=;
  b=doBub9RgbRX4XeLIxEmLHX46fltv2k5PXdsbd2apFCAqYp/kOjNiPCxw
   hOiCLBMu2eLhOux8rNKBVCfehBzSq7+9GXBLb6QHK5FjxSu9aCjRg+NBw
   xeAihg/n9tDs0BwSHPLBNy4DUBJBx46ERkhA+z53/ZF8UgG0VrElVSIXr
   KqDgn3I37ep+xqSJTgLrIEP8gg3WZJ6Li72k6dJMw9dDzMk2CeApPCQnt
   vL/pnTZfgl8+8QIFhVKgboSuOgozYBwP3WAv3U1bjPdpyqfwddJdSEPO2
   cYotN76WlWpLpg386F0YNTvI7h7cBL8sob1vwN2U9EPJw6P9mNPvpoMD9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262923561"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="262923561"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 23:34:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="561243832"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 17 Apr 2022 23:34:22 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 23:34:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 23:34:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 23:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APFHDQXHIYhzS17JF0USjZl6KBSbLk4KLcNZc0LvzinFduJbPGOYaPof10XBLbWndOG5C8B4G5bJo+uOFSFL9Hajieo1vNr1wl/iDrdyl87Fr1jgLFdncK17TVJwbys8GUd2c3/uw/sZOGuoBHviX9Ce0ZLuuihgMbbLciXpHT2fSVV67yFHZtMg1IykI6OosSUhj5PCO+pl1ZlSjuwFP2wF2MdxqBtb5PXX9lh+TOeUhOIOuPO8ua8ZSk6Hcikzgjs1dtHLSL5oiBJDjaRTsrk+4eq+NDk9dmC7U2WTnAYJTxCDF3mQ2G2P+X2az7KcRSifCIY6ok8A/9qs4bZYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6wEBjUjx9A/mKlPTsCmg3kpIW8ugLl8HEdYfhbBbJI=;
 b=dpOvuHyB/rG3JB+xs0JWhCk0PANgsOYYtfEfjRJSSjQ3w+lSFJpOuSo+9D37ceKn5Dw+ncxTChnVnaaBwGWNki1Qm5Jbafo4uA8e4yX3u4EfELGuAE/TBnFimojMKlSVmj56FwytwWBUYiRiqE3+x3hIPh1NB4Q2ht6gFDbZucs5n6FqA0EqPj6BVU/OW1o/I5TPsWsSgRSoafpJDIWuF5NjZ2DH636BjxyJAewZbLq2dzLEHB9Y9wNumv9QGY7VhBpzzk+pgP6SqYyXKRYHNyDKOCKals1WEUzEAHaGM73rvfK73yUsP+kpWVdJzLHUO1ujhnNaq/ULPZKp2eOo8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5453.namprd11.prod.outlook.com (2603:10b6:5:398::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 06:34:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 06:34:19 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        jean-philippe <jean-philippe@linaro.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Thread-Topic: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Thread-Index: AQHYHHcYr3pxcExTDEW1Xvk+kLHIpKyUa1mAgFa0xYCAAALQgIAAAs6AgAAEYQCAAAInAIAAAneAgAEPWYCAAG8QgIAAH9EAgALJMoCAAY2TAIAABm+AgAAKLwCAABErgIAAmRsAgAO/hhA=
Date:   Mon, 18 Apr 2022 06:34:19 +0000
Message-ID: <BN9PR11MB52765490BFC5F08CD4F7A9208CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
        <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
        <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
        <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
        <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
        <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
        <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
        <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
        <YllADL6uMoLllzQo@fyu1.sc.intel.com>
        <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
        <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
        <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
 <20220415140002.7c12b0d2@jacob-builder>
In-Reply-To: <20220415140002.7c12b0d2@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90076819-0d10-4e77-4345-08da210577de
x-ms-traffictypediagnostic: DM4PR11MB5453:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM4PR11MB5453E780E84F2D646D0ADF798CF39@DM4PR11MB5453.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DjiRW5Md8j3SZaZJktwO67F6q+taBiwsHvczH6hTIc3jqRJwn81PrigzQLQ1LMBAHzDcPrzK6q5ZVGmYH+oaRYYd0DAqQHkopKPfx8t7mASQg9NNiRxZhySh+3JpCmT0zHjGKYS/e093J/QLHF8tQh8LwoDk9RxluMpljQN1DeQ453q4E6ZrRLNPYrOawiKjysX903i4jh3MNnHzhfB6WTy4XQarG8x33jwTi1AYBADexd7yIfRXaROA8tOIR0P/v5kYa4lgzag68i7epOJ7NtQzAF6m4uzM33EmqeSU/NkdBz8/lrLRZbeUti110Z4XFSShqOosxcP3ie9pcW4xUR0I3rvUZ1R5S07Hr6YWpKcCRKHszOQLVEzVSEn6LuLPavXD//A+8UFz2c9keEUw73U8gFL/LBHgtGOw1PVeascOO6S1apwSX2nUDV9i8bHAzzE6+f8Fw9qIXiEOGR6n3mt8LenWcMn5OIoiTEwA+oJGdY94dLyp9i04bbo+grzNllqFClKWAQXzFsT8tJCKY9rPIVWMNOTLyNVlpbQSH8FePihT5Zos1rfY+DZP/r7m33au5rJeoHYayM847b0cf8DphrjiV0jX2d6vejxqytaCptKnwSpvTYUpX3d7Mh+WSj3P+1W9dESDYs5cO7StH4O5t5VuBfLBNrYMpMS1XwbUajPFJ0pHE5n2sPhwyVioVVikxeWhEn570V6KVAzIxVdF8kDBILcaIa1I2bstPgkdV95vsz03spM8HvL+/LTtJz66IGqHErnJOG5UBgT1rA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(55016003)(82960400001)(6506007)(7416002)(52536014)(508600001)(316002)(71200400001)(2906002)(110136005)(54906003)(26005)(186003)(8936002)(122000001)(4326008)(8676002)(33656002)(7696005)(86362001)(38070700005)(38100700002)(83380400001)(9686003)(577694001)(48020200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tQAX163dfm8RjEzby9aTDAGYP+quDAU0tby7+1ctj7KxuUIk3fHuL6DS+5oN?=
 =?us-ascii?Q?y5o02rVQ2hW8CAhzUOzBjp2/Jcm/E2nosNJCKYCVmeAWcVzh3HlQBJpwtG1T?=
 =?us-ascii?Q?tHAT1Aj/pcOrPQ/V2NMZ3VRHh2nDMip8lS/vBWf41F+Kz4AGQbP1u2LnJmYb?=
 =?us-ascii?Q?TlVPosaGvCStUfdfacIoTUoc+lIgq/0OTJW5V2bU/742q+cGmCa6pQy0jTXG?=
 =?us-ascii?Q?oBh8BpkY55R22LMng/PY7ARKXNVPoOmpqT8rNQpGSWGvDyi04ZEDWIRzPx0t?=
 =?us-ascii?Q?dA6Es+/S+iyk4o/j7t84ELwizyXfwCx0Euol+BRIsYyDGuyYldqrjp7sxZan?=
 =?us-ascii?Q?gafkyr8DYXFwrjYKaAG0wzORVHhWXkBErGvZiDCtAph6ml0VyVyI1qGZ3btW?=
 =?us-ascii?Q?HBxxO5gKkFr3ShzKwBaaOfjRRaHNXRLrzZc4lKjYZvaGbwbvBfCq1t+MmEjZ?=
 =?us-ascii?Q?tSRyUNMpKlYpJy6FuqspB1HtmeLUZh2jJKu8YGmv7+kZtdsGzSl1qdfMIIWm?=
 =?us-ascii?Q?isx+pARiTNTbwu7qqvPXYp1EMQabUzn/oXbGXNAn6ED60UWypoNMSdjSCXwN?=
 =?us-ascii?Q?3oYchc0nXkT8XXGdkeqAomBfi2nxZCDlu4XCaQnkYXvWCVEv4RnD/xQ/9EGa?=
 =?us-ascii?Q?bTJDACUF4ngUuKBmnhqOfkn5UwU4dPzKITUzhLSytesQW9IGbY4y02KqiyPy?=
 =?us-ascii?Q?kMkLJRkpVnxL08o3iu9KDRCxTT/xghe+SuVRMl1fTcdIO6XOIx7dBxAqxdZ+?=
 =?us-ascii?Q?s443iu4Rz5bZ9ob2Mkh9ossl90WV5eCyV5Ly43HHwSSyfEVtmzxAbOjPkfr1?=
 =?us-ascii?Q?NlotHYI4jAp9DB3vWwwzyQGHBI9tnkiKRlNtyAoNpsXo38OjNDghwNzG0L/G?=
 =?us-ascii?Q?AOd7CkBtc+VvvxxbYuH/Ek3L2xC2OqR1E7j4/kdFabXr9SwpD2vUcMm8OliN?=
 =?us-ascii?Q?icwFVgHTOgrql5Z/2JZyZYq+49nGCmmhHJkQDxox4jzKf4mO+MUaxdtFSxDz?=
 =?us-ascii?Q?c4ewYfcRkJ+lSNPYfVCzFY95qfoxE13fQvs6yN0V2y1F1MM5HRvLiO7bKybG?=
 =?us-ascii?Q?QXFM+hhDPXyEMDbF1W1CFx/g5YcURBHDh/WAHVaz87d8FJ7QSy50p8joOZTO?=
 =?us-ascii?Q?0Waii9AX//renJqVlu8udSKBIAc78WS7yfdld3VgED1w+tSdI3qlwWuU6YC/?=
 =?us-ascii?Q?fSjNeZIWEHwAQ9QJU42AEcLQRx1yE8tjcipNHrB9j7etXzwReX2/vVT1VpYD?=
 =?us-ascii?Q?+D4y4l711/ES0jnsMkLn61Joo8J7ikQKYCsbz4LilGzNG0AzkpU6k6btOXtr?=
 =?us-ascii?Q?Mq6QJg6o0+17zKyICPPZmyY7Bbls0AAJvaZaqIG76lSt9zzL07iEmacpcHrf?=
 =?us-ascii?Q?YG56k2olASKtR/BulKAP/FmisRz3f2gkZbmehRb1x2atU67npwPgcNV5Em3W?=
 =?us-ascii?Q?+XEzZdu1u0pc4fjVFAhxIAStyxrpH61r3gDYM4I0UdUoHcewHRDhP6swX7pM?=
 =?us-ascii?Q?3ho42XSQ/eWrSgNc29it9g2jCYuwKPtxlnMuUCRaW55+YtGn2BK0vRzeyC1K?=
 =?us-ascii?Q?XpUQo78n8pqpnM63uZh2j2y+nGY2aktE4hevBc6Cr1UyKACJaOKAHITobW2Z?=
 =?us-ascii?Q?mQSzI3QDshA622zLxIOWF0NV6gcLJzW/fUUfyn2XxzjNGP7XHcBXB+Cp3kx5?=
 =?us-ascii?Q?tpfmfpU6t7P53Z/pK55fjiuwyUhdjUW5xAI4UPKJOgTKjwRmeUOIEhOogDOj?=
 =?us-ascii?Q?XrrEte9e/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90076819-0d10-4e77-4345-08da210577de
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 06:34:19.3755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHvqN2sNg9VT2D05GePT8hgMngxGQJyQI4iWN4GFXzTdU+CrIDA2So6UTu4N0DEbHaR8RPY8HlF/SZ1ZPWG7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5453
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, April 16, 2022 5:00 AM
>=20
> Hi zhangfei.gao@foxmail.com,
>=20
> On Fri, 15 Apr 2022 19:52:03 +0800, "zhangfei.gao@foxmail.com"
> <zhangfei.gao@foxmail.com> wrote:
>=20
> > >>> A PASID might be still used even though it is freed on mm exit.
> > >>>
> > >>> process A:
> > >>> 	sva_bind();
> > >>> 	ioasid_alloc() =3D N; // Get PASID N for the mm
> > >>> 	fork(): // spawn process B
> > >>> 	exit();
> > >>> 	ioasid_free(N);
> > >>>
> > >>> process B:
> > >>> 	device uses PASID N -> failure
> > >>> 	sva_unbind();
> > >>>
> > >>> Dave Hansen suggests to take a refcount on the mm whenever binding
> the
> > >>> PASID to a device and drop the refcount on unbinding. The mm won't
> be
> > >>> dropped if the PASID is still bound to it.
> > >>>
> > >>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
> > >>> allocation and free it on mm exit")
> > >>>
> Is process A's mm intended to be used by process B? Or you really should
> use PASID N on process B's mm? If the latter, it may work for a while unt=
il
> B changes mapping.
>=20
> It seems you are just extending the life of a defunct mm?
>=20

IMHO the intention is not to allow B to access A's mm.

The problem is that PASID N is released on exit() of A and then
reallocated to B before iommu driver gets the chance to quiesce
the device and clear the PASID entry. According to the discussion
the quiesce operation must be done when driver calls unbind()
instead of in mm exit. In this case a failure is reported when
B tries to call bind() on PASID N due to an already-present entry.

Dave's patch extending the life of A's mm until unbind() is called.
With it B either gets a different PASID before A's unbind() is=20
completed or same PASID N pointing to B's mm after A's unbind().

Thanks
Kevin
