Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C23B556F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiFVXnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiFVXnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:43:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE44427DD;
        Wed, 22 Jun 2022 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655941414; x=1687477414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R5Vju22Wdk/E8hrBH7Gl+wuVRUcwhb9vJdYv+s7puaU=;
  b=cOQzjeuDnEZuaNzG9FsLhTDTVWdl0HXZ4Vfy6T8otkPO2yprB14a3juk
   E8C6OtCHIh3J9bfYoJFqICSYzJOsOy24h3aydJVZXzs72pCbRHDZVmPUd
   On1S4s8SEObNtfkh2k/awmrMJTAsnRwqN9kaF0Whm/b3Xcve7MeCM9/0v
   crrLN2XKGVMV4M1JJvWLhALzTMweaDSNyTQRmV4nsa/Jc0zlE+Gaz98YG
   cpyYabLiG91+xlnEDbKazk0PkL+ftfxwkV+4NrodDBfIwmMXrZxoNlfOh
   v1SheB1IjqPswPCLhnS3JZzZFYt8YRAI+EDGI1/p6rw8uvhcN54M5hj5b
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281303491"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281303491"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 16:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="615364351"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 22 Jun 2022 16:43:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 16:43:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 16:43:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 16:43:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 16:43:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7q8t6f4YwhJi1ZwMcP7TT21MLWUeraAZMP1/z2NrHTiTZ7uyhsqFJhGlDT0JdbcnX+R83XO9Zh1isu6BRg8mwE3cE/hgPhY7X/nSLs/i4GugSa6gRRJF0VTr13aUlLcBBsqib+1aGOB1ett5hpWvgsXGv7mclbVb14gowOx0HYSAJMkG8p48dFtgaTj6z6+y1r/1pveADppA624eKmPzugre00CafEttd6od1iTwYEovrFL2NSBGnYqAIUYRn9RD74NZPiJoRLNf/x5mTF4FI6JCFTxk3mziitqEI/JemC1ugktImOFgTLPGq+XqomXhlLsKhaLn4NSUvBnCLjdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOM0Dm7PDlw8nSZek7hAEg/vujniYrq67NmwIvGCYxU=;
 b=fw1Rgoyzf65Tr3v/Aw7cxbx8yLBorC74beBLfRKdqWXcOayER0gZ/zD3Im3mK4bKr0ZpwyJzkhfaNqASc2xLaG7LxjaC4ZLxw3xtWahiIl04mJHapteZ0pCBWZrC66sXYEAKEcxBXi4mnXxpcIBtAuUFPr1oxZ02a3KB6suDfGw9VYw+vZMt2pQh2OsYyAW06Dv0iFxw7rHQV2iLD1hZXV5KTMNyMCoSyoCmT7dLSqPMNu+l9tnF6F/dVgnJnCnaezPkEejMHH4wW0sUzJXuHJbL/3OOBx2bZzsIKQeFphcLDtwwSJ54aoo1Ef9STxsYE8rfyryoKMAThJLorNQPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN8PR11MB3618.namprd11.prod.outlook.com (2603:10b6:408:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 23:43:26 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c%5]) with mapi id 15.20.5353.015; Wed, 22 Jun 2022
 23:43:26 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Add a warnings in sync_sched_exp_online_cleanup()
