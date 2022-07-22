Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EFC57E33D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiGVOvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:51:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE57272EF0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGOvWvt9WMT2JA9E5IJIimxG+QRFUUtaHYyTfOrj+RbcDgnPO9y+BUoULzZX6rb91Ywez//ZvI0i+U/ao6/dBLcMgohQJ+qgk6u8poEZbAm6ht+eXkV0ofpT4urdy1WF1NG0U5V2NJlLEU7h2SGhYP0sF0NYgw89tskjhKXnJfC845NxF969qplJhtrDbuE+T5SS/PeNbcbYS56Eo30jTw8FxH8GOvDPmVWzyl/mmYh8LEdphcNsxblRd9a9SjFmMTh5AhHGHm2WvSw954hqy7kIbJ1MJObY9TU4hdnlQwB2zkFaA8BonRrcMJL/hGrPPJErVDpLWO9WwrJQyAYOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9TUaRS1Y8Id6rXtGGpwwqqxk9o9jk4eSmQDgu2NaDI=;
 b=nr/NS7TR1JutPRTVoUFpwhf1cXky/QFqWrGAVfuSVx7Oq5gdo8y2bOsHOU5hKuR2EcqMUl2CeDdIuSRyRh23E844FP7WMhgx3Z8TEIqUTfaIo8KMUUh7RqLvLh4BSGoWuHMaud+IZ6gmwbJCSoQ7gWb2sDiJe2YSWSU0eLfNl0aqpLN1uySp2VKE8Vnb24E4y1h/TLejFh9sDqn7MWlON6QnGoZNmTAJT6yZsPjsf5wlwYwTiZb7mOnIO+QAn+RiSx4snDJea43U8h3MqvF49tH3763F3QYfJDP9Xq43ROrqEMTqmualdHq4SSvpPtCmk6c70MgnumBJFUb6SyZSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9TUaRS1Y8Id6rXtGGpwwqqxk9o9jk4eSmQDgu2NaDI=;
 b=juJHT9Rtl0vgmUdVOfptPlYtjFLXviuwyIfmxImtDH9IDOvWifyyqsZGfPsJ5fD8xRbLJn7hqkqsqWBD8uX5hIzVqqpeRcsR4ibd2V/296qlgM+/ZFPZZJNNDqzsNd7vdR87g+sGMa9nkQCNt+YK9QFaZDYDPBEQtjCFS/0yohQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 14:50:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5438.023; Fri, 22 Jul 2022
 14:50:59 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "markpearson@lenovo.com" <markpearson@lenovo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        "gerbilsoft@gerbilsoft.com" <gerbilsoft@gerbilsoft.com>
Subject: RE: [PATCH] ASoC: amd: yc: Update DMI table entries
Thread-Topic: [PATCH] ASoC: amd: yc: Update DMI table entries
Thread-Index: AQHYndGxeTv5g/s+NkCsB37UOMEoi62Kdy9QgAABmwCAAABjEA==
Date:   Fri, 22 Jul 2022 14:50:59 +0000
Message-ID: <MN0PR12MB61015A73E0A812A0755B905AE2909@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220722134603.316668-1-Syed.SabaKareem@amd.com>
        <MN0PR12MB61015828F24938CBEA87F8DBE2909@MN0PR12MB6101.namprd12.prod.outlook.com>
 <871qud42z7.wl-tiwai@suse.de>
