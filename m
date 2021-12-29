Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4836248150C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhL2QOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:14:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:58523 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhL2QOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640794446; x=1672330446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hrk8G4LY+4sUVgeSpaXbbLaEcZw8QNcJq7EvOouNRY8=;
  b=JkPMpJk010U3M8I30bYoWInznOKRSAlAnH5aPCIWu4GrHyqBoxC8B+Y6
   2g/GROnBRgBpyxw/o4Z8N0INoTP7ZEvOdjdTVd02ZeADlZnFO5MhkPO9Q
   H3AjNCuUu4LMvtxglxRV8JUttj8Egr16eS3jyroN4ebUXGXZib+qeVHXl
   4ud71YHGmWeS6X5tpnlnaAZXOSIAm7rFnSRiWdL9Aoiwvr1xEhMXkhGzw
   1dbCwKBJe1G3wyKrGa8W7i/9mlvCMiR4codN4Vtm//sy+yjUUkmjPc665
   tEd1c593mJwb0uppoI9VJFRCEXvfiWcVMayhRIUxbWuQECcD9GZHJrbLx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="239081146"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="239081146"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 08:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666311687"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 08:14:00 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 08:13:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 29 Dec 2021 08:13:59 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 29 Dec 2021 08:13:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgNZcBN6BLfTRZEGUrJZb4IzxgpycpAPJ3JBFqP3l3DHjsNgD6tm35/SBu3Ginm6ftSzztvqYVjfj18oQNoNuEA2sjPuGLx5baOWRfEyRsDwjZjjhFY0RzV+r2mx/z/VHeW1uH+G5sIiE0TDIyQ9ID+wI0AG/my0mVFkPRtVSW/8dkJ8e+YHItTpJQs8FbPCyyuJ/nIW7l56gwC0yL7iNJfx9zSzSAw/FJpRlD7AirbOViYYm/hEJm1SOeKTGg28ONFYOmf4JnwTCiFA9GYd2wASPL8NC0hSmwHrgI6rpFK8DD515RchQ7MG508c0DBicdcgdEWYpVzZW/lNUSB1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxGZB1ITYU0E7BI+BKJcHMhtKGgww5yy4hVvOsEKKRs=;
 b=aOn/ylPkENrz6E+xd7zDaRsa1Mia/cNv0Iir8ICFE6QEmt7yUIDb9BZO+0ntOYCG+lTQqINFrggO7led9Lbu5kVlAFiRbxHyCfkD2t+72JQeBZ1cnuf33XH+gmmASp/jkU2D/6//xa2B2/w3cJoOqp3ntzGMcl70A6mBK2WbPdPP9kBfJV1moVd2DB8XR4GJde+erJBDFJiALnUKPWa1eL/prOdIZeJ9z/ZZ7fxSXlB5mv0GHV4aOOU6ZM4azX0us2+M8NUCXDlYqdvkhKCf6ayImxhcB2jW/K08aKKEiNWfXJTl4u17N8alReP5tw74iyNvJU/KOykhf5nk7s31mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by MWHPR11MB0064.namprd11.prod.outlook.com (2603:10b6:301:64::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 29 Dec
 2021 16:13:56 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9920:c2e:ef83:d62b]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9920:c2e:ef83:d62b%6]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 16:13:56 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Westerberg, Mika" <mika.westerberg@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] Keep polling IPC status if it reads IPC_STATUS_BUSY or
 IPC_STATUS_ERR until timeout expires
Thread-Topic: [PATCH] Keep polling IPC status if it reads IPC_STATUS_BUSY or
 IPC_STATUS_ERR until timeout expires
