Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB41D592F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbiHOMw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiHOMwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:52:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2109.outbound.protection.outlook.com [40.107.21.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDCD1570B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzGOazLuX2zGQZrzcbiLsmSApL/33xD22R2rksvWYTA9YmLDWhzqiETT9pAyrvRXC05NpcjmMfjdGhpo7Zco+cWziRvkyKiW4Xmd/aZzpzD/U0nO6Pb6MOOFkjr8vPbFj537LBWP/f3KvoIOt4PRg9cT9cMs+iDrHx8ro7WWig7Oif6e9ZkjLsAJZsHt3z3dqJ0Ylji6r1SpFqkDkpbESbBVvcpE2bL0gwm1+HTs4MsNBmGFff/nVyfdjYlcQZV4fejSQ04+hAlJ/r25FaPiSvArUACRz13JVhj+k9pfC1o7RXm4lrb5sQlhQzpJu+zc+2/BKMSHIdTZrWT0aXfaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkYwojgB8z5gxe9xhmtCrLcict7KZBg75hryBHiGA6w=;
 b=oPcOoVkFLVJmraK716SCJL4YSq8VNIiXIbP+cyl8tJlk+JMjz+p8pRgBjBAGS1ZAcjt6ArJpMsVkmwtsENfAtDeLwmlMLyVbRh3JSd8m/PUSERV35kaphPMyq2RNm6Rxdz0MkymTYYITzfdwJoGPyu5DZn1ivPINqq81RlPTjdEa3L9G3Hgcxpw+CMkkkCkf683udL9GRG1YTbPYXbmdr3WznRh9IjayT7+6TESMwG/N0QP1hMju1goDDs0oBBUzTq4iCc8qepqxV5NR50Lmzhs1emuqPfyWmKLR2nubxqn5Z1i6mccXAlHlg/tFosoEL4cyZCcv7bpIeomQJHR0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkYwojgB8z5gxe9xhmtCrLcict7KZBg75hryBHiGA6w=;
 b=kzbO6WgBToBXGl8azTntBD+ljOSYMmYDoGbAoPifbO9JKk9APdx2h/qfh9+RmScWo3W/OKFKWhElKb/NynQ+GWGE012ySdOczCbCb3qiRDseBFoj6XgVrjJoEak46RTAI3u9OnNHBwOV1+U/NlA2mpRWE8oQhaQbRykTQLY27SZ7JBj+6kr3cXbXCSErodFNToqZqp4JEex6jYBqLTUfnfbaSV0PPzo+RICnc9Mlxj5KzosL5EjkrEOstU+vyb0pSy4aTBvFovEbxPcL/FFWMReaT/mxlfRCFwebIxnOC2tGqT9TnLwkVsAKRx3dMTN+vYNAFB/6+LoV+BiY8ANWfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by AS8PR08MB5895.eurprd08.prod.outlook.com (2603:10a6:20b:298::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 12:52:19 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841%5]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 12:52:19 +0000
Message-ID: <93df4e05-30d7-8176-23a6-948c1bfe4225@virtuozzo.com>
Date:   Mon, 15 Aug 2022 15:52:17 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v1 2/2] Drivers: virtio: balloon: Report inflated memory
To:     Nadav Amit <namit@vmware.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "kernel@openvz.org" <kernel@openvz.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
References: <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
 <20220809095358.2203355-1-alexander.atanasov@virtuozzo.com>
 <83B75FC4-595D-496B-91EF-ECCE16D1E2CE@vmware.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <83B75FC4-595D-496B-91EF-ECCE16D1E2CE@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0203.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::24) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72e1a3a5-4deb-4c53-d542-08da7ebcfd45
