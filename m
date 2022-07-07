Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE41A56A6DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiGGP1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiGGP1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:27:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA6F2E6A9;
        Thu,  7 Jul 2022 08:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ6iK8ZMk32JEZ7j47i+b5AdZbA2MFOx4QK8b1krvsIIPz3up3Hcu+FkrDb09ckIOAPlWySuITWLOO/MC52KV1n9zgi45gEbT2jqtLHWp6h/6cYd6KR1abIXhOKiwqmC6IHtfe+qBE1Ja4r1t1q0NqKN55uYeMFaE07gy4RtKC1H7gksw6TNOBYdoPKGdehzbQYFlJvWaxrNtCzpLHcrDDotRiCJEk7glHH6BPva6xn20IWAXejG3pyoVBmKlP9M2djdZCTJW+6eG+1XEsEl4eUuTM0Pk1RV5BB7SHBvD7EQ0ndCQr40puFooazdMPqEYAWmFJcnrXNs9oEwFoSouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cflTPdaTBS1qx1FqCstuBaDzkotQcI+iTKIiMAHC/y0=;
 b=Vpu+bucFYSgSXzXNZ6Wlhf13sV9dBxfBEeM5ZvxRHxo0ygRBoSNy/reLXW/4/AVWY9XvFX5NXf6vbrSqq9GYPTpuPMQeiEJZAYkaYDGPucLkbcHq5CR8yK2agjSsFh/hWQZi1JR/UL+HyWGh/QBCs42aJkie4gzPiy13JATrzcLGRMXvcrfQuyEWEI59RzHSkaCrIyqrJSN2ZYFQi9aAStCrFwRlEseRtyz0ND5hV4YkyDtkEJB7D4wyOVzqQORJbtNdCNkm6Li50VnOCLrWdgQx4gXgAs9sUsecHBr6VMinm/zjT0aS4c9ZAgkNCP/diBci30Jmko9YZua9T9+eFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cflTPdaTBS1qx1FqCstuBaDzkotQcI+iTKIiMAHC/y0=;
 b=BQYI3TWWgKOK5DulZ7X2dLwiZnnKfsF9cnoORRkTQWR1zF+8/wsU1VUB1Pzih+Q19vxm/AfrnPmxjO4Jg5EypxwDNU7VnCIinWKtXt/6VUH10/7dLVnB4juyKV8arRfbicwaFEvdtpEsbC9NRa6lSph8QaAPR2SoH8kMmDMmXgM=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB3483.namprd12.prod.outlook.com (2603:10b6:5:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 7 Jul
 2022 15:27:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 15:27:24 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dmy@semihalf.com" <dmy@semihalf.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "dbehr@google.com" <dbehr@google.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        "zide.chen@intel.corp-partner.google.com" 
        <zide.chen@intel.corp-partner.google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sachi King <nakato@nakato.io>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>
Subject: RE: [RFC PATCH 0/2] x86: allow to notify host about guest entering
 s2idle
Thread-Topic: [RFC PATCH 0/2] x86: allow to notify host about guest entering
 s2idle
Thread-Index: AQHYkgDy4lzAjPGC9UKu5zAtzCiz0q1zB75w
Date:   Thu, 7 Jul 2022 15:27:24 +0000
Message-ID: <MN0PR12MB610107D8E99AC05C7884AEE6E2839@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220707125329.378277-1-jaz@semihalf.com>
In-Reply-To: <20220707125329.378277-1-jaz@semihalf.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-07T15:27:21Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5e06c8fa-9fa7-4eef-8d22-2ac09137181a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-07T15:27:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: de8b1b8a-0829-411d-8f2b-c933272e8c83
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 342b7545-8776-403e-e510-08da602d3195
x-ms-traffictypediagnostic: DM6PR12MB3483:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MbkCYreULCjtP+eb8nktS3Nm4V4H7hwRH0bXEWA9g58wsymtdf+p4pfdptfw8XnhmD0/CNQcizMf4F6BG22p3HnHnMckT2CotBY70snCsqbhFhEoSawvzNpI6k7JjXS/HoKWt/C7LBjsImYTwGcR4ypIWOhcxNIc9S0Cne4N03ybCdbwF5cbBBLX9vRU3TBsYUyUJxRXDuL6RZNQ9jlcd+tjuQnh+ozGR7JjOkfBHOgYJUxMLCGNu4kuxkUMfwiWGB1TMU+SDF2g/pbTI7SrHIR7cJcAV9UUb0sdgFa8A6/2mzYGg9fp4cjIG8M+EltC0YH0yHr1tIJDN4YGGbHDu/OP4vRfUHalfC8cUDDmO5PqUhtwVDvHzFsQCS8UXROaywKzD8g6c7QJk/N6wmi+VG9REjSTDbT2k1Pv7zjmCrHxFoWeppc4f1qNmW13uezYuilfFxMTeIsKugX8SWaezNGG/125VbgKMMKbhvzkECeGdiyd909x/84EbdZOJLNyq74yGXg/u17gxzWvlrMcRTgVZPg+6Pb/Zs2kRDgFJ7zLSQBw4fI0U7rB8jehmkVuRcdCzP3swcjO28FH4QhWsS72gOaoldvIh7CJPYRCaauWHC9DNHS3jTzBWPL9MIZJaKUoXX/3sF6CWLseU+XYfjZ0N9STyEO4gAQch2wGV9KpfsSeBJER1ic8pgnvRz27xHhEc8H/HwnPjkOe+5yklUQp2FUasIAJOzt65/G0nVU7ayP3jiHh0vJ4rU3fSvPhBfNSpZKCm7jXZXVskK19QdnQSF+p05Axe/rqrLDXpjWp+j+u28vmhRJcA7DtknPkawFn6XmP7Y0/6ksnGkFRzWL+IkMGdiXiwhSGWJY0ZDXt5s2sOjcMJjE3Gim9Rgbz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(45080400002)(6506007)(966005)(9686003)(54906003)(110136005)(38100700002)(186003)(316002)(41300700001)(8676002)(66946007)(38070700005)(4326008)(76116006)(53546011)(26005)(8936002)(86362001)(122000001)(64756008)(55016003)(52536014)(83380400001)(7416002)(478600001)(71200400001)(2906002)(5660300002)(66446008)(66556008)(7696005)(33656002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WUz86dADOHKj3ckIaSvg4QCKzvI8bD7h3kr5a+UqB2u4PqZNV8z7d5DKS9E+?=
 =?us-ascii?Q?I/rnWSKWxmrQKhnHKmRRez0wgafw+EwzV2jRegfTNMwNRXP6/knwQYTqIC37?=
 =?us-ascii?Q?Vtsrp86SRqlYssey3k2MaR4D5rdAau49nNA6ySBgBJRhLczGB7xgVweXxu7i?=
 =?us-ascii?Q?uPdm4UxNKoEsaoonStcrvttZ7vnIAORcClc4njJWhVSJNjNZilQRTu8+kf3n?=
 =?us-ascii?Q?aFLzz41SALnJY7O0Ivg7FuskOysi/ObwGNVRDHPauAD9FRDj4O0WvXnMRd/j?=
 =?us-ascii?Q?8AFgbtG5LmjOB3GQMfa03+IqC4QdR8YKAB7FobpBND/E/l4qR++/pdkbNr3F?=
 =?us-ascii?Q?5hHlkoONkfUkwJu3ETUioLvVLyCd2Y9ZeZ3TGW66+/dinQp2sq4ihRUpoM+J?=
 =?us-ascii?Q?cLlCWu5OreIF7Dy7yq6XQ8tFoH/uxEr9kN10OThWxf3ITE9tOgpjrFsUv+5Z?=
 =?us-ascii?Q?/OpLCLEJUoIC2oaAy/hvzcfBoQEMaJwFIQ64+szLC2us2vRo2bAS7TDphOpZ?=
 =?us-ascii?Q?xEqiC29ERU3/F5ek08Zn7IQ+Oa/tOiQ/7CED5P2kh4fjbMsBbQN4p4eEKOjl?=
 =?us-ascii?Q?AIV0X3nXcrHNd3gBT7aRJalCpeRPNFFrhnL34gFPskZ4mdwadVuU7Hwmq96D?=
 =?us-ascii?Q?NVkfIc34W+pg7pUAYLlRRMX29eG4iuqzbmqj8rZZYB86vq4hrRUdx0LW59+0?=
 =?us-ascii?Q?fEpGKJjHM7Wtq4YzHa9lBhbTnM6rzwG+rGVXY8qThDN+uYhepoxt1vwxHQQr?=
 =?us-ascii?Q?NUDRl438dj54DjD0tv66RElEET1iBaPBvhuxnI5C6Ebgr3IVp+8KjyCC4CDz?=
 =?us-ascii?Q?LA1IUE194B8X3RvOSoAW+oJW7ZbnRKFw4lC3O5NYbFtNWc5Ifqh5HIcXlJ7N?=
 =?us-ascii?Q?DSbtNeUZhclBGVyHkTJYTkb3NNZy31tCe/thrwmwrwBMWMGxa0rjbCTIy5dR?=
 =?us-ascii?Q?aenaVvrSRFbie6h0ECJrnNAX/hi8unWJa7BSuYdEru6GdHQKfqgC0MYWN6Ow?=
 =?us-ascii?Q?mYlGTUyNYMMY5XAp/Fp9L508Tc6e1B6+ReeTi+MAaZ3OFL41uz9appA6ZQuM?=
 =?us-ascii?Q?/YrcDjPUNAgOkJCd910zr+pg7jX0xKvt3WmoH8fN8PMQqmO4RlhB4wxK4tWx?=
 =?us-ascii?Q?+qqLI5BpyGBmcG8PjLKeSosvmqxZh+TMhTmP7mscH5BUx8JoKPOEfZgk98Vc?=
 =?us-ascii?Q?K8cZvhtfgy99sG5lCrFytIG2lPfM9ub39DCa9LjXvB3YC5o/9B7/RLivdvtj?=
 =?us-ascii?Q?KL4R2X/gQ+raDscCB9P92Y9BjPC3kiRXDKhJbAymFR5MPY5onYpOElHZL2av?=
 =?us-ascii?Q?ac/qs/DthCQ5k+ZknuxI8eVtDYstF/rwS3fC5W5Tq157DUvqudACcavzIjQ3?=
 =?us-ascii?Q?ZuuQF87jPkNha3NT60cWOmt9IUDqyY12a/jTAcWRngDEoDWgtiodQbdLpcQL?=
 =?us-ascii?Q?ODcCeLS/CNzaRS3YngR6acSht5Dihmny82BJhbUovL9QoGYNGGh1KOtoj04F?=
 =?us-ascii?Q?QO/7BdKY7+y2vzVlNjvkzLdpZOfYCLcYUDt5MEoDg5RD4vqj+g+UdKTfbYmE?=
 =?us-ascii?Q?srtJ0zOBLJGGokg85hw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342b7545-8776-403e-e510-08da602d3195
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 15:27:24.7266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qf+KEi9z7U15mZ535ATNjBqQnXhyxyjOq6W6mpoFxM+0Q+JL8itaOumJOUMWAi76M5daF2Wr2QvCSsvGK/lEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3483
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Grzegorz Jaszczyk <jaz@semihalf.com>
> Sent: Thursday, July 7, 2022 07:53
> To: linux-kernel@vger.kernel.org
> Cc: jaz@semihalf.com; dmy@semihalf.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; seanjc@google.com; dbehr@google.com;
> upstream@semihalf.com; zide.chen@intel.corp-partner.google.com; Rafael J.
> Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; Hans de Goede
> <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>; Pavel Machek
> <pavel@ucw.cz>; Mika Westerberg <mika.westerberg@linux.intel.com>; Sachi
> King <nakato@nakato.io>; open list:ACPI <linux-acpi@vger.kernel.org>; ope=
n
> list:X86 PLATFORM DRIVERS <platform-driver-x86@vger.kernel.org>; open
> list:HIBERNATION (aka Software Suspend, aka swsusp) <linux-
> pm@vger.kernel.org>
> Subject: [RFC PATCH 0/2] x86: allow to notify host about guest entering s=
2idle
>=20
> According to the mailing list discussion [1] about the preferred approach
> for notifying hypervisor/VMM about guest entering s2idle state this RFC w=
as
> implemented.
>=20
> Instead of original hypercall based approach, which involves KVM change [=
2]
> and makes it hypervisor specific, implement different mechanism, which
> takes advantage of MMIO/PIO trapping and makes it hypervisor independent.
>=20
> Patch #1 extends S2Idle ops by new notify handler which will be invoked a=
s
> a very last command before system actually enters S2Idle states. It also
> allows to register and use driver specific notification hook which is use=
d
> in patch #2.
>=20
> Patch #2 introduces new driver for virtual PMC, which registers
> acpi_s2idle_dev_ops's notify handler. Its implementation is based on an
> ACPI _DSM evaluation, which in turn can perform MMIO access and allow to
> trap and therefore notify the VMM about guest entering S2Idle state.
>=20
> Please see individual patches and commit logs for more verbose descriptio=
n.
>=20
> This patchset is marked as RFC since patch #2 implements driver for non
> existing device "HYPE0001", which ACPI ID was not registered yet.
> Furthermore the required registration process [3] will not be started
> before getting positive feedback about this patchset.
>=20
> [1]
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
w
> ork.kernel.org%2Fproject%2Flinux-pm%2Fpatch%2F20220609110337.1238762-
> 2-
> jaz%40semihalf.com%2F&amp;data=3D05%7C01%7Cmario.limonciello%40amd.co
> m%7C514a545cf9aa4a7b6d9508da6018138b%7C3dd8961fe4884e608e11a82d9
> 94e183d%7C0%7C0%7C637927953769026163%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3DRIDiHUNpHUsBYyK3pwGND%2BWJoioXZNCKt
> mML2%2F1LAxs%3D&amp;reserved=3D0
> [2]
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
w
> ork.kernel.org%2Fproject%2Flinux-pm%2Fpatch%2F20220609110337.1238762-
> 3-
> jaz%40semihalf.com%2F&amp;data=3D05%7C01%7Cmario.limonciello%40amd.co
> m%7C514a545cf9aa4a7b6d9508da6018138b%7C3dd8961fe4884e608e11a82d9
> 94e183d%7C0%7C0%7C637927953769026163%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3DBqykAwWzO%2BfeGPSsAqTmX13O8F0Vvm3G
> PL56EpmdSJ8%3D&amp;reserved=3D0
> [3]
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fuefi.=
org
> %2FPNP_ACPI_Registry&amp;data=3D05%7C01%7Cmario.limonciello%40amd.co
> m%7C514a545cf9aa4a7b6d9508da6018138b%7C3dd8961fe4884e608e11a82d9
> 94e183d%7C0%7C0%7C637927953769026163%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3DQXK52zFXJGEBm6xIv6IFeF7Xxgz4Yp5UmgLSQ
> diXtlI%3D&amp;reserved=3D0
>=20
> Grzegorz Jaszczyk (2):
>   suspend: extend S2Idle ops by new notify handler
>   platform/x86: Add virtual PMC driver used for S2Idle
>=20
>  drivers/acpi/x86/s2idle.c       | 11 +++++
>  drivers/platform/x86/Kconfig    |  7 ++++
>  drivers/platform/x86/Makefile   |  1 +
>  drivers/platform/x86/virt_pmc.c | 73 +++++++++++++++++++++++++++++++++
>  include/linux/acpi.h            |  1 +
>  include/linux/suspend.h         |  1 +
>  kernel/power/suspend.c          |  4 ++
>  7 files changed, 98 insertions(+)
>  create mode 100644 drivers/platform/x86/virt_pmc.c
>=20
> --
> 2.37.0.rc0.161.g10f37bed90-goog

Thanks, you matched the implementation I was expecting.
This looks fine by me.
