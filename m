Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAAD4EB4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiC2Usv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiC2Ust (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:48:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2371B4EBA;
        Tue, 29 Mar 2022 13:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRLWk8wDJMRhnTpL6odE9aQmCmFDoqipJnOTSRmh/uSH3zpUp8lXOox33+gxNH7eSNRkD87dCNepx6S1iccflhDAQNjikwc2l+GZ/TqvlwL0C7l/siNq/k9Y8IKZxIbzUZnwThqZrEF27v9LXixUk8ZgXJtvlIc4u3kaTag7KytdMyCZ/WovORD8uXwIicd2XCPFhO7V7meTYaojh5v6t9BpmdeIpgZI9wXGKe/I3mUCAyelwJNdh2rGyzB45Azvu0JHPgPE1uhcfnfSRUlKvzHt8RoWS84JMbJlOc+04HkFhyxkkX+duvvFqmHUqf5/rinb7VMVcYAeDSf8iDR/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWGjsp6bcWoD+PhWERM8MSXtSYDlVFmnFMGpERQQVI8=;
 b=gpZuDd+WWKqYB+qOVhmrxBSdnnICD/fl9sGzH9fsH52o0/g9O304Pjxvh1oXPbzubXO2qpJA6bYlRMDYA7I2/VB+QOeLazshs5moiAuARreef+3hDqfR8Om0J5WeS+sbM0orIaP92rsqYYpKgR4bzZUI/WOBRNs2EX58mPbrkZ+kj3lyjL2ddhh4TfoAQtf4LcoM95SnbR+j9DgAn6MO7UcPktqaKeiTMD5IX4jP2TaxyoM+y6fCvwzBUrZbME4UR5dZsRmHBeAhhpcyxUoX0lQk8LdDKuYtpWbeyO5563KGshDDbUvcjPj7RWWREByDVymmGD9c5RH8/QdEF4GZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWGjsp6bcWoD+PhWERM8MSXtSYDlVFmnFMGpERQQVI8=;
 b=1m0NXNzr+lit1DgtwH9HmUW0ZvAjdr03BHCfqrkLCFxU3WSr1Bx1GSECFCXSR/aB7VNaGJLedFA1nIcn7co9GiWxkQsQ3ZS8NwH1F+wjXkmVAUodY6cfELmSlkQQcQL0fbWZZS/eLsuOezCKMnHWGFkyAdenAQflPvYPfhxhCyg=
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 SN6PR12MB4751.namprd12.prod.outlook.com (2603:10b6:805:df::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Tue, 29 Mar 2022 20:47:03 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::b5ce:25ac:77a6:9903]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::b5ce:25ac:77a6:9903%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 20:47:03 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] Improve usability for amd-pstate
Thread-Topic: [PATCH v2 0/3] Improve usability for amd-pstate
Thread-Index: AQHYQxCvjIp4MpZ2wkGqsTNLtlSvs6zV3xwAgAD217A=
Date:   Tue, 29 Mar 2022 20:47:02 +0000
Message-ID: <DM4PR12MB5168F84795F4467B048B6AC3E21E9@DM4PR12MB5168.namprd12.prod.outlook.com>
References: <20220329015947.565-1-mario.limonciello@amd.com>
 <YkKhCplrh/TJl/OQ@amd.com>
