Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0D855E400
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbiF1NED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346092AbiF1ND6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:03:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2132.outbound.protection.outlook.com [40.107.20.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E00A101C8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMvfwguHHlnFHZ+dQzx1564PGjKcK3p6HIbtt5dU0tuNdofUxj6Cb2C9ivN+BM9yztBtoOKzV9YahBiSwe31ow0U+Poy27tBqTZOGyxdy/Oq8RzMSRF7FzZVw9YSOUY27rQmEW2Bwb76EougMYYAE8eDcQmISjP7fQaYyd0DWQ0xc8KMtQcHw+Me0EQweZFcXyckbH4MM+T5x+HaCK5CDwhtuh4ye8sM6M1WplVHA4gMNZU9R7wVzSpPGDxDzubBzDYOFk4o1eXivKwzuFeLryOwXZfhxlzXDi3jehNfaGjYMLUAaNdK1meRbMe/n0Ll/AChq1jnqRjq69iPdXC3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN75STyIfwlVxoMKB3m2aqvAjnxz9/sUi9B4/uMCrvo=;
 b=C9NZ7kruR7JotIFl7CQiuabp0oTivZXbwd7d6yGEng6gJ5OPwIL2pnmo+buvOsQDKzH3okw22p21oe2J5AqmeR6SG/9h5kqdBwC1nPgLywnbISSrH0ygSkbJBLpeeUJdzgFsHTyBRjw3ifjlRO6BdalLuBNbhDF4TSi3hYAGcd9PVaVw1gvDuvLwL3hIrpiYRdRZ+8iwpkOYgGk4EqoazhsUyrRlqn26y3ZtJRlv9BejQR2DRoOuXsTM7EXhVHq3OCUoIIY4NmKLTUKWxFL1sBFaJfYecDW1fRxpwmwfvSj0aio2VIX3aR5zvtD4IhPxvXdLACSipkbtky9buRCZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN75STyIfwlVxoMKB3m2aqvAjnxz9/sUi9B4/uMCrvo=;
 b=WQbU+01qEDa8OO8Ggz/txZZQA/Qkohd+6Uvr8i9NOGUgF84U7NN+LP/0SvxOfezyS/UFhNSTuTv7eoyuM5p7QXUgvwjnindjaoGOXYdwO/X06JZzTj3Br/FbP/aBmVDAAXaVwKYvpe5CpEmm3FZ6rh9PieiPyQhWVAhTdcyjmLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DB7PR08MB3900.eurprd08.prod.outlook.com (2603:10a6:10:33::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 13:03:52 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::60dd:9fed:c95d:e54]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::60dd:9fed:c95d:e54%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 13:03:52 +0000
Message-ID: <26f462fd-687a-aaf9-55f6-7b5414709dca@virtuozzo.com>
Date:   Tue, 28 Jun 2022 16:03:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/1] Create debugfs file with virtio balloon usage
 information
Content-Language: en-US
To:     Vasily Averin <vasily.averin@linux.dev>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220627163714-mutt-send-email-mst@kernel.org>
 <20220628092324.23656-1-alexander.atanasov@virtuozzo.com>
 <e20dccc7-8ab6-7c15-7088-e82e67e7ad48@linux.dev>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <e20dccc7-8ab6-7c15-7088-e82e67e7ad48@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0802CA0030.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::16) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfc010d8-e3b4-4111-86b9-08da5906a64e
