Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34344C0A59
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbiBWDio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiBWDil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:38:41 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B2A3D48D;
        Tue, 22 Feb 2022 19:38:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kldDa+L/+pvVAH4Zg5xsRkPARcvcvn6XjzsxO6MPu1o7zgU7v3Hej24yFMPxYtHtW4tHO9AW95f1kozijpI8JmrApoumpCf2ScHJLPA9U6IqvDAs5vfA09iLcF1RC1BKZoHhv3aDPe3jTQ+6brPEM9zGLkkl9/B/4uAIjDp9J1AQu5XB68A4+Nu2LystIQNrviqKT1KMMXG+N4SYzjeEZ/hiHhalexmkGiYeF0b9TfWWAi9ruFUkXBD68LQOqnfdZYdS3j2QGkIgq8ijHNwsyxqZbwuFR61XdoYbpjenY9Usuuo1KswBn6/YaIwiEZ3UpinASl27+cgBiGOtZW0gsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9pRRYa8PNP/LDfnxuXduAxxzR6MjSK9yTp4PsvRGQE=;
 b=FWwKVUtFaoFrN/lnsI2q0xIecxpdkor7uI3yPhdMsrvlVgXegYUnEd97rtMUI/dtTqrznIJqXsA5amUT4VVkfZblIVkP+06d+3d7XJD+qONwF/B60Jgdjm83dFgwP43ZWBrBn2T7BVNRJhMxPzL17HucmrJdgzwcS0GG0yTcLPYHaoZMJecsKOeTUMiLyU1LaTHqzGPMJ3PSKnfG8uj9R0rDiGmVjzEY1PQ3SbzkQD3xnRGotDG4rkowNSwDXpSpxPB6rCdAhMXhYmAYTAW6EXouPrk/4TWWQMAm42rd7e8z+onk8E2vI5a9GIg4B1yqXGN1X9ZmQDEA7OdQi/VJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9pRRYa8PNP/LDfnxuXduAxxzR6MjSK9yTp4PsvRGQE=;
 b=mrFk/dRvk8SsmP6w2OOkEvt7ANOuimviFiK6gbeDuEZb/JhXOmmwhQkSCO1AuvTi4n9Dz4skEMfnA01PezZDJp1ScjgkFu33D5lV539fMXpFqeecMWU5ZRL6sFXONpVzah3uSZ62FVsWiHa0GX711AuK1b+6/e9W1OHPy2izR/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN8PR12MB2961.namprd12.prod.outlook.com (2603:10b6:408:65::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Wed, 23 Feb 2022 03:38:11 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 03:38:11 +0000
Date:   Wed, 23 Feb 2022 11:37:42 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 10/10] cpupower: Add "perf" option to print AMD
 P-State information
