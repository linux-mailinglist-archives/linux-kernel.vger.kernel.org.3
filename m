Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1734B1C09
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbiBKCOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:14:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347217AbiBKCOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:14:18 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D00B5FB7;
        Thu, 10 Feb 2022 18:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644545657; x=1676081657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P2v+LycRY+1siwshQbeQthlODeMtdQY7KyLJocz/RRI=;
  b=M0m6KbHxvjjbj0sevuRGALKpw42HqX26Zk9PHIfsYOg6Jq5GGTMi2fWO
   xeHiHE2Bmu5I5GLekPSEApWtRPrDeHSAHfOw89og/nTHJQJTDyDk2bB3H
   lvL2S4peyJa4hu2IO3lUlz8lCSyr6la0dvM60bVkgHK67nalcNpJjU4R8
   onrE4gSUgT3U4ZReomQyLK+rH7VVqNpWIkZa95SmNE2GDycMcMSvBHs7p
   mXlevp13RubxJui0Q2j16O2kDRtiLu4BFNiD5MRyvjvTHeXfl9WLsvXJM
   oV8/nvugwHhoBcmRkjclifYNOaxPkl9oPdj6KTwlbsspt8vDVRK5SxeqU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="233196737"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="233196737"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 18:14:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="500621324"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2022 18:14:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 18:14:16 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 18:14:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 18:14:15 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 18:14:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ4o1MFlqBVFE95v7GffT2kRWLLfKzSNaVCrgFxdcSo526YwUOQDH3OgjGkCI5By+K/ZpbxdwnHsAmjvnn15OQBdUCyxCKCoSS45Qn7T/jgezEXfNo7MyssQTRUFcWWywSQkzj/8kVTCrdiy6b8B7cNeZHk7lir38Itibh/n3dSMO+3w+ulCQgD2GSUZqWtykkKAQy1DrhQfk9T2rlkTROUCUwNNxyXZQYmJRjVM0CHYRQZ7wjkdVDbY7sp5mmuIOf2aelMoIyGJnbzF6hhOi+9Rk48o4GgLBaRKIVB1Kk+oPbqt2XUBFgqx3PjCvoZzoWWF3mHJX8CcEetkP9f8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqM1cWdZpmrakTvwhywRMF9Q+d9gpOerDluw2hwNO+E=;
 b=cIW1678aOFmtNS9r7MUmC+f3U9+91bQGPk0C4GT+XPKVJF/RmvOJkPUu9EWJ8y29XG2vxf/ictf5A2BumVwIebvIeUARapN7+6Yan+o4i1Wz8Eviy8dK4y+aoADc1NBYT+D5gmZuDoJDExNor+Y7D6lhreJqnTYnClBbCVG07hUWDnMKKJW3F5ovTMkxYhyKlNgTQHMeN8wtB83mygLXz32LA44LejD8JyTJtBhPxkArXvzK9xySEhjB/2Gdv5ER6WohOzPAPlSfc99hThIIWIjnIusiskZ9kvPBE+WQL1EoqGco/F2GkzVzXNi04F4d0DYABdwNBjCDbAqUxIkd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH0PR11MB4887.namprd11.prod.outlook.com (2603:10b6:510:30::18)
 by PH0PR11MB5594.namprd11.prod.outlook.com (2603:10b6:510:e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 02:14:13 +0000
Received: from PH0PR11MB4887.namprd11.prod.outlook.com
 ([fe80::8c1:d962:3d7a:f432]) by PH0PR11MB4887.namprd11.prod.outlook.com
 ([fe80::8c1:d962:3d7a:f432%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 02:14:13 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     "Chen, Yu C" <yu.c.chen@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
CC:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] tools/power turbostat: Support thermal throttle count
 print
Thread-Topic: [PATCH 1/2] tools/power turbostat: Support thermal throttle
 count print
Thread-Index: AQHX17vmo9Yl0WxUik2a7/rHYiG/gayOKpfQ
Date:   Fri, 11 Feb 2022 02:14:12 +0000
Message-ID: <PH0PR11MB4887077D94A30A5F757F01B4E0309@PH0PR11MB4887.namprd11.prod.outlook.com>
References: <20211112115159.725357-1-yu.c.chen@intel.com>
In-Reply-To: <20211112115159.725357-1-yu.c.chen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37d07c02-6565-4a92-2d97-08d9ed04325c
x-ms-traffictypediagnostic: PH0PR11MB5594:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5594FACBEEF521B9FAB808C1E0309@PH0PR11MB5594.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VKkoiIQm5juA2+kLVLfxPl09vQKPXcMecHK4BVBlzXy1jj5HWhMW9xXCS63Xmb/LgwR5APxwJOZ8QUks2IXy++FR+rMQJErb8Vceiib0tfpubb0jtLesH92f157mSDowDRu3RFFNRTk+2KQME96z2IAXMNit57tzCJPU+8W8MDQelEnUmrZjh/qUop9icdDYNFL2bAeWUXazM+0Gw+b3/W8nNs2kGzu7cnkxZMphRWmGSzS6ivQ98yAshT7rOhI2WEdZiL2asPges38Z1ItOzPDmMoyHicdOJg6b7TLcct3BMvB7yb9zL48NwRjnfc/bA/AnwEJelvgXuEaScTE+C8vS4jzOoXaN6J7sfGGzQAxMmd66MeOPEWBzyFVjyDIVNPSzlYtqX2NvPUsin926mw0vAlEBodvdhdrbWpTC1APSBnI/9HtSimTKCI2dCEAGf0kV77IenDrrRsPdPK0jC81LjFaDvn9zVnL1pBBKvYLkwevflVU4FNPJbo945VwmuHeXNfPGFptmK7VQkavoPzibEHPCuhexuEsXnGWcgqbf262IH2o/89Da/5VZvdmKv+2O0JGhCTPMZkuSCErF48SreSTRMlDKhdhbRJn1Q9QdCgZN1CGa4n4yz8JUHI24HGw7FnNLR8DP7h8u6matJmmO9CHiG1o7dIAHmc7GEx+dXZ1DcaF6/I2uh4qkndi2bLh3bxpnfnepbHd4Rk6SqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4887.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(2906002)(52536014)(71200400001)(86362001)(316002)(186003)(110136005)(76116006)(26005)(38100700002)(55016003)(8936002)(9686003)(122000001)(66556008)(4326008)(8676002)(7696005)(6506007)(53546011)(64756008)(66446008)(66476007)(5660300002)(38070700005)(33656002)(508600001)(54906003)(66946007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vNSepIwKNL5jE67ceIIwxvFLb96n9yguKMas9S3EoOJPi6dg/luwcZt8b6eG?=
 =?us-ascii?Q?mEpXVvH/TzXQfiiDiWobXEwa8JOcPLe4o/64NdgqNIvXWHaQSxvLu83tmxHy?=
 =?us-ascii?Q?RnwgL84rZSwL5m+pdoo64Vc5OObns+EVhgkOWHHu2MZum3PCsakPhA9mBpeB?=
 =?us-ascii?Q?ntY8gEekjRS2rJUEV55G4AaoiVZ+dHXeJVIkQj1c4Q2womYoR1dFgGY74yV9?=
 =?us-ascii?Q?x1vpsA4+qH82cbZX1GrlW8C/Muw2gINnke3EE0LDgBZ+S/IFKOo0+KZBRJmm?=
 =?us-ascii?Q?Z7W/NV9CXTWfYF4W1anRGirVZKfuAQPEguBsqYFzUcgNOsdkMLPLrXAs501b?=
 =?us-ascii?Q?U3156uN7z8U508lgwNzdBbp4qjMD/BpyiAttv5a5UbpnQZKRz1qzDl+Mvclg?=
 =?us-ascii?Q?xNb+p6Bh8UWSXz2S4aG06TCzfJg9ZbxMO862po3hjVTWuJ5wTZWW7wKGiJqF?=
 =?us-ascii?Q?ofYkX+ZkpLGCXZ9M0v2u5m+Fy0JcXoMnXnAupq0GYg1FgNdL6nVBQkKfYiRN?=
 =?us-ascii?Q?HoygqzxE++aXSfoOvOW3muB/vUyxAezl8oDvPGX6BfmMNYSb62Xt+skQXzbv?=
 =?us-ascii?Q?mI/4wtoNXs7mFA14wxT1cJ04S9ieH0jwbWKpuIUFzxDgjkGqGEwwjUaJAvPF?=
 =?us-ascii?Q?W7rgZQyvi1dp5UpbRu+j3XkVMfFW505e+yS/XJN3Xnsj/9ehTjSxiyvOToC9?=
 =?us-ascii?Q?cqTGXAWo/w+mpTh/c5FNjOrSdZfxBqVyPUPvpKGjExhU4XL4dUlkpEvV09nC?=
 =?us-ascii?Q?Kh3IMyB7EPjpDIfj9+96jPzgOYBl/VfxjrpT8nt8CM1BVAg8TsbPB+pCclsv?=
 =?us-ascii?Q?7j/GrSICgVmY7SGFaO34zLMycBUs1TCWgHNRIGTFV0oXpNIcacDE5HIzszXe?=
 =?us-ascii?Q?CAPi0UuZjaxg8nuvglfeElP+tqomlrTw8JaoXi1h9cBG2iCqOkd+urgtsAys?=
 =?us-ascii?Q?Q3HBZW7bFQN7Z9L2KUemV6ROD5VhTGqEbncJeYZ1fkCKoXcIs6OgiMZIIq2J?=
 =?us-ascii?Q?O47EBxvtx4kxlEQ5HIlFe3n8DS/VLr9Zb0rNoxd2vnbxmjfRna+pA74LLE1o?=
 =?us-ascii?Q?LxLh+IhJzuhL81z0gRiKLTp36YHWcfDLyW1gdvPt4WsXlSLie6dLNOZ0LUcu?=
 =?us-ascii?Q?30mU7qpg0GMtjMiJx3+YzEHQZ0QzGzEkNpKvpZCMItyCfWRUjasNubOtPMlu?=
 =?us-ascii?Q?ZTtwm7nH2Ob6HZrsLoCRwEPwODOahYONkKVQjSLCehbmOClbygd34wEKT3vt?=
 =?us-ascii?Q?x+XMxwaPR0Isdtw7gwJcjIrS23ZODdNcU/NLS6azJ0gya1cq/z4889woIvTO?=
 =?us-ascii?Q?nO0MAMV2NtkKOeC116AVYnArMiMsbiaBVWkPWdfeiuef18BOiGo7ogTe1zgF?=
 =?us-ascii?Q?kEqSMjNFn4bpsehcsnGERuh4L9cB/GGZpk7YBEBmhXXrWfwbBaicrl+UIhjN?=
 =?us-ascii?Q?AN0JQGxTTtOdx1pVyBWUZ8AeZ05ujsxlKUPN5DWn2M9QsEIaJHyEBSCV8OGS?=
 =?us-ascii?Q?VnuSzLmVqEtRC6A6dd0YVoQljzHEKjNnWpqs2O9id+LkiSfRGy7EhG9fSQSR?=
 =?us-ascii?Q?BBGRMIaCicIX779IYrpOFiUGd736HGj5vZOj+hcYrzZMcfUbkkod1t05WZK1?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4887.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d07c02-6565-4a92-2d97-08d9ed04325c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 02:14:12.8771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AMdUtBXXsCbv3pfZEQWP5t/IrRi0+igLsnBSG2NkqMDLR1Ey5d9oU56r3A2hYqjAOil2muFHXtlyKLenUaSmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5594
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What is the scope of this counter -- per-core or per-CPU?

-----Original Message-----
From: Chen, Yu C <yu.c.chen@intel.com>=20
Sent: Friday, November 12, 2021 6:52 AM
To: linux-pm@vger.kernel.org; Len Brown <lenb@kernel.org>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>; Rafael J. Wysocki =
<rafael@kernel.org>; Brown, Len <len.brown@intel.com>; linux-kernel@vger.ke=
rnel.org; Chen, Yu C <yu.c.chen@intel.com>
Subject: [PATCH 1/2] tools/power turbostat: Support thermal throttle count =
print

The turbostat data is collected by end user for power evaluationit. However=
 it looks like we are missing enough thermal context there. Already a coupl=
e of time we found that power management developer asking something like th=
is:
grep -r . /sys/devices/system/cpu/cpu*/thermal_throttle/*

Print the per core thermal throttle count so as to get suffificent thermal =
context.

turbostat -i 5 -s Core,CPU,CoreThr
Core	CPU	CoreThr
-	-	104
0	0	61
0	4
1	1	0
1	5
2	2	104
2	6
3	3	7
3	7

Suggested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 43 +++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbos=
tat/turbostat.c
index 47d3ba895d6d..b7908f1ee969 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -205,6 +205,7 @@ struct core_data {
 	unsigned int core_temp_c;
 	unsigned int core_energy;	/* MSR_CORE_ENERGY_STAT */
 	unsigned int core_id;
+	unsigned long long core_throt_cnt;
 	unsigned long long counter[MAX_ADDED_COUNTERS];  } *core_even, *core_odd;
=20
@@ -610,6 +611,7 @@ struct msr_counter bic[] =3D {
 	{ 0x0, "Die" },
 	{ 0x0, "GFXAMHz" },
 	{ 0x0, "IPC" },
+	{ 0x0, "CoreThr" },
 };
=20
 #define MAX_BIC (sizeof(bic) / sizeof(struct msr_counter)) @@ -666,6 +668,=
7 @@ struct msr_counter bic[] =3D {
 #define	BIC_Die		(1ULL << 50)
 #define	BIC_GFXACTMHz	(1ULL << 51)
 #define	BIC_IPC		(1ULL << 52)
+#define	BIC_CORE_THROT_CNT	(1ULL << 53)
=20
 #define BIC_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | =
BIC_Core | BIC_CPU | BIC_Die )  #define BIC_THERMAL_PWR ( BIC_CoreTmp | BIC=
_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__=
 | BIC_RAM__) @@ -872,6 +875,9 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_CoreTmp))
 		outp +=3D sprintf(outp, "%sCoreTmp", (printed++ ? delim : ""));
