Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261FD4C9574
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiCAUJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbiCAUJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:09:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A391274D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:09:02 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221IjAMF030543;
        Tue, 1 Mar 2022 20:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=efFJWqb85NUkQ1juTjD4nztei7jK0aBy0841M7B13aU=;
 b=TeeUW3dF/fHy5xy+zuBxsHP2onwOkOuj9SDluh50a+/AeDbgqcG4CfCQWSdAL37MKnEb
 QUjNY5vh06PO8NVnDGjGnyF2LsFXyGcBJ1d7yfm0bL7aCV2eqMwrJDqKsqtGcbuxbvH6
 R3pWW5EJ3PO4fGsoNGBpHuJtS46eWux2JsUkzLZodRpq41pF4RtPowru6Gqh/ccOvc0Z
 qEsCsUfhcLjUuQPu67sl96VcrxyaAstlxHEA5fd3m34lY49+LmtLjed6fubCuUyeW311
 mcP97HXk/WXtzui5JGnbUgWfHRGvoPB1QdALtTXh/RysK/6kmw9YhsdLNr5Dm0qb85Hi /g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k43w6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:08:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221K5xwV034174;
        Tue, 1 Mar 2022 20:08:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3ef9ay4t7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:08:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZV6H/bDIdVG5LVoAOTDEhAbnz7tLkde2mCR4RV9Sy178lbq2UTeYX26KS8wOKnMHavK5bJED3ug7m3lY5Y59YJbAikN3pL4Gnjd0knTjKJ6GCrA8yNKgRIBDSMWzVFlTFdnWg5vk4EHRaA1p5xM1txMwb/7m+pKf7uKJ47cygnDnIUeBUoXW/vn6Ep6J+hwVS0CQIOvy3+6K33kgSh2/f2MDn6KjCdZShfXrZNlS7RXpaTPcLblLD/SbQgRJ3n8M2r8dKzjkbPavCx98ZDuo94RvaIaJiDOKcp6ZTRZllZHHoMvEdkQ99OKkUyTHhm5WnHvoEHR8/7T4T5G5HTwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efFJWqb85NUkQ1juTjD4nztei7jK0aBy0841M7B13aU=;
 b=KZ6X038D7MmsdRpYKAGBnS+svGQrZiF/epAB6SJyng6fqI/ViQM7Lp/KQkmQcvHHW/F4rZYBQWgVtdm0w1Adx1q4RWEsfZ7qqmLhk80c4Lg6RmjHq/q4fWsvJsak+38/1FYOEYb4kEjCkN/ekzg/ilQgqVwpxV5gqFrDP6xiorTk88UFtzJuFUP6p/NbopUG+1J0IbatXQG2n89jtbMgGFS9Ha0H+VemNtDY1fA0tT+q4t6Cb6NwDk3hQR6U11YXzychB8AQf+0iwARbEpXT6U5gBgMMmcW/k8myEz0w36gP6kt1+Kl6/j1u+JMhewKBjqqGYtNs+AYmJffHLcbqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efFJWqb85NUkQ1juTjD4nztei7jK0aBy0841M7B13aU=;
 b=HDDUfrlYfx/PYO9WRCG2RReWYelsvGnDkoSbC5Ezq/Anl9Ybgpg+Cf7qVziRseIlNirxM+kRQD9BPQetthWdfcPvH4RJFCZQMfp+z64tyq4NZsVwzPpBwseL9JZG10nWUwNvQGayUBdsxiP1gwvagS+lGKWNcOZ8v/Lo61CMMvQ=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BLAPR10MB5313.namprd10.prod.outlook.com (2603:10b6:208:331::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Tue, 1 Mar
 2022 20:08:38 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 20:08:38 +0000
Message-ID: <75f0637f-262e-1650-2a30-e7cbe2962448@oracle.com>
Date:   Tue, 1 Mar 2022 14:08:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 08/10] crash hp: exclude hot remove cpu from elfcorehdr
 notes
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
 <20220209195706.51522-9-eric.devolder@oracle.com>
 <YhWySYFks0qwk2JB@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YhWySYFks0qwk2JB@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e83e0dd-d505-43d7-c0c6-08d9fbbf4651
