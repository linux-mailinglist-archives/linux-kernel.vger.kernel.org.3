Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9016513B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350775AbiD1SPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350741AbiD1SPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:15:05 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76286B6E52;
        Thu, 28 Apr 2022 11:11:48 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SHwfTr012372;
        Thu, 28 Apr 2022 11:11:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=PPS06212021;
 bh=DBdrXFnsXOv0V1aQnUpN06EPk+g/r2L9QPiIJssBJaA=;
 b=ltmBBLzpLXqWSa9fP6NiKnds/U2919rUCh/rl9aWM8PTtXlSPiUvKvbEK+KNE6VoNqxb
 ns9zWzJ6an5bjNa62dd8Gs6sQBgFU8NSHCsGiNObC7ckK4RfjjKTy43PQOXDtNUmFfAK
 ZX7Lk54KHF/oBJyA6Gtc62nI2wIogRfvv7D139g68mOav1qUPvucyBQUeI2GI67crs0n
 K7zgDOhitXSPh92pKhC/F7eQwWfOFUOMmSKaYOy+61NjuRjJlGhSY13k1hDmP5l+vThb
 pM9ZgDUsObQHy12ZIaoacBqXU2oJiI8kvpDdP1PkujL1NuaYi4ZE1OiN71Z/X7HbH2Rd mQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fpshjskkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 11:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQTCWkarvcFJcq20NWf3zrQjHCA8QT5voqYeCQdPOuLf+Cqnkgyox3ybetDfQMiPmuqISB1wikpaCFoKyZvFA3mk45yrOr0eYMmq6LHN4GAkUFogoK+4QnlAAUs3AAkqQBvoDYhOwbgQd2mmMiYyGth8ILCuau8Z5oAVC/ge8ntlElkipVqL0+5M82PJ/fg3VOypktjjpzXIQpL2DgL4vbsCksO+nYV2Y4XFAMlgwTSeUV1a4+YbzYq4y1KZTtWtxE0k5fhsM2aFV1tykrOpoL0jhVVEzI2z5MG/0dLa9cdLYIrNjL9ySmGFgzVy0GJIt9EwBs+oLhIuzFbYx4NvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBdrXFnsXOv0V1aQnUpN06EPk+g/r2L9QPiIJssBJaA=;
 b=LeY1fgAobXhpg1EUvRGopnI/J7uwFQpOBYq8gLjWpQJiaHVm/PDcOQCxVZguErob+kTcf7zD7GM+1v99LsZpNZmQduOx3Gl+2ASt1yC9LNzJWFaZZmVUgQIPriLHfKMlkEv1nxb7R0U4AllcX4j1D0tG115AyUEDQHt53THfBHpnOBoZxkbmYeSXA7wF2qTO2L1Y38TaA46xbLyZAaU4Gk0v2qhtepPuRQijJm8viBmaUH1AZX9IS30mmMRlqG0989wFpn1xkNgkLfXlgo+r+/R5wG0dBr8JxuuHVTjRl5wXTpgUZHL4Qk8314AePwIydwOVOJeVWfN2vjDGNDt7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BYAPR11MB3176.namprd11.prod.outlook.com (2603:10b6:a03:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 18:11:37 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%5]) with mapi id 15.20.5186.023; Thu, 28 Apr 2022
 18:11:37 +0000
Date:   Thu, 28 Apr 2022 14:11:31 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/4] platform: allow ATOM PMC code to be optional
Message-ID: <20220428181131.GG12977@windriver.com>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
 <YmpoeJtFNSyCq1QL@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmpoeJtFNSyCq1QL@smile.fi.intel.com>
