Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30A5ADDE8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiIFDX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIFDXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:23:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529B2409F;
        Mon,  5 Sep 2022 20:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjYz3Q8/tZFFEwV1wXkXatWfuwCFs0Kx+9b7sleq8LIHHXEUJm/gpJUuTc07XmQuYy8QK2nhJWboTAkStYAAIBnJW2IzY1rHI5m/KXnTE0s12JirPp8AdDzJ5CVTuIjFAOTIeReRZWWWsgDmYg8e6erW1OhJHrsz+0us4OURt9LOB+OcAUR0BciVTqcGVC9v8HjOLh+y/Jkztu12bJ6hA9cHTGB5jR4gLc3NNND9pgJKtrXcCZOLqC/ZioQRE8slJiLnpRNvHQDnxRb44r5AI13j/kW+OqLmwYllPACL+wtj0bi9OIwTpB3j4AA+MlH5sjoGav2P07mXUthzNoNJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNwDRScT7D19biv3bg20mGCB/lmg5G8F7HuYUb/lUIE=;
 b=nI+Cg1VU898X8JouhQZbUsLQtyeaF108OPG/8jup2pswOv4XcQQFqOAX43LulsUwrMdDXGLTtPMsn+r71fTWuggj/HUtZ/cYvJsedsdO1F0vD/4LCk78Ml/YpWp76/1aKgKWYPOwp4zim4BXoX/DAhENB3CPoK2UVbTOnYx3S1EpvN3yhYOPmcJubrrwAa5uJ0l8Qzdoh8kQwP2FJzKr9Tg/Vuwd3CF0tF8PZmeOqOy2KJBF7oESCg530PxX7DkA9IIIpikWi66l5sAIFLXxQU1Tp9N62y5mfVlbt7DVwBDnCqhU4xq3XF6xrH7CgAXAMYsdmkOMv3ZaTTlwwtGXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNwDRScT7D19biv3bg20mGCB/lmg5G8F7HuYUb/lUIE=;
 b=iFbkQzk2U+EBWO6TCDFpRQ0YSL0VqA4WXtyEvN2N6lySioADJeyDv39ON7b2dWW1FEUO6kQiu2FXnlt2JkndIekjfnkjyeqLSdxp3Fa3TBbGkPtwBTsHFETQ3ufQ+QY5yFY83uo3fRX6ibDaD017vG95q1HhksidRScqm9rcMz4=
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.12; Tue, 6 Sep 2022 03:23:50 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 03:23:49 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Recall: [PATCH v2] cpufreq: amd_pstate: Fix initial highest_perf
 value
