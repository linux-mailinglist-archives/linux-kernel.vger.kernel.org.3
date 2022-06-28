Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6855C11A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbiF1I3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiF1I3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:29:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5355521BC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656404953; x=1687940953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pQwF3EAvD0Vlz6c8UWrMJ9M6X8cAOFPk5KqQ5qRt0uc=;
  b=KXHrp3HQL6lmvQoX8Q9pnDmBvQ/TvEmaEVzWq/EkFyK24NLpAawK/1g3
   WswzFOHxVDBh/AWhhqpGd8yE/4U8xkX8Bg7DtX8Z1OrGOrQWLLjk+88u5
   8knysCwmAI/Uz0Vj6/lt9L7SSp5ixxNr5HIaZrpTQmNLTebmdKODPvnHi
   hCySvpyXTnJAMgSdcZdcL4D8IFe2uFi6/rXJovgTElfDkyhB1LuumAY7g
   uVNIKVi09/TflbQLaBG1c8nRLHsxfCNmNQ/XI3HGeFVv7svMoeQDmdILd
   tU7X3/bYur0zDglmKpfD0syvpOoyPNa8Vo31Swi1wME/wQW4+5GNsDvtB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367987150"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="367987150"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:29:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732662628"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jun 2022 01:29:12 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 01:29:12 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 01:29:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 01:29:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 01:29:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgoQ0Dq7WqCo6uw90OO+R4V6rbhq/ovhi3WFRKRyFwoqXiW/3PzGlK1GUwjEVrAXRg6nkNox9kvxTuwO+jX6H5ftdmwZAAy5isOtcgB64gM+eKt0T4dZ/552d2VzGhFh7fJM/kSaGXiDTI5ceOE//FhT+CXT6+4mytGbWendsAiWc0bQA5fbOiRrL+/0tfMv3GzLe2+7aWa1RzJMZpEEfZQfIiorH0oUYyk9MAKrGtEM8lIK65bEiYbc6iQMg8ZYaHofvVvfiHgjimX893re1BBjob7wdktG78DbkJ+JsJhBrmMQ+zWvnu8CRmcLUkFwuRrgpbKRG67fx3BUUlADaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kAPSppojA4f22rb02g+g2ru3VKahonfcN2WWGl8wTQ=;
 b=LVHusOxMnPlHblOwzjuZejv/nVW93et7uKjvDHRPSz91S9iscxnoztEIU05SGIzUVat58pyRrSZ0clA7vq75sep196aIHS0zg4pGhywjoqT3iU9DOwTJci3Ta3ScmPpVoGxIXtPoC/l6pvPRTRwKakjd5YiVIT0pqlDlxRwL368Quzf63l2oHkVXzw465rKtl+GU4gPs7SM12xJP423yR1qsOtszYZ+wMmzMBhO+P61GbcHi6Fyz6uNg3qtRfc2PpyMGNsBdJFFPhXgyxZssxCKPWAV6dfe09eIkcu4X3IBolEMyc9dZ9NWW19d2k8NAfJrJqLTtTY9trSyJv2FzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB3260.namprd11.prod.outlook.com (2603:10b6:5:b::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Tue, 28 Jun 2022 08:29:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 08:29:09 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v9 09/11] iommu: Prepare IOMMU domain for IOPF
