Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A083A504CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiDRHBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 03:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiDRHA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 03:00:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D646165B6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650265100; x=1681801100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hny7YM6scauN0Vuz3ZdSxUnT/xs8sqaGJPwkPtg4NA4=;
  b=OoMaorhsgzpm7fQuFuqlTyqqtsSLFHBtsUkMKIl34qWOmE7Q38MKcctf
   8n+dcyT3WJDDtsfOrLtcLVg56qMd9SzPkj9NcNPySX8XhsAFv7g5J2k5N
   jinIbbkbFLHqT+ZPIHrhxnlq9+5CS68BJHCPTzVykYSbClMbB1zGq51V7
   75FT0WqA5PcSDAZPQgH3C2mn52HCi4NKxsr0YDpKfzm39CsnWdriMeDST
   MC8Shmf2+v59x0JWfK7bqZFzFRGUM/GOAt3ppro+0rO+OeUB7w76kOpHI
   nOTPaoYStsBtvhWTsBJlNlNIRmgrzpd7F5llGikZU1v4atkJ661RB+KLH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="250766750"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="250766750"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 23:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="528760374"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 17 Apr 2022 23:58:08 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 23:58:07 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 23:58:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 23:58:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 23:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC+9+3kLKyKJ8w8MRzZ4squF5RxwEycxea04R1IoJdzDzR8eZA88u0LWpc8LWcu5PJABfb4SRFCPv5rVGtzoCTmbXXRbyT3eDT1ThxIVAvNUNwtFdi1OaKM8dBzJwksedyWH28q3D4Y/ITM0sOC38cwRFK6SBInQYjNVftk7iZzqvWjb7gKGhGiNlYIQZrJUugXIACLsbntfRBuL/ydhc+KFnl41Ebhvx3TbJu78ys/FNL4/NvPevYPzJUXAfJvwvkj6pVg3Pqg5HlbwNmlyhO3IVn2Jy035L3TOWvWx7LgL60OAdNfy2PZOYcFypi2TA+XEKB/gS2xg2FSd1ScLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGouHQMlgdFryG90YVkFJG8jkLMkwb9yz/gaBqhObWg=;
 b=VBQ1djhLbhQOYGAAWbMIik98bj6dmF6JiRpsyXnU8moGN9u540xbLs9En6knXy3hlQwAaI1NZDuN5ybRGh3iglhnMnuco1JGc99kd0bWbgYgtUmtwh9aj9ryQ7TEb8MZW02jlgR6D59aJx99836lntCWEWAyU/ZiNxGVzsPCGT4B8274l6aUsBj4U5kJnBlsbpeJ+yPFJCRVJ3F2tgLxoj9ScmvGm+QotVUpeVwfIQYieXuNiVqLKbl7ONKinxW2j7yBWeMWrXbkvm+euFlXmaH85PBd2wq2O254Jn1pszEJaFds3FSdqF/0wcLYt8kLeUNknUnPZVcZw9Xygu6enQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MWHPR1101MB2127.namprd11.prod.outlook.com (2603:10b6:301:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 06:58:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 06:58:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH 2/3] iommu/vt-d: Drop stop marker messages
Thread-Topic: [PATCH 2/3] iommu/vt-d: Drop stop marker messages
Thread-Index: AQHYUY42a6XBNItalUuYhHt6UDvifaz1P7fQ
Date:   Mon, 18 Apr 2022 06:58:04 +0000
Message-ID: <BN9PR11MB52767F7FCE2E82106ABDEBBA8CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
 <20220416123049.879969-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220416123049.879969-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67dca861-f572-4a58-c952-08da2108c964