Thread-Topic: [PATCH v2] cpufreq: amd_pstate: Fix initial highest_perf value
Thread-Index: AQHYwaAUA++9T+HBpUi2lzLWtIlViw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 6 Sep 2022 03:23:49 +0000
Message-ID: <DM5PR12MB25044B57A57CD45950A7F0EFEC7E9@DM5PR12MB2504.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b45fc08-c8f3-4b00-31ab-08da8fb73780
x-ms-traffictypediagnostic: DM4PR12MB6664:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5pQX/4wZ8jsl16vxpejiueAQx5ZBfiUo7wVpznm9msyiBqHIuvD7fY5TDi6YJP2dlIC848X+TK2EuESSjD4VdJPeKI/ymcRSBeQ+5N9Ew3Ir/3ZUrrAGMsOzD+tfYlYG9TlW/CJFgeZP7PejG44lfG0sHnPwDZ2LHvv1s/CXZxNtzGvJWtzUzWWnwsBCy3gfdzTBOpkueOdONkhApTVN3SXBGirFAzTcDPDnr6fTnZdn+/ryVg2YZdJPB1Hh66Hq3lTOHANaYuP8EZLFyZHOQJK5Owo6snJObjUzLlvbmsZK30ah+0MksEsGTnRe2uPo5kuKEW13sL43vxYc7pCdri7Witqv8lQzjqw3K3fiKG2UY1GrwXPAqbFnhD22z/Z06LVq+H20ngdjc2pz039Xc2xZ35bN1FB76DPupruwUzLj+YxmOkjzSdxdC6lrBOmYMeJ+2Sm/X6gLFMucFJ+ZfLzbyarIhUz2YirqWMIScPQU+3knTL3Im9BK009Xi/3GxaD5N9c0fA5zuDLvXKXfxgGIWP6qvCmM6pulxpNLvO22rY0RJUyq/8QLBihG819LAdQmiVnZvjnwVWhBWRojuxwquS3dapbWz6Zl5u6NtU+7BPMRAqsxcwgokKQPs4C6XFR9zRjDeBN313IbyUnfjV5VTpUbDaUubVI6mUSKXPcfRQ2nlyo2bmRIlZJ/DMV52z3L+DQi7oQ9n0SuzmHYgPNPOeYtTdp+0qZPPqERe/cFAj8i1FDEmtoEw68zW76+dxYGVyxaem2LCU60kDgiCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(5660300002)(8936002)(26005)(6506007)(41300700001)(71200400001)(4326008)(64756008)(66946007)(66556008)(66446008)(9686003)(66476007)(76116006)(7696005)(8676002)(55016003)(6862004)(54906003)(478600001)(6636002)(52536014)(2906002)(316002)(33656002)(38070700005)(558084003)(86362001)(38100700002)(186003)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?njcnPcaDO8tTNObJ6ONAu2tGcmYIZs2YiKBLuhQkRyTLDv9UTwkSbIg/4HMe?=
 =?us-ascii?Q?X/105f8DtsTyio3QGW9rt+QUeQKLfCsyXMTGio77f+d7KT8pBaXUJz8tcp98?=
 =?us-ascii?Q?5/fJOP4+wqlzYUcwk5UNjMOqxyaTUnmFizsuqVsq67wbC2ndckvhLYwbx8gj?=
 =?us-ascii?Q?9RBsBisJjhb5cKgmLf/S5S9kKVMc2jkaarFQ3FUjbKbpxD48xU5Bgq5wAdE7?=
 =?us-ascii?Q?ZXCE+Pjuq8iA8kZwX8flXQ//6k0lRP2F6C87KfPWs5NuP3UDrGDFn7lni//i?=
 =?us-ascii?Q?cPCq/7yX9gF5tYI/aaMOH/Ugr//V3OCi0uUEYf+QpGpdu0xtc1y32D2Di8Ze?=
 =?us-ascii?Q?pDPz8TGcBoSpDR1k9LDep0zEajjsqT4aMfWsPb1Y9TUH8IwUgxeDmV9SX7rt?=
 =?us-ascii?Q?pSLuFR+eE2MCDCzfcc07ylZsQ8MLjnrB6vfmpCfF3O2HKJJ7qE6oWyciDop4?=
 =?us-ascii?Q?6G0SG31b85tSpX1R0iW94oYLDdY6F3D7HBH0dgfO3i7hm+/cfDt4HvIdEihP?=
 =?us-ascii?Q?uQi/bbl6JTHCKNvieavaosg41BX0FpTfA5mLOLbHfWIcdvehUIwjfFa3bg7K?=
 =?us-ascii?Q?EZBg3AcP9pldMKVPp5q1sFb+tpIR+3QRCjBm+CV7VgqMZ3RdP+nEEJDnyI0s?=
 =?us-ascii?Q?KAfJYmAs3iDBEmxCe43FR+JWdWYA8QimWhAnjpZF2QGTtSLr+Px7HHfbYsxQ?=
 =?us-ascii?Q?dS6e3LTNvD8z260cEvQmq3WoaL+TLKt7LeaeC1ApqjfsVMF4bqQKKvIhQpb2?=
 =?us-ascii?Q?r28y45vobrXyLEIrqWcWhBHQ+3ViDApjnZphF85GJU+kh5iwgyxBVeRDH0zz?=
 =?us-ascii?Q?0BdKFGU2Wz0UucvOgBgTE09b1yntTwClpQc5NA9OhuUmSiAeI5c+eO/JuLcp?=
 =?us-ascii?Q?sq2BX6ifnOBnXs+6MccSL1fKB6jy4iIoxIwXeRq/7tdd09sQX32pNtuyJTtr?=
 =?us-ascii?Q?qL+2gCFbqlCKMaymTR9g37HWCNDDnaFjXEk3lMleDbdX9bVFSAT4HJQkk0CG?=
 =?us-ascii?Q?KQPlrrFAkTGVpOmISfEKeAoHvYrKu4szqIpbgPJzemS5yIfupQuLdIBaGR/b?=
 =?us-ascii?Q?8/IvbANfpuRkD91U1h5hfFk5aZrYN0pRe5C9YnaajvjudDaPZFRltlQQy7x0?=
 =?us-ascii?Q?TXNMimA/Q7orAImWYgaaY+ixPMCMYK9Yx/d9w/LbnQElP+YZO3KEiF+XdzyO?=
 =?us-ascii?Q?KE6y4M4uGkHmDzbjK4RCaBwyrKhJRfI5pyDhRFEN3r6u33vEakg+tI/AtpCu?=
 =?us-ascii?Q?7jyEeT0l0VFwebh7Wx/uvKjQZzh3WTHQIgMmbJ1W8KiM0UnMhISICFPzmHME?=
 =?us-ascii?Q?/WifgSvh6LT4oOosq7aSAPFvH/nwAiXkJ4wUvWLBheb0tKGhzwe2w8Etg87q?=
 =?us-ascii?Q?6wCjSKdVG6xQuIcGdVgazg4IrpIo4/zbCqk0eHgjglrlVJLe9B3OUterGv4b?=
 =?us-ascii?Q?0+Ti0jhvR++dsXlpQezYo2s8zzPxU+kTe5okO9jMJQTgZvJHNA2Y5C2C8pLc?=
 =?us-ascii?Q?ZazFkOeeR+aFf0pz2gMp0rPoxIbsfMvyliAaP5PXJ3pp5w7CePs7HQLi4mhU?=
 =?us-ascii?Q?seqZLs/WL7VPGwJ/W+9YeUBBxQTlqZJz5X6rE0Q8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b45fc08-c8f3-4b00-31ab-08da8fb73780
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 03:23:49.8969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+agpFIzpDncjpRs2skZa3Q3HZeF7i/YQY9TYyR1tBeb+SEInsGDwXrQaJAyyklTBQFGSO+svAbOw3LIhjv37g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang, Ray would like to recall the message, "[PATCH v2] cpufreq: amd_pstat=
e: Fix initial highest_perf value".=
