Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA00956D2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 03:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiGKBjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 21:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKBjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 21:39:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09C66440;
        Sun, 10 Jul 2022 18:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldhFakzD/DjU8CQAgbd63rXB156dIWaZ7D10E/oYqqxPztnZWMzfsmqF/YoFA2kUJ4O301D/c6nCp0DzdEQRIeaPifQ3Rt0dZt+w/68W2vxd4ln3ndvjEopgc2Uh0eexmunCDvXpOh6rH2rnqu9U+f4yQoGmZl4zejuWNcFvc2M8wn+k1FMSmTqrLtKK9eei/5p29ZKnl7pnnkzDGTsSiYOlAPKw7yxCo5BZAhKOvxwUt+svpoN0o/vDGP6UeEugaFkjeCVDZBeBFLjIsZ5YCWI0Kg1W08a15s4CpZ5H2GQwljS1S6Vnq2DrHRbbSBjDl53l9SXjx6F3KQOv0fxRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qr+9zitSf0P+fu8mkYw/ze7pBSe/JSVnEd83PbL4Eqk=;
 b=Fu+MbdlcWE3mAIv0Z4EKDAibOcHJ477C0+8jC75e6O3xGxyoiErLsiWQsZaEG/DBclgvCI9Ki8sQCrsbUUCfIPGm+21kMXS4/I8CSordXgbdX49gtqWpR92F4puSPAR8NAMRx9vpzrAogjI4gwdVollZmHbfLMrVgvIJvf7agCH5EtZZkR54FwQl16KNPCIwZo49WMhQHSZ7Rs/zupiNCACFjzo/4P9cn8nB+IpFyr4ja0mAoCpkAIxDGUV0XdbUhgRcKb5ksMczdeVnkYSJzBZqCPlRyWrB+mXKVelAzVG/vHNQHnZkzuDuO9IJrrF3vSoy4CrOpaO5qqqplb3clA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr+9zitSf0P+fu8mkYw/ze7pBSe/JSVnEd83PbL4Eqk=;
 b=sV4R492TnjkHfuMzYXvSsXAcNqgArMJ4UH+vx9YAVeKKeX2t55Y7sbiF9wvthg1w+Y6N+uSUd+wCHlQDzKl9TzAW5SiZttXhDMS/NfXwsorhA8yjhQscmAZrK3lKNuXoILa15o73JkvJTfhUF/13hTslI3S0N9BX9FZu3oDgjCo=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 01:39:11 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 01:39:09 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
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
Subject: RE: [PATCH v2 10/14] cpufreq: cpufreq: export cpufreq cpu release and
 acquire
Thread-Topic: [PATCH v2 10/14] cpufreq: cpufreq: export cpufreq cpu release
 and acquire
Thread-Index: AQHYk572EuKZuGe1vEeWclJdooiFQa14ViMAgAAJLkA=
Date:   Mon, 11 Jul 2022 01:39:08 +0000
Message-ID: <DM4PR12MB5278B192484CF7B728875DD59C879@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220709141940.836412-1-Perry.Yuan@amd.com>
 <20220711003934.rn2igfoxtpcsiocm@vireshk-i7>
