Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A0A48607D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiAFGNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:13:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:8810 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232043AbiAFGNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641449585; x=1672985585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/1lNWdAgD9bAwI14d+YBmwDpRfL0PNYw8IcHDYWnkVU=;
  b=fFZ967VfiXoWj672aEMpnWetn/QD8tQFu+UM6QE/PWUZ4+hS0x8nZJwP
   xJwFVy+8zETKRDfBDniIiFe3lBYd8ya4poTWpEVsTvHGUdH5y2Oy1VQww
   WFVZxMFc7wNYqqr/DXcnpAONzARSU7jqeC5vKuGIsgHuXqcKIfi++ih3G
   7hRKu+WZea4LwbiWacBi7w1vTwd7B6h10xSQEuRRuLLX3WGJBtxsxFnH8
   E4je8NPEhvYWw/0beZ0YBmE9jKvmrMwXBhID8K+lvcqFLSMbjV0Cj3hv2
   8kejwTvNYBo4bc/tg/b1Q42+e2M+5AXlzhDf1N31Y66YQJR1jRQsFyiAJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229411518"
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="229411518"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 22:13:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="618229038"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jan 2022 22:13:03 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 22:13:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 5 Jan 2022 22:13:03 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 5 Jan 2022 22:13:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3gj3K3Qs1hbATHFFPvcIRqoihcMxs4sNVxWBrz1OImp5ls9+Bm9N6xQXH+PKm/50WeTY4uWF4jqOmV5AARCYGF90iFKqkcKSTHyMiNsS30DmzgTW4iXnhZYhI+0n3GEDWpQZyVtWUmEPIlewCJi82g4pT5P6SRO/K/Tnyv0w94GXJwPCOTUIFBPmgWbMu+85/TxD05Ihp0Edn9OVo1G6LsDYQqaYRjEpMTqsZoIBEdaMdsML5bel7BNsGgdX/XyRJXGfqYQbrNFkn2R5tjUrGN+LqZgPLY7Gv92zesBTRfK7TJ7ofu8ALQwsHWt1rhh9I3/jAekdEfkJxQbficeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1lNWdAgD9bAwI14d+YBmwDpRfL0PNYw8IcHDYWnkVU=;
 b=VokPWbq64qVkewrJ6ras5azQpzOsfJEfqp6TxrvvXH63j3ODPmdwOfpV4TTu649r1CV7d5NKKcWrE1Izncsk63OuLK1YsdhM0b/rFDNFrw+wHn1X2+Qulxj8YZxsIzmgoemTBuXDko2iCXeMliu/GSE0Ky7lP7/qtiGgYneWColbu6myJTK+nK10MT306oG4Od+kEooaNHMHQJbXWlJSbggDKoMDA8T9YT4VH0EiPL0Pc1Oml7uOwCHUr1b0p6y4EeHInlTSv7Z1U6HvusGh7McZdvBrLgk34jtsK4iK2sV/x1d4TVtK5FjSA3hvqZc9lJgrQU/R7PPF2rcqRm7fTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5781.namprd11.prod.outlook.com (2603:10b6:510:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 06:13:01 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7%9]) with mapi id 15.20.4844.017; Thu, 6 Jan 2022
 06:13:00 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v4 00/13] x86: Support Key Locker
Thread-Topic: [PATCH v4 00/13] x86: Support Key Locker
Thread-Index: AQHX8IXgPtLMRzOkzUOX4xWFKhqGg6w0Uf6AgCDKzgCAAHjSAIAAEj0A
Date:   Thu, 6 Jan 2022 06:13:00 +0000
Message-ID: <B67A9D30-2FC8-4AF7-957F-5A90D889142F@intel.com>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
 <YbqRseO+TtuGQk5x@sol.localdomain>
 <4101B942-6327-49A9-BE8B-9E51F0427F50@intel.com>
 <YdZ5HrOKEffBrQIm@sol.localdomain>
