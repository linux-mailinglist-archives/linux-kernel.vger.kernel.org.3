Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C7E5A797B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiHaIxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiHaIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:53:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296DBC7BB4;
        Wed, 31 Aug 2022 01:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIdWzrOWutXmkIOb7qg3Ogbs70JiwhRf9n8gMjN19Cb88B7UtkVnHlA95MhhecqXKEjKdi8ggfJuj6QLXhai5DtuTgvVp/kb+PlYq783OGhASFZStECBlAB+dwrR5rJyXg86X5gWNDhskrAP6qGLaecjfeBxXKQ00gxE6RyQqSLRdVfjKWGhd/dBnHNR8tNZc2DFskMuxAzmaFLpXM2WREp5doHRAGBq8HTeFw39Qwrn5HnbhiUN/h7fgUA83yaJ5DHL3QEneYelSep4xuJTl2ckv1y0Ywlh6PnK/CFZ8z/OpYTXO+77xmN9oOBPsgwJv3+A8UQ3B8VnGaFKqbkxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlXkzdDsus4x2iftEsZQWg8VyazIMlvFL7P2WcHtVD0=;
 b=DBquHvVrxO2cXOHFHQ6gmzKhgntJWMVGPYLGmJyVMD6iXWLaD07nVmYpusPBkhd5PQHsVE3iuJkPTf+Xp5WNYllHssGarOCYcghTYAI/4Q4DZrAT0zdNaS/vrTQVl9dx+J8Yg1ho2iAaZ04oZR9uOD7IgSNeVeOcPWeNbUfWhYdJlrDDzFMXh9qIc422AQQuVrWYJ9/NhgfTZ3T/eZv7OLej4tYjyPiBnZd8QbnSpxPKxLYzb4jb9/JhIv1JoZGeQl412wzY+JgfZwDIXg+EZObYPCZBS2sHZZrVt+J0uiGmAPUvOuOYWnV9k3kOVHnAVxd3l5e5M6dtcUwpQjDOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlXkzdDsus4x2iftEsZQWg8VyazIMlvFL7P2WcHtVD0=;
 b=zOxq53fwEtRjSeFo6600PIESUpelA8ZWQr9gZQ3qgUBzFCd7T82Ecp51ugcxRMZWi81QgCV5SKujb5Q8Mmegwilxqz9EKYYMI/PND71LmE5qa9yk0eGgb9wssmVsz7VS/t5bZcj1Yeg6THBGGPLr7dwuZRAM0ky7Y1JmE4H3rYQ=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:53:30 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::a970:8eb0:b1f7:5e7c]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::a970:8eb0:b1f7:5e7c%9]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 08:53:30 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Punit Agrawal <punit.agrawal@bytedance.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
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
Subject: RE: [PATCH v5 4/7] cpufreq: amd_pstate: fix wrong lowest perf fetch
Thread-Topic: [PATCH v5 4/7] cpufreq: amd_pstate: fix wrong lowest perf fetch
Thread-Index: AQHYr/xojEYM6TqTGUKdgfkVu76baK2wENvUgBi7yQA=
Date:   Wed, 31 Aug 2022 08:53:29 +0000
Message-ID: <DM4PR12MB52786384C0BFEFF5E0A381079C789@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
        <20220814163548.326686-5-Perry.Yuan@amd.com> <87edxhim3j.fsf@stealth>