X-MS-TrafficTypeDiagnostic: DB7PR08MB3900:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XLZS7EqOfVQcVmNMkaJTK4s/WzHt8cFXuhAcAMXDntGQKsBz7bsh5Ccrb8HKTrKIYJsBpPmcWdSw8oNTqnm184v3GdK88+/mmV5k4aUkUYjbesG3uTLTKo4KiajNsH+g8Dy1IPFB87u66slGEZhFisfF8HW9lLi9VPzBObiKF27il9CugGrRu7ls2UM29T0GPRGE0tFfL1p6knKiBWkIejJDrbQxTeX1sJ1TYOPaSdT/xZPqxuFbkrA++qU90UuSzdaBgli8a7VNuCI8qU5ZEkkJoVhUonUi5m4zvAMcKvjSLdh46L8+fS76EmidLKW8tJG4Y4i8WUXH8JZRHgxpk1CORxkrJ3JUCr+trqH3hb/Q8d/wtL7PZx9+MTXTsa9GhHh+gII7WO4RDm9wCYR4N27KT34TJAZaVqy0hffltvZv3zOGACez2yMfiL+DmLHHKf4rGpAfU3D99z4R5nW3KzpRiex49zpGXSO/dn/ICZaIzUU+Qen265phJnrqBua4SQRmdnGYzE9fLMDQWktUS41eGdRNTJ9AEFtI6AZYk2pOchyyp7R5fgYi89sbd2WdpDteslX94SSplYxG4lE+t+ohHMK9uqVrDLjFpoefAtq2SNR1v9zit+cVU8pgeCRKFIgHi4JbKRHBrzU7BY5vdIEsGTUb8UTjQ1TOJPIZNG3MINItJcmOYOERWq7hCZeOHMVySAhYXRjfQQ8P7BZtF46HDun3oyE/jcIcknX0gwPs+yBF+kmE1qNm14OdOpCobEiu73OWDDXGQE1eM8CIbk/Iq7ilyTYA/tZWHfsZID64IgkIzK7t2bB4KxhubBrgppwkOrcehOc4hcdB4QLQndkHS2CVo/DU8Yv3r01IY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39840400004)(346002)(136003)(366004)(396003)(2616005)(66556008)(6486002)(4744005)(2906002)(110136005)(26005)(6512007)(44832011)(4326008)(66946007)(38350700002)(66476007)(53546011)(8936002)(86362001)(478600001)(316002)(6506007)(36756003)(5660300002)(186003)(31696002)(41300700001)(52116002)(8676002)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm1rUG9DeUlmcHFybWdRR2Jja21OeU9pYXlDajNBREZ1anpnSVBnWHNUZ2lm?=
 =?utf-8?B?Q2tKbW9UMjJtZlJWdldqK2N6NW5hcENXMi9YcWJvTC9UMlEvbnhlZW00dkJ4?=
 =?utf-8?B?ZGhrSzF6cTBHV3NTZmdoMXhJMzhibUdHVWhTS3ZXS01aSHhjLzA1c2xzMEl2?=
 =?utf-8?B?N042VU1TKytETllCVUFFbW5QcGNFVUlyYkR6WEFqMVZ4QWYzSmxqaEt6aTBD?=
 =?utf-8?B?YnZMZXV5UHFHemg0V3VQMit0WWZhZzhpY3lMTmwwdkN4eWxWVm9jQ1NWTGVt?=
 =?utf-8?B?YnRhakFVbVQrNGtVNDBudWZ5bHhXenBxR05iYjNGNkJYTkkwMjE1eWlnbnhx?=
 =?utf-8?B?MEtqTjE1Qk9Lc3AxZi9GZURqSExiSTYyaXRvcUJ5MytocGFBSSthcEJqd2JH?=
 =?utf-8?B?RGVCQUgrSVpUSkhQRnJXR0dKRmVrbVEzRGlxOEcvRDBCN1k0cXBnM1NJYlZR?=
 =?utf-8?B?bXRVaWQvVlAvUStwck5hd2hodS9RRXdJUjBCdDl5YnFmU0hEc0ZQNTVYSDVj?=
 =?utf-8?B?ZmQ3VWlYekRhQlh4Q2NMdERTc3BnRXdBWHdVenE0endiZ3VUQ1c1Ti94RHRp?=
 =?utf-8?B?VTlhamwyNU1mM3ZWREhlYUEyc1E5UFdNZG5aZVJzbnlIWklTbWlQTlFCNXBj?=
 =?utf-8?B?MGFRUHNwd2FrbisrenJvNGtHRzZFNlcvWE5hTW82UlhvQzRZSmljNkw3c2p2?=
 =?utf-8?B?aXVyekVDTXZJZnlKTFRaZFFQK3ZYU0JqOXpwY3Nua21ZRUhZOG5YODlpbVRh?=
 =?utf-8?B?Z1ZVM0I3V1JpWnRlcDFuakJMdXV4OWVXdEtYYlU3YVFRZjFhdmwxcVFLN0xo?=
 =?utf-8?B?Nmxvb25kS1pEaC9zdGRkUkJFbDBYM215ZVNWY01qN1ZJRlg2ZmZEWDhROHFE?=
 =?utf-8?B?TkQrcDJ3WU15QUx5d1VWSE9nczNMZGlHdHhpNDRaY0E2cEdQbWJFM3paVC9W?=
 =?utf-8?B?TG1SWUM5bzliZk9DeW9leTk1bGpVUVdidnpoOVp3SEpEMm1TeWpYdnBBdFFs?=
 =?utf-8?B?ZFU2bDdEZmlpVWhXT25sTnFmdHdaWHlob3RVVWExc0RTR2RXWWRjV0dnWk54?=
 =?utf-8?B?Uk5hQW5na1ZyWGpuNlJFclE4L1R6QWhpZDVKV01IWGh0RXhVTmp6d3FISFJN?=
 =?utf-8?B?NHJpRkhrd0Y1d2tnRzViSWRrUDV6WWwxOERDMjVNNGZVLzEwNVJjU3YwRDdU?=
 =?utf-8?B?T0hoRElKSVFYNlhYM2UvTGpwRnVKbWVVRTk2QWlxRzk1bUVnOEhselhQNUJx?=
 =?utf-8?B?KzhqbkhsTnBDVmpEMXNVU3B5bURTZ2pKZWtUVTQ2amlGdjNWRDNYeklxOUZm?=
 =?utf-8?B?eEQvc0lWTXg5ZnNQK1AvVUgzODZ4M1hlM09JV2JJNXZqQmpTNzZ3NnZBYTVw?=
 =?utf-8?B?QjdlZUI4Y1dtN1cyNUhJNTF5aFU5ekNsS3QzbStoZFBDT2U2R3VpTzM5NkJr?=
 =?utf-8?B?OVhYSWJWd1R1d2dlR3JZS0xoTVVtcmRFcGZCdE93ZkJaeStnNHdJT3ZCNkVr?=
 =?utf-8?B?aWlBTm5hQXpTdVZ6T3hjQStTN09jT1lBRkJYOWNGMjNZZGFhcXJhUEkyWHhZ?=
 =?utf-8?B?K21BcXVhaEpQNnFMNVRLWmxtWXhrZGxaSlJRWlpoMUc5UHZtdlZOQ0JLTkFv?=
 =?utf-8?B?MVBWQ3ZCdktJdmVZbUczdHBlTi9rM1ZoVzh2dW1Bd21vYTZyRnNINmhhTVBD?=
 =?utf-8?B?ZnFYZjZSUUpsalB5dWdLZ25BSFBPbWVDVVJOR3Y3cmlqTVlBZWpaTHFsdkJG?=
 =?utf-8?B?TGtHZE5rL1NRUUNzbG9vblZLTGtSU1FlRGIrZXloQVpNV0NXZmd1WjZBVjhC?=
 =?utf-8?B?ZHZCclpub3BucXdRK05sQUFRRTBoRy9hb2J5NG1OWENTb2NGdHh5a0c4NGh4?=
 =?utf-8?B?OFlGeTlLMjlvU3pYclJvNHgrcUJWR1lWUHZKWWZNdDRKQzBNWnl6Z0dubXNs?=
 =?utf-8?B?cUZ4MUlxZUpXQVVadCszWTlSUnJ3REVmMUppY1JpVXBveGR1cDFHREV4UHVM?=
 =?utf-8?B?OUVkZ3JpbXA3cmFqUVJJNVN2TlRPaVdQMm9nL1pjSml3U2pTT0QyYXMxRE8w?=
 =?utf-8?B?bzErOFRGbGFkaGdYNVBmYXRhRm5qYzFSeHpyTkc5MzF6MU1TblIyYVcweW5s?=
 =?utf-8?B?emZBOEN5N0I2TWI0ZmZtSFgrMXU4MWNhOGdpSXpDSlpCNkgwWmVIVkNUZzVi?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc010d8-e3b4-4111-86b9-08da5906a64e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 13:03:52.2592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /R9uhFemHW6jYFyHX/5CfBuryyHZVCnZzZRtToBtxvoSFgSMte2HnCw6/eEYlbNa3EwLpy2j52iK5Xs0lnWlGCxs3sYikyio447/L7nYCx6hbpQPMvFX0JJAq2aJstJo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3900
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

On 28/06/2022 15:55, Vasily Averin wrote:
> On 6/28/22 12:23, Alexander Atanasov wrote:
>> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
>> +{
>> +	struct virtio_balloon *b = f->private;
>> +	u32 num_pages;
>> +	struct sysinfo i;
>> +
>> +	si_meminfo(&i);
>> +
>> +	seq_printf(f, "%-22s: %d\n", "page_size", 4096);
> This output of the constant looks strange for me.
> Could you please explain why this is required?

Ballon driver always works in 4K page units. The values in the file are in the driver units.
Guests need it to be able to perform calculations of actual values.
In the case of virtio_balloon it is always 4K but other balloon drivers can have different page_sizes.


-- 
Regards,
Alexander Atanasov

