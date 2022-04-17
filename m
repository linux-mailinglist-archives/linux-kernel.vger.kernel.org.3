Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2A5045F0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 03:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiDQBlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 21:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiDQBlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 21:41:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E42DCB;
        Sat, 16 Apr 2022 18:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClEObw7Iv1tNHImPfW/Pz0ox6jyQM2J+ivFCsNeg54sZKEwA//WoqYVZjKK6A+z2zWODaR6asLOb25+Kwqh94rExN+q2GmHK9lMZh3Xb5bELQTT4pvBS+6PxoYcXNVUDOtA/elZvpyRcNAPuM4dlmK8QvOGLcuzBwXaUihC4cUpMP6XobSgxUrBa4H2c+cB7VcJfWr4Al1uP4X9JGl7meQaZ6XpLFwZI2EovfuEnexM480adLh7YR7hfNM18hoDTRKmG289ceFysqrFVL9329JMCUjcKCHP1qT8NIg4XcmkfeMJ7+VbmSOaJvw46c3NqgeuGtk9KAPctqJgwTSwrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaTUAVqKQxUvsfBf8BYkPaEpPspbSQwn/EPiRdHwXsU=;
 b=QbSLzUwmiDqNXJX0rsXoxRX3PsjvCW9xeOb4+OfI90nWZtRkOwM29SFBik6NYZrAhRssU53mXWllD7xoPY8j+ww1soaiNz/MPJFcYF6JFDGEbW/kz26TRV0UQ1H5nApIgdf1z0PFZyaOFgfTIUGYjMGpY+EWe8JF8aLDvkCiYdZhtTm4DImQ3d38+8iUNXF2QuOMCtTQZc5sDpCm+TjwRND7QuLcgOM/q1ANStfmZd69k4TZSRbaEGYBUGmvS5WQXCtH4Xrkar/dtb2O1f/laxhykjiSAW06a3QQIOuPDrsAtoenZDClEmmkGr7oTM8cNhzuDuC42fEXmwC4QD6qDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaTUAVqKQxUvsfBf8BYkPaEpPspbSQwn/EPiRdHwXsU=;
 b=nTOCInvv3Zl3ApzA1jAeH37bigOmHyjHIgOxSSNA6IP6DU4v2ul4Yx5raONvmQthQ4ujCl69fq4li0Re69kHkrAmLEhwGholYq8O/x+BH/AXvHF7495AaPRUTY5cdf88qe7A1uT1lnV5V83k/fiJDN7iUtKXnubNmc9taUP4LCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.18; Sun, 17 Apr 2022 01:39:11 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2c60:61b2:4a7c:2d7e]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2c60:61b2:4a7c:2d7e%5]) with mapi id 15.20.5164.020; Sun, 17 Apr 2022
 01:39:10 +0000