Thread-Index: AQHX/LjrrHoyodxf402g1xww8njLyqxJpH9g
Date:   Wed, 29 Dec 2021 16:13:56 +0000
Message-ID: <CO1PR11MB4835D217B78F17BA6AD79F0096449@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20211229132948.4738-1-rajat.khandelwal@intel.com>
In-Reply-To: <20211229132948.4738-1-rajat.khandelwal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mika.westerberg@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 754d96de-116a-4b8a-c2c5-08d9cae6374c
x-ms-traffictypediagnostic: MWHPR11MB0064:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB006480B2A975BBF88786ABEF96449@MWHPR11MB0064.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HD+apG5czsFTiMAA32kjokdmyulQzobUut4089HTkIWSuvJ3WUg1y46ZO1NrOTpizUtR5xyCwqa9Wh7l9aR5DHCOjScdWXMLb9psAB1q6Xx97FwIYfYh8YoX3+Ts+4Cu+q9K5CImBRWYRzyRzXvPR6YgriBrFlGtESuBP25s8qAdn4XZpGjIvdsH1iXSZte8prvp4VMh6NHGnVUOFNvpEL0XBw7WcM6K2W3qhcRQpKllBD2rcDGFvZ8NQe0G6GewkrfBf7YM/HSvIEfASovIYs0Ed11p3sti7hP2qN3R48jBXw5ERa70g7Nf9m9sg3IOt+SG9IVmatMw7qwY6dGzDog0JDPudJ1IxXUMPnQ4Y7S6N8mUrTdkrRKy9mmxWtNhQz7KPc5VBH+5pSL2aQdwD0Y1v9tmbIpeCgvWRBFaSCXNEd36iVHa63UwKa0Cj8uaE1zIoC6P1OLlGe5kCQSkctPpynTE5HcHhi1ElcYA/9HN9YuSZZYBk042nZhQTB6FPXNFe/pngI5BnzQxb0hCde3pL5Aw0TUJx3x6i0ZFNP0AQebNUhsr/Jh6eTkbpyK14xBS+Q5QPyc0WXVRAx36xG0o+Ten2YInuUYiRG+x7VjbTl+TBlY1ZVW4Rj3yFeiT05cxIIKSyT3kO3x29ayfGCCMpZ0jAMcX7fxskDNrRE+reDcKLAmJBZR9gVHMvZ1wp8tUKK+J8KPd+Vf+NzKuNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(52536014)(55016003)(71200400001)(86362001)(5660300002)(6506007)(53546011)(8676002)(64756008)(38070700005)(55236004)(54906003)(316002)(122000001)(38100700002)(110136005)(8936002)(26005)(186003)(7696005)(6636002)(82960400001)(83380400001)(66946007)(2906002)(66476007)(508600001)(76116006)(66446008)(66556008)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SnBtdBmfINNY7pnCP+Sq51avA0ZyNYDeN3MFXHRjOfn/OUi1Y0FA52eRpEtl?=
 =?us-ascii?Q?+j1xBia68HNcWdXQJjWdf0zUaaG951e88UgOnYx6WKTEGdtQvCfhZKCwueOQ?=
 =?us-ascii?Q?0R0T3qyqvSVxafGte7sicFUgfW0zq35TOFGKTmeuzVvoRIb9RMu1ahby5AdS?=
 =?us-ascii?Q?YDpZabj99XYj+G4PtfL73w7jEDh5nPXMBWQJ6i8UtATzQ6Uc51gy3H+fBCf4?=
 =?us-ascii?Q?sUU/v52+UN/6RDNWf3lG6HbWxYzxnZOovm15qwSTzt+0/jaM4Cv+FXrQDz4+?=
 =?us-ascii?Q?L0Nt0olIQbKHsgTir5mLcODj2elWfxVf8snEpcZrfUKCRSZA3ujZoiUF2NkX?=
 =?us-ascii?Q?TzxN+MjughnK3D7uwyqJ4ZemN8M8XlreWU+DRmifzUJliqOq6EEb+oPxNewO?=
 =?us-ascii?Q?7g7aTXuBlG3K6yu63jXVIC73nExo+enQtR8qjVB2qVXG97tzqpvWMz2bR2L8?=
 =?us-ascii?Q?0K3fT0OMdujRFkLBkgYO18elUrzKnRuG8JbusX74/8JA2G0MCltSyCZbClMm?=
 =?us-ascii?Q?2ZqY2niC7JlpfyFlXh7TxaRaD0Zcv1Xe1cMchu/D3DwpdDCNAk7im7YU4jMT?=
 =?us-ascii?Q?RNVEOznpCx14wmBRv8hfapcddpFK0qzCdAWjBDYQSTmlevr44hAdRvXn48Ep?=
 =?us-ascii?Q?l8Q1rdO5nmW+82VxxTpuhOP0W1jhymmItVHob71oKZqFr+p2uTOXi0cyWtQG?=
 =?us-ascii?Q?9WwdKGBmolmrXEJoe+fO7LrnB0avqZOrcy4iqaKR3eoA8L1dil1SHrhI+J51?=
 =?us-ascii?Q?CiLfIUkdml49sVjepIEDQEVwrZ/9Wvpq/tJkVpQUQtQ8SjJ4UDZml5OQY6uh?=
 =?us-ascii?Q?0hh4C8zPHhVXU2ZtRvspNxfpHghCfhtlbV3JMQ1M9UpDxMMPT77YtynI/tIN?=
 =?us-ascii?Q?zA3FphCLe+gWpAhZKkmXR+Yyqdm5510i6/8uT1Hz29tiQl620bflPeeVOQUZ?=
 =?us-ascii?Q?vj5xBVHGs5/N4DnD0kRroz8L2bUjqrWHitdj80qL/BDFc5dALQ80mro4fQDS?=
 =?us-ascii?Q?at6hD/bbAWj26QU6OZDeLb4+6Qm0EkyWSvEJjzQNfoU2cdl/+4nQV9QNPaxb?=
 =?us-ascii?Q?zn+GThI/MoMDP9p/JuaizsvcqtVwgjXVyrHDm6lnBV82rdyWO3ZpRrebO5SY?=
 =?us-ascii?Q?Hws1yBriZRDzdybvx1/+jGqAeGysa+/eQ4g165ldTA2VNsVhx0nTPkMO3o5c?=
 =?us-ascii?Q?Jkyf5PQXMUUniroHOhwJhsZdmoJIMW40ygb9ltcPmNMKdQTCoa9tNg+AJupI?=
 =?us-ascii?Q?6p6i0iSK0bXYI31akuhRupB8AY47spaZP/ZcdM9vf/CAGL1zubHfVpBdpnmj?=
 =?us-ascii?Q?0RuqKMn2KWiJvmM2BRR3NcpWci7A+8pf5cvfX4swXUHI7kRnhO1yaK3WN/mQ?=
 =?us-ascii?Q?OXkQ+YHkULJpYcZTv5PdKaURt6Fk4m7HoX3s2n6rRjhE3zFdF26cPAuXEzvH?=
 =?us-ascii?Q?Zfb8WRfDg/cBGrLVtC9rqg5ZAGziX8Y9ECERpGETZIkxBwbUVXakiNOVarsj?=
 =?us-ascii?Q?ateWeK+5iGXVZX4svSkXWQyremI+EtZUH3bGXiM2llexnfgmp+CPLx2nXUee?=
 =?us-ascii?Q?3WKFKDk4FkATGoVDGxP1Pldrv0ix2B8G6DTaCqTzP5FRWhjdp2Krz5lw+BY8?=
 =?us-ascii?Q?zlkk+v5PZmxrmC3ZjO1QIurM9gsU5K6eS8zorEsE+kBk+2fPwb4RyvmGPJur?=
 =?us-ascii?Q?fuZRiA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754d96de-116a-4b8a-c2c5-08d9cae6374c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 16:13:56.7608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6dWsnTCUYr4ro3LfVpjy9XYmQ9iA31V8uTfWEXzVjBu84IelSwpe8d4c45H2OoQQo5zH0onVT+xg7SoS6vM64+bmomPv6TOdUUR4McAoLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0064
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi @Westerberg, Mika
This was the original message!

