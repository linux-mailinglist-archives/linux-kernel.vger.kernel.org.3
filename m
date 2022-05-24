Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE72253276D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiEXKWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiEXKWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:22:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6397F84A00
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653387752; x=1684923752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OEXMLqv32Gzijx5ryfghJeVNQL2qA6od3WVEpB2evFw=;
  b=A1DQPXndd6RqpYBzZNBWL4WNKRylHUZkmZHV8x6NIGqs+pfQmhbCf4uq
   G7QLRXYHNCj9Kwg+i3hxwBS2mi+yIjDynlyBEuDj7F1aWJU3SmAMGZhIm
   VtKAx9jLzPoywmnUzIkNsVRWK/3n1XYQluG2JeHaxim2/uMcJjyYuNa4A
   UCIkT6u1qxznjUbIOoh+IXToJFI99yNnnJ3DteJDpaCPMwrSweaLxv9Wm
   oZYfyEDEQdsWaX9PhySORHXGlSrBG676CIbyBrPLuLX7U0ZJ65Yd1TBMO
   2xagJAlye7zNlzg35TKZqfVA1jCSlrfPABosUPwER0oiqvlNiXqdApgJW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="272309621"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="272309621"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 03:22:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="900987491"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 24 May 2022 03:22:31 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 03:22:31 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 03:22:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 03:22:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 03:22:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJEosYgmU22oN0FaPe6URtz1m9w+/doHt8c1ieztHoXwW5etprJpfM1bjam4lgvR1jBUeJYZEyw3s7tYkn2gy0ybAt1wSA6Iu8zpCcmqWLWxKSNCi5uCP2p16CK8H9plAzHSYq253FHfvwu98+Tjm9kDYvmKMPQhX28sgjKPiLC3EIRfg6SK80zoyS9U6TFKWcgDF+8srGYL8QogSGqGCFmFnED/PiEaON8VEgMvJ+fcwTajd3pebgquxIsxi0ES9CSgwwYHYbN4HrLMlvxKA2Eh66MBe30a2T5NEdJSNk2pcnGX5cC/e0yy+hSfJ2uufcOJA6X1uahkftOC4Hzntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq8mbEqXCWIhnGLFpE2zTtlALFWNlQOGLdBGed0tM90=;
 b=X9WXHmKY+hwwjfndtxsuU8Pq4G5fFnd0VBpw/c3K8yltidbWB462t+aE2jL3cazPyfTHYWqopgvrYDucAHrxoWnBPM14XQx+eQ4IpMeWQkNZzCGt8jwTPO3gRdOniCdo9fiuq90Fq+yre2CCon+dat5/9eFug+QWSV4sWWmhllThVnwSVyJ67VTD+D07yQuc3JSJ8oQ4UWUYC98AbC/94VlHRnRaG5/2fM0ZRggKl38NME4+xHwUxfaDsUvi8EYISwgGPeEjt3FiY1B83v0HCyyVS55gfaVLYsaciOSOikmoJOIJc6zIPmdlf2b7NpnyZhmLqUP371MX48iZrf0Eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MWHPR11MB1437.namprd11.prod.outlook.com (2603:10b6:301:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 10:22:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 10:22:28 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Topic: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Index: AQHYa1GHkRXh3WJ3kEuCY8op0Mm4AK0t2Dnw
Date:   Tue, 24 May 2022 10:22:28 +0000
Message-ID: <BN9PR11MB5276E462E3B32DDE54DD66418CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-7-baolu.lu@linux.intel.com>
In-Reply-To: <20220519072047.2996983-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8d0f12f-43f4-4b44-dd8b-08da3d6f4dee
x-ms-traffictypediagnostic: MWHPR11MB1437:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB1437678A2067B504A0A25BFA8CD79@MWHPR11MB1437.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mnLHazE++bUOiX/3nHYtpfiq4/R6G97fJ+CkPZR7pjVV8913F3QQV5neFrbSdvi1pgVbkBfmnOjLanHzLRo7jgexUB69+GoQZvwfKpI5FWMFALltm4ycQqeE12VXNdrR6n1PLTF7xYLgK0VMsk+MIB/D0wJYKdFLLGlrpkdJSHCMOhPNNwinhfPB6CylnSj3OR9YqMh8VBxdzuaDt73HYnslVIAgzDSsjCbAvk71p6eHY7Ty/pV5AhLxhkcGdSsZgjljAvn8u3PSw8s7BDoSyP499fl0CpjH12qAHahYaY5FsOR8I9wdm9efRLsgf0VhQEcLJ/T90aFbxP1Jd9kOLqre/3pdMNRpj18wRUqBFpV2G9tVmCxWGqc3W7A/qpnG+5qPJf52/Q/MurCK6WMlbaYkyNX1Eju4NMT29utO7vFA4HHzBeRptMC981WC+Ox/4ObHq6mgQeXdXD8kTgqNJ7PJAwMh0hGXi3MFu3rE5TcI7SnlIPjYLFsCeHIejUQQ9kk0cevG/eicXnfW1f6YGxgkkLvU56WaSuEs54kwA8ZyKHhx5HyEYXKrOHuq//zxIW3wRqB37QevQ7qGA7n1n9tT9yXhMyWKCKA7a1T+RJZufGFQ2VBfhT4TZFxgpAqUgd632dZhxIvmYDtyvhlszAvWfyc/G3HASfo1xONtWRs5tZNwmov61kZXeQbTcssX0sFM3D96WN0SF5zXTeP78v8xVHmMb04Yhg5E+8wazRM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(110136005)(82960400001)(4744005)(316002)(921005)(7416002)(66556008)(76116006)(66446008)(66476007)(66946007)(54906003)(186003)(4326008)(8676002)(86362001)(71200400001)(5660300002)(8936002)(33656002)(55016003)(83380400001)(2906002)(508600001)(52536014)(6506007)(7696005)(38070700005)(64756008)(38100700002)(122000001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W+AvgQzrevACTRpwChKnuYSrxW1f6Ok8K5z3pMb5dEUhLjmvo3aCdl6D5og6?=
 =?us-ascii?Q?crmnFfmlng95BR26Ml6FBZi0dvrVfxoKqeQneywg+z1VG6V7k40JzlPRYP+i?=
 =?us-ascii?Q?21dfAp7KkUdDr6OIXVsrpwcAdONV3MEKMU6HX5iu/bwjWJLlmVxLrZ52v+Xs?=
 =?us-ascii?Q?lUH5tWxmY40ItLMn/c4tOxe2EMnR12rABEgSCGxtfNHVzza3XMqwc5SoutfK?=
 =?us-ascii?Q?gx7VGlfoC61y2R5nRjKBQ2rGR0SzoKpjJrZlPnWKj2k/tlFl8zLOqcquIgtG?=
 =?us-ascii?Q?cFtYL8T6sZE4x6QDLQhMx5UXUXIblGjOfTO3Pu1e7R/MoDeKxHFsNYBlZ/+n?=
 =?us-ascii?Q?gsxwKdQotJI1vnoqOTr88Tmd8t3hhrmX9IvUFVf1EU200ACB2+Ara/9Gu/WS?=
 =?us-ascii?Q?I5U5EVRhEtGQALIWtDQxWy7WeLL/CUwLZ/mrfO1N5wDcnW34FmUFBB+A+YeU?=
 =?us-ascii?Q?DVFQcVXBIv6IKUC37UOS7L/nn3cMOM0CVq/Ua7fByL+EboQ24OfmafIacNWc?=
 =?us-ascii?Q?cqt5pILub8B/irZVQdZem7uFRuhhacVRaN+UuX7ZTU5a1sU5/zL3qq96DxvW?=
 =?us-ascii?Q?O8OVHNbKfyRkLtcDK/T+JLvrsK964pAIsyl/L7S3ZbEg5xPADCc997EMsLox?=
 =?us-ascii?Q?gwE4tuUpORhgxTlfion9vM0qCRGGtYmsa/uSN6uBt+E48klkNK8CreikcxaA?=
 =?us-ascii?Q?1mNBpBaGv4fr1affuHDAR8wuvXAgOPLBD8Kgmud6ZDpemoGaWD5n+S6YxdvP?=
 =?us-ascii?Q?G+BcwSkvxdrjnEZTNHszhM8ScUxUK/cqEUYTQj3wTVbaZWVs2vwehgCQlJh3?=
 =?us-ascii?Q?lMvtKa2AMITxBboaDD7d7N8dW4cfwT2CChtx1L1GtBW+558SOQnOyYGB9c/1?=
 =?us-ascii?Q?GituU9V2Jxznlen+UCmawyPmhTJBodnlR2F2FNgwt6BI414cUzHy/54szjch?=
 =?us-ascii?Q?mIeLL9diRgb5fsEaSdp91CjrZMNVZhw1NfUbjS4XC0qGYTnapsuaSut2MIu1?=
 =?us-ascii?Q?/nkIEjPuZdrdd6G8e7Wrxza9mHnnGsSf+P6AwdXIKGLMskac/EKC1+VePoJR?=
 =?us-ascii?Q?9knCLoIwIHw6yLOy/ey24eNdepndzywhDaKqaPD+MQ0himIu2v+HSDqt9JEB?=
 =?us-ascii?Q?q+uDuiXVbrjK0Q6KKG3cqx1Q3/N6NvRxX59BhqQGs+3PfrX+2jNNN6lzAWWx?=
 =?us-ascii?Q?Ff+RQaqNJuvZH2uWA9V0yukR8axGf9xuqULwAp6O/Ov3JXkY5Ehi+wnq4Fh+?=
 =?us-ascii?Q?gKPj+eMcWQhbKxUoEu+knTRVUUSqB79XbJ5/OWNeUe71FPdFc4fmrADyEDKk?=
 =?us-ascii?Q?iQg1EtnQhK048kj/MkJbNmqQbSfXvfn7HYzIzjeYQXAcK/Sg5lmKSX7t6GU5?=
 =?us-ascii?Q?U34iy3U6VuP1Jz2t82HUllg1Z1Z7x0gOPvQYpL+j6D/8AnfbLmJSgzQhcZNT?=
 =?us-ascii?Q?3qverin98yj9SoCBr4p3NltBU2DgKIaVGVhjQZe3n+crFc4V5ZBW9rWUJ6y8?=
 =?us-ascii?Q?DRKeI1qYkcp4zeTglAnUbh+nqP86Lckx4OaWdU9Y+iDVfA8OhMXvzfknfs08?=
 =?us-ascii?Q?+84IhgFKGaS6lPrlY5vOugpOU+zSNNSJl4QmXh6yISJv7hp8+UeLcXSowiub?=
 =?us-ascii?Q?R0LONoujyRdHHHZiAMcK03be+iQ+Wc7enslPbpvXe5VKPtjXX96lMgTIxBsB?=
 =?us-ascii?Q?bRpREtFprEYbmrVjFBBZkUqRc4rIlm9zeHF4LOftAu1fkyUZ3M2/fy8l9RoG?=
 =?us-ascii?Q?UgrkP7tlNQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d0f12f-43f4-4b44-dd8b-08da3d6f4dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 10:22:28.4197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcwIc13KV3hX5v+J2i2MIEX31chS7T6n/zHzsAOQXrsTgK3EA/K2CPwzhq8KYqTyfhMuWRozWQwmugUTlxd39w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1437
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
> Sent: Thursday, May 19, 2022 3:21 PM
>=20
> The existing iommu SVA interfaces are implemented by calling the SVA
> specific iommu ops provided by the IOMMU drivers. There's no need for
> any SVA specific ops in iommu_ops vector anymore as we can achieve
> this through the generic attach/detach_dev_pasid domain ops.

set/block_pasid_dev, to be consistent.

> +
> +	mutex_lock(&iommu_sva_lock);
> +	/* Search for an existing domain. */
> +	domain =3D iommu_get_domain_for_dev_pasid(dev, mm->pasid);
> +	if (domain) {
> +		sva_domain =3D to_sva_domain(domain);
> +		refcount_inc(&sva_domain->bond.users);
> +		goto out_success;
> +	}
> +

why would one device/pasid be bound to a mm more than once?