Date:   Sun, 17 Apr 2022 09:38:47 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Add unit test module for AMD P-State driver
Message-ID: <YltvpwYslWfq9Sgm@amd.com>
References: <20220413090510.4039589-1-li.meng@amd.com>
 <CAJZ5v0jFXhfL=2TwBfzzfEdyKUwYDCxo8OKZuYtJjASKE5Oqfw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jFXhfL=2TwBfzzfEdyKUwYDCxo8OKZuYtJjASKE5Oqfw@mail.gmail.com>
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ec8b6fe-21e6-43d9-2d2e-08da2013120d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4198:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41980656FABE41C48601DD93ECF09@CH2PR12MB4198.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AiY/LOxj5ZY/lJSrmIyedgTPhEo/pJwapPXOei+UdZaLOmN/julL2hWUU7wXNn/09q+K+YXab6276LGNbg5Qgz47yjmMlJ6ei8VlS+Y7dqPhuUjI7lvg7NYywFJYoS1AvEJQ190q06ScvoHeHpeMamWEwto1q/sAFNqd/c/2pTnBJRGstwBb0WGk+X3g+MquJKy7qLLgdKV/O9gLEnGHSlT1UiXCkCvjLAR4bZOQ1QJaLU7FSxemSEakkjRRyw8QO41yg+LyOzZadSoSOPBv7EuFZQ19v9MHuzYdqsT5r1+rYta8Y+ZiEdxF/f0JigRKc7p8ZByfwWQTqk+mklCS2j8Od/yEVDybFCak4W7kY2IjF1zNM3iNMVG+Wb1AipHdRdVFVN5ZSVk62kXS5IiyLCuGVi7l1yD0JUEXxXgRM+CepuE54GeKdP52iSXH5qfi1Z95QHlcBwePnWjaaOgcgmKOQXIB0bGVMwAGta+zT/zVO3BmfCpMvjQlc+3awP6Znfbsb7pPKs2Ncp5mTJCSvjvl/RTF15jBxOEDzKOglEPB5A/gdbn5WOVsExG1Pxa5F6QIpJy81lR8BhlYyBhTftDxq+rGdFNGvKQuF2xBN96WtJE63Ig8HHuHIt88sX30g4QhNJC0fdeeVaBSPZP/pv7QWTaTo/pCt8VMl/Jamm9HwUtDD3GX1ArGzBu/0mVp4WySTbJUC+CTmgex3+f6ejG0wxDf/dCLr8KddSNRH7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(38100700002)(66476007)(8936002)(36756003)(5660300002)(2906002)(66556008)(6512007)(316002)(53546011)(54906003)(110136005)(6506007)(6636002)(6666004)(6486002)(508600001)(966005)(45080400002)(2616005)(86362001)(186003)(26005)(8676002)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QMko6g/SkiipMJNNVEUu6N1fQpEVkFNSaYhMEk+AmCy8ZNQrFuxq91iyFfc+?=
 =?us-ascii?Q?yjNk3uZFvfgmALqEnHDg76oCdl9vjvWmlTKDKgBoQsNhleTuX0ZVHq9tqreG?=
 =?us-ascii?Q?1194EIj5BOMNoITE/4mQnl/xnj1l6+5XPazVwhXfwOqRbEBPcpD1Eypj5eBi?=
 =?us-ascii?Q?UBv9WSLdQzuMDzjZZni92OTs3Zg5onrkQ3Cbx1Ew8rqr7MkFm1FIWTf1dUoA?=
 =?us-ascii?Q?ctqjcP0gVRzii66mMnMaEDW7RPquqrZ/w7E2V/BARo1dbLwka0nnisF4AdJ1?=
 =?us-ascii?Q?UQN4oO1TgIA5M8rX2lcmu/umep5tqYolt36/m9YQuL6m58ZLbtFLHcDW5VNI?=
 =?us-ascii?Q?Blz3KgHNMJ77r2XcyBeCDIRdVoDp4ozQiJHDFkL5mZ+UcaXPnY9B/8doFNZG?=
 =?us-ascii?Q?ifTQGLaZD3RGeUfQjSQu2ZiFiw7VTjS5zLhFwP/jIl7or8iKmukCkXCvS9lX?=
 =?us-ascii?Q?5TB0kLMWT/lfYLCt7k+JPJ4MtKrExRPpwJHRAKdy4VnKgmT7kR3YPK5jqsys?=
 =?us-ascii?Q?KaGXc0ltFLMiyq7girxt0J0SQLe6sSGMjKc3h3npbOCZR/jbnSNSOrN7jkQ2?=
 =?us-ascii?Q?3jZOK3eUzPJWvfeabEYRfL76zifGT8EMx0Yr6umcexNWCadTHeuSzPRUebjd?=
 =?us-ascii?Q?thLjrfWypJjsD+Wc0VvzmXC8KwV0dCqoQzuqFfpU+ZV/HlpZMPlL+2Y2/gxq?=
 =?us-ascii?Q?9u+NOgywgmfuZyXaY37+/vdEEv3gZHkYnwyGCOx1hvYUHa5iMDgNwuWMRln4?=
 =?us-ascii?Q?0dQXNUIYkYeyvC5H6XaUUxGgk890QqRm4/l0rHVs5fwxL+IReJcBTYlUic0j?=
 =?us-ascii?Q?HPM/Sny/qUxgbrJBa5vNeVO1V2mOsmnw61zNYZ1N+4nLGMp/dVUXyAcKH7Jx?=
 =?us-ascii?Q?/pneKH1Jdt3+ET3xVvfmJcNCLmEblyAk1TQiwb/4uphyqK9twxsJumbs1Skc?=
 =?us-ascii?Q?20D/Vh9ugV//sxGkxYL52gJo9SOfUOQgB7S27q23CDWDyqsGeRsYfbH9qTpu?=
 =?us-ascii?Q?+g1Z76YqSD2HJZ0ITuJuKAPBdxZeEhxdAOqy6XReGmXFMyrKZwkHCY/AfEON?=
 =?us-ascii?Q?CWee5Wj4S29jA7XMV2PqtZ9GB1L7NsdDsDmX6mYCBDHaAM2hCsgYFQ68Vo+E?=
 =?us-ascii?Q?vBXmuwVf/pyUnCAQKOkYrxqL1dvnzd00R4i74RLw8gyxdxqUCp6wl94yDMNZ?=
 =?us-ascii?Q?H9Nrjv7Hmhcn0n3tcVedago3+pO0JL22WAXJxIShl1QT/o+ixeygT83VfBJd?=
 =?us-ascii?Q?YBIH3s9Cou55Z2NAxo31Cl8QIiUncbusUfUvynQWAzqXPGoe0PaMoECcg06w?=
 =?us-ascii?Q?qPc6jKzkoT521Gh11M3ZV5ud12iUmweeVHqU7vWBF63FNoKazkPzKIA4alON?=
 =?us-ascii?Q?FwbQQzSgRiCLj+8mPv0GvRTRHFTZHJXq8MceIFl0TLQ09fS1DwKyQhVByRlA?=
 =?us-ascii?Q?7SUjyGCvYmqCtj9QGHbiON7AryohPiVqK8V+1oC2y5GS4osSPUkWbRHosmww?=
 =?us-ascii?Q?zBNkor9ToVJCA78RIg1QeUMkmgtMx4UJwCBJVAmsWkxKVEbxX45CzDKkgU0D?=
 =?us-ascii?Q?PZ2s7gubLp+KpwILaXM/R/jl/WyRPosHtqCcL6fF/1+L1cdn4WOV23LFhCll?=
 =?us-ascii?Q?rxHIt+ZxlXttZdYPtyVh5Rz3hkJHAWwJbVPqSbzTJuNYOCOSY6LD7m3L0DYv?=
 =?us-ascii?Q?/toCP9qPrAM3IESGipZps3OaBAvPLngJfcIR0vpU3o8uNVbL6ATZoOPe1gmb?=
 =?us-ascii?Q?S41hXyGBBw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec8b6fe-21e6-43d9-2d2e-08da2013120d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2022 01:39:10.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGawCbhhmeUM2ASxH82T26y73V32pVMPZIgCz2Blp7qBwD2uWWS5N47jXXZsX0QCV0qgE4lqW2ZsGhEavYbNLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 11:41:44PM +0800, Rafael J. Wysocki wrote:
