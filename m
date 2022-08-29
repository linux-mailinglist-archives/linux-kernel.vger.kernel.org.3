Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977C05A4047
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 02:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiH2AKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 20:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiH2AKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 20:10:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDA32558F;
        Sun, 28 Aug 2022 17:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBqOzgBRiY5FFUni9e5q0jTGKM7Q3pzGu4WnWLXB5UlpkYemcD7Cyx9/lCkimfskwr2qj5W+ZAJ9ImCzySgKUaJtOGkXdQjPlrrKNU/6TQBoGDoLo35uuG+/xYNxoe1sdOOdc8768xaLnzr4empV/aDt2Y9ShWJFqK+LWsOIJbo2keQWfp+eBxlClMHIa/n2eTEgCMY6BkYu7yB97PFeN7FhJYEJ2FFcsz+kxHG3cyKQw6bd66oWfxkGt0sgT8hMjzze4J4Xf+pKjD44OQvFjQCWIer/KjtGUC1SBJ0rFVSjF8ikeMBvAcb5S+Vw6oFqeNNV4akfQLjc8xBnxRr3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAe71djFPDICmTm9XX1ru2HvwCPeoliu7P1OTHltXaU=;
 b=KoOJSczlTuyy54DE5wRxZkyY1bxQZcx6Gwaiwcs1AaOi16bRCX5ypzQLPXtiiNVunwh3QptJn+eHxiYTBfSbdG6t5k8IurGpqPDaimTpuVFX4ZHLGMCJb47RzD3nFsypLs/AM4FDQU1fBKkaFC8nDUnRNECMaoAVq7qdLpSCXr+WnrykMjd/JBweIlmxj3UHXSkhgTA5sXjtfZ46byzESwyouS9ussTvaUiSJcMl3zUJQoDWL0/UhOahT/jqzWm7eFECydpFeYhTN66mkCn3ysn0j28n/1tN/iVIoyCh0PHOy3vFQACeLnsCvm/q/IsRNL+ZKmXbVn4KVHvmsivK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAe71djFPDICmTm9XX1ru2HvwCPeoliu7P1OTHltXaU=;
 b=zb4hHUBtm1VB+dYnbqp2Ge9JASMcBOqIYeCYUWtOIxgXbODuobtPN16m7+Cei46iAc7TZMHrq2uqkPitQJr1D2XZX/d9QlPeQ+Me0aaVbCrwIxyTt6CATaMzm6fFxmz4qPvnn9pKfbBw4WdApIElawm0/KMo3ipwjD72Ay6WRkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Mon, 29 Aug 2022 00:10:12 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 00:10:12 +0000
