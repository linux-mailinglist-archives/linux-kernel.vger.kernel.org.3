Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF44DD4A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiCRGS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiCRGSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:18:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27A02B3D5D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647584252; x=1679120252;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ar9rhJb+qhiQF9WVlXC3Ve5wbrVZgWXhOHndqFGSrjw=;
  b=Axq2ygqCt20U4UafCMEHLrXCgIcUXXq+Y+/mww9Yy7+/CTp4jAR8ifpE
   eMs0vqwTHccvC2RYz1uzfeew11xYvA/0fyAqJopTUVonkQE+07AFsqGtK
   YAUIBgWTm05+fRDwFI4pynGxDxwiSUO0ZmBrQSbZjh2H2K4EIHSFC0HQX
   kbOXhOHea8lf+uK7Itxnf6068TDEba7mCK34a6Wf/mJFa9uhnHBaxxYog
   gSn3pT9BGzPJSZ8luRQXKTxDUSY7S9Xgorvb3IF2Nz6+77UPSoNVyk4br
   vik03RB/dra6aKHXdtwxWoOTQuDU9lylmSAR5MQAqm38xobE6d7DXhq4P
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237008216"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="237008216"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 23:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="558271330"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 17 Mar 2022 23:17:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:17:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:17:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 23:17:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 23:17:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIIA+D+bmSlAA3HPnru+dYNPybuH9o/utZnMKLlLu/amoDIK88xmW8lk3Kk5y74AlUfUFw65Wcoq63vF6KEkM7JSNwumJFDgSMoIuyf0LU91PI9Cv4PHg3jhBCQIKwcQXOFhEYA6XAi/pOIhvbp+/efOn+fUWrhTDZcy2yRgRY+vE4zQaWHxVb7ODllfWQmDFytUnjwkWYcyB8QVYccvoQqTI0C6HBWTsEKGS1TIqyEmsOu/mnoynTNw/Zw1wKmN4AS/viCP34Y1T1M6hFZb7bkmg0kfmnPyojDU24AwinGDXW+PiOYvhVzFupwQRkeZ0t3LZ9ec341a3nNTPdfpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF/ta02Pb4DSqeJLpDqvRUsZ20yUjGwYtdmRhYBanq8=;
 b=SOO/tPsCcSx0tJID+167hUyDhk0XpilUWJdibQBQSlVPizVmulqI80fMbAlBtxsGWL0b3hzVoau7c34Ir9y6DpRIMfLMkyIi57M08TsYCCqzD1f+oLdYiHPXApRJd7XWJRMcPHY2B2/a2BlXFYQmOWrEvqDfISvjtdHyMLI5Ku/CV3wmmrkSjFLHj4VRI9gE9nYjAsjWInophgD7cFwCk7OzmQej7E8tqSpNPX1mc4DGHBQZaoVRn42CijuQ5MQCmXZJwJcpBT3kiPrdcMyewuVuuLG5aTDUW/O/AINBP7VdUrWvS22Yu7BHEkc0vNSz+ozSdg40ugahQe7rA+mkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2909.namprd11.prod.outlook.com (2603:10b6:805:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 06:16:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 06:16:58 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 7/8] iommu/vt-d: Delete supervisor/kernel SVA