> On Wed, Apr 13, 2022 at 11:06 AM Meng Li <li.meng@amd.com> wrote:
> >
> > Hi all:
> >
> > AMD P-State unit test(amd_pstate_testmod) is a kernel module for testing
> > the functions of amd-pstate driver.
> > It could import as a module to launch some test tasks.
> >
> > We upstream out AMD P-state driver into Linux kernel and use this unit
> > test module to verify the required conditions and basic functions of
> > amd-pstate before integration test.
> >
> > We use test module in the kselftest frameworks to implement it.
> > We create amd_pstate_testmod module and tie it into kselftest.
> >
> > For exmaple: The test case aput_acpi_cpc is used to check whether the
> > _CPC object is exist in SBIOS.
> > The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is
> > not existed at the detected processor, so it is a necessary condition.
> >
> > At present, its test cases are very simple, and the corresponding test
> > cases will continue to be added later to improve the test coverage.
> >
> > See patch series in below git repo:
> > V1: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pm%2F20220323071502.2674156-1-li.meng%40amd.com%2F&amp;data=04%7C01%7Cray.huang%40amd.com%7C7a5d4998e2ca413a215b08da1d6425e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637854613222577975%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=8fAzN5hea4sVO5E7%2B9Uh9VSsyt29gM2%2FCkMXHS0%2FfP4%3D&amp;reserved=0
> >
> > Changes from V1 -> V2:
> > - cpufreq: amd-pstate:
> > - - add a trailing of amd-pstate.h to MAINTAINER AMD PSTATE DRIVER
> > - selftests: cpufreq
> > - - add a wrapper shell script for the amd_pstate_testmod module
> > - selftests: cpufreq:
> > - - remove amd_pstate_testmod kernel module to .../cpufreq/amd_pstate_testmod
> > - Documentation: amd-pstate:
> > - - amd_pstate_testmod rst document is not provided at present.
> >
> > Thanks,
> > Jasmine
> >
> > Meng Li (3):
> >   cpufreq: amd-pstate: Expose struct amd_cpudata
> 
> Please collect an ACK from Ray for this one as per MAINTAINERS and I
> will leave the series to Shuah as it is selftests mostly.
> 
> Thanks!
> 

Thanks, Rafael!

Jassmine, I think you can mark all patches as "v2" not only the cover
letter. Then we can separate these series easily.

Thanks,
Ray

> >   selftests: cpufreq: Add wapper script for test AMD P-State
> >   selftests: cpufreq: Add amd_pstate_testmod kernel module for testing
> >
> >  MAINTAINERS                                   |   1 +
> >  drivers/cpufreq/amd-pstate.c                  |  60 +---
> >  include/linux/amd-pstate.h                    |  74 +++++
> >  tools/testing/selftests/cpufreq/Makefile      |   2 +-
> >  .../selftests/cpufreq/amd_pstate_testmod.sh   |   4 +
> >  .../cpufreq/amd_pstate_testmod/Makefile       |  20 ++
> >  .../amd_pstate_testmod/amd_pstate_testmod.c   | 302 ++++++++++++++++++
> >  tools/testing/selftests/cpufreq/config        |   1 +
> >  8 files changed, 404 insertions(+), 60 deletions(-)
> >  create mode 100644 include/linux/amd-pstate.h
> >  create mode 100755 tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
> >  create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile
> >  create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c
> >
> > --
> > 2.25.1
> >
