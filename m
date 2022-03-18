Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56EA4DD35A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiCRC7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiCRC7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:59:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF3897B98
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLjZIbXBUS5tZFQfhwZ2OOrBVrdzHrhp7ifRbz8aQAuQcd2rp64wJiKmvhznrHQmsFql+6X7kOujC8otuVgrgj/kqdZgLkZASzANNRHs8HGSgvjIuDJK95BT+1HZjIuM7EqeAFbfzA1NydfzoUT14T99RoNpRuwHEDQpD0xzCT62bMqvwJjTH1nS7x0bowRwJRBtjXjhno3hNEuQ0bQLl9eEcnaTeGHG2g8Xe4i12FBFmMlxL/ChRuHfCqMqf1E4w6XRlhEEQzZuO6JT03SXTFmdxnOGj0HQ31kFjUZgx/BBJ3jf5zfCsNo6sWDayyNsrj5jKdd+NcjDh9mmx6GbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HeoyrxpRMZTcjL40JqJ+Q/atcKUi60a7sDHIPin1ME=;
 b=fzTqS4TxfNGcYN16OaF2XBgWGbPtVvHg84w4n9E2pqZh1K/zUwXw5gD4GY9r5VdZ6/jR/bDv9kBTaqhrhtqH/nrtkfL+Rtz6PiRap9WFjIHA5oL7zcOxba9ZlsXG8xvLp3HpQ3ev0k36ZBkgKx3m2hxpQeO8ZeZ9JBhiLaWPE3qywkRwa5VUNnTUXoB13GJbM1bjTteKjF9LckVjHOyKgpUmyCiej6gwKixWTfANdu0JngyxM5ze/TM4ykdBdYjlcS/a9QQ+8vz2jxqqOv8IHQrZxObWa6mHUl8tlM74DsnWNQRmBGgdRfSFFGDtVuGL5AuKobD+QQR1K6i/fM1wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HeoyrxpRMZTcjL40JqJ+Q/atcKUi60a7sDHIPin1ME=;
 b=IrlhYwBS7L4w1bUhjl0TflCuYOChr0eFx8YhkV7VnzlmfSDvuF2Sj4JrypSh0vTRcS6CD4mdivl6Svl6NrTfk07TPDkS991gBDSdv3qp8v5zyxWRSvHPlgaFnsHfRdA94oQB0g7k3G1adhX81FJdZ2B7W0aNJlNAimXydhqKTgeD4NJkTGcO3V4ZOstBS0q34Y4vFaXKbY08tZq78kBS0ZvIBbynfoKaGf55Xmtw7WlJ5yN4RQ2F30y15vnGhMK1WJDnomuwoI5I8l7qLL8pLy5z9AbBhW64wChF2RVDpu4L4RwcSTTuuPfnu8hP16I4ULd7JZryhMSUnq2ETcX6Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 02:58:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::b4d2:1b8:7a7b:fdcb]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::b4d2:1b8:7a7b:fdcb%7]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 02:58:28 +0000
Message-ID: <b3d5e596-adce-20b5-73cc-89c07917082f@nvidia.com>
Date:   Thu, 17 Mar 2022 19:58:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice
 instead of char dev
