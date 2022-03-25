Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF624E6E21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358429AbiCYGPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351777AbiCYGPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:15:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF7B33A15
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648188827; x=1679724827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G6w0qxBV2FNkUidTWzHv5fGjlhEvyLN23eS6nx+2SmY=;
  b=LIPUYEHsyXJ0F6Gxf6lU6jesoN8MUmbXQKJtWeu/BB6bCZT+Fq/ASNZ4
   LJbOve3ydBCA/s0Y1ZIU5CXcSlIrx61qKX9dg6WncFkUud03NvTE/zC+w
   i6iRTpHmibNSZMUusRV38yEQAlwwRjDsSPVQM1SrP8AL5tNcy+s8NLubP
   6EOJgUHLvrUBpE0x0+AOFYpHprltmnSs06yVWr2LfO0v9ZBvaJ7xH3UEM
   rxFjRDCJwq6xB/yZ6M/rZxrD95AykDYv+9+FuHqpsNPbUuFVmDfCpy5PO
   J2eGd+hDWv31JXRyBmqKfMYDwe64VFOJIziVMHijCPt7i0OaB1eSmrDtF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="283431096"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="283431096"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 23:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="601951459"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 24 Mar 2022 23:13:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 24 Mar 2022 23:13:46 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 24 Mar 2022 23:13:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 24 Mar 2022 23:13:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 24 Mar 2022 23:13:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIRHnsGKJM0hqesyKPWcMQTVAopRfnozkNBnZT62UiTXBNRMeu2RQs+kfotX55iqKBL1hCwLqlW7Izn/gum2HX3Jm1TxYkUkoIJw/u9UA9DxPEEnK9W7xpvYkwQETs3wuvxIbtX9y1LwecDF5EfS9bVu74Gzv5OAAloa8nmv7wetvmFRIgE/2NcJCiGVlV1yly7jgbRTzP1mHL6CahiGdBAqbOjOv4siS/805DjY3hjclu+R5EWV+HF/38YH8A5TqgsmMUuSneJIVH5WCueAUGT/vA9h+wT8kPu3iAVwKwWQOZACeLRA2up3PadVUizHU3dq/ZEpBjm7oAlwZ8sdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7dLnZTrHYkZ8/VCCLSC2gWSgFJyqeO1U0zP1ozTYk8=;
 b=FT/LBNiGK0EGG9ckr/BJkCwf0TqTwHXbR9sycL9s4JNmKrra4RNwOoi9szkCetaDqKCyKoBkxnTtdGh7pljjTbV4ZZ/teSQzfggkm48rvCTwCN0r7COTWNWQD18Mde4yP1I8rxfTtQBesn5R9iuZwodoMArfvHPORBZiKYGCBh4ede20JKzZcz6n0606BZPKyQsLFfuj6NVTGAMl6r99f2gz5pXM4tb2hI47Tzo/ZWQ9ln+lUqJ6TvTpgQ9HEmlj2W9GDE0abyNLWKnihTp2FuBVQnZcYexBfuPaJosOeTKaHKi9+PmxlgIKPkC2zrr6lYx4UCg1yk4xNLsr+pZ+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4895.namprd11.prod.outlook.com (2603:10b6:a03:2de::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 06:13:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.018; Fri, 25 Mar 2022
 06:13:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     David Stevens <stevensd@chromium.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
Thread-Topic: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
Thread-Index: AQHYPbc7YJqxtY3XIkKe9qY2q/ald6zPnLVg
Date:   Fri, 25 Mar 2022 06:13:43 +0000
Message-ID: <BN9PR11MB52761E41CAD28CFCB935688C8C1A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220322063555.1422042-1-stevensd@google.com>
In-Reply-To: <20220322063555.1422042-1-stevensd@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e67d9712-6dfa-407e-133b-08da0e269d65
x-ms-traffictypediagnostic: SJ0PR11MB4895:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB489529D2C3B09B137571891D8C1A9@SJ0PR11MB4895.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vb0hhteSjVjpjWyyikSyCnCcBvOC01mxtosL/tQD5wz494d+bJkUfm49JdOSZDV/CiWvjnTfoUsThMXNqVZTfiuD5UG+X/gkvAmtA8X9tyqcLX/x//3+0BBqLmpDsl4bIHoobCacUgNV4CoZCJVGiwmUDsO/Nm3pXl2slpz5dLE757zvknie1ReWl2ArrYdsavrp1tCikTGG70S9nLTgDTzE5kKkFdZPIfYjAFBtWDw08F5FQgqRSJPL3I8EuQdVb44T8lnvD9MZGXyxjp2tKXHJHUjL9/QaSijRtH8HTAl1fir4lupcNvQue1fwHaMAZIbzHEOgoTcgEQwP4t++WP7vizhSFGSqJJfaI6voINLBjBGEuX1z64AwkJh6oAV5z7ts4+6p7RcOV86e59MlBzPkA5kYeFnDklfUolGut+EHexAhaa650x3J4nme9+ap2QLVIwz05Z/Y3txJGQB77I/cUWVwEjqA2Wa5brjMyTM+tV5Ejt+nu3n/BOqvQKXUtpzgPHsdxtgVTO8Yxg8zpTfF0Y6WQ8Pg9K6oCy4ncbLodOuIjv/e8egZbF/9kCBUrCYyH1k+cTyJeG/evfEx+r8pGNEyxJui4w8E9Sxv8g2D6JeX2uceO4KYUR/YQwvbgaj6v/MLsb713+ze2bcXWdBVWHMRbUclWJF9dyRbI+ZpSrVGK61e6tkyXrNi1ZHhJt2P+5K65gcJ1Ic7Of50PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(4326008)(71200400001)(66556008)(8676002)(2906002)(186003)(66946007)(64756008)(38070700005)(38100700002)(9686003)(55016003)(316002)(76116006)(110136005)(54906003)(26005)(66476007)(66446008)(83380400001)(8936002)(6506007)(122000001)(508600001)(7696005)(52536014)(82960400001)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7XQ450Ilhwo895RCKDENtNy/390jnxfsHce3zqqG0X092Uhvg89f4jTovbG+?=
 =?us-ascii?Q?lXusqycF1+UnLq2j+VimcM2eWiULNZmysjTpRw4XIlvpQWulwVHtaqHMPIfs?=
 =?us-ascii?Q?K0kpMsOH7zqkrnAD+MCnfpcMWk3jr+LSQK9qujtBUR+iY1AAuu6R4gRHIJ+/?=
 =?us-ascii?Q?GkcKQd5DBLoPDus9VVj83xpLh2l1GP6FRYpf67RQyjul3FsV7u39eJGX26sG?=
 =?us-ascii?Q?cbShs/semlxrYE7i6E14OkjYlcAwhuREi8yzD6LhaEE2YOFN836jCnoUOqQ/?=
 =?us-ascii?Q?MRVXr9J6PZY7Zqv4c8aKxpnNj4Eko7nErk1rwHa5L1dCY6TOPeTyaEtKfkDg?=
 =?us-ascii?Q?i/KAnllCk0lZSIu/l8ILsSZaHlSVBnn5UqHFRY3Bkln/I1I90vs/ST9cyu83?=
 =?us-ascii?Q?jQTFngaE9op7AluUGXHCVbjMVBgyUjqRHziwoRsI2RdfwtRZjenpJt0ha0ZL?=
 =?us-ascii?Q?ak2D+TeJK2XFJW/S3pyeqKXRdO6DN75PfSIW8zCxOV/J84zsZL46RgZ9sCW8?=
 =?us-ascii?Q?yqADuD293I80mh4a1R5MfTfJFkfN2wucds27yiM8hrjnfUfQfTmpyK74ue8L?=
 =?us-ascii?Q?ju7ktFE2njdNulzl8i/Uq4GOLDBgmhR6w/OcxspaNbT6ArbdBVm4eRB4rIlg?=
 =?us-ascii?Q?gZm/5we1A56L67ygbJ2nX6clvRIsrH2R4y1jpdGW+e6jM09z8XD5aHlRgPl5?=
 =?us-ascii?Q?e9SGeFoOnrqNmM2KVE6EQ3DMCcTmdl6wcIRi0LZTmsQLjgHDkkRU1Pi2RdUF?=
 =?us-ascii?Q?rdoDJHja8Y/wlk9DVVa4qrJHTHKg20mz1BzswHI/3W02VLsjOHqG8C7dkLy0?=
 =?us-ascii?Q?REQh593Ygsuw10QZcz5AgdbV1KXc8niPlNAJECWwjw5umEv7VKoFGVsDddpf?=
 =?us-ascii?Q?59ALfY8K1gRfIRHoTP+vyCBf6X9WDyZnqEwIlUO760WytCN9R7dusYYLSg9J?=
 =?us-ascii?Q?TJeHo4MKHpG0cEUGL5Yw+3IqLGoFp9FBzHGFDYsgUB9ueT6qdA41QFNgRh68?=
 =?us-ascii?Q?+I17lYhmfkq13jDSWyY4gmuXosIlnZKxhAKIrb7Pi4b79E89Z06X8J28xXAb?=
 =?us-ascii?Q?uJi6SKG0koMltSibiWItNj4eZ2yIB527l1OQiy/y2z4wIPlaLYkP3LC+Hp0K?=
 =?us-ascii?Q?dC1Y7FalTqkELkb1w/utWcjsdGoXHlIglBwe1T3K2MROaE2vVr7mvdasboc0?=
 =?us-ascii?Q?/b3rBl6ALSs/X4Q+nNcbl37+l53vSgCEGl9r+FZnvguj+VLrCb1sFxmL0H/b?=
 =?us-ascii?Q?6ktrMbMDcPXXulHqV/n9yKWPbeT0U5wq4meF0Grsjam6kX0N2tcy26g7Kagg?=
 =?us-ascii?Q?Ug/tW01EGVv+4nfL+IzhRkfXijvPKdSW6UHob86WaRQ1xUddVHsG4zzF1YIq?=
 =?us-ascii?Q?A2PffAzZiYctIxzP88YeTjUnGjIq0iXPQS6c692OOT5W4rZ1xWm75DdT05PR?=
 =?us-ascii?Q?sDrNoobHlQdLCR+fFUpl1nrwweHXVtvs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67d9712-6dfa-407e-133b-08da0e269d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 06:13:43.7758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeB7ZYd18aefY4X+UXmu5e++pA0rQ4qGPGbNiXWfvXtbRdqirflbwaMbVjrOYuI0EyQCV7ktuC58Z7z1d+ruTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4895
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Stevens
> Sent: Tuesday, March 22, 2022 2:36 PM
>=20
> From: David Stevens <stevensd@chromium.org>
>=20
> Calculate the appropriate mask for non-size-aligned page selective
> invalidation. Since psi uses the mask value to mask out the lower order
> bits of the target address, properly flushing the iotlb requires using a
> mask value such that [pfn, pfn+pages) all lie within the flushed
> size-aligned region.  This is not normally an issue because iova.c
> always allocates iovas that are aligned to their size. However, iovas
> which come from other sources (e.g. userspace via VFIO) may not be
> aligned.
>=20
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
> v1 -> v2:
>  - Calculate an appropriate mask for non-size-aligned iovas instead
>    of falling back to domain selective flush.
>=20
>  drivers/iommu/intel/iommu.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5b196cfe9ed2..ab2273300346 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1717,7 +1717,8 @@ static void iommu_flush_iotlb_psi(struct
> intel_iommu *iommu,
>  				  unsigned long pfn, unsigned int pages,
>  				  int ih, int map)
>  {
> -	unsigned int mask =3D ilog2(__roundup_pow_of_two(pages));
> +	unsigned int aligned_pages =3D __roundup_pow_of_two(pages);
> +	unsigned int mask =3D ilog2(aligned_pages);
>  	uint64_t addr =3D (uint64_t)pfn << VTD_PAGE_SHIFT;
>  	u16 did =3D domain->iommu_did[iommu->seq_id];
>=20
> @@ -1729,10 +1730,30 @@ static void iommu_flush_iotlb_psi(struct
> intel_iommu *iommu,
>  	if (domain_use_first_level(domain)) {
>  		domain_flush_piotlb(iommu, domain, addr, pages, ih);
>  	} else {
> +		unsigned long bitmask =3D aligned_pages - 1;
> +
> +		/*
> +		 * PSI masks the low order bits of the base address. If the
> +		 * address isn't aligned to the mask, then compute a mask
> value
> +		 * needed to ensure the target range is flushed.
> +		 */
> +		if (unlikely(bitmask & pfn)) {
> +			unsigned long end_pfn =3D pfn + pages - 1, shared_bits;
> +
> +			/*
> +			 * Since end_pfn <=3D pfn + bitmask, the only way bits
> +			 * higher than bitmask can differ in pfn and end_pfn
> is
> +			 * by carrying. This means after masking out bitmask,
> +			 * high bits starting with the first set bit in
> +			 * shared_bits are all equal in both pfn and end_pfn.
> +			 */
> +			shared_bits =3D ~(pfn ^ end_pfn) & ~bitmask;
> +			mask =3D shared_bits ? __ffs(shared_bits) :
> BITS_PER_LONG;
> +		}

While it works I wonder whether below is simpler regarding to readability:

	} else {
+		/*
+		 * PSI masks the low order bits of the base address. If the
+		 * address isn't aligned to the mask and [pfn, pfn+pages)
+		 * don't all lie within the flushed size-aligned region,
+		 * simply increment the mask by one to cover the trailing pages.
+		 */
+		if (unlikely((pfn & (aligned_pages - 1)) &&
+			     (pfn + pages - 1 >=3D ALIGN(pfn, aligned_pages))))
+			mask++;

Thanks
Kevin
