Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE264BE88E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376414AbiBUNnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:43:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359282AbiBUNkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:40:47 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9198220E7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:40:24 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21LABu7Y015433;
        Mon, 21 Feb 2022 05:40:01 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3eby08tfn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 05:40:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b87VP6TZNCQeQioq/YQ/konec8PM9Lfir/eTzE3BzDvCYe+LtpF3a/1U2ErcgEC18XVknvc+HeXyVIGejwRSkHGN7HyZSIltalgG0BNclNk+wWAhUQA86/EXm5MzlYN+ZZv8J0WEV6hbEEd6H8Lz45SC6bWNaC8wgArPEqS8muSS0JxcN6el619zBL9/kH5Mgt9bP+Gd2fi8PIr49KroVxZMZlGamkQfQZ9RGJzkOGYycToiB1Jwmj4J9sLaR7Sh+dPlRtZZcAj0A0RpgMVNoaWGHDIpsLQ4z7gYWjurB9ft3gS9+2mtvfXcfdr9ti5ePh90xkY2ZpZmonBlQ5hOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDBoue/Detsq+VFbp+fu6KDE0NPfvZdgDHBJjA7sBXw=;
 b=cmtwhaZtwxSVxK0LV68yYGj78komZF7EIzaphllCD7GyVQdXEtRT0IZO1svk4RYTjeehbEr07KEmJZpJRCp3vDAHaxsh630EZAOtxEmQ+9CRvXBCukq1/Gp3MuVWaFRvK3E9CDALrHnB7M54hX7q4gQPDf90HahC4dZnI7cj4k5MiBaaFmGbSilyWBa6qHj+r0tUdr10ByOKGWZBWrTFx4yYI5iZP6ehPNzpml04h7RDmUUeoS0vgsdVDKUbj+K7U28ym5y9IfMtnZz4fFGLEGr3Iwjs1oxJurOcEG/0UAxZ7BL78/OFygzIProQvp8rq8DCJxzPKgbakizUu4uElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDBoue/Detsq+VFbp+fu6KDE0NPfvZdgDHBJjA7sBXw=;
 b=uIuFeVCPS+eK3AH6npdyXDqoky+C8okcBJShswsMrvIk7Ok3UxiKRfcUMmODDamwaD9kVVgoyeVhf40Zmh3AhKXVnVhBLdSOyettsIKqk3o8aEPQYFz/YWjmLmeyCL0ZAO047stWrWHfVGAwy1drin/RCLejmiS90tmpgiIgPnU=
