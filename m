Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D165697C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiGGCGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiGGCGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:06:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677012AE10
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657159565; x=1688695565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mQ3xcda38E/IKk1va3vVmbOG7qItHBvp9IviM/XfK7k=;
  b=FcEZcHgZU/mU1yFKC5lqfi+A5D6eQ3wuGPYM83iqEK2MTFs6tAOZLiYE
   QME7RtGY8O9su0YeTFllIEiQq0J8qahSFbNKTEV7z9pHcV8DPWJo0VQzD
   RgKudJ5zV/0qTBaA3zFJk/yEGuLgYUfj3kgGYGFMPf815ZRzOOLqUGtrq
   oRrMYdv9338sXjq549dETCyWFOMUJVy8Gt7k42BULSoqsDSQUEqDvcyst
   3kPOPjkjoTKDLEQiT9sVsH1oWZOpIoSkh85PLAf7OAUbpEAYSzCCKllZM
   H84/suSbFR7y/QSgfpxHBEcSCDMLoIlV8+nNOTQsbdOOVQT1+o1pkgJ0H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="309466073"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="309466073"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 19:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="620580985"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2022 19:06:04 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 19:06:04 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 19:06:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 19:06:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 19:06:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqKX1IZKWNJ6V4H9a2vfs0oRbA5kZwAwXBMBylshFavIqIdUNV1JdjZ9Q3dsCJYqmqrnaTqTZSkJpR7yBpMP/TpVPdPX7taASGrgEmjJ2q7AWTotz8HcYe3UWV1A+UbcIclmSki8UVrxnMvxoEguwug37W+K8c3qmg8j3XzM0DqiQpDE2RVbeCudCvgKkgriUMp4DlgWXhYXFhTuqs/P4M/lRdmvnIUj9q1MPLmAZJjmaFSF+c8Pd85/xUsF+i6blwQ4QNIb7B8tuxFGfW4nrsrafKVurHavhWeVfh93I1FLvnUEzkFXTN71eJePQfNK9FKGTEBhXb3nQqx+uLmiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQ3xcda38E/IKk1va3vVmbOG7qItHBvp9IviM/XfK7k=;
 b=mU3LQHiQZWMc/CDbUHftdnGCICjjeh0aWNKzs9352nOUutT0SnxuYkELeHtC32kCDbZh5t+uHsbBV3OMx1f5bqkZJ6N064DHmRcMhsUF2NrjcwMsFiGJVtB31LqeMGOsQBRYt0XR77QQq68Br9klNj4vaSYXQkZnqqyQ2X39JRr0UfFHnlHB/7yKvVye8tOVMjrsJEys0JgkklEZZlUzG0A0si68QYhZATcPDCZYlmaK5a4DTgRkFyR2ZSavZOIyMradIg05awz12vP9YKTNANt+87gpVXTkRBTFAPHJjw1SnNWHqgz1tr+OSY8bmcL4AQA7QsfB+X+0ceM/3s8cqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MWHPR1101MB2174.namprd11.prod.outlook.com (2603:10b6:301:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Thu, 7 Jul
 2022 02:06:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 02:06:02 +0000
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 11/12] iommu: Per-domain I/O page fault handling
Thread-Topic: [PATCH v10 11/12] iommu: Per-domain I/O page fault handling
Thread-Index: AQHYkC3auMAPEOLQ1EqqE1ImiBKIMq1yK8Cw
Date:   Thu, 7 Jul 2022 02:06:02 +0000
Message-ID: <BN9PR11MB52766D609A6AF7AA9C1881AD8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-12-baolu.lu@linux.intel.com>
In-Reply-To: <20220705050710.2887204-12-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6c3f09a-b269-4bb4-d3a0-08da5fbd3e32
x-ms-traffictypediagnostic: MWHPR1101MB2174:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OPrjAimEgWUb1qSdLNsKRsICT54oUAqNKJ1q/pSzdzkZO/XkukSyqGBrvkvHwaSeflB7wsCjqDiKwIdWRq/dvw6QSgVX0jshQrwLuCKU0frVRnCpfDST0ieA9WxO+beddgzsxYp8gWKBN7xY0/x6DJx9dK99zLxMZQaoTFOmy0LMqkD0fJm65IVtFMdfDL/hKxfXGdrm5xCGggbV6G03aGVgZAqKzdcRnZYkKonkY/JG4lUoLJPpptBeKAIFG/djXtg85IUoUEJK+kYnSgl7+4rMyrvkT1dmp6tAUa84ru4H1MZKA2H59CS6Yt0sUylUTjkMJu3cHTFDiYNN+8eTQbk1LVMDL4V8BHRHK/ZSZdJUSR4hjzBOiU8HCrO6hT/eicvj82zNPigI5SU/T0CDX0ijMPgmUZuBQuVApRPK1bI0LBkffx5HAekT/kGnHy5l4nzbpqsXKwy15vASwietQRxfu8z/U+D54KH7SAHPjSAUa5Alpi3B9sdHZWrKAf/W40kevfy18vTblmKGJKr3ji/46bbni/QQn4DBl8vVywK/vy/jgixkXjd+sQGad1xAjuUegfIHGkFCSghJBEy1q0ICyqf8N1cUiZ1o1IcmkVirYXP9+RupLht6dXJcA3nAzjmOi8jvgEHmW2tmbJnqOuNTvSXMmTTruJ79g58v2ArDsAYRgCc/iuodYKF6GFKbwHP2le0gFJp5p+gMq9OciChIE7FlevXiqmv5i2jMBF3X/WBM7vuOfoQdLOvkD366SkkLK0n4lkiGJ9kFGlbC/RyFfn7aUqQEnUWjqlloYdMUxakqQUH6uWVFiAOw/hgTIZPruk1i2le6VUABA/oC8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(346002)(396003)(52536014)(921005)(8936002)(7416002)(5660300002)(8676002)(86362001)(41300700001)(66446008)(76116006)(54906003)(66556008)(64756008)(66476007)(110136005)(66946007)(71200400001)(4326008)(316002)(478600001)(7696005)(9686003)(6506007)(26005)(82960400001)(55016003)(2906002)(122000001)(38100700002)(33656002)(38070700005)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R/aec8nbJITG8nujFmcHQOyRSfckj35d5ykFe2qPkq6wzkJrA0o070RJ1ONO?=
 =?us-ascii?Q?crgwrFPP8+iU9v2pV7SrpsE+4KRRHY6rtewTtCUk8NUyMhqtVWloqrTnh0rI?=
 =?us-ascii?Q?1C5BMY2PRH14a+b7rFHYE0gl2E7Zq0G4ERQnQH8ZIwSIq6Oi/12dvHV5EcqF?=
 =?us-ascii?Q?5WV3GtRTvHi6Q7KBTOcDpfG2PfazoE9fXSU2v+lRMxszqJXIXG0nCc8hp5V7?=
 =?us-ascii?Q?+1zZ7AxTptWJcQ95W+tJSxZG9ay6OdQ/w9REGpatCNIgLUhmBGFyrC8BEcYw?=
 =?us-ascii?Q?jOwuoU9LbzP4/YR7V4cf5dsZrUgfTCm0iVSl6xgsVmO1ywVgizAYRGm2c43F?=
 =?us-ascii?Q?yMEVasYt4l3vjKzvFzQe8hj//TjmtV/0t0Q6p1AxuSfD1XrEyMeoRDvoHDHH?=
 =?us-ascii?Q?3VrxkotZp8tbgASHmw1YnXUBkQ47Qy0Ab3pLKBn/DFaFnYgFg9udmPE3eT5D?=
 =?us-ascii?Q?CF74qBmlemrwLI+5iShRAnHhXjT43nyZmrwJ2G3sa4aZ9szbYxmNzH55RQ6U?=
 =?us-ascii?Q?sJELygNQ1IOaaI4NplAm8gGMo/3xeZx4bNxy/y6VWKUG/U1+zJx/BvhnyFot?=
 =?us-ascii?Q?1wV9otSxJLjenENZd6HvTi1oN5CWRhaYhnUQSbD5U+6TwxvfA97SNVKs7Chw?=
 =?us-ascii?Q?X/RElG3V5Hsl7ksZF5wkyy0zv7yGUjWZ9dTzj+sV49WETVs6mlMln2EgBBLw?=
 =?us-ascii?Q?xceq5Hs6PXWyBzT9Bh3V1LZ5Oyeo0EFUpMINBfW1o24cfCdPEKYenqzSETQ1?=
 =?us-ascii?Q?r3MB7+rMcLWuWhC6IjFaa1b4pjsFw3WrD5fwmwh30Jnra5XEp/WueIxPYB4y?=
 =?us-ascii?Q?HIX5biVZeJKapfLSxoBBGWeduVyy4PcGVtJkLGI8PhWFJMgie30R3f2gew2T?=
 =?us-ascii?Q?PgM/2cLaBou6dTVouKhP4/JlCFMbGK1EL4r7VHExkXuY9/wxYs685F4OREix?=
 =?us-ascii?Q?EhjjnIFkLCe6NkpnIvoeDK2EF4m7EonFdE3OkXlMlawpYSQNNfJawjt+Dh1i?=
 =?us-ascii?Q?0zv5tqzh886zn+CmK+M6u0hlTAcTpnQ4Y+RGcLSq1VLrs62j0n2iRT5he7Ow?=
 =?us-ascii?Q?5rWJ2/iGnBfULX+n406lGXBfNDpLThngp3oUO2bY9fWTOHEt7VVxvfWBMxdq?=
 =?us-ascii?Q?sYshv8JmSOqTpjpThEh1Q/KQBlibjuvF9fixvjC4b2SCEH1OMLqACYaXxZXn?=
 =?us-ascii?Q?h1YmGs1nCOO79zuVTJimk8m7J1pRpnHIkzwBmq27ss9TSCMfXk1axy+Sbj57?=
 =?us-ascii?Q?M9Z0DJ6sv5APWYEUnouE/k/PklLEaR6+5Ev2gPQ2tEF6lLJ03S8cFJ1OV7Kn?=
 =?us-ascii?Q?OeeaPRJN0tMfAYVqjx4AQ1JDcqqSka6Ga1NGJCX0HZKYWYfLTwcOBSZU6rhS?=
 =?us-ascii?Q?ZPDqTzySP/CPon7oQD3ePQlkE5lKF90GFVWdYfVTj/71CJMtPKBNntF6imZb?=
 =?us-ascii?Q?K4bBx7CgEP+P0BAsZE+Jte2wxjUU5NT8uWpq/FuOQG0fw0WpcFcqETdud6Rs?=
 =?us-ascii?Q?kMkV3zdULhgMrmfl6H4J1v3jJpS45R5SwxXSlyuq5CCg7+yUItqm+9RrTXku?=
 =?us-ascii?Q?fhLYCUuBt8y62zEptKXabWl2cYxty3RHOCh4JLAn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c3f09a-b269-4bb4-d3a0-08da5fbd3e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 02:06:02.2853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rg6np+wZo0DdpasrKOl2QqrdzToilcwiGHeC07N/QgWftMfxkE3aeeskszJed4txQL0cdNscp2grUEqVudywRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, July 5, 2022 1:07 PM
>=20
> Tweak the I/O page fault handling framework to route the page faults to
> the domain and call the page fault handler retrieved from the domain.
> This makes the I/O page fault handling framework possible to serve more
> usage scenarios as long as they have an IOMMU domain and install a page
> fault handler in it. Some unused functions are also removed to avoid
> dead code.
>=20
> The iommu_get_domain_for_dev_pasid() which retrieves attached domain
> for a {device, PASID} pair is used. It will be used by the page fault
> handling framework which knows {device, PASID} reported from the iommu
> driver. We have a guarantee that the SVA domain doesn't go away during
> IOPF handling, because unbind() won't free the domain until all the
> pending page requests have been flushed from the pipeline. The drivers
> either call iopf_queue_flush_dev() explicitly, or in stall case, the
> device driver is required to flush all DMAs including stalled
> transactions before calling unbind().
>=20
> This also renames iopf_handle_group() to iopf_handler() to avoid
> confusing.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
