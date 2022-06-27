Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0831355B606
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiF0ESc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 00:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF0ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 00:18:29 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354602DE5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 21:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtZdODcZ8MyizUbDECL/meCvR4ryNmIH8WYBvar6nV5I9+2UUGAFXOPDypPGKMaIbNmO5rTipPeFRhDt2BWky9qJmP6UYkvY2MEC+XLmjQ+WxapNmNRqfqkv7Qr1QNKmkCOeQIPqmurG/ptfQyfZ55/VYXGE8Ic4rr8itNFDz6QucbKcyl7uzO3TdFjbcOZ92K7DqqJyGfa/mSjffPF+4yDKMbFa2jO4nY+xK5VU2zVnZcFGDaZIDEqpuY0XUWTWB8RvHAwJpExpN2LGSFM8TZlgLZU2xOCzz0Uwq7wK6ALNw6mkqKCUpHrHBm5dGBC0HWbc8DVdidkTnIkdJrRboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3bSlYNezZ/V3s5KFnG5kep5QwlIAAsP/NfYZM1eLvY=;
 b=eGiswYhe0akAHU5NtTTIRXhcfve5+XVsQBlXBf1EadNp+8W/6+qTGYbusRpWd1HJ/kWVDvz1RPMrokpvv4dvXcH3AZ+IpUIb+64poOPUV4xOqPw5Lt0ptO2EFtFHIniU14L2nNKcc8yoT7OJvmUzHnw2QlWRVmA7muko+yR2iN0ra+3hTrz5V57nuKvev57h3LSOidBRUReHi25xS3OmeT4vPrFks3lwXDVjeP2pcKW/dmMTLA23ck0bVS5Ad4YCXSEzV1P5tYjd+lgQ/0GPU7pRVmqfK5YO+Bb+7h+ssCN/MR95U/qHfrtmo+WtO66rAC8SJ8W0CQN/jUj210n7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3bSlYNezZ/V3s5KFnG5kep5QwlIAAsP/NfYZM1eLvY=;
 b=Phvuj1ZapsrweOWMAJPdyFNlFtbFFpFkFNQUYJA1QqJyW0hVrhHRiVFhLjCa6RIZAdNal3PsrbHnrbl8/e6gAEXRrB+UWymkoQXTRx5BRvQRPx09rx9c2ks980cpUfdf4N9YE1ibV5bTTZgq2pjYHVgc7Okj/cPiVgSFAS0OYEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4026.namprd12.prod.outlook.com (2603:10b6:5:1cc::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 04:18:26 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9%3]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 04:18:26 +0000