In-Reply-To: <87edxhim3j.fsf@stealth>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-31T08:53:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f9e67d13-e095-453a-aed3-3da2e27ac6ea;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-31T08:53:27Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 34df444c-3652-4555-84ef-dbd52b3843d6
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06dbf62f-9f94-43ba-fb99-08da8b2e46e0
x-ms-traffictypediagnostic: PH0PR12MB7080:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPeiOwVcQUOPGg2fhjZxAcit8HQga/JCjSZoeUrqDl52jGVJxBZqPPSrXlr8n/L2U4j44xe38+0XrR8IZ1ijJPCfr7df3qSE2NivFl40bcz5O/NAZQeXG+vcaEWx8KkLipZN7kGQFZCB0tWKrkMgn5n+N++9K3H0NTyyOusGguwVItD9w75E1+sB8YNK3xRuOHR5/DiwsGsyZWNcPqIhJsNilnUauvLDum+J7zQjNw6o57ZGNN96VDLbxTm0wn9knd4xgJ5o29Ko+84hMB3hpkxRTA+J6Akna5lz3WryP67bdPF5+XCeBjn+rwVN/1EBt9P+688Dz5cxJmFahjugtvyn4R6ADSblQ7xcYkKebPrn+sVZKlF3sjFglkj1xPPPyk1meElobhaWczb/HyVxF1kadlFfo6AL58EhHIZZTesZ8haw8M30ajA8o/zhJa8up/FH3d9imRtyuC5Ay7e4xiQAwVXgZn43LAhqNod3hvCp/7d4Ijwvni4VSM+G3xZrb/v7M+EJ3TT8p9oq+BlSLlIVE1Kt+xpe/CMs1x0neqhLi3Ktw/AhnAJSHvmMgd+EETpnMq8+uIDfTAryPise4WAzv69SsP0d3ehk7mTE6NM3wklTNtPix6RopTZb/dCJTGzGOU6pIfrqOjCemR8c9MFFNAZr5C3qb5dopRPuMScDcx3sbk4mv5rirIXKb5nlcTt1SVa1Va5bEi0RZ7Ka8qsFRlTmFYeQZVha9FEFP3MnbH5Taj3o8TydOxvb+7/x+FQaSM6yBzUcZ8OAKqyGIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(83380400001)(76116006)(4326008)(64756008)(66946007)(66556008)(66476007)(66446008)(8676002)(38070700005)(186003)(38100700002)(8936002)(2906002)(5660300002)(52536014)(316002)(54906003)(6916009)(33656002)(71200400001)(478600001)(6506007)(7696005)(9686003)(53546011)(26005)(86362001)(122000001)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tNfJOLOCGUR7zWESw6RDznoAPwOBeXgpDdOxyKnc87ekCwr4w9nL8N52PAfv?=
 =?us-ascii?Q?gH5yMwi3UyoaqdEMWlpdFH6KaDnAG5mLZX+B/hYW2WU/hWgp+jT81Hz4PeUX?=
 =?us-ascii?Q?OatPcu47JB+96TUOcRAgct8qnrYcKo0oVX51d0sj4nONw1AZwAVEnVq3+tu3?=
 =?us-ascii?Q?LzosjFWCXE5das30XP5znIy6fjzIayN/BAmRzUUDNIOvSQQY8dcV0nGzPVcz?=
 =?us-ascii?Q?0orA4x5uGhaV/FcnVJDWoJcXj8a6kfH3/GLjONm+LV40iy1FBcnro2+MZxg8?=
 =?us-ascii?Q?qoTTtlRVgXX+MGnLxQf4EjGKPVQD0gX8JvyslGVysH2BDJq6DK/ziuBsxhyC?=
 =?us-ascii?Q?x744Fw8rXp+qPsjo5baP+pFay6LR2qfAxyhQaz97Q5W5ym4rq1lriFHUAllu?=
 =?us-ascii?Q?psvjZKbEBjcojXlITaEO811vYyWTDVn8Q6hZUpeiQOOT2/d6WqGgCiDBEqO8?=
 =?us-ascii?Q?BDv1hTABXfVICevb1ACEEl87NknXZzRoOUd/GeEa9L9qCRFkgqtNTn/Gz60o?=
 =?us-ascii?Q?1M2p1eSs3sLpQ4bjLWjA1HKEjBUIoWbOmydYfkXYe9HTkPG3ad7d0nJzCGgE?=
 =?us-ascii?Q?u0Zh0SxJwiZ86PrOKaLX149tmrCwZcu6A3coKwyxnMPUShqOqcKwqQjlfh/k?=
 =?us-ascii?Q?4LBAOu+WVgNmDGjkIO4ZyHydwD+R4WzNEHRf/r53fpoNNrlmeFGVZ9zQ884W?=
 =?us-ascii?Q?eBZvRLRxdaptbNKM8rUBEJzNf0fsxJFAmNDgMxq3hQvVjRyOjJIXCNzc946e?=
 =?us-ascii?Q?dKZfx+6V+yPj7g4IyKRTcKVI+TXQQ9a8qNLaV8G5eLhtYKVoinVqgvaBua2+?=
 =?us-ascii?Q?IEc9UT6Yqm64yCDfwhAeeJufjt8bGzMwJqeDq1qa0Q+Hj5iqCWq9yj3tRgzQ?=
 =?us-ascii?Q?2fTzDZqabUR3Sbrdl4dlI1sYse3XIR6zl0m7FA1aeVMrzZAW0+2E33gIrA0b?=
 =?us-ascii?Q?wBqo5TyS979T533iz2lW+TSY3WDCigLlL7ofyDt4V887UzqpwbLUNkYKaDjd?=
 =?us-ascii?Q?GJagL3DtrP0Vh1ki3uk+q6+QQ8039l31ytab+pq32cPSukIcWbPCc4EsDARg?=
 =?us-ascii?Q?DB35B6ZJipZPwbSyJKtUwngMNG00+Eje1tKb49n7Gll3A+CrcSYl29PnA2ky?=
 =?us-ascii?Q?bY/e2K9KEBRtedbviF/u0SwB+aTyS7TA/XsBi/d9RK/v8dFraaKhBi2aBkvE?=
 =?us-ascii?Q?YdgpHWHaTseC68ZDZ3nQ7YB3GTZsLgByeMIlXw34lUR8HstD72hwEv2m2fXu?=
 =?us-ascii?Q?2d6LW0kzQlfvo48nojAaASTTeDZUOK5O65txTxoNkaMi6aRhVC8C9Z5VPN4R?=
 =?us-ascii?Q?7JTYSdAF4Hbg+HEhUxrI53JIc425t9euPha9w8yKgyuh6UTPcaHBbjYYvsIs?=
 =?us-ascii?Q?OuQToCOvwvRauE+dm+Xf9pvS5fxCnqp6oU2p4SXs0Z00g/gfO1m12jEd3hx3?=
 =?us-ascii?Q?kEvfbAz7dS97oGXajbpEazTRt4FR+6dQEXvj9/zbjeuJMZ4QQ5liT+A66Ge+?=
 =?us-ascii?Q?IVH0vJhTJric/YG/mt0fewPcwAmzUqqrXmy/NwjnGZ//Jng13biMb/7PpRAc?=
 =?us-ascii?Q?Zy6F6e3DPNDjlPuHr2ClHuAhIESuF/SWhFt/BqsX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dbf62f-9f94-43ba-fb99-08da8b2e46e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 08:53:29.9783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAGC5xTrGJUNdPw6dqlWp4DIgxC6m2MNAFYtPuxt9rEmNltbhiBKBb63GMYpqiQdfLnz8wsF07t5TQ70ZvW9IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080
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