In-Reply-To: <YdZ5HrOKEffBrQIm@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4d9282a-5a89-491a-f4c3-08d9d0db977d
x-ms-traffictypediagnostic: PH0PR11MB5781:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB57817C75E166E231327DA2BCD84C9@PH0PR11MB5781.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nP7qoHWjlcal9yYPNZfMfVbNg2d1W8f4qGITcK3ActdZi5+pQxRv7zcPYziLR2rDllDSHPjnnDzrfsAyeYTf6GfNQO0ypxUjYnRRX8ZItvxmoDpzqWWrHM+9XtTf8hMVS9H0LAN61cvBemqkcq/iaOZIGsrnA1i5kTKTP39d3NJw7j3bGQO6ml6C+5yBq9gmqEpcQZS4NXw8r0jivsaI27U50NLoNPx3SZIKDynjQGiLCZdvhNCnRhcvIhrpeF1Egw1UXENkbm1fheV6zpkZ8O4FF6IULAh4rHwlfBovpq0tqXgfjhOdGhcHrgOMZWJJQOGsfrgqMx3AyrHjhkd4U2u/Qll5ALFYm/Zv8bQ4VhWIDnoq/AzXCPedaSpe7f74t2WLaHrJdSDjfv4Ff4LAQWHBp5yvhu99jQW/PeU3/7OcVcdkvNAZgc8bqEeHpifwVDFOa0GFPdDGeRl0VBLq4eBnJZnm8kJSnxf30IS2PAgy1o/xAMFdkaQx2kgiHuO1tOubnrn8czp7R7fXimIyZ9kFaVydgEkQR7eIF9TwEvwEuXUF1cOiDSeLFBlSlVQEiwHo1zFVVJxKCSzc3eQeHL4iycvENZa6WySRvwhqXaQ4VqQIQg+CTsLdaEn1fqYpCvaVzlOdS0t1ius867J+Sf/ajuDPA94qdSWmtj5iRToN4/sPamMtdt2U0+oFiUPiyQKrBP7h7BwHsrMxULm0PSMBe1I0Bn46Ettn0xAr+OpRaYNXX9LqBP4+egy8BvP+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(38070700005)(33656002)(8676002)(86362001)(71200400001)(36756003)(6916009)(508600001)(66446008)(5660300002)(2906002)(76116006)(54906003)(66476007)(38100700002)(83380400001)(4744005)(66946007)(26005)(186003)(66556008)(53546011)(6506007)(82960400001)(64756008)(2616005)(6486002)(7416002)(6512007)(316002)(122000001)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZZ+OvV5mUFkbZ+CvJZ6AyM4L43DO5sLkQs+vArEfrRa5CIBTwFoYO38dHBwi?=
 =?us-ascii?Q?Vg90scRIx4YT4guTZ/dn2JVUGZgHT+2EYO2KrLdMFh5GiJCka4TzQ34EjH7e?=
 =?us-ascii?Q?4U/kR2Dhm5DwuvJ0C0BbAU/piPLqpWnYsmB2+c/CMlSBTSD3seYuqdD+FAqx?=
 =?us-ascii?Q?WlfKCIPqQvx522RWFBzCBCA8mYzBlGA+0V4CfMHtDdis8Jx7DxJL3GR/aMKE?=
 =?us-ascii?Q?qJiX9Xsitljf9wj5DNmgzRU1WprttSsHtt3kfuugCuqe/OXffHxTbG74Y9wB?=
 =?us-ascii?Q?KcqpETQva6fKrfU++BcyIGgigXUdnFVV5L8uEqrXOTYvQ5rxt9hm1NpFNxMB?=
 =?us-ascii?Q?uVETs6bk9Yq0nz+7FjcSuuvCuD6hJpxXCMWnEeoCrDzUqsWYgxL0EOuuyqVd?=
 =?us-ascii?Q?UWCiPCnC+ThQMw1TdN7oRnjgA8f2mQPLUzx/uC/oFTk0Nc2BnDx8RrHxT4V1?=
 =?us-ascii?Q?j2zRBfX9SJq6E/ob9G1FAhqx0ZiiMZSljKpRoPNNW5ZjLKBvIFocbZ9z0x3L?=
 =?us-ascii?Q?rNRzzUudTCrZckJ26KBQeruBPF/USURBGp6zVW9++thyc3dosU6FpUtQpZ8a?=
 =?us-ascii?Q?2CERuqKodCPNqOabXSxS9FP1DR5Pj32XVGekengl1i9lqY1T2i4z9zFuKmO8?=
 =?us-ascii?Q?oxo4KGYQvpw9wV3FSn1jV7xWaNZaKUvnnltlgYI1CtvsAYEiwkKs2r6kXlIM?=
 =?us-ascii?Q?dBTypP10B2YF/wfD4YwbcUsbqjQSRlXQM8z7hFntOtjEqoeczr9qpXVIm0EU?=
 =?us-ascii?Q?aZZFBym71GOUxkXB8fvwozIJiqeHseQdwQGPKmJAoKwJrSNH8mYQ820itAQF?=
 =?us-ascii?Q?3oSahMQWmWILf+GwrXX2NPLNCqPyZElXQfDlTdut/vARk0rMkpnnwEzuupeK?=
 =?us-ascii?Q?287pfgyFaYYrq0HkcHBUo0oQAe936BwEFZMm7LX6njb3Ri7qTuW8T08OVlIC?=
 =?us-ascii?Q?06bx1l08xurtjOBpXmu/XpDLLi8v0ZG1WlL2UvOM9EaAZpo9pCeKOaeQ9ek3?=
 =?us-ascii?Q?RnOsd5cQUVK22mR05cpUMs6IQ/O03SBl9YEJPM0GKgHB0DF+ZpFmQYni+gC8?=
 =?us-ascii?Q?EVU+5J2idQc2OY8meRlI4uqXwhysmLMtmNLg5C9WXS+zZ7M4a+j2v2hH+5LC?=
 =?us-ascii?Q?y2uWx4/FkorvIzEzneT4fgCqpqNTVDG/3odmJeIcK25mAoaZioV4kwpe02vZ?=
 =?us-ascii?Q?XqJ5S1XQCEgXRdqfu7DiZbcxXqyHcQAI3E5F46U9xypx+3eBkIfkWrvzz/aH?=
 =?us-ascii?Q?yWPM5Gn0ZWEWkBAZomgQLwB1Rt/S9J9I3XMvR9nwnSZ9MMp4rfOR82eBD+d4?=
 =?us-ascii?Q?fl1uFPJfGovvJ5Sf6g0gwQURaeYle6xfM7nxrq8yjtfTrwGXtdnbzGrPvNIq?=
 =?us-ascii?Q?eKIWseWI6+iq7qi5VXI+u3nMykuers//4/SG3k4TXVC4/fKnRsPZgV2y8dCu?=
 =?us-ascii?Q?UVA1FJRMwogRadtg/oGfTazeMLkgoY3aNRS9UDRtWPp97EUuT0/7XyYPTkDi?=
 =?us-ascii?Q?af3pWsaC8C1f03AILgnknyhAV4WSmdBfsPIZCnwBA7WJOTw04WddIPsrrFf9?=
 =?us-ascii?Q?T/huSffsvvpVUk2o2STEMmnBSEZ37/tOgpeVtU0v9zMKmp6vXzHUzDUomhw0?=
 =?us-ascii?Q?NhdgFcyzXFBiYp1HANlm+6Jp9829pCzFbCG3DdmBqiPJrtEVu1WR9vMBHOi/?=
 =?us-ascii?Q?xKz7V2S4IRDlveTBbNeATCrhHqU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <650678EFAA8AEA4EBF93642644F856B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d9282a-5a89-491a-f4c3-08d9d0db977d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 06:13:00.6108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sD1v3mVU+yDiT9v7LQoLQfNKGrsTxX2OQt9x/BBiccz/durOGqfaKqRIK1uY5pjxAIa4wz1U4sfd+e1etThSfvcnAgLxQl+vCRB6CNsNrpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5781
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 5, 2022, at 21:07, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, Jan 05, 2022 at 09:55:17PM +0000, Bae, Chang Seok wrote:
>>=20
>> As long as it is factual that the mode was once popular, it can help som=
ebody
>> who wants to use Key Locker for an old disk image I think.
>=20
> AES-CBC is/was usually used with ESSIV, in which case the key cannot be f=
ully
> protected by Key Locker.
>=20
> I'm not sure you should bother to support legacy use cases, especially si=
nce it
> might mislead users into choosing a worse algorithm.

Alright, this is not that critical as it will be possible to add this mode
later when needed.

Thanks,
Chang=
