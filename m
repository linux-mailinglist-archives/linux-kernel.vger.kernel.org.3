Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8C04B550B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355949AbiBNPle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:41:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355221AbiBNPlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:41:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E26BCA7;
        Mon, 14 Feb 2022 07:41:24 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EDvxBo018194;
        Mon, 14 Feb 2022 15:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Gk0CPVfDLOuTqkEqeB7pGE38ooOMfwUSDoYfVyDb460=;
 b=niy2H9k/r4st4+B6i0T/hjS8yTb9MqzOneCpF+yjUk69KOGiVxMrUCmAq509y/UYY3ex
 viG3+p3X/nER2YKlyU0b3c2BM7qeaJ54igrAvqkz7mD+fi7PaHeX7q8d8JF3s6r04PtK
 c0oPZ+SyuVPhop+nIHBGPdtwJ1nd5IL5i4HeYi7XPnPdZvzIy1UvaT6KXVeEl0NRqtE/
 G9YATshttnIDUDZHq2yX1BIkr0H/fP6lhsYJyzXpu/nVTnGpCTRpBCyl9Nyb8Dc5MtZg
 E+wcfOEqzLJDSAAZmNcWh7YL4E8M3BtZY5GOUNoIgBV6r8pYjSHVnshdab5IToAEy1Wy mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e65eucs9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 15:40:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EFeUBR069227;
        Mon, 14 Feb 2022 15:40:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3e620w61f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 15:40:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHgBaxfcns2xXzyuN0PCZMt/IxqXu48CSZHDyhYv7Du4u0MDyYNgNeRh7CM0mZb8N9yo03axUkeW4hpPvJ3XJIXtFiMZUUgjueYtUBcFctLDw+u+1/pDNf0Xnv1u1hlokCSFYGDyYZdegJ2+9sMAwSQ+A4JTSME8ibiznOhrLJ8HKxwnE1GPiXAo77tiAkvR2uYkuByWeyil3pHUqKHnuOrVW92InarFIiQCjO3zRJgoA+GR+q9p2oDGL+QVzky5pgZJp3chUfAZXIDku6Fo8DQ3obUPoRIMmctHsIyrRP+H1LOkdWF+9pP9E1Vvaq4iM5VPeLwVPgV4S0RByMsvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk0CPVfDLOuTqkEqeB7pGE38ooOMfwUSDoYfVyDb460=;
 b=jdx8IICsT2eAKcE/yWaWBzpuc/UJNFPPux9Qv147TCZpZuxPTYjZnO/x5DI8dBuKg0MJDDLlBmrj5V9ATEQcPWP3tEvzY9//FI2jf5ZXvvW+qsN6+3/qPmNouGRWA3GGNMu2l1dOjYXRIbKrm2Evk1TzkLryfmnG9uajJubbBkedJVQrCwQ2SygOOoEWHL/VhHxe1yIuH4JF6aRk7jZD06cVvXErZvZ4BlgWRK7YbKHiSdqID4i+X47JK4MTYFiIC1+9s05HrqT6gOjhZs7UqT+7rso2HJvf7FxjHlT2uCFbVZ2HhNUgkjoBIWdpVWUXWS33r1Tvu0bRENfD14FDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk0CPVfDLOuTqkEqeB7pGE38ooOMfwUSDoYfVyDb460=;
 b=LiwoC66iRVATUVsD9Z3/UYa7Aow89BeWf5uiBs33Csz64x9x7fl+axbyosIFe+ebOm+9+URgwmz8yXso2y0tCaCC9VZ7qcbAl3IAyMSUqQBmOLf3GATP+wZEu6ccsiUApS6VC9Zaj+6fRGL/nZ5NBVB9qjVlln57lNdn5l5HT/Q=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 15:40:48 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::a1ca:a394:7333:2aca]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::a1ca:a394:7333:2aca%3]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 15:40:48 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     mcgrof@kernel.org, masahiroy@kernel.org, jolsa@kernel.org,
        rostedt@goodmis.org, bas@baslab.org, tglozar@gmail.com,
        Ast-x64@protonmail.com, viktor.malik@gmail.com, dxu@dxuuu.xyz,
        acme@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
        irogers@google.com, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PATCH v8] kallsyms: new /proc/kallmodsyms with builtin modules
References: <20220208184309.148192-1-nick.alcock@oracle.com>
        <YgblCSWH3g0+uy48@krava>
