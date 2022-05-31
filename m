Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4B5538FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbiEaLZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343764AbiEaLZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:25:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65CD2BB1D;
        Tue, 31 May 2022 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653996298; x=1685532298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zsbt4cux5WoyFSLCBFF0jDa/YwUKY73sHpaQsyFVSD4=;
  b=JsW1QybF2lgsixSb/b6TpQiEQ3EAKGCtTpgwu6mQdReNBKCHA472kz34
   5iJpaqZsiNINLG9ig0WptWuyYzhtExUzANQ9U2wf1PnFQJIdDC6cWjFOt
   D4bxCsIBD5p3FIZbqlEHlhud5/Aen2OeAjlGmXfAcFI+O6S4xx/8InY3g
   Xj005vBXiDNbV/MvWrhKIYzjFtiYEKCtyKXWEKunyDxQmWHmedSxjRQd+
   IjfYCZRFpZekUGlUYZ2xLzYkPVgymS5GRsJidRr8axzamKxdhn+LsFlM3
   ZXZpmoPZri5zxFTRsN/Uvrj2cDmhPcXRKJ5LRU9Mh7sPf9/vB8cW0Qamw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="255706598"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="255706598"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 04:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="720267864"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2022 04:24:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 31 May 2022 04:24:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 31 May 2022 04:24:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 31 May 2022 04:24:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 31 May 2022 04:24:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSjJzncHcQWrTRJHPxjHiMzNHtOgwU9xytI3Ok4JswuGk75LrJD9LD8fa10BKJymUbDkz9pe2+ptH27PWhbe63WmZN4c8tyluQvXVwkMi4G1eJOqWvaNxF83B2CT+YWssd9dhGZyUEVIkM2xTRU0Luh6GGxGTMTwAFXQMBp1iIZjcRoGbpp7VCF4q2y9+bpk2Ij3p8jAUqX/ioVs5CvgsO5hyihMIXroEylp713C5iortnPYLHYf/Pic7ItRqOPTd4kis35NsyO54NlBjwH738RsAtQMGc35z8ZP3xzsfqi38aNOk3SeMgo4jEQqKLgJjRxnFML1TpYUYLoI+Khbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDLiMA/pPi9eMQ6yMqww9wreanAxR2Au7bB/WF6/XqM=;
 b=IzMxe3/fj8qFkjMvDIWGyYvwc95ewHrEBTuLyEoR4iYRU6ZGrY+PfKhVpj75fg4mHp27iuUNAsmKX3irTAKkYkLikuqZZIGJhH1jhrqY3GakeV8go4R/lm+HzVEuCfIYoIU4EwADmV/+xdPmg9WUXrW33AlPrxmWNyuu0rO2jplmGAVDH/1NlVQBfm4ziEhaT4K9yfDUzos5Uu3dFyk/bDachALhf6EESuAVEsv1B2YbMU9OqkOhfOEosYE5sH8FKzFq/xzyHqCw7QeZCj5dX8TGzds0pO1NYpJ7SKcONH4auGZRYfba2RuPaKDlHrqViqRKDogOqk1x5Mvfpu1Qsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM6PR11MB3771.namprd11.prod.outlook.com (2603:10b6:5:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 11:24:55 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%8]) with mapi id 15.20.5293.013; Tue, 31 May 2022
 11:24:55 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Fix incorrect judgment condition in
 show_rcu_nocb_state()
Thread-Topic: [PATCH] rcu: Fix incorrect judgment condition in
 show_rcu_nocb_state()
