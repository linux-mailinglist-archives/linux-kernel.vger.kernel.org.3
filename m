Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BA155E6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346516AbiF1OZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbiF1OZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:25:53 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FC02F661
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:25:51 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SCZ1BX012398;
        Tue, 28 Jun 2022 07:25:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=PPS06212021;
 bh=6rt1kwIueabe2dNIkyAL0qdhEseL0IqKsqzu1HxyZCY=;
 b=Yp27X+nuFd6TPIAW2JTT2qiyEkdOAtTwzQIDNfJo9ANZonUSX5dDNCrO6jGgGZYu2LQ+
 363U0oyunZWoWWSN+0kDGOX+7mg8V8r8KXNdm50LyHJHM/5xAtLVpSUSDfNbLsSAUyXL
 93cRS01UuN9F74ohQ5q+DFaIlpfSQW8ZXWAzz6OYd4wSKDtw5ktg1nvpEOMObxj84nuF
 4qcbDQnWpTkmlqIPWQ11kUUVuvqFKFIisYETHgvheAd54Qs++4MEilTEne1IgvH2XsKf
 fLkCUytsbIVyeeBvMwzszlCQCPqNgsRPy/TCoxrK+4LNi01Y3gCp8RlGxX5N1pE7pxvm tA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3gx1vka5wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 07:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJk/yT/fz2BIK+w1EaxvG8Tt3YST7f70RT5PF6qhCg8rJZIySnXOaYjJVu5LBuzMyPp8KV9S1xVxrMrqOEfj1P1jWUkE18irqHCqzDC8/OnR3/gMVt3/mZ3hoAN+v/MhFSP07pRsU6iX0RWCWhdIrdfDblSyCzGC2mRTIGOSuHtWm8c11UWLgfcazP2UIlNfSgSQ8lreWwD4iPtdLpERsdLHaZE0w7IaamsFhv2+lx/uAf1q0neybPzIrZWoljgzg84/4INCl+OKpDilGECQSy+6V0bZswMb0xEphwNoiCKEliXWO2Dx+5uKrPFVJPNiEpMFg0MlPLr3fNpuvNsCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rt1kwIueabe2dNIkyAL0qdhEseL0IqKsqzu1HxyZCY=;
 b=dMVlrAU+CQeHQ8SMvBRQihIE8bwW/soE0/dnPzVXDjbwNec2vGCrlz9pPJFzsLeIstPP4Ti0uE7vcW5qKJa1N4XQSWY+OyN+bQ/4oiS6kS+PUzTBtwphPIzCu4zdhqbXXsK0/kgm+i4JtUwobSmHtuAi34YfLzxzzHPAqs6+MGEph/33m+nA4hiFI2VYIenjinnk4ObTHPhgF56EXUia0aNYQY0i2vJAgIldnBiiyK59HyGp+2MLdrMfzvtt0RQuHwST0OSrr2DgWTlmAL63pVuobx/zdzVC/sRDiJCDCgqxWDz0/LqWaI+hkrfnVdUBzIjx5FGNwFFdtUNFFbw9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BN6PR11MB1633.namprd11.prod.outlook.com (2603:10b6:405:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 14:25:06 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::45e5:975f:214a:f0d6]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::45e5:975f:214a:f0d6%4]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 14:25:06 +0000
Date:   Tue, 28 Jun 2022 10:24:59 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>, mmarek@suse.cz,
        Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] kconfig: Add implicit CONFIG_ prefix to
 IS_ENABLED() and co
Message-ID: <20220628142459.GB1723@windriver.com>
References: <YrrQOifFIiISf/3g@hirez.programming.kicks-ass.net>
 <CAK8P3a2XfzQo6emT4pXXxAjWewdP2LiAe2fOskFf-0suSmBJQQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2XfzQo6emT4pXXxAjWewdP2LiAe2fOskFf-0suSmBJQQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a623e0e0-7b33-4147-7521-08da5911ffb4