-----Original Message-----
From: Khandelwal, Rajat <rajat.khandelwal@intel.com>=20
Sent: Wednesday, December 29, 2021 7:00 PM
To: mika.westerberg@linux.intel.com
Cc: Khandelwal, Rajat <rajat.khandelwal@intel.com>; linux-kernel@vger.kerne=
l.org; platform-driver-x86@vger.kernel.org
Subject: [PATCH] Keep polling IPC status if it reads IPC_STATUS_BUSY or IPC=
_STATUS_ERR until timeout expires

The current implementation returns -EIO if and when IPC_STATUS_ERR is retur=
ned and returns -ETIMEDOUT even if the status is busy.
This patch polls the IPC status even if IPC_STATUS_ERR is returned until ti=
meout expires and returns -EBUSY if the status shows busy.
Observed in multiple scenarios, trying to fetch the status of IPC after it =
shows ERR sometimes eradicates the ERR status.

Signed-off-by: Rajat-Khandelwal <rajat.khandelwal@intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/in=
tel_scu_ipc.c
index 7cc9089d1e14..91f716e84474 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -233,17 +233,19 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc=
_dev *scu, u32 offset)  static inline int busy_loop(struct intel_scu_ipc_de=
v *scu)  {
 	unsigned long end =3D jiffies + IPC_TIMEOUT;
+	u32 status;
=20
 	do {
-		u32 status;
-
 		status =3D ipc_read_status(scu);
 		if (!(status & IPC_STATUS_BUSY)) {
-			return (status & IPC_STATUS_ERR) ? -EIO : 0;
+			if (!(status & IPC_STATUS_ERR))
+				return 0;
+		}
=20
 		usleep_range(50, 100);
 	} while (time_before(jiffies, end));
=20
+	if (status & IPC_STATUS_BUSY)
+		return -EBUSY;
+	if (status & IPC_STATUS_ERR)
+		return -EIO;
+
 	return -ETIMEDOUT;
 }
=20
--
2.17.1

