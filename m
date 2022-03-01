Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D318B4C9570
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbiCAUJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiCAUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:09:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D95AEDB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:08:18 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221J2uN2004279;
        Tue, 1 Mar 2022 20:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2ZM/9doC0OmsIKSETEm/m6L3mWzw2jKELJn1vGIsOs8=;
 b=UdMp6+ENjJKp2XqrmgCps6w0zinNynicse6rhFQ5N0JlDQZyplW/2RwBpe0jbda/TS4v
 NaQfaid4pPevsKtvZcex6PqG32SmKdkaVLWUr5kEG0r2Enol/0zgbTVcmJpMCRlCSkI8
 938Hf39eeY+UgQkTfskMH8L+Hr/0DNbKMZvxeKVSBT8p0VlRTQJai+OyKbJjLBk0q4cv
 1u7WWycQX8OrbjbgbE17EUcaJ244++X/9HKKugsIU4cs4VYLBCZsM3lk95/tmkrLcijg
 +ywn75vxeAqQvpMSxF0jwtVH9ybNosMCEIOuuxs9BJNeP+RQCmM8TPG5SbLH2ohGrcFX Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk9acxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:07:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221K5M0K172057;
        Tue, 1 Mar 2022 20:07:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by userp3020.oracle.com with ESMTP id 3efdnngcng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:07:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql32SJJJPqtomVLoPwOwrx3MYGaiSPXmyPC7wCGZXnJ9LBeiM/rDjnUaEpJuaLZ/Cir9P/gNcJICZ9N/LEyDnWbkxW4jhVL4InxJNjXK7n1YkC+dNVcUIbOR1/nxIRC8lkpJ+WGdykICwEzdmK0lHhat5eSZ6vHxWIc12jn65rJLLucaKbB/jfN4YEe0GHY3/+pS/wcvyooyz4IySqqagU++hj2yzaJ35gQYKSbMYtw+/mLJTwhL5J8zglpr+ICG/MfdQNf/zzstGF3Ml0qrmm6UrLMDmfE1lvfms1TsgZ5+1j8I6unLmZWye/TukGZfDQwsY1B2X3JG+RTyHqcD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZM/9doC0OmsIKSETEm/m6L3mWzw2jKELJn1vGIsOs8=;
 b=Tm4KgKipFf3ImA6AKGyUjCE12ZSIpHKQ+nsH0uU4DJh0jNtVA9+DN4i9lk1LOllse9TyN+2eviN6LDywaBkz2z8CkEm93mQ1rME79E4lyRdr86ttz3FYEcHpvCp6lO1ZzfQcle9MqgAFP2Ch8VQdmLMQn8tfRSy+6wfBHub9K6njX1wUziQdszS0IAvWMro2Weg02zoA42wkFMs6l3453aILl0ZvpMSFiVSHOyJkrYUTA4uEIqCLTvaA1gXEYkRWSYTUX/1ZkE937iOM4XHedk+GfUTsNYtXmsSdPzWmAQQHSG/PNJXIGjR+HhbdhGfcRihup4TRkMfEuAH5I24YXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZM/9doC0OmsIKSETEm/m6L3mWzw2jKELJn1vGIsOs8=;
 b=c/oTU/q0mDZjillFdk8FqucPz52cHug61r4PG9tpnQrB8FJmj/M4LpcJtOvxdaU6raOQ5lWx6BeR3N5hON1bxZp2E93IlCLplzCI5x8PpJpu+iWA1l/BV8dikbZpO0PCxnMNPlE7iJUVX1BH/L172ClHoKWqJACQUvCeHY4/nwg=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BYAPR10MB2837.namprd10.prod.outlook.com (2603:10b6:a03:81::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 20:07:53 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 20:07:53 +0000
Message-ID: <dbe84151-e3dc-7a1a-6cb2-2021d8dfb461@oracle.com>
Date:   Tue, 1 Mar 2022 14:07:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 07/10] crash hp: exclude elfcorehdr from the segment
 digest
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-8-eric.devolder@oracle.com>
 <YhWxeSG3GfJwOGOV@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YhWxeSG3GfJwOGOV@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::37) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7658833f-1390-487e-97f5-08d9fbbf2b7d
