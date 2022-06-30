Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB356174D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiF3KJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbiF3KI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:08:59 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80127.outbound.protection.outlook.com [40.107.8.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B58443CD;
        Thu, 30 Jun 2022 03:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE9O7T4zSudWHhWFfGm022euRLtvb5mWR4vd3A2hiWFvqaIjAEZIsGkG6VaDUdZpTffWAe6U8Z9a5vbupEWChmXz+emVjusVbOpgv9WeNgNevCJEVlMxuMun9/710XE+ONW7ZLWOunXQnzi9EeaLIq1QMr6tBDAOxXx6vlVvx13j/VzesmoT9Y8M2no1SUKkN9TTzVIZ02B3THwsHx5+rEc+90L52TFHbqpCljGEBCyHYNQSom61JQHzyOCB28mukH7A4MV60xytM6l7he7KPuf0uuyZlOdIaHXair6Qgwm5JBZMv45ctOpNOjwY9oYGyG2PEYkgJcn0lx3v9tYqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX+VOKs9b8n5CO2f75iDPS/QHWfkjXSCf2VETGHVh9Q=;
 b=KtX1/J9c8K/bxi7N7D9MhT2ZnShVFCrhBX5qDHnAddvpRpRQeWqXYWfiuVUuiv24+pxHVecftsk5LrwADDOkPxd/8ufu3v1pK4yHWA6etjg6lw91fvB6X6AtGdyuwk/QPx2yShvoJkvwhsAdMlVwx5gzc8mIOVc66KtERMl1p1bCYDM7QNAqMoj+htidTftN51AhcjE7RvkpST5WkhNiic9r4ueEb8zC6V36Y8rCm7CfKsvl5rczZHxTnfs1v2juuGeytLgdjXM0UpDFThP7TgRSDbeu4xFDEyKGGRIxGexP/PtPkmtCFZ6OSzQrI8zZ3kFCwMLcPqlYwV8iKk9eYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX+VOKs9b8n5CO2f75iDPS/QHWfkjXSCf2VETGHVh9Q=;
 b=STtUHwz88OdkYKw4cfevgfYVczRHdhOn2GybBL1vMJWHjF1o8aNgPo4brW1q9/F3HmYozFFE0hqwDQAmdTC8TjTQzQClSJTUxrzSzIvwnBJirXOsAsvlFT0lbvxJIZFxPXdlbDXEDvUTprckcdedK5FgExrD9RIjKPipFYR09ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by AS4PR08MB8242.eurprd08.prod.outlook.com (2603:10a6:20b:51e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 10:08:55 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::60dd:9fed:c95d:e54]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::60dd:9fed:c95d:e54%7]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 10:08:55 +0000
Message-ID: <1c72645a-f162-2649-bdb6-a28ba93bccd2@virtuozzo.com>
Date:   Thu, 30 Jun 2022 13:08:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 1/1] virtio: Restore semantics of vq->broken in
 virtqueues
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kernel@openvz.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220630093651.25981-1-alexander.atanasov@virtuozzo.com>
 <20220630054532-mutt-send-email-mst@kernel.org>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <20220630054532-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0302.eurprd07.prod.outlook.com
 (2603:10a6:800:130::30) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38b8e00a-69fa-48f5-7d9d-08da5a808a45