X-ClientProxiedBy: SJ0PR03CA0367.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::12) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87a84d47-81af-4953-44cf-08da294288dc
X-MS-TrafficTypeDiagnostic: BYAPR11MB3176:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB3176928E4A6690442143667F83FD9@BYAPR11MB3176.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5erQ2DWu/B2Oij14zFOWTiqOr2lhCpbg+gjWoQgFpGIA+uCoSxu3hTWj/iPFch7ZD6cJ1A1ftvv94GFpCN8r+FyeUMiqppdCoDPxl4sr9KEJQ6xZbpqwj8QMt8AHPrY/1WQvwviMcu2e6HjL3ZLu1ad8/IkXPTab+nTtoc2azYXgJRIzjxfyPDnA7AjVhPko968zh+TqUYJ/KKmPVXBiWpN78tbO2V3QR09JqENm2Y/zZ5gp4T5Ug9FyQnQky1kW9QszOpjlGHpkS6wTVY14wp81kZyh1XFerUYXUzTvpKP0RGLetsHmtK2pXTZpNX8gi9yDN11UgZY2ufsGGwNByU7DxFheTDrAGcJeethP4MgxaVm8LdfLxpFgGnYyGXAzJrdVs4uXz+AVtarneKpLWYMLirVo87/kxmVfML51qn6v3y+ZTSGsgp4qP19qd0o/6GpCdiGmvnAfryMGlRLrIxLT56S/b/TTN0/eplzvNqkATAylorvv+No/s+sYaWtQfWc+sUFMhIUL21m58J6+sxS13UtxPBVDCwH0yHc+PYtFTsXG2EPPBRPRpl8JjJJy8QypJ83kQ5pNc2g+wv43KhC51O4l0+nZcAfzJoDqmxuQbJtqYW8mUL0ncVz1QqJVh2Pwowv6qC8xxpDIT3fbZ8pmH/ORraREOHF0qDKjssbODpabUR+V1eDYXXu7N4J/bm5JJuUhcCYX7BkMEREstoE+S/STSqMRGffHszsIdsQMIFnI+CXiTPhBANgY7vu3fGvEBprsVMwbU5DasW0Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(54906003)(5660300002)(26005)(6666004)(6512007)(6916009)(52116002)(38100700002)(6506007)(316002)(508600001)(86362001)(38350700002)(66556008)(6486002)(966005)(66476007)(4326008)(66946007)(8676002)(1076003)(36756003)(186003)(83380400001)(2616005)(33656002)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hu3qCwqPjcXcHLDda7gLFe5+VQ/srQtOZmh0qdXvkA4Cz5zjvLvI0Tv8SLC/?=
 =?us-ascii?Q?C52p2EXvuUwkXoxnQHDMNaTadoSHj+HJ8PBy4FcXnjXmKtoaED3E1W9kWe2t?=
 =?us-ascii?Q?Xe4mKmBwCOKcAgg9gRZBWeU+6FF9Eh2JSJfJtlheGr6nS6E8gLgmuQ+8mirO?=
 =?us-ascii?Q?H/SPAjKsZdV4Qbhlz2vl0txkPx/m7jbSiktcqbceQ4NuW6OpGKM4mb4yaU5R?=
 =?us-ascii?Q?jbEtiez9/aKXa2H+EIcAeCY4L1WW5CHLsdtJDdCmrKsClqMwITwWFNxxy9NY?=
 =?us-ascii?Q?RBvIY/YJPopcAR0djFW251aS+f4dGrE/Lo5mLuml3NekbBmMxaxd954dMcI3?=
 =?us-ascii?Q?rWWCpMNRBaeNUJvq5fQ1Xt51duzOrImqdZ7T9Sqiro/FJMR0NFVTXKovf3/N?=
 =?us-ascii?Q?54s25cmGyEqQIziCz93WOVnT58GcP+lfpC+5BDgsImwNw4Jp2GsrLGVwM0sb?=
 =?us-ascii?Q?w1cbpR+2MpY/+R0rZhRUNHC95R5VMzZKpZdx5ncmMAYxS6BhxeRrAS/he0l6?=
 =?us-ascii?Q?p3bAXHin+QJhWSt3rGcHpRHeIFPRDgY4nENOikdeDcMvWzPPlIMR7HKWvP44?=
 =?us-ascii?Q?BMDTVJcWzhW4yWaAa+4f5AyaQ33bgzVxV3ErVQYyV/kHmaQnyZhGcQVWJ7Wl?=
 =?us-ascii?Q?18zDgUGRVrz0dsTyFOLhBxdzRAAOXjQ+JYFvOC74z8Q86PA67jxMSpVHcnMf?=
 =?us-ascii?Q?vOksexfStovQpgjlzh3/lkqpsSQHpsntr31Hi8xvwUOtzrbGQwKC61i4MaIb?=
 =?us-ascii?Q?H3EPFIVvlNz3QTV2Bw7QCnSTXSQwIM/FTqVwBhyWcq6qsPUvSeOa54bpQWAv?=
 =?us-ascii?Q?NAypl7EYfDLQmsIbguP9nbZVNY8o++CFmDDvydC/pwpkKAOHqPGSEm+8lAcr?=
 =?us-ascii?Q?xUH9HKnvIGlAtP8UMHli4Njjr4OdWXmItVTrf9gGGCPO+EHZnnbyksAUb8Rv?=
 =?us-ascii?Q?ZNKFehMMOpo9tIY2eXcmuS/KCiiDX1SyADKPM16ljPL5YBKEH/G+jBIF4vr9?=
 =?us-ascii?Q?FfoLaELKY4uqG3RnIVPKnX+Ow77B0pUbcyAsmp9Sf+BtmSnrlK2qCefcdQkj?=
 =?us-ascii?Q?J7Ln8wBNQ3jO/yIP4O/oW1kdr0SkpS9cpXfgD1rCXrA60iQRf+AiBcMbKDe+?=
 =?us-ascii?Q?TQncIRj9y3UKnIAj91/9u19wiO4h4dWGpCqr7mTpfhNAGYcvs8opiRdL9yj0?=
 =?us-ascii?Q?NyHLzDjHufpU4yhsM+j2s9YfJcZSl9Ub7Zrdm6SjnTgrkZ5KvXxu4p472yVc?=
 =?us-ascii?Q?RFZZR1wANCc1knoMZFh9PVTJaEI104enk5lqg+DuVHUVByzmrG43BE0jcux7?=
 =?us-ascii?Q?9aRabfHEueEPz9+xlOHMRr8g7SWTy8BKoLkt3/XINc2/Ry1wVyG8/DgL6gj4?=
 =?us-ascii?Q?71o4g6slqmbO5P80mpCFZWzUIdncUbFyw7MMOM97+ngVkw3yuHLV/mH3uDc2?=
 =?us-ascii?Q?N6kxVi0XpgTVjyhaBCk/hZQSHqMcYWt2uryUyxDIg5geESlh4GJ19p+VBo3d?=
 =?us-ascii?Q?DVrFsUSQyOSc6ijR/WISQncCb+979KYxaRYYKt2AgchmBzK7h2Lieagibhtp?=
 =?us-ascii?Q?Aqhu6JAo0GBTJ4M9UKF0mLAr/pkA/QUewSeM9vfpBlHF38BO8cgoNcNQHv/y?=
 =?us-ascii?Q?4cGpKlSYREUFw0yVZzf6o/CfWblFQJQ3IMtzm0lQOnFfeTnyEc0qOdmE9u60?=
 =?us-ascii?Q?lh/Jewb1WYLKhbSsoG54pHq2tM59yVvMdaghh8NsR8WJGbg/SqlhOzhImURB?=
 =?us-ascii?Q?/NwzJSD6pOzM9EEEbj0RtMmGkUI8DvY=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a84d47-81af-4953-44cf-08da294288dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:11:37.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm16VrP0v6B5gODjUk3Hsi4xXzwcCp6dW/O60IargmBHxOCFmo+s2Kq3IIYfk81rLAeB6rvUvofwM7uHPLXg7tSr1rsK2gYAhBuzNYnXS18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3176