Hi Agrawal,

> -----Original Message-----
> From: Punit Agrawal <punit.agrawal@bytedance.com>
> Sent: Monday, August 15, 2022 11:05 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>;
> viresh.kumar@linaro.org; Sharma, Deepak <Deepak.Sharma@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 4/7] cpufreq: amd_pstate: fix wrong lowest perf fe=
tch
>=20
> [CAUTION: External Email]
>=20
> Hi Perry,
>=20
> Perry Yuan <Perry.Yuan@amd.com> writes:
>=20
> > Fix the wrong lowest perf value reading which is used for new des_perf
> > calculation by governor requested, the incorrect min_perf will get
> > incorrect des_perf to be set , that will cause the system frequency
> > changing unexpectedly.
> >
> > Reviewed-by: Huang Rui <ray.huang@amd.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > Signed-off-by: Su Jinzhou <jinzhou.su@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 5cdef6638681..183cdd4ba00e 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -307,7 +307,7 @@ static int amd_pstate_target(struct cpufreq_policy
> *policy,
> >               return -ENODEV;
> >
> >       cap_perf =3D READ_ONCE(cpudata->highest_perf);
> > -     min_perf =3D READ_ONCE(cpudata->lowest_nonlinear_perf);
> > +     min_perf =3D READ_ONCE(cpudata->lowest_perf);
> >       max_perf =3D cap_perf;
> >
> >       freqs.old =3D policy->cur;
>=20
> This looks to be a pretty big change (lowest nonlinear vs lowest). Does t=
he patch
> need to be backported to older kernels?

The patch fixes the min perf initial value, the correct min perf is lowest_=
perf which is captured through MSR_AMD_CPPC_CAP1 register or the cppc_get_p=
erf_caps().
Yes, the patch will need to be backported to other kernel branch as issue f=
ix.
Sorry to response late.

Perry.

