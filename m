Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3321579348
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiGSGcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiGSGcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:32:05 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DC323BDE;
        Mon, 18 Jul 2022 23:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYScM62OPGv8eNIUvbziGmET1xt6qn090J1aln7qb0frOUjNjhiHm8kAWMFGezY6yNnhsIvRcnNoGev5ks94dDEwG0F9+RwrUlS1D/QlydRBvxH8aqU8alYE0vtF4rDO3mAFIbvwhQf/isHadwQjwDVXFmgtNLxdqSjcyGlEIWGuk/naMWHuNxKaENQQaiY+TkmW86VKwsKIFoOyWMm0lWoRNgGTD0N5xKWT4XpsEpaXOfxag+UA19G5H1nEsLFcNoQtaafoLFCr0sW/Uijd0QRypilUB4Ht5RTF0nuH5ZnPpFfdWWQKVLorK5qccXdavWoOyi9yrTr/x8aPslOn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTV+MeOy242/e/rik5nvoJRESg97IHs1BYQBLCkmXyQ=;
 b=oE4gqmc3SP091GVaPlnh1mJRfxdHRr0gokl54oHqXFyNK0oGMOpXXy0MaYua4fxnKGBSk2Vo6PDD9dTzVjPtRNvEdo+ZSYr6MALM4rHp2wgikH2KJO3MB2MYR9D7YdybqTQUVXUS18Bg376luJjP4zE/28lURBg0LD6DRCPvvR85tBB21y6cWxS9bKYKlGL6l+3HPvWqmUbxdivekqItqpfdR0mtIGJvGxnvAM8xt+H2/yRtRyXp3yB6HUYVCVxrQhUdSbrTqARA9D63kyd98qyHqR19wIz15LZKHtcv3rEWlcK2nlHkXvvmwCN3vKxsAl1tUTb+CLUOucdFnktb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTV+MeOy242/e/rik5nvoJRESg97IHs1BYQBLCkmXyQ=;
 b=vG9m4f2pl2QdCTNgy99a10hiQ8xhOkleKwpIz1D8OHVaroyeONgRd7ScWUU5ANRT2Vygkt+FSbFsWiPLy+AABysWQGmpqOZyk/jZBMd+zqe95B9mJHdBrY6ULa5Cs0vbVRaE5jB1zJWzH5gIAm/xsVUsxIEgoYfhrUQQHcj11N0=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 19 Jul
 2022 06:32:01 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 06:32:01 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
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
Subject: RE: [PATCH v4 13/13] cpufreq: CPPC: remove the acpi_disabled check
Thread-Topic: [PATCH v4 13/13] cpufreq: CPPC: remove the acpi_disabled check
Thread-Index: AQHYmDJucz6q+OTWyE2eIocZUbRKfq2E54yAgABaP4A=
Date:   Tue, 19 Jul 2022 06:32:01 +0000
Message-ID: <DM4PR12MB5278656DB297B438DFA5F68A9C8F9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <da43e5feeb246c02ba4ce6ffb5fbd35fe7bd9f14.1657876961.git.Perry.Yuan@amd.com>
 <YtYD6bRaFxby2KBW@amd.com>