Date:   Mon, 29 Aug 2022 08:09:49 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
Message-ID: <YwwDzcNMQnMcPOU5@amd.com>
References: <20220817034630.1172065-1-li.meng@amd.com>
 <20220817034630.1172065-3-li.meng@amd.com>
 <0f9706b7-6dd5-663d-70cf-7221b5a1bfc5@linuxfoundation.org>
 <dafdc2de-3846-2612-1b52-d15c02f89b81@linuxfoundation.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dafdc2de-3846-2612-1b52-d15c02f89b81@linuxfoundation.org>
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba8a4c7c-a021-46ff-76f8-08da8952d789
X-MS-TrafficTypeDiagnostic: MWHPR12MB1453:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7Wmy8OfI/EiEFPw0WBYFAfri9tGvMXdrquyEJkzRoKJLHf3y02OEIifJEZlXrsxgDSXhtaaS02IhQ+I27ThgDq9KcDiNDVyIbyhwKDQI64borjn5yjpt+c9PskbRNXN8aPdMLOpAeSIi38shgKB7wxJ9boUqbMYKpMNgrn6mnI1mAFT3G1AWgAIYAZzY06u7I+CruPyxcFR6o2f+4mMcOdMfL+S9pP41C3zG2qRxfVWTLdhge4bB3UFUK1ycLqaogszWFOdRRYxc/MJTSNdSjEK2nX5r4OmLcHoprT88AIO8t1BWTDJF/DCYIW1G5B23LRHXuEfKJnqMkXYNk5O5cLUTbO6S6GHU6ZOBDoDrTTc8O49ic/9TjqOCEysobAxTBqWsnGEYGUHjpJBXuq7bRAvBL9oVFp95kVWUUQ/BZp1/PfJm2gs84tkDNc+hrpnfces8xu2fW+pCLGaTFSS8Yd/zKlnXv4XnVqlbIhlcFzTEabxKGlGQiRnh3wJUmtG50s4KiUgankWhKZDzM3+Vn0xYMp9K2De6q8ZThRvqbNd4mX6CZncdjcGMSp/neODKjAIcmhDrAy7zXfX8gJDOxoMd9enltMjnp59merzgZU8WA5lX8ifupDDHCnX+HWnQCpPin/zujaJzb3CGNk/jZOh+FCAqftqzPIGTp2U9pIqA0CaBKrwKYCCEauJMTQmPZDmsYJ4vNdFIH2SFihdyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(186003)(2616005)(6916009)(316002)(36756003)(6512007)(2906002)(6666004)(6506007)(53546011)(83380400001)(26005)(86362001)(8936002)(5660300002)(41300700001)(478600001)(6486002)(38100700002)(54906003)(8676002)(4326008)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MIyoNjb2deRE/kQ6Wur5/MbBaRz78Bfe2UqgoQq6PcygXfUCW6eYf94/zk?=
 =?iso-8859-1?Q?WRba1oxLg2HsSelEBQpbNaPxRKwVFW+b0KbRH257iz5MMYlni7iNXtV2v/?=
 =?iso-8859-1?Q?H8BxOJhkOFsdjL4DEiYPXrLdYs6ecE2bxYdJgy0fiNNufWLCZ7ZL86C9ui?=
 =?iso-8859-1?Q?Ioq1ZtIflBOMedL9SUAK6CBWTzC7oNP/GXqhuL30fGVFodpA8R79J4hZ4E?=
 =?iso-8859-1?Q?yk8w0GUKas0n7sYiTlDYs+60k57qhPC0OzXpjYiObM8oLjwes+3SxTFdrU?=
 =?iso-8859-1?Q?M1K54+95maJtLwXlmkvw0G50PBxQ6Sa0Re7lCIqJTipDz9aYv+XqnGFz9/?=
 =?iso-8859-1?Q?90vDpjMYuOVHEX2b5LEdrksGSLZ9Xbogm5uWhvqwBul7oXT0GRuedRTjhH?=
 =?iso-8859-1?Q?Mkef506WrZMMD6/J4zGqwGuTfyEQI1TiO/J7P8xB9k+vwY0DR4ifwCABa7?=
 =?iso-8859-1?Q?gPTpGhgoVohZmh3XaTp4iokts9Nb0Bxo8ECYDRD5W6Htlnz+GzmrXjtQ8l?=
 =?iso-8859-1?Q?JKygFhsTrsvH6V5I4rnUUdV47v9HukD7CN/SWP2ivQtm88ugdo80ycwOMy?=
 =?iso-8859-1?Q?IspGiWWP6iI3gmnlMJ/C3W9ls6M1Xo1oRjy5PUmWeyG367GZgynhs1F6Bb?=
 =?iso-8859-1?Q?tN5f//HrF6Nbw4npwqQA8gJmEg0q+AoBGVpngTo/rgwisGO0UyA/hhmHfp?=
 =?iso-8859-1?Q?wvzhbYh+JwyFwSYGQigT6BUAG8J8w9tO1MyydcS0ZGADgrGvnfdwzJeNBI?=
 =?iso-8859-1?Q?2YR/eg/S69SVgM6xkUAJlo4h+f0QP0iqIRlA7kPqvUdyX6NptTw/6TD3Un?=
 =?iso-8859-1?Q?XgZN2IPSN+qIky3YmTETzJbbvpUJg9g50IlWD+Fo02+pgbaSJOa9+933pE?=
 =?iso-8859-1?Q?LFlOzt4WjWFO+8L9WuzTCcCR+Sye0wGU/0sjhSZnpbiBcvsHgYwnEYqVQU?=
 =?iso-8859-1?Q?NEzk7lSMve4u0WiLH8WDMqOuu6MfNEnF5VbUtYesGnhVcP9eqbV+/GACH8?=
 =?iso-8859-1?Q?h8Y8I7VlDZqRvdinuAH7lGhqQfMjnFdgo9NED6x6z/i0pw+OXCeyBuZiW2?=
 =?iso-8859-1?Q?z1ogL9BJbLkQs+4m8DWIDwK14kgbXk3L7M52VH+DjC+HyYxURfocTxRzNM?=
 =?iso-8859-1?Q?fa2URXITCVVRrwT8saFzAV4hYrnRUnkZifROa6vOsi9YKrSEp3lNVbB+SD?=
 =?iso-8859-1?Q?sIgOK+C56ZUEdhBhQARbh4QgZ1184fPCGW/W8qZh+QPN66GUN8E1jCo0w7?=
 =?iso-8859-1?Q?yckmDbtMShe2kh5rrrD7rWeMJgYDXxj/eick/ljHE9K1M2VcblStO7Zbnl?=
 =?iso-8859-1?Q?qXj4HTxjcHxyrxKy5VJe9Ekn4XZfoP+JPPqRJpx3MWteVHyLyILvK4kac5?=
 =?iso-8859-1?Q?VLFCLUtEtLXtm35k6znaZhCzNfMiSd+OvB5Qxf8zBRZSImKqdwBil0wIPH?=
 =?iso-8859-1?Q?DQvJx6+OF/bpDw9IfDJVgPT5MqLk9LvAaxNY1qy3QSge854wSJn81g2VxC?=
 =?iso-8859-1?Q?9L0CE0C4kKYOa6hj8/87AkKDAlDQ7XCZGgcdyaDzblNwkeSp3i+POYWIh/?=
 =?iso-8859-1?Q?l2LCoINyZ9N08RqTKmI649Owgk8GT3y2Mg+Pe/snJtzwLBCTWcnZ87guH+?=
 =?iso-8859-1?Q?903MM70xuBSCSjd8+zWqlctNX/h+p+Ruvt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8a4c7c-a021-46ff-76f8-08da8952d789
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 00:10:12.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90pJ8nT61cXt1SsvIHEFuQ+oqqLkfr078Z6LoHndQa7EJ3FzKCa5tC03ihnoWJ9D144I5W5pRClf3XBFtvWQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1453
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 06:36:30AM +0800, Shuah Khan wrote:
> On 8/26/22 3:47 PM, Shuah Khan wrote:
> > On 8/16/22 9:46 PM, Meng Li wrote:
> >> Add amd-pstate-ut test module, this module is used by kselftest
> >> to unit test amd-pstate functionality. This module will be
> >> expected by some of selftests to be present and loaded.
> >>
> >> Signed-off-by: Meng Li <li.meng@amd.com>
> >> Acked-by: Huang Rui <ray.huang@amd.com>
> >> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> >> ---
> >>   drivers/cpufreq/Kconfig.x86     |   7 +
> >>   drivers/cpufreq/Makefile        |   1 +
> >>   drivers/cpufreq/amd-pstate-ut.c | 293 ++++++++++++++++++++++++++++++++
> >>   3 files changed, 301 insertions(+)
> >>   create mode 100644 drivers/cpufreq/amd-pstate-ut.c
> >>
> >> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> >> index 55516043b656..fdd819069d72 100644
> >> --- a/drivers/cpufreq/Kconfig.x86
> >> +++ b/drivers/cpufreq/Kconfig.x86
> >> @@ -51,6 +51,13 @@ config X86_AMD_PSTATE
> >>         If in doubt, say N.
> >> +config X86_AMD_PSTATE_UT
> >> +    tristate "selftest for AMD Processor P-State driver"
> >> +    depends on X86 && ACPI_PROCESSOR
> 
> This has to specify dependency on X86_AMD_PSTATE
> 
> >> +    default n
> >> +    help
> >> +      This kernel module is used for testing. It's safe to say M here.
> >> +
> > 
> > Shouldn't this X86_AMD_PSTATE_UT depend on X86_AMD_PSTATE?
> > I am running a few tests and when I have X86_AMD_PSTATE_UT
> > enabled as built-in and X86_AMD_PSTATE is disabled, test
> > fails saying incorrect cpufreq driver?
> > 
> > Skipped: Test can only run on amd-pstate driver.
> > 
> > So it sounds like X86_AMD_PSTATE_UT depends on X86_AMD_PSTATE.
> > 
> 
> Once I enabled X86_AMD_PSTATE and X86_AMD_PSTATE_UT=m, the test
> ran correctly.
> 
> Please fix the dependencies and send me a new version. Send all
> the patches so it is easier to apply them all at once.
> 

Hi Shuah,

Thanks to accept the patch series. Actually, we want amd-pstate-ut can be
modprobed even without amd-pstate module, because it can tell the users
they loaded a wrong module like "acpi-cpufreq" and needs to replace it with
amd-pstate. :-)

Thanks,
Ray