Thread-Topic: [PATCH] rcu: Add a warnings in sync_sched_exp_online_cleanup()
Thread-Index: AQHYhQ20/x4TmjWtSEepVJie126Nl61cGSeg
Date:   Wed, 22 Jun 2022 23:43:26 +0000
Message-ID: <PH0PR11MB588005D38E08891423310EBBDAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220621012412.2724457-1-qiang1.zhang@intel.com>
In-Reply-To: <20220621012412.2724457-1-qiang1.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: 97200115-804c-439e-933f-08da54a900c1
x-ms-traffictypediagnostic: BN8PR11MB3618:EE_
x-microsoft-antispam-prvs: <BN8PR11MB36183B0B526C75D068DF7372DAB29@BN8PR11MB3618.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0izm4gR6RpW8zDWlKYOxoGA+M0p7WyzlNaEqsokJHCFRjC5vISnPqzk3Lt7ds0O1PYEGuU7MyasavPFLtQROef5XOEG2UUlkP5GNkZpXamOX64eolU8G0wI+7uNTJNmxQvbk4+cNsULoeHGLQVxftFyvHjAYF4K9PMKeBgjSbE+aqoGddvPceBdB87kcdxmljbKlgEOFqrqb1TdyBSrJoZbUavA+GQ81/Wq5iaE1WWMnJNkBEUVIfpON9HlSXa8bEcuh/bH5ZwGZj983PHQrshPXVAlbPmlqQujmiXHFhAso6YmnKtpmPNfI3doOpX/SpSB/V4S3rePvNEtShPn69GCDAG1UxavPkFYlHznzXXJ/WtU5g+xbGb/PpPEAOEzl+LyZvgoGHw3fq06dQY0MpaCFdKsMwnoCgH8y5EKMsj01EtDcW2LFD3SfYM18hhGYeA8NbDuTrc2D0BzzVcQhY3aokheOw4hoom+Zxz3NBBhGI0AjylDaQWahDyD3iJkbpilj8RsGSaYqHyynSr2GVjuMIuDsYtDrkbFzRLzsBil/qdRdQrunOT8r5Sw38nNo5CMn5Gr1JrlDsNlo9Ac7EEUJ9hE3pHYQfb7w0cJlOoEJwdirzhCzlprzE8ypxP0/MvkqAgV0p532Uxuo5Wwd2H4cV411I53nCr7GODaF0MaeI1sO4UYBQY5FJABP82E5tcOoIMqz0WirjzNgEtNlVDBfOwiNJh4tsdMDONJrQuofJLvuY/PTRQj0FQ91GYspCZxLW7mEsA/DKdX3t5EAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(136003)(346002)(39860400002)(66946007)(478600001)(64756008)(41300700001)(52536014)(4326008)(66556008)(2906002)(55016003)(66476007)(110136005)(86362001)(33656002)(8676002)(71200400001)(66446008)(6506007)(7696005)(26005)(9686003)(76116006)(316002)(54906003)(38100700002)(83380400001)(186003)(5660300002)(8936002)(38070700005)(4744005)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mfyvnh0opeDxqdzSS8/F+7J1LPWPM+MdmTZPaG6FLsDfodz35JwYrqz3WtPY?=
 =?us-ascii?Q?u5HVUGPch9NqwC2I6Zk7vYUIxiR5Vf1khq/o1jEImXpGuLRlnYqLqP0uHKjv?=
 =?us-ascii?Q?sbZfL+3v3T2CJrnExruP5EFlvCV0DKAcXLM7tzXNkiOMOCHZDIBDoouEIubb?=
 =?us-ascii?Q?6wY5N08aC1wIkgWpzHRo98kGB7wkjoxnKMQzF5e2x/u0wUMB0KUZb7JFG3A1?=
 =?us-ascii?Q?ZP3ZvxmRbOkQhJ7udYtpvB12547ba05icpYzl9/msSLkWNiqOT0MQ7GB7mOl?=
 =?us-ascii?Q?LSt+pD9K5TGvU4xLNx58GsgbuPN8ucPq72eKQu2L/KKl3sEuWD5HnRB4Kq9p?=
 =?us-ascii?Q?ll07QGjP8wTAc3V3MRiJz9iCXDcLEZO/SAm/5GdPq3VZh2faVJjeGvW3kAa2?=
 =?us-ascii?Q?aiHBwK3/hUxXDgaDhyrgE5P4XXx7zcB08kDq/mm+oB1Nlf21K9+YK5XdtKFp?=
 =?us-ascii?Q?EyFBEVvkPsCrmu4QPy0fLofs502Y/q7nZLBJxrfT7/vrZ5uG10qcwkraYUdI?=
 =?us-ascii?Q?bQiV1i7uiUACoR2jJD1RAQ/y+OW5+3/RmbLI1c1V40AqQ8q0SK1WZyEJXFkv?=
 =?us-ascii?Q?jvKXNWVylQuX/tfMkC788EX4d+DMAKsb6ckBCt3JtIPiwe5PqU0OT0kWIhQF?=
 =?us-ascii?Q?WyL+9MCk9f0r3OCpbAMiVfXsUW79hBzNcC5XJjnOUKVfQjtarStZlOhcC5D3?=
 =?us-ascii?Q?6kvOlQ8DFBlI8X3h2zviWeBsNeunKcb4V5j9NHOKGpyocNEpLyMSLbJNUWJN?=
 =?us-ascii?Q?FuJJhrTOl52ROpTXtbqNpaDP1DYaa+71oOvlAebFfYBuF+HD/rhDuOTdG32c?=
 =?us-ascii?Q?nalCBXjT9hfYCYMRK6QP9JMCPG3bZSgub+uta23BJKlNdI6BrIuyKr3awIFs?=
 =?us-ascii?Q?Uco7SkwEiGVPE2V6KZ7XbeJPgA9a803WqDgZHXdRuIiDP69Gq+8XCSPKN+Qi?=
 =?us-ascii?Q?reezwrdvXegvDhSHYwAztWfFHNcnkt3s+MCFfWYr0lXN1yMzn4l37JnspqOQ?=
 =?us-ascii?Q?4E2MuX1E1zFdCZBiCbc8kONWPYkM5ugt1KqccFvMdgnxYqvH+0yEk60CgapN?=
 =?us-ascii?Q?xoF4bxgOtz2J2ihzj348sJ+I7Cj8k/ZvtqeuatpwQTixcwRa4GGuytAG8GP6?=
 =?us-ascii?Q?PAC7W4AqwpWGyI6ia2ObKJ98defIroBtCDI7qh/vRlVto+9FuBWbCf8bFNxH?=
 =?us-ascii?Q?lOIUaef0d8ps+BnSWUPHGESi9i6ME2W/vJMhX1d+A9LyKuNo3nZ0h4EHvA4M?=
 =?us-ascii?Q?vHky8gQbmVA/VKBvrxYIZNawgJFHnsJViHyOhWh0dllC/fHHvq9mDUUPJOVr?=
 =?us-ascii?Q?rv/YAEFfUqLZPBw9lHC3AsLXYsXzQ4r2hlzmAbuoZ2qLoYu1pQzGrLc9SB0x?=
 =?us-ascii?Q?rzz5GBTPuH/n3/J7bT4trpPwLUrfgEHof4Z43Z3mMNbf2LaCm7BiGyObZsK8?=
 =?us-ascii?Q?GkcES4alcFXiyW1x1xb1zLUkt7t2jaM73f953uh3nL5YM5UIfqVuSMfvZ9sn?=
 =?us-ascii?Q?EU77TahWPRASd9BX1vxQPsjwBea/1/7YwmGhGGgXY9pPZD0wWTFN8zDEBbLS?=
 =?us-ascii?Q?0ZeS2sDUzu57n8CwKLQPEDwBiqh6grFdE+KhvQKLSFOKeIT+yi9YvImG5XmN?=
 =?us-ascii?Q?3NWwXUshy+i8JrpskO24oiy5DRENy0KWpE2PDm3OtDPrgAuhWezhoiKclpjl?=
 =?us-ascii?Q?bnPS1x0uSYOrKZdaRM2neKLEyfTiuizcKM7cJugX/hJbYZl7GaPzXCkyah6j?=
 =?us-ascii?Q?eteXcYMJBg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97200115-804c-439e-933f-08da54a900c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 23:43:26.4614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qz4pzaZUC6KFK045HDvOL+4pGg8Zbfd0QyErb3je9j8g0b4NC35tN3zNTM2HOTiPas4dxrIs07iI40J4pivcjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3618
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


Add Cc=20

Currently, the sync_sched_exp_online_cleanup() is invoked in
cpuhp per-cpu kthreads when CPU is going online, so the CPU id
obtained by get_cpu() should always be equal to the CPU id of
the passed parameter, that is to say, the smp_call_function_single()
never be invoked, if be invoked, there may be problem with cpu-hotplug,
this commit add WARN_ON_ONCE() to remind everyone.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_exp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index be667583a554..ae8dcfd4486c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -865,6 +865,8 @@ static void sync_sched_exp_online_cleanup(int cpu)
 		put_cpu();
 		return;
 	}
+
+	WARN_ON_ONCE(my_cpu !=3D cpu);
 	/* Quiescent state needed on some other CPU, send IPI. */
 	ret =3D smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
 	put_cpu();
--=20
2.25.1