Emacs:  because idle RAM is the Devil's playground.
Date:   Mon, 14 Feb 2022 15:40:39 +0000
In-Reply-To: <YgblCSWH3g0+uy48@krava> (Jiri Olsa's message of "Fri, 11 Feb
        2022 23:36:57 +0100")
Message-ID: <87leydpibs.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0155.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::16) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f270c44-1dd2-4dc8-03e7-08d9efd05f3c
X-MS-TrafficTypeDiagnostic: SN6PR10MB2943:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB29437A4224C5E9AFFEAE07378B339@SN6PR10MB2943.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+QV5TiU99j/oj/wcPbeymrM547KWHIbVjrC4bwaUPP38+AgODKd3sErgTjeZkZ2400CJnvKaR3JiOHEIzk81swNGqOAiD+DwF27LKJ208Go8K8NA8zrFFHZwYL9OZmMYm0KvWWWGqiI1x3s3kdGL1mqpHiiKdEpzygKcm7TM8ger/8D996Nv7KWpwwHzq+7TW1YEUyd3oEerN6FiXvr0be3iodwhthbdvT7FGYbNjHh9a0/YOggLMYWehr0lGdn93tfHCZcdkPxpK8KKWVQO0ikdrZy6OjmddIHUL50whLzIxN6CuwO74qLuhH6rx3xNMDVPIqVClhxQJKcyR15xtR44F34r4xnmAE4jwp4WSHwiLR6reRyeOE2/SdCMSPzeGPSsJoM6KIfAVpcp0IcdYp2lfz5FMxNWfwCT5+xgTn7nS52TVaeH6TmB0OU2DwNvomgpwussl670ElAdMLE/g84SzQptFzYtrFYioxa9uevQvLxLCPN9Vg6wMtE1DVTqr5xbdq3QZdkSfSgtoDxYOrTAc2jq7B++0m8VKQCG39x3IF2Sne2iLz0sNgmqnVmbyXNbJ3HDGA9NPvnTzSDmJRZVmu33z4vF0CtJ91INUYRkck0uo4tSrtjr6fEcKqSN+3FdN8XQUP1XVgd+eLQxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(86362001)(9686003)(6512007)(7416002)(5660300002)(8936002)(44832011)(83380400001)(52116002)(6506007)(8676002)(508600001)(66556008)(6916009)(6486002)(66476007)(4326008)(36756003)(66946007)(316002)(38100700002)(186003)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eO7ieGH5hmg5tkCohhJjXTaBeefQOSPebK2X9nHOXZ29KPNBbcsN2LTngxkK?=
 =?us-ascii?Q?L679S9IUIE7YCjr73rQ5B4MbBkH6ziR6YUPI/0Bfdsw3wonR2OCzk4zfrhT5?=
 =?us-ascii?Q?OsqC0rKXjeEMrusGx5s8VzjZKy8RwslFuPFeNWREPNSz7BdwuUok82wntRPG?=
 =?us-ascii?Q?swwg+MyWUBFs8TkpQo73ZCcHMnf9aSs1TsQqhPRuiJmTqjLABhfgOsRm8EJm?=
 =?us-ascii?Q?T9G/bqj0iaESy+NP71+MYjrRB0Bw9gGU/A3bcGH4B0hL9/SKnaN6HgFsWgo8?=
 =?us-ascii?Q?AXTYWBQKydlLuF6wLyyewiWX8Eug2KysaCelp+tLPVz78rqswKPJKlw5SkIN?=
 =?us-ascii?Q?17iXQKclITzV9703Awk+iNnk1aVU7szDUFHcu39ansI3UG4eg/3Xise5aPe2?=
 =?us-ascii?Q?XZzEILn4rJwN0O1Coi50l+h36nkQX7BtUufDffQXgj54MKccmRA17Qs+QPYt?=
 =?us-ascii?Q?izSSb1TYYTR3n1HZLr8sMyrkzSrkx5p51zTvrkfN/Fm85tDs8uQ4NUIdOP1/?=
 =?us-ascii?Q?8FNBEwZ5nY+gKDdONudzr8q3/mY3nxHbxB/sZvOgJYvt7Od9sAlBFw7kSFhG?=
 =?us-ascii?Q?yVWaVl6+hVmzpH2EPllosJlH83sIvCRye/C0Gm4yg09ZG8y73bgWAk9InHXW?=
 =?us-ascii?Q?kClmqfRWQG341dCWY5veFo53EOTqv+Fir5sX4EPomY8blL1VIxXqREOOcCBd?=
 =?us-ascii?Q?OwZUHS4NJGxPh+WeXkUCN7/AqEft20NYGGGlhkOXQK+yM9TcY/myKZnU4AG9?=
 =?us-ascii?Q?94Yqz92WeSXq3q8XXa35m3nkRnYy/nvX/+nzi2UdshzFd++NvWE3hDdxcRA5?=
 =?us-ascii?Q?YzpnQKU0li4sJexUKTVJt1pjUSrZMSX5LL7gxLFDjm9nADbRdJmpDDa1J4BS?=
 =?us-ascii?Q?2GabPNfmWA21DpNVk3VCd0p9RF8ko1KcDou0vtBJsoT3K24mQkYVYSrR8Y4G?=
 =?us-ascii?Q?tqcMwd3W5TgTkans8J3uq/UZZSJMtZDD4+wKL6QFzsIn3TpiyhovNjQWbIsu?=
 =?us-ascii?Q?38bhAnc6j7eyhE0l3cuHd/69+AAtZW7ijBtbfXgCqkLvqPIJ3RKQjdymJwdd?=
 =?us-ascii?Q?V3QeFePrbbc2xRXqWrB/ly4841sBtDBZZv7JloERIPfsgYb4iZAy7aNIr0/F?=
 =?us-ascii?Q?6znn0WyWT3lzDxQ9OCSDV6ZkoI5GUowK7D7Aiz5E35xRv5/ISbbIfVtwy1MC?=
 =?us-ascii?Q?3jVpc1wCFxtLZmdRazNjBTKv/oNA/bAaiF9apPR6l/OPw67JDuOtiEfSKry0?=
 =?us-ascii?Q?Ny4j+VOIdJ76mnB9lw2bfOEvy9MaWs607Oa5pF2XZDXNQyDdyBpAkdT0GkO1?=
 =?us-ascii?Q?37RrqqUF9YKz938/zTAcvx5UO01YxqwcZI4fjb1XDpqDY0yojePwaN5eUfEi?=
 =?us-ascii?Q?pW7oRwtj5qJlC2yzu2mQrAMM/zkfVDBCAbmAnZFWi81AN9ztTBwMCYtzJRy0?=
 =?us-ascii?Q?/Uq6nocv98LMeVV0Vl/rXJLak+uPjCnMvmXj7QA7rDJyTjByIz+mGxRODxge?=
 =?us-ascii?Q?y6My/oX5DRPuynTVANKf8eHld+UVDkABIt2pyM0g0fuDTwISOnSFff/j1ChH?=
 =?us-ascii?Q?0HksJFQu08u/TiDpBTz5YLGlz1U021ORsS0iYYfn5lC7B77GISYMay5Ut2nB?=
 =?us-ascii?Q?lQo3+9vYwFMpBBxbH6CYx2uLbjXfeqye47//ocBmplhJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f270c44-1dd2-4dc8-03e7-08d9efd05f3c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 15:40:48.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8QPNb1wdxgGreaOYezl1ZtYJYSyNx+L6NWb3fFaiVA9d0GXa/FkX4WG3+WiyPJzvAbznYI4STDD7LcsrFGN+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2943
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=660 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140095
X-Proofpoint-ORIG-GUID: l0q1KNcQYqlLVt1prUBQsWR9E1GUGbib
X-Proofpoint-GUID: l0q1KNcQYqlLVt1prUBQsWR9E1GUGbib
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Feb 2022, Jiri Olsa verbalised:
> On Tue, Feb 08, 2022 at 06:43:03PM +0000, Nick Alcock wrote:
>> This is all controlled by a new config parameter CONFIG_KALLMODSYMS, which when
>> set results in output in /proc/kallmodsyms that looks like this:
>> 
>> ffffffff8b013d20 409 t pt_buffer_setup_aux
>> ffffffff8b014130 11f T intel_pt_interrupt
>> ffffffff8b014250 2d T cpu_emergency_stop_pt
>> ffffffff8b014280 13a t rapl_pmu_event_init      [intel_rapl_perf]
>> ffffffff8b0143c0 bb t rapl_event_update [intel_rapl_perf]
>> ffffffff8b014480 10 t rapl_pmu_event_read       [intel_rapl_perf]
>> ffffffff8b014490 a3 t rapl_cpu_offline  [intel_rapl_perf]
>> ffffffff8b014540 24 t __rapl_event_show [intel_rapl_perf]
>> ffffffff8b014570 f2 t rapl_pmu_event_stop       [intel_rapl_perf]
>
> hi,
> I tried this version and can't see the symbols size
>
> [root@qemu jolsa]# cat /proc/kallmodsyms | grep ksys_ | head -5
> ffffffff81094720 T ksys_ioperm
> ffffffff81141110 T ksys_unshare
> ffffffff81160410 T ksys_setsid
> ffffffff811c64b0 T ksys_sync_helper
> ffffffff813213c0 T ksys_fadvise64_64

UGH, sorry, I should have regenerated the output in the cover letter!
The cover letter is buggy :)

This is entirely expected because I dropped the symbol size patch
(because it's formally unnecessary because you can do it from userspace
by examination of vmlinux or the .ko files, and the symbol size
representation is big, adding hundreds of KiB to the kernel image).
And then I failed to regenerate the output to show this :/

In this series, /proc/kallmodsyms now looks identical in format to
/proc/kallsyms, except that you can have [multiple] [modules] on a line
and the meaning of a [module] entry is different. (This may be a small
enough change in semantics that merging the two is possible, but I doubt
it -- existing users will surely expect that a [module] entry means that
module.ko exists, which with /proc/kallmodsyms is not always true.)

-- 
NULL && (void)