X-Proofpoint-GUID: bcoruCwVVfNvrhacUXk7JoixikQsOiQ5
X-Proofpoint-ORIG-GUID: bcoruCwVVfNvrhacUXk7JoixikQsOiQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_03,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 0/4] platform: allow ATOM PMC code to be optional] On 28/04/2022 (Thu 13:12) Andy Shevchenko wrote:

> On Thu, Apr 28, 2022 at 02:24:26AM -0400, Paul Gortmaker wrote:
> > A few months back I was doing a test build for "defconfig-like" COTS
> > hardware and happened to notice some pmc-atom stuff being built.  Fine,
> > I thought - the defconfig isn't minimal - we all know that - what Kconfig
> > do I use to turn that off?  Well, imagine my surprise when I found out
> > you couldn't turn it [Atom Power Management Controller] code off!
> 
> Turning it off on BayTrail and CherryTrail devices will be devastating
> to the users' experience. And plenty of cheap tablets are exactly made
> on that SoCs.

Sure, but I could say the same thing for DRM_I915 and millions of
desktop PC users - yet we still give all the other non i915 users the
option to be able to turn it off.  Pick any other Kconfig value you like
and the same thing holds true.

Just so we are on the same page - I want to give the option to let
people opt out, and at the same time not break existing users. If you
think the defconfig default of being off is too risky, then I am OK with
that and we can just start by exposing the option with "default y".