x-ms-traffictypediagnostic: MWHPR1101MB2127:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR1101MB2127034B3350FEC2F4A1B9F28CF39@MWHPR1101MB2127.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DCjEqoXBBhjtFSjJ9+fXpaz7hpNZBZAMlm7Z5y2FzWUJtg4aN5r+RNYQu8XyNU/0ONfTtpR0co3uW52xlTODxtiq/Cw5fE965JUYgYgNHsoUYLNNATeihw9gQ77HHwmSZJqav8a4kZf85PB/UaZ1WekckFOBvHUXAHiGtqbVdvo86imRlOSfOODjFF4YqLzcVVT/4Gu6CnJkgVuXhnY5h7kg32FwhHY5gZwqz1BohonWQsnOBS/6rqExzDrk7nP1cOmjTqTgvzm3gosQSFggM1Igzhjc1Xs2Iaow0J5/aV1P7FQO/hxMMm2fNXTBy/QI+e9d/pKKSSstx+Mph3ODvKmWbg7W1WHiOrosJs3aO2nXqEN30PF476z7r4uv83aPNpCOQCVjWHYclia4Br8ryyunmqM065qGYZDb6zePQQtuqskmQOzjtz8/oA0S3NKXzi+Pq7f59Fiu1aeSFArCfBfl0NX7PsWWHHwYFBQfThFyoDE9WZ0KuFDyyimWBO3a4b/eE/0ikd9lu3hcVU8C1Xvy9mTxNy9E3yi/yydWiaT4whurNhGRjHHYv/q1gS41UKXMgiGBUosRnnTvAVz+XN1UhY6IVf0qpyh8eCBL87KfkHpGhEHdStfP/NSkVUp4Sx+atmz55XuGgJHDyq+omaYoy3mcaXh9bzs2CUWjVjS0IJKxILSPALQxnGQ8UrqjAwAOP2ec5a6PeBs/sq5LTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(15650500001)(71200400001)(64756008)(26005)(508600001)(8676002)(4326008)(55016003)(66446008)(110136005)(54906003)(86362001)(33656002)(6506007)(7696005)(9686003)(6636002)(316002)(186003)(83380400001)(2906002)(66476007)(82960400001)(122000001)(52536014)(5660300002)(66556008)(66946007)(8936002)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bs0/Cy6ZfnDQlOAo54sJ9lQCsA4yNRhACNa3cKsJEFrIOZck+pLOxNOC4WCv?=
 =?us-ascii?Q?mnepzLC6uEsfQKWXpJ/Y0Abb4KIzywVt6GPXAoVgh6FWv9EWWWH2ZPYE97vV?=
 =?us-ascii?Q?B62xDFkft0JBg56QsgCGckE7fDYOQwrvg+u1tNzAqTf1YU/soDYpoZYkVL9F?=
 =?us-ascii?Q?UDlAFwfFiIenENrh+J2aWTlneMvOmN2moX5H/WG/bwsfLfuqyMviSRCMANLd?=
 =?us-ascii?Q?LL4KRh8/jhwwCAxgRY1Ct2HtP6wR4glQ7ZxRIjHmaXKL0g5mYX56NtJqh9Kg?=
 =?us-ascii?Q?2ZhAyiRy2yubFanrmrjnvLQq/c6p2rMlW8WGGL8p/XKtCI1mZX7L8v3uxzcS?=
 =?us-ascii?Q?RUkbUVBvKRlLj9ilgYjmZZA8yClpWcKsO4JT5MBhZjHJ1tmB2tI9RgIQbK7e?=
 =?us-ascii?Q?MMHhYSAvmEUVLolo89Ihxvex26ab+VM0ddy+gjQuilSDvFeyyVinCP+k4aBQ?=
 =?us-ascii?Q?z7cg2aC6g6SqIj0LkEkIhJjmUPSE6i+hqn6bcBBUdbBvHzcHAZW+34UBQB/Z?=
 =?us-ascii?Q?CjihvJuhE/CnvzLArs9ybB9LJvNDei6QIPoDiO1FBEbAZsUWRb8838oDWdmD?=
 =?us-ascii?Q?xq1elHl96wEkkxHrVeqtFZHaXUG17cjL6f0lx1WVNxLj+EIBMsJo6jdigsZW?=
 =?us-ascii?Q?4yK8c6kv6y/6IOVuKYwA+ZeG/L/zlQTercZK6Fr6fALAmNN8jg9OoYoTGd+m?=
 =?us-ascii?Q?2xNB/w3+HulE9ihufRKsAySbj2hjqa/2GK6PdUKf8s88efflXcGE8Eaj3zTQ?=
 =?us-ascii?Q?JxTcLQQUdcRzcrQxffXVeNXgwWzrIc9cJdk1IX+G2pN6UZ7s0Dst2Y3pzqHM?=
 =?us-ascii?Q?FbG3f1thCZXk44tYAgkHJvbyjQKNnO6y69V5F2+xnLCAWSLj7+jUN0QyDbo+?=
 =?us-ascii?Q?IR9aN5vAZnpWjZD2if0jivn8752wnIz+8hsFcpN3H2JcrAXPn2PXeJ7IHSXR?=
 =?us-ascii?Q?HA3i760KkslAdT9UBCvPnwCMEO0cPAvPi5zSwdhKyf/qiE8MCUw6EdWRtI5s?=
 =?us-ascii?Q?mpaNuDjM8IZMOiecArSb28k9uVV3DeZkwYIeg+OoQT23TmHG5Jqz5LfYUcji?=
 =?us-ascii?Q?sTAtqJlJWvzyaF9Rt98Df9A36QXRv6V444FH2HY8jfB99gHDeiA5taSs3bhS?=
 =?us-ascii?Q?vEZEuJvqqYdDyhdt3w4m3SqMwmpoZ+XmY0gDYLdKVKMRQ/jbWqFN8onKGD4E?=
 =?us-ascii?Q?DuDUrz8cL97ozO3kFoJSEIjxWo/jVad+c0URLvxWle/5nrl7Q6FLPEP0RCSC?=
 =?us-ascii?Q?8IIsW229QNv0O4E6HdxmnOzx5D2AakLDKFsZhqv1v55B0aSmKoYUSYMEuXue?=
 =?us-ascii?Q?81EgYpqFeeyoDjNQfd6d65L9W3wXUMOV7lzxYxOoxvp9ojZ/gyErFzwQuyOq?=
 =?us-ascii?Q?tAacGBnLQeMv8rM1TppRrXT2ohTAiLdXg9keeGC/kyK/vZKJ4n2A41XV+V8y?=
 =?us-ascii?Q?3DhwwIGtQRZpgRAb8dZ4V4AxakWm+H9d0fA2YjzmsByFsHYizhNi+QbaCRvE?=
 =?us-ascii?Q?naN1AJ8DClr391Jnw1LWGe2oVf+95yjVZybj8oSQZ4VxnGCcLI0aWIWLoJAP?=
 =?us-ascii?Q?e7Dd4LrvcRYa9W8dk3VQptPGUVX4DVLZUawJ1NyVF9WqfXdi7oH9eZREXial?=
 =?us-ascii?Q?3ZqDhf0Z5Z/2rGcV7BBTbYKnwdLdbA+bFCq49MFRPs732M7zh8F16D6D+LMS?=
 =?us-ascii?Q?fF6fCkMKon2rz8VAyl6GCcta8H7cBjdG/65WDWpzVHhIoMW26sbkkK6WqK1+?=
 =?us-ascii?Q?RWmpL8jCxg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dca861-f572-4a58-c952-08da2108c964
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 06:58:04.7533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fION5+7zOfQ5PCBZrNYZ3Es8RRtZP7t8HBwiLuS+hTboOHGCpmY+7rNQc+sKDn8Lcq27waneyCsMMOkuQWW12Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2127
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
> The VT-d driver explicitly drains the pending page requests when a CPU
> page table (represented by a mm struct) is unbound from a PASID according
> to the procedures defined in the VT-d spec. Hence, there's no need to
> report the stop-marker message in prq_event_thread(). The stop marker
> messages do not need a response. This drops stop marker messages silently
> if any of them is found in the page request queue.

The comment for iommu_queue_iopf says:

 * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must dis=
card
 * them before reporting faults. A PASID Stop Marker (LRW =3D 0b100) doesn'=
t
 * expect a response. It may be generated when disabling a PASID (issuing a
 * PASID stop request) by some PCI devices.

So obviously the current vt-d driver behavior violates that requirement.
Then should this be a bug fix instead?

>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index d88af37c20ef..d1c42dfae6ca 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -758,6 +758,10 @@ static irqreturn_t prq_event_thread(int irq, void *d=
)
>  			goto bad_req;
>  		}
>=20
> +		/* Drop Stop Marker message. No need for a response. */
> +		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
> +			goto prq_advance;
> +
>  		if (!svm || svm->pasid !=3D req->pasid) {
>  			/*
>  			 * It can't go away, because the driver is not
> permitted
> --
> 2.25.1

