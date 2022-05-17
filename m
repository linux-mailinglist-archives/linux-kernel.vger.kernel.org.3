Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E7C52A193
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346083AbiEQMc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiEQMcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:32:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282342C678;
        Tue, 17 May 2022 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652790741; x=1684326741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wrioHmNHykvLTKEryi4rmqmvZJGgZa/YmMV/5hCi0LE=;
  b=lsiz8lBLtUuWpS5mhcc+Ch6H7VpDhLRFwO80+7a71Q0hZRab4RS5rdV8
   YnKYDSSQAeTdzq0wfqTAOzEDgxSGX+6P5qVH6riCajehfBsyIbbBzL9EF
   POqktkEuK0vjeIFlSfimvFLOJMo1lJ+86V7LclytIYvEYlnqJprilE6QA
   BA7APO7w2ftiqo6PZo6UkHuLJMh5W7qhqGlot73730+JFm6/H5hVAZA2y
   QxlpW7zduZINpaJrark64HPUmzcVXlmbLyFojkV/ZMhKBJ6jbDrSxNLs0
   G71G5iSlY3L6ajMyjC2SH7dD5qkVr4hx/VnPk1Zkhck6DU4i//+xzydeI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="296443394"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="296443394"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 05:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="672830788"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 17 May 2022 05:32:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 05:32:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 05:32:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 05:32:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 05:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZNFDJp/KbLNWAxZ0+keLpcd7MOLTPO1sXMN543xs3OOZrttdJCz7K4/FwBX4qeAFnXM72zGgmYjb9kI6iLCOce0LNF8e55oVlqcffee6v/jntiuMAK7C3CCLOunEfMzsXHyD/QiYDpahlLq5TS+Ro3COFDTQolKG3z3+5Zl9ZO+Kt/n3YffWOku1Osay4KP+HGUFIzTy/BVNDfGYjnvkXY6in/A9jqY7vCaC+qoteTLDifqgI8H+aNLGnRT9Dva7amD6M6NEPs8zTDnn0yNVSaxq6zT/HMqViAKVRijzJw+8bWrY4jkaqrMiIxF65XYEZpWgZ3zi9U8faVBT7su5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5lZmSsKiCN1MED8xPoQ48lwXGacUnXwH3a4rTQk8Nk=;
 b=aD0wiTNyThihsliZojGq43Pdb8/R0lq8lmOebpWKQu4MV55VI3v6tgUCgpPYmTYJm7g5opXwy2D0B3rrXa4KxGr5Fjg4iteNPVc3cJKSPelQa33R4z3ycjwRcUGisEJAJgR1L+tvZOw2m06WyPq+l4rx4lq5euU0D5pwSpKN83N9S1vunkI4XunovwWOuUQpynfzhwEh+uLsy94fvtejjQZyQMxW3L+eOOD5gTFaOs2eFg8V64TNg+17wCvSN59zBcnz/dUEqgJ/7OWfvj5egh0ADeW/ay4kM3VsyL9iWVmPUaS/F4v2OLeK3mVMPwD51PDa+UPCaum0CtLcq0WYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN6PR11MB1778.namprd11.prod.outlook.com (2603:10b6:404:102::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 12:32:11 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 12:32:10 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Direct boosting gp_tasks for strict grace periods
Thread-Topic: [PATCH] rcu: Direct boosting gp_tasks for strict grace periods
Thread-Index: AQHYZmJsqZZOz0NYwkqRvRtT9o+4C60b/q+AgAC5l6CAACKMgIAGLBeA
Date:   Tue, 17 May 2022 12:32:10 +0000
Message-ID: <PH0PR11MB58802D034A41626D88F44BEEDACE9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220513004256.465233-1-qiang1.zhang@intel.com>
 <20220513010651.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588012EC5E5DFD3FFDA49401DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220513141445.GF1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220513141445.GF1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 824f5143-bc81-4309-8fce-08da380143ba
x-ms-traffictypediagnostic: BN6PR11MB1778:EE_
x-microsoft-antispam-prvs: <BN6PR11MB17781E1B7D0DC9AFBDBC7C48DACE9@BN6PR11MB1778.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vn/wNwgfsglkc87a06qvZU7cFJZzNKT7y8O2baKPvK88cVUE1nB1LfT7WKQgFjCqJJDsRurGVUmFVCDmuUVcErkde7hF4vjQsY67pFfqbsVc4a8i0qCjaHKRpb8nmiSk7PYMuGCNnBhX5X23dfcxssBWJdm505kSfMXihnHd8S+ZXqtJDmZFVLKe9ZkNXb61oPZCkc4a2hpiUXxP4lY8+hXarWvfb+g8yZMi/7F5bb8qhNUIstZXsqq7S0AXk/gsqUwEw2Nu7KwXDR4p9qXCsLJERyxlUcJaFjLDCT/+XlqfO2wOleORijP6dXGEgfCRc/66hqu29D+nACGj7Q7GOzvXLpaSkaCPdZwu7zJWG4claIb8bijSRDx2InllyNegfofpK3boQHn3ATLMIflip+WisbKIN/06herH8M/anDVgdbk6A3iLvlvv+mMko9yCZj3uoa/SFvUiTdBLfSf1+dJUq2ytvZkqY8Mf0UynyYVUSFHiz1BXUjfItQGbLvBGj1WSvOSYgk/rY4TwW5W62w1SlgJ9M0UiuZL5KRVgJCdP3lwjHn21RYU1xgqysQRZmB9gS4objz+Kuav7eOBHP7qPFYI4PUjxf+bpKOlWg2w91glCJULQ2HxMUOjAhiTLxwaLFPcqxzFvIHzpcNacpBIaIOqa3hY2xmt8XqyTPaTXZGOWVONcDYYEjwkLft9ZGCNxme8Fwgda5qqLEiNKhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(508600001)(9686003)(33656002)(86362001)(66446008)(54906003)(8676002)(6916009)(64756008)(4326008)(316002)(6506007)(26005)(55016003)(7696005)(71200400001)(2906002)(76116006)(8936002)(122000001)(83380400001)(66946007)(38100700002)(38070700005)(5660300002)(82960400001)(66556008)(66476007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WWmhPd88kS7gxA0jdzg9//zWg5mO8FudnQmH4Zb7qgXlp4TpdtbXI5nG6DX2?=
 =?us-ascii?Q?lPNGbW3fAZAGJQO6ox5Wtvnybqbhdt9oagglPkd3eidsTp+U6sqfXm7UmtR/?=
 =?us-ascii?Q?GYM/UWTawKKtNPuAMkZJ38WTSyopaVL0OUlYRFLgF+LFRuFB0TjMkeq0xKR6?=
 =?us-ascii?Q?9uDd07yCD9ICs2K7Y5jER5plcPyZXiqE9Eus6dt2+Ql0oQZdLcOgnyIdQhMG?=
 =?us-ascii?Q?31YE2W5/zIclNeDKJeiGjUPI8APTixn3/3n3561ZfLYS1nAjzh1ezi+pWMSb?=
 =?us-ascii?Q?J7quYbJYioPtQruVpFgfSP51X1Z2+Y7jUGs97oTZMwlvQlIdLIqFqPb/CigL?=
 =?us-ascii?Q?BduWEv4iM3POxBId7p9mV9lU2B/0C08e+6XVwpJ2iximF8Wzgtai43KCxFMM?=
 =?us-ascii?Q?DtCbTW3yI2vyVQ12T6wN+VQYXJmoTOCX5yzzOicTVsBPsHZhw4gDD9yoUYuZ?=
 =?us-ascii?Q?eZ9U5Uxb92P+qFfN3jeX2oD0JlTXnwnwGnrShlqkatprNvSCN8+z8gVsBlwO?=
 =?us-ascii?Q?H01E67j8a+uSy86NyhA61y9lnYvz8GpTPG785dDRnT+CAXlzL5NncVNY3kTV?=
 =?us-ascii?Q?lAbD4KeWjG7rvKwwE0YFiaF9sTob74KLwNMWIOs7dB30OzbnVaeYkUAKYo9g?=
 =?us-ascii?Q?7JIpdPsqEpg9eFR2ROlmV00WR64l+rg0LW0WGA9X8kE3/t9V1KRX55MSq+69?=
 =?us-ascii?Q?uiC5Tzj1ro2Qq7lmWCJ0hKmOB+I7n+09nKWLs3BLJ3sC3WjxzgOkBzLb+yFK?=
 =?us-ascii?Q?ZHKSa1HKfZC9ksZlZSvyRNm+ITYeYLL87A6NxurYEExMp5boKaxS7Y9wn8Xn?=
 =?us-ascii?Q?nznIR2P1btgJW6lNgMntKOdGl86u7EF6eUZJbcnFWpqJzFg4+IW0uKmda8Cy?=
 =?us-ascii?Q?a0VRbcStG3bq7oEeyzZvCcjNAGAvOeo8rxffhZ0U0JsRzhG5GRXFlgskewBs?=
 =?us-ascii?Q?SrrOvF6tqVXGOVusJf8Rdm99fSFaAzBgbNVBPYzptYJIUpMzYVfGzlRzv9a6?=
 =?us-ascii?Q?v7cT7WcbNtXc9sWqPygM6hcTW/WlNMUWOR+sreutC3ZeJIcZNkEAob9V0OZa?=
 =?us-ascii?Q?oRFYYdkXklGL52B21bkASox2H9hTlUDKUI4Brjt7J0VB7gnh7oUMuk2m21LD?=
 =?us-ascii?Q?XKofv0cXs8bjAlTMqQtqO50NvX2cOi1aAEbs/vBOeNo/pl7ymrBi7PQmeIVu?=
 =?us-ascii?Q?kNCuxjhGsjUNWcKIvU/RhJkLifuXLjgx5QSY2JKnksfZzrcP/MqBKGefdki4?=
 =?us-ascii?Q?N7zPkn+vNCricSm5IUnLxabYymznGUDgiibdzwoB0FmJvHjkMLNCan33xQwm?=
 =?us-ascii?Q?yy+gfkbuzKXa3vOH9ZD1A6IxFLVclSkpv6jum3BiAvfCqrDSxjUuGEetl4N2?=
 =?us-ascii?Q?4MKS32HxcL68VI8/SZ1xaK4HU2ZyenayXDBaaV6gtX9y9QJVjlGr5GgutvQL?=
 =?us-ascii?Q?GW+OMp5KAqgqAddNeAA9HLtCvgWetJrmNXHgLGPAMa3T4zYnNlySccEuTGrw?=
 =?us-ascii?Q?aTZMj/b0VVacSmR7uQf0JbAFOqQZm173qiNixHWGJxmp/T1xo9lxpyt9U8F5?=
 =?us-ascii?Q?ojclCd0HOk9rYTHZQAOdNIvSqaxeJyDrHX/1UssKNiQrprz6wz9STUT97Dbu?=
 =?us-ascii?Q?E0DGDVJKzLTWViZ8K9aG4syyUgOGle5Z9z92W5rbFCYun9GyOS9ogiQZ93Ti?=
 =?us-ascii?Q?IqCbBLyIUzEZl2gBe9657abmLnBY/mcO0X8ZsCobcRAaNCAtWvQTFrl7EJmX?=
 =?us-ascii?Q?IJeb2h7/Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824f5143-bc81-4309-8fce-08da380143ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 12:32:10.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nyrDMvC6qKBda/M0tIqLHxSPScSNiLFErQO8UJ1qJnRpeXw1ZDQis/hGraBJDt1PKA/m1oub5sVkNbOHBMOtFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1778
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:17:16PM +0000, Zhang, Qiang1 wrote:
>=20
> On Fri, May 13, 2022 at 08:42:55AM +0800, Zqiang wrote:
> > If the CONFIG_RCU_STRICT_GRACE_PERIOD option is enabled, the normal=20
> > grace period will be treated as expedited grace period, the gp_tasks=20
> > that block current grace period needs to be boosted unconditionally,=20
> > therefore this commit adds Kconfig check in rcu_initiate_boost().
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>=20
> >Good eyes!  I have queued this for further review and testing, thank you=
!
> >
> >What sorts of tests did you run on it?
>=20
> Hi Paul
>=20
> I didn't think of  suitable test method, Can you provide me with a=20
> test method to test it, I will be happy to test.
>
>Here is one possibility:
>
>tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 60 --co=
nfigs "TREE01 TREE02 TREE03 TREE04 TREE05 TREE07 TREE09 TREE10" --kconfig "=
CONFIG_NR_CPUS=3D4 CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy" --trust-make
>
>On a 16-CPU system, this will do eight kernel builds and run about two hou=
rs of testing.

Hi Paul

I tested according to the above command, and the results are as follows:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 60 --con=
figs TREE01 TREE02 TREE03 TREE04 TREE05 TREE07 TREE09 TREE10 --kconfig CONF=
IG_NR_CPUS=3D4 CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy --trust-make
TREE01 ------- 154236 GPs (42.8433/s) [rcu: g1986553 f0x0 total-gps=3D49693=
0]
:CONFIG_NR_CPUS=3D4: improperly set
:CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy: improperly set
TREE02 ------- 410546 GPs (114.041/s) [rcu: g196373325 f0x2 total-gps=3D490=
93612] n_max_cbs: 805081
TREE03 ------- 160648 GPs (44.6244/s) [rcu: g128673793 f0x0 total-gps=3D321=
68735] n_max_cbs: 646284
TREE04 ------- 347059 GPs (96.4053/s) [rcu: g539425233 f0x2 total-gps=3D134=
856594] n_max_cbs: 205907
TREE05 ------- 360973 GPs (100.27/s) [rcu: g77594645 f0x0 total-gps=3D19398=
951] n_max_cbs: 31033
:CONFIG_RCU_FANOUT_LEAF=3D6: improperly set
TREE07 ------- 355903 GPs (98.8619/s) [rcu: g639182469 f0x0 total-gps=3D159=
795908] n_max_cbs: 259737
TREE09 ------- 305700 GPs (84.9167/s) [rcu: g9668841 f0x0 total-gps=3D24175=
06] n_max_cbs: 2498623
:CONFIG_NR_CPUS=3D4: improperly set
:CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy: improperly set
TREE10 ------- 220566 GPs (61.2683/s) [rcu: g3456465 f0x0 total-gps=3D86440=
9] n_max_cbs: 507348
:CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy: improperly set

Thanks
Zqiang

>
>							Thanx, Paul

> Thanks,
> Zqiang
>=20
> >
> >As usual, I could not resist the urge to wordsmith, so could you please =
check the version shown below?
> >
> >							Thanx, Paul
>=20
> ----------------------------------------------------------------------
> --
>=20
> commit 079e0f894c5d887c678f94332c1fa7287abfd6bc
> Author: Zqiang <qiang1.zhang@intel.com>
> Date:   Fri May 13 08:42:55 2022 +0800
>=20
>     rcu: Immediately boost preempted readers for strict grace periods
>    =20
>     The intent of the CONFIG_RCU_STRICT_GRACE_PERIOD Konfig option is to
>     cause normal grace periods to complete quickly in order to better cat=
ch
>     errors resulting from improperly leaking pointers from RCU read-side
>     critical sections.  However, kernels built with this option enabled s=
till
>     wait for some hundreds of milliseconds before boosting RCU readers th=
at
>     have been preempted within their current critical section.  The value
>     of this delay is set by the CONFIG_RCU_BOOST_DELAY Kconfig option,
>     which defaults to 500 milliseconds.
>    =20
>     This commit therefore causes kernels build with strict grace periods
>     to ignore CONFIG_RCU_BOOST_DELAY.  This causes rcu_initiate_boost()
>     to start boosting immediately after all CPUs on a given leaf rcu_node
>     structure have passed through their quiescent states.
>    =20
>     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>=20
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h index=20
> 99cde4c947699..b4ab952f04ea6 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1159,7 +1159,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp=
, unsigned long flags)
>  	    (rnp->gp_tasks !=3D NULL &&
>  	     rnp->boost_tasks =3D=3D NULL &&
>  	     rnp->qsmask =3D=3D 0 &&
> -	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld))) {
> +	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld ||
> +	      IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)))) {
>  		if (rnp->exp_tasks =3D=3D NULL)
>  			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