So, to that end - are you OK with exposing the Kconfig so people can
opt out, or are you 100% against exposing the Kconfig at all?  That
obviously has the most impact on what I do or don't do next.

> > Normally we all agree to not use "default y" unless unavoidable, but
> > somehow this was added as "def_bool y" which is even worse ; you can
> > see the Kconfig setting but there is *no* way you can turn it off.
> > 
> > After investigating, I found no reason why the atom code couldn't be
> > opt-out with just minor changes that the original addition overlooked.
> > 
> > And so this series addreses that.  I tried to be sensitive to not
> > break any existing configs in the process, but the defconfig will
> > now intentionally be different and exclude this atom specific code.
> > 
> > Using a defconfig on today's linux-next, here is the delta summary:
> > 
> > $ ./scripts/bloat-o-meter -c ../pmc-atom-pre/vmlinux ../pmc-atom-post/vmlinux|grep add/remove
> > add/remove: 0/410 grow/shrink: 0/7 up/down: 0/-47659 (-47659)
> > add/remove: 0/105 grow/shrink: 0/1 up/down: 0/-6848 (-6848)
> > add/remove: 0/56 grow/shrink: 0/1 up/down: 0/-10155 (-10155)
> > 
> > $ ./scripts/bloat-o-meter -c ../pmc-atom-pre/vmlinux ../pmc-atom-post/vmlinux|grep Total
> > Total: Before=13626994, After=13579335, chg -0.35%
> > Total: Before=3572137, After=3565289, chg -0.19%
> > Total: Before=1235335, After=1225180, chg -0.82%
> > 
> > It is hard to reclaim anything against the inevitable growth in
> > footprint, so I'd say we should be glad to take whatever we can.
> > 
> > Boot tested defconfig on today's linux-next on older non-atom COTS.
> 
> I believe this needs an extensive test done by Hans who possesses a lot of
> problematic devices that require that module to be present.

Input from Hans is 100% welcome - but maybe again if we just consider
using "default y" even though it isn't typical - then your concerns are
not as extensive?

> Note to all your patches, please, use --cc option instead of putting noisy
> lines in the each of the commit messages. For myself I created a "smart"
> script [1] to avoid bothering with that. Feel free to use, modify, send PRs
> back to improve.

Thanks - I'm used to explicitly capturing who was looped into the
discussion.  But I hadn't considered how things have evolved so that in
certain circumstances that might be considered just noise with the wider
audience we see in the typical patch sets of today.

Assuming you are OK with exposing the option as a choice, I'll make
things "default y" in v2 to ensure we've minimized risk to existing
users who rely on it, but wait a while for others like Hans to put in
their input.  I'll probably follow up in the individual patches to ask
for clarification if I'm not clear on what you had in mind.

Thanks,
Paul.
--

> 
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
