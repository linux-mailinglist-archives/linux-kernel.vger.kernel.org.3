Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D536568991
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiGFNcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiGFNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:32:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCBB24944
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clyeREZtjTNtNXwVAPiZADjC3kwUFfavcV2Kw+7XWjM34X/cGkcbOM0dIFwqufGM0zTHLyCt16Mvl+Z0VZqqjVItwVjepAt8oFW6Ush1/UAbe/Hzd+K76zYLzVGrq1o0ITEB8qW7vL1eGm8fI2VAa1muj7TsjkRRYVNqUgS0s4KUqEUi1L9jqUHiJCxD5zvj4bF0ZD8lFamGTplqkaBmuijbvmFzwkK2hFtRVPFo37IKLW/+4d/0F28/3vCqwerVl8wEYzpIHBon8DhLb/XSCffmO/jpiru8uKJMPIZd3WMK/GsgslxGNVTagFG78PEF5NEH4TwkqmZ6X4Q3sOnWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW89Dlla7fG02y2kibsv5FYfnY83/A3lrj/ydmU1vdM=;
 b=cgBQq1yNCqHxFa4s6+8upHG4Lk2FI5YrfzjTKMY+DLpcN/YRfy7qsh1NGTTgEf6yci8+yvp9Xxo8MjDl9SEtmGycSmL3VXksCjCiy83ANG1PRUYg8i0lI8AksCxDXkUk/qaYM1iyKkPomxUJIjbya/qFaPV7Zh369DygdkU3aERorybgfMm+deepOo6XSHQKMjoJi8cl2lUcG5M2/+qL/d2dF4UCeQYPtP24rjV2GkzgvJ7CitazFLdv8SBYgvPx3fMliIaXKqYUedcCGJYMq5/fFfYTV76CjyH5dmlQWqBk2p5/7Dh35kioDzvAyYadBxXANFKe/rvdalLs3khXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW89Dlla7fG02y2kibsv5FYfnY83/A3lrj/ydmU1vdM=;
 b=RJBOm0oajXftpoLXf/e2Uijy4pFPQMfdxECHUqvPHEjaXdabyFh38dS/i8Ms7l44BQ5SHGATbIPp7i1CB/fOWMxJ1/Cpm66x2f3K1JHub1em1wkhk3kWYgLKpQXFZxobgYEkbJOZMjE+tUjYXiMhviHu3664j4ufdcHNeh09gHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 13:32:09 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 13:32:09 +0000