Thread-Topic: [PATCH v9 09/11] iommu: Prepare IOMMU domain for IOPF
Thread-Index: AQHYhX4Co7eoDM+XZUiUgFo8UF9Xaq1khWPA
Date:   Tue, 28 Jun 2022 08:29:09 +0000
Message-ID: <BN9PR11MB527687EE83BC26F08A7D99908CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-10-baolu.lu@linux.intel.com>
In-Reply-To: <20220621144353.17547-10-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98930d55-d991-4733-6bf4-08da58e045c8
x-ms-traffictypediagnostic: DM6PR11MB3260:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Z5Hx1VdFhlZAbnZSd9lZb9bW9HtcWa7Vj7Muo5Bhsu5GGau68AAAtkUoXq/6GvBuJepArvhn5e/HKeHcRqLn3EpUkubecNrlZ0px3FxYP04Wgpx0Ahg1KImx3hXYxxChmYf2A3oLgPDyhuIgpeFMlYe6iOBEbSUeKohiq0r4Xwgcg9CHn6xTC4MUH3c6wRm+xcA5Bi7vGv/ptaUnYyOnZA6Xyr7pubb3+B5R6NVu1dJ+5anAgQwQP6xrEqI252v8ucxfZ5K4rn8B2Z9kC2GuTtU708m6DZcv2rYykOayABapmtuLttFg7IkIvb4dwJIBk8YA9GyX/h4Fv1/sSXdpU29l5DHBOXRAGGV/MF5cl+6433J0w+EWvYh12G7exOnX9r/5b5fOewzwhY2nbT3NYTiatQS85/jGJ98UJtsiHsRKM0usJptPR5cac4qpoW/9C+CSjLOZFnRLitDr2KwjJ0/ije1cDwbz/LpDGlEe+wUF1Y/x4edmkcLmOhzbwF5Yq6K2upAeevoh1nD9vy80K/t9RDNCzT3YWmT3zkI0zyjSi+EclCQ+PN7O9tW0ks0DjRpnVYIhjIvusX0dj0XG3QYAz+6XoCpkNL8uK7evWYaNhY4WT6eH/HLcZJOc08hNNQ8dwqY5nhg1VIRaU8hN0nL5+SuyunQVXlV7RVKRfTQWZ6KOQSKXgGevDIwMfnGtyHXaT3q/5Vok1s/v1+vltlxqj2PmMQTIRYj37tK8KPrfEgUxGKIG2PJn9JXDgyZ6KelZ5Vya8nau8eiFK/4yd/Iob9XHYAZii3KPooIBtfRd146EGKuPRJ1q8Nv52Ya
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(366004)(376002)(39860400002)(66476007)(478600001)(82960400001)(64756008)(4326008)(66556008)(86362001)(38070700005)(921005)(8676002)(122000001)(71200400001)(66946007)(54906003)(110136005)(66446008)(76116006)(316002)(186003)(83380400001)(33656002)(26005)(8936002)(9686003)(41300700001)(38100700002)(7416002)(6506007)(4744005)(5660300002)(52536014)(55016003)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xwntihsir9Zib6ZEiP4fzZyPyAaWXqAc91XPB6VHYuqapZx/VjovSibAxSOB?=
 =?us-ascii?Q?Dn1kdW3YOUYfQKB5S5DZfLoA1HYt9xjUKc0H6gJD+/jA+BCIo15Q/tXhTrQT?=
 =?us-ascii?Q?X0j+osLN2pq908YnxGTZoavKC9tWpe/Z2d7gcnUeDh2d4aekbKtmuIXubzF+?=
 =?us-ascii?Q?dSJRfi/DC6ctHJfiU0Qpmd/JV+muWvy2q2VKn7ZDOQiWU4p5RiV6apvLcBBP?=
 =?us-ascii?Q?FsJSzPqaLTOQgD5VVyzvdIE+QNYWGXRJ95RSFi3gEEtPL7jpOHvsVnld9fTQ?=
 =?us-ascii?Q?0HC5ABw8bJtHrDjpU2GDQYo2wIMC96ZUAS7PyvT38HxPn121OyOOsxsYDqlD?=
 =?us-ascii?Q?NuErBk+G4RcIzXqpDM7PDEbumrgmJFcboO+LWpWni3WeXsKfxX4mKhQ1nen3?=
 =?us-ascii?Q?XtbrcHaZfq/+wxYECiIsgG8Rl/4BL1PQs4Cyo7hdTos/LWmZEFZisKb6056e?=
 =?us-ascii?Q?w6hwqoSqZaX7FmqV5daPEg+FgOblCgIu7snjAsq0QuoPa0WYZFcBC/npkEUw?=
 =?us-ascii?Q?CO4zRdPqvOtxLQojHWr71FewK/cDxiNN6uwAAa6vuv/TxeAEyGH3Bxd0PnRE?=
 =?us-ascii?Q?rmvQz97goXMRD9frkJ105hyicG7VIErsslS24k8luOp0JSA4hAcIfHV8vttf?=
 =?us-ascii?Q?TLUj0MVll+bJaHxAY6ewBuyh6N0olxXGuZ9PxiiPcmcbCdQ6D1uBdthSmwxE?=
 =?us-ascii?Q?IZvk3kOfe4kbwxabA6loP2FWqV71nwUZf018KshIdcb4EO3KaWxGq/wW1VQf?=
 =?us-ascii?Q?K7cNeBrQKgleUkJMvMAQRNH9aZTLnNB+XdBWiuLneAzxYhXTlF1il1KIhzkm?=
 =?us-ascii?Q?UtDL15qTRyLhIV/RCyOdcggrLCoBj9YxcVnnW8FcltIg0FI5clAcxgd0lRU7?=
 =?us-ascii?Q?fItJIOHvZwtwFBB9HBrCo9nnDOwGh+myfSi7PgcsXDWT0iDYM2iWCiYRe7fC?=
 =?us-ascii?Q?FwFSELQQVejmPgqBFM0VX+2MV9E24CZRk9YV4VlFkKb/WT9fg0Bj4V0sPgKn?=
 =?us-ascii?Q?ISShfux1JLit94pmZG37wkKCoPAeAc1pLl/XxXgv1WZx8XbyjQkWny4qpn4K?=
 =?us-ascii?Q?dS+cDfb+9nBOvnyRlDzXLE4MLm2/Jn8ZGKLAXc9vYdJ0qsfi95CYVV7LDGz9?=
 =?us-ascii?Q?rEGhQq2zB6RQ/gqiXwuhBBXtbR3UqUkJ+shZMWguGTH6cMXSzyLi3hC/Bil9?=
 =?us-ascii?Q?fckyTZcvDauEHnL7l9qiEzD2aGvoABfg0MRp6hN3eYnUNpTD8rC4UKCP83L1?=
 =?us-ascii?Q?aeGvvYbLJ124SNIAOILCuHhUQnHAOXEvKM+CQ06JXVrKzKJ03br2/67NZnn8?=
 =?us-ascii?Q?xm1Zz0UPMR/wF5E2Z1kw5IXk8zkk7VBtEOv2AADamPX6XJrQl6Pv8GK96isz?=
 =?us-ascii?Q?cLTxgiMWdUWwcp66jVk8WXLvHIp8JUPNGnGyn/hdq6oBplp7hSf879SfDilX?=
 =?us-ascii?Q?NCKONjlO8B5QPOPvsCoxT0HIXqvyIbXGYGp7CBFr9rEdMWz/t7AdYV44gNA3?=
 =?us-ascii?Q?q31UChmRkpgw/j/OXrFo85d3P740qLYC54lhB4BkbUU+H/923m44SvYOW9VQ?=
 =?us-ascii?Q?j2MapBZ02Yw4gn8ZIAyttveAo7WUVVYMkVJ8RilY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98930d55-d991-4733-6bf4-08da58e045c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:29:09.2607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q51Uu6qU0wV6q3JNt3NHQvwjzmAWcgvIS/Zfa0G09ANj5yx+J4qzJ4z2XBY9LC9kiWeOW6rt6noksb8KP528Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3260
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 21, 2022 10:44 PM
> +/*
> + * I/O page fault handler for SVA
> + */
> +enum iommu_page_response_code
> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
> +{
> +	vm_fault_t ret;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	unsigned int access_flags =3D 0;
> +	struct iommu_domain *domain =3D data;
> +	unsigned int fault_flags =3D FAULT_FLAG_REMOTE;
> +	struct iommu_fault_page_request *prm =3D &fault->prm;
> +	enum iommu_page_response_code status =3D
> IOMMU_PAGE_RESP_INVALID;
> +
> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> +		return status;
> +
> +	mm =3D domain->mm;

What about directly passing domain->mm in as the fault data?

The entire logic here is only about mm instead of domain.