Content-Language: en-US
To:     =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, rcampbell@nvidia.com, vbabka@suse.cz
References: <20220311033050.22724-1-mpenttil@redhat.com>
 <20220314182439.GB64706@ziepe.ca>
 <d9b9c82e-4012-cf0a-d966-d9669a684a27@redhat.com>
 <20220315183922.GC64706@ziepe.ca>
 <8e836d75-97b0-d301-4d6a-92025e91cad5@redhat.com>
 <0f53c5ff-1711-861d-9a12-0634d4ab9fca@redhat.com>
 <20220317141539.GD64706@ziepe.ca>
 <10fb1261-f22f-8e21-4056-166c283e26f2@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <10fb1261-f22f-8e21-4056-166c283e26f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5788b68-3d3e-4af2-1999-08da088b2d2e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39631A248E60D75253DC27B3A8139@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRGOdiHzBXOOiRAa7+N/hlxn/2vfyDAcJRksuhtqwsg23PfAIm0betfo4PI4OL2hrFiYeHbAdTUSR/5EPOpeVOU3aembPncymncUugDzPpcsOu6BLsF8UaOudQecIWBGnmRhXIu8FeBQ+l9gugqDKm8puzi6A4SLC395v9d6CeBXxTE0MiynbuYNqpQ3j+8vE5L6pTxGaFzaS3131jx6WZ39ezhauM93VrfqT6lObjFCa0mkE4B+VN0SbzZwbObPLlUf80G5uby/ARJt8W4wRTpEhONBD2roXqLcWpaYQYQEemnBFh920UhekSmfwGJJ3S1mVZXKhXNit+WixTJf5c1F6rlX3i/Oa0llPQ/S3CTn6Maj2UFY+wxrsbW53PelNeLShCZaGJndwzaUFlR6RFuKgWgQJr5cAIet0xMnE81QFk6dKwsIVkjJcZ3kLRMT2dHIhaRdJue9uIaWEQvOeVxJa+3r6bda/gn4rzLNW9jaBJ3EvphMdHp7HbRxb/sodaWTniCwKYm0qSmYdgpMMdDc96gM3j++xXFpBVLkRSWAmeskNit0Pu17BrUzBwvWB3PEwZB3i34SqovCcKiW0C6YTokqSR23Sc0VZkqelwIR8STMmmx+UsF2MeB4j/uQPlBMsDdj5qEgrK0fczi+nHtf5d2gBvvvZ9d8UQ9LOUicRrf5gKhvMA9A+hamDJAHJU3yM2kplVgwcN8d+zLkmbzRolgO5KYmdcNAW5x07r3M68SULDEjOHWcDNe0Es6e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(83380400001)(66556008)(66476007)(66946007)(38100700002)(6486002)(508600001)(6506007)(53546011)(2616005)(6512007)(8676002)(6666004)(4326008)(26005)(186003)(8936002)(110136005)(2906002)(36756003)(86362001)(31696002)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGtGbkNYdGhwdmhISG5FWmxMUXVuMlJzWE5lUVpTSi9qa0ZYOU11dmcxMlVz?=
 =?utf-8?B?REN1MkZtVUJ0eTJZN091dzMreHVobWxqUDNnV0xKMnpTQTlMQ1FwaEhhTlJL?=
 =?utf-8?B?ajRwb2hhV25ORldRQUVUOEUya2N2WHdtU2lWdjRCdTVWY3NnMzhuVk0zZis1?=
 =?utf-8?B?dnY3UWYrYkFrNk5FZGk2MldZSWNIT3VOZW1sSEVjSER0NWgvWC9uMVpmK0RV?=
 =?utf-8?B?akNHM25xM0NLeit0QmdEQUIxdzY3b3ZSS095eGV4YkRTMWVvS3VNcEFQTE51?=
 =?utf-8?B?NnNkOHJQRUgvMVhpQk54Szd5b2wzRnhDNzkrYysrMzdkenBUclQvWHpWaGFn?=
 =?utf-8?B?TTVwZjczVk51QUs2Z09nVEtwazM4bDIrdEpDTkxLQ2xwOHJVRzZQenVkZGtG?=
 =?utf-8?B?MU4zQUFSSXJRS2w2UFNuYlU4cEZtQ2syL1hrTWVNUnk1QS9kMVZZeFRXcjh5?=
 =?utf-8?B?QnRwOFVsWGY5WWpWRU42ZU5QTHVENEFvcktHWXNKcG9US1BDN3Naa0xEQzNn?=
 =?utf-8?B?OE51Uk8ra2dWZlJ2b1hTMnBkTEEyVnFmRWFJN0gxZUdpM2J6cnFRRUFvcTJM?=
 =?utf-8?B?ZEtkSk9xTUk0M3VCSVhmZFZ5OXExbVdDckZqYVE2NnZXTEhKK1k4TDQ0QmRM?=
 =?utf-8?B?ekFSMCtFOU1wNmJxTmgxVmYzTzlrcFdHZExiaWNLNkZjYmpqNHVOcHM3MWVt?=
 =?utf-8?B?MEZqRzI4SVlXdERDTFd1K25FeFNURElYL1ZTZG9ZdUl2dTRuS2JtbXN3Y1Bs?=
 =?utf-8?B?RWZ2Vm1vM3g2WVpLYjFBdllYSER0d3RHbWppdzhDdXJDU0M4NElERGlYTGYz?=
 =?utf-8?B?WnNoNGNhcDRyQXY5bEZVc0hreGlQUmI4QytPNE9PRGIvWVVoaExwS1ZNWUlu?=
 =?utf-8?B?NVZMYWZKQ0owOWNzKzJRQUROL2dLMURjWWg4b0Nmd25CNXJvRkEvUElDalh5?=
 =?utf-8?B?bjRKU1A3TTROa2V2NWhoYmNGcXU3UURROVVZLzkrR2txOXhZS2tFMnFiVXoy?=
 =?utf-8?B?ZlE0U1k2YnVIV1JGUkM3dnFwaUxoNGlEQUVDNlFaN1JSdWhFdGkzTk02Qk1N?=
 =?utf-8?B?VTkrRitpdHhuVTlhbjJlRFphaE84aTJFYnlTN09KeG0rTWUzVmh4Q0hMR0dQ?=
 =?utf-8?B?bzQ3RXA0Ni9Sc280aUtPcnpFcHBsZHl3SXdYRndGMWM1S0VQbkpDTG1uMDlR?=
 =?utf-8?B?ZjEzOVozbkV3cmVyRkdFeXhSbEMzUTZ6dXVVSlFKSVgyNmJLQ3lyY3lPTGxZ?=
 =?utf-8?B?YVkyZ25QL1RybDQ3ck9RWG41ajhyNzcrY0QyZjVibnNNZXNyK2VsRnpROWdN?=
 =?utf-8?B?TWtRdGg2TTlabHNkWVhYdnNaMzhNbkhLb1RwTytqcWF2YmxadCt3Nkd0V0hy?=
 =?utf-8?B?alZIU2sxSjF5ME1YV1MvUkdBN014SDM0cTRuZk02MUdYUk1ucEw3a0FDMklj?=
 =?utf-8?B?RUxJS2h4ZXA0VURLcUkrUnc4YXB5VXV2alJrMytWeFdTYWdMMXgrUXc1VEJk?=
 =?utf-8?B?QlV4WEJEbXZ3cXY2aDB2N1dUNnMzV2g3cGsrZmFIY1dGcVhjcXBibEFMRW5F?=
 =?utf-8?B?cjE0dko0SkJySVQ0ZzRBOHprK0E4UnBzVlZNbnpZUTN6dERBWWY5NGYzVENN?=
 =?utf-8?B?dUsxZ3N1QzFtdy85RGNhK0h1cTRkWkV0aXFrWmhYM091bkhWUkhuVVlxVmgr?=
 =?utf-8?B?TURWUCt5VTlPdWJtaldhakxXNUY0UjZzVGlNMndkSGdZNnkwRGJnTGFWT2lE?=
 =?utf-8?B?L0ZXV3VUWGhLYUhmUGZmak1WZitNT3gvWWJuaDh2TWxBRzh5cUtHZTlzMFdx?=
 =?utf-8?B?ZzhkTjVoMGptcEdIaVdoKzZoZXQxaVhrZ0xRZDBmdysvRkF5VG5zcnltWE1F?=
 =?utf-8?B?eG1NQ0dYWUpmbkJtNnZlRWJFOWQyenVpUVJQMFpIZ0xGajZ3NXlsTzJON3Fa?=
 =?utf-8?B?akdVUjB5bTVSYUhwS3Npd1FNaFRGSmVnZXNBYUFEOE5aWVZGVmlvTXN4SVkx?=
 =?utf-8?B?L1pYV3g2MENBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5788b68-3d3e-4af2-1999-08da088b2d2e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 02:58:27.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VW1WZBE4viztNaGhVV0BSd02jFQamQ1xdXJtTqZ1iy00cvCdzpykRz3+BHDCgK34MsFNG1pbTnTsMmhGYcZ49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 19:34, Mika Penttilä wrote:
