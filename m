Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5D6591289
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiHLO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiHLO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:56:26 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021021.outbound.protection.outlook.com [52.101.57.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6135901AA
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVw5/HJD8uew8LR37K6mwSQH5qOu3iQn3Jb27G1p9TKlu+mTISud6KkPcp0AIXwATxEn8tJylgcqvd9M593L8op0T3Dve6vnOkAhvTjsRvkdxV70FqnPqX/oAvaLvk/EofnDHytH2SiR4an99kwOVFekXuYtO+HXch1zAKRTc6rIzq5fxxyKtoTru92/eO8s35eV25eltR3KBhb5D8McdoNn9XHoaHVbd1Ejl3yaDv29sNs0VTvytFlhCrmf3dU8pSWo5rZdjsGZm5I0Cofq9UOcv/lJmYAJKUo88Iu7ELg9cDzHEBeZ3sjGALQX8QkrZ1t2qyuvLji+xFiRXuOR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL+HMaiRSAXnrrhQOgb9Z09Y4ROKplhiRtwU19G3Wds=;
 b=S9FVWoqSpsWZ7LsIjbdGMaJ9Q7CM8g1p95BWRKPI2FtZmjJ9LjNxI0fuqBt6dZ59AroX9SQTvvX66iIKRomqmhmRKk0Yw2tg+t+FG3NsE0tsjbwAsHvVFKl+h8KqJ1GWzsIpC/oNPVyhloiCaYlurou2U2wS+KKpRmeyC6MiBRnlmB7AoAnbsIXh54lO1Df6IUl1rrgO8CdQjyJA/Tr2ugAVaYzBG5P1dL0wQKQAloTlc3rfrd34Y9H6910fZ8mYY4cCr5hphRGY9Fc1+e4VnM1Xdr+mmBH8Eh/+PEduJa+hENyIAFER8uSt7j4zuMiBc47TqbWMKb9mGMgB4Mw8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL+HMaiRSAXnrrhQOgb9Z09Y4ROKplhiRtwU19G3Wds=;
 b=STa7sJuYb02/rFUVkr8vpptXLTnSOlAEWxtPHuDb9EbSko1PUoyHuHeKUA6TKUH5gOudFaJnYUGNwcck/SgruhNq5RmadhW+6YsKFxlgtF6ESRi7/EsxwLjvB1VsgjCpuXMG+Gid3Nl0RYksy1B336sJZEf528OsybiVwfBixXo=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MN0PR21MB3051.namprd21.prod.outlook.com (2603:10b6:208:373::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.5; Fri, 12 Aug
 2022 14:56:22 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::1932:f857:15ab:136c]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::1932:f857:15ab:136c%6]) with mapi id 15.20.5546.005; Fri, 12 Aug 2022
 14:56:21 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "will@kernel.org" <will@kernel.org>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/cacheinfo: Don't use cpu_llc_shared_map for
 !CONFIG_SMP
Thread-Topic: [PATCH] x86/cacheinfo: Don't use cpu_llc_shared_map for
 !CONFIG_SMP
