Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B136956971A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiGGBBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGGBBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:01:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9742C2CE22
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 18:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657155666; x=1688691666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9/d+vb0IXJ8IEhEwmvUzcBi+h6uZ7e/LOJ5zMmI+/gY=;
  b=XvHZVA7fJGF4Ru0KaKfZ+2gdD4XvYmkYgxYNZnVfXEnELFbH2XHuIxyg
   AT5j+KscQcNc6dDRQ+xwwfK8GLKETGzu8O2LJO+JCiVqmlpPir/ZUwjBE
   Cb8Pxm1TRMSHyCBnNXnbjU/SvRHjHWNqr93vwHyBi+3+f1QH72PIRfE6e
   riVzGdajJENwfnBUdXJ/HpuvEtS8BAeXd+SLHGaDUsZvZYUqpBfPnmMIr
   KtVo2rY737eKKQLIFnviUrd2cyvolCEWaxvA2FUbIDPs41iWh/MRJdJxx
   QWrAzxqDILWtAmHDtKsGqfC9y9nuFKrWAbSRURk/yu8kyKBtbjiipRnOa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="282653732"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="282653732"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 18:01:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="720339390"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2022 18:01:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 18:01:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 18:01:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 18:01:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 18:01:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4BFV/lfZSyuzB5V+pT3G07XVcRN8/c7VfiyXcJi/deeFZcqbVR3ZyTexdYKVlsMBHUS83zfQzUeTayxLbhrK2KxQAL3lKLxzEw6Ip7EY0/vxueGG2bkb7W8li6KCvNBPIBGxKp+rCrJxLO9QWzM9fdS3PQC2x9SUZYIEnrfcS65tLmDnjnOltUHyyya6vI3qK8+o24lOapizDZQGT88FsOxOIHJxnGNzchVA1vVC9wr2V8mFu53FN4UC7u3ynx5KDU2Nhu9XBPC8x/1v8Lnhe1bDs/s51Z9vI1GdN9TKpWVr5HzjXshCRNRx51vOxhjWrOvjvBs6ufMZxiEc36GxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q24mHhGMHNHAl5p82TUPjucTjGPbTB5qBxzviPKapk8=;
 b=fGWxUWYcyPNcg05dVagk4B5GUyw0YRwOoza9OdKTjea+4ZHSPzY5KfROFly1w66LXP5uzySZxIq0JJdc7kqk7nz5+h3ZxGQNwttZk0vs4HuEYUzxMtGq9fJlMdB4KcL3vK+Xr3NBUx8rdJNei3rI4yPXGibsSOeWJKJceq9mNphjQVQe/ESFPBQ+GaHwrJgxhSFbp3BFkwugHoJhnEy2hCy7nZFVRFXYatVy0uOn5qGTPyCXy4+CaX7l6RF12s2zZ0TuUDkynMbxwnlbcRwDRc9NRRziLKcdV0d0LEL5PUxgCDSKz7vRleqrdGpzuaPMnmg/g0Qy3q1ZRz9vO3vOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 7 Jul
 2022 01:01:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 01:01:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Steve Wahl" <steve.wahl@hpe.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] iommu/vt-d: Refactor iommu information of each
 domain
Thread-Topic: [PATCH v2 3/6] iommu/vt-d: Refactor iommu information of each
 domain
Thread-Index: AQHYjbePRj7gsEdtHky7Xe11jFfFkK1yHaMw
Date:   Thu, 7 Jul 2022 01:01:02 +0000
Message-ID: <BN9PR11MB52764D1132C2AB21B0A2A1B48C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
 <20220702015610.2849494-4-baolu.lu@linux.intel.com>