In-Reply-To: <20220711003934.rn2igfoxtpcsiocm@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-11T01:39:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1c773abb-1d19-4481-87a8-cdc11223edfb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-11T01:39:05Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: bb7453ff-dd3c-421e-bb91-da91e72f1e0b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e184a1c-f177-4192-77bd-08da62de2626
x-ms-traffictypediagnostic: MN0PR12MB5929:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kM1FNv8eLLuhwPtSG1th84by8p+cpsYoGJRPjO2osfgaV4SvmI/ZOoMe7ISNj5BQ5kyuGP7i2ZKrTScG7o5VVTPos2VCE88nJfoIPXjF3zCKxyv98wFin2Lfb2/rHtqFqS2+W5gpcOnXs+CJadCH2+YK18+yM8NPGoNDmFw9AuqwyyZahwWaDp+FvOHckFv3Rw4UblFd09bNJRW5z9YPSxmVyZCVcHh432DxLqBcJ9zTnI33h6IAovnztjJBrPefc1Orm8v4w8n8hMHYgZoomJD/0t10s+ijANXpRe4nx0CGtbGrYW2BvXogibLulxQdvm9UQNeflDhH38Ez/bYowjIxP3clx9MUaGLe5K+3OwQiUvgfvRhv0dgl26qQJxd9lHEvNhRhDE0ZfQjNZeG+SWdO5pnKlYGeLPE/gnie0RYGh53sqgpzH1J836+Z5pw4Wgc43xvcBYhWtldDNqTQUN0ylSygiGa+1uiUGRjkZUikpR+lqkkDpbSIFPFA+TFa28BunWk6DzvBDRBKBd6Bpet68+Aqvvs66CyArtPVBqICPGTf7wpIRJ5bgJKzLXYh5spPtwgCkb7tIHwaVtaqyb1yM1htkA6NO7Ftefzr+cu2+uK6FcKESFI74EgoG5HvekMeWZNhOL/u539GgH1pQMi7fQL0jm2mHTmwD3kPcJP1priIZOa/UAytmKRs5QM94C4NFVB5IXIVDWPEjW1bDRDk199iIdgpdW1WOymO+UKVKAAwBORJpQcCAA0kdq+7royGeXf2qTAXaHtID3ul6qJCn+2I0teQ3iqHJM6Yhx4FVOXFx7l+hijTTKV5heHk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(53546011)(186003)(26005)(86362001)(83380400001)(55016003)(7696005)(6506007)(9686003)(2906002)(122000001)(41300700001)(8936002)(5660300002)(6916009)(52536014)(478600001)(54906003)(76116006)(71200400001)(64756008)(66446008)(66556008)(66476007)(8676002)(38100700002)(4326008)(66946007)(33656002)(316002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TAqHIb8rUUk+tA/fWu9kilSeBClXgwoAFkoyE+NQrAIoWKcyT6FtfzkY6xnb?=
 =?us-ascii?Q?1E+e6t/5gD2kSuC8qS8ulaJhAJzf1rbfLLK18Q/HwdSqJtTmHPaOicWM2aGT?=
 =?us-ascii?Q?k/LgGoXO/g6dldNRcq7ovVh9+fEohH3B/Gq9Ols8jmwgNpWsMdI+oHm27IQ3?=
 =?us-ascii?Q?2WVqYi4IcGBk8qzCS/kLmCT/hHD1BjfdCVhICUB1VGImYZ5xZ7K94Cre67XN?=
 =?us-ascii?Q?W/puLoRv1z+Yz3CilPVZW4lfWfqu1Eg2LDeW2Cm0mD4yn8RDzaa2XubB/Z13?=
 =?us-ascii?Q?qOTRcMirKRpXWza+QLMdL2nhN1sgOPgbDcsdeCu4k0A9LSiQEy+DRO34ZTLp?=
 =?us-ascii?Q?CNKHXzH7K7Ir+npIjoPPmCpnBJXNKkCIj+8S++1JEOJGQUDdfvhZaIrUZlAx?=
 =?us-ascii?Q?w5mkawUzv6b26VcMZ+Dl5YBqUvCL5k77Gd0r45VzbhkhWl9Mj/JU90Q9VO2H?=
 =?us-ascii?Q?3b3pVnutropRlieiIeuo83raM1zyvKq5+pxMXo8YZ+hQsGWWaH2pgO09NRQ/?=
 =?us-ascii?Q?OubWPZfYyMRhWwjR9hSKLFeQBrVOIWwXeJ9GcThk+K5Jfu2suX4c6JwsQjFf?=
 =?us-ascii?Q?BqXiYWtx2+kEykDsW8VEL0mjGhBTtTJ6b7MZXGUucebJM78AciQXqS52rFbY?=
 =?us-ascii?Q?mjxFOjV7mkQW4wcZBfRb7h4lA2qBUQ8di3kde5iEk+AjvRzXV+xoznCI5R/D?=
 =?us-ascii?Q?4d6c9Q28d7IEaa2HWPtKp50yDqP42zLMCVPCkVcdDQLFr6kPFA4LdmyQJjXC?=
 =?us-ascii?Q?jJfMCKM1TT+Ow/Hjfzo92EW28qHe9C84/j47doIyYl41Urw6GmPC8h+yjCWP?=
 =?us-ascii?Q?otZHaT5HFje9kXO8BYKxHfd/Gr39fReX3vrG9vIqAe6EysGMwuPXMmdlWN8w?=
 =?us-ascii?Q?YDOTSUvaljveIo5RwanaNMSheKp6bK0IQ8PUKC7KzeCtR/7+veXoE9TcvtEZ?=
 =?us-ascii?Q?2aihdPK+9is3KVc8ZWJCsLNqRQtsf91+09qBjtyHPyV5UQKPoaa6a7hLXdCj?=
 =?us-ascii?Q?9NJDWnWYijmc9rqkopdI0h4y+OccYlbxoXykltVyq7lb/2GvjtPmUMLXlXxB?=
 =?us-ascii?Q?74b8pxOC0lkb6gfBrt3T9csZMUVmnDS8nY5pYNbpPWrCj76gEPrdwWyOQE3d?=
 =?us-ascii?Q?vC+c/sNPa3VMGoaDqAaxrF/L0CLoHvs+MTvv4lRN0eT7yM4XW6r4+11WpesS?=
 =?us-ascii?Q?wsGzdzbqBmihT/M2QRMnL2U1qa/SQ3hRf9Ir6aeDQdatJJo0iGlqE+GgzK7w?=
 =?us-ascii?Q?RAFhQ7xBJJ+GyRWBLGK8QLyxwnisJ6x3JS4uaLdz41jx60PBHDgs9mTKVA5/?=
 =?us-ascii?Q?fgkO9q9/4YGL+c2+8TG7iWCQI449F5US7x9YNe8TtFuz4qZu1waGb4UCcztJ?=
 =?us-ascii?Q?dxQRRv5hoZz8ypHcaIwNIB9LI7bO4tiv2DCvVHaebuaNkuO+AEzm9rZQYgbL?=
 =?us-ascii?Q?Dl98bO28GjMjooLZEjiA//6vC+dKavJE6B3LCPiszNrw7250Id+LvMCkgpde?=
 =?us-ascii?Q?+Msp9/0NI7bOX7ZCldIYE91JSYVH87ztzKAbpwEF5FlJTDzzmQPZxGOb/Nq1?=
 =?us-ascii?Q?e+dzudaCdli2qyaUgqCiLa/eFWb4I4EZSLD8Wzgv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e184a1c-f177-4192-77bd-08da62de2626
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 01:39:08.8039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZeS9dUC9RiPWywaKMdsJCLlHYpyx07Rdhb4GemL4CcDk7KEMy6GSGSYpptuRBQ3NaQdXzekRfjFR+0r5xh2dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Viresh:

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Monday, July 11, 2022 8:40 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>;
> Sharma, Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 10/14] cpufreq: cpufreq: export cpufreq cpu releas=
e
> and acquire
>=20
> [CAUTION: External Email]
>=20
> On 09-07-22, 10:19, Perry Yuan wrote:
> > "cpufreq_cpu_release" and "cpufreq_cpu_acquire" are only used
> > internally by drivers/cpufreq/cpufreq.c currently.
> > Export them so that other drivers such as the AMD P-state driver can us=
e
> them as well.
>=20
> I don't see your driver using them, what am I missing ?
>=20
> --
> viresh

The amd-pstate for EPP mode is under testing, I will push that patchset in =
a few days for reviewing.
If this patch makes confusing, maybe I need to move this patch to coming pa=
tchset.

Perry.