Thread-Index: AQHYrNRnTGhWHsyWF0iBbdPnq/b6B62rXYYQ
Date:   Fri, 12 Aug 2022 14:56:21 +0000
Message-ID: <PH0PR21MB302554AAF6772779B8E2ED35D7679@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1660148115-302-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1660148115-302-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0c08c440-a6e3-4db3-82e7-2648965a70bf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-12T14:55:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a65a07c5-acc0-4752-d4d1-08da7c72d216
x-ms-traffictypediagnostic: MN0PR21MB3051:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GtkOXbeWgA+4QL2Cjn7ACmwhEgbjVt012F45OU0RsBbqdcJmNDZzv2O3X60w3z1fd9UjlEchJrBm21ekJRnLUFWxOZJUZb9s+SjbuiikJsqArVXyALq2gWkBrz5MimePrnpYzXgP/bCrssgsMO7yOGc9XhB/gDV2NF0UZz16mwGzZmf1XElkXMxAguEc0XERrLAJ/4RqsqxBsUyOqKsAHKtjblJcg2STc5nPzagXpZjtpuQgVBJxOZ4JurQina7I30P1TcrtpUCKnlNkb//4Vetl/ER71RjFMLLQzcHhHsoo3S/YGa6uoVKbVyDquZXM1Tu3AFteXo/r4TG1D9GJ8fKtjvT97NyYh02ietDe7OI3s+KsrjzPKd+3iIQemmwPndFiyqVfkUfy0KYvb5TcofuuYa8ZlA232emRHlS9AXPPFV0oIH3uKReuV/rbeUBEP+Wlz6c3LSMjHBaHkaOSihlyylg7Szb2SSEEOJE1KwVIAHkYJbg+fSg/TNWsxwv6NFrcLiuqCaIZO9zrzVjRJ6saRQHlHI+LVt+6FCF4fnKbH3uyK8h5TJXCosX9XkjJrXpDjKWl5SPqJ745WdexNn3NyqOjzKtgW9FZGbKGYcobfZEQYU72lFZZZOhzI7D2xmiIyhc62shFjK7LRdM9kktmOt5qnQZsoJ5D2SdZ4+VYGyqoLDddhmCyb0mL4kulONzqD3anU2kMjlBWVXUVROtsWu6iGioD7gVE+KbWKdpeLR7Dfp97GuRSyX5rBSGzozesQuW8T/qu4CaNUlVLoKDiEmB/Yutqj4NiJ8pecB2B/bp3FY+WgUueXOEBbng6+mq4XOqjYA4xf7GMLXFz75O0ekNoutKgN6Ntwc8ZqdVaB0BejdAPOsNGSf8hnle1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199009)(10290500003)(110136005)(41300700001)(8990500004)(38100700002)(478600001)(921005)(122000001)(66446008)(66476007)(66556008)(66946007)(76116006)(8676002)(52536014)(8936002)(7416002)(5660300002)(316002)(33656002)(2906002)(86362001)(55016003)(38070700005)(7696005)(9686003)(6506007)(26005)(83380400001)(82950400001)(82960400001)(71200400001)(186003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NmPbTjrE5oC2H69Gyonbn7qjeUez1RNQ69GoZOK0DalDqByCOEJre3A6Ni+a?=
 =?us-ascii?Q?W3MmwFt75oxRY8VUZbfMH7VKjOD9gd3S1HPjbyxisqbvDT9FstYmX+9xv3tv?=
 =?us-ascii?Q?GQPxuyAWkkEV/ej5O2bYm+R4jhEJH6YnBGhQZn8QfhE32G8OCDZgC+bxPMsA?=
 =?us-ascii?Q?NdGqviI1MIIaLg71s/8d0j7lASyXN40zn+NAlWvLIfLB5K0ozQejbi8BElUu?=
 =?us-ascii?Q?djMkC1sdqaRhv4qgwPziJGTkcH/dN1DF/xOq08U1X3HrGHiZBTieJGC7A98d?=
 =?us-ascii?Q?03HXRdHqBTekp+w9Q5/WJM6BrOPX2Q449/8qN3e9iV1w6RGvpgAmsS1ICwrH?=
 =?us-ascii?Q?NoPAvJmkPAoAq8K0ftCW8zAN5lUKKsqgH6WlV90fRL7QYNOtZ8lz1rNRgN1M?=
 =?us-ascii?Q?LTPkzuDj+5xGMQoLxS27hqQMXzUb0sweVwzaaKwUelkwURn4FiHTFUzptnfU?=
 =?us-ascii?Q?lnj/3MB4QuihH0SZKA+pj+WEmEYGOvB4mZl+x8qnrydnyBconNB41r7QKTIg?=
 =?us-ascii?Q?uXoKUjEB23b6hrdAnDuyGhobvZwMb8hf1o7jxX0dGnxpxw7m8r6aq3SjlGTX?=
 =?us-ascii?Q?BlYo4RaQEc30WFsGLURg3+nZInFqTEUwPNMWT+01026odQAnLorCn88Dq1lU?=
 =?us-ascii?Q?4kW6nlip8YNdSbfOeTVljvTsaIMQSFriRA9/5XF9eRgev6iNFB2rasi1WWIT?=
 =?us-ascii?Q?NaqhVbql9f1dMTgjUryoCzwQfdQbtxlvrQtQ0Bb8HA6KyBQNSUNvNeEs8udY?=
 =?us-ascii?Q?i3modpefFDkKpiOpgPtUnLH4RobNFs/jdtr9h504VKmONfaAQgyeVt0rlWBB?=
 =?us-ascii?Q?HBH/Hwoh+XCZ9hC5lvM1hVSNSw1j0Dlm182m4Vb/sT0Mb9QBoECxAEOZuaNT?=
 =?us-ascii?Q?V8Aa24rGn4G+bquL+HlFMtVw8zQj2HqbYHWLWrYbXhWfYK05j1NACwdBa6kf?=
 =?us-ascii?Q?H8lbcVJetZG36T1hBU1Epixi5Zn1PpkBj7RhRmHkcqZ6wkTR2BAb3EU2ii0d?=
 =?us-ascii?Q?MlTCwksRTtUIjlLVvjpmmJSl3FT14ymvhATMtG4yjTUFCP/vu+blzL+0z9LI?=
 =?us-ascii?Q?yg6P9htYn/RRADfe1gf7HlL0qB0zQ4bM5YJ4oOl65H3lcn+loxf0mMLNQ8Rc?=
 =?us-ascii?Q?Qmx/ZsbDZ7iRgvGQgaPYxVjBuowcPn0NRyH3f+al11+UJhZ43XaklKRcNcjy?=
 =?us-ascii?Q?+mcfweukKD018Vf75rEoI6K8H17qrYiE3mT1z7DjDpZ2LoYG4tjvKA2Ki/Cc?=
 =?us-ascii?Q?e/2y6q27vMLHYen/h4xI+Xlk9zTmSeTnLXi8AnnqrfA4O4L59lnOHCihSFeP?=
 =?us-ascii?Q?KdlHfMFZW+EEmOtVhuibm0Wdb3loJSHABT4OW37zAruorfrxgBzc56q4v/uj?=
 =?us-ascii?Q?PzBMHbnWP4ALKpdEZEN511Uk3g4nnmAtCfUEZaYOnp53ChIni6hM+Ej8b/3W?=
 =?us-ascii?Q?dxF1VIhuoooSAMgZGpPiFoY1OckBxn60kksZV7yDUB8SszwgpUD8Id+BnFkp?=
 =?us-ascii?Q?uDBrEjCJ7VlWGkdUPA/ToJ91PjNGK2pxLBqfNSjV8SQYYJH/tMTjgMWMQAhZ?=
 =?us-ascii?Q?x1epbgf+Iubw7EJL3dnWcotzY9WVfORAdG/ZFyChD3aCrs30Wgv4BvufnsZ+?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3051
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Wednesday, August =
10, 2022 9:15 AM
>=20
> cpu_llc_shared_map is always declared and defined, but populated in
> arch/x86/kernel/smpboot.c which only builds for CONFIG_SMP=3Dy. For
> UniProcessor builds this mask is never populated and hence invalid.
> Current code doesn't handle the case of AMD UniProcessor correctly,
> which results "shared_cpu_map" and "shared_cpu_list" files missing from
> sysfs entries for l3 cache. This patch fixes this issue.
> This code used to work because of a another bug in 'cpumask_next',
> where in the CONFIG_SMP=3Dn case the cpumask_next() ignores empty mask
> that results as if CPU 0 was set. This bug in 'cpumask_next' was fixed by
> following commit, which exposes the cpu_llc_shared_map bug.
>=20
> b81dce77ced ("cpumask: Fix invalid uniprocessor mask assumption")
>=20
> Fixes: 2b83809a5e ("x86/cpu/amd: Derive L3 shared_cpu_map from
> cpu_llc_shared_mask")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/cacheinfo.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cachei=
nfo.c
> index 66556833d7af..8753bf33fec4 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -889,10 +889,12 @@ static int __cache_amd_cpumap_setup(unsigned int cp=
u, int
> index,
>  	int i, sibling;
>=20
>  	/*
> -	 * For L3, always use the pre-calculated cpu_llc_shared_mask
> -	 * to derive shared_cpu_map.
> +	 * For L3, in case of SMP systems use the pre-calculated
> +	 * cpu_llc_shared_mask to derive shared_cpu_map. In case
> +	 * of UP simply set the only cpu in mask.
>  	 */
>  	if (index =3D=3D 3) {
> +#ifdef CONFIG_SMP
>  		for_each_cpu(i, cpu_llc_shared_mask(cpu)) {
>  			this_cpu_ci =3D get_cpu_cacheinfo(i);
>  			if (!this_cpu_ci->info_list)
> @@ -905,6 +907,14 @@ static int __cache_amd_cpumap_setup(unsigned int cpu=
, int
> index,
>  						&this_leaf->shared_cpu_map);
>  			}
>  		}
> +#else
> +		this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> +		WARN_ON(!this_cpu_ci->info_list);
> +		if (!this_cpu_ci->info_list)
> +			return 0;
> +		this_leaf =3D this_cpu_ci->info_list + index;
> +		cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
> +#endif
>  	} else if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
>  		unsigned int apicid, nshared, first, last;
>=20
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

