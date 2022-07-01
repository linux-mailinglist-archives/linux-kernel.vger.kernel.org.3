Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991DD562941
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiGACpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiGACpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:45:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B5161D69;
        Thu, 30 Jun 2022 19:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656643516; x=1688179516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WbuptIixhhYsoIXnLhas7uY041UBm6czrk7EDxRIDxQ=;
  b=UxSEQ8Iiz/EJ6VvlpSLAVSXCO0ITwXBUwp2MjjjH0qJ4D2d2XaBOTIEF
   S4CpHTD/91Dk729gfsB0ELXaFrP+vzenGQIImM+/HKDUQKVhT+hSgnCmG
   TlBZe5mcgrcop49M0Oh5P27vc8K/mYNqHphwBv7dXwOcPUw4dLpBscDtD
   teQpCYWxlr/RatrptfFiotbwLLzLZzuo2AWldE3UOmd/s/DoN8Hir/HUr
   48NcpAEWDx1JAOtwCJuSz4mjDZzm187ViPN6DSzQFuu1fk2fEM6ol7AJi
   I397dXiBRJaSyFLp28gU6WghQXIZWkE3nSEOWlQROJCH1tD7E2knJlaF/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="308045114"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="308045114"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 19:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="648156411"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2022 19:45:13 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 19:45:13 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 19:45:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 19:45:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 19:45:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9SqxzaGFTCBbjLlQs7l0Q6sInyng8N/5td0t6EJrb/Er2Qkka1cR/MjHrVEI6vFB/YvHhN4Y55NKnMIfKPnioPn/fOZ/Zwns3zEhJHXOONnUbGJf6fz4Jyc2LE7hJTbpel4UxWKGNMRlZyzLNjJDr7hpkLJfv1Hd8vGL9pr18VMcZN297mTLMpMQfINl43kQEag/Ek9iMWb6z7qwtB6D7E3634ROYqKp1pKZKR9WYYblmgU3QpCqcZMiFF/wiu8NrTgzJTt7kwHu3hcJnYEuTSVq+Btsqt6IzF7qyxGCvUPQ3pE/fVdeibxUv0Xq3ZY1629oQhKPbqMi/jcNjaOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAXE2r7voZcWAwheftBKUoLr5SKj/O1B+7sPWNIfhb0=;
 b=fk+B586WZtUifCHiiNYBzqxe+uHQGwfDaYzlfnzvW0CDHmfPkSdAlhIaerFsN675RbNiu65gBHP2cKYx4jHwBze1G53RDZCZr48hoPXyGvWZtz94/kZRYr61q45c/H9UFlgUXGLVYXKBqhYmnW9TMBmSLWdlXHWWCblyYY14x1SfcunQ3owH8ALCgmzn/jSeWs9t743bHGboi1QmyScI2VOyiC45bNoZP8RhrtPddI0xYG45uZzE97MWKBNqgnhT0kAh0JNoT5mK14WLbYQXYr72wX6UCaKPPlVpqGtsxsIRpcwSFZcWA5+SbNGJjysRCiq+fdwzW2ZOf6vZONvP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN6PR11MB3533.namprd11.prod.outlook.com (2603:10b6:805:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 1 Jul
 2022 02:45:11 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c%6]) with mapi id 15.20.5373.018; Fri, 1 Jul 2022
 02:45:10 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Make tiny RCU support leak callbacks for
 debug-object errors
Thread-Topic: [PATCH] rcu: Make tiny RCU support leak callbacks for
 debug-object errors
