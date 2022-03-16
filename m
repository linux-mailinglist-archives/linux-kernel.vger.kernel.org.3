Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF14DAC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354371AbiCPH4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352251AbiCPH4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:56:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1718A60CEB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647417309; x=1678953309;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=aGPC/AzOgIBprJzGoTgLxNHWhOi4GhuR7UIFn/FijQI=;
  b=eWiFS3a4wMkTPoJ+7jW+4FXu8C47IkdJgNzpMZEuCtL5NJfmNuCtblLP
   IH1ItTzGBPCmAveOucDFroozO0M4brkW5a4H6QuPJSKMat5fUTqNGhAIp
   sZegpe9F/j304kCiIWqJY8LtyhJ0RmlbPLGUizJAXY4JkZNAKZVb54ELi
   eh08qYpYnVHYE/h69ODT9ulfKTS7JB5a7mT4VWbLlRWsEMW+q179BYqWr
   qqOWQD+rBIvDqx5mCLQ/DXMr+N1+TAH84dMmlFmtL8B/EkoKmli1nkLNz
   YFAAgjSjnRWWUC5kWlRouTVdpd8w6gdQ33qFLgXTRvumBPoiHj1zWLXG7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243970786"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="243970786"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="644563045"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga002.fm.intel.com with ESMTP; 16 Mar 2022 00:55:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 00:55:06 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 00:55:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 00:55:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 00:55:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMaMPiJx1C+VVFbiDfdjvnsBiqjCnlhOlU6+qf0bDZ+B9ZWbdn4rGfW1XueWcmUFReH6fnh7dVkVPqbAyhQaF9fXvSr05Yy8CSEmeDOuSYSvh/PQYqraEpV6kBOL1/yOTYpGr926UA5K+JxfTLmdFHGKwDnkXxecHUWjmX9VAILSi6T29eo3+I84fTQgFhhD1llkytSxMXfF7KwfSxmFlSW6qjGpx095pCPq4tNjtm4kG1S0F9Wy+ZpJvA22n71R47kHRNNjFGUbuNAX/WnyC2gQEto9otwTPFAQuFtbpQZDcgUnjD+HtoeprlI0c3AVLZLPrQI6iT54SN7IBhLXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iwmWrNImWAgwZmofl0cDNohud5FvxDmDnFu367AOrI=;
 b=evEeGmVFytS19MrEIxBaBfC4DDnGPgNulM6sN2zupDoIhwxAO7MQF7A2kc4z/aDN6K1AK726xBiIrosQggkpOc5XwNJHz2QCQQmXaOjr6Dsfadmdz+8kWxQdIYC1IYfA4o8kKHSIPvAm9f8Vux06hO6p8b3VdlMSsGh2lrH2HNMUD3t327JGd6ihTtDn+TkCn+8flNM/x1RylEhgVdwgjL+32VW8ZYewtkD5iyxa9AF9klLwz5dtkSRfAtwImq99qoFuDTUPrbuYu8/DRvnTk7OZFveNJh2vrHGc/UZDmWe2UhkAZ5X/1W4DKALfdcKPoyMJ4tdnBoyxtLCJRWqFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22)
 by BN6PR11MB1620.namprd11.prod.outlook.com (2603:10b6:405:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 07:55:04 +0000
Received: from SA2PR11MB5115.namprd11.prod.outlook.com
 ([fe80::e12a:51c3:128b:4cc1]) by SA2PR11MB5115.namprd11.prod.outlook.com
 ([fe80::e12a:51c3:128b:4cc1%7]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 07:55:04 +0000
From:   "R, Monish Kumar" <monish.kumar.r@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: IGNORE  THIS EMAIL [PATCH] Revert "Adding quirk changes for
 Samsung X5 device"
Thread-Topic: IGNORE  THIS EMAIL [PATCH] Revert "Adding quirk changes for
 Samsung X5 device"
Thread-Index: Adg5Cu+7hRd2iR8qQ3a2VcYKdofwQg==
Date:   Wed, 16 Mar 2022 07:55:04 +0000
Message-ID: <SA2PR11MB5115A5586E4D0538D8EC2394C3119@SA2PR11MB5115.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 506be9f6-3921-4976-58fb-08da07224842
x-ms-traffictypediagnostic: BN6PR11MB1620:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1620FDBF09E9F0BEE2014490C3119@BN6PR11MB1620.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSjDZcombvARVJeWYM/ICVmctIT4g5I66zAq2lnCK4PvS5LbAp6mxSUwl1pCpz6BB2UUxvDpqT2N1C6SegRt6jqYZ1OTDv1goevfWDVTlY+4wkQP/KW/B1Kn3QxnDf3j1f4PozlAgCu7OkHBHFbG+oKP3f7mciKa2ZtL0X5yDDm+yZkne6qMsw99e4a2y9rhks51WQueJ7jQna8yd+KrFQz6P80GeET2J4KNBc2oy26UNhkRdDSUsxGw4dX8t1oncarBB7uiJOEYg6WlaUpQWk3GKBuHLDNp5uIrqXHjRm7nQBzeF/YbmzCMkwAgHi53lPjF9BOgm+UQLzJKGWgd+j+NpxzYho2jVKjUgP3yBmm2/Qhdt8xgo+pD9V9GZMlhIoPxtdbTI5DGsd6Ei4ypLZktUVtInA4Vmb7sXmvasS7eovr/NFCR8PJ2hWuHCCoZ64GHSivEDysbFXJvpGyBrlm+q+c4zX8G8zMCo8jUBAQvBh+LSNi+61Z6uG6cTq2PRAihECqAaIKshiWnVrYTAeiYYjpM5Ui26Hebe5r4N2Du0wIL3QQ6fYBhRM3tbg+/h5SYuz0d6Od4wEqfO9rBlK2i5sxPhHDqCn9ytk3MGgez3flgmyV+yGF/cI1c+qho+ldFPvBRPwbOmPp7yt9/t9/T6O/OQLUOkZzUBQOu6wE78pwzI4yQc87IU+gOycoLx8JUk3z2/sgaT62TSgs+tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5115.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(83380400001)(76116006)(66556008)(66476007)(66446008)(66946007)(38100700002)(64756008)(508600001)(53546011)(7696005)(6506007)(33656002)(9686003)(38070700005)(52536014)(26005)(186003)(8936002)(55016003)(110136005)(2906002)(122000001)(82960400001)(86362001)(316002)(71200400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oipCWAxoIuXGDwzQyDovMUqnditPBojE3ygGNlyx4e+OKK0dlLu1+z0Jcj+h?=
 =?us-ascii?Q?ATtsiPGwnXKOxSJDQTwZcehyMWSuM4bwQisMkuIiVh+BIQPU4Z6o2duI+Vb/?=
 =?us-ascii?Q?WAQ501BkRYKPc/+OxakoX5jj0f4RDJlHcmELkda+9k8oROzN3G8z+UME03gU?=
 =?us-ascii?Q?8ErEGMkFn3QGBJStWztg8g5JsbkAQRtDi335FHO4Hu9p4yAhdPRdrGbXV+bg?=
 =?us-ascii?Q?tSKfJ7T4vGStCsGhmv2jIow3UWC3F1weHdW60JWMwD/6Bm9wTwSvf742l8XL?=
 =?us-ascii?Q?JgEvNi3sm4dseItWX+SDeI5vi97qZ3kdq3tFXq/5HxajlelBD6vhflfb+seI?=
 =?us-ascii?Q?d+n7EfuNGhHqZgGSrg9yr3Kehiq9Zv6Vinv5xQVXozsOHPA5EwNunp+zQRDH?=
 =?us-ascii?Q?Z66EVkPowkIJX64sOP3QI1jl3+dIHgXf/jjqmOUk3IznOwPhl5Z/7UpFzm2K?=
 =?us-ascii?Q?ILIWbBe1aB6qnMZZdbHWkOXRjF+LaGGx7eorTeSYDmNw64OOVWUGsH8VHcXl?=
 =?us-ascii?Q?YXxzMjm5bSC+2wD0UIefja5nCmnVKBLTjIc9oA9AkLCe45wRdP2PIzlR/Aix?=
 =?us-ascii?Q?hpIitNR5EV62ows+KSft11Mv1IVskNCYXuZrlGbozRZ3KiSThqUriCMoQEud?=
 =?us-ascii?Q?Zj7khwSAiZsO8e8g+zj8g6cRSkW9Wp+SIQK2HTFAFwk70bLxI8s+hRzOarqc?=
 =?us-ascii?Q?I7ggUYkJ9AcS0oCfgHu4p97EjijCrrnSQ66lSXd5cXm7EZyRLTeu2JGL0KDw?=
 =?us-ascii?Q?gs8lHH/VFlebUZYDwkt+kHLe+w5roy2A8IuT0NndCxIXIgAfcCdv5ojM9HvW?=
 =?us-ascii?Q?XnoFvEjfYFcArUTCg+m7LamDSXrbU8OjDBVulMCPmzM5FDS/41x1cBeTt1Wm?=
 =?us-ascii?Q?LSZ4eXolfi4yUvWXYufW+puV15UMY9Bzx8uYd97aeSehhvaUcaJ9V4bzzRX8?=
 =?us-ascii?Q?8em1r3qoe0C3mH80l8g2/1x5CsSnZ3lye4L+23z91m5nxCBrzFFcJ1Pcq1mi?=
 =?us-ascii?Q?+Y18ZfCc9J9i9OL6w/TTvIUjCQp3QlN2p9wG4DWExTYVLCdPKOyuK0/+pFkj?=
 =?us-ascii?Q?hOFxW1y5foIegSEdP0fBCnvaFSHa2J51kQMaspVOCeQsQszTb7ISCePDZ7WW?=
 =?us-ascii?Q?riswRV+f6oV7tzgf8gT3co2/W1WtaDFpeZuDW/fnsn+RUzU4dmbm6YYa9Ufx?=
 =?us-ascii?Q?t5w3Frk4Mgnlobmx/DI81+4dpYGDDrlmLsxS9JpqR6/+KaktVmUhRig47WkW?=
 =?us-ascii?Q?MPeZBfdcbeMPRUgdu5d1t6kA6SML16NMIL4Ni3+DnF5b/Qj/3S6v+/ij6eV0?=
 =?us-ascii?Q?/OeqnRMIXYs4CvMNzEzpoTrtTDo00LpvULqI1ynQ/NUDCqXYVYs1v+LWr+RM?=
 =?us-ascii?Q?FrGO/iy3LSNCm7DKrD8fjV32jbA6D9zPRwk3S4Cio/cZr90IGcFOSfpf8s0G?=
 =?us-ascii?Q?qKhKslzl6ltFUHWpMpAD4TU9AkttHQe+wRqBd5J8Ifk3sOFzlyJcMA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5115.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506be9f6-3921-4976-58fb-08da07224842
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 07:55:04.7999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdRGWlel46W3wfeCq1/1DjX4VKfUIyUlJwK1Em+dRD8J/SE9qlMe50QVZC9GR2WmSpJYaJ1VOUM5gNzMWzDw3Xzj7l7faYqv5mmUcg8x34c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1620
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,=20

Please ignore this email.
I will send another email with patch having subject nvme-pci: Add quirk cha=
nges for Samsung X5 device.

Regards,
Monish Kumar R


-----Original Message-----
From: R, Monish Kumar <monish.kumar.r@intel.com>=20
Sent: 16 March 2022 13:23
To: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nv=
me@lists.infradead.org; linux-kernel@vger.kernel.org
Cc: Rao, Abhijeet <abhijeet.rao@intel.com>; R, Monish Kumar <monish.kumar.r=
@intel.com>
Subject: [PATCH] Revert "Adding quirk changes for Samsung X5 device"

From: Monish Kumar R <monish.kumar.r@intel.com>

This reverts commit 1c1b18c97b441cb1a4eb9c6e95d9c357b687cdd0.
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index c01cb3=
81c3ff..8bb184a7479c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3463,10 +3463,14 @@ static const struct pci_device_id nvme_id_table[] =
=3D {
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
 				NVME_QUIRK_SKIP_CID_GEN },
+<<<<<<< HEAD
 	{ PCI_DEVICE(0x144d, 0xa808), /* Samsung X5 */
 		.driver_data =3D  NVME_QUIRK_DELAY_BEFORE_CHK_RDY|
 				NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+=3D=3D=3D=3D=3D=3D=3D
+
+>>>>>>> parent of 1c1b18c97b44... Adding quirk changes for Samsung X5=20
+>>>>>>> device
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
--
2.17.1