Thread-Topic: [PATCH v2 7/8] iommu/vt-d: Delete supervisor/kernel SVA
Thread-Index: AQHYOCocpbq5DVETBUCsK14gZYb6VazErkaA
Date:   Fri, 18 Mar 2022 06:16:58 +0000
Message-ID: <BN9PR11MB5276B2AB27F5AD50BC18AE718C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-8-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220315050713.2000518-8-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d92fb6f-ff49-4d41-f210-08da08a6e881
x-ms-traffictypediagnostic: SN6PR11MB2909:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <SN6PR11MB29095FBFB92770F36FF8FE468C139@SN6PR11MB2909.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yt5KiiuyEDjEaexw5+owbYr7tXk6n3EvuGlLacc7TwKuIvqjiX+NqjmoJ+NurUmpFoDkhzN+oWXfb/06E3slMBvsW1RmyuvVkXWejZ1PXXfWMrNDGb9jPyJngIVecNW0dic26qDj84jahVn98Xv/T/wzsebrBk8bSpPSG40NtvNFtZUi6oCKmw/JlmWJaXGvHztxqX9iek0aQCdV2BjCy+zH9fAilu2Clz0O7ymXYhVWcoHe8kzCmgz2S9SquRX947EMKvfhiDZPNXIi4x/UANujYm4ZTkyubr9Gvq3cYa6KkoXumV/lnRqHOnOe5CELthMHVB1qm7aIOsajIAtdJPbk/HgJcHwqqqlBzgcQuXbjc47RJI0X2+1TvIc+TiuDtiIWUhOXslFtS+xKaSanJRUV6qQDkbnzMhPo/G6lLPmxwvoqvho7A4fr/KQk1/V7YOIR8dHs3pJgfhfonoXuMQBZydAXCDcvYhGZLNJ6HrN4XjRdipXqECaO8IDotTJ6sbaD5RY73N4vuRynTWI1j82fGKxxYTMcL+x36p0aanWkOAzi1EQJB45ey+bIPhwW+Rz8LK8c0yt2vE3xjllWIXjElxZVax3k5pRMH74qVoQBIcW19HH6Mv6hfHB13WbouIvgVq/170iiaCUvEpR3eusNgzzQHZJ240XPhEEWEnbRbUmQTVQp65wWpqC0FvkKuJusNbmQJRyYvDgO/hI3eQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(7696005)(2906002)(9686003)(316002)(83380400001)(86362001)(26005)(186003)(5660300002)(508600001)(38100700002)(66556008)(66476007)(8676002)(64756008)(66446008)(76116006)(4326008)(38070700005)(66946007)(54906003)(55016003)(71200400001)(110136005)(8936002)(33656002)(52536014)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bWKk8z4QQTC5Am6l0DCaO0j09FUA1TsJnIxwS6X1O8JyicpNhhZLYBuv0Kfy?=
 =?us-ascii?Q?Pv3fmXI3PuEFDjVizsrU5KXfQxodICV6LCd5u8xGUBujfD9WKTImZtkZ6lA4?=
 =?us-ascii?Q?OgVEPGXfzchgDm8aIbwJSBxwLjhD/qHJvrGxSel+zhSUBie97pUsvnCn2Jag?=
 =?us-ascii?Q?YDXVJP/y1L0zap4qROtS/GowI9nqMapjW1iN3pOfJOcT2Mkdep2R8un4aN/H?=
 =?us-ascii?Q?g5TOW832x3hl5s3tTKq9l9e11WpybydmnnoS3UQRaNtYvXfiv7PpNeipavvS?=
 =?us-ascii?Q?nUxPFPiFCAd6dZO/QDUeGPG+b0xuWvZT77PTVd+8MyVFsKH6msXCYrr3kzGA?=
 =?us-ascii?Q?pm4Lqd7EANIms2Becexy3z/fZJu0wAcYk5dqhOK+3y81yTwsbzFBnMI4E5hJ?=
 =?us-ascii?Q?cDFdu0PU7JMQKjpIcpiwRxW+SEPo5Zn+xeL/IoNSe56X/zMAlKIFlEJdGEk8?=
 =?us-ascii?Q?pMLvDZk/VGmAul4trOpjkJuWG1cfEWumHbNzKM5zJ4gyYHzFSinBTJwsOimO?=
 =?us-ascii?Q?h64ONK9mK20NBhE0leLPCVOoIpZqz+rwOmqBNCgwmq0rSU8D0iLuJNc/RyWp?=
 =?us-ascii?Q?Tm5ySDLxLFXl4I4qZUVh0Emp3SSUNR1RILfgcI5+5NDexmYHklrTUwLK8LSZ?=
 =?us-ascii?Q?QMQt07vruNS9TBPwAONpt1koAltk93UOgQQveLdTj6SylqiSd9biQD0fbtLt?=
 =?us-ascii?Q?Cqo/YIDGnmgAPWP8h0Wxn0PjH6JUHTldgylnTaXgbqmPMceFeSQDgyG44VQH?=
 =?us-ascii?Q?dt4qXBaBAey5WtoRcoiSbUEuhWJA5tsLAcd07qRPx8WNT6NY9dtKkHPV6tCw?=
 =?us-ascii?Q?1w3s/t+E3wcyufmj6MudBGeGVVOfqcjrsuquk6vf6skGxvRsZUYjxg1Yo1St?=
 =?us-ascii?Q?ayEuzo4p6feRZ+bP96eqtDNURxPIe4j/B6NrwScfRMWwsOVc6RWU/py4SnZS?=
 =?us-ascii?Q?kbCCXOJNfY4PWT/idqoIHSD8KGPM2LP501aPfnFN2s9BAT8Xm+v79FWbTmkM?=
 =?us-ascii?Q?2t/yuTNt/9yxkepFQbyWTkYIwFfFZWmrukInLz9JSsFw7zSWgWK9ThUlM6zn?=
 =?us-ascii?Q?5i6K/D3TskdYmdFg+yYEILzpYPKc+fIrBMGo8s9xLjgO+vmHNb58NjFBZTo1?=
 =?us-ascii?Q?GIOSWFVd0zrLBCXiFcxhKgWTMuikXjVUQ8LBiei8THGYKwuiC+jv0Y2I3My+?=
 =?us-ascii?Q?ipHOJqrMq6EQL2DeTA9thX7wB80gzMJXDky2NF1kXIdK0qH+mNJt1bHULXtg?=
 =?us-ascii?Q?umr6cF9B8wg4RVSq/ctLhEzmOg/+/sH1V44VF7/bIb5+NG0tQroaqerMSttP?=
 =?us-ascii?Q?N6CvmodvvH7GAx8i/kaJ+gD04lKNQhpbL0SxqYWDj+equ/CMo4BMbAIj4UqS?=
 =?us-ascii?Q?kvx4TixqarHVTUhsciG3sMA/nlHD9Pic5LoFrQRn3xoweMEPMJ2Au0iG5mqz?=
 =?us-ascii?Q?nsFBLQKKm8qEQP5ttT4vm7Zqo8YRbrCF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d92fb6f-ff49-4d41-f210-08da08a6e881
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 06:16:58.3207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdOjEWLAI+3w0GDHBs/C6PUB0DffXijmXtgmaFW6JKc2S6gC9jUMWZuIkVU0Rudc44pSuUmGgu/MSH8StcGTjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2909
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, March 15, 2022 1:07 PM
>=20
> In-kernel DMA with PASID should use DMA API now, remove supervisor
> PASID
> SVA support. Remove special cases in bind mm and page request service.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

