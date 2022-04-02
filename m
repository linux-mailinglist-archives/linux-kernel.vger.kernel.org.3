Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BBE4F03FE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356551AbiDBOhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356543AbiDBOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:37:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455DF173B06
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmjoVk0opOSGQKaSnwKIV9PA0JHekDKiAYC4kauqQgG1EE9voIMHh626j2W0/YQ924HgT+Qo+8f0Q0wug8UideCVkmc1d1pukPox4xfl3g4Z3ljyh8zJDHauqjdhlNw0ADx5mzOK+de14MRpRgM0JhSoanfUYLH0TbtpxJuFjr1nkC4CnLCAGBZIoYiY9JqoSUZV+eYAJEIm4Hu37iNqFPdXzb+6sEHWDileNol6n3refvx41/6h7U+zw5N1vfL9yEYYDmNdcph1cKkA1ANrhV+7w0Cg0OdtDBr7bsY7ckaS0R+5/bQ1rgQ/gcNfdnqHZjHU8nL55F0Hz4RbfevSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37+5hF1+S8NUp/KUFf5xNUQJQ7EvNx1ENoejRSmTEIQ=;
 b=nkseEIYOlGEzlbAkKa2TbEw7HAhhgwlfJy/O/noUztI/c+15Ta2HT/mRXsknxUTV/1PoJ8ZVAk3fvnO0oa1yC1IqMk2SQCuzkRGpvHMFQo+l7U54HsYsKrcv+IraF1TgRWi/YDR17GhVLX013r6Yk7t719VAGa9VvnWCwnsekEchP6IDB9WazLZizfvI7jEZNfuB8bcmgkSWSaO6xxhULaV7S/4CMhnBvXUndKH7PcNFXXo1HqS/dXcT02+olQEGd4Jcls7v7oTHktEa9VOyiUgpTzthyTRYJyC7Vb53UhHUxir1fdo8a12BgoPtSf4LzlRVPAg9xyj6rnQ76PWGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37+5hF1+S8NUp/KUFf5xNUQJQ7EvNx1ENoejRSmTEIQ=;
 b=Det58Jo/EhJFyNHpWcLHV0K/ni2C0/8IOLc6goUEK9QsnKHkgvLsDwnrarUCNRvA7EgI5larV51ILpQeAflWToAOsd055CFsySVWtHImDSK91KdXrkRP+nW+aIJaRfs8q23fJM2XebS9Q8PJ88EMTGtfsuJjujIZToIeKgIJC94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM5PR12MB1289.namprd12.prod.outlook.com (2603:10b6:3:79::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Sat, 2 Apr
 2022 14:35:26 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::7446:3a0f:f807:f5b2]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::7446:3a0f:f807:f5b2%6]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 14:35:22 +0000
Message-ID: <c8ddd124-1d83-fa13-eaf9-be5c2328943f@amd.com>
Date:   Sat, 2 Apr 2022 20:05:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2][RFC] sched/fair: Change SIS_PROP to search idle CPU
 based on sum of util_avg
Content-Language: en-US
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Aubrey Li <aubrey.li@intel.com>
References: <20220310005228.11737-1-yu.c.chen@intel.com>
 <50315795-c2cf-fc1a-6698-752b0c26cb96@amd.com>
 <20220316115418.GA20589@chenyu5-mobl1>
 <9191110a-daf9-0520-a47a-801fa3f744d8@amd.com>
