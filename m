Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F824CFB94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbiCGKk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbiCGKUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:20:18 -0500
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924977C169;
        Mon,  7 Mar 2022 01:58:08 -0800 (PST)
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 226L06ud023876;
        Mon, 7 Mar 2022 01:57:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=72R5RbUhAxBOGV71kKetK1+kS9bIKdkJe+KvJgxB+AY=;
 b=os8vzH0FRYibi66lA/6DTK3CwY6I9fjbFGuZYhlO//YtDR3hzqaiyg52Xktlae0dmCy+
 Xw4ZgxomcIL89Mmc7DQQ6dmk3xxeA+EvycsaYJqW7nUvnOOl43Fn++ezVQ4Pq592YXmS
 K8RPltSTd4NGoayLxSE1/WRzAmgYTQs4PYYAspNbPyn/01pChJNnqPyLUpoPonWt5XmY
 WdJTaA2/Qhd0e9G1YhgkJfN8f1e4qYMlWJVrUp6nwyKnLuGnEbsI0r8vsu4TmIub/jGt
 Dt4fY5L0004w2o1Kf/zxOmXPXtFFQcRX8dVuZTWGkSg2IONzDEIcajxncKsKJbHWRCMI 3g== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3em7tkju8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 01:57:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHRq4QITulf4VIsfDVMMS7J/OvAuHGTVXvYfFR1FuMmiDONlvzcIuw94evJfJuKGIh59LOU3sJfLpLrTMQxOHghVm1UTcMAfRX6ssUsOxd2T/VNj8vIXHixOpdFzc3yuyeItKdiEDO8P9jh6JL8UkoAtR9wjsr4vN7tncBPgadHbqmYlJx7G8Zk0z9AjQV3f18t2si4efY93ZVkKYjNy2Jpij5sE2/ETihLu/R0cq6LNRifiog8UijU9oQpv/h62aOjdT0hWYQmcAcSvSPMwbjZpYICrZ0SRgaoGvvJ3yiRcZMBOd6wEztI8oLB2V8h0a9b0iO8c6r31+tYJSxx9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72R5RbUhAxBOGV71kKetK1+kS9bIKdkJe+KvJgxB+AY=;
 b=kEm5Tx6R+HpYMlRMEN6n83/9jjYNHUW1L8H6iX6v7ZCjxADk7+IAe/74d0uzSiXKP9xa0uDZDBHy7QjLKmbJ1yGSy2V2DfJ+2bLZep2H9WDiLmNjjNsxmYQQUKysNgWAW7Kb+4K9n2QBXdbwuiNUQ9qz4f11Ix+qGob6hpWTnKRR3TQILd/YzW1XVg/IZmE5/7j1FNYyPBp+mGo82tpt4AmEESkdtcHpFtHhW80Gkbk80gauEIIUlxTz2Q4BVX6QRa5HVgNDuow6s1CRw7/eFqv7hnCW8WxVyi9WaiKjqhCcOMQDfuhNpaQrTE01/4ztaCkWgPjrZwmgjTQ1hkhY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3460.namprd02.prod.outlook.com
 (2603:10b6:910:91::14) by SA2PR02MB7819.namprd02.prod.outlook.com
 (2603:10b6:806:144::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 09:57:15 +0000
Received: from CY4PR0201MB3460.namprd02.prod.outlook.com
 ([fe80::7567:4530:d91f:33b3]) by CY4PR0201MB3460.namprd02.prod.outlook.com
 ([fe80::7567:4530:d91f:33b3%3]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 09:57:15 +0000
Message-ID: <48275d12-7c81-ba31-0ec6-c0623c143ef4@nutanix.com>
Date:   Mon, 7 Mar 2022 09:57:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Regression of madvise(MADV_COLD) on shmem?
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>, dancol@google.com,
        Shakeel Butt <shakeelb@google.com>, sonnyrao@google.com,
        oleksandr@redhat.com, Hillf Danton <hdanton@sina.com>,
        lizeb@google.com, Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <dd620dbd-6d71-7553-d1e9-95676ff12c82@nutanix.com>
 <YiKsUr1FQwmDP7V0@google.com>
 <CAOUHufZyrLrkEvFay+FddN5Ve3v_-JvNROHo9hEhsoVuCpwh0Q@mail.gmail.com>
 <CAOUHufaBi5Js6HXCO3R5nOo-+NiWajmDjM4mpx6H55JWS3auGQ@mail.gmail.com>
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
In-Reply-To: <CAOUHufaBi5Js6HXCO3R5nOo-+NiWajmDjM4mpx6H55JWS3auGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:510:f::21) To CY4PR0201MB3460.namprd02.prod.outlook.com
 (2603:10b6:910:91::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94686076-6d24-4632-b032-08da0020db8d
X-MS-TrafficTypeDiagnostic: SA2PR02MB7819:EE_
X-Microsoft-Antispam-PRVS: <SA2PR02MB7819F51397C0CFFFAAFF762FE9089@SA2PR02MB7819.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSXf1IFJjAMWlXOqwJzsdZvY6nZ3+SMFd0xkDqECYHDeb8JU/RyHJ+6XwG8KlOJWyNS6BiqX0D0MPuu/8lWXt4h7+WUxlNhDfxc9qBKI+e+U/SGyop4HhRadXda7sqK/Mk2bnTgb83TcI7do+5cZWYR9PvQgZ3N4myvl38PW3aPuuc7ciDx9LHDTafNTaPtZgmq5jHmzgqIkyfvRYx0N8H4O5/IfqiwGN6QFmGV3hBRM/DMeuFuX4jsUR67WtujHOwY8XqyoaMCyuANmXWdiQKWVWQvIvvo5FRJKdeqg5tzGRvHcNH2Ko3bNe8mEfrggEEDIbcmj3ky9byT3/Y7GsVtEbWfKMswiUJKExXA03Ir72uX8Mo9bc3bwFSM9o5lc0LkFAzHP6EiSpmh+tSUs8RQmcuVDZCFpPLFTOAl9WhoRn8s5x/KDixqrX9DYUQ1IMjo2xQ4v8e+xlcGdiuPC2Si0zxzxOfcg+y0+7GR3T/IleRmJgSQe98c4/p1LW1d9BcfFAJT/idQcNAuQvg5pN1fkYH0y46mutqlfsiuuV0l1ltcht+Kyo76mRLb0iuhvW8uPqXIQuk89MD6igh5yAM9nJCH+/k3mokYlueLd3G/uKADG497d+Tj5HyR/osXdacuCbmEWAVzDOxxfTyZPIQUY8k8eVdisGLg8ZZVjeojh48XXobg6meGG05qzQUqKx3XSwrpua8CRCNPRIzHLaMS1aXxXU8tTEvfxkDsqf5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR0201MB3460.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(508600001)(8676002)(4326008)(7416002)(66476007)(66556008)(316002)(66946007)(54906003)(6486002)(2906002)(83380400001)(186003)(26005)(31686004)(2616005)(8936002)(5660300002)(86362001)(31696002)(36756003)(6666004)(6506007)(53546011)(44832011)(6512007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0RUbFpTSHk4Uk0ra01xTkFuQUNEVGhYOFdNRGhhclBTLzRESzYzeTBUSktX?=
 =?utf-8?B?bkUxN3dMQXhid3Z3YU5Dbmg4YWNiaHVCOTAxZjZ2bTJZSFk0U1VTaml2V3VP?=
 =?utf-8?B?dDBNUGVwMDdHdnFhOEVEcmk3L1NvOVhzNm9OSXhRMlhsWlNrNyt3VWFqeHFh?=
 =?utf-8?B?RFBGZWlKY29XSWtQSlM4d1RLV1g3ZWtDVzZXbDZJSUZjMStvamc2cXNwTFZX?=
 =?utf-8?B?TTVJZlovZTRIdS9iOHZ5SHBlQno4aWZpOGpheFJ6ZEIrVWNDbXRtRjVpcnlp?=
 =?utf-8?B?dVVFam12aDdkaG1HSC9YektqSTBsczRmMm5KUVRTRmFRZFFxa1B6V0svTWdh?=
 =?utf-8?B?dHRaWEQvSGxlS2pQKzF3Y1VrZi9hUkQvYWpNQzZqMkMzcGo3ejBscEpZQmVs?=
 =?utf-8?B?VEdMS2FLSWFURmYvMjVpdnk1eCtWbStoWnRrbEkyTzc4TWRLQkdlTXJYK1ph?=
 =?utf-8?B?QkVBbEVMYnZHdDlhdVBSUENwZmwwQlp4dmJZS0RqdHBEOEhNdU8wS3N6TVZY?=
 =?utf-8?B?WjA1U1NYbXVPcHhpcHJOVXZka2ZRTm1iVXkxMTljaFRrdUJGS3NyTVg4ZEp5?=
 =?utf-8?B?Q1pwWG51WS9GUG1yS0hiMjNSZXNoVURPRWJZNG82MjkwZVBycWMzbEY4ZVFZ?=
 =?utf-8?B?ZklVRFpmVTY4ckRvYXZuMmhId2ZLc0NZazE3eXpWTDFNL0lLYmI5RmZXRCs3?=
 =?utf-8?B?OXMzTkNrM3JEVmdVRks0LzF4MHhXcEtYb01TNllYTjc1S1R6V2loUmo4S1Y2?=
 =?utf-8?B?anl3VzhTQ1V4Y3lNb2JnRTc5MW8xQ2JDNG44dUNKQlpyOHNxdGY5S0dUZ1pQ?=
 =?utf-8?B?Ykh5UUhZaUI3WGk2d3dGZDFXZy9aUUFjWk52aUVPZVBkSjZLSDNWc0pJRVl3?=
 =?utf-8?B?bHBGSll0R0ZRcGp0VVJuT1BMWUJwSUNhUEw4Z0ZZU1Q2UkdWMHM1eS8xYlJU?=
 =?utf-8?B?ZVNubHlFeFZmam5ZOExBOW9IV2N6cmNMT0gvSGNUSzcyM09FNkdDcGxLZzF2?=
 =?utf-8?B?eEVPaXZCaDB4QUQrUTVHZXJPUDJjREpyWS8rbGlEaUJVdWdoT243UzNOekdV?=
 =?utf-8?B?Sjk0OHlPZTZYTHV6c2JsOUlCekQ0Wk4vN1pVaGRkWmp4SVplL05EY29TWi9o?=
 =?utf-8?B?TTlZS1hNbHNBeklHdlRNZTYza3lPeVU2Z1czUkt1c0NIQUVUdTBkMzdvTVFS?=
 =?utf-8?B?c0RxazUwRHhBcEJMc0o2MWtPUko5VmU4MEY5cXlnTU9iZWQwdG1IWGs1TlhL?=
 =?utf-8?B?U2lzSktkQ2lWNHdUS2Q0czk2SCtYSEdNWlltRUYzZlg3UzRkU1FsUWdnNGZN?=
 =?utf-8?B?TVZtdmhXeE95ZUdNblJrZWk2cEJjdDNJNGhwdXdocEg3WTFseHh5bGRxSjFJ?=
 =?utf-8?B?b3Y2SG5xQVhSNkJJQTNqZCtnMlZ4dFNua1FkY2lGUzRBRnRwMkxWU0RYMzNF?=
 =?utf-8?B?bmxEaTJVbnVKcHFXaml5Tk1JeTFoeVhJd3lYQlFFZ3ZNMEU2YW1rTHZWUDJX?=
 =?utf-8?B?T1o3cjBPMkFTMmdubGhPVlE3WkFWQmxsQjh3QUZXd1hKYkwzRUtBblJQRXZ4?=
 =?utf-8?B?UlNHQ2ZzVFZsdXlXb211S2d4V1FWVmEvNDlvMGNic0VuUWpVYU5ERXhLeEVj?=
 =?utf-8?B?c3FDQVhqb09WV2ZnbHRvRDk4QnV5OXh1RWxXUmlwMWJCTE1ERWRldVlBSTlX?=
 =?utf-8?B?djJZanhOQ2tNQmRKV2hxcGFsMFBSK05iQUE3SzVtNDFOdWVuOEwwM0hsYkVJ?=
 =?utf-8?B?dFg2cVJkaWNCMll3dks3U0V6emFpMDlZbEFZVUdtYzVqLzNPUnVrL3ZMcHRR?=
 =?utf-8?B?WTFpZ3RVVVplMCtucERtSU9TMDNDRG1ibHhlVzRuZnVhcHI0cUcvbFZzZUE0?=
 =?utf-8?B?bW5HN0sxaFlJbnB5QmpWQXVSSmJUdlk2UCtkTGZleWJvNzdyMGJldllBamFk?=
 =?utf-8?B?R085TmlaY21mZjhPdFo1a1B5SjlhSHl3US9YdExvUnNqYVlHODJTaEM5MVFV?=
 =?utf-8?B?VWJHQm5CYmpieXdpNmN6bzlqSms4U1RYa24wOUx6cXh6ZTlielNaeFc0c1ZY?=
 =?utf-8?B?SEpWTjByN1M0TTNNN1NNU3pjZmVuWGJRZVA4TGV6WHBlanBnTWszb1drZDlT?=
 =?utf-8?B?WUZBZ2tERGI4eFEyaThmeVVYNVRsajllN2l4Q3cyZVl1ekdFM1lFbFlMb2Ju?=
 =?utf-8?B?cXFDTGQrVHIvZWhUUk1teHNOZGg1OXk5enFHL2l6bnFGSUZwTlBENjd5NkFW?=
 =?utf-8?B?cVk0cGthWEx2aUVHdUVKekxBd0NRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94686076-6d24-4632-b032-08da0020db8d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR0201MB3460.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 09:57:15.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8I8n+GISkpOJsPKW5EgCEK5kx74ltdmcRJ0EfcECf0fN5odE4BCNfkPXAYHLG71BqDvZ6c7ve9LLJ2awinWOZ+oGXZn6uR63OmtUcKNMyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7819
X-Proofpoint-ORIG-GUID: 2oA293ugoFreLwohqQLoLUuiQUdp22BQ
X-Proofpoint-GUID: 2oA293ugoFreLwohqQLoLUuiQUdp22BQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05-Mar-22 9:49 AM, Yu Zhao wrote:
> On Sat, Mar 5, 2022 at 2:17 AM Yu Zhao <yuzhao@google.com> wrote:
>>
>> On Fri, Mar 4, 2022 at 5:18 PM Minchan Kim <minchan@kernel.org> wrote:
>>>
>>> On Fri, Mar 04, 2022 at 05:55:58PM +0000, Ivan Teterevkov wrote:
>>>> It makes me think there may be a regression in MADV_COLD. Please let me know
>>>> what do you reckon?
>>>
>>> Since deactive_page is called, I guess that's not a regression(?) from [1]
>>>
>>> Then, my random guess that you mentioned "Swap" as regression might be
>>> related to "workingset detection for anon page" since kernel changes balancing
>>> policy between file and anonymous LRU, which was merged into v5.8.
>>> It would be helpful to see if you try it on v5.7 and v5.8.
>>>
>>> [1] 12e967fd8e4e6, mm: do not allow MADV_PAGEOUT for CoW page
>>
>> Yes, I noticed this for a while. With commit b518154e59a ("mm/vmscan:
>> protect the workingset on anonymous LRU"), anon/shmem pages start on
>> the inactive lru, and in this case, deactive_page() is a NOP. Before
>> 5.9, anon/shmem pages start on the active lru, deactive_page() moves
>> zero pages in the test to the inactive lru and therefore protests the
>> "blob".
>>
>> This should fix the problem for your test case:
>>

Thank you, it does fix the test case in 5.17.0-rc6+.

>> I'll leave it to Minchan to decide whether this is worth fixing,
>> together with this one:
>>

I suppose add_page_to_lru_list_tail() makes madvise(MADV_COLD) more 
"insistent" with moving the pages at the end of the inactive LRU, but 
perhaps that's aligned with its purpose?

Cheers,
Ivan