In-Reply-To: <871qud42z7.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-22T14:50:40Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cd504056-5b28-4c82-9219-b319ba95c7e3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-22T14:50:58Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 8a9f2e8b-4095-4286-ae40-a751b124b389
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0caa5d88-57f0-40e8-8c88-08da6bf19771
x-ms-traffictypediagnostic: MN2PR12MB4077:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UIJyv7ImxrBT5n5ZLmkfdRFbjonZHVg0OoYegA4RMsAq1B5ckgu4yBALgUMcPozAw/raYoZr7CSdWQVTmEmjHgB0UWW6AogY6ps5yLDCkYtltXWRO0pi5Xo/Iy6litqYm376ut52Tn15TGFhUe1FPTC1cochEDKhhJ2TUYuUAUxgTkwT2RWgNiJV+Q/H1c7gDyfIoJl5wflO/7iq9uhLqvYzctdpTUMCRCrIRECExwzUl39CcbUOlvnhB489nm4UX8WI9NtiL5jmRBiiCpeYwbkDuVPqfY4VXnBI6+rGaM/B2IZTLeqR/D+lR1F45Q0rAVmqEsl61gSa1J7mRcpznjrFZIrKMq7VotyjbnskC3/qsR9uflmU4jPpoj2Al+6iLQYV8SFhQI6N1X4OJTlPyRTLdYSCzM/smS57spwaulmC77s39ZMBN02m1ueSBdIIo8Lk37mYo94zO/2eLTgvvhYr2QaL5XpG4oDVqCnvm3oIIY0ZaqQvdrVNR6mc+31NFcbQD/R3/7QHhnbfEjTl/tPRq/rGAKwP/3n6UMZyT9ms+6ORTMjf1GdvAenyCloJmODjTtGmg6/vvJKKjJS8Oc4eB1f1nokh6Gode3KKnP1K+69UJhBggU8pcipJDfQld1GcEL+EY9uSayNwc/Gnkp5pr5jPEgFl/aXA+h+A9BFrVrfQVrS/H8TQ+FZMI32YaGmlB+1TlWPuGGFLiaLt1292rnlr8ChfvT062TSaZbIOs6m7TrylA84t7jHI+8vCGR8/4exmbVFChw7wxw+aNv4RPcEu7s6T3hnAK6CXVxO0p4bEHcRHJBveujYdSpAJuzv9hsxVhuirrQeukkve3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(316002)(966005)(122000001)(15650500001)(478600001)(6916009)(45080400002)(8936002)(5660300002)(54906003)(66556008)(66946007)(66476007)(66446008)(64756008)(8676002)(4326008)(52536014)(71200400001)(76116006)(7696005)(6506007)(41300700001)(186003)(9686003)(2906002)(33656002)(53546011)(26005)(38070700005)(83380400001)(55016003)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i91qQ2K5wk8s7SHUaS6g6fQlJh6bMx/XTPiAs0+aixkLY3q9EbEIi5xNwZ0f?=
 =?us-ascii?Q?yZJBXUyzukhNbbsG3gaKODTsyvYgPiYCAQcLHn3M8FDa6FW46K1DIHtI1Tr2?=
 =?us-ascii?Q?TWgd2w+akK9nQETc6bQCoWZuZLkdVY99CNTCskgmdQOawTna/1HerYP1ECs5?=
 =?us-ascii?Q?yh6rSf5UPPAUfJVroOQopsFWHY/dZbso2xTwrMPdOgE1JGVN5vn3Cu/mt/Zg?=
 =?us-ascii?Q?vLaDM1PmEQXJKBscltGiNriZ/q/I3EiLVop1JPBHbMDaagy5K3Kcf+RYroWu?=
 =?us-ascii?Q?QIHcvBnnR9IaHYuCu5Qunbdzy42uVmkNzZrZapvATAD9tXzT9skdVUbY9j8o?=
 =?us-ascii?Q?ndWp22g1JS50tVbzQ57ViFlHUXNLqJn6KdoNVCZQup2f69dE5MuqWSpbVPi6?=
 =?us-ascii?Q?52j7TLTPY7MViqSs9wxPGXahD+CDQD3d7DWcIs7axyxJlXaQdR8XACUqbQ9p?=
 =?us-ascii?Q?beGSxFvVdHxCyH0k709vmsmvCaw2340v8p+jqk6s2oAfk8rkKsVyj9SI0mZw?=
 =?us-ascii?Q?IyEY1zArPiszTGUi8oE5/K3BBngmJu5fSfpcDQtfD15nqZhzoNfeajwRUaRJ?=
 =?us-ascii?Q?Sc/Gx7AUHEy9o/EagClQQC/ds7hIdADfAMUFcmqHiCdv05EKxPNeIbN0ldUc?=
 =?us-ascii?Q?tiodURs3XVWL/dOip1gOEZJ1a7bvBs+7dCptNqdnRDnr68/8kAv+ImrdRJkJ?=
 =?us-ascii?Q?uif91DLnqdo/m0ubXd2jMVh83QRt0+xsKNyTM1eYgCWjX6aGbyuoilxS6kEJ?=
 =?us-ascii?Q?GdVF8TU6R9CrAb9rpuzjRob15yfUESMkgvVTvwwv1mw/egIFxRpYByCPMbKY?=
 =?us-ascii?Q?N9y35FVLHuT7wno/kQxwI7ocAhQzDimTKxUiO5B7bVZ+0kdF2TK1yoi2xMDs?=
 =?us-ascii?Q?owGjOYndZ371wHCweg1rsy6sSEhFiSKr0ohXqMgyENy/wgnIR+4WUw6EuNXa?=
 =?us-ascii?Q?L9wA0pPkIOFZE/XBuekiKt9/RLpjo7ucuW15Wt8Zy848enmSprTiDrQW5gID?=
 =?us-ascii?Q?t09iG+F/uXKz1L+IAVnYD/uW29Wub9rIXUNO3EhqZWIpGAg3pnvRIKOfDs7D?=
 =?us-ascii?Q?UDXIywkgc2FwLB28DTIMA5pYfgMYFv/ATIfSztJluDKsbRN5kEZ4jpYnUqaV?=
 =?us-ascii?Q?w9EwClCWP3A5ShOs/ZVqR82fQCerkb8qzMMqX0SURE3cWGKOzj4/wRLA2OR3?=
 =?us-ascii?Q?tm7ygIdooWuZpUqGpyqIPo5oCDcHRVbrBp/2OWQna4sHWHWIMD3u4ox1ygvs?=
 =?us-ascii?Q?tSuq2Vum5SNzInzLvXz0W/+eDc5CQZz7cZZW5gJAj9FNtXVxDHgXV+V1UIrB?=
 =?us-ascii?Q?T4UKQUGBYuditTBHpv7vH3L7DQVC90kOcZTvyoI/H5i5VOJ0hNyB+1BkyK9C?=
 =?us-ascii?Q?X3yTDpWxzic9F89SCd6UE/pHNlPPtZ7HnY8z64FkOb1oHEZ4TJ+uJvpxSHGH?=
 =?us-ascii?Q?f8tbU7KijrGd4NCgyy3mnXeww279a7zhPRJSX2mElmQ/2k34YjOVtewagsAm?=
 =?us-ascii?Q?7uST0UVj1SYaG5A20Fd5OFuROMrIVLhda/rP3uymMQo2BpGGfRJqMR/IueKS?=
 =?us-ascii?Q?gHR31GcM1Fsorjv4BjA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0caa5d88-57f0-40e8-8c88-08da6bf19771
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 14:50:59.7813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSfh/wXAD6JKB3CyGuNKdPRShoB1rT1ahxOZx3Sx6Y+d7HsiKQ/0tAp+3w15+juK9y1c1n+mtqW8YrVN2gDlVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]


> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Friday, July 22, 2022 09:49
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Saba Kareem, Syed <Syed.SabaKareem@amd.com>;
> broonie@kernel.org; alsa-devel@alsa-project.org; Mukunda, Vijendar
> <Vijendar.Mukunda@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Hiregoudar, Basavaraj
> <Basavaraj.Hiregoudar@amd.com>; Dommati, Sunil-kumar <Sunil-
> kumar.Dommati@amd.com>; markpearson@lenovo.com; Liam Girdwood
> <lgirdwood@gmail.com>; Jaroslav Kysela <perex@perex.cz>; Takashi Iwai
> <tiwai@suse.com>; open list <linux-kernel@vger.kernel.org>;
> gerbilsoft@gerbilsoft.com
> Subject: Re: [PATCH] ASoC: amd: yc: Update DMI table entries
>=20
> On Fri, 22 Jul 2022 16:46:40 +0200,
> Limonciello, Mario wrote:
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: syed sabakareem <Syed.SabaKareem@amd.com>
> > > Sent: Friday, July 22, 2022 08:46
> > > To: broonie@kernel.org; alsa-devel@alsa-project.org
> > > Cc: Mukunda, Vijendar <Vijendar.Mukunda@amd.com>; Deucher,
> > > Alexander <Alexander.Deucher@amd.com>; Hiregoudar, Basavaraj
> > > <Basavaraj.Hiregoudar@amd.com>; Dommati, Sunil-kumar <Sunil-
> > > kumar.Dommati@amd.com>; markpearson@lenovo.com; Limonciello,
> Mario
> > > <Mario.Limonciello@amd.com>; Saba Kareem, Syed
> > > <Syed.SabaKareem@amd.com>; Liam Girdwood
> <lgirdwood@gmail.com>;
> > > Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>;
> > > Mukunda, Vijendar <Vijendar.Mukunda@amd.com>; open list <linux-
> > > kernel@vger.kernel.org>
> > > Subject: [PATCH] ASoC: amd: yc: Update DMI table entries
> > >
> > > Removed intel DMI product id's 21AW/21AX/21D8/21D9/21BN/21BQ
> > > in DMI table and updated DMI entry for AMD platform X13 Gen 3
> > > platform 21CM/21CN.
> > >
> > > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D216267&amp;data=3D05%7C01%7CM
> ario.Limonciello%40amd.com%7Ca50898fc385f447a436108da6bf15b31%7C3d
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637940981608875195%7CU
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DukJGUsVoH
> MSqnjlflOUuQD%2B7dSV2gy8qunjKHkEHQHY%3D&amp;reserved=3D0
> >
> > Syed thanks for the quick patch on this issue.
> > I just noticed one more tag to add for the reporter of this that Mark c=
an
> pick up when he pulls this in.
> >
> > Reported-by: David Korth <gerbilsoft@gerbilsoft.com>
> >
> > Also suggest Mark this to consider to pull back to @stable, mostly beca=
use
> of the X13 IDs missing.
>=20
> Put Fixes tag pointing to the commit ID that introduced the issue in
> addition to Cc-to-stable tag in the patch.  This makes it easier to be
> picked up for stable trees.
>=20
>=20

Good point, here's a tag for it:

Fixes: fa991481b8b2 ("ASoC: amd: add YC machine driver using dmic")