Message-ID: <5173b152-0c16-9713-505f-918725963587@amd.com>
Date:   Wed, 6 Jul 2022 19:04:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [ammarfaizi2-block:broonie/sound/for-next 328/350]
 sound/soc/amd/acp-es8336.c:200:13: warning: variable 'ret' set but not used
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <202207062130.ZOiHtbFz-lkp@intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <202207062130.ZOiHtbFz-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc11496c-5e10-4597-9499-08da5f53ed2f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hs6jJ+EDcN3vyGhbN/bdWXgC+KTNdfRQ7R0W9KDJz0V21ULeonPtt4UfYtAkZLnyttB+rzg0YK9BjNqRCecnUhnFKd3DCowGwumTuNUEloV+fKRtymun1+jXhmxj1mX8pWyPvpdLdcDJS30uLIe1xzx5dUQsy+HhOkvgeG6S9H6uFJVP4AlKvL3Y58hvLH30L/dkoNsklfLp6liT9hanwp0A37tQbVFLAJ+6BmrBknfByCytih7/n2KqsqXftyeuC08oVEX0seKb1NFsAYwDrXVH95JqR2ZwffKgB5htBUUr5yjZnUt+BGLQLgJxMrQ2CdEBWVHPcff8XpWd4pn+Aton1l0GIBAf99fMaUugB2mw8w+hPR/WWLA+UmO31qGNvxhXKscKqWS3jt9azDy//FYhY0TUCUFJwrgoCtBq5/LxhvXdyTwHIEhieNKX6Iwv3vSvI+CJ5prUwMj6EDNDbcC1donIURiOTcF8FCLiIfQKUI3Ra2uAOUukN0NUIKHmZNQlbLcb8WZYThXiIDhx1Df7q7IzizqF1HjzTq3DxF4PHx7UkCFOdZO7H+kDBO2vf2IVJLXYHyZeuLhNN1t/fsoyI/8E3n1SUSLExL6AAUBiZ92v8N51aG75byDvgHTGYgdlTSSgXDUm+WGLzEGXHlpzM7sLMvW14SouC7/s1RFsJ0wdYIEqB5kh5CjD14po/QWVNRXwrotmV6/9pr6gN2ZyN4X7y4NfL+0QOpGFVPN/5zW9k3WsBNiJx9pIzOMtQNDAEta4/ghJehD7ohhaXJSfn8LVjxAxrdM4pSTdCCiFEKEFXRNZYN8egaeDYGf6r50hc58l8tnAsc9vmibHbeUkHPbZ2UXPWo4EmkBvDqkzOxHtmDs8vbO99+G09FlY4CgQJkc2UawaQCtfptX9sugYegNfdy+hb2y3cMcSgq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(478600001)(38100700002)(6486002)(966005)(186003)(2616005)(31686004)(36756003)(6506007)(41300700001)(6666004)(53546011)(2906002)(66556008)(316002)(54906003)(8936002)(5660300002)(31696002)(86362001)(45080400002)(6916009)(6512007)(26005)(83380400001)(66946007)(66476007)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUNFd3pSY1pudStSNUJ3bzFQYVpZeGI1YWI5UVVxNXpRTXM5c2xlRzFOcVlK?=
 =?utf-8?B?cmxZdWtNcjlqZ3pyMXY5QjcxY1R1MjBkOEJtUjFvcmx3MXdPUVNwdE1aVXJ0?=
 =?utf-8?B?anU4QkRLaFcwOEdobjlpRGoxUGgrcCs1TGRhSTk4a3VneG5FZGxsVGhlZGxj?=
 =?utf-8?B?VnFEZ1MyQXNLSUpkQjc0VUJwRVRiK291QnFtcHNiQzZzbHQ4a2NyNkNlYVhj?=
 =?utf-8?B?dllGdkxNajNMK3VYS1hiekFINGlpNmpKejhPT2ZqcDN4QU1xcGpKMHVVZ1A4?=
 =?utf-8?B?cEVCOXNiRzNoZHhlYmRiWFZpdkJwVFl1T21UM2xwbjlQMGtYQmtudDRpQ253?=
 =?utf-8?B?RUMzSEhSSkdzNUlnejdsWVlaTUw2UWY1ZW8xRTdMMHNZdi9ENnRXRU9wbkM3?=
 =?utf-8?B?dDY5N2VEQnh5azlwUUF1ek5kc0dkVmVOWEpnRVVaYVoraGV1R2JCcHhjZVRj?=
 =?utf-8?B?NHFvMHpDSkhkU3lpbDA1OG5lbWxjN3RKTGJqRkF1OEtFT29tdjUxWVRYWE91?=
 =?utf-8?B?ZTB3cG5zYTQ0ekE5L053SENma0Y4U09yTG1PRmxvd3FSNFIvcnp1cXFEQWdw?=
 =?utf-8?B?U0tJemUzVTcyYVc2L216MDB4eXY0endQRy80RTNEaml6OUdkb0ZzNnlWeGIv?=
 =?utf-8?B?dU9Hc2IzYmNGV0pOL1VMRVVRS01qeGVHZ2xJN3hrZ083SlZMY3VLaVE1VHlQ?=
 =?utf-8?B?RTZQdTJxRm1OL1dRZXVGbDA5UFkvUWlFSUdMYXd0bGpFUGE1c3hPbC9kSXFi?=
 =?utf-8?B?ZnRLQ1c2bFY3eFRRcFROTlBoTVVCZWFoVkJKdVhzbi9MQkwzSG5iTWt3WDRX?=
 =?utf-8?B?MWpYQ1Bwdnd5TjFHeVQvcWpRLzE2WkwyTGtXWWM1UkxXNzI5dGtiVXBUeG9E?=
 =?utf-8?B?ZnF5dmUrejBiVmdYYTBwVkRnUGN4VTExaFZHc2M4c01rTFNxT1Z4QXdoTThl?=
 =?utf-8?B?b0FUQlNVSFVFR29Pejg4WmRtNTBCeUlpMi81cnNEcHZVckc1RE1icGRudHFl?=
 =?utf-8?B?cnhwWCt0U21XL2xuR3NCT1l2Qi8rS0tiSlRSSGlDS0RSM2xIaVhQNDFpNTF1?=
 =?utf-8?B?WGJoMmNvUTErU2hsQmFwbUJaaWRxejZ0Y01KQlVhMjBQQzUwcndjV1A0VlhX?=
 =?utf-8?B?YVZnMGZYZkxVb2srZWY0Y2I5NDliV2VTQ1I4U0tLRHgxYVpQRTNGTVcvMzhJ?=
 =?utf-8?B?M2w1aEY3RFlEUkRxVktPcmpmQW9DVWI0Zm5TbEx5VVlIcXF6Q2d5ZG1SdS9Y?=
 =?utf-8?B?SFQxL2cvSmNuNVdSR3p6VVYyZmIzb2JMeXlHa1llTUdVVGZ5Y2xWSTFpT2Er?=
 =?utf-8?B?ZE9xM2Erd2IyMzkxWUpmSm9VMXFtWnJpTU9uMlF0S0Q0cDh5bTlXL05xMWpv?=
 =?utf-8?B?THJHMXRaTnoxakxFTmgrdm9VWWNmckY2S3NvU1ZzWXplU3BrR2JITWkzdEJm?=
 =?utf-8?B?aTluclpMenAvZVFOTTFUdTNLMVkzdC9FNlMwdXRsNHFEbGdoWGZtNkRnTTNa?=
 =?utf-8?B?YkJic3VSYllVeGFaaVVZT2xscmhJVko3RmlYRk5YYmpFVitUMFVwYjZaZTRG?=
 =?utf-8?B?RHZBL0prNGMvaVNweDk3WTJQc1dEOW5hT21sR0hwNVZ4Wm1PSEFTWHlLUnF1?=
 =?utf-8?B?ZmovVi9kcnI2c3JUTVJXQ2FoWUtka0xoN3RCUFZQVVYxRGpjbnpmbXkzckN3?=
 =?utf-8?B?NS9TOEEwZTVHSFhQMGxLZS8rdzBKQzVGcDg4RTBiZFBTRS9lNy9XejM5T2FK?=
 =?utf-8?B?OEZITkMvZDh1NmFjc3dYQnArUVhLMXJlUXFJUnZSTGlsYVBON2JpR3lxelNt?=
 =?utf-8?B?c3Q3OVBNY25VeTBubTRKODhOekhPbW9hZjRnK2c1SGw0cm1pdmxjcFMwZGlL?=
 =?utf-8?B?OWRseDlpL1VJMGdVUnRBUHRVYlJYMFY3MGlPQjJVbk5TaElSMXlWNFdrTmls?=
 =?utf-8?B?a09UOFUxN0t6YXhHaDRDNkR2UDZUTEo4eDNUL2RYNXhXd3cweW5leHlPU1d0?=
 =?utf-8?B?d1JDNkhQa1NFTXlFdkhvaURLNzQ2RXlyVndka1pFd3BWS1Y5N3I0SElZNUR6?=
 =?utf-8?B?aGJJYTgxaDIrSVpQR1ZsQ0t4djZxaFk1amhCc29Xb1d2THFkZ3J2WDR6eG10?=
 =?utf-8?Q?GjfHNIw2yz1BTwsEiKAYzSTyW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc11496c-5e10-4597-9499-08da5f53ed2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 13:32:09.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOBupSQuE3mZpnKT81GSqYydrhr6Pplxm46ZNzrg4b4INT8mJ8qoOlPiDignD5GUeh2OFzuulnWEU2LteF2QWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/22 6:46 PM, kernel test robot wrote:
> tree:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fammarfaizi2%2Flinux-block&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7C0e2df47acb3a4a45cef108da5f51d702%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927102343485757%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=iomgwZKDI83uZCQDRvGYgcvKuKh%2Bo13lPp3nfbRrTyg%3D&amp;reserved=0 broonie/sound/for-next
> head:   b182f4804a456b4ffdef1da14aef92c8d4cfda4a
> commit: f94fa84058014f81ad526641f1b1f583ca2cf32f [328/350] ASoC: amd: enable machine driver build for Jadeite platform
> config: i386-allyesconfig (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20220706%2F202207062130.ZOiHtbFz-lkp%40intel.com%2Fconfig&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7C0e2df47acb3a4a45cef108da5f51d702%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927102343485757%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=emcKRng%2FBGZmBQYhxmHftQXVrjfMVMUv8OR99DrZCHA%3D&amp;reserved=0)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fammarfaizi2%2Flinux-block%2Fcommit%2Ff94fa84058014f81ad526641f1b1f583ca2cf32f&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7C0e2df47acb3a4a45cef108da5f51d702%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927102343485757%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=zhjq5SzIYw291Z%2Bpo2dlWPqYoPQqT3tkXBfHTMbaAUY%3D&amp;reserved=0
>         git remote add ammarfaizi2-block https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fammarfaizi2%2Flinux-block&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7C0e2df47acb3a4a45cef108da5f51d702%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927102343485757%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=iomgwZKDI83uZCQDRvGYgcvKuKh%2Bo13lPp3nfbRrTyg%3D&amp;reserved=0
>         git fetch --no-tags ammarfaizi2-block broonie/sound/for-next
>         git checkout f94fa84058014f81ad526641f1b1f583ca2cf32f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/amd/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    sound/soc/amd/acp-es8336.c: In function 'st_es8336_late_probe':
>>> sound/soc/amd/acp-es8336.c:200:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
will fix it and share the supplement patch.

