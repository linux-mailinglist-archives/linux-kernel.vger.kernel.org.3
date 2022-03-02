Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07B44CA164
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiCBJyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiCBJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:53:59 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD6EC69;
        Wed,  2 Mar 2022 01:53:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxGnsk67pVCV/Byti8tQocgMoL5vEmWlvK8uAcy+7WfGZj4uyshVTYNzR3BoiW/M+CHBPeFFLFOyvppJrGHoug5yUl4v7n59f5YMeTTLJedUuVQd6x56CeOay+TUClP8Fe/mVTGQN2uG9BFPdYDolv9mceF6JCVObAlI+QocJHnnqv6/bGzZv0b4nBj8g3oxANmyp4ar4tjEPdgO2ArRHHxqmvVVCnkoq6M9DYXFThZB0izWRYlQ3ObhHsCC/iBNeWpMi4hD2Xe7RhWTySwC88CJ8d1h+iHkcZVIwXZ32q0NUI+E8QtcUzl4A71ixJPXRjQokCV/i+RpTdVTKkaPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8BMCqh0JtY44h0eDsrYzNnE5PHg6CPZNcavkAxb+hE=;
 b=Nj+vIQzpchcgTnJkBiyGis82whg5tjmm2Ixh3za7RCmMNeWFi0yTb++JgcqnX2MJM8hs1Byol9Pf/miYZ3xRazIriADrtnh2TYXWA7K5QSbey1e111jmBDBUGswZJyvp3PV/2cWQAnxgySE7X4zJ0BcTvQiT1Br9PepB9HSE6QLpGvYB120v/a8HlZvHgocbmDNkjuWuVMSiCYcIbMVXXnfrGDn11/RkM02VHX/ynyWQIPdXTpKcdAWgHGyDM6W6vlWBGtIzQnpSE4KjCxT/S+sCGO9trrluqYFsmyO3f9S6EDpXYumkakeuCN3GTDHAU/vhpL3c6ioqXfXT2A0cqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8BMCqh0JtY44h0eDsrYzNnE5PHg6CPZNcavkAxb+hE=;
 b=BN1xbmuZ49Qu6bumOHtS1v7DpBIERZuk6frGPmkU91KMzBdcwxFQ4CJQXIAHi3LVNAyd46oL08WwVuIJu96gazkMkWK4CVW2jglmIf7ywejTBy/qaENKPlmrP7Wa31fWJrgawJ2wSLNr8LQj5Lb3/7iDzzr/MzJ+JN7uAWuTE6k=