so you removed all the references to SVM_FLAG_SUPERVISOR_MODE
but the definition is still kept in include/linux/intel-svm.h...

> ---
>  drivers/iommu/intel/svm.c | 42 ++++++++-------------------------------
>  1 file changed, 8 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 2c53689da461..37d6218f173b 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -516,11 +516,10 @@ static void intel_svm_free_pasid(struct mm_struct
> *mm)
>=20
>  static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>  					   struct device *dev,
> -					   struct mm_struct *mm,
> -					   unsigned int flags)
> +					   struct mm_struct *mm)
>  {
>  	struct device_domain_info *info =3D get_domain_info(dev);
> -	unsigned long iflags, sflags;
> +	unsigned long iflags, sflags =3D 0;
>  	struct intel_svm_dev *sdev;
>  	struct intel_svm *svm;
>  	int ret =3D 0;
> @@ -533,16 +532,13 @@ static struct iommu_sva
> *intel_svm_bind_mm(struct intel_iommu *iommu,
>=20
>  		svm->pasid =3D mm->pasid;
>  		svm->mm =3D mm;
> -		svm->flags =3D flags;
>  		INIT_LIST_HEAD_RCU(&svm->devs);
>=20
> -		if (!(flags & SVM_FLAG_SUPERVISOR_MODE)) {
> -			svm->notifier.ops =3D &intel_mmuops;
> -			ret =3D mmu_notifier_register(&svm->notifier, mm);
> -			if (ret) {
> -				kfree(svm);
> -				return ERR_PTR(ret);
> -			}
> +		svm->notifier.ops =3D &intel_mmuops;
> +		ret =3D mmu_notifier_register(&svm->notifier, mm);
> +		if (ret) {
> +			kfree(svm);
> +			return ERR_PTR(ret);
>  		}
>=20
>  		ret =3D pasid_private_add(svm->pasid, svm);
> @@ -583,8 +579,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct
> intel_iommu *iommu,
>  	}
>=20
>  	/* Setup the pasid table: */
> -	sflags =3D (flags & SVM_FLAG_SUPERVISOR_MODE) ?
> -			PASID_FLAG_SUPERVISOR_MODE : 0;
>  	sflags |=3D cpu_feature_enabled(X86_FEATURE_LA57) ?
> PASID_FLAG_FL5LP : 0;
>  	spin_lock_irqsave(&iommu->lock, iflags);
>  	ret =3D intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm-
> >pasid,
> @@ -957,7 +951,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  			 * to unbind the mm while any page faults are
> outstanding.
>  			 */
>  			svm =3D pasid_private_find(req->pasid);
> -			if (IS_ERR_OR_NULL(svm) || (svm->flags &
> SVM_FLAG_SUPERVISOR_MODE))
> +			if (IS_ERR_OR_NULL(svm))
>  				goto bad_req;
>  		}
>=20
> @@ -1011,29 +1005,9 @@ static irqreturn_t prq_event_thread(int irq, void
> *d)
>  struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct
> *mm, void *drvdata)
>  {
>  	struct intel_iommu *iommu =3D device_to_iommu(dev, NULL, NULL);
> -	unsigned int flags =3D 0;
>  	struct iommu_sva *sva;
>  	int ret;
>=20
> -	if (drvdata)
> -		flags =3D *(unsigned int *)drvdata;
> -
> -	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
> -		if (!ecap_srs(iommu->ecap)) {
> -			dev_err(dev, "%s: Supervisor PASID not supported\n",
> -				iommu->name);
> -			return ERR_PTR(-EOPNOTSUPP);
> -		}
> -
> -		if (mm) {
> -			dev_err(dev, "%s: Supervisor PASID with user
> provided mm\n",
> -				iommu->name);
> -			return ERR_PTR(-EINVAL);
> -		}
> -
> -		mm =3D &init_mm;
> -	}
> -
>  	mutex_lock(&pasid_mutex);
>  	ret =3D intel_svm_alloc_pasid(dev, mm, flags);
>  	if (ret) {
> --
> 2.25.1

