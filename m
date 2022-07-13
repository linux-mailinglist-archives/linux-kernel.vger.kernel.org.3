Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646DC573EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbiGMVao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiGMVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:30:42 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218B22526;
        Wed, 13 Jul 2022 14:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+lyu1olQdcSHQxL/VdG6BqihKrblWlqa7v7O8Ztz8QeKya8vYVATPHyu34ZSfl3gn8wUXiYRMWtukq6uoz++kCk6hWyCNewCK6RTlk8R4yuzPnWthSub/RvrSfqBei7jXSuXj8aEKgAOpC/rUCOX+GLv2F0JCepNDj/Zi8rV2JsgTlP3MRlEazzkGFd3W7tKUWGSBLRhi4WL2ureyf5phi/7iFDw/tUj4ovT3BUfzVabUnfFSkSxYExlSLd9bHEN1coSgEu0N5h4XMqSOoIeOW+fNJ1xr93odYJRZE5DwwE7TnOSwQ5HqqzPTaOvHhNvEDlgpIkGKo+GwOR33wA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFhsTplIoJzDtzgAn0grxC/E+FBO/AymAFckBEa8+DY=;
 b=AGN7OgahZPnYZ/b9nREtN2dYzeyV4lYJkrrk4R/3aWMBggDGwnGp/KebCTpX3F60JJxPhcoVY/oM0vXH/kU1n7Xy4mAlSSrrgfYFEJaK4ejSR/JlNoifpr96QYBYfqNOAMysAaS7XS9erF8QIevfJtKjoY0a3oSSYhtEBMHBEzK6pid05xCNAFjWH43XDMjL88UskkH92CPcK/OIrJbZRhn3vEGchF1UNV1tbwtlKaf3t2Rm1t/hYfY2bI70w3LcMJGnEkPHuYRslh0rOysFObV1f+cAdK9J8NSDMGx23C9PH7ngs0a96j66GRQfqPu5clnvYuMp2bsUPFCaGma5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFhsTplIoJzDtzgAn0grxC/E+FBO/AymAFckBEa8+DY=;
 b=cXwgczpmMUTAJrobxE6bkVf5rA8bgKjLFL47dD8MWgKn8aqZebTqIrm/FfOksc9DFAiXETr5tCRHtbqGCbzGYHWxORWFdU7nMh6pcf/Q9K2gJrEhoAULiGF9FUHX7cA5gmEqqYpKjeMNlmzBr9yN1pW9pBgkjjaw83RD8S3CP9g=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 21:30:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 21:30:39 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "madcatx@atlas.cz" <madcatx@atlas.cz>,
        "jwrdegoede@fedoraproject.org" <jwrdegoede@fedoraproject.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: Don't allow PINCTRL_AMD to be a module
Thread-Topic: [PATCH] pinctrl: Don't allow PINCTRL_AMD to be a module
Thread-Index: AQHYluJm/GGaVAMR90CY0VitQbx7aK180DUAgAAAI4A=
Date:   Wed, 13 Jul 2022 21:30:39 +0000
Message-ID: <MN0PR12MB6101367866088D8744679FF9E2899@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220713175950.964-1-mario.limonciello@amd.com>
 <3295df49-1ef0-7726-5cfa-462bac1ccf12@redhat.com>