X-MS-TrafficTypeDiagnostic: AS4PR08MB8242:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnIL9gyrOsNiAYOIghOOOCpORrdfe7DwAnhxwiWG98jZZsq7UPTjUHDiIbm556cX5qWzp6Cxk6r14NLvXpfLd/gZlCQvCliW9basBFtjSBwtREpbJ0K6EmrW4gAaG5LIGNDW1C1E3qbbNP+iqF/DRFkxAi3rfiKS7g/sPslaDfge1A9l33UHFxtYIzp29AEbZDqaXIz0dyYJZuZomVlM18CTDRHAhMIkc4kkoxfCd4g7i1C+Rim8lVnCKhkvw4uIKLwvZPbxf+2+tK4WbvXKNq4ScWVaT3Nl+3eXCV3/EHOrrfHd/48oWJRcZxNsBjm4tUnCudjZuZ653PosoDNRoRqldnWzgb8UT2S9poqxJoXf/zfszz9rFtuUWJNYjzZ2v+YLSoq3k0VyUDKvYohHPZwg1BLljSFNzbFxdcLedllxK8zk6lifXOR9Z9+kYuXDLwkXQDa4M8L13fqAV7fAAFNn/VJUw8/Kmv0eJCkQHrqTT/BikBVGHEPJfVkCe7W3llklathMnMaH9vAoPW2ucmzFFPJCZTokSGsJEL+DmpFQVyrzKIZHV/dXWvoXM98uo3CWP6OOYQqKl3Dj8KinrKk81WNq0qCThT3mjXw6tv3RXUrRgYB3DqvZsFYsmXGm/LIZvEPNrpnJ9o6dOXmWPB4BKQeB8TfIjh64Xf1AXTmwwA2PXR1PmA9e9CY6Xa1LyrFd7Ya73C5Lim12onMfV/AusezdOkIVTDVjthzATQ4hyUIjnbiQb+kKLaKPqy9n9mFn0V8IKtDF+FbWmWjDNBDAaMorBlrkcIQyODwQSrsSZ5wmMeIxbG/i56b5pevydZbh/jQzzx4pC9fChivnm29I6jeUFSuyG7fq8f2EYPmpony0QxBJvebnNUg4K083
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(186003)(8936002)(8676002)(53546011)(6916009)(66556008)(66946007)(66476007)(4326008)(26005)(36756003)(2616005)(6512007)(31686004)(83380400001)(52116002)(6506007)(38100700002)(54906003)(38350700002)(86362001)(31696002)(316002)(44832011)(2906002)(41300700001)(7416002)(5660300002)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDIzNGU0WUVTWU1Tbks4ZnBUanpRMzIveFh5d3czc3ZmMXZpZWFDaURFWjN4?=
 =?utf-8?B?YXczYUx2cFdMZFg3VlRlNGZxZldoSnhkNXA2NnpqMEVraVVxcjI5M0VmRzd1?=
 =?utf-8?B?SkhrS0tnM2Q0Q3NpYXVjR1g4Vkd0VkZDRi8rNW1mY3NpZlcwYzJ4dkkzU2Vs?=
 =?utf-8?B?bEV0WXRaeDNMUlZLVC9WRVd1TGMrdlFISm1LaUdOUUZUMUMvKzZnY0ZBb3Ro?=
 =?utf-8?B?TEFsKzlLNDlBSmhrejdleUhUanFXZmQybVAxbVFnRUlYMFE4TStJQVVmZ1B2?=
 =?utf-8?B?Qlk5N2NwVlg5ZDdNSXhoR29FY2ZMcHNJQUMvUG9qZCtXbjZtcGtuVDdZRmdR?=
 =?utf-8?B?UmZ2azBqNFhBZHFPbnhjQmpGVndRanlRODAwVk1zdys5dnVxdDZQcER1RXRY?=
 =?utf-8?B?K3FHenp6S3NxM1lMZTAwUlVuK2hjTTV0ZnJTNFpKRHBhR1JUSUZubEM0bGp2?=
 =?utf-8?B?Tkk1c0hyRU92SVVkMHBPczZqNXlsVU11S1RTcFc2K2xBeG5OM3JtWko5UWdW?=
 =?utf-8?B?K3BpRHZWL1cvdTl3WTB5RlY2MDJJR0hWY1lEMEJudm15cmZiZVBUeGorSXJQ?=
 =?utf-8?B?cTR4cG85akhGZzArSFZ5Z0xlU2FJbFBrb0p6bjVaZDd4bVlXM1MrM2FhU3Va?=
 =?utf-8?B?a1hocUlaNWpvQ2IyVFZRQVpldS9NaHMvcGU2dXZNZUdCK0JIcTNFakpnZVR2?=
 =?utf-8?B?dDhpTGh5VEhWRnlpR0dFbU5wQWRLSzRZRUtqQ0tkMXVnNHQvL2U1emtJQ1Bj?=
 =?utf-8?B?VG9sVWlRNHRpMGdSU2xsSG1JTE5pTURQZWxqYUhnK0xzRHA0WXJKZUM1YmNU?=
 =?utf-8?B?VjBXanNPZEhHSjNNT3ZKTWViSzFHaDFYRmdpNmplUlR2YTkyVTc4bVZ4VzVx?=
 =?utf-8?B?dzdnVGNZWVNKTEFzTklnR3N5UGVZWHMydEl6cHlJc0tYQW1tMkVaclhBYlJv?=
 =?utf-8?B?MUxtTXVaelRKbUdsRXphMGdrT0ZBZ21HRmxWKzVVVjVVdnlHSkVTYnZhZFVG?=
 =?utf-8?B?WmlEakhhaGZOVEsrS2toSjRzZUJRcGxrTk1jRHVNNFFJL1dVOUwwS1BrNHRH?=
 =?utf-8?B?TlB5QjhoOUtneHQ0RmhFWnJLUzRyeGU5S2hFbHFWaE1jbElPZktxRS8va3Vm?=
 =?utf-8?B?YXNQRllJRGNib1dmUlNUcUt5N2tVUHZPOGxnN2M3alFYVDJNQ0ZmZnhxYm8v?=
 =?utf-8?B?bkUzWk9EMW1BWDJ3T3l1YmRGeHRkOGd6YnZWcUFxSFRobkhEaVM3SllmamZm?=
 =?utf-8?B?ZnhGamM0WmRpUzlyRlk3cUpHNWVwTWl4OVlQTTkwWEd6QTVnVS9ab1owQkJ0?=
 =?utf-8?B?SFozTFZPRGJrL2JqQ3A2d0hDNUxVZnRkNEFBMkZDeStVOVU1V1A0YjJJNzJP?=
 =?utf-8?B?M0lJdU0yQXhTZ2t0ekQ0Z1hiSmhkRnF3NzEzVFB4VHB5ckw0VjhGU0ZJenMr?=
 =?utf-8?B?OThKMlFHNldiRkFaWXZOV1NocXJldzFaeFJZU0lIRkJiZ0labko4ZjQ5amRS?=
 =?utf-8?B?aXhTbXJaczFtOUo4N3pUZjFmUmFQWFpJTnRJczlYNVVUWnpTM1VtRWhVYUZP?=
 =?utf-8?B?d21yOUlNQmNYRUUrWmJMSG9kL0pSWlJsTk4xbjkrSzdwZjUyeVNYUVBsR1o1?=
 =?utf-8?B?WGFnYXU4NWw0Q2c1cTJSMEdVSnNsNXUrQzZaSU1MR3gxNTR4dXNKZ05tQ3gz?=
 =?utf-8?B?cnUzSjVCRDlnQTVwRjEvZ1BZY3c4c28wUHR6MGRNTEd3ZlFGOHM1dms4YTJj?=
 =?utf-8?B?eDdwamRuQXFVUVc4a3YrOEtlbnV5SFpKZkEwYXV1UmdnenJvMndyNE5kQjhr?=
 =?utf-8?B?S1YyQnZyU2F0MmlyYnVqOWNmcitKWXZ6enFaeWp5TTlZd2E1VjgxZTJzS1gw?=
 =?utf-8?B?OGxSMEt3YTdGSWxkVm84bWZVeVVSOVNpaFVLOFhIUFF6cTF3QXQrb3B0VUpX?=
 =?utf-8?B?NHhOdWFtNFRRZTNOMTFodXZRRmNCVU9FM2hkSXZOcG5Hd29ScWNkbUFLazNv?=
 =?utf-8?B?bWk2TnFoN3Z4N3FIWnZ0ZTgwTisrbURnbkdoaDVNdG5iTEtDMUVUY1VqbVRE?=
 =?utf-8?B?WDVoRnJSaFliWkxkdXBBOE5jTzA1b3B3TGVyajlPeFJIWnAyRitReDZ0eS8v?=
 =?utf-8?B?YXA5N3IrbGtMQ0U0TURYWXlaaCsyZEdGQlFRTXgyNnplcWxMMWFHay9FVVdB?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b8e00a-69fa-48f5-7d9d-08da5a808a45
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 10:08:55.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3nFc7jM/m5DbxAlxPMxN23u7mod1jf0Xiv7+cU3Wv0eNr/0oSPMi0xg+6+94BaDgRP/bPXEhZ5WybR+XtwozjWKDiIKFk0RKvFETC+4FtOXPc/18pEF/EEUakIoDaKQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8242
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 30/06/2022 12:46, Michael S. Tsirkin wrote:
> On Thu, Jun 30, 2022 at 09:36:46AM +0000, Alexander Atanasov wrote:
>> virtio: harden vring IRQ (8b4ec69d7e09) changed the use
>> of vq->broken. As result vring_interrupt handles IRQs for
>> broken drivers as IRQ_NONE and not IRQ_HANDLED and made impossible
>> to initiallize vqs before the driver is ready, i.e. in probe method.
>> Balloon driver does this and it can not load because it fails in
>> vqs_init with -EIO.
>>
>> So instead of changing the original intent ot the flag introduce
>> a new flag vq->ready which servers the purpose to check of early IRQs
>> and restore the behaviour of the vq->broken flag.
>>
>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>
> Does
>
> commit c346dae4f3fbce51bbd4f2ec5e8c6f9b91e93163
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Wed Jun 22 09:29:40 2022 +0800
>
>      virtio: disable notification hardening by default
>
>
> solve the problem for you?