Received: from MWHPR1201MB2494.namprd12.prod.outlook.com
 (2603:10b6:300:de::20) by BN8PR12MB3619.namprd12.prod.outlook.com
 (2603:10b6:408:46::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Wed, 2 Mar
 2022 09:53:12 +0000
Received: from MWHPR1201MB2494.namprd12.prod.outlook.com
 ([fe80::70b9:2de3:ba4b:c4e6]) by MWHPR1201MB2494.namprd12.prod.outlook.com
 ([fe80::70b9:2de3:ba4b:c4e6%12]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 09:53:12 +0000
From:   "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: RE: [PATCH 1/3] cpufreq: amd-pstate: Add more tracepoint for AMD
 P-State module
Thread-Topic: [PATCH 1/3] cpufreq: amd-pstate: Add more tracepoint for AMD
 P-State module
Thread-Index: AQHYKJy3VZjJs4yYZkKXFUbpgtLvC6yqsCkAgAAK7wCAAACogIABHV2AgAAMITA=
Date:   Wed, 2 Mar 2022 09:53:12 +0000
Message-ID: <MWHPR1201MB24943F2D2F382D13B5447D9890039@MWHPR1201MB2494.namprd12.prod.outlook.com>
References: <20220223100350.3523826-1-Jinzhou.Su@amd.com>
 <20220223100350.3523826-2-Jinzhou.Su@amd.com>
 <CAJZ5v0iaY3tsNKFXv09Z4wg_2R3+9UsSnqfPBbOYFaqoVS1qCg@mail.gmail.com>
 <BL1PR12MB51447B1235E91A81309190B2F7029@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CAJZ5v0jDbNVEtRiaiUXembZB2r4uxVy3iKO0aTqOJsB0rLpV=A@mail.gmail.com>
 <Yh80MwmHqAXK+PbD@amd.com>
In-Reply-To: <Yh80MwmHqAXK+PbD@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1bd3cd97-581d-4c8c-bc5b-cf19b1940847;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP
 2.0;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-02T09:52:31Z;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 162b129a-b719-4321-f4f7-08d9fc32772d
x-ms-traffictypediagnostic: BN8PR12MB3619:EE_
x-microsoft-antispam-prvs: <BN8PR12MB36199E1FD82578343CC943A290039@BN8PR12MB3619.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9aHyeixD4Z9v608IDEQu8PvGWv6w5uhWUQhmdY6IM3LCfjhr13Uv4LttI8pQGgTO77kbpuKqdWtr6usArtuDVVk+BT6hpqs2w8kfoTfHO7rDN1w/3wMJwKxJX8heDhxWPftFIgXsEt14mQZmQMyYne2Ud4uGqq3w0BLrv4IHo94I/C0L/VA2K3RuxxXMGpiyPF1QNl5NM58csv12uJoVGwo/BPM4iNFFUgdiAdEP6Jq+8wdjAvV9SGqf2HZqcbEKywcmBBaa3PjmPbeydLUCKLm0l34jGDRSfworL3a/A/l23GjjHSt4EqRyIcFkvUPjgHI8P7A136eOFW0lu+CnouMUIQ775oZCLLrdetFoQJiYEpKvMAZ/mkPhbRz76yX1knaaEcbdueSAZsh23+e/rrMYLxgNXVigPAAQcigOL1RgkaAWnhfBlZZGRV+FOdFnQUpj2jn+ynYPFRtusCBxCJRGFKC1v4rFqKevb3U9471zwgGQJu7r/FEpNSRpMOEkN/cLC3pKq2DCi1cRCakaSwg9vNc8nf/ijIwuVeBIIO6RkbpP54mefVsJmNUKE0HUtMlvwxK0M0dTmWI/oowC9TfP45P3gqp6OWO9QjYWReDboI3sDIBlPi56h1YY5ux8UyhjOiEqRQFiLE655tdmyOHeS12GwXNJ8Fr+aU5+pfkmyHQD7pAepbOrM/+Wwz7jseZuiYlYC9ZrytTCh1t9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(7696005)(9686003)(55016003)(6506007)(122000001)(53546011)(83380400001)(33656002)(186003)(26005)(52536014)(508600001)(4326008)(54906003)(110136005)(316002)(86362001)(8936002)(76116006)(8676002)(66446008)(66946007)(66556008)(66476007)(64756008)(71200400001)(38070700005)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ms1VR/TicIg86T3HjNs6+Uq2z2msRR2kjOpRw+ZggecABBcKGdmCjWk+rPGH?=
 =?us-ascii?Q?tyo48LaATYMWrmO7Fjv4E1VxqIaEszXQTc0ITMlHLRok+TuyibHiKvOvENpD?=
 =?us-ascii?Q?SvsEuWltWlUz/1gtBeTfJCurlh45vZhqlqus9JKfi0q2xl1ClMz/HtjH/WAu?=
 =?us-ascii?Q?N0QGzBzmmw1smr6UIVaanrmwCTTPVQ32ljlC4lcBDZ0YOMOfhYk2Ut+D6XMP?=
 =?us-ascii?Q?JNn5Rf+geUXavEnimvIY5yhwnrOu+e5zFz92zevlXR8YGdDn9eT+Bv8GGg66?=
 =?us-ascii?Q?yonFXRXBR72sFaTWOTxJSxKRwI4nWlIOhZJnetzMM5pDzeVW2L9Ke3Wa1lQ9?=
 =?us-ascii?Q?vqaoRqs0carPgP7ucljj7LApMw+esYS23gcXtQi3AdStoBd2pBjLum46uBDE?=
 =?us-ascii?Q?2yKevkxV6s/bsVSRajssKx81+Shxjd0XVEpDSiFlz8lShfITDA/6I4PQLeNS?=
 =?us-ascii?Q?EJtpwBTRPbK2Fq1YoxKtG09PSQvWkdQ9eOXiKsmOMCeymBCMZgl85xn5HsJ0?=
 =?us-ascii?Q?8Aw5iKUf1Kr+xPCNBvQXEPgmEaoe3lHEZ6hn80FSPgvEwR9q0g5+YX8OHXlI?=
 =?us-ascii?Q?dXxX9LjYHpkNA72pwJWac+ZRUpHbeAKTS+MLdhu+ubLqUCnvGEOjvLZ9CqNP?=
 =?us-ascii?Q?SS2lGbaNMHHxjCYWbAgUk1ImsKH4L7z1jF9SB8mjgCgeDrZ0IoelMK1ABioT?=
 =?us-ascii?Q?MIgr3vGdzXmmiIF4PO6BniMLvHULNarJQymT41tfn6MwYqxkFl6C+vwVrT0n?=
 =?us-ascii?Q?7TCFu2XhZ6TNWQs4DMU5WyzT2uWdt+1rebHa2n9TFwVM2XH0VX0HCuUrQWp3?=
 =?us-ascii?Q?cQOdWs+Mc9FXt7IY6lEjxLAQ2IUssU/8DzdFCy7o8dcvfIQjlJVuZ2oJwtmt?=
 =?us-ascii?Q?ZaqNFb57q1PqfrcddCK3lvmq8Rspw2mrtR4UsWyBwViNxDrkubnlq73E38kV?=
 =?us-ascii?Q?YlERwDhmYR2336WuHi7xN3rtnOrXJn3xxdb6bxl1/eOuJMZK0qEvMs4/VCse?=
 =?us-ascii?Q?wHHXLSX/bmIeP4qEzwAsKS3PghrNda+yZF1634X8gNDpDPB/eH26XmnFisDf?=
 =?us-ascii?Q?72RPg8G0zIfVCXIGa+outXrX5F/yFJ6M+fuQUqYZc1o5b+Kps1O/mj+2LmZ0?=
 =?us-ascii?Q?zF7LvR+6+W37P8Rv7+i5KVp3dVzBqGdxSN37HbHGWvBr5J0tGECn0FrAT5W8?=
 =?us-ascii?Q?TZ6AfIIH1aKDAhJnhvWzrQjkk/tKAXkiapGvvMNwgUmxIKKeiQ/CunlnBkI6?=
 =?us-ascii?Q?PPcybxkq9MZa5+wNecWuCvPceYiuXDVhu5G72AXwt3/Y1AL+87jeY5VnkOtW?=
 =?us-ascii?Q?fRYvn/HSYCzaBwu0q3xvo5q9I3aHjmmqmt7Oh1oLWc2fSoapj8FLYb3V6OAf?=
 =?us-ascii?Q?8fjRbIrYrFLLs/+UNfIj+KHNpqGYZN8Q2CGmXeDLYVFlqtC2HCRAKuE0i0Bx?=
 =?us-ascii?Q?0F/2oCdoBzE2Jsltum+XEzOOGHstZuJ8ufyLGQi4JSsQm4GJV7cMR0pM7rSD?=
 =?us-ascii?Q?CHfoJlCs4qrlsNkkG8s6Ow9LpS2keXkubhdQEFDjjBdWBdKT5oO8LTb9UNaM?=
 =?us-ascii?Q?G4/NHvdQLq2gMiT28JXMZdPDiQE9n8ZHdKEw/I5bNVpjBTFEO76xCeBUzY7V?=
 =?us-ascii?Q?NwOBZ4YeiX8zEqziu/7ys/4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162b129a-b719-4321-f4f7-08d9fc32772d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 09:53:12.5982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LxR3qp3I83t7mrQLbRfEjM/3GkugBinOmE9PN3wgtIIE71VZgX/m9OCO5En5z/ULRaVb90CRpiohHwuFK4VBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3619
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

Comment in line.

Regards,
Joe

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Wednesday, March 2, 2022 5:09 PM
> To: Rafael J. Wysocki <rafael@kernel.org>; Su, Jinzhou (Joe)
> <Jinzhou.Su@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; Linux PM <linux-pm@vger.kernel.org>; Srinivas
> Pandruvada <srinivas.pandruvada@linux.intel.com>; Doug Smythies
> <dsmythies@telus.net>; Viresh Kumar <viresh.kumar@linaro.org>; Todd
> Brandt <todd.e.brandt@linux.intel.com>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Sharma, Deepak <Deepak.Sharma@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>;
> Meng, Li (Jassmine) <Li.Meng@amd.com>
> Subject: Re: [PATCH 1/3] cpufreq: amd-pstate: Add more tracepoint for AMD=
 P-
> State module
>
> On Wed, Mar 02, 2022 at 12:07:45AM +0800, Rafael J. Wysocki wrote:
> > On Tue, Mar 1, 2022 at 5:05 PM Deucher, Alexander
> > <Alexander.Deucher@amd.com> wrote:
> > >
> > > [AMD Official Use Only]
> > >
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > Sent: Tuesday, March 1, 2022 10:26 AM
> > > > To: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
> > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Linux PM <linux-
> > > > pm@vger.kernel.org>; Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com>; Doug Smythies
> > > > <dsmythies@telus.net>; Huang, Ray <Ray.Huang@amd.com>; Viresh
> > > > Kumar <viresh.kumar@linaro.org>; Todd Brandt
> > > > <todd.e.brandt@linux.intel.com>; Linux Kernel Mailing List
> > > > <linux-kernel@vger.kernel.org>; Sharma, Deepak
> > > > <Deepak.Sharma@amd.com>; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> > > > Yuan, Perry <Perry.Yuan@amd.com>; Meng, Li (Jassmine)
> > > > <Li.Meng@amd.com>
> > > > Subject: Re: [PATCH 1/3] cpufreq: amd-pstate: Add more tracepoint
> > > > for AMD P-State module
> > > >
> > > > On Wed, Feb 23, 2022 at 11:04 AM Jinzhou Su <Jinzhou.Su@amd.com>
> > > > wrote:
> > > > >
> > > > > Add frequency, mperf, aperf and tsc in the trace. This can be
> > > > > used to debug and tune the performance of AMD P-state driver.
> > > > >
> > > > > Use the time difference between amd_pstate_update to calculate
> > > > > CPU frequency. There could be sleep in arch_freq_get_on_cpu, so
> > > > > do not use it here.
> > > > >
> > > > > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > > > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > >
> > > > I'm not sure what the second sign-off is for.
> > > >
> > > > If this is a maintainer's sign-off, it should be added by the
> > > > maintainer himself and you should not add it when submitting the pa=
tch.
> > >
> > > Both developers co-worked on the patch.  Isn't that pretty standard w=
hen
> you rework someone else's patch?
> >
> > It is, but that's when Co-developed-by should be used.  Otherwise the
> > meaning of the second s-o-b is unclear.
>
> Yes.
>
> Joe, can you add below in next V2:
>
> Co-developed-by: Huang Rui <ray.huang@amd.com>
>
> Patch looks good for me, could you please add new patch to describe how t=
o
> use the tracer script in Documentation/admin-guide/pm/amd-pstate.rst?

Ok, will do that later.

Joe
>
> Thanks,
> Ray