In-Reply-To: <YkKhCplrh/TJl/OQ@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-29T20:47:01Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6d76b0e4-0579-4acc-be63-a9f05a6ff4ce;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-29T20:47:01Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 6c28d8a6-c195-4b04-8900-86251ced14ac
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36779823-0afd-4062-93ca-08da11c5478b
x-ms-traffictypediagnostic: SN6PR12MB4751:EE_
x-microsoft-antispam-prvs: <SN6PR12MB47511F9B2D9CD5A7F25A15C7E21E9@SN6PR12MB4751.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X9rCqFr5LJDgOhM+3dRsl6wC5v74pXHLhfIlpMpIY17fNhnCU2XlJH0xWN2/lLin+DCpUa531LtmLWnPY6wsArSD22rwJYHC3qM4pkv/UdgBwB+ZCF1ZHJtlXWF1YVufCcKOnmf2xuY4dwMGpW5kqoujtvkHf3qX4SenlG4qRsN3Nd7VMHyGv88XEZYTKnMvaVseQ6bq8sG08t148bXM9tQbjyq/1JT6XXWMc6EtUfL6gJclkeNlRNVYqE9FdxPNj+V8m5qEquLbSEnmRnjFMU5pOO8WilL6gjLVzw2/i62whqmS6TaK+zNOV1JhX9OZWiodrGpSG1L4KET2t2orjVHhaxNY9bSitdgCBJskOoP3aEpZDUuvsV2j7OegwtWRBnBXEQQ+Vv/+YP1dxbwq0hD6Y0/YcjWVDH33pa3u8sE65qlZYZchj7nCpHJ3f1DGJXNc+EgqqriVrER1kFyJIHSXMkLPZ/jr4xLdy/8vejdBrCo2qgpWu0WX0dzD1c6UYfGhDCF4yYDvkplBgzHALepC3T3mZNmkoVqrVijliQ2sMsZWNnfyk7+m3vvDgtLbv2Qg95ajAVxs7VjDGB2v6PyBz7PKcnJllpFZNmxN8gQKJ4InLw9KgSSvWRQUe1Ww/l4iuue9PU4zFh271F6W6F54yD/LSAXMwxAfhC+vBwz8yVUu+Y4eABlRMhYQlDnEsZif1YzERru6NwZHI0VFag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5168.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(8936002)(66556008)(8676002)(6636002)(66476007)(76116006)(83380400001)(9686003)(86362001)(66446008)(6862004)(4326008)(38100700002)(53546011)(6506007)(66946007)(7696005)(64756008)(122000001)(186003)(26005)(55016003)(2906002)(33656002)(71200400001)(52536014)(38070700005)(5660300002)(508600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aPYJiEQ9IZvAxR8llhKkY/o8ev07mcMAVX7tDXkb8tTGUbWpEkbm7Fmjtme2?=
 =?us-ascii?Q?+N1q5uOAHd0iRt6eYSbD+xYbnT2SxWys2IraXAz8MSsESolGPio/+tjPp+tL?=
 =?us-ascii?Q?V/s6mNgkGhgPxyfkaK2/RY4/vZ0txHUekduMW+MGWe5b2aJtr0gP+YOQ6GSf?=
 =?us-ascii?Q?5bFSZMhB5gXp7pyBg0kSVo11HbacHmHolnIzXnjqwoGHL7YmIqq40xDQHRVw?=
 =?us-ascii?Q?LhWYKOqvtRo6571/8yU7rm+X8y4lQ/HeJuR9XkT7eiUVCAHMbAtc38t2qpw0?=
 =?us-ascii?Q?aJIhuU82AI3ySllSHQEJiYRJZWNeKGvzV+pYYkOuC/1MJ/JZ7afSM+dYffcO?=
 =?us-ascii?Q?lJWxHeZsOzw7JvUQTz949XPliL5WkVIiVBsglFJIVWCqZyslg2Fs06H5aoZA?=
 =?us-ascii?Q?MOe0562VxHDbP1evTqz5lAhCyyqfdGnNd+oi8dh+Xqn26s0uKjAIYD2BXksf?=
 =?us-ascii?Q?YVgBP8AG2Cf4GLOhJJ5jtmKjn3fQkIEBKOUHuMnDGI1XHvP7OthAcOOdpIJN?=
 =?us-ascii?Q?BQgC0kwDpzRmTSnhCq9UfXzxghqSNVQ8ePWN7b5OVCKnaehTW4dkLB9ZqO0N?=
 =?us-ascii?Q?tWr772e9V8i5E0PcCIHzwJY7JRtcHJ4bPzgJNPH4RDKzmmDJhiY8F3XiOqHG?=
 =?us-ascii?Q?Lwl1dMo1ozkXgOvEq6EPHLlCd/4NOT3+wgXbH/eubInZXDDYkAuQ9EmKNX0I?=
 =?us-ascii?Q?zbZSV3b36wwrpawICc4h4ypiseZZHcFH1+2z8pOcWaBxz4I160FusasdcwP+?=
 =?us-ascii?Q?Qa3p+L6pF9w/xZjhMtZ4IJKIEF4mEGFOL2lJqCM6wmXzhxTovzEDIEQeY6Kh?=
 =?us-ascii?Q?SD81z79ozIg4AGAGWPJUQ6ynVzDSFrP9I67AqlseDb70cE1WAIci8Am8tWWU?=
 =?us-ascii?Q?g3X5j3qD898kEfqwsHs2Id8lPbZ130rz3v48XGYhJee1r0dtuUDSAUfWIQWD?=
 =?us-ascii?Q?JO0KpY9Gs6nW9gFckqxDyhq2F/P4NFNq8ZkZIu2l8WV3h6G2twojYBD7FaGd?=
 =?us-ascii?Q?7TfXDUmbDqXxuGnJCcXYWZLMFWK9OWq/RJ0XbkA867TqlQiQfVssN8jI5knI?=
 =?us-ascii?Q?IqxDFxvtVTGHK2MMMDaMyhmRhdFUqpWJlob/vCbPm5m8LC27Gpp7kPjqNMqr?=
 =?us-ascii?Q?9HYfHkAU7gU295/odxp/xX6VrYes0lW57XUqSL312hQu1MFvo0sANd6+Xg5h?=
 =?us-ascii?Q?Dl6fha2rncFkDR55K84A7XQZUNvcKtvLcAPL97p8aC3i4LzqbaXR5VHvdAu6?=
 =?us-ascii?Q?oCJftv+V6OP/Wez3WWBYdwosGTTJGRdybAFQp5BbxoKgjYOMrGJupjZzkpJQ?=
 =?us-ascii?Q?vrZdcoW+UcK8LuettyqCdpn2FTpxB0t1ZQak+WEglkSfYvblqBoY1EOw5q/P?=
 =?us-ascii?Q?tDNHH+J9Z8Rd8XKwFMsyg/F53zYGP5INv77Y2yHuCsri/lU1SBVaZjtnpE71?=
 =?us-ascii?Q?NQAzp9PmIL4Sl9+/fQMKTvHrMEGatgcF/4o8jSK29jZcGVTdj8LVq+Ji0Z6u?=
 =?us-ascii?Q?RnWORv7mgQciX5fHiJwQpvX5XfmJq0vVFBsVM8KUj4YT83a8GkfhFTlNqgUA?=
 =?us-ascii?Q?hELzwMMRiyrLtFIiKxaplQieAhk6tjH2RBAmxr0qT+xzNdP1kxUZ1Qp31lsP?=
 =?us-ascii?Q?q+EdJ53TqOT1VVPGYScf3/Z8RMDeXT1PM5TtQvIp4eusoihrzBTSl6/WsjRN?=
 =?us-ascii?Q?caP5SL24FnTxtMWhPXQnujtYw4bgyCecR+MVMaKFlf8tSkitDd4F0asjQ7xR?=
 =?us-ascii?Q?WpFydQw9wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36779823-0afd-4062-93ca-08da11c5478b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 20:47:03.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vF3DYdvDirjXnGL7HdUAGmUZ9fNS+2MW+vo1FWdvXv88icPIyaT5OXoAD0g+JOgTENJF+OFOE+WrifjYZl+MhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4751
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, March 29, 2022 01:03
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Rafael J . Wysocki <rafael@kernel.org>; Viresh Kumar
> <viresh.kumar@linaro.org>; open list:AMD PSTATE DRIVER <linux-
> pm@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v2 0/3] Improve usability for amd-pstate
>=20
> On Tue, Mar 29, 2022 at 09:59:44AM +0800, Limonciello, Mario wrote:
> > There has recently been some news coverage about `amd-pstate` being in
> > 5.17, but this news also mentioned that it's a bit difficult to use.
> >
> > You need to either block init calls, or compile the module into the ker=
nel
> > to force it to take precedence over acpi-cpufreq.
> >
> > This series aims to improve the usability of amd-pstate so that distros
> > can compile as a module, but users can still use it (relatively) easily=
.
> >
> > A new module parameter is included that will force amd-pstate to take
> > precedence and a module table to let it load automatically on such syst=
ems.
> >
> > With the patches in this series a user can make a file
> > /etc/modprobe.d/amd-pstate.conf:
> >
> > options amd-pstate replace=3D1
> >
> > Then upon the next reboot amd-pstate should load automatically even if
> > acpi-cpufreq was included on the system.
> >
> > Mario Limonciello (3):
> >   cpufreq: Export acpu_cpufreq_exit for other drivers to call
> >   cpufreq: amd-pstate: Allow replacing acpi-cpufreq when loaded
> >   cpufreq: amd-pstate: Add a module device table
> >
> >  drivers/cpufreq/acpi-cpufreq.c |  3 ++-
> >  drivers/cpufreq/amd-pstate.c   | 30 +++++++++++++++++++++++++++---
> >  2 files changed, 29 insertions(+), 4 deletions(-)
> >
>=20
> Mario, just applied your patch set in my platform, but it get the page fa=
ult
> panic below:
>=20
> [    4.195078] BUG: unable to handle page fault for address: ffffffff8aa2=
db87
> [    4.196838] #PF: supervisor instruction fetch in kernel mode
> [    4.197035] #PF: error_code(0x0011) - permissions violation
> [    4.197035] PGD 1f980e067 P4D 1f980e067 PUD 1f980f063 PMD 100800063
> PTE 80000001fa42d163
> [    4.197035] Oops: 0011 [#1] PREEMPT SMP NOPTI
> [    4.197035] CPU: 2 PID: 464 Comm: systemd-udevd Not tainted 5.17.0-
> custom+ #1
> [    4.197035] Hardware name: AMD Artic/Artic-CZN, BIOS WA21407N
> 04/06/2021
> [    4.197035] RIP: 0010:acpi_cpufreq_exit+0x0/0x46
> [    4.197035] Code: 7f 00 00 a0 56 95 d2 4f 7f 00 00 80 f9 e7 d1 4f 7f 0=
0 00 00 40
> 90 d2 4f 7f 00 00 10 36 93 d2 4f 7f 00 00 10 a4 87 d2 4f 7f 00 <00> d0 b6=
 57 d2 4f
> 7f 00 00 40 bf 1b d2 4f 7f 00 00 00 a4 85 d2 4f
> [    4.197035] RSP: 0018:ffffaee0c156fc78 EFLAGS: 00010246
> [    4.197035] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000040
> [    4.197035] RDX: 0000000000000000 RSI: ffffffffc04ee5c5 RDI:
> ffffffff8a706100
> [    4.197035] RBP: ffffaee0c156fc88 R08: 0000000000000000 R09:
> 0000000000000000
> [    4.197035] R10: 0000000000000000 R11: 0000000000000001 R12:
> 00000000ffffffed
> [    4.197035] R13: ffff9286ceead7e0 R14: ffffaee0c156fd90 R15:
> ffffffffc04f0740
> [    4.197035] FS:  00007fe0ab0c3880(0000) GS:ffff9289ee280000(0000)
> knlGS:0000000000000000
> [    4.197035] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.197035] CR2: ffffffff8aa2db87 CR3: 0000000105a40000 CR4:
> 0000000000750ee0
> [    4.197035] PKRU: 55555554
> [    4.197035] Call Trace:
> [    4.197035]  <TASK>
> [    4.197035]  ? amd_pstate_init+0x7d/0x1000 [amd_pstate]
> [    4.197035]  ? 0xffffffffc0477000
> [    4.197035]  do_one_initcall+0x48/0x200
> [    4.197035]  ? __x64_sys_delete_module+0x251/0x260
> [    4.197035]  ? kmem_cache_alloc_trace+0x34c/0x450
> [    4.197035]  do_init_module+0x52/0x240
> [    4.197035]  load_module+0x2471/0x2790
> [    4.197035]  __do_sys_finit_module+0xc5/0x130
> [    4.197035]  ? __do_sys_finit_module+0xc5/0x130
> [    4.197035]  __x64_sys_finit_module+0x1a/0x20
> [    4.197035]  do_syscall_64+0x3b/0xc0
> [    4.197035]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    4.197035] RIP: 0033:0x7fe0ab64589d

Presumably you didn't have acpi-cpufreq compiled in or loaded at this time
right?  I think I'll need to use IS_REACHABLE().
