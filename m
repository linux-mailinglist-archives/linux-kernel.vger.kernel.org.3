Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BDC504CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbiDRG7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiDRG7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:59:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E5165B6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650264993; x=1681800993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zEcOUkoNPp9cmzKVRlgHSy0ZBq/Fk3p3WaDgRtHycUk=;
  b=f/k+9WE40u6Lw+RcWBrABNeD6Ny8FU1JTMLKHWRw1fvIfVtHSqQJLyQ7
   s+TWriwbHqokHZ4/dxu5oSRIOcHEsCVENlBEp/C2lfPH2gZE8pKkaScOB
   FIRPfYhEgvr7qGcs7aLE/ne7ZG7Or2b8fj6gmBvxMw4Dkq6HZjC7dCt+V
   80KiNKCZIW8jsmePZNqvEWX/ByOAsL7M1vSyQe7Q79HH0tuGmWPiyHR1h
   PlGu0Zz8BFls1ZUMF7TQaKCJVuueKCel8mupGk89paYxT3kL5V2TaTHID
   lGrcjKGbJ70QqKh57BAjzZuW69akEpgrxuOS5x5eMwefOYdhjmiCsNhuz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262926719"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="262926719"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 23:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="528760018"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 17 Apr 2022 23:56:32 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 23:56:32 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 23:56:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 23:56:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 23:56:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj8NhClRgCMWvtUkFiP89Z4/4Mv5ymRR/QCeprqD1Pjk+Ju4ypndXKkaA1k6P0QrKaXVCuiIYk4TwBAKy2O9VAMRgLyo5IGaWAmucCTyRlPQWqwpbxJr4AvBxKkcwUCbvH3RObOa/bT4JbyM7I0WTs1ROf0SaEZf9EASHyxL69y8nc54MYRPGfX6spmWyvwJL26+cD6tSclxhNtBNST/sPzv/hN0c/1WWsYJKDcJ0/RbyfqaKHusX1c5sW1b4rykE6xCXsWMpB7SUEogU4TmBcZhY1C3Gaw34bibx8BSpWUUWR6eEQhYOeGx5mibvkhXh7qu8FEKxQcLvKq2c6Dg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkvH6WupurbqgMawe9OOxZgspwLeKuRmkgwpg3eVFi8=;
 b=nPl6vzhJtUz4IWazEuzq8AuqHGTGL5Hb3olGJXzDXimiheVWJWTb32eqO9DgIHfTScGubhFI/4d/OS+48lAXL+px48FhmMrmEG2cW4oXs2QIV+D/1595w8NKm8LyKOYvl0FFO+kYLFZvLN5cf13h3dje2p3a3Ug0QfOPRTdFn5twrt+MN0YakUB+5gHU3NKD3kCN7ZJ7ljQ4IXQ6ZAm144n/odzFgsQCoScR2gPje+qZjtZH6cWPbo/+eltJVaD18Uzv3HfDJMAPBPF+zk0Ij3e0222zzKTNWPWSC5F/rEbPtGyeQb4RutMrWjmiAV00PDJqAaytX0AYJVM90V6G1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4736.namprd11.prod.outlook.com (2603:10b6:806:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 06:56:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 06:56:24 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iommu/vt-d: Set PGSNP bit in pasid table entry for
 sva binding
Thread-Topic: [PATCH 1/3] iommu/vt-d: Set PGSNP bit in pasid table entry for
 sva binding
Thread-Index: AQHYUY4xoku8wzlx6k+6woIzZ5zzT6z1PxRg
Date:   Mon, 18 Apr 2022 06:56:23 +0000
Message-ID: <BN9PR11MB5276A47E4013FA692C7560D58CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
 <20220416123049.879969-2-baolu.lu@linux.intel.com>
In-Reply-To: <20220416123049.879969-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e20c112b-8fef-411d-92f3-08da21088d63
x-ms-traffictypediagnostic: SA0PR11MB4736:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA0PR11MB4736C158A330C7F83831C5AA8CF39@SA0PR11MB4736.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZhpFVNvH9+/xSytqkzClDlxbwI8VQ1AI74He2po40te1mj1MQxTeSqVjT8/DXlOi72XB1tRY6Qy1srWsLMQKuOAwIoTSTQIiawYhMXMpMhhpyqasA0YVhR79WO3OBw6+QWrvbwSMRWcaAK4h1aAxbYbDLARhcyNyTGBUPEJ2ALjTIqHVKZcbqNRfqf4/ahI3mG+CEqcd4us+BhrIkAdkyYspwNz2VdDCHUIQyEU8Qm1SiDyz1pFVRSkqud4S/g694hw7wb638xj5Y0wG1cXYP+SRkx7wYQG80EYvbrHZQCvcHKojo8lcPzVcc1ljbDP0UwsTE72fyb9+KDr1z1nVWibWatu2B7N1F78r0kjmZOq+/4VMfl3ZffAMDSBk5mWZULRZcoFd9PLSb7EUidaZAloOrCmyMFaRJSwsXUX3F9D76GWXUBZhcf6tLBmba/x0NI4FzjyYfP5tH0vPE9mMOBK3ETWd2TyQVkwtCM3/Y+I8iIBWzd+xt+esjU7030p46jxcskwHntMo7LTqnLY2t9gbvntqZyY5UXl06pnE8sp5Go8TEnYRS9ksMM/Zwyrx6VWFII3aPublrfhdoaBqR2vgRgT6VoWijOsg2oISzsGQyMyg31d5XOPhCRQh52UIMl9JdRMHdSBC+CzKM4+T5K0oXml6gCEgutO4XyD3msBN7bBabvw+mjEJAEs3o0OU39UcbE5IH9tJbWndTQQEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(66446008)(122000001)(82960400001)(8936002)(5660300002)(9686003)(55016003)(86362001)(2906002)(26005)(52536014)(38070700005)(38100700002)(7696005)(508600001)(71200400001)(6636002)(4326008)(83380400001)(316002)(186003)(54906003)(6506007)(110136005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?19DwfbeJZpM5b8XhXWq7mR958hkjAkgg+18ze7lVZqaJuIHR7vkgSklGtTxB?=
 =?us-ascii?Q?sDTMM2VCLWHPpfQo9PL4nYvSeyBX6HdtrpZpTZq3ww9HeTKFOlQ1LNTdwu/z?=
 =?us-ascii?Q?rI2LjLAKs4i96NhBR6ScN4peQV1g6rFLvpwM+YtbCwreXWvRKDxotBnApGS0?=
 =?us-ascii?Q?7c36WKQDSNkQuwwRgw/x9sulaEUeJiGKX05kRXLquo16ou2P7l9qdUuaSmuS?=
 =?us-ascii?Q?/cYP1tlwewnugvW9x5LfUPBaVqdswnuUYF8rz1oP9QI5gHfZ9nA+uh+r2H7U?=
 =?us-ascii?Q?x71AztoHSIBQiyfKVoFHFRWg2wc2/SeUcUFz2TIf8owpRJNweiMkr053wAh+?=
 =?us-ascii?Q?40Z9LphNho9MPXwKStjPFCK/xOy2PAKJ3369S4gP2fctxx8rpUxSGHcUevqm?=
 =?us-ascii?Q?MKV4fMOkYLl233zj0r81Y9LLcbRwEiSCN8Ymff5tEAZ+o2Dp04GHK6IfnWmB?=
 =?us-ascii?Q?0GWDdCX72ELna4ECZopsYmJOUhA0IWyB5HYVdvfdhAk8klARdPg6ZJ7f11Bx?=
 =?us-ascii?Q?03teoMerapV21A2OSMrDP9Wh77zCYjnRfcfLs6+AbVVJ7CSh/AUdYVUkFdR9?=
 =?us-ascii?Q?3J4HDuULuGaLIv/Ja5icRHWuiWjubPD/9p01Rd1g4jx3p0ltxDYipKvaW6zO?=
 =?us-ascii?Q?rgAO6BOZ6lnyuAXnmJXo829Ii1/MM4m4JIx0gjG6SrNFf9IG9R2jFxT54Hzt?=
 =?us-ascii?Q?M70PKgELtOhxpo/SyXVBA+pRgJ+WtDFOLTzBftCe/5cMGFwqZcaVwFskjtcG?=
 =?us-ascii?Q?c/4GnZC9BKOF69Y6+J2yxQd+K3GbfJDXLMPMJ2MM+ehZ1BkjZg0yavwuhnpn?=
 =?us-ascii?Q?+yOXk9wudLl5OfOug7GwnS0Buy2Nkv1xMvyRvpBFhqtlnolQAEZqf5Hl9tmj?=
 =?us-ascii?Q?7ZwWu7RKXSBEwRZNc4+BPwoROjSpTNUFgB7/HOz08jQt7YqqcS2DB3HXXn3l?=
 =?us-ascii?Q?LMxmLEfnL49DOvPOF7vlAoy4pmFPInIiDf8WjTYe9JZCttwcZgklh8iUdGtj?=
 =?us-ascii?Q?r7i+i3F7NaAQgr5d9b0ywNa7S9a9Emt/o25fsx5lmAa4MgCoRB57Jx5GN+LM?=
 =?us-ascii?Q?dQfVmbUNhsWSD2+9fNS6HgFSF7tsveiOOpm/5xppbt6urQHaglGisd6yILqA?=
 =?us-ascii?Q?hzD+NZbc0gljrzwE/BlpjXx28OYLV66D32kHF8pEoX42zf4KRhKUDTu+6G9w?=
 =?us-ascii?Q?lulbLucrl5Vf0wyJOFmnBAdjmqhv+CFcPKuyCDTJYnPM+Aug6GVZuafoA6kK?=
 =?us-ascii?Q?eyZdFzzlCX17EH0PVuQN5NbTXrTk5FDE/dJE2QQrhRIA46G1mpGaUckTN/hT?=
 =?us-ascii?Q?mRn8zxIwI+nSRHnWfrNjADvf5KaZo0YlFRW78Gj62a8ktnMzttNjvhyGcQlW?=
 =?us-ascii?Q?/9NvOfQrpwSdQja9lLVTsx6qy/ewtSCeVrFItUS7BD3cOi6PagmzcPO6JPAr?=
 =?us-ascii?Q?Fvg6vSleXH5cqYZsQbqZuKdpMUCjuTMQ5sPsjt+ZjWnDRr5fFrjvAOMs8iSj?=
 =?us-ascii?Q?viKZS06cZykN495UGWONYxHrbMC8e9YcznaO7w/H70CqckiRqFxDMp6K2sPR?=
 =?us-ascii?Q?kdqLzY1RskMvG7FPoTULb3tH66u1jg/SA3H+mhpahX00ljAP/sL+0/XEGkNn?=
 =?us-ascii?Q?eqbEJ8upRubji7wL4KKHdt4klOOnrrYP/wEZr/VwZJEO1Tz25yjrubPMXAE6?=
 =?us-ascii?Q?2sbG6AuuXSiW6C3LokmGiWv9kHnHjWe98LN1DcLTYHwuGZ73e7ljxvSuOgzD?=
 =?us-ascii?Q?kVNdm7V3vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20c112b-8fef-411d-92f3-08da21088d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 06:56:23.8308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPTU+mfEccZRX4lwh5RHSZu4yn5IZZBBBuIvjVSjj3WFIZV+0N46U1TJlPOtlca69k2gAgWVLYRHfhVPh8AZkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4736
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Saturday, April 16, 2022 8:31 PM
>=20
> This field make the requests snoop processor caches irrespective of other
> attributes in the request or other fields in paging structure entries
> used to translate the request. The latest VT-d specification states that
> this field is treated as Reserved(0) for implementations not supporting
> Snoop Control (SC=3D0 in the Extended Capability Register). Hence add a
> check in the code.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.c | 2 +-
>  drivers/iommu/intel/svm.c   | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index f8d215d85695..9ca3c67a2058 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -625,7 +625,7 @@ int intel_pasid_setup_first_level(struct intel_iommu
> *iommu,
>  		}
>  	}
>=20
> -	if (flags & PASID_FLAG_PAGE_SNOOP)
> +	if ((flags & PASID_FLAG_PAGE_SNOOP) && ecap_sc_support(iommu-
> >ecap))
>  		pasid_set_pgsnp(pte);

If the caller wants snoop for some reason is it correct to simply
ignore the request when lacking of hw support? Suppose certain
errno should be returned here...

>=20
>  	pasid_set_domain_id(pte, did);
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 23a38763c1d1..d88af37c20ef 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -394,6 +394,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct
> intel_iommu *iommu,
>  	sflags =3D (flags & SVM_FLAG_SUPERVISOR_MODE) ?
>  			PASID_FLAG_SUPERVISOR_MODE : 0;
>  	sflags |=3D cpu_feature_enabled(X86_FEATURE_LA57) ?
> PASID_FLAG_FL5LP : 0;
> +	sflags |=3D PASID_FLAG_PAGE_SNOOP;
>  	spin_lock_irqsave(&iommu->lock, iflags);
>  	ret =3D intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm-
> >pasid,
>  					    FLPT_DEFAULT_DID, sflags);
> --
> 2.25.1