=20
+	if (DO_BIC(BIC_CORE_THROT_CNT))
+		outp +=3D sprintf(outp, "%sCoreThr", (printed++ ? delim : ""));
+
 	if (do_rapl && !rapl_joules) {
 		if (DO_BIC(BIC_CorWatt) && (do_rapl & RAPL_PER_CORE_ENERGY))
 			outp +=3D sprintf(outp, "%sCorWatt", (printed++ ? delim : "")); @@ -101=
1,6 +1017,7 @@ int dump_counters(struct thread_data *t, struct core_data *c=
, struct pkg_data *p
 		outp +=3D sprintf(outp, "c6: %016llX\n", c->c6);
 		outp +=3D sprintf(outp, "c7: %016llX\n", c->c7);
 		outp +=3D sprintf(outp, "DTS: %dC\n", c->core_temp_c);
+		outp +=3D sprintf(outp, "cpu_throt_count: %016llX\n",=20
+c->core_throt_cnt);
 		outp +=3D sprintf(outp, "Joules: %0X\n", c->core_energy);
=20
 		for (i =3D 0, mp =3D sys.cp; mp; i++, mp =3D mp->next) { @@ -1225,6 +123=
2,10 @@ int format_counters(struct thread_data *t, struct core_data *c, str=
uct pkg_data
 	if (DO_BIC(BIC_CoreTmp))
 		outp +=3D sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_temp_c=
);
=20
+	/* Core throttle count */
+	if (DO_BIC(BIC_CORE_THROT_CNT))
+		outp +=3D sprintf(outp, "%s%lld", (printed++ ? delim : ""),=20
+c->core_throt_cnt);
+
 	for (i =3D 0, mp =3D sys.cp; mp; i++, mp =3D mp->next) {
 		if (mp->format =3D=3D FORMAT_RAW) {
 			if (mp->width =3D=3D 32)
@@ -1311,6 +1322,7 @@ int format_counters(struct thread_data *t, struct cor=
e_data *c, struct pkg_data
 	if (DO_BIC(BIC_PkgWatt))
 		outp +=3D
 		    sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_e=
nergy_units / interval_float);
+
 	if (DO_BIC(BIC_CorWatt) && !(do_rapl & RAPL_PER_CORE_ENERGY))
 		outp +=3D
 		    sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl=
_energy_units / interval_float); @@ -1467,6 +1479,7 @@ void delta_core(stru=
ct core_data *new, struct core_data *old)
 	old->c6 =3D new->c6 - old->c6;
 	old->c7 =3D new->c7 - old->c7;
 	old->core_temp_c =3D new->core_temp_c;
+	old->core_throt_cnt =3D new->core_throt_cnt;
 	old->mc6_us =3D new->mc6_us - old->mc6_us;
=20
 	DELTA_WRAP32(new->core_energy, old->core_energy); @@ -1626,6 +1639,7 @@ v=
oid clear_counters(struct thread_data *t, struct core_data *c, struct pkg_d=
ata
 	c->mc6_us =3D 0;
 	c->core_temp_c =3D 0;
 	c->core_energy =3D 0;
+	c->core_throt_cnt =3D 0;
=20
 	p->pkg_wtd_core_c0 =3D 0;
 	p->pkg_any_core_c0 =3D 0;
@@ -1710,6 +1724,7 @@ int sum_counters(struct thread_data *t, struct core_d=
ata *c, struct pkg_data *p)
 	average.cores.mc6_us +=3D c->mc6_us;
=20
 	average.cores.core_temp_c =3D MAX(average.cores.core_temp_c, c->core_temp=
_c);
+	average.cores.core_throt_cnt =3D MAX(average.cores.core_throt_cnt,=20
+c->core_throt_cnt);
=20
 	average.cores.core_energy +=3D c->core_energy;
=20
@@ -1987,6 +2002,26 @@ void get_apic_id(struct thread_data *t)
 		fprintf(outf, "cpu%d: BIOS BUG: apic 0x%x x2apic 0x%x\n", t->cpu_id, t->=
apic_id, t->x2apic_id);  }
=20
+int get_core_throt_cnt(int cpu, unsigned long long *cnt) {
+	char path[128 + PATH_BYTES];
+	unsigned long long tmp;
+	FILE *fp;
+	int ret;
+
+	sprintf(path, "/sys/devices/system/cpu/cpu%d/thermal_throttle/core_thrott=
le_count", cpu);
+	fp =3D fopen(path, "r");
+	if (!fp)
+		return -1;
+	ret =3D fscanf(fp, "%lld", &tmp);
+	if (ret !=3D 1)
+		return -1;
+	fclose(fp);
+	*cnt =3D tmp;
+
+	return 0;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -2129,6 +2164,9 @@ int get_counters(struct thread_data *t, struct core_d=
ata *c, struct pkg_data *p)
 		c->core_temp_c =3D tj_max - ((msr >> 16) & 0x7F);
 	}
=20
+	if (DO_BIC(BIC_CORE_THROT_CNT))
+		get_core_throt_cnt(cpu, &c->core_throt_cnt);
+
 	if (do_rapl & RAPL_AMD_F17H) {
 		if (get_msr(cpu, MSR_CORE_ENERGY_STAT, &msr))
 			return -14;
@@ -5572,6 +5610,11 @@ void process_cpuid()
 	else
 		BIC_NOT_PRESENT(BIC_CPU_LPI);
=20
+	if (!access("/sys/devices/system/cpu/cpu0/thermal_throttle/core_throttle_=
count", R_OK))
+		BIC_PRESENT(BIC_CORE_THROT_CNT);
+	else
+		BIC_NOT_PRESENT(BIC_CORE_THROT_CNT);
+
 	if (!access(sys_lpi_file_sysfs, R_OK)) {
 		sys_lpi_file =3D sys_lpi_file_sysfs;
 		BIC_PRESENT(BIC_SYS_LPI);
--
2.25.1

