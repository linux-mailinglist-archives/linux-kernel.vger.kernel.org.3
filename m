Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD84D2D92
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiCIK7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiCIK7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:59:18 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12560106B28;
        Wed,  9 Mar 2022 02:58:20 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2298GqVr006243;
        Wed, 9 Mar 2022 02:58:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=7hkQOAfE42Nf0G4qjxCyovPvshl+8lJp4h304APu6b8=;
 b=PyWz1Ra+BmyYbDN6kvsUb4JFt+AjwstslN95VFWPSn095Nw/TimKw01w2uOgK1qFI5TY
 2DKuzyYRigCDRdYOt3veexp3Nx65Ql6nCi84wtcJtLH85VFIMYoojsuSPiecnYZ2iZwD
 jwmSrtWB+C1RpnUuLzMN/y0cDPYftcSueGw= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3epak3e126-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 02:58:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrvFg0jHhHxR5lFUXp6oEOwanSQOTHWf9eD2HIxmJ6A1hIG2SOJHodYkvFJl/HOyN+28oYEwgPveavnhJ3hHAsiTPNDh5Ko3scuoIFOgJi+DKbjcdSQ03Rnz6IjwZBZyyV3ve0fwkpBIQP9vSFxDOJxCTdJvHN/yOl6LvfoWwZNXyIC2BEWa27dCWDpnnx0YbVO0l9AfTTNb1DsSnPuJSoAAWLIosbRdod5IiY8vf0EVglegJfc5fH1PTxbrUJ52L3GoG4t+oVyaMvM+Tu5EWpiFgAe1l261Tfx69SJNsFup6NOREh8E5NO6nUni564fkFTB41iOrb6WSlkFfwP/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Luu+PvJnsCumMP0Epc/bWu8e+D1GSps4Q1cJ9bj2fLQ=;
 b=YFz8Azp7/jRreHJE0klYWTDUYxSQDQvfP65pHzRhGMr5Hg64sse705b63us9T/8gW1HKUYM7VfJ1G1f96YcEXzDE068RuA+04SFHLIvxLncfF5VGmuYCNptJiQTKBw3CQwSaSCFYNeus9a6GeacSMuAjX/X13zReUpRv6vX4VR75UZLYJPP0dh+VtvMRChsr+HfSNBW08/xTB4eLvhGpqFkDec45n3D7QD3e0ulXn5HVo7gNt/ZOvLzHKpIciOGHELefQYwSkdYH9uFHQ+Yp9WoBLDrKajKB+C3b4UegMkiehiNqv+s4Doy/JrSYf1Nz6H33Ye8yl5NPmSL63OA9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by DM6PR15MB2476.namprd15.prod.outlook.com (2603:10b6:5:86::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 10:58:17 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::7cbb:e9df:5833:370e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::7cbb:e9df:5833:370e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 10:58:17 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Dmitrii Okunev <xaionaro@fb.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Xiaoyan Zhang <xiaoyan.zhang@intel.com>,
        Pavel Machek <pavel@denx.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [RFC PATCH] platform/x86: Add sysfs interface for Intel TXT
 status
Thread-Topic: [RFC PATCH] platform/x86: Add sysfs interface for Intel TXT
 status
Thread-Index: AQHYM6IJ2oHmymlKRU22/keFD+BGbqy23yGAgAACvgA=
Date:   Wed, 9 Mar 2022 10:58:17 +0000
Message-ID: <YiiIRLZGq5c5uBjX@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
References: <1368465884-14779-1-git-send-email-qiaowei.ren@intel.com>
 <1368465884-14779-3-git-send-email-qiaowei.ren@intel.com>
 <20130516160311.GA12299@amd.pavel.ucw.cz>
 <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
 <Yg5A4Mupue0V9diu@kroah.com> <20220217123753.GA21849@duo.ucw.cz>
 <0cf678e0b01bf421f3db6693a15ac4060501a80a.camel@fb.com>
 <20220222093101.GA23654@amd>
 <YiiD3WM76L3jbMyW@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
 <YiiF9wfx3V+K1J33@kroah.com>
In-Reply-To: <YiiF9wfx3V+K1J33@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a69fb55a-8553-4331-ba4a-08da01bbb750
x-ms-traffictypediagnostic: DM6PR15MB2476:EE_
x-microsoft-antispam-prvs: <DM6PR15MB2476368DC4E6A13FFFB653A8C10A9@DM6PR15MB2476.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YZYqL/WHdcyc+XlVDmhLKcqx+hu36PU7CDQ5SAB9xxWdZGwuYb9Sk8xFw2VvXeflyKorkwslyEctG/xo82j8sA/BU4dSAFzCAz9uRkHJesaJXJRd/8zV8vvRz9i0ANdB9RlBxb6VPWbVGou768l33C/DSy4w1oBqWb7LqF7WJrSG/pYiyNsnYxf205zEu9gb10lxmW4F3f7hmU+vpqB7KwobWQYhB2CYCXNaPptS+veZri0vW2ArFKl8am63UK53Ms26c/hK/MBdFXSP4udzK8CUo67E3ZXyo9aqwkcftcBaXjgkOyQQofQD7lrtOYhuKEKLLTch27HhQ+dqblokyacc/B8dMmkv4qW3mubSLYUJVR60q1tW/Ys/aV7HlICfj6JGSIISamHZXaRp8lcf0sepR9UmHtWAIVwYhGO/0b5f0/3tpPxEKaPsVZXhcfjEVY/u/Mf1iyEpaRBEis2gtSYemShQ4Fm9vyFMbeRI+SIkqWYj6x+ZlHwQpKHhsyOodhhCs6YGcMqTOKkSJHZJRXuCjDXSV0PX7l/5YIKhqLFy7EdKzUGpzjBx6lmgKK7PDv4dstF3k/tbWE2vVV2iUhTM3XR9HaRFDpC7Pvl2Bq9JvD3jvJWj1CEg/41g3/fU+5XsFMaQuzyUEaWrNobJlOBSiDt2MxZDVwszhhtIsqAvV0leX1jFw/O45ZHGHEcrm0fS7zv+ZscGEP+RlycWH81DEk8G1AAffPLbHsPrfrX1P+P6GB84rwFVWtFgZCJ0RBeLlJhJdLH6hBfSCYMLfpXlck488vaDt5pNGo2FbIQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(5660300002)(66556008)(66476007)(4326008)(66946007)(76116006)(8936002)(86362001)(38100700002)(6486002)(7416002)(6916009)(54906003)(8676002)(2906002)(91956017)(316002)(83380400001)(66446008)(508600001)(38070700005)(6506007)(9686003)(26005)(71200400001)(186003)(6512007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nRsdzsN6UPDOv47g7ekwpuX37U+fgDh85QYcxcVLiyBU0lj1pezrbmY0+PcX?=
 =?us-ascii?Q?xcTmtOfUoGhEesVPzR7ypGgPEAR/JbYfLWfU+uQAz+WZHKOJInjcP6s0DFZI?=
 =?us-ascii?Q?Vr8h3o/OnKNDvdOdvBhA+OXVx0Wtwm5GcCx8qLmA4TVj7EXBhd/UNw37EzC7?=
 =?us-ascii?Q?KArV9F3aX+C8gj6rCc5TIHQzIYXuXzAsZoiHMojFkoIIPk7/BndAbucD02k2?=
 =?us-ascii?Q?pbqZXqdCcUaZZwNPH8XkKz2kxQ9t+zU0KNdhj5ssGhmqsAd1TIDE0DMbwEtT?=
 =?us-ascii?Q?wdQAwmH2j3ixcvbxT3bul/JBv3HJC9z9hjfCAjJMC6jWX2nmZsVOWMN/XNww?=
 =?us-ascii?Q?z5osedht+2bm0yH+oI0KqRfuTn7MYGULI9iZH+/lIC2KCssimzzEMfLy03YG?=
 =?us-ascii?Q?mfPchtlljy6pESMA6v3PzTsCGiz0/mmARCGhzIr92UH3W7ebKK9WGYPSdctD?=
 =?us-ascii?Q?Yd4OR96qdWfVeHoM2VH1dMI5cBZxUetZzqM3GLula4N+7YPa016QBxDo9Zkb?=
 =?us-ascii?Q?3XgMLxtql8NpF4Ji7sA24VjcClGqIV4u3sB23NFo4ogqU+P2CeTVdEFJHgWn?=
 =?us-ascii?Q?V5+TKb4fOcphHCFH8KDPGpk/g9s52Nqj32MCbSmbDv+Am7cO0InG95JrZAFm?=
 =?us-ascii?Q?5Li9sVdHPZ73JQXo0iHst8HlWTdC56aP4SWo3tgKJosmsiEx316HfflAfhtT?=
 =?us-ascii?Q?uk6JwKjfwF0XX82VtG5wyaeRvQL5nGeVMSlFSolKIkd6XT3SJVoUr2opsmxs?=
 =?us-ascii?Q?XVY+bpDOfib+sGeuYhDro8sjocBs/D5XKsCr/Fv3o5kR1mhLgzckNHZ9r6iM?=
 =?us-ascii?Q?ID75z7xzZLYtUl2yTQp9hcsSL9rKq7Hn5zsK/ueRyqI9ktlibHkGPh3p305r?=
 =?us-ascii?Q?pYx25Dq+Ra7hx3CWFUVtNz4FLyaary/ik6MT7WtZf+k+As5m+UoWVBBvxwbS?=
 =?us-ascii?Q?d4XUHLpYS2IOGn/HFInJFtbpE5cGOppimMF1FPCxsFTmu8nX+wnAw+UcEob9?=
 =?us-ascii?Q?pcfZik0vaDVS0zEj5YXb2GxHtvoJt2jVoUu77CE4yJBx7SxQnrZ4ZjNSYyld?=
 =?us-ascii?Q?zbQjUWrcdvd38+MyFx8IQ6awlMknwG9yVoyDi2kV9VJz5f/tPUS1scqVam9K?=
 =?us-ascii?Q?990BRDoSDrwIrRBh2NEYutAz8KOXQFuB7EkcE9Oo0cgOMgbJP1OInDtj0IMG?=
 =?us-ascii?Q?r9zoBI6zq6VXpgob7nkWpgydJ3vOc02WCewKvH9P219X9ksIP/eC15MiTqrT?=
 =?us-ascii?Q?WNOvSsCTsag6rfkYq7YpXQDcjJZhSDgm9I46crfpT4vkObaeFtqzk4B5YOTI?=
 =?us-ascii?Q?Pj0I5bZcQwm/APBr8V4O0dyKiAZFdvxY69C9IejXgjMmIH7Y86SmuI/wSfmk?=
 =?us-ascii?Q?1oXh6pvqMLLhOV//1IPyqmGcgq9hAVemZV8KFlRtU2RUo7YHtH0enV96vyJH?=
 =?us-ascii?Q?loQmiBYR+68xLcgEaldwxh1k5wJo54mXV0CWK1gro4z9e7STKqxd57Tm7gTJ?=
 =?us-ascii?Q?QTdd6VYQXNjoAskVla+9o2T3p1vvwq7odlZuQ+CjFIT5SKv3Qpu6bqZmWp/U?=
 =?us-ascii?Q?s1Bl66xSUJCkPeLzh3SgvVYM1l8NJNT9g53cxiSu?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93F8584D58D299448FBB2A66E98ECE47@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69fb55a-8553-4331-ba4a-08da01bbb750
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 10:58:17.1286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfhYxkfGsk2gm2MNx3snfOOLmPheyUEagOvWByLPZee4ZvXftsdbxczi7JcgdBuh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2476
X-Proofpoint-ORIG-GUID: cfInI7WNvq5T926n58ghJsiLxPboqEHC
X-Proofpoint-GUID: cfInI7WNvq5T926n58ghJsiLxPboqEHC
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_04,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 11:48:23AM +0100, Greg KH wrote:
> On Wed, Mar 09, 2022 at 10:40:03AM +0000, Jonathan McDowell wrote:
> > (This is an RFC to see if the approach is generally acceptable; unlike
> > the previous driver this exposes the information purely as read-only
> > status information, so userspace can make an informed decision about the
> > system state without having to poke about in /dev/mem. There are still a
> > few extra registers I'm trying to dig up information for before a proper
> > submission.)
> > 
> > This module provides read-only access to the Intel TXT (Trusted
> > Execution Technology) status registers, allowing userspace to determine
> > the status of measured boot and whether the dynamic root of trust for
> > measurement (DRTM) has been fully enabled.
> > 
> > Tools such as txt-stat from tboot
> > <https://sourceforge.net/projects/tboot/ > can make use of this driver to
> > display state rather than relying on access to /dev/mem.
> > 
> > See Documentation/x86/intel_txt.rst for more information about Intel
> > TXT.
> > 
> > Signed-off-by: Jonathan McDowell <noodles@fb.com>
> > ---
> >  arch/x86/include/asm/txt.h             |  34 +++++
> >  drivers/platform/x86/intel/Kconfig     |  14 ++
> >  drivers/platform/x86/intel/Makefile    |   2 +
> >  drivers/platform/x86/intel/txt_sysfs.c | 185 +++++++++++++++++++++++++
> 
> No Documentation/ABI/ entry for your new sysfs entry?  How can we
> evaluate if this is a good api then?

As a read-only export of configuration registers is a full set of info
in Documentation/ABI/ required? I didn't get a feel for how required
that was from the existing files there.

> Wait, I don't see any sysfs code in here, are you sure you sent a viable
> patch?

The export to sysfs is via securityfs, as that seemed to be the
appropriate route (it fits into a similar area as
/sys/kernel/security/integrity/ima/ or /sys/kernel/security/tpm0/,
providing userspace with some visibility of what the kernel thinks the
state is).

J.