In-Reply-To: <YtYD6bRaFxby2KBW@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-19T06:31:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b94d793c-d7fe-41fe-b4a9-3cae7072d6b7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-19T06:31:57Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d40fc043-9e19-4830-b87a-8961288e22bb
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7674885-1d9b-42d1-b3ef-08da6950635e
x-ms-traffictypediagnostic: DS7PR12MB6359:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9vW59nD7XWm6I72AU/4dQfK1BcWYEAgbGE5Tdx5cE1QXIVyRkjUWV6QwLbOY9Pb7p/5pL8nDxI0XgVnjvlUkfTz1ghUdEfCTCEQfhZyRhQUMijHL+pq0J5h00bwbV/Xl6+mSdxXwmkqRktrmvJfdu0itu2hOMCab2RBDc86L9u+qw6rBvnZXXn57KPqrjUurnv1sVBpgWoSSgzkIfGuZ7F/O5k9aZWYApC0rkrB3ha1Fa/nb8IoATkE6qyh+mBLuA6N386H6ZHwsP9mdtQESn/x98SlTzxA/PIO+V6QxJx0rXzqnTCH9eT8n6iJtgeSAv0N1fLhhhxPsBOkIfdsN/gL65fOvC2qmDlFBiHf4kZ5hZUBB9nPstpO102B5K1EmBdTo8qcCrDuQS35pujPUsMp/1cC/M9/fggKO8VC0kYXJPTeFu4uzPeN8oFyrdoM7nlN8vGGe53mNzndEGEjAhNbp+s8WCxiYpTL2F3dMjZATz2gRQM/V9bp6nWFspNkDi2PKw6fYRrqcjd0RZItPl27d+j7hlulSv/qdSUq3YMbLbNHTJJkN+1Bcp9Gb6syR12BhR/tiPQel2KH6gRF3UwZzy9huu3oSU5csNY7ZLjy10JjDSwjmnIMVztc6rCTvLdSHkx2YmuCbD29sUXJdJUlxw3MEb6ODqN8o8vXhJmUZr9c+J2d+XtS13CbDjmrJYhxpCNJ/gc+jMSqna4/5suInkll9HHfz3DZmiNXN4kY/kFpNIUqk+AEAr9ICIsk7A5gFvQCMxgOX0UBr7DqgcaxkfK2n7drjxVgHRhCzh+gwTtVARzWs8tpJPkOcUfwM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(53546011)(316002)(478600001)(52536014)(54906003)(7696005)(66446008)(4326008)(122000001)(71200400001)(26005)(8936002)(86362001)(8676002)(38100700002)(64756008)(66946007)(76116006)(5660300002)(6636002)(41300700001)(2906002)(66476007)(6862004)(83380400001)(186003)(38070700005)(33656002)(6506007)(9686003)(55016003)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RFZuW9alU6IcbEGclgIMg90js8qqUK/VI6bipSbeUKLECsAZXCnaZZ2BnB1D?=
 =?us-ascii?Q?CjTQ/Bco+2PHXb+BGoPdbd/gDqmoNTWdsAmW98JWfPmUVFRUqV+HMa+i42Ra?=
 =?us-ascii?Q?dC8s6ZFjLx9IExg2aY8XTbz3k8ZyoX0di6HzTU2zZiHCRp6cifMWPq0BzfRp?=
 =?us-ascii?Q?KENIINcuNVu9GzPG/rW7Ni9BrS8bLMKa++RqsSV/zbTaxoZWK0pyVjUdwF61?=
 =?us-ascii?Q?9T1FO7FnfY+uNa91O5cBVYGontSbdmI9h06+2yuLiljajeeSh3DGHshceo8M?=
 =?us-ascii?Q?tTAL/JH/OAnOhXn6wi+kBn3BrrMjmznd07NVAexHL5g7QAA5vn1gKbTSA244?=
 =?us-ascii?Q?hE/pzHrl0nE9gme8g0yt3i8+MGlCnYdsZfZ2mKW/KXjSdvLQziMkMbHE8IB4?=
 =?us-ascii?Q?MKp3eQ0ENOPTJyhRX0AMsDj2XD1lbGgbIUIOVEHvbj71B776LvZtZmjW8SsU?=
 =?us-ascii?Q?+/7niQAcxca4IuqiA4gSlESXuUb+2CAWkIWlZZYGrBt7QmdczJlPLdmii+8p?=
 =?us-ascii?Q?kJcPsc7VZNbwqfhXopKz+96Il4dIqVbsA+NzGptYwjXKtdPlWvVXqJlGcRCd?=
 =?us-ascii?Q?YWQuKCLqg933LEqyCjeQwaPEcwp0Lre+zx3HhunR3X0sv6nju4KhYr6fdlqI?=
 =?us-ascii?Q?+/Kp3MrsDgvSihPtfTjG6fr+LvQy39xElJFAn4MIJ7XAjaBGSXeY+8vu6IgO?=
 =?us-ascii?Q?GtF6ttBWmbFvYobQbIy4gk4QVWWrIqmj5CV5+j9xWIcR5kY9n+4zwlM0ee+c?=
 =?us-ascii?Q?K781SH0q8Q0YE0C2LH7cOyWQfvuxiBJSFBxZQtEI5UAc2Thw6KX+p8BM1aHu?=
 =?us-ascii?Q?rETL//hmEVy57AZ0/hOV5S6Bt7UG5kHjuZBOOfQueTiPmCmktbEwHW6tNSkG?=
 =?us-ascii?Q?8KsOC7HscwuxWTIapP2HAM+lvLC80wYQaOkKOX31Vu8o+Yf5eFu4NoRlcvOP?=
 =?us-ascii?Q?7sQMvV5ap1c2XhnrOgUvIpoiwdCa5cRC0GT0THvICy65o9vXhr+iZ1thz72B?=
 =?us-ascii?Q?78itv8mIusd4BRNiLCh5bUQ5E7K8EI4U9SWhGhHgMkMIuLjbE0Spfe5S7E1S?=
 =?us-ascii?Q?qBGRjdJIpsjUmWePZ41xiFE+eA7fMVVmeR2U/PDpt0oy6JKNcFr3PU/bu/ft?=
 =?us-ascii?Q?MZ0LBMiczLLEH9eJElhjqfK5GOBLW3eBHY0WbAzsVOTBGLNrxVe+N8jRD6Ou?=
 =?us-ascii?Q?/66hKg9FkGWIaQB/BeO4OA+X3ez2PLTmYZddOQk+lEM9oSUJbj2DSAFMuS6T?=
 =?us-ascii?Q?S1qBs/OVAFMXZqCeuw4deOZXNL66GOVvEvcqZRpdVdjLc+SabCgjX6o4epmL?=
 =?us-ascii?Q?jheXpv4wR8Gp7Mz5gt+gHbFpOXPg8u/lK9Rux7E8IKwy2XFXAz960SKifi04?=
 =?us-ascii?Q?GqlsTAcL9e0uniQS5HnZJ9YZzsqsrq1B6BNenGhiznI6DWTz/l+pIyWMgSkF?=
 =?us-ascii?Q?d2oJkn8r9QQZPGdMjb2IMQ0MoLXU3fjdwbCXhrkms+ixLnVV9hrilY2MF3Hs?=
 =?us-ascii?Q?V8c/YZBqnXsvr5FfR/mKbChM+xSpDYvWV1evtyLpGkCm5oEnkR71P4XHIeLq?=
 =?us-ascii?Q?+FBnVZI/gyRYceU43BgSCV1b/V+SMxBBzoYv0+Ec?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7674885-1d9b-42d1-b3ef-08da6950635e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 06:32:01.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KyIKSZzsxg3LCsXZNyNNMZvKY81FVQA1MRld42oJKhtJh7RNiF9DcKx7FAmpc6dqw4KUVL7n2Bi8Bx6otTZyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Ray.=20

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, July 19, 2022 9:08 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4 13/13] cpufreq: CPPC: remove the acpi_disabled che=
ck
>=20
> On Fri, Jul 15, 2022 at 06:04:32PM +0800, Yuan, Perry wrote:
> > "acpi_cpc_valid" function already includes the acpi_disabled check and
> > we can remove the duplicated check here
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>=20
> Patch 10, 12, and 13 should be one function update to move the acpi_disab=
led
> check into acpi_cpc_valid(), should we squeeze them as one patch?
>=20
> Thanks,
> Ray

Sure, will merge the changes into one patch in V5.
Thanks.

Perry.

>=20
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c
> > b/drivers/cpufreq/cppc_cpufreq.c index 24eaf0ec344d..9adb7612993e
> > 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -947,7 +947,7 @@ static int __init cppc_cpufreq_init(void)  {
> >  	int ret;
> >
> > -	if ((acpi_disabled) || !acpi_cpc_valid())
> > +	if (!acpi_cpc_valid())
> >  		return -ENODEV;
> >
> >  	cppc_check_hisi_workaround();
> > --
> > 2.32.0
> >