X-MS-TrafficTypeDiagnostic: BLAPR10MB5313:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB531375A9C16F6E6067AA8CC597029@BLAPR10MB5313.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MslmCkRngqxl+eO8wRliovaNGmjPC2T5IGujJ7dkdEYNPycCUYQITnQtOpfotUxPwfi3tggaY7ikuAUIvpeFqYeaHcGz0lleMETqEIMqGF2VET/h8oJ/hrOYSkO+yiUPBhSTugNv9FhDHnYUcFBNrQPMwjLS2TGzLSm8P1h0p+vEGIBgvVfffPWW2lCSzh/89Iy9KPo7SZFpTgzDznoqc/07KWnxjlbEGxhcnMKpR/K0tvAeba6LzTFUcG6eLaXiYOb/pUEYs39GPgqX7ya/De6bIn80/VnXVqMifind9wL2sgKnV49nyOUX2/HIR6A0GKCuUrBos6dED2q/EM9JrNITMBEu8RZDuYhECK3ydes75J4T4dx3JYHqPJDMZAK05V1bVBEGtMX+9MIaWq4EoFeUGE3eN7OgfQrfzJ/1yPonYTuHgfybn1RKd57AfVbPwBYfnbYdrcePqHp5X+BOVX731sTSKUGRAgUvI0xF1l2jmjdk4eA6+KSIKOA7N0V86its3Jq2GXPY46TN7GdfezOtEgDJe+JaL+ciZP2t3MZx0yMvQ4ve+IcPYhtw/KLn+egzhE0LMzYhiN+Xu6RDr8/zqYqAMB+P3DocZ8skZV0SRVgKU2DjDl/5QlSf77yXhm0FZyXSXlTuWMDpB1hCkvXBERO1RwD/lPJvyNRP5RheNExfCrBOFcfWL5QxAzYYKqDcYzIRQV5n3BZ2HAq7G0LDaA4M3Fv4u1tz+eTGeYIKCUXg2l5jcDA3NN90n3T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(8936002)(31686004)(6486002)(66476007)(66556008)(4326008)(8676002)(2906002)(31696002)(86362001)(7416002)(508600001)(36756003)(6666004)(66946007)(5660300002)(107886003)(6512007)(53546011)(6506007)(38100700002)(2616005)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkZWWHk2SThrRERxbXg5RnNZYWhDQjNsS2pzVzR6eWgvRFpOQVFsc0pUeTlU?=
 =?utf-8?B?WUtjU1U2Y2p5Y3VLSzhVYzRVRzlWckIzUHA0RCtCZE53UnQrY2F5QStIUnFG?=
 =?utf-8?B?dHVsd1U5Q29uMjIrL0VVOVBSSEI2VVNoeWhrVkZIM2dzbi80M00wZ2x0YS8x?=
 =?utf-8?B?Ym01VVhtN0QrQXZnZWMybEJSL3FwTnJwcXd2VjVWb0FNNWFXeHhhVjhJd2dw?=
 =?utf-8?B?NDA3eWEzVWlpTnBrbXJiRTdjSHU2SzU0cWpvN1duczI5TnlieExZZkhFMHpV?=
 =?utf-8?B?VVA1aW42eXI3bEZtTEJVNGpteXFHVE80Y01BQlhQVVpFMlp2RENESXkyVFdG?=
 =?utf-8?B?NWxiazNZMWh3MS84S0tENW5rekh6R3l5cFo0MmhQMHo1clRlZTdPeTM1SGJv?=
 =?utf-8?B?QjlKTkJWdUZnbEFNS2FLVG51ZXlDSUNRakdTL0YzTkwvZlhrVllJY3c5NTN2?=
 =?utf-8?B?M1I3THlRVk5DeWpIM0s0azk2aHFEVVFOeGZ2cHhKKzVRQytwQUNnekdnNS94?=
 =?utf-8?B?V2xrcXNWbGpwcHllM2h0c2ZlV0RzbzJsVVl5cUxabmg2d0M4YWVGVkptd0o4?=
 =?utf-8?B?aHlxTWpDK3NYU2Y1RTJzV2VpejBxUFZnQ1d1WlVNSi9yd3BjaXJqdURncHRv?=
 =?utf-8?B?cVppU0tGcG5XSSt1TGx2WDg5S0V5U2ZIYzBNdUpCbldvUGYzdHRmRzdFUG1S?=
 =?utf-8?B?NXczWHJFRGJPTjRDT1Z1aHZERWVEZXRobXlEUXFsdG50Vmg2cmlXWWV5Yklr?=
 =?utf-8?B?c1RaUmppRTdobkVNSnNDTXdDR05DeDNTclFjeFZqb0JSWDB1MCtmL0FqaUlv?=
 =?utf-8?B?SDlHMGxzR1E3R2pWOVFzZEdjVExkQ0lJcS9ScUVRZjFPWWVpWUs2VUU4SFJC?=
 =?utf-8?B?VHlzd3hKR25KWU9VZlh3REQ4dnYzTEZTb053QjlWODNla2VXNmRrcksxdjJh?=
 =?utf-8?B?QndLUmkzT0JXL3ZvREdLaUhtd25LcmR4enlUb2NKdTJJQnhoVUpnYmhXU25V?=
 =?utf-8?B?b2RHU1E3dCtWNWxqUDBBZStqNXpYcGpXOEFjajl4MFNTdnE3WjRUd3hkRnVN?=
 =?utf-8?B?WHhQTSt3czljYU8yVE9sT2p0WUxyLytKektxSG5VM296T0dDVkJaQVYrZmk3?=
 =?utf-8?B?WjFCQjJzVnVuSklTV1lhSzgyVkp6R1orVXBnTGFOaGxLc3NuVGRScmF0eFgy?=
 =?utf-8?B?bzVabUZocGJoNWVHek5CVHhXbU5zeXNFVGlpaDd6b1RrYTRqQXVNSFhXajl4?=
 =?utf-8?B?OFJxS0NkMHljbGw0ZExsbzRSdURlMExCSzVQWW1PQkJ4T2dkOHBGSzl2RnFz?=
 =?utf-8?B?cGNMaW5JUkgxS1BoWmlFOEU2VE4zMnpQV1NMTnRlQXdNQzFqMkxLMFV2ZGdY?=
 =?utf-8?B?YXU5N0NXbnZVK3FQTTl1S0hsL3c5SXo1ZUVyeThIYXdjNC9LODBseUJUd2Vk?=
 =?utf-8?B?RXNXSzdJQjIvTFNYaW9Ba3NFOGRXc1NnUFMxWkIyVzArMUU0dG9GY3AxbUQ2?=
 =?utf-8?B?L2RkRWVnQlY3UkgzVEhhM2RGWlgrcEpBa1M5a1NaZHRqU0pUL2I3aFJubERV?=
 =?utf-8?B?WjBZNjhmZmw4ZU1vUXNLQlMwYW5RalN3UWJoYTZhY1ptWkt0V2w3SmdyeFI1?=
 =?utf-8?B?Q1FtR0xIZUdjTU9vekV4UkJIa1RoT2JnU011ZnRiT1FlRzdlZ2hoWkdpQWl6?=
 =?utf-8?B?UlE5cW9vOVErcWVSVXVLYWZFWFFXb2txZTZuWXB1c01kaFUzY3BIem5xOGE1?=
 =?utf-8?B?TE5vL2xlMXowcHpnNU5EZW8xL0o5dnd3MU9vZmZlWU9sdExMMXlBbjZQTlpk?=
 =?utf-8?B?ZEpWYmhUTzlHd2x6aFRFbXlrSml6d3VOU0laa2g2bUoraGJ3d0NaMWdMWDFN?=
 =?utf-8?B?eTZabzE4NEpkZGJ6dXNmQklIcTZCbmIvTHRZYUlzcWY0NGhkUUFRM2c4b2NZ?=
 =?utf-8?B?N3BjRC9VQkNTU3Z2NFRNNjQvMmoyVnpUL09pWkhwZFp4YndON0VJUTR2MG4y?=
 =?utf-8?B?WVVaNWd1Q3pkLzhmbFFPT1BBZlYwSFZBNE1sN2lyVE8yeDk3UTIrMG05bnkv?=
 =?utf-8?B?TFdsOSs2QWMxSEh1NmMwS0tLanppOGU0aUIzQWVxK3FnODNwM3VjUEdReDRU?=
 =?utf-8?B?M1pqaHBDNlpvdXh3NGZEWWtEdU1vUjUzYVU4NmNpYVYwRXJ4RnZOYTBBOXhx?=
 =?utf-8?B?VFJoUUdwc0RCSVlncUFjSXpuMzlRUUxzMG5hVFB2Vm5PeS9QbXFOb1QvTkU3?=
 =?utf-8?B?MFhnYm5KVG5NQTl0SW0ybStNY0RBOE1VN1h5eEtnS3MraE5OV1JrazRJUTY4?=
 =?utf-8?Q?8yK2U8S/PwdUjpvkwZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e83e0dd-d505-43d7-c0c6-08d9fbbf4651
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 20:08:38.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzGmIIQ4z4M4Qq9md1/kM1WPazDv03yG+JG2TvdEIQo3j7EEdkgm/O3uE8wBYsQabDtjDk3Mi5PaEahrWDY03iYScnfKCBQTMdUa8yUj7z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5313
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010101
X-Proofpoint-ORIG-GUID: 74uO_znkyWHuCEm2MJc_TAa6afAYxXyH
X-Proofpoint-GUID: 74uO_znkyWHuCEm2MJc_TAa6afAYxXyH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 22:04, Baoquan He wrote:
> On 02/09/22 at 02:57pm, Eric DeVolder wrote:
>> Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
>> still in the for_each_present_cpu() list when within the
>> crash_hotplug_handler(). Thus the CPU must be explicitly excluded
>> when building the new list of CPUs.
>>
>> This change identifies in crash_hotplug_handler() the CPU to be
>> excluded, and the check for excluding the CPU in
>> crash_prepare_elf64_headers().
> 
> This looks good to me, and the particularity of cpu hotplug can be
> understood well by other code reader. Thanks.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
Thank you!
eric
> 
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   kernel/crash_core.c | 10 ++++++++++
>>   kernel/kexec_file.c |  5 +++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 524470e18883..b6942e04a188 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -550,6 +550,16 @@ static void crash_hotplug_handler(unsigned int hp_action,
>>   		/* Flag to differentiate between normal load and hotplug */
>>   		kexec_crash_image->hotplug_event = true;
>>   
>> +		/*
>> +		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
>> +		 * this callback, the CPU is still in the for_each_present_cpu()
>> +		 * list. Must explicitly look to exclude this CPU when building
>> +		 * new list.
>> +		 */
>> +		kexec_crash_image->offlinecpu =
>> +			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
>> +				(unsigned int)a : ~0U;
>> +
>>   		/* Now invoke arch-specific update handler */
>>   		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
>>   
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 93bb0c0ce66c..339995d42169 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -1314,6 +1314,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>>   
>>   	/* Prepare one phdr of type PT_NOTE for each present CPU */
>>   	for_each_present_cpu(cpu) {
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +		/* Skip the soon-to-be offlined cpu */
>> +		if (image->hotplug_event && (cpu == image->offlinecpu))
>> +			continue;
>> +#endif
>>   		phdr->p_type = PT_NOTE;
>>   		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
>>   		phdr->p_offset = phdr->p_paddr = notes_addr;
>> -- 
>> 2.27.0
>>
> 