X-MS-TrafficTypeDiagnostic: BYAPR10MB2837:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB28379E8AFA26286AA009184E97029@BYAPR10MB2837.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHsJSfcrafKQVHbfJKlltd7uLZV5dzm6JREDfAvSxEZJHWs4maADclZkDsWt/g19+abrD0VpCHwz6YQtGj/NYgbnwYsSCzjCcJiLgoDeE6QaAvaYVRMvYOpFazM5SYwkjNnBztJW/Pc8qkrp0cjjkLthA8GIBFfWCoYSlcgQmIQ32sCi3ORnyzk9UwzVvIAlq8l7JMr5EfH58t7/fZVJKgdNem5mWWnIPRgu49BAAcQQksYgjKPI173X9jyNmg47ZcfSvf5q2mq2S2hxZjdon4BwRMpRagmh3tjKDl6mn4816iP5qgurovXaBJ74Cb70oJgUFu7PdW1u9zu+v6sAhArAKIr+bxOf25AA3CxCH3hsjYhuiG74ZdW71PnRQDv9vDVibqmOmJBZeTWU70ZOkuXUBJl7Z+vsAmbkukYmnfHvFpZ3KiBw58QNf2jqphRIBukvJns/9lV9NlbR2fS0zjO+YxRJPca5EOiQZEE5C8Ae+6VWneLcYRcWzJOlEqdcRSS0qkdwBPUgIi4GEYFlcwK51gjRGuGD8Ha/Eo8Ol+ONgB8V1uLu6dyvFTl5rVxPqaJkF3CJ39YA1SVdW7L2D+ySC+YxSrAPlbRmeD6HqnTTMnR6oWhGGgaiLUM5350FOVukD7mYrsnUCQtA1PxeB62UU5DYPmCPjfMT0FHyl0uqPc7K/MW31ngQwdRfrNDoXATZzVymKrCzMghq3dORETbFB/l6uL576b05mw6YCu6yKeeYxOhWiJ455qf71U10
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(2906002)(31696002)(4326008)(66556008)(8676002)(6486002)(5660300002)(66946007)(36756003)(38100700002)(508600001)(7416002)(8936002)(86362001)(31686004)(107886003)(53546011)(2616005)(316002)(6916009)(186003)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1NRNGFHbzVJdHVuUHdLQVJTVHd4NEN4S0ZaWlVwaUtQZGJ1K1ljejd6SUxm?=
 =?utf-8?B?Y3E3M2JkY3BFczJ5ZDNHbytIR0pjNWN5MXJTWHhHNjhHelg5ZE52U0lmYW5i?=
 =?utf-8?B?RWhTYkdZWVpwTFIvUFlRYTViaWZ6V0dqNVpmcUFQdTI3UkN3aWk0RXJyVmhQ?=
 =?utf-8?B?NlE4N2l5QlpETVBhcjhZcUk2TGRoQnI3RGdVQUZYeEZpb2pzdmJOdktaNVVl?=
 =?utf-8?B?M2JCL1hDMzlFdkJNTGpObXRsNVh3ZHQ1NVR1Z2FJOU85aW10WmNNYUxKRmZ1?=
 =?utf-8?B?NTlzcXl2Y3dIU1llRlVMOTVSNzMzclJ0aU1KaDNSekN5NGg2VENZQ09KczBk?=
 =?utf-8?B?b0tjbFJCZlhQYjVnd0dHT0NVWHZFQlFod1VzTFEraU5KSVdadXExQlZMdnFv?=
 =?utf-8?B?TUx4TC80VGtGVmZVNk8yUXdFZWxSUTNxZDlQWC82RTA1OFlHRVlvSCtmVXZz?=
 =?utf-8?B?aCs0a3FpM1lHdG1uU1JMWTVweElvVzIyN2hURTBTbHhaR1YrZk93RHNZU0w5?=
 =?utf-8?B?TEo5NmYwb2dWcEkwVkgzRmUyVFZ2NW9TNTdHYjVSaUNNaXlVOVFxU0RYaUpZ?=
 =?utf-8?B?NW1zc0VSaVN2aHBUMUNtaFdyM2tvcnZMMnZnWG0rMXBGU09aN1dWamJzK29B?=
 =?utf-8?B?M2U1WFN4aVJOQ1BRUHBOY21zdXNaUDJrN0xTOEJVU1NKSk9VKy9WbzRJSWJj?=
 =?utf-8?B?eWp1Tm1wVjJ2WGVFb0xaTS9Pb3dkVjB4OU00ZzF2MmhNbmdmbGRRU3NrbjU2?=
 =?utf-8?B?V1d2aURtMXhQenY0YWNXUUV4cXErVTBzYWgrNWpXeHZqYm1sYk5Hc3MyNFN4?=
 =?utf-8?B?RXRBQytMNHpnQmlEREN2bWFOMTcvdXBGTVRSc2pZckJRUTRJY0tZV2V6Tlg1?=
 =?utf-8?B?OVp2YkZId2FwRGdRU21jV2xqTFR1S252cm9JeHZsWENBYktkUC92N3R1MmR3?=
 =?utf-8?B?aGxYcGs5a01mNDJGSVJVYjRjbkVMVGJWWWpOSFRoL3V4MDZXWWF4UDJVUUd0?=
 =?utf-8?B?U1JYQllJNFozejR5dytER2drTkQ2OUFIQmpZWUtwN1Z2SXhxQ214S1d5YnpK?=
 =?utf-8?B?Z1dpZnNWNmNlWFZYMEdFV2tudUpscnljTGU4bG9sTVd2ZHlnNnNnVVp6NHJ5?=
 =?utf-8?B?VXp5MHhNUjMrbE81Q25UR0FkUlhYZUlxMGlucDNoMWEySytOQW5lN0taQkpW?=
 =?utf-8?B?OVlBVEpHaHUveUZWRGdGSGs5cGtuQm02b1BJODBaRFB5Ri9mTWV0SnI4WUxL?=
 =?utf-8?B?V1hCdWx4bTdlR0xnZjBjODV4d0lwaXBkT1FSdWw2R24vZTd2dTk1WENnVlVU?=
 =?utf-8?B?cThBY0NnczQwZUkrT0VzcS9sRHFDbkpGaExHKytyMXJLUmxmdzBycC9qTDN1?=
 =?utf-8?B?VGxneUx2Rml0TmpteE5rTHExMlVkVVVQQVRPUS9HV29GSkV6SDB4WTVrZ3pp?=
 =?utf-8?B?eWYya29Ba3BNQ0pOUG5xRUhnZGhzQVBaYW9hbW9CQnY0MHBYL2UrTjlJRDBF?=
 =?utf-8?B?OXZYYW1GcGVYSG1vVDhqU1VmL3N6dkhkeEEwZHJrRXJkaVZBTDV5UzB2S09i?=
 =?utf-8?B?Z3pqVlpUZ25odTZZV1h3aVFPYmVPakxUZEdGcDNTdU9sckVaUHh4M3pHYUNs?=
 =?utf-8?B?d00rVWpGVmdqRWh4QnlEQXRSK3ZQcCttTFJOZFlOV0wyT2tZZ2dUR1NjS0lL?=
 =?utf-8?B?MUs2TGNzbjV1WWxVazVrVFh0RzFXSWE1eDZkK1d4M0Y0ZE5RVWFEWmNJZ3Vq?=
 =?utf-8?B?ZHJiWHVockZVbXhmYmt2NmtEcS94dm5yb1VNM055T0pGS2Q1NFpYVVlFUkhV?=
 =?utf-8?B?UHlmM1o0THZ4NW5pZTVYaVllR2FYZWxhYTNTQ1d2dis2NDdDSW43ZlpBVCtH?=
 =?utf-8?B?TFNod1FHRCsyZmxPZWRkZlgxNU5HTWFmR09ScllqeURpRFdYb2ZmQnh0ZHRU?=
 =?utf-8?B?RHJoYlBIUlU3U2lpOVZZSnk2dFFvRGR2d3N2dENEV0FFOXZzQkhvZU1NVTl2?=
 =?utf-8?B?RnZlZGI0aHFNTXFxK0VJd1B0ZG1NNmFwditUTGtmZXRuMTBSeTBtOGpVbEIw?=
 =?utf-8?B?R3NiTUJsZmFHVHJmQ1hzbSs4NDZtVlBDMmRzbDU0VUZacEtrREhkOGdHeGZj?=
 =?utf-8?B?RWl1YWJjTlROOFV2NVpGcUJrMmR2ajdOZ2M0bk9ZQXdrUFM2eE9QTWtKNXl0?=
 =?utf-8?B?V3h6VERhalB6Q1N6TGlma3ZJb3F3QTNwbStHMDNQR0dwdVdhTFNmSlBZM0Rn?=
 =?utf-8?B?UGphV3JQTWp0MXIzMWtIck94WnJicktsSS9EbW5oTFRNV0NNMW56YjZXTGxz?=
 =?utf-8?Q?9fSzpovKiGG99qVnFS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7658833f-1390-487e-97f5-08d9fbbf2b7d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 20:07:53.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER0WafbIJ70Nlh74sSC/yjHHgLZXNGjjPPVVrkKi2CV6OMomhGj/ItHiRUQplYZWDVbp54IRG01S9/SnyNYlPVe0Pn7qWg+hainisFx5eIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2837
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010101
X-Proofpoint-GUID: BpKXaHEFUye4FW0hJpwQBudEDj8LHdro
X-Proofpoint-ORIG-GUID: BpKXaHEFUye4FW0hJpwQBudEDj8LHdro
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 22:00, Baoquan He wrote:
> On 02/09/22 at 02:57pm, Eric DeVolder wrote:
>> When a crash kernel is loaded via the kexec_file_load syscall, the
>> kernel places the various segments (ie crash kernel, crash initrd,
>> boot_params, elfcorehdr, purgatory, etc) in memory. For those
>> architectures that utilize purgatory, a hash digest of the segments
>> is calculated for integrity checking. This digest is embedded into
>> the purgatory image prior to placing purgatory in memory.
>>
>> Since hotplug events cause changes to the elfcorehdr, purgatory
>> integrity checking fails (at crash time, and no kdump created).
>> As a result, this change explicitly excludes the elfcorehdr segment
>> from the list of segments used to create the digest. By doing so,
>> this permits changes to the elfcorehdr in response to hotplug events,
>> without having to also reload purgatory due to the change to the
>> digest.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
Thank you!
eric

> 
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   kernel/kexec_file.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 801d0d0a5012..93bb0c0ce66c 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
>>   	for (j = i = 0; i < image->nr_segments; i++) {
>>   		struct kexec_segment *ksegment;
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +		/* This segment excluded to allow future changes via hotplug */
>> +		if (image->elf_index_valid && (j == image->elf_index))
>> +			continue;
>> +#endif
>> +
>>   		ksegment = &image->segment[i];
>>   		/*
>>   		 * Skip purgatory as it will be modified once we put digest
>> -- 
>> 2.27.0
>>
> 
