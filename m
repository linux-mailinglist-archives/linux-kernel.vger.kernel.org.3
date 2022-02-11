Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8104B2D70
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346766AbiBKTSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:18:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244398AbiBKTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:18:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE9CEB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:18:36 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BIdFwE015541;
        Fri, 11 Feb 2022 19:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Gf6eTmYhIyyCTr5T1dBdSFlzhf5F2LnPASKjCOZ8wjE=;
 b=k/fOoPNcjstRQIgAYgbFYwn6coK19OcnPRStegGdRJR0EMYTYYDe6eyG5dKam+pqfREx
 ej53vnI9Tr/64jlQ6LpB54h9ggGoQdpNqsclMNVg6faA3hMN6RoJpXv9jT6nALknPN28
 wTHpSwcsxrE6C/IWiZas9u8uSAW651lrPn7gaIwaAQIbDtx4JwKk+uasnDmfJibLM1tM
 0nbqn8Rdh5VAQN2ll4PBfXbYepMir8ni4PoUxfuJPBTvZK4P9PKju9POPLoxhpwArFNL
 GatXj7b9frrxBPsgNpcPmw/qbrILyR1CGHhg7zSY+IN74rz94F0AYftVUdoSDUmwpLAk Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5g989yb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 19:18:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BJGHsf052913;
        Fri, 11 Feb 2022 19:18:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by aserp3030.oracle.com with ESMTP id 3e51rvu7ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 19:18:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLCZ/YefAHT3CSOMGVJxMeRs3MZUKOxBw/vM15G+FZRJjG3Hg3t71BR3uHnGXEx/LJlZhKgNIKU8cHdTmZShZPdldbsD+8sacN2hgJoaAMlrl/TG/abAmhUhnuwfp+D9nTZ6Tep+kf6N3L/ZPjSD4IIQdFyy5Re8yf20hHImHsmSZ27pguU/Mb62SuU4KNvPBfaRtjDeJQqJ501zLbc1/4Uwx6Lid3Eoiln/r4T+gvz2Lo2kdFs4E4onxV2Jm+GK22wjHT6Zt1XyxobAjNTmNzzLTs2LMFWaqFQ+baIVbDzMF81cDdcu4F6V3Qb+RQTKvf2n+7K4i6uoVquU+A4XAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gf6eTmYhIyyCTr5T1dBdSFlzhf5F2LnPASKjCOZ8wjE=;
 b=GmAlVMNDDiTspfrHaSKOfflPjWN+Ijj1yU7zsD+xVykhlCLaEBRXWboalNZx8rQw4BM4BcYm1fcG2t7MgsIYhqSTQdF1vFdE5f00Sewo6KUosSgSUrPugQPrpIrjVo9n+uUoGVduepMz/SaFxA1HiAYMzxZTsKEgJADzNNIIZFfom65zflldnsPknDwfxSPU8RQZ5CMZwSYYq0o0HhYLqrdoaf2QmHRF4K+b7XrcQ7ZxRPuLrBdtCKiAgEX99Djedrf/Zx7GkZO4FWW+vSS+2T278rdLjjI8e/UHsEJy1Ih3Va7HgAzznGxrCfUViRZ2UjkPS5DSzFHzo6StmN9q1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf6eTmYhIyyCTr5T1dBdSFlzhf5F2LnPASKjCOZ8wjE=;
 b=xyYGzHiQCh1QSPMFx4VR0EmCCNa2S8ys35yWHIwdZxkhQ6SXNYjT8OOk7mc4R9SOLpytgEblKaac2TR3aGS6TdQ4ES81xECVpJR9/t7+M4vIhT/nfdBCLeS88vvRFBtO0Ew+olWINykq8NDuzq+sCLqCirTpQ77rL2utoTP6rEc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4505.namprd10.prod.outlook.com (2603:10b6:806:112::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 19:18:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 19:18:13 +0000
Message-ID: <64aef81e-4c9a-914f-e559-1d559b9eb19c@oracle.com>
Date:   Fri, 11 Feb 2022 11:18:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-2-mike.kravetz@oracle.com>
 <YgSDcmXya7vTvvZE@xz-m1.local>
 <bf1f7a47-5d57-492a-03dd-e42afe186d47@oracle.com>
 <YgXJ4VjYBJC9ZfbF@xz-m1.local>
 <CAJHvVcg1pFfFSggGjDCNKt6ZzS07HYNHHQMcmguZACECpBGf=Q@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <CAJHvVcg1pFfFSggGjDCNKt6ZzS07HYNHHQMcmguZACECpBGf=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:300:6c::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fd6b194-8bc4-437e-53e6-08d9ed933fcd
X-MS-TrafficTypeDiagnostic: SA2PR10MB4505:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB450585D75724412ACE00B85BE2309@SA2PR10MB4505.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OcaSY5WSqVqnECgChFMqovjfrUCwG8HQeMmlachekhnJ1zYLs1lv5lVKcP6QpPEg6QethaAcWW+HNldYlKevo/iUci7SOWwoE6xdb6eRzLrJYUCuBhvV5CYzY8SeZ3QoHd3GaHMqtqNmCapxXbZAHqvEEoo1YMqnsy45uv7ahJ6U8kMVksYyaLWOJ6oFC6FZtfogLfJ4zeiwKXalU5wDhX3or6cwuGLazJuz00hgL5gF0jdHKG91od8vJPX0ho8ZHXXpldnzOlDUv5vmyjkyGhn3H8CRRi4nMA8pAfDd1YEMaajwqYSo8V0xUJ/qBlQGyqgxAuAEDb3PVfwV+O57Ajc11vYU05TvrnlVF5HdMHmX6Nq/QtL+b+UZpruGwJrM5E1tyZfU/dbXZzeSvyD5pRxVQfxbDdHWPVRsvPyErC+BjY+oOvKSqpviuij2yrCLbYvgvbMIoDCTOZvUDXZja8vo7Q+eOsxQPfIuHTf0m3u8H8hwJJwoLbMLg31AFWvBPUpi/rJG3aYWm/vd75LVmY4e+wLXK5S+2TC1A18JVZVdUGNxU5KsxObluIhq9yP0edNy6eJildJ6fyVbdp1/F3EDQ4F0vVwrAU61xuTNVCbW66Qyr0c31FTGzaV12bj8OrTPUHcXxuPo2+yRVHMhUoUs/M4M5BTGNt673gaKb6DfhLkuj1XtyLP2FkyckuPp+7JtW0msBVBe5glxkeZt3XTaCdnbR5hQ07Hi/G5/tfSqiMY84tYbebj1z7CxUQ1sNzVMdIb5XoVg2azQJWw1+p9po7YIzoCqOwdXESaNmfYcdPGgxC8jUIBLnXZjKCRJ9X7EScfgq48iSmZhhCf7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66556008)(66946007)(6512007)(31696002)(186003)(508600001)(8676002)(66476007)(8936002)(2616005)(2906002)(86362001)(26005)(53546011)(52116002)(6506007)(7416002)(38350700002)(38100700002)(5660300002)(6486002)(316002)(36756003)(31686004)(44832011)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzNVRXFsSkNxZEtnNDVmeStMTXVNa1d1TXhWRU4xQmhJK0U1OVlObnlDc2FM?=
 =?utf-8?B?NmZtcnk2RVY3aDl3Tm1ESDZQSVZ4dWhHZTVBbExML3JGczVuLzUwMVR4N0Fw?=
 =?utf-8?B?K0VKZm94dEplbmpiN2J1cVdsSEtTZXFPSmtaUWJsKzlzUmVObVRRcXFzT1Yv?=
 =?utf-8?B?ZXlqZFkvejJlV1pIbWVFdTFqeEQ4NmExZTgva1BNcDVlUGdiZitEY2Jlb1lB?=
 =?utf-8?B?bWxLREMrN1A1a1FFTFNXSHNvN3IwSHVjWXYrZEhGZ3ZRTGJYb0FzUnZwcDVO?=
 =?utf-8?B?QXJLSUE4VXZidUV6d0tXYnBYR2h1VUZMTzhMUmREL09ORURkU1ZIeHZFdnNw?=
 =?utf-8?B?YmkxNHJoQmZDRUlSaGwzT09FYU11R290ZTV4NmQ4M2Nra2dzZzJpVldrN05N?=
 =?utf-8?B?d1VwVU9HVEJXamJWQ1YyT2lxRkJhTzBIMXNsMk5pUDV1NVJ1ckkyU3NkWGt4?=
 =?utf-8?B?V3BoQVd5bjQ2QlRRekRKa0dEUEJ0TlBMSkVzMXU2eWkrMHBVcEoyTVRtbktY?=
 =?utf-8?B?b2dBRFN2b2xaTVl5WUFMemRUcG1CL2hWSGVFQVNjQjNZdmsrZ1hEZkNZY0Nj?=
 =?utf-8?B?cXcxZFJrZ0c5R3p6YTRMQ1FhQnhOenBQYVBaTllzWjE3WEd3UVA0KzJQQXFw?=
 =?utf-8?B?TEZUcERTQVUwTytUU0p4U3hUaEdHVW93d2ROenRIZ1NZLzBzT2RWR1A3akZq?=
 =?utf-8?B?cmNCRGUzbFR0SUIvclhyei9hVWtTZVU4M1hxSVE0QldSZzRQNFNQOWRobm1h?=
 =?utf-8?B?NFhmcWhEd2F1QUo5OGMyd2NzdFRjb0xaakQ5MnE2aUxVQ3lYbHFPa0RQL3da?=
 =?utf-8?B?dVJKa0JwYjFrZXlzcklHMVk2VkdpY3FESTBreTlIVGhqZjVmWWkxTm9LV1c3?=
 =?utf-8?B?eWFkZEt0MUFqcFdtckxvYkJzV2s2aE9QNHVONldYWGg2SnYxRDFGVDY3a2M4?=
 =?utf-8?B?a0JnRkxNaWV2NzBFQUNUMUdsampBc0xSa2VqbEhmY0hxYnBzTkl6bi84YWxD?=
 =?utf-8?B?ampTS3Y5UklwRFV3N2U4ZWJzbnJtZHBRNHdsVVBVa0FUMDNSNFVDNTNXd2Vs?=
 =?utf-8?B?WTY0Y1VCbEJPY3VGeEljVS8xWmJjRzdCY0R5eFJwMWZIeHRLNlkyVDZIaFNT?=
 =?utf-8?B?bmR6NWRYV0VDMHRGZWRNU2UyUEE3OEgvcEc5c296KzZOaThxY05uRmhxdWx2?=
 =?utf-8?B?YlJ3UmJ2WEUwMytTeTFycFB5b0RJS0ZIUHpiaDFpampvbXozNXEzQnVKL0tQ?=
 =?utf-8?B?NnlLM0d1OGdMZ3B2VmJocDhRclBrYzYwUXdVS1YraGxJMmF5bThsbjRXT2xn?=
 =?utf-8?B?NVNZZmVGem1EenJBMWRVL2pQOGROWmE1ZUszcWc5UEV2MStoa1BBSUdNWVF6?=
 =?utf-8?B?SEM5d2w5OEx1MFhHQ0NqWnpNUXN3NVBHYzdkU0xhMi9YZlE4SDkrS2dxUk0z?=
 =?utf-8?B?cmlDWCtCSmJtem1MeHVHS2YraXBmeGtQM3pVZlVhU0dNS0tEdjlHTmVPUkk4?=
 =?utf-8?B?YndJejQ5RGliS0l5OFpPMFQ3UnA5TURKejF3bXBtSTJVY2hGZEFhcDlUbkov?=
 =?utf-8?B?RmtBVGxSUUU4MldxN0lyWVBWejhhaFpRVFg1MWNCVkludkUwdHh6ZHVVYnhh?=
 =?utf-8?B?bi80Rnk0Y25CTmtmamtmQTI4cndHQk5ld0tuMldOR2Q2Nks4UGpOVi9oUTNX?=
 =?utf-8?B?TFdPR0hrd2hLUFVLVzdUMHg0QTVCWFo4YVgveDVsTDVpQzlhV0FBVDNrUXNU?=
 =?utf-8?B?bHplaWZIcVBpNUdNYnRmT3UvaWNaNW92L04rVWhtTUF5TW5LTlFMWVU3SkJ4?=
 =?utf-8?B?aklhY0ZPOHZKemN2M0JWSG1qWmEwVnAwQ1RYd1dEVk5EUnFaK2Z0TWRKSkNu?=
 =?utf-8?B?dFFQVkdvR1FiSmJMN2RFanhPNjZtNzF2M1RNc3k2Tk5NdndRZ0g0VFJrSm5B?=
 =?utf-8?B?MFRJMXhSb0RKaFNENjE5SWExZHdmaC9pT0E5R0U4WFBCZmdGL1k3dEQvS1R4?=
 =?utf-8?B?WW5oN1crNDYvR3k5My9QNm83amRKSmU5Q2U1SDUySllzY0pSa1lpLzhEaDh5?=
 =?utf-8?B?d0V5NE5ZK1EvaEhwSVJ2T0piemZRZVFQd3IyanRXSTNLRzRPTmp5b3ZrYmJn?=
 =?utf-8?B?cnZkak9TNUw4aTVKYm10M00xdGttVDVtM2tiVTJ4SXE4T0lpV2lScU1SSFky?=
 =?utf-8?Q?TA/QFgVbI6iJb5ffJSpNDJc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd6b194-8bc4-437e-53e6-08d9ed933fcd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 19:18:13.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KmgltyXkEcVUo/5beiGmDvatAPRHnCDi+LzdpaA0MpFP0Hy2kX9mzFvADIEjKVxESaheM+zUJMGGruI5tkItg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4505
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10255 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110103
X-Proofpoint-GUID: QehYlp7E4NTov7s_O1jEcDNC7NH7nBLo
X-Proofpoint-ORIG-GUID: QehYlp7E4NTov7s_O1jEcDNC7NH7nBLo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 11:08, Axel Rasmussen wrote:
> On Thu, Feb 10, 2022 at 6:29 PM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Thu, Feb 10, 2022 at 01:36:57PM -0800, Mike Kravetz wrote:
>>>> Another use case of DONTNEED upon hugetlbfs could be uffd-minor, because afaiu
>>>> this is the only api that can force strip the hugetlb mapped pgtable without
>>>> losing pagecache data.
>>>
>>> Correct.  However, I do not know if uffd-minor users would ever want to
>>> do this.  Perhaps?
> 
> I talked with some colleagues, and I didn't come up with any
> production *requirement* for it, but it may be a convenience in some
> cases (make certain code cleaner, e.g. not having to unmap-and-remap
> to tear down page tables as Peter mentioned). I think Peter's
> assessment below is right.
> 
>>
>> My understanding is before this patch uffd-minor upon hugetlbfs requires the
>> huge file to be mapped twice, one to populate the content, then we'll be able
>> to trap MINOR faults via the other mapping.  Or we could munmap() the range and
>> remap it again on the same file offset to drop the pgtables, I think. But that
>> sounds tricky.  MINOR faults only works with pgtables dropped.
>>
>> With DONTNEED upon hugetlbfs we can rely on one single mapping of the file,
>> because we can explicitly drop the pgtables of hugetlbfs files without any
>> other tricks.
>>
>> However I have no real use case of it.  Initially I thought it could be useful
>> for QEMU because QEMU migration routine is run with the same mm context with
>> the hypervisor, so by default is doesn't have two mappings of the same guest
>> memory.  If QEMU wants to leverage minor faults, DONTNEED could help.).
>>
>> However when I was measuring bitmap transfer (assuming that's what minor fault
>> could help with qemu's postcopy) there some months ago I found it's not as slow
>> as I thought at all..  Either I could have missed something, or we're facing
>> different problems with what it is when uffd minor is firstly proposed by Axel.
> 
> Re: the bitmap, that matters most on machines with lots of RAM. For
> example, GCE offers some VMs with up to 12 *TB* of RAM
> (https://cloud.google.com/compute/docs/memory-optimized-machines), I
> think with this size of machine we see a significant benefit, as it
> may take some significant time for the bitmap to arrive over the
> network.
> 
> But I think that's a bit of an edge case, most machines are not that
> big. :) I think the benefit is more often seen just in avoiding
> copies. E.g. if we find a page is already up-to-date after precopy, we
> just install PTEs, no copying or page allocation needed. And even when
> we have to go fetch a page over the network, one can imagine an RDMA
> setup where we can avoid any copies/allocations at all even in that
> case. I suppose this also has a bigger effect on larger machines, e.g.
> ones that are backed by 1G pages instead of 4k.
> 

Thanks Peter and Axel!

As mentioned, my primary motivation was to simply clean up the userfaultfd
selftest.  Glad to see there might be more use cases.  If we can simplify
other code as in the case of userfaultfd selftest, that would be a win.

-- 
Mike Kravetz