X-MS-TrafficTypeDiagnostic: BN6PR11MB1633:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXNd49nt4TFECCmM5GPOOAW3udqrQpHV+ELChfOUOJ+i+pZyD6WeOy6atJ96qMyXgIiqwkV+fwQtaq34/9WX188aN3ptXQDvHFRgZUj3Uj1OeDuxHFia/PI3dQuxFodaoeRGMRDDGTwfkOqvFDe4TEhKg9z4THLdvUc4sKHV7cT29vtY1wQPLkew8VH30GZJIk9kFxqyT3rtaMJIi0ZCEVYC4fU08XSjQeeEs1ZpRYxhwTI3NTMaMN1BDO5vxJ3EK+vHsZ9jkvtbBSAQZPS6NWJ+bWib/sUwZ8O98kCjEuQ8cSsef+eN8G0U1kGLHsn55Pg9zGy/k9SR9vTyxS6KZT7Q1kynf0VZGtR5SDrNnX1B49RpmY4P42CXejzYv70lMG2ZPqjjUA6ebPkAjMDXlwzIWk5i69vKsFKBERhXrSofz8Dhp/703JkuPnYNI4lvNcFis6OY1g0qRxXo0F9VMiP9VlhFPlI1oKGAEGl37hUs8XyCJEyzsPEvEtQMtPUIWuLmkxrWq0GKeU59o045l8rfRRQObtlMaFgN7fllcVx6srppCbeWDDT9UWRCJRTKvNEoKJWd1FuiyPISBF1HKHXD1hNFvr92t7/DWXFR1noxVnu5ORUjQ6bM3YfEroK1I76cp02KuxjSd/0EUXr4K9O1EheZOs1JSOrhAmKVTsFxpERHRh/K8kGptcKXhwcEgNMgaaeD9TAq//iH6279RicDE9NoRc/lBb4gd/RYu9ULudY6GiXGcU06URG4VmL2uI3r+Obl/z2TlKWU/V6DgvqmJSUBhEZElI4JYu9XNqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39850400004)(376002)(366004)(478600001)(44832011)(6486002)(26005)(33656002)(5660300002)(52116002)(53546011)(6666004)(6506007)(41300700001)(6512007)(8936002)(86362001)(2906002)(36756003)(38100700002)(2616005)(1076003)(186003)(83380400001)(6916009)(8676002)(66556008)(66476007)(4326008)(38350700002)(66946007)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6CEtXPS94DajXgkpjyu2m+3RksRTvYz9po7PyyWfoSJRW+saL8V9B6rvtLMF?=
 =?us-ascii?Q?YDSZd0N0v6UiJMmoxw8xXLxvfdACSzsBOHmiOmSHF9n3DtXbxy3hyYT0J1LJ?=
 =?us-ascii?Q?kT60zIvIMFAOzGDhUrkOX8cHHbSWfrO9d6XfulCJgxcj/HBtBrmx7cM2qVNo?=
 =?us-ascii?Q?CEMQ2yI8nmzWpzdIyG0SEAewjDYLcS8nutog+Mwzq5M4d5Swdox/HcAg4sLR?=
 =?us-ascii?Q?V2IF+7IsTpCTzdZw7f5Jix2HeQ8EsDHo5TJkq2lNAL23i0G6YaFU6La3nKuS?=
 =?us-ascii?Q?3EL5rGKYqiIfZsxQS1E0l2TYiULH+NrJQpBIWHssDFerLdP8YAWZw/pe/hDf?=
 =?us-ascii?Q?FYTuXjgK/DfLfj5ZyQjOgBhmZWE3PLrTW8lCfbxVQhnJBBdB6LqxXLcTCcuP?=
 =?us-ascii?Q?/NsqYBmUn0Uah/VOiU8wT+M26cw89cfjQuLHqBa5jl15L6Eh4i0/pPTcggCY?=
 =?us-ascii?Q?151ON1Qc4m12Wv5z4VL+YT0wGfocBuhEt2hOC46Ddozewyoogi+sCKFp3u1r?=
 =?us-ascii?Q?+ACP6Hu9MKw+VwfXaRAhkDHIf82Kw8YLp9k7tgPtaDut2l0+kz76tdwYQLiN?=
 =?us-ascii?Q?bbyry6h8WD8rX5X73duk6wmmORhXEfcB2qL9k/iMc0Tzn8rrxPC1YtfHaxP8?=
 =?us-ascii?Q?6FNsOfys3vlcy0Xuxkdm/xdE6FplGzpSoL8Si+c4F4kX3z6GmMm+PhenYUY0?=
 =?us-ascii?Q?jZsN9Yjz/EiW7LV7yXb3rLb6vbjRhHLgU6TkOAvnkzFHjlvj7H9ikSOFfVBD?=
 =?us-ascii?Q?WQSJ8K7+jyeS8glQ1DWZ/nL7Ig3ROjvObT4fdA8oYDbzcCkmD9BsXtQr3lsE?=
 =?us-ascii?Q?tfi9WR61vdDv6Ay6l5Bs6gHCRxL5ODGfdwjFk9Yg/9L5e3276eKWf0QvfZP7?=
 =?us-ascii?Q?AwDUzGYoSVaAGyFBi21SVyYcufvLIYUAIR/9kJsJXA23d4Bl58BAaeFpX0NE?=
 =?us-ascii?Q?2xIZmJ+c2x/MVCLDqjF/eiVx14k+0WfsLEWD899KozWxlCMMP0JxnUEfZwty?=
 =?us-ascii?Q?uvsd7iMcv+QKsgMkdGwrq7DnVYAsvt5pgMfMuCyla7AQs2o6JL0XNTsWUC2n?=
 =?us-ascii?Q?MF+7GAjZKAqV0sCNyaNV1vn6f4pTklkCnarVH/LTLJc+KYpNBjC9DZw71AvG?=
 =?us-ascii?Q?V9XYK3Z4gbFDpLQvTuWnQU/YB3pEnUxpnSBO2WtQ9MPVGxP+70TDskpJq7LI?=
 =?us-ascii?Q?1Vj0nQEBbCH2XW4xqCY9aOFfRxvl9x6NTJAMVW5CCPhuxoDDlX19JaVu6zSP?=
 =?us-ascii?Q?peOqmyH2HGRxm10tSxD7tZZ/pKerMJrTqaKKhGooHb4RxeROQI8IR+ZhoJQw?=
 =?us-ascii?Q?Bcf51HbNBxECQ4Hw6vusMItQBu770ejTiK3sjAqdXq2ucXJZNotXuR6uvhej?=
 =?us-ascii?Q?cn0tFLGEK1/uirY2OdI5GzlUp+UyqIX3LJZPwdOb8RDMUGAmVRXDRgF1TI6G?=
 =?us-ascii?Q?G9mYdvj3UnmJy87w0+5p6NJjq4Wfca1zyVhybPSR5o1xS0Lm0m0O0ftWg2aJ?=
 =?us-ascii?Q?/PKH9NqJsQpoEHGJlsqZym5qRF/2rVbeqzz04AAkTfjq3zhJ7Jnlz2d1yRyk?=
 =?us-ascii?Q?VHqaMA0d85+9uRdUjWyk1sIKyTVUIGDG57mB77jvL+mXsmOB8B+8uJpRU7ny?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a623e0e0-7b33-4147-7521-08da5911ffb4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:25:06.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4NOC3FZ5RhaBMHBQAM9Xo9LB+uL5kjyKHG9x/a0fbZwLekEVRvB1fTUUfo5OnobtOuwrHVYTUia2/aFTZ4cZydEwDE9Z7FhO5a132RGKZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1633