In-Reply-To: <20220702015610.2849494-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1286d451-c09d-4266-910f-08da5fb42a05
x-ms-traffictypediagnostic: MN2PR11MB4648:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: saH3gq2hsvONbb39HKK/ncptmskdEgvv3qxCghCleZGuO3Mt0kGHkuUCyt1Wr6padGki5V5D0aR1RkDfRkzW6XgzQJTTRsX0WFT0yuI47TEIh8Afbs948SJgNSHfjXx0AF8hLA2gsP1iwem0ow72Cx8qIRSDRP5JHo3ZrXb0CLX9/OoUtCTSDtmNmxuqDDq2YyXG2p5eXLJHcE8vLcq5PF+A+Q+ArrZe3jLktffZrYURxZDwNna7FacGR4bhyYb9Zf8NaYZQaq5qes/FgsKKrhrt9eZT5wlc43WDIfuSzP07HYzEYtJxWWEGJFTQIHMzXPfr2qjJZlDWY1sSQDdBAGnm71YWARV8q61XXVMlMMUk6J41MAxnVPDe0rdZ4qYP9+k9pblukV7YykQJF10BM/lsMv+IKdPTkP/p0eushLIK92lAvrTAs+lwtSW74yg1ntGtMKfMz2J1+o38d7orhuwusPHrSLjvpmZJ2cKpljku0V+u87GNGXfPGJu4khqbYqIc47EH4BLQGp8ep0qhftuSVk8jN32KyiUieRKPLytL+zdwFSqAFldgfmv2bdQ7Uj2u7UQd0DwC3kPGOEOWsDDV2875PZCcqTvRgrjPLgyQ3vbWmINUtJCY2Yh5XValvngp7k1ORbok+XTL20ayilxgrs51lLJQI5zq5rDcvzT3rF5QVXa3z8N7jJO0EJQ3C2q5j/QA4QW7Jpny4a5v6GirwUrZ4mzJ15CrmxqcSROCn1oTT5JO3ASK2aal/3SpCjzY3FrRwqeAQmEDQZCnrTMunhvxE0kjvFBcKwMduF42RUNg5fgkSt0LspXqKB+T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(136003)(366004)(478600001)(83380400001)(110136005)(54906003)(41300700001)(4744005)(122000001)(7416002)(55016003)(9686003)(316002)(26005)(8936002)(52536014)(5660300002)(71200400001)(38070700005)(86362001)(66476007)(66556008)(8676002)(38100700002)(186003)(66446008)(64756008)(66946007)(4326008)(76116006)(7696005)(6506007)(2906002)(82960400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Y5i09wxTZeqyk3cirEV7liIGYB0uHot76eONV5OSC7doxmyxabPafBBe6eh?=
 =?us-ascii?Q?Ow7V2De3aL7NLP6ZCZb3y2wnVVwZsSJrrbUjKMaXnBdG9y9x/0F/pagb5ODR?=
 =?us-ascii?Q?xTZpbL0bao+PTfzjDg/WDNie6aWRjjyy9TT21mlqPkzn+HarrE1M7RLdLDu+?=
 =?us-ascii?Q?d4RuSOeYBe3nuiiBPNGZNcv3v7iT+iX66Rc36S5DWhIoNKWdaH58V5lyY6DE?=
 =?us-ascii?Q?ZaH+tshUoaLb6tcf90l9hiV3nDb3++HBi5fb9vD4SifuyenAwMIfLPpXzzFp?=
 =?us-ascii?Q?vvCeNUAi+HhGReoXr9GHQW017PEEye+Da1U1+7MDDgEYrvhc+Izj+oWin0n2?=
 =?us-ascii?Q?OB7K799stxn6x4rQ552yReLF3pCtS+HIWhBluMRvaoYDAlk3kPhVq2vbvLpO?=
 =?us-ascii?Q?TDXuWPCa+a3f3ZDkWNrBmZuV0aiXbl1oVJjZ0dZzO7HEOd4hfBmOGqNzKrUP?=
 =?us-ascii?Q?uG/ZC4hWvNIZNDeaBXF3qk+266Oe2C2zRXJx4UzV4Jx3r2EPKjzR4YtClDy9?=
 =?us-ascii?Q?9WfnwCndfEvbR/DJQak5g7y7x0oYgzbZEr3oo1gJAsSTHhQ0DaKcdVl9Op2w?=
 =?us-ascii?Q?IFVVPiPMypFmz+GZK61bljo6EDGHTtBD1OZAjTVuwo3kf7bW+1fI0T7S6ckr?=
 =?us-ascii?Q?cAn32UtyFVM4q/NQl0plass8d/ImPgKX50TffH1NDbEVjvVM2gw2rDQKImSw?=
 =?us-ascii?Q?li/8yUOn7CDUQNROVoekr9IlLJbOZ3adQNnea1m7LumLwR600kmL2p64i9kj?=
 =?us-ascii?Q?11/JjW1vovOW52lCcpQGNKqTFzLNIDwq4/CsCmQOupVso6QIYgT8QVFZJIyB?=
 =?us-ascii?Q?9oJjoXbWLyeyu6OC1HkEY6gGN/wgvC5A9T6VCKWb9wsSVMFyOXK8UkcTI8kO?=
 =?us-ascii?Q?hrIZpVQK/EnLHke1xOCtuatrdmfvPaft/bqc707mRbEvuXJ6PBFhAaf/Na2t?=
 =?us-ascii?Q?XeRShRVKixud2tSGV5P2Z0E5kSGEYjBDkR2klTNmuU896Fhd+f0C+B39OIMK?=
 =?us-ascii?Q?Itb5oyjJEC3joQtKyjcx+ycIdwsx6yFfF2Qr2vqNpvUL+79WfXYJa2h8mwwG?=
 =?us-ascii?Q?Bv0LGHz4bTTgdmtFXE07gjeoQa9e8MLf38r2fKHU7I6mKt8c6IkHzsxfYdGV?=
 =?us-ascii?Q?I5Ibno7BkfCxlbuM6SBg550GqUYILGcKeVGafWZnoh+w+BDeRsGrTz0PVmRT?=
 =?us-ascii?Q?LlYlx5N33Zg71mZz/WKPXbrt3X90Mfjbcbwnl5LZw1wLJq8VMPvoGeh9aWni?=
 =?us-ascii?Q?pSnXZ+2tPuOHALrLk0fKWd2F2cbroOEaqh8LNewg3nP/7VD+t0K3DVdT1vJx?=
 =?us-ascii?Q?c3QXCv9acDeDgOHAUHFuuguhiDtqN3bsY36NngV1dIruH7MVKXy+M9Cisdz1?=
 =?us-ascii?Q?hG1g1h8Gtt5mbdcPPXtOBEYi+C0nUHbWedirSBMcO0OiP/J99WoZc/fkzrRa?=
 =?us-ascii?Q?9fDc0yxUEY4mrpvk99gqHWO+DNT5FI4UiDTBteC+ClKwI4S46OE5Mk2yBtfD?=
 =?us-ascii?Q?+aI3GD/6fwB2b1MQK3m96bYUf+C17wK0xaRRb2IpFMQLqUUsmx0Mh6fjFP0m?=
 =?us-ascii?Q?DLTrF758EVul801S2uN6sIDLpOZkYY4r48N40PL2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1286d451-c09d-4266-910f-08da5fb42a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 01:01:02.9481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJcwMEvNyac+w1n4zXiMq0EZeUrdthmCdNw+2zZxAL2oXfvslPu3VzJmWx2htKZ4Dt/4ecfCkgExLvYlgBrgbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Saturday, July 2, 2022 9:56 AM
>=20
> -out_unlock:
> +	set_bit(num, iommu->domain_ids);
> +	info->refcnt	=3D 1;
> +	info->did	=3D num;
> +	info->iommu	=3D iommu;
> +	domain->nid	=3D iommu->node;

One nit. this line should be removed as it's incorrect to blindly update
domain->nid and we should just leave to domain_update_iommu_cap()
to decide the right node. Otherwise this causes a policy conflict as
here it is the last attached device deciding the node which is different
from domain_update_iommu_cap() which picks the node of the first
attached device.

Otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