Thread-Index: AQHYjPGiR9qq+LcmE06RfbpLQZakLa1ozxnw
Date:   Fri, 1 Jul 2022 02:45:10 +0000
Message-ID: <PH0PR11MB5880784F8718DC6F18E8E0DADABD9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220701022325.2228233-1-qiang1.zhang@intel.com>
In-Reply-To: <20220701022325.2228233-1-qiang1.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: b90fb061-ca05-4737-22ae-08da5b0bb79d
x-ms-traffictypediagnostic: SN6PR11MB3533:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ya7XhK6gp1RA2DVxHBNGv7TAxYgZ0J6klV6UC6R2T17M8guM2ttbwLhlq5zDIoCtnOdxQTcpGxhLKlZ1iSRSUuIkbWivz1NqDyYcbFmebvgNzPhK2X0wBBNIeLgQWgMIoQt/5UejH/jx2zX8MBX1PUD0OIC2OMwZVTqkBVHc1JcUtnmDqYG2nxrIOlt6IVe6mDWy3UdPo9v0+Zj2JD/rXmLVWnmpumuSN4WHuoUq+H5skUG5wAuKPrTXd6e8KYLA2gvGTF5Y8hk7rZUvUipJg/laUr05J1h8RCuXop0/pdo6JNayRKMcORhi1Xfyez6UR2DIvM8QC7Hzy59Jpjud1hCJHfHrbrED7wp0cW7MhjsSSzX6yAe0mjcU/BAzV4qIG2dHF0l/hYDxJjA/ZA9bIhvQMwAMEW4FURGih5v/rx96UI5erutpxYEiRCFXgeOu3lxbzQ/KNfWdf/k2mUTP3BM1BXVSEWF/Ny/DiNK7L5+LWXfMsdclG6jDRzx0/CQG+ed0ges8O6e/LTO+Ihp3Vd3CtuyDPIPOUPrgWisH3N3Of/HUP+QKYOi9F75OJ1++qOLfimHz6rd1JqTsaGHk/i5HztnPvIh15JLnwdAARsqN6lMe+QoMUJGbupozI/H4VWoE4fvr1xuKJQALjh3ns9eIDeRsvvPxvix4cW/mk8c1ssodEQpuBCV0c8YagnJJY3T1UtPjOwz5XEwNaDOLn4v92+m8JDIZ02ijr023klOUMdiGEqU0xxMQgDd49bP3t2k00Sl8GKHEdzI1EmSd6rzRY37bVfxAKAQ04tHtvzuxwpAW3wqB2H8dwcuZEicT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(376002)(39860400002)(366004)(186003)(7696005)(8936002)(82960400001)(83380400001)(122000001)(55016003)(38070700005)(6506007)(38100700002)(33656002)(64756008)(66946007)(41300700001)(54906003)(71200400001)(478600001)(8676002)(66556008)(2906002)(110136005)(4326008)(76116006)(66446008)(52536014)(86362001)(5660300002)(316002)(26005)(66476007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LpxrEQwrMrhVhp9ykvegENdLMvpaK1nnq98JOzWgcuRMhauFJlmA/Z8aoKYK?=
 =?us-ascii?Q?iBa64f5PsLIL0ulK9s+uhp/v05fkr4Bv9lHQrf8C1+UHVm42Pr3KGNB4yABu?=
 =?us-ascii?Q?r8EMa3MVbqHXqW71PF8dThO9kblUGAmJ1qdSAd+DvaUA6kYkN9DqhMnahGYB?=
 =?us-ascii?Q?5T4vplXlqaBUJjwK1gG34TciumXBlKK0FhZMbYO4oOKODn2ShUP1oZ1/zhB3?=
 =?us-ascii?Q?VEmNR4w0QT2XudFPq2ckI7G1Cvgpp1H3bIWWIfYzhl0cYZmNRDrTVaxVFn7N?=
 =?us-ascii?Q?3ZLVp51QddebKU+ZgUFIMOQKt9HmTj7L8jUUVh5ho8ecil8wMwJo9+XTjDCA?=
 =?us-ascii?Q?HmyrFbBSOVKjFY/BMUvL16IfZEC+U3ZUGj+3qbk+IBWCd4F+dEvBvMUyqyhv?=
 =?us-ascii?Q?rAzNw0H910f+TzUGqMp/EmRX3tpYetHkSgAhe4Zb8WEycB6Grahra2zD8lnM?=
 =?us-ascii?Q?uX6iQA4zNDu9V7jb3jezvlZdTIGE7dcoeEnHS42enrdmJjDSsxWxYpaDbRwi?=
 =?us-ascii?Q?M8TePHQcVMFHVNkxcORVWFfeGvp9Fo3hlZeO55rGS7l24dGMdUh9JH9PK27g?=
 =?us-ascii?Q?21H1Ol1VNUrbiWIA7uaEnRGpi31bxeYVWRO1xYIuQivvppIaSCQUQA1FyH3y?=
 =?us-ascii?Q?KUcvAWkBR2VDYRANIS9JjUOdEhwSJ0h+jIW+7fpuukgqpc2liD1VqOdalIPX?=
 =?us-ascii?Q?9kieAXw9pRRVArLtzkUdJH91Wx1z7XQ23I3wyVZ1ggaa8HZgrTw4ic5jxKOH?=
 =?us-ascii?Q?7icViLl4zTc9K2Q/Yda29OZpdW3yLgvC5gLo/BDM435oSLeqpZAj4qIC+kwN?=
 =?us-ascii?Q?Cu0GP7ij7j0m3bqHqOMS1yk+buLW2/+g3M2GveedwzsDbQ4+0lut2Ut/Ympo?=
 =?us-ascii?Q?gmgi42O3E/+bsdDYXw/da5OZtC9XVJeP5Qb8Ikr8wkoqrDg0F+vRrUph8Ls0?=
 =?us-ascii?Q?mlS3oo4GkDrYBGAIIuBTj2W9x//XEf//Y+Rg8YxX7AZowiaid3FKlQE/Q6rx?=
 =?us-ascii?Q?aiJqW60crC8KpCD9HO7YviigI+bHTYKVMq+1aNY6DP5+dKc9RMu7coAqTZq6?=
 =?us-ascii?Q?CaK7PqsLfWI5zbhNpNBNftdxKN67kTIL5ar7Rq66s0ctdiCVywvr2wIW0tV5?=
 =?us-ascii?Q?0ZnOuvlpBLTmaQqDjPyifkj8baAVd3O+e9fu+OqgVMvUe/R+Y7zCi8uPAswv?=
 =?us-ascii?Q?lLk0liMAAMS4CFsDBf2NTZu1ijnA521e24VG9f+nH24O5Hg85Qvtb85V51Bc?=
 =?us-ascii?Q?NhgMSMvV3pHbF0EMb7XKITRUW21gZ36MN1/q0WK22Tsnt0NA9eLCF9mXraRk?=
 =?us-ascii?Q?y/JcTlMnUIvwFtaeeOiHwikXVZIrkAMerXLc/wBHV22v+EEKWeAiJRSG3cji?=
 =?us-ascii?Q?P3MiV0nS6hc2Ha2CXs8bTwyCoe24oojZ9m18QPe5NMRZmyKZijYhy2+klgON?=
 =?us-ascii?Q?OxTTXv+1slYmlGAIawcJEYiFQs5Dk5x75sRM+W8hKoY0lwetwP4/DGuQQXC5?=
 =?us-ascii?Q?My9QmlO1VXEHVrAT2NJeFdHJy0KWy/SehDuTRWGbILaUhBFA2I3RqPC0v2Gg?=
 =?us-ascii?Q?NlrcyNKSqbNjE1WECOeT4uSs5+cNw3rLFmDIjwbf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90fb061-ca05-4737-22ae-08da5b0bb79d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 02:45:10.9174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiEZpUM2ultoFZaBwEQfhQbf2vedgZp5iYckSxP7DjkSniFT5NnuVsxUZ3whZG4SMbs/p9KkwBzSDiS6wDT/vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3533
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, Please this change.


Currently, only tree RCU support leak callbacks setting when do
duplicate call_rcu(). this commit add leak callbacks setting when
fo duplicate call_rcu() for tiny RCU.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tiny.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index f0561ee16b9c..943d431b908f 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -158,6 +158,10 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
=20
+static void tiny_rcu_leak_callback(struct rcu_head *rhp)
+{
+}
+
 /*
  * Post an RCU callback to be invoked after the end of an RCU grace
  * period.  But since we have but one CPU, that would be after any
@@ -165,9 +169,20 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	static atomic_t doublefrees;
 	unsigned long flags;
=20
-	debug_rcu_head_queue(head);
+	if (debug_rcu_head_queue(head)) {
+		if (atomic_inc_return(&doublefrees) < 4) {
+			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->fu=
nc);
+			mem_dump_obj(head);
+		}
+
+		if (!__is_kvfree_rcu_offset((unsigned long)head->func))
+			WRITE_ONCE(head->func, tiny_rcu_leak_callback);
+		return;
+	}
+
 	head->func =3D func;
 	head->next =3D NULL;
=20
--=20
2.25.1