In-Reply-To: <3295df49-1ef0-7726-5cfa-462bac1ccf12@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-13T21:29:46Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c6254ede-3688-4f67-9b6c-93d270a3c91c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-13T21:30:37Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: d84e156a-c5c5-4248-a3db-7f5d3d112273
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdbb0177-20e1-41a2-8ff3-08da6516eeae
x-ms-traffictypediagnostic: CH2PR12MB4088:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAhsf8TJnIB8hyts4Vnk1w2rhMQjVQFIyy/LVDWMtDi2Avtjt8I76cdcTXqaEmjdC/akolOYP8JZuDeZqOld2VAXlMEiYWfWwlVgFop+j0IA+QjcMYTmSrD+Hl+ALb+D7huRvytUBl9JokT7mFyKKDOgc1wBB2rKDneBLBmkg9bwV8QFmum/Zm5QU3WnxNGvxmFqDbrg4a4dABgVzs4EzuSpVBat4D7qTzm5mDwRf86aTAhpwHJjBp7e6FJtrc38bm/YhS/eygpyUOgAL2EYNl+vH6GyTkvcW65eUdbsb8zDbYnwHRre5BnMZgylxFzNyXQY9V2KGRI5V9Xc5IapTbEmJNnbJW7h4i5ylxUpjhYjdk/H/vem4J9xufGTBAywIEGPsBTj9Lmwqk2D1XM1LOtzhePkEmI9A/JqoPK5iR4faP07J4+mq9o7guFSUuPvJ+UAbo9GNi0wj9mhjtWl5/ELbSi2PY+WeGLJQTnvlIxYkLtHGNSTOVrxK3BrILTrHmvpqtH+ZOL9FnteET2oqWZD6GrQ5JY+BwawEyXe8Ppibd9g8gU+3v7ZRuGct5V8eWFqzSmtdvfBxUteJMbX6DflggjHPvfzBR48+SuZ08UiDieDDpYQoeHb+fHNQOLXWQYPsqKbGdd+wRJggd/gzYU8ars3yetcT7cNKHF+56OSkWq0aLju4nxzwR9jmjoKQ2YFcAGP3OpiND5mJq7mnTEpnsqG71tiolrOcXFPR3EinqYQbUOGfLC1FWbCnr34fO/RKuYtVleaYJG/Hmed9wfiZM3Xs2N3dCR8k3JNn3aCHJmdhUgY5deEbZVUU1amAKj/DXQORdI8c/mbKHTxgFgIJ9Yz0SqlvisTrmod/kkLqvTWQzZhNYTkQKoDfjGn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(38100700002)(64756008)(83380400001)(55016003)(33656002)(186003)(45080400002)(5660300002)(122000001)(4326008)(9686003)(66946007)(316002)(66446008)(66476007)(8676002)(66556008)(76116006)(71200400001)(6506007)(966005)(54906003)(110136005)(86362001)(2906002)(38070700005)(7696005)(52536014)(478600001)(8936002)(41300700001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1S0taP1erZgYzH2FlDke7aKjBj0B09i2Eqv0EzGGGlPdFcXEfg6z9AGcMK30?=
 =?us-ascii?Q?HfQeixpMIpOfC6qFxWyeIkjLuDjB0Swdo/yaBfTsydlxHQab2gUjs5a29/c3?=
 =?us-ascii?Q?MW6MY3SkOJYWLbi36arE1Em8UnjynnbX8OeErYtENJp+P7bAnVkPtuSIjVxt?=
 =?us-ascii?Q?00NxrXYQhWe6qMo+XANY0KCA66Y1umqwkPWnDbXAeBJTelUKoBbjaVhw+qJP?=
 =?us-ascii?Q?AMYX4+57zCQ9Cdb4lVubuY4vZ/zMEg2tcH+fczWucbrDrs36jmVyAqDBc/qc?=
 =?us-ascii?Q?TUpaC/QsVKmLJdIUsl1dQ63UM5lxf1a3mXzvsjgY+35v93oeuEIYeplqbhnx?=
 =?us-ascii?Q?rzoGuPS5x3/pQi5Hf59P7HwEYRVSpmJa6wdJbWP86+wZrY735BbGQFzXB3XB?=
 =?us-ascii?Q?Uiqxr2yL0QNuKp5CoqTv67t9gMsZyng7BrIEhcsCkNSacNeOjAKpJflIyRSx?=
 =?us-ascii?Q?VUZZcMXopE2BVK028VO4HP4opGcwlVqXCNe1vx6CAksKaAsfVRwVsgX/zYOX?=
 =?us-ascii?Q?7jo+tnaM5HCkyc8/2TqyFEtRXL3Bz9oziVRNoEtJHTXJiY9uuxSPIMBRUuzw?=
 =?us-ascii?Q?MEnUZpdHc2S3J0fJhV00B4kFmsGIQjdfqW5RUdIS7d6QvmFz6IBCoYdg52jT?=
 =?us-ascii?Q?zGeqP/Qrm72kX8tXx3yI1aMDNB/S/K30TpLMZ5Tak2VPpccuUHfLGv46X9Xe?=
 =?us-ascii?Q?HMFVefzoPgZJF5OyTOfqoMr7ADnoo8wjkyU5CxBw7v/eX5gwMgrH88W5ZwS3?=
 =?us-ascii?Q?6snUywFzLnMcNy5WmfmYiiBtuEiswxUVK9Zfhx1GA4/88mFEoRJXVvVlMfvC?=
 =?us-ascii?Q?hjShl5lSyecQARJxxHan1PFwCSfso4g+CeIvz+ZKUyXekhLVn/AVMe/dFHlz?=
 =?us-ascii?Q?gS9vL/HdDpDuNF4Z3gB+KUmlM0oVw0Ac1Ozg9SQ/P9BcqTr011/I4Y0GWIuM?=
 =?us-ascii?Q?hHl4jghVLK1qBj7pVgSi9CB/V+co6P13a65XbF1CJ+xw3ux2m27n6oPY9RXB?=
 =?us-ascii?Q?6JmoR+Q1+llIH0KV45lreBjaNk8ZYovNbQbhSwLj/XdDCvTjNHH2uhW7J6k3?=
 =?us-ascii?Q?89UkegR50iKHpHQTC4l4xvFcQp/HG+RYpKwA44fUO4BHedF1/aLEBn/2jbsK?=
 =?us-ascii?Q?CBpHwuvSCR241UQ1+g+pdfUomxkKlTMHCNEfsNsEHg298pmEGesFdwoUT8yM?=
 =?us-ascii?Q?zAEFyW5IiRl5NI80ELenCKusTIvD7qZtVmv6XqsEjPxqbGSTohv9rTDZN1sJ?=
 =?us-ascii?Q?MS4s99a2HSelooamB0BhMf09e8j7+OCEs7L+MW+IxqGrtzxXVbZ/GCTWk+Bj?=
 =?us-ascii?Q?Ky551WSplvurfJzAHbeVzm/eqTG8mq1vzgJezgqHo05tfyxH1tsfYi9SELJs?=
 =?us-ascii?Q?Gl0rQjvTo/98h3ae+S3UsbWMMnf6nPqIjac2mY4napvL2eu2r2w30rQDUeDr?=
 =?us-ascii?Q?lvRXrv9CJq+kvHl3HrQ9qN3EhVuBXEU6TP6YoDSztKDwQgX9NkonQvjXt024?=
 =?us-ascii?Q?wnrtzqwomWiJT0saYqTSAPt5BEQ5fOuVQnalvm1UPHtOuqmixkx7U2v08g1L?=
 =?us-ascii?Q?8P5a9oC5u2BuqKd6tnm/TwEUXoMnqGy99Bh0BBWWfy2/pntNW/HfjIRmjJcE?=
 =?us-ascii?Q?OHAysPIxe4WXNJYzXYXzLro=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbb0177-20e1-41a2-8ff3-08da6516eeae
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 21:30:39.3981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCXbwewB9ysjRAop1jiC5TBzm/kgiWH1MSHF/R4NtuQHZtm7z2DxNvkLuXswKEsSpTi+crZjUdoPZNg87lNVzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Wednesday, July 13, 2022 16:25
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Linus Walleij
> <linus.walleij@linaro.org>
> Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; madcatx@atlas.cz;
> jwrdegoede@fedoraproject.org; linux-gpio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] pinctrl: Don't allow PINCTRL_AMD to be a module
>=20
> Hi,
>=20
> On 7/13/22 19:59, Mario Limonciello wrote:
> > It was observed that by allowing pinctrl_amd to be loaded
> > later in the boot process that interrupts sent to the GPIO
> > controller early in the boot are not serviced.  The kernel treats
> > these as a spurious IRQ and disables the IRQ.
> >
> > This problem was exacerbated because it happened on a system with
> > an encrypted partition so the kernel object was not accesssible for
> > an extended period of time while waiting for a passphrase.
> >
> > To avoid this situation from occurring, stop allowing pinctrl-amd
> > from being built as a module and instead require it to be built-in
> > or disabled.
> >
> > Reported-by: madcatx@atlas.cz
> > Suggested-by: jwrdegoede@fedoraproject.org
>=20
> Note I generally use: "Hans de Goede <hdegoede@redhat.com>" for all
> things kernel related.