In-Reply-To: <9191110a-daf9-0520-a47a-801fa3f744d8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR0101CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::22) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a72ad1-12d5-435f-7e53-08da14b604b8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1289:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1289B31DDE0CA680A6B9471998E39@DM5PR12MB1289.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3WlJlRviCSRTlruknb2kAZhXOLJFXJDhfIDyGeRkV0aVBEQxT0zzoRYrF/btj5Q3nuPUnfh0WFUJwWJ5wQWSwc52duX+CMlM+mk/tdauy7zNQSnUzyn2AHBC1H8V3Vek1NhZPlfBEBmW44hsSTCvfOlq1v8uqn2Vo5uAnzZuGuZZTULSTfSTAV5IPiTi4WDZxwrkE89orLQQ9bsjRqy8m+RUBCGhtGScXH9SXXb0wNV1kG5Liv7J+ODFAPKd9PPz6nRMbS2ZWiEJxotWiz+q6uUw6M5MzIy4mDSlw+QkP0FhIBIfvL4So9452dFzQtSv+CIhnFf1R2kl6zpn4TynhAsJGgOMuiF6tnOPADwg2OsLpbbcXh21eJFURcs8GGF86FycNA0+RRz75d32Jde08GbbjTv+pUaevh1v3qGs8suaqs26Pjvt17AlXJ28n6SFEZxsuL04Zki/Oo7x5GHxdoOAwiIosPoOMGMDyBaAh9qKp/RK5+OwObYJlgryIdP+/J/a331MthmKYNovS9/0grcPLPUEcZ5QL6kiTasQCzlaEBQW9XXuqsoNRwkfib/dSk0N2GF2geXltbGFlmDiZsZVFoTYe5k98E/H3xvKOwwdCWhJSi3aTlEGKb8VtChgHP89SkNPvuqyz5I258vg4fhjy1aDnutTytkhtJyt7hhH3fw64nTY+BUFzcG803mCKSB6WWd1N2g0charQ8oE8F7S3EIXFwLY8LD/6BgKls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(53546011)(186003)(6916009)(6512007)(26005)(6506007)(38100700002)(6666004)(508600001)(54906003)(2616005)(86362001)(36756003)(66556008)(2906002)(31686004)(31696002)(7416002)(66476007)(4326008)(66946007)(316002)(8676002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVGVUFYRjE1bHpFNW9zUi9rb3E1cGVSd2Zrc1c3VjEvcDJ3TExpeGxUZjhE?=
 =?utf-8?B?K1ZGVnoweVk1S2NFQXorWGNuQVhGNjVHaUxldnREYzJYVVZvdENUd2c4SnhC?=
 =?utf-8?B?TWJKRkZBMit1Yi81bmxRZzlpRXM2YWVXZkJ4MUM1MGpIYVd5OC83bXBreFlC?=
 =?utf-8?B?K096S2U5NVNySGVXaTFTdmszS0ZReGw3VmE3d0s3Y0FEK0hlOVB4dk4yMUlZ?=
 =?utf-8?B?UHpmdmtEdFV0bDQxOHRXVzhnc1ZyWGdYdVVGM1hkRzdoQnZ2WS9BY0NEdHMy?=
 =?utf-8?B?OVE0K2hGTzF3ZjBtUHRQY2l2Z3cyczB0OEo5SHlzZnozcDVSVXRPUXFoRE1B?=
 =?utf-8?B?WTBiS1ptT09sSi9DcSs0UnBJRkk0L05WVTQ3WSswZngrY1E0citCcWlxc0JT?=
 =?utf-8?B?d21xV1hSdnpETTN2VEYrWHdaaXFUdWFhWldKY3p3Tm9YTkhJOGVyU0tNRndH?=
 =?utf-8?B?T2tUMnFiSHV2UXRBVVAxamZ2ZzAwWkE4MkwySG14ajc4TElQQzVwc0syOERq?=
 =?utf-8?B?VzZBWnJDRHBEQkRCc1UvVTFnS0h4VE8xdjBlT0ZGdUt4Tm4wQmlENzI1WE0r?=
 =?utf-8?B?R0xUQTFHNlhpMHBxbkYvZ0NBczhnUk1idnd0OUFycVN4TVJlSHpSbzFwNkhz?=
 =?utf-8?B?Y29uVDYvTTJQbkVJWWFPa3lpYzdQbm94WFJ3NEhhWUZNemQ0REYzZksyUHZq?=
 =?utf-8?B?ektWc3JnZndiYmJvNjUwWHlVMVVveVMvZVp0L1RvOWwvbDlVTTF2TFJDZ0N3?=
 =?utf-8?B?eTBNWWlPZzN1aHhGRUdiN0dCM3NtZVNrTDNhNHZIYUQzYU1Vd0FrRjB1RlFD?=
 =?utf-8?B?VTA5Y3VLZkJ0N3BNSUhOVDMvT3VndzZXSkw5WHJBY243aHdSSzVDeFFYMWlp?=
 =?utf-8?B?TVV6bmY4cS81QnpFZGloN05MNEo4VUEvaG9FcldVMmxQRDdERFVzY3IyM3p5?=
 =?utf-8?B?MWs3NzhrMGozQjlGWlA1Z3VmcHdieTVnQWhMVXhkL00rQm0yYzVpM0J6dXYr?=
 =?utf-8?B?cXZyTThjdjJhUFJLOCs2bFA4VXllZUI1MVRmMTc0TGs3TiszYlp0bFhjdU9L?=
 =?utf-8?B?WlFYdW0vc25QMjRPbFhla3dIUmdKRnByaGE3RDNZRzF1dFM1aHJRVkNtM1ph?=
 =?utf-8?B?ZzJXL1dOdzRzZFJsU3RPQlJSaXBsZFkwYTQyV090R1E3b1FlZ3BlYktka3pF?=
 =?utf-8?B?eGFRWU1aWDhKQXlnRHgzVm55VlVXb1UxMmliREtBVzR4ZjlRd21YRFF6SWRn?=
 =?utf-8?B?VjNCQzZIbWdRWklkWTlJamcyM3NxTWJPdzFacEU0dWk0WitzVUdJTkxScmlB?=
 =?utf-8?B?T2xCRDRWT29GTW5WMkFCbHZTTlF2QmNYQ3FCOGNVaXIzbnNYQjNDUHVmb1Ux?=
 =?utf-8?B?UXVSaFJQVnN3RVZrUGdVR25FMUlhOGhmbDlJNnJLVkIxNVRpblRQRStDQWNI?=
 =?utf-8?B?b1AvR2RQbEdCTVliUGtpVXMya04rRkVJWUJ3WCtRTmVLdDdGa1NrdDhCZFRN?=
 =?utf-8?B?cVNuK3I1RkJidDBkc1VUcE1FK1ZaUFpSM21rUzNMN0NXTUZtV1hZUkdrSHZy?=
 =?utf-8?B?bU1FWXQ4NDQ4c24vVFljSm5OaHFXZml2Q3M0R2U5L3VROXpCSndXUzFPWkdL?=
 =?utf-8?B?dVdMNFNwN0p5bzNENk1TWitYZFNraU9aTWhSRkNGMnBkQ3FTOG9aN3hPS2Ry?=
 =?utf-8?B?eEcyTHo3VGRrSlNGTmt6aWZFeDBiN1NxdHJvTkpvVnhNdEduQU9qazFKU0dJ?=
 =?utf-8?B?Nkk1MzRBOEg5cWZHbXRrSFgvMmtNdk1FQTdoaW1BL2ZQbXpUVnM0NytKcFZK?=
 =?utf-8?B?aE5SZmdHYjI5YWhjZUo1UVFnMzZBUml6WGNUeUl5OS9zWFl5WmZ6S2l0Tm81?=
 =?utf-8?B?TERvS2xIcG1qbmJvSEtDaHliVkdHQjgvVkVESTBYQk1RY0tHMFhPdFJxS0pI?=
 =?utf-8?B?MGpiMkdacm9CWmpWaXlXMzlUKzdBQWY5QlZLZ2VvcHM3cnlVeWNmQ0Q1OTIr?=
 =?utf-8?B?SmFlYnh5cnpBVlBHOWtEMlA1NlYxRzRPSmFJcE42RmdiNVRZMWNkcUg3a1B2?=
 =?utf-8?B?TUlnZmhhOW1xNFY1akd1WXNjdDJKNVlhY0tvVmdWY29DdUhIc1ozTzRyUkRC?=
 =?utf-8?B?dVEycC9pT3hQMXhWVDM4L0szWWdBN1dEaTBvbjVDUHZ2RDZQeDhtUUFPVnRD?=
 =?utf-8?B?ZkxyTW5kR0tvdEExZmo5N2oyT3lOWXpCam45OEFHcWUwbm9kVkF2aTh5c3Az?=
 =?utf-8?B?c1lQMlhzYjFkUXFacXlhLy9KWUNvdVVNOWdQeFFra0Rld3pWNDdDTW41YjNv?=
 =?utf-8?B?LzNYaGw3ODdrWnpFanBlcjMyaDdhSmwvVUEvZ1JVckdScUgxUWg5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a72ad1-12d5-435f-7e53-08da14b604b8
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2022 14:35:22.6837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdsYVD3NGvobfrG8FunXimoSsp0tmYJkbVTnMrQaKtt/zclT5fCRKwxnygH1GpcGic+TLnNrVskIDrTFFCwQJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1289
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 3/17/2022 4:09 PM, K Prateek Nayak wrote:
>> May I know the average CPU utilization of this benchmark?
> I don't have this data at hand. I'll get back to you soon with the data.

This is the output of vmstat captured every minute during the runtime of the benchmark:

procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
  0  0      0 524179712  47956 623328    0    0    18     1   95   70  0  1 99  0  0
  0  0      0 524583488   6984 296760    0    0   869    32  765  613  0  0 100  0  0
  2  0      0 519057408  10840 413092    0    0  1413    97 40022 245964  2  1 98  0  0
 13  0      0 515806048  11036 1560292    0    0     1 15861 47291 481310  3  1 95  0  0
  0  0      0 519494240  11844 2073552    0    0    27 11934 7397 70297  1  0 99  0  0
 49  1      0 508753216  12064 4519468    0    0    22 82723 160775 1219361 11  5 84  0  0
 51  1      0 508787424  12188 4686136    0    0     3 177661 199218 1522425 13  5 81  0  0
 51  0      0 508717088  12464 5102900    0    0     8 172393 215555 1526566 14  6 81  0  0
 54  0      0 508974208  12584 5133116    0    0     0 196022 194294 1520359 14  5 81  0  0
 49  0      0 509171712  12720 5133420    0    0     1 189473 181195 1520990 14  5 81  0  0
 65  2      0 509624672  12820 5172400    0    0     0 192406 190311 1516981 14  5 80  0  0
 50  1      0 510052864  14228 5231312    0    0   886 173806 236733 1491140 14  6 80  0  0
 50  1      0 510455904  14340 5231412    0    0     0 191996 252078 1479435 14  6 80  0  0
 51  0      0 510845184  14464 5231436    0    0     0 191033 251433 1480865 14  6 80  0  0
 54  0      0 511137472  15128 5247844    0    0    12 198460 254401 1485615 14  6 80  0  0
 54  0      0 511242816  15240 5247868    0    0     0 205262 255299 1483994 14  6 80  0  0
  0  0      0 524682656   6488 302624    0    0   596 64012 55117 315385  3  1 96  0  0
 11  0      0 523307136  10096 350728    0    0   788    89 3350 30092  0  0 100  0  0
  9  0      0 516713440  10276 1222368    0    0     2  8941 51751 497130  3  1 95  0  0
  0  0      0 519524608  10428 2009192    0    0     8 18969 29798 277747  2  1 97  0  0
 50  0      0 510469184  10608 4463716    0    0    15 72376 99893 592582  6  2 92  0  0
 50  1      0 510225728  10760 4954988    0    0     3 175225 223641 1531010 13  5 81  0  0
 49  0      0 510185376  10856 4955084    0    0     0 167856 208568 1541377 13  5 81  0  0
 51  1      0 510101696  10964 5058408    0    0     0 185400 216839 1534992 13  5 81  0  0
 56  0      0 509908448  11084 5058524    0    0     0 184871 240666 1478386 14  6 81  0  0
 57  0      0 509593088  11188 5058624    0    0     0 174319 257078 1472289 14  6 80  0  0
 46  0      0 509449280  11320 5120364    0    0     0 199695 246095 1484076 14  6 81  0  0
 47  0      0 509569120  11440 5120504    0    0     0 195409 246954 1486632 14  6 81  0  0
 51  1      0 509394240  11564 5120640    0    0     0 187739 235864 1487453 14  5 81  0  0
 46  1      0 509165184  11668 5137480    0    0     0 190097 225997 1510812 14  5 81  0  0
 83  1      0 509214944  11788 5137564    0    0     0 185712 232513 1524289 14  5 81  0  0
  0  0      0 524685792   3940 268116    0    0    48 153174 152934 966090  9  3 88  0  0
  0  0      0 524574880   6560 317068    0    0   703    82  193  342  0  0 100  0  0
 11  0      0 515208960   8380 877736    0    0   606  8627 31043 324947  2  1 97  0  0
  1  0      0 519673440   9196 1845944    0    0    20 13871 41874 470542  3  1 96  0  0
 56  0      0 513421280   9328 2819588    0    0    13  6776 21005 106752  1  0 98  0  0
46  0      0 509829408   9520 4192212    0    0     4 157023 199117 1512516 13  5 82  0  0
49  1      0 509403200  10084 4596844    0    0    22 175970 205070 1512552 13  5 81  0  0
50  0      0 508933536  10220 4828368    0    0     0 180676 224455 1512344 14  6 81  0  0
47  0      0 508529472  10364 4940972    0    0     1 196158 250799 1502868 14  6 80  0  0
58  0      0 508565344  10476 4941012    0    0     0 194334 256721 1502510 14  6 80  0  0
50  0      0 508594176  10596 4941144    0    0     0 182299 257354 1501533 14  6 80  0  0
57  1      0 508721088  10700 4965532    0    0     0 186060 255378 1501167 14  6 80  0  0
49  0      0 508646144  10824 4965644    0    0     0 191029 257866 1500889 14  6 80  0  0
49  0      0 508739136  10920 4965672    0    0     0 182014 260923 1504201 14  6 80  0  0
50  0      0 509059616  11032 4974112    0    0     0 195981 260905 1503577 14  6 80  0  0
 0  1      0 516111104  11152 4975472    0    0     0 190756 186797 1452580 13  5 82  0  0
 0  0      0 519977088  17876 4985004    0    0   177 18948  747  650  0  0 100  0  0

If there is any specific monitoring program you would like me to run, please let me know.

--

Thanks and Regards,
Prateek