X-MS-TrafficTypeDiagnostic: AS8PR08MB5895:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3q93t9/Vl7gAw5UpoZNoXxeGqSiztXbO+73pUjmeuSRMuTeTflzts6mEOpvlpW66IS78CZYEVo/cdQHFyL4FU4mTfNNdRXgHOEuNOfAiXQeeEYgdDhGK/fk6tk8KeSvmImEY0etQk5gwPKMbeSyZepXiqo/p+dyntSdWAeAO+EEahlDjtjCX48amEF0xSeImCPwWmAszrgviFkNt8xO0VBZCmib5XjvVcc9kLHMJ2dxcnQRGY5R7nbzfwfDDC1NYctgpxACS8sSu+UDorsYWSkIH2Zn+bl2WlCU3n+5RWDMWfONW0gHZjsMqeEa8w5bp6erg6q18IM1J+Su7Ft1/Xg+hOhS1Y4u4y1G8fOHISiMqxtVimXvCjWlmBhtQ5l4vt4bnFNswKdIfa68Os+lMotXr3TRS6UvnLGwABM4r9SO5g5/xsaNcVhf45CSartMpZrA88MItZ1Qi/vELJo7PTIOhWoN9k1gD7sdXvijbutDE/2e/+oqcbWYMSUj0suG+Z1jRpJ364w42S/zThPNG9YnnYOOgwqjB2AQ1MvO9k2QMyhhrlQGDZtoMOW6E20QTDeM97P5pmdQcAZDXw9KE1YE37xM3xAOpfNTqcoBRZ0xSTCglXWsk/Hm07gFfO6RmSXoeIowIkJVyHijjSM7maEpzzAP3lDoyNnF+PU5NsBu/wfEUmk1MGtJS2R3/v9Rhlw31AM32UlcWEAjqX5u4zf03X8+1xYPekuYRi3IrXHQDv3WJ1POYLEYhfyaKsmzj/mm7GS8VXhQaRncfETqDhGCvDlrUnyOkX0MozSbys0FlyCTqtKF2CowAYKVn0UTiNaGAsALu3qXHhWJXncZhdBSmKfZOLWb/7EDjRtlNQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39850400004)(366004)(396003)(41300700001)(316002)(478600001)(54906003)(6486002)(26005)(38350700002)(38100700002)(4326008)(66946007)(8676002)(8936002)(44832011)(66556008)(66476007)(5660300002)(6916009)(2906002)(36756003)(53546011)(31686004)(186003)(86362001)(31696002)(6506007)(2616005)(52116002)(83380400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTVzNS9oUjIwcWE1S092aExmalZReU9iV244Z0l4aUhZUzJETVk4bm5VK1R1?=
 =?utf-8?B?cjlpRXhTWjFQWFJKRVV0UERBMEtPRWd1c1lTOUNxcFhhTFdrQXhDcytaeWR0?=
 =?utf-8?B?N1Zibmg1Z1ZZQWEvY01YVXBNcW8vOVE0aFkvVE5RQnRtREovdkg1eXF3UXlD?=
 =?utf-8?B?UGl4SXlpckFTc3R6bktXVXp1cnFPYUlYTTJEaGlZVlhlaTlWR1BzdjlaWkZt?=
 =?utf-8?B?K0VUWlpyOHpqQ3Bpell5cFkvb2JSWnJCM1owSCtDWlJNRmxwaHQ0N1puckQy?=
 =?utf-8?B?d2dCU1paVEZNRXJ3dGJDekMrQlltcDZGOEZFKzhMdnI5YmxmbUxMOGUvMTJJ?=
 =?utf-8?B?czEyckxLYWkvdHcyLzMzUkIxRnJIMVhUTElIWnpWQmQxRXpycDhnb3VJbzhr?=
 =?utf-8?B?RDhuWUxSSGlIZ3RtODlZRzQvSXpyU2d0cTd1QTBQY1drR2k5NENYWHF6Z3l0?=
 =?utf-8?B?NkdHZHVGVk5FYWtVTDRvOGRvamZOMUVkdy96S1F0ekhvMDRQV0J6bmQxR296?=
 =?utf-8?B?d3p2dWpYWmxpSHhnUElnakt2ZTRzWU13NUhtQ1RBeG5ueW41dHNJaUtaMW5h?=
 =?utf-8?B?K1RFZ2Z2cjFzZ0xXQ1hUSTFjdWhpakFNT09ZaENra3Z2WGlTeEhZcjlYTmFa?=
 =?utf-8?B?VWp1QzNveTNMdWVVODNzMzNzWHJrNmFWbXAzaEhFcXcrVW1YaGRFZGF0YWhJ?=
 =?utf-8?B?RHYrN0NqZkQyazFyYkhwSWNRVjFDUWpkU0c4THpqK0x5N1Z5ajkwNzNDdW4z?=
 =?utf-8?B?VWJLUkdjUVZLa0V0aXJmc3RoMG9EQmtPeVBiRndyNSs3S0lNazM1UUtUdzhR?=
 =?utf-8?B?QWFXTUpGYU9JMW5ZV1l0TmllV09uQ1FZUUUwRDNsQytMMURuRW1mdHpWWlNx?=
 =?utf-8?B?aGZtYzZuMC96eDU4YjU3TndIMlJnMkJzYVUwQTQreC9GWWdKK1FSd3JoSnA1?=
 =?utf-8?B?REtTWjZSWi81ZW1LelVoalg4MTY2N25zRHBtLzhsQys1ZmtCOGp2WGlFNk9E?=
 =?utf-8?B?TGowTjFYYVo5UVlXdkIyOXdYRS9lejFoakRrV0RVRFFYbXJPend3ZzlaSU85?=
 =?utf-8?B?N3pCRHBxVWpLaVIyWjVQTUVuOGEzQ0FtVnpzaXRyNFMyMVRpUUthSTgva2g2?=
 =?utf-8?B?YmE0Q1NPSk51R3djUUF2VVk0MnlBOE52ZFpoTWV1bTFmUG1FQVh4cDRkbWIy?=
 =?utf-8?B?N3RmdHhZdjREZTBZR3F2aWNRaGMreEdYblZJYUt0bXJxMWVHNkh3Y25FUjRy?=
 =?utf-8?B?VW5BNU1FMFhFLzU3eTZKellUU0RHWG5tVHRvY0I3K3ZBZ3lLeGtRUTgyZG5m?=
 =?utf-8?B?eGhVRkNYdDBCV1NJR3J3VTJHcG1lM1NYN2V0bllWSzRMRGNjSnRUcHd5dlY0?=
 =?utf-8?B?bllqc0JRMStRMnFQSjljSkE1OHhxekRjK0taNkRkMDZ6MkNqUkZUQUNLTkdI?=
 =?utf-8?B?VVRMQWxFWnNyQ29rY0ozNkNLT1dUZ2lVdEZLRDFHWUx1RFVyVVc4OCtsaG9E?=
 =?utf-8?B?R0Q4dlNPSmtFbEtOWW1UNGRaSVpoTjFuMGZJNEdWOXVIZEpXVDQxOGZHOWtl?=
 =?utf-8?B?bjNack9DcHI1MW95NkZtRXFyYlAwcGMwN2UrK3dod1kwYUw4VHpwMmk3amht?=
 =?utf-8?B?eDJkcURiZ3dnTzZiNHVWd2lXbVhoK1NRS244UzVPdkg2d21UUGYralFBM1JB?=
 =?utf-8?B?enNCenNLZ3R1alFIUTBTNmVFZE5qdForUFg0VUhnWDNiZzFtbVF3aEF2cmZR?=
 =?utf-8?B?QWpTZnZ1ZmR1emJ1VmNQa1ZwMUNtUjF3NnFGNnk5RjBJYjRtMUtJejdrRlNR?=
 =?utf-8?B?TEVuRkVZME5ETGNvN210WmJHU3hPTm91K0V3OFVVREdOZ3YydVEzekxYY2VH?=
 =?utf-8?B?ckxKb2FycU0yTWg5N0owK3gwLzR4RTkycUQ1SEZ1L0tTNnJVM0VUZVdJNlBv?=
 =?utf-8?B?b2ljMDBxRjAxUWFSd1FFcW5XZmZsME5wQnpERSs3THlnQjBQNkxDd2FSamM4?=
 =?utf-8?B?M0dzWG1VcFZ4ZEszUkJ1L0d6LzVIUyt5QjZyYi9RamNYWlpUVUVNSGhEUHZM?=
 =?utf-8?B?Mm5xWUhjbVpqNWQ4OUkxaDhTZzd1WmlWaWJJeTNDUnBiZ3lLOHNVL0I0Mnpq?=
 =?utf-8?B?RkdweGxNd3ZwcWkrcUhoVjlIVmg4clBMaFpXdm54cEZoQnFpNFZHcnpmV2Fs?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e1a3a5-4deb-4c53-d542-08da7ebcfd45
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 12:52:19.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMv5DCMw7j08nTZGmL4Zi8inVrvDw2TCQa4B9R8NrH7KNJdJ+uCTD0r22X8Th4P6+mOHGbVe49Qk18ikYKvc+VrhVlLIA4NjtU8D1hsiBpTlitZ7bo9EOH35DKEPpbdb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5895
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9.08.22 20:44, Nadav Amit wrote:
> 
> On Aug 9, 2022, at 2:53 AM, Alexander Atanasov <alexander.atanasov@virtuozzo.com> wrote:
> 
>> Update the value in page_alloc on balloon fill/leak.
> 
> Some general comments if this patch goes forward.
> 
> Please cc pv-drivers@vmware.com in the future.

Ok.

> 
>>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Wei Liu <wei.liu@kernel.org>
>> Cc: Nadav Amit <namit@vmware.com>
>>
>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>> ---
>> drivers/virtio/virtio_balloon.c | 13 +++++++++++++
>> 1 file changed, 13 insertions(+)
>>
>> Firts user, other balloons i will do if it is accepted to avoid too much emails.
>>
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index b9737da6c4dd..e2693ffbd48b 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -208,6 +208,16 @@ static void set_page_pfns(struct virtio_balloon *vb,
>> 					  page_to_balloon_pfn(page) + i);
>> }
>>
>> +static void update_meminfo(struct virtio_balloon *vb)
> 
> Putting aside the less-than-optimal function name, I would like to ask that

Right, i will think of a better one.

> any new generic balloon logic would go into balloon_compaction.[hc] as much

If it is going to be a place for generic logic may be it should be 
renamed to balloon_common.[ch] ?

> as possible. I made the effort to reuse this infrastructure (which is now
> used by both VMware and virtio), and would prefer to share as much code as
> possible.
> 
> For instance, I would appreciate if the update upon inflate would go into
> balloon_page_list_enqueue() and balloon_page_enqueue(). VMware's 2MB pages
> logic is not shared, so it would require a change that is specific for
> VMware code.

I looked at the code and i do not see how i can reuse it since
BALLOON_COMPACTION can be disabled and as you say even for VMWare it 
would require updates on other places. Looks like if i do so i would 
have to handle update from each driver for both cases. I think it is 
better to clearly mark the spots when drivers do their internal 
recalculations and report to the core. I see only VMWare is using
balloon_page_list_enqueue , virtio balloon is using only migration and
i don't see how to hook it there - i haven't checked the rest of the 
balloons but i guess it would be similiar . I agree it is a good to have 
a common place for such logic but it might be better of for a separate 
work in the future.

-- 
Regards,
Alexander Atanasov