Thread-Index: AQHYb+hwe8ZGESsVvU2EbYC8INN+sa044Rog
Date:   Tue, 31 May 2022 11:24:55 +0000
Message-ID: <PH0PR11MB5880D97F865580DFB6F12A9DDADC9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220525033430.1953349-1-qiang1.zhang@intel.com>
In-Reply-To: <20220525033430.1953349-1-qiang1.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b6fd156-46f5-4d7a-bede-08da42f83046
x-ms-traffictypediagnostic: DM6PR11MB3771:EE_
x-microsoft-antispam-prvs: <DM6PR11MB3771D27EA6A6E3E050D196D4DADC9@DM6PR11MB3771.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jcki0T1/NywI623s6oDbK2OJzGPR2KqgtUMZZCalwwluqI5DukB03MqyYrTCH0qNm6aeC4L70MfYLHXRwoeoSX9eynODEU8uJPRy0gs+IwlhEJP6xPCAyeB9o2591U9Z70nveF2CSFsI12f3SrVg8T1sLvsYSudxpUjaQH6c+otLtGDiTeisX8BMbpB+ZbBKxIuJv8hO0wZW6ha4PAgFIV6o6BLtrmyTGSxeMtarYkXtfsPzMa8xlAlhELvMX2SZgsAh/jrjZvDlNPg2WDwXM9pgSvXhF1GbW+LjLssHkxAflR4mZY/QoPzTeJK9dwkzl5ENyGSeS6/LSmlR4j56t9VYlrWsYpMBKxMh4zCxaVX7+QPCDFj6ZcXJKghPo8qM2WzKnBf9aKuvMUcjI/cuuHVaAtiohYWKRBDFHxN52IcHTk15vz/lUid1k4eNMMuyZeq+fbr4UuM5FS2l0mwQtOnH91ERdLXtd5Zy0JOhCSk+ce1L/Q0NqtVlyNMC01P4TfWqHG2sYIi/spu7ssGp+d99DQNhKZhsbplSPNMX5oxfT7tx6fVJVGC6LHgiUxscWAq/8C7yiN6HyDiA1V3UezumsOo86JlYqg0rku1nE+1w9ze2O0IiTg5taGQl20cNiGQGZXw1OK0wXGTCSIbMgB+Lf2CakDAkD2XMtpeHiPwYvIBArB0ZJbJnGr6CCjfvoIlKGy5Y02XCyEZnHpa4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(5660300002)(33656002)(8936002)(7696005)(508600001)(86362001)(6506007)(26005)(9686003)(2906002)(122000001)(82960400001)(64756008)(66946007)(66574015)(55016003)(38100700002)(186003)(83380400001)(38070700005)(316002)(4326008)(110136005)(54906003)(8676002)(66446008)(76116006)(71200400001)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/yU7YnFnv1i7Kj+OZ99r+BooUuPyGgK92/XCF99vMmEmUw/Pmn83UVGKfi48?=
 =?us-ascii?Q?v2uTUJL7ksFDk4vn8q022kTGrGckvlo3+XPs8pnAuiu+NTYk1UM3HDZ/If9h?=
 =?us-ascii?Q?CptoAzrOD7GXfSPngMMVXeQuGtTcVzPmnANU7b9f7IkFbwn78IXi2hrr5Cjt?=
 =?us-ascii?Q?C/CyCa3GFe/+tdLd0Z4Ov39sHL//N5DRFdF9hvEjgxGrmOZHif8+IfvBsUbM?=
 =?us-ascii?Q?T42ztgMHJMsfNlZu9Nb6trfXcnZZ5vq8ZNDKm47rrFdlef2qZf4aMpMwfMw/?=
 =?us-ascii?Q?Xg4Kpl9Cgwc1LQmfDe4dLhUrGag37sgdz16hH9EtFSqmP1bj9sGSRBxO9goS?=
 =?us-ascii?Q?azLPG9nXDFMUlVyUbQyPfTrOGMIYw8cV/pYG52HI7eB9pM5Ip4BUeppMsLei?=
 =?us-ascii?Q?GvKHKZKq2giO1Dhb5Dzxxg3/UhBM5rzkDlPBALyuXpTgpdpwj5+mNIZN9PZO?=
 =?us-ascii?Q?+/M9X9B+fue7Bv0SdXlpRL6+QmLM3a7TsGDdg7CEzznvvDQNEVducfvHAPwm?=
 =?us-ascii?Q?EAihor32ZsEqp1EykjCx1NUdKxgosUHR3eyqdPxcNeFfOv8WFpeFHO/kRqrg?=
 =?us-ascii?Q?aKD9pkD/gjgKzSwRVXXAGo+4tu5Rm4hydnC9gu7JXrOH2kOoO8hiGdhnzPxJ?=
 =?us-ascii?Q?CT9+aHJrl0pnFwaXZyKEqglM9uTwUvvG2Am33jZO07dJQv2KLOPqvKl5XfDx?=
 =?us-ascii?Q?Yjr96ON4eEu/kyu0rD5UolyGe3dFPFhGU+opOj37KdaRoWCAZ4FVM1KoiAdE?=
 =?us-ascii?Q?VenYhY3NUm99EJS/1BTRy+1M6m2DbTAEUp8mbG0+KFzVOA2wyF83+Uji/7fw?=
 =?us-ascii?Q?MDCKiXmjpw90BuqafWHSEXuT3MyYU+uEpbPL6Ar+Rn3rY0yPlgDMV75NLLuV?=
 =?us-ascii?Q?XN0+1QeAqLWpUcUoVzJ86Z36bPksOcGqdsxe+Hs3ifT348GhiXGSTIbhgu5u?=
 =?us-ascii?Q?I7OTCFGbw48mRUqb4XvZgeRgoyL+k10UVjuHLtEUUWVyTtFatjSHwF/EYTZv?=
 =?us-ascii?Q?9ADCgHx6QjKYIAX8dP4LsL6+oVOKERNVIo+9ZjkbJA6pruHtkunifB3BMfjK?=
 =?us-ascii?Q?qVl+vIYn44mD3LrRSQAdVL6e+dUiByx2VK4Bj4BHYDwG7zg9q0zbeL//WMQQ?=
 =?us-ascii?Q?z8AauLSiFZG1PX/3cnpFjcCNb0AhpfAn35bBQWZDrqhk576Ia+NwlazMVNA8?=
 =?us-ascii?Q?B16ptkyX08nRHQMiA9tpPBW7VAdmKVBZx505cYOkJMvCqneZLBol4N2JyrX+?=
 =?us-ascii?Q?5muw5MVhFhw5QvT9OAnW1qsb5tuO9slqutErPWTKqNC3y0PVvJBYsBtpPPrv?=
 =?us-ascii?Q?9LgXEAHWbZ1kL0fDMxgPmdDGvDwbaFcz8s/iff+5JW2C5+fJs2uotMva3sbV?=
 =?us-ascii?Q?r9zqnVX6x22ywzcHAamMVotG9liNwKm4mZeHIsK2qMN5hq/WysMw/cI38HKl?=
 =?us-ascii?Q?FOVdhcavciaRtzJ+SLaZArpMY+l/GgY+3RVb0fO05ZLsmViWYoeWbZcKmTyX?=
 =?us-ascii?Q?o7QQ3iiLLPAg/lcu9BIZkNWMWlvZXNI8tzJAnqcCKdFXNM84mN0wGPFZAAcz?=
 =?us-ascii?Q?LOHagY3tiq8C5oBeVh1Hfv8CnJLCRi16fcctJUZMHC0iQw49WiZ5CQZGk8/m?=
 =?us-ascii?Q?HrPdkydKYNyQ+Id/gf9CpeyfuimT6zQzeudvb3+Rt1s1KgzAO895YRVDEqUh?=
 =?us-ascii?Q?Jr0D623whEaHcr9HVLjWy84RzJi1E0HDYDWC1U5H3zq4qmFPllJpFmbF5es7?=
 =?us-ascii?Q?VMiErW4hUw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6fd156-46f5-4d7a-bede-08da42f83046
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 11:24:55.5455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZzJEU9zpbBpehILqxSLcQDqp+9GcyTHi5DGdv9I8S8QMSprEb0ACbni4vQ4/Btp5zy92glJdLA1B+1ExhX4rJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3771
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Frederic

Friendly ping.

Thanks
Zqiang


When check the 'rdp->nocb_cb_kthread' tasks exists, if is true, however
the output is the cpu where 'rdp->nocb_gp_kthread' is located. this
ensure that the tasks in the judgment condition and the tasks of the
cpu where the output tasks are located are the same tasks.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_nocb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fa8e4f82e60c..f4ee81d119c8 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1438,8 +1438,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data *r=
dp)
 		(long)rdp->nocb_gp_seq,
 		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
 		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
-		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
-		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
+		rdp->nocb_gp_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		show_rcu_should_be_on_cpu(rdp->nocb_gp_kthread));
 }
=20
 /* Dump out nocb kthread state for the specified rcu_data structure. */
@@ -1483,7 +1483,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
 		rcu_segcblist_n_cbs(&rdp->cblist),
 		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
-		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_cb_kthread) : -1,
 		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
=20
 	/* It is OK for GP kthreads to have GP state. */
--=20
2.25.1