Message-ID: <YhWsBivPabbGoWr0@amd.com>
References: <20220222153426.2216974-1-ray.huang@amd.com>
 <20220222153426.2216974-11-ray.huang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222153426.2216974-11-ray.huang@amd.com>
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a47bf86-c59e-4ed1-722b-08d9f67dea47
X-MS-TrafficTypeDiagnostic: BN8PR12MB2961:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29611EED972EDF3333731328EC3C9@BN8PR12MB2961.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcThFleFVtEwlCyBf8sDKk3IHr2HH+KG+9rNxDmBArOZKI+NFSHkc+MFYgXXLCSSJps4QC3qqL4A/4x0e8nsRvEE/6NeVpBpgXTL+ADn1SxD6ONGZ2U4VP4MdnzPfuHMPtQYIAn3mKzL9iU89e4sJrjI9yKOl+/fOFuWfE8p0Vr5g4GQXWRqGNcrkpB2qvmUM+HsimiiDy88Ucjz3CIgTsqqpPsvhZZl+NpKfIfg/JXjjOyJbSThKNnR7i7E3dSHnh35JXAUEGxAt3jBr21LLsu1O7iZehtavQ5yD9V+GMKziBxvDMcOHnAvawGPEdEv1cUIjmPVqsgEy6HwnViea7Fh3mbTeSmI8fkKF4gJRPcDGTWUsB8eJDGDxhsHj9CVWgb/R2YetE+s6SxLPkdGi1bzxI9+TaOfc18QNDolvLjwyjU2g4ZMwFAFuQk2bkJdVSjzj4wBd44fPj9ACMGG8oPSylZxur42CZMro5JEid0Eka9lmORckgFoXxvUZcqj1KiL/CjwuWodw99Bjc7D87VqGoXB8p7p2ADgFzo7FLbS4Ey2g8oo6tmTMi6kaqPe5LA/ZvPveo87DLlizDbs2sKpDwSSwrzAI8p0XaM9ytP0NV4gEgra2IltYZdcPl6XCdj7l0NNuM23cYT3mNmXWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(38100700002)(2906002)(7416002)(5660300002)(8936002)(36756003)(6506007)(6666004)(66556008)(508600001)(4326008)(66946007)(66476007)(8676002)(6486002)(54906003)(26005)(110136005)(186003)(6512007)(2616005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9vlBgmLQDIWUho4JZd4w4duwT3fF8KDi3TeUV8bOV+MaWpwQ/x5Lai7MMDvZ?=
 =?us-ascii?Q?IgMYABaWUdG51aIix4QV3SkYblPWY+dHOoII4S0w6f6S5+IRD5kUmATSS+hi?=
 =?us-ascii?Q?iB5QU4m3pI9+zAAP8OsHJVyy/RN57vh1klddKCYpDX5qhmoBTMebBTXL+YWE?=
 =?us-ascii?Q?wTrFgQVP8v0trvJSdiXKwaiLCeSX5GORRoA3yoYN0/k5/Kv7YxbUZE9A9Zry?=
 =?us-ascii?Q?MpftXmwRMG/vyypt05KsfMXv8Cy8SAEZFQw9Xwivkah3juQmzcdoJAuHLJua?=
 =?us-ascii?Q?dI0tjxEDRybd9Svp9e6Mzfm9k6vUsihMXOCSzNGxoykhsF1QSb7fWXxatpup?=
 =?us-ascii?Q?fJUphSA7aaUSOomsaMhRInpIEgATWkDYRTrNB03lUjXOjZEuXFLdpAKPJR0n?=
 =?us-ascii?Q?9iMxVzql/thdZhlxTHwAylnfomCRebCa+kcHaFShUPpmdNK0f7H8wyFGMnf5?=
 =?us-ascii?Q?ae3oyW5BYK7eO9/cX2/tSQJgzkjr3uPXMmZT7rEy/3PyECX/4+3NVzk3vS9X?=
 =?us-ascii?Q?Xld31x2EnEfjGEYwk+mtqfj9CaKoLY1SFcRyFZ8p8A/n4b0+TXlSGibPksR2?=
 =?us-ascii?Q?YiievtibfnILJNEEUJTZeeF4rZGkTF9ImwrvMGGot6IkMznlYSJIg9pjxpFV?=
 =?us-ascii?Q?POfmxOjU10aq/SOz5/hXbxBhKqL+xZ1XEpH45iiBflRR9eHIYkWj6pPJ9Gwl?=
 =?us-ascii?Q?cc2hlXFS39tykKII/6k96oXfquOBJ+AfQNWJe7v3g37d57J80AhKK1/20xVo?=
 =?us-ascii?Q?R8yTegCS8OVodJM+f33DD0HLZBtCp9YXaXqCRKXHhANrdNujhjSqCcDGmK53?=
 =?us-ascii?Q?3f+wEBeIWH4NI1eJhD9Wj4v3fYp8JyAsp1jzH41c3EfV6uq9Weo6lWu2yhga?=
 =?us-ascii?Q?OyLtIn/fZ8+MmCczX2SEMVDs5qlGqOfFezGKMtfquIS4xt9y233etSVc454w?=
 =?us-ascii?Q?cb6d/ERjG0DkdSt6JQ1eydqXg9VOJuFVXxbB3+6+ZdooAyrqWIVDGsF2L0HB?=
 =?us-ascii?Q?dcoaSgZLagm9WGo30fjGXrPJomJh55XVix2JHoV8fUNGZiAFgORiiqZ87xHC?=
 =?us-ascii?Q?lSzKqAmEiwaY0JETeylvvgv3KFDitn1pSh2j5cfWYL/ZPXaDhldzd9vua+kz?=
 =?us-ascii?Q?eUsGiRFYGg/r+07f9uX+vgTaSzUU2NufomrCuXj/6sn2ZoKrV70bLEnH60jQ?=
 =?us-ascii?Q?M6YLC77ErtjNnncRr1bx/vxvRl6HYiVYZZjLlk+U0MY8o8dMCZZWJen4jY53?=
 =?us-ascii?Q?1aZ9FK2ImJQFgDxkSFuQS+RaFNeMdLitPfru6rPW+fk698kMt3uqs1/FJsY4?=
 =?us-ascii?Q?FZIgRMIRHWYzyZxFr5MhXzK8M/updXrzaTt3DgaJ4uOsEOkl7x3YSGNEvJA8?=
 =?us-ascii?Q?rQVnhLfykF1Bs3ZW9LV8Y/cV0g5UVjEGCpjXqE8uWvcUHAUPxNxWHDrDQot1?=
 =?us-ascii?Q?zNQwIuIFp6XVaEUHGvpT8cwMhUeD29KVLBn/GtBbgnFU1hV1BbXOpMyHa4/m?=
 =?us-ascii?Q?a++yt8tSHrL3aFzHeoi1NmZZYaYRYkd+z+DyFsTB3zd8ooxa1ANdc9gKTSce?=
 =?us-ascii?Q?IE3ARJQjdMNlAgfpuYrckwa8ItCgcz78WTNXe4n/JlCBJUzi351IXrzKT0Vr?=
 =?us-ascii?Q?W6/+Ug60VSk+uGwepN1ZLKY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a47bf86-c59e-4ed1-722b-08d9f67dea47
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 03:38:11.4343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6wWpn3MfToTOZBsQiWhugeHIIoGk4j5RjvDy/fz0GlDSSIKCfgdXuqQ19bAgz05GVTOmuqi8XLiDEbMWZDPLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2961
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:34:26PM +0800, Huang, Ray wrote:
> Add "-r --perf" option in cpupower-frequency-info to get the performance

Thanks Shuah! There is one typo ("-r --perf" --> "-c --perf") here. Because
"r" is occupied by option character. Would you mind to correct it in the
commit log?

Best Regards,
Ray