Received: from MN2PR18MB3358.namprd18.prod.outlook.com (2603:10b6:208:16a::23)
 by CY4PR18MB1621.namprd18.prod.outlook.com (2603:10b6:903:14b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 13:39:56 +0000
Received: from MN2PR18MB3358.namprd18.prod.outlook.com
 ([fe80::a4f9:5ae9:2889:e100]) by MN2PR18MB3358.namprd18.prod.outlook.com
 ([fe80::a4f9:5ae9:2889:e100%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 13:39:56 +0000
From:   Szymon Balcerak <sbalcerak@marvell.com>
To:     Szymon Balcerak <sbalcerak@marvell.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Wojciech Bartczak <wbartczak@marvell.com>
Subject: Using SCMI driver to prepare data for controlling cores via ACPI CPPC
 (_CPC) and PCCT.
Thread-Topic: Using SCMI driver to prepare data for controlling cores via ACPI
 CPPC (_CPC) and PCCT.
Thread-Index: AdgnKA0Fna8MTaiJR2mk4AEBghp8kg==
Date:   Mon, 21 Feb 2022 13:39:56 +0000
Message-ID: <MN2PR18MB3358B61B4B5777FB35B42733BA3A9@MN2PR18MB3358.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf40fd6b-b44a-4f1a-4102-08d9f53fa5f6
x-ms-traffictypediagnostic: CY4PR18MB1621:EE_
x-microsoft-antispam-prvs: <CY4PR18MB16214D3CA6B1937F31532CF8BA3A9@CY4PR18MB1621.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QTECiINM6PR0yqyV2nMBBrpiR4JEBDeS5wY+YXJQljLLot1YFCJw8RS3E7EDka+JEVoDLQxytyK0YsbNncn1OpTcGcL1YqBtPnr5QuEpMCCZo8ZEWTYnE8kkJCrtND8rI7AQ++EcTdUUaw5cHsvTcSayjyYP4tcMpfWd1bhXjRjNCJqhrFLOzeD7VPwY6+pDaZ0MVjq9DtdYia+NrdF2U9SRgVTsCWdtc3y6szuCjPpwfuSCJ/s7vHv2p97lPIsqf0VO5HD6SFP7VRpwPToiAdApxzpIkn+xbhGSAR8zeihPd0N8WisviYooWXtIpnWYGb4LqJxLiDhzFugOYoRH+ES4XUO70hDs/3nxlEU4Gg9qWVFwZVZMs1b9WTiUWTlNSy5lbk564SMrkAFEOkNQiHsxHypOBdXSTPf5Kweddnlox/y6m37VbLiOo7GV5TnnWYutDRAz8E53qsTXhIxq2oeNCShffPxWVORSsLOLuEIUZTM0M32+3EbwMobu3T8tjWJv6wnQaLalwy+/2h+9zw+GFgVRt0w6sDGMiT3qCBleTnReJvw6DSlgo5MzIf4R08mvgW3ieyUNiN3ZejOgMgdH0HV5osJQsuqFjxB8XcXN6ulpyupaPlYmSbheTcmFcNvt5CVuEpviLBdP55MLLANnbEU4LAfpUMi0bUtz4rvoGcc55xlOKA+TSvoJVJJ+f9LtL49TGGHX3keuu4Am+UgbnhrM6G8TX/o4HUQaghHr2LliZIjkCrHPBrpqKcAPkxH+1JcYHY79CfauUFGkORrVGN37PUm7BPqDvPr5h0DGJW/UF8VzpenBu/wP6KSwsoIC+xOIrJEaY22rFtu6+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3358.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(54906003)(55016003)(86362001)(8676002)(6862004)(4326008)(316002)(33656002)(66946007)(66556008)(66476007)(66446008)(64756008)(122000001)(186003)(26005)(76116006)(71200400001)(83380400001)(107886003)(508600001)(5660300002)(6506007)(7696005)(9686003)(52536014)(2906002)(38070700005)(38100700002)(8936002)(6200100001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/6p0Ed4V8XFjWQ3x87Sz8Ssn0OS14uedSUsqMIYhW5Yvpjjk/1cYsVcBjsSy?=
 =?us-ascii?Q?syudLe4QjH9YHYvTMNJara0jEqvNCXFbugalTK4ZjM9Wd+gayHJR23HA6XAm?=
 =?us-ascii?Q?fy7Z48FtyI+USJ8+7efDFRtaz+MchocolpasbtErtLUvcjJgEmJrr49/WpyM?=
 =?us-ascii?Q?HlpqL16YI4+aISkU6cSK/FzVJDGVEQdHxW+qQvOYzUcnJM3oqegp9au/XpOt?=
 =?us-ascii?Q?L3748UUts1uLEzRCVI4MF3hVIVwohSsC6l84QH6QEqQ8DoX4FbuXx6I+7Yzc?=
 =?us-ascii?Q?6JX8qemqEohixiKAkIhT/cb/wsgjRBTCkaT7SPNysgvTop8Z+STF+Fw6zglK?=
 =?us-ascii?Q?r3tbsiIbPC5w5PZpQXzj62mDqLs99Quvx5VFR4ypoWGa0RWW6gg3jppGZKou?=
 =?us-ascii?Q?F8ZJ82XN5udexXaIwQq2j55WTVdC1vQRG5fztA1N43RAaV1bDQ8pAVXR8fjS?=
 =?us-ascii?Q?Ym8IfXsI+IMnDh+SolBCsr95xisRLOOctQh3wj6RQM/stWJlVt35aO4P+BfK?=
 =?us-ascii?Q?2rb12qitPtXms/+V/TT8h8+/4YEH4IsCnbJ29fioi6lWwQV+YNZCADybQhCN?=
 =?us-ascii?Q?o0NC5WrtVm4AgrSZzpWy017iNQe9NvJDWrZozShugOXDQ1+fJAx6PNnIxnrk?=
 =?us-ascii?Q?rmN38SLtVjnby6gm+N6zb7KmKoiopqlMOJZCQ7kGziOcwZYPdESFdXL0Dj93?=
 =?us-ascii?Q?iwnRK95H4UnTMVIAp3VR+Jy26UJfjgr0rf5rzb01D0QPi1MEmPgoGFvEoRUj?=
 =?us-ascii?Q?wdb6mmnSsfb/19WBuyy7KsneQdhMy989mtOcZwgfG+brDLs1KdKpePzos6Y/?=
 =?us-ascii?Q?OCPqYVMh+E6jVKkkyEG1zEwN4D55HGp8gxERpBdtgziDBqp3jO9IKEElsigg?=
 =?us-ascii?Q?UM6yHCbilQVxAkp2eb/gdZhHJSRGz0LAd2sVnUazHXe7c7CenMQmDyJo1B5u?=
 =?us-ascii?Q?ffwYuXhDJ2/VRwdM8xTjS8X5Q+tIMzeYIctITl0KNk5D2hcdcKyUT8JHtBqg?=
 =?us-ascii?Q?tuTxQVPQAgPk5wgaehgoSSWfUbrl8jX32WXdqHcZubV2xbLPRESJk1HFmoE/?=
 =?us-ascii?Q?6mI/6SvNuo4e4ITWkIOl0nfDYGhEdQx+p4BBFuoM/CB9qnPIqYbnFa9lRHf6?=
 =?us-ascii?Q?rBjhOQvB27zQstF9G3dQBtwBs41PQBntAMoxQUDhYnJwGDsWnGg/kSU/Sz0c?=
 =?us-ascii?Q?Ybu06nUYWKjc1HJJZycv4T+ywpuEB70r+9iWduFZPnL/4cWB7Sr0yj6cvWsM?=
 =?us-ascii?Q?gwTzO78iqVo4RPYJwHNNmlHJsHS/7Vt71+8DHjIuHzUv30EGrJ0tl8Du2XDO?=
 =?us-ascii?Q?Wy8Txu0GHYaUTLxrE3DHKga6ZiVhNgEEshB+82Gfx+ZaTlK7FSx23srxYjNh?=
 =?us-ascii?Q?TFLFylTBWRy/YVwUtnmaOYUM5BnNnot6CwYEWUB42obxYNHy5xLRE7mS/ODB?=
 =?us-ascii?Q?nfwyResStOc9QfUUXcdE6EdbcB90hQIHNWUMPlf1IxgPnQNmaeNiILdvG25h?=
 =?us-ascii?Q?V9aifAR3PLnaPSoPHhV21v1qBalhthrGYrpTwi+WIGv5xSRMuBlAglHH0pgH?=
 =?us-ascii?Q?F3dkglLpz46aYq82IoEv2kd3EzktCUXRreUt7zBiLjjAyVx4jUDMqNO7CqWX?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3358.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf40fd6b-b44a-4f1a-4102-08d9f53fa5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 13:39:56.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfS7ME0hGjPi+QlqFVZr6PQpI4KdL4Y87KYIrD7OgYM1ivxnIlT9ZP1QK2ZVo6tBnXm4l6YwUYljWEgwrqoQCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1621
X-Proofpoint-GUID: 8LUafhXSnKTw30pjIYiluWzkkk2L_XvM
X-Proofpoint-ORIG-GUID: 8LUafhXSnKTw30pjIYiluWzkkk2L_XvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_07,2022-02-21_01,2021-12-02_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

This is a continuation of previously discussed topics:
1. "Mixing SCMI and ACPI" topic discussed here https://lore.kernel.org/linu=
x-arm-kernel/20220207101024.rpcbbhtd6y6g7ykc@bogus/T/
2. "ACPI support for System Control and Management Interface (SCMI)" discus=
sed here https://www.spinics.net/lists/arm-kernel/msg798464.html.

We did further research in regards to ACPI specification, SCMI specificatio=
n and ARM requirements.
Considering above, in ACPI we defined PCCT table together with PCC subspace=
 type 3, according to SCMI specification ("The SCMI transport is represente=
d as a standard ACPI Platform Communications Channel (PCC) of Type 3").
This PCCT table describes "mailbox" between System Control Processor (SCP) =
and the Application Processors (AP) on our system (i.e. shared memory area,=
 doorbell register, etc.).
As a result PCC kernel driver (drivers/mailbox/pcc.c) was able to gather al=
l required information out of ACPI PCCT table and thus was successfully pro=
bed.

We also defined some sample ACPI _CPC objects for each processor core, so t=
hat CPPC kernel driver (drivers/cpufreq/cppc_cpufreq.c) could use those inf=
ormation.
Within _CPC object we added specific registers offsets of PCC subspace defi=
ned in PCCT (ONLY example: ResourceTemplate(){Register(PCC, 32, 0, 0x124, 0=
) -> Desired Performance Register})

Having above setup, execution flow for getting desired core performance (dr=
ivers/cpufreq/cppc_cpufreq.c -> cppc_get_desired_perf()) would look like:
1. ring the doorbell register (defined in PCCT)
2. wait for command completion indicated within PCC status field (status is=
 part of shared memory defined within PCCT);
3. read the desired performance register (defined in _CPC object as specifi=
c PCC register).
=20
Now comes the problem: without preparing valid frame according to SCMI spec=
 we will not get any valid response from SCP, even if we will ring a doorbe=
ll.
Considering above, we came to conclusion that existing SCMI kernel driver (=
drivers/cpufreq/scmi-cpufreq.c) could be used to "prepare" valid SCMI frame=
 and write it to shared memory before ringing the doorbell.
This way SCP could "understand" SCPI request (e.g. get desired performance)=
 and return valid data back within shared memory (within specific offset of=
 PCC subspace).
Do you think it might be a good direction to achieve the goal (monitoring a=
nd controlling cores)?

Main problem we currently see is that SCMI kernel driver will never be prob=
ed on ACPI systems as first of all arm_scmi (.compatible =3D "arm,scmi") wi=
ll never be probed successfully. There is no DT on ACPI system at all.
Do you plan to add ACPI support for arm-scmi, so that it's properly probed =
on ACPI systems and thus scmi-cpufreq is also probed?

Finally, assuming arm-scmi  and scmi-cpufreq are probed: how could we accom=
plish preparing SCMI frame before ringing a doorbell?

Thanks,
Szymon