-
Vijendar
>      200 |         int ret;
>          |             ^~~
> 
> 
> vim +/ret +200 sound/soc/amd/acp-es8336.c
> 
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  196  
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  197  static int st_es8336_late_probe(struct snd_soc_card *card)
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  198  {
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  199  	struct acpi_device *adev;
> 02527c3f2300100 Vijendar Mukunda 2022-07-01 @200  	int ret;
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  201  
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  202  	adev = acpi_dev_get_first_match_dev("ESSX8336", NULL, -1);
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  203  	if (adev)
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  204  		put_device(&adev->dev);
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  205  	codec_dev = acpi_get_first_physical_node(adev);
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  206  	if (!codec_dev)
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  207  		dev_err(card->dev, "can not find codec dev\n");
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  208  
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  209  	ret = devm_acpi_dev_add_driver_gpios(codec_dev, acpi_es8336_gpios);
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  210  
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  211  	gpio_pa = gpiod_get_optional(codec_dev, "pa-enable", GPIOD_OUT_LOW);
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  212  	if (IS_ERR(gpio_pa)) {
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  213  		ret = dev_err_probe(card->dev, PTR_ERR(gpio_pa),
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  214  				    "could not get pa-enable GPIO\n");
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  215  		gpiod_put(gpio_pa);
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  216  		put_device(codec_dev);
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  217  	}
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  218  	return 0;
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  219  }
> 02527c3f2300100 Vijendar Mukunda 2022-07-01  220  
> 
> :::::: The code at line 200 was first introduced by commit
> :::::: 02527c3f2300100a25524c8c020d98c7957e485e ASoC: amd: add Machine driver for Jadeite platform
> 
> :::::: TO: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> :::::: CC: Mark Brown <broonie@kernel.org>
> 