> On 17.3.2022 16.15, Jason Gunthorpe wrote:
>> On Thu, Mar 17, 2022 at 08:58:52AM +0200, Mika Penttilä wrote:
>>> @@ -1225,7 +1232,11 @@ static int dmirror_device_init(struct dmirror_device
>>> *mdevice, int id)
>>>
>>>          cdev_init(&mdevice->cdevice, &dmirror_fops);
>>>          mdevice->cdevice.owner = THIS_MODULE;
>>> -       ret = cdev_add(&mdevice->cdevice, dev, 1);
>>> +       device_initialize(&mdevice->device);
>>> +       dev_set_name(&mdevice->device, "%s", dmirror_device_names[id]);
>>> +       mdevice->device.devt = dev;
>>> +
>>> +       ret = cdev_device_add(&mdevice->cdevice, &mdevice->device);
>>>          if (ret)
>>>                  return ret;
>>
>> Right, miscdev isn't that helpful in the end..
>>
>> Jason
>>
> 
> To wrap up, I could send a v3 formal patch with either this cdev way or the miscdev way.. Both 
> eliminate the user space /proc/devices parsing and mknod'ing. Jason brought up concerns using 
> miscdevice like this, although for this case it works correctly. miscdevice also provides a little 
> more cleanup and simpler code, but the difference is not huge. So what do people prefer?
> 

No strong preference from me either way, but I would like to bottom on
the potential problems with using misdevice. The fact that miscdevice is
misused in other drivers does not seem like a reason that it must be not
used here...Jason, after Mika's explanation, what's your latest
assessment?

In other words, given that the usage here is correct, is there some
reason that miscdevice is still a poor design fit? Is cdev_device_add()
a better choice here, for design reasons?

Also, is there any change that could or should be made to miscdevice,
that you have in mind?


thanks,
-- 
John Hubbard
NVIDIA