X-Proofpoint-ORIG-GUID: Bjj88NWAf_LU7g0wdJTF6DR7oPGxtVmd
X-Proofpoint-GUID: Bjj88NWAf_LU7g0wdJTF6DR7oPGxtVmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [RFC][PATCH] kconfig: Add implicit CONFIG_ prefix to IS_ENABLED() and co] On 28/06/2022 (Tue 13:19) Arnd Bergmann wrote:

> On Tue, Jun 28, 2022 at 11:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Since IS_ENABLED() (and friends) are clearly meant to be used on
> > CONFIG_foo symbols and IS_ENABLED(CONFIG_ is so long and almost an
> > tautology, allow the more compact usage of: IS_ENABLED(foo).
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I'd prefer to keep the more verbose usage, mainly because it makes it easier
> to grep for a symbol. If today you do 'git grep CONFIG_PM_SLEEP', you find
> all instances in Makefile, in #ifdef and in IS_ENABLED(), though not the
> references in Kconfig language, which leave out the prefix.

TL;DR - me too.

I confess that I do the same thing - I grep for CONFIG_FOO to find the
consumers, and "config FOO" to find the provider.

So while I can appreciate the value of removing verbosity, this will
impact workflows of average people out there.

Doing a grep for "PCI" is practically worthless.  Having to grep for
both CONFIG_PCI and IS_ENABLED\(PCI will inevitably annoy people when
they realize they missed a code path needing an update because they only
searched for the former.

Paul.
--

> 
> If we remove the prefix for IS_ENABLED(), the same grep fails to get
> all the results, while searching for the substring without the CONFIG_
> prefix can end up finding false-positives by finding longer strings (e.g.
> CONFIG_DEBUG_STACKOVERFLOW vs
> CONFIG_HAVE_DEBUG_STACKOVERFLOW).
> 
>        Arnd