No, it won't if CONFIG_VIRTIO_HARDEN_NOTIFICATION is enabled - balloon 
still won't be able to init vqs.

The problem is in virtqueue_add_split and virtqueue_add_packed - can not 
set driver_ok without queues.

The return value of the vring_interrupt gets different - and iirc 
IRQ_NONE for broken device can lead to interrupt storms - i am not sure 
if that is valid for virtio devices yet but for real harware most 
likely. Either way if you have a mix of  drivers working differently 
depending on return of the handler  it would get really messy.

RR's original intent was to flag a driver as bad why reuse it like that  ?


>>   drivers/virtio/virtio_ring.c  | 20 ++++++++++++++------
>>   include/linux/virtio.h        |  2 +-
>>   include/linux/virtio_config.h | 10 +++++-----
>>   3 files changed, 20 insertions(+), 12 deletions(-)
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
>> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 13a7348cedff..dca3cc774584 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -100,6 +100,9 @@ struct vring_virtqueue {
>>   	/* Other side has made a mess, don't try any more. */
>>   	bool broken;
>>   
>> +	/* the queue is ready to handle interrupts  */
>> +	bool ready;
>> +
>>   	/* Host supports indirect buffers */
>>   	bool indirect;
>>   
>> @@ -1688,7 +1691,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>>   	vq->we_own_ring = true;
>>   	vq->notify = notify;
>>   	vq->weak_barriers = weak_barriers;
>> -	vq->broken = true;
>> +	vq->broken = false;
>> +	vq->ready = false;
>>   	vq->last_used_idx = 0;
>>   	vq->event_triggered = false;
>>   	vq->num_added = 0;
>> @@ -2134,7 +2138,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>>   		return IRQ_NONE;
>>   	}
>>   
>> -	if (unlikely(vq->broken)) {
>> +	if (unlikely(vq->broken))
>> +		return IRQ_HANDLED;
>> +
>> +	if (unlikely(!vq->ready)) {
>>   		dev_warn_once(&vq->vq.vdev->dev,
>>   			      "virtio vring IRQ raised before DRIVER_OK");
>>   		return IRQ_NONE;
>> @@ -2180,7 +2187,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>>   	vq->we_own_ring = false;
>>   	vq->notify = notify;
>>   	vq->weak_barriers = weak_barriers;
>> -	vq->broken = true;
>> +	vq->broken = false;
>> +	vq->ready = false;
>>   	vq->last_used_idx = 0;
>>   	vq->event_triggered = false;
>>   	vq->num_added = 0;
>> @@ -2405,7 +2413,7 @@ EXPORT_SYMBOL_GPL(virtio_break_device);
>>    * (probing and restoring). This function should only be called by the
>>    * core, not directly by the driver.
>>    */
>> -void __virtio_unbreak_device(struct virtio_device *dev)
>> +void __virtio_device_ready(struct virtio_device *dev)
>>   {
>>   	struct virtqueue *_vq;
>>   
>> @@ -2414,11 +2422,11 @@ void __virtio_unbreak_device(struct virtio_device *dev)
>>   		struct vring_virtqueue *vq = to_vvq(_vq);
>>   
>>   		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
>> -		WRITE_ONCE(vq->broken, false);
>> +		WRITE_ONCE(vq->ready, true);
>>   	}
>>   	spin_unlock(&dev->vqs_list_lock);
>>   }
>> -EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
>> +EXPORT_SYMBOL_GPL(__virtio_device_ready);
>>   
>>   dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>>   {
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index d8fdf170637c..538c5959949a 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -131,7 +131,7 @@ void unregister_virtio_device(struct virtio_device *dev);
>>   bool is_virtio_device(struct device *dev);
>>   
>>   void virtio_break_device(struct virtio_device *dev);
>> -void __virtio_unbreak_device(struct virtio_device *dev);
>> +void __virtio_device_ready(struct virtio_device *dev);
>>   
>>   void virtio_config_changed(struct virtio_device *dev);
>>   #ifdef CONFIG_PM_SLEEP
>> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> index 49c7c32815f1..35cf1b26e05a 100644
>> --- a/include/linux/virtio_config.h
>> +++ b/include/linux/virtio_config.h
>> @@ -259,21 +259,21 @@ void virtio_device_ready(struct virtio_device *dev)
>>   
>>   	/*
>>   	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
>> -	 * will see the driver specific setup if it sees vq->broken
>> +	 * will see the driver specific setup if it sees vq->ready
>>   	 * as false (even if the notifications come before DRIVER_OK).
>>   	 */
>>   	virtio_synchronize_cbs(dev);
>> -	__virtio_unbreak_device(dev);
>> +	__virtio_device_ready(dev);
>>   	/*
>> -	 * The transport should ensure the visibility of vq->broken
>> +	 * The transport should ensure the visibility of vq->ready
>>   	 * before setting DRIVER_OK. See the comments for the transport
>>   	 * specific set_status() method.
>>   	 *
>>   	 * A well behaved device will only notify a virtqueue after
>>   	 * DRIVER_OK, this means the device should "see" the coherenct
>> -	 * memory write that set vq->broken as false which is done by
>> +	 * memory write that set vq->ready as true which is done by
>>   	 * the driver when it sees DRIVER_OK, then the following
>> -	 * driver's vring_interrupt() will see vq->broken as false so
>> +	 * driver's vring_interrupt() will see vq->true as true so
>>   	 * we won't lose any notification.
>>   	 */
>>   	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>> -- 
>> 2.25.1

-- 
Regards,
Alexander Atanasov