Message-ID: <3492774b-a462-d8e6-34bf-9f5ea10729d4@amd.com>
Date:   Mon, 27 Jun 2022 09:48:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC v2] perf: Rewrite core context handling
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4008071c-5643-4e78-5a24-08da57f414b8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4026:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsYsw8aoO9M9ivhy67dl4LrL42QjDXaAJBVGc8pJDnC5g4U0fIvPRgzlhklB34XmRL2PmKd+zTmV9f3e8RJFuKxJNmoA3IBr25t20clld0XVWw69gtMVZn4RNnMjmTPUTpTZ3iYdAxrBlIVdLvCzfgCz6RtMxA+QVn4pRKRj2dSPFOmWTseTfxgRQ1vB8LAC8dt2zjHzuxUTnnfoOss3Ir7vCIybvOM3kLtWPYrKW8lNXIkpKya3T/rFd5gkO0h6Jg3hO+FPhpyDy3xfGkjOdReO82YHdrpZsFda1+93NFVokLy2EIRUle3bY4dEv7p9NMHVBV8+LxeDBOadml0hlFtUa9n5XZW1dT1zXWeD636DNbARZvODvZxvIv+tH7OPU/k41A5cOBusvVpINwy1wjIhMfRmudzRzatfPWwPkWbxG+Yyqg0luK023x94gR4pf6icPkg+v9yl9mDJXYAG6ehdh6DVbnXbIP5D2xaYOrTKHZDRDJg6stWrmtNE0Js/cJKblTeuNxe0CGmhchULkOP93AuetYEwzFGcDsl7edFIW3ibjE2FB0XisFBePd+3iT6zAykGdNaBlO44ZS6yz8D9b09IAzuKCnoaN44582NsKQORrZ5RdCjabdNgqnvSQ3iikPhqh2hhl1jeNKLJw/aVru/cyiNJCop2FD5GII11IpFBHK6Kfvs2aTU0hPtgYB1EMOf9ZiNMmra5IbhH6MFX6X3/ZKcxS8zykqipNbj0IXgqgVWU4C3DvvIemnTD2JNYQ/nBpLAJFPpnsScpMaQidt/8/5A3Mmh+YQlwZ3wduzFXFVehPJBjjv8dQDFg8dKw+Y2zaV3Hd5px+5JBiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(4744005)(7416002)(44832011)(6666004)(31696002)(38100700002)(2906002)(316002)(186003)(4326008)(8936002)(41300700001)(8676002)(5660300002)(478600001)(66476007)(86362001)(6486002)(6506007)(36756003)(2616005)(53546011)(66556008)(6916009)(6512007)(66946007)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBjM05jWERHWEVOdGpjNzdkWkwySmNpSC9HQVllY0dTV0VTUGN3aFY2MTA5?=
 =?utf-8?B?amdyL1VSNVlvbmlvaEdzanlYaGdNaVQ2S1N0SmxCbGs4NFloa1pQUjIrRFJr?=
 =?utf-8?B?ZCsxV0VlY1dFSVZYcHlKMG15bnRSSmhWdnlwNmZIaFlXVDVYUDNVOTZNakVQ?=
 =?utf-8?B?TStvZU9oUlBVMUVqRUJNM2p3Uk9zYTVwa2RZK0F5eGNpYTBXN2RqUnYweXZS?=
 =?utf-8?B?Z1B4ZXNUQnRUSDc3TVFEem9xYnozUFlueVA0YzJPeGIxd1RKa0Qyc2dic3hL?=
 =?utf-8?B?emNKK1U5NlJ0R3g3ZkhxV3BBaU9LUmFHTEVRQ1o1dDd2eHlnRVMvdzBqYzZt?=
 =?utf-8?B?VWFIMVJCZlhPd1BPcjNKLzlWd1J3SFU2YXZJaFRLZDdJcFZsMGlQWDF2MEQ2?=
 =?utf-8?B?MklVMS9jYlBYSnpKc05ybHJIb1p6UDBlN0RXUmJPZlk3RjRVYVE1MW0rMEtz?=
 =?utf-8?B?bng2R2RqY3ErTFk1b21ZNEV1b3pGemdvUWt1UVR0NFJoMGd3OGZka2xvWU5Q?=
 =?utf-8?B?N1pwWHNaWmVwZzJ2RzYxUHhQSTY0aEtjaUdTdDVzelpwcS9KTTZ4QVFaTUZs?=
 =?utf-8?B?bHNSa0dqUXZBRkdhSm9xdWtqeXNwbEIxbzlFdFhHUzNlN2VwMmlJT3ZaNFFO?=
 =?utf-8?B?cnN2QzZaRjlNZnVVeFQ1VUV5Q2ZQb3pxTWdxL1gxSXdSYk5wMWI4cUZjWkJl?=
 =?utf-8?B?QVVvdkFVeU52ZWc4L2NYQndwQ2h3bUMzb0szSGFuOTFkbVlYUjJMbXkvcEhP?=
 =?utf-8?B?ZEE0anhBdVYxWVRROFVFZXRMaDVleU0veCs5eGhQZGdzYVA0ZE92dno1bzlH?=
 =?utf-8?B?ck9xRWc5aEM0VGxaZWpza25OWjFWL1VsK2Q2UjJyZFAvM0V6TVZPYWJJaDdo?=
 =?utf-8?B?M1R2c1FwU1FDYTY2cVhKb3pJWjUzWjdrMlh2UVY0d2QzOFYyZHUxdHJWNHBZ?=
 =?utf-8?B?dmN4L2piMlNwNzIxYTlpcFRySHVvZlQ2S255ZmQvblhjYjhxVVRXMzErdkdz?=
 =?utf-8?B?WTBUYWZwUFRiVnNzWWw2a1hVZGRud0tSMllhZzdmVXM4SXROTWdEdXQybTd6?=
 =?utf-8?B?ZmVhQ3YrSHorU0l6c3c2ZFMwN1E5d05vM3pWUlp6cjE4N2JpaWVnWTBhNTQv?=
 =?utf-8?B?MlM4MWF4R2F0Ri9TTlRCZjVLZ1I0Z2NGdUtuSGErQStBcDRqUngvKzgwK3lx?=
 =?utf-8?B?Um4wWDNIa1ladkpKYXpkQkhZeVhmKy9QWUNFT1J1eXorV29UWEY5K1RMTUdl?=
 =?utf-8?B?SzZ2YVBoR2labUI5blRpU09KTFVRbEJhWFdPSmZxWjRCWXN1WDVNTjJKdUJQ?=
 =?utf-8?B?dCtiaDdPMEl3ZlVSTUNPZVcvejF1UzMxYTliTmIrZmtjNEtISU5lM3NrbkVl?=
 =?utf-8?B?cjFRMW5qU1h0RWFYU2dXWE42MzdwWDIzb3lFSDBQdGRncHJQUXByT1pRRVZk?=
 =?utf-8?B?YU1wVWNGSWQxTEx0ZklFT3ZrTUNKcVduUiszeVZxQVhJZWhmLzlobkNoRGo0?=
 =?utf-8?B?WDJRN2diZlBEdUFpUCtJRkpWMlNreWdNL01pZThnSkFPMUNjOGMyTDMvNHho?=
 =?utf-8?B?WU9GaDlBV3ZBTjE2aFlObGVqdERIK1ZPSjM3YmhXZ3lQUlo5aUtIM2RTUXV5?=
 =?utf-8?B?dmFocC9XYk82SnZvQlBFQUJ1MnVDczdSaFR5S3BlTy9UVlRTQVVCeEtDMlVW?=
 =?utf-8?B?UEJzYjVpZ2hyVmNZV0dyY29ONUhVSzVueUJzSlRIdFhqbitUek9mbGxSRWtP?=
 =?utf-8?B?eXd0R0pXdERxYjRaK2QwRGtZeTZrODNacVM2NTAxek84Mm9uUVpFNWFKQkV6?=
 =?utf-8?B?cHdPOTdsT3JvZzV3dFlPbTJwcDRyWTdNVFg0Wnh3WjFkcUcrU1UvcjhORnpG?=
 =?utf-8?B?N2VIUU04cTZyMU5jOFhvRFE0dGdYNU5Za3E4VkIxd2U2a1k4OHpDK0p1TWZL?=
 =?utf-8?B?bDEvcWNRTExDcmllQ0YxczFlSW1sc3d1QkV6WCtGRSs0c1YzNVRyREpoa2U0?=
 =?utf-8?B?R0JoNmdCdGhOSlEyWm42VE1pQVBpZVFQdjJCNkp1OTZEUjJjVFFyTnJjZkg4?=
 =?utf-8?B?MXcxb0pQdXFmcm44TW5peVZOdG85bFF0R1RhRG9YRGd5WFF3Q1lSOWxGL295?=
 =?utf-8?Q?E369QffCW8KmZ6PegMHQRne6/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4008071c-5643-4e78-5a24-08da57f414b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 04:18:26.1202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imGq+m23ysoFfbxFrd7ingLE4W6AUzl55ENOAZVbo1V5qy7kwpi3pNCzuuPQMe4INS1tk63eaemLn7Mz0aBj1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Jun-22 8:05 PM, Peter Zijlstra wrote:
> 
> 
> Right, so sorry for being incredibly tardy on this. Find below the
> patch fwd ported to something recent.
> 
> I'll reply to this with fixes and comments.

Thanks! I've resumed on this but my mind has lost all the context so
it might take a while for me to reply to your comments. Please bear
with me if I'm bit slow.

Thanks,
Ravi