Sorry about that, I just took the email from Kernel Bugzilla when I copied/=
pasted
and didn't realize they were different.
Will try to remember that for the future.

>=20
> This looks good to me. Fedora is already building in amd-pinctrl
> which AFAIK is done because of similar issues to the reason given
> in the commit message:
>=20
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Thanks!

FWIW I poked around and at least Ubuntu and RHEL are both enabling it
as built in as well, presumably big distros setting this up by default may =
be
why this issue hasn't been very widespread.

Linus W,
BTW I do have a suspicion that this might be the same root cause as
https://bugzilla.kernel.org/show_bug.cgi?id=3D201817
but we'll need someone from that bug report to chime in to confirm.

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
> > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D216230&amp;data=3D05%7C01%7Cm
> ario.limonciello%40amd.com%7Cc28ab57936e1427e7a7a08da65162319%7C3d
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637933443003195561%7CU
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DXJB0L03z%2
> B3mVBZxdlX6q6MBanZQwymoQSwlmMCrPjcs%3D&amp;reserved=3D0
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/pinctrl/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> > index f52960d2dfbe..bff144c97e66 100644
> > --- a/drivers/pinctrl/Kconfig
> > +++ b/drivers/pinctrl/Kconfig
> > @@ -32,7 +32,7 @@ config DEBUG_PINCTRL
> >  	  Say Y here to add some extra checks and diagnostics to PINCTRL
> calls.
> >
> >  config PINCTRL_AMD
> > -	tristate "AMD GPIO pin control"
> > +	bool "AMD GPIO pin control"
> >  	depends on HAS_IOMEM
> >  	depends on ACPI || COMPILE_TEST
> >  	select GPIOLIB
