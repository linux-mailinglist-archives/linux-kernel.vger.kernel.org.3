Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BCD4D3FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiCJDpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiCJDpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:45:44 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2565C64C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:44:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDyUYavxzE8dc48b4YhT5I/TPyREXOJyfAWli2y0E6i2kax0g1fXAcmjQupnYcrGpuX3ZvzAVTRG/h4N+BYZFvIn/Aea28T8852d/+bQtgE+6vKNAgTJsluJgCjE+zTh/r/ZJXTrca6szXrL5ABig1UvIw6ig+Scuzos8cbmycPjrX3YzgHpj7nH/J5x4UnFyGUT5HpZRz1NC3TuzfRqfCRCfDrKaFurmxaPHaOBvs6xveX+Hi5Cz042WlXarCi9sQSnmtOQ9tJUiXU2cp6E9b32TrLBMfm8VH3GIfVofOD0xMN/bO9gjRCb9YPwrYT3fYwvmPPtRxXt07xEoBQWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXeYdl9AcHbdOmIeY7GYP+OB+ikQFu8IWBxCFGEP0hk=;
 b=ZvLUYPimSXRtzU3DQz6V97RooC368p4I/gs6n2o1cD+M1kL6XWIcS4z5oA3ph9YfAmL0LOPqRT+wA+iS1EnQThYbA6Pwx0nZg/N0JyrnssM/qblZ5S7OUphX9YAMjrAC6PA1+JmrZxZFetilLdpjjYPZvoQGiJV4DjZJ+l+I4CbD+SANLvBj7jq+fJ0gC64DzZzS/V0ALJZPGhMmIrGhGBDHP1tdMeqG7SLPfDp5TvglSJQ6MVqq94SjGX8Xy9l50Jzl2ifRoGDfmUsu/3l8IQkdMGfnmU8kg1UuSE/MpxC48uVBgVkqY4LtRULsa/JFpbjkblpvpI2S54JS1LMHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXeYdl9AcHbdOmIeY7GYP+OB+ikQFu8IWBxCFGEP0hk=;
 b=IyTKrZ86OlbTKm0jTFb4h0PNZt19oqgmGnrj9t381Iyis1eVgRlaC8z+xqRWapIIgW1iCeOQhVrLjVIYy+qzvgks9ReaJu0kfw4m0488V2QzWpVXIWbQageKCblKiL4nTDWgyGWc5ZaLPyMasVny19uOpd/CbY8I3Mp6V5GMk3NKoYZSlt0tCLHz8p5eCRUhEnIPCcuR5P9bVwNrVkSUNSClW8AQjy2AYpDYbJQi4DqgPNRHJpRXVkefga5tB3hHD5pYkNlC+2Iz7H9fuGQbkg7fKycTVXLC41VrUwvQDlTdUERf67wXlbZodOogGy7OKryCj0gPlIQzKAVgV3eYlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 03:44:40 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::b4d2:1b8:7a7b:fdcb]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::b4d2:1b8:7a7b:fdcb%9]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 03:44:40 +0000
Message-ID: <4c6bc437-32ba-7bfd-05e6-b555a1a13776@nvidia.com>
Date:   Wed, 9 Mar 2022 19:44:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] HMM selftests changes
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, mpenttil@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20220308015705.8424-1-mpenttil@redhat.com>
 <7fc9cae2-04b3-153c-f826-e565a1beeb2d@suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <7fc9cae2-04b3-153c-f826-e565a1beeb2d@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd354440-b61b-4fca-aced-08da02484e5f
X-MS-TrafficTypeDiagnostic: LV2PR12MB5749:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB57490E9977A73E4C74EA00D8A80B9@LV2PR12MB5749.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXIy8haNeZlps1ae7eVen93WhvFcfnTkSvTfyFHgmd0dD5JnNuym7/XFmAy4q4Jhbl83uvwjE+w+0wswP6doBjhIZpvwWdycXHXpF0mdssHtSWuxRzgbszwvVALnyDxpB4LXEPgFdkFmiLqzQmFhLWLsrqZCt6H5eA/AJGHfUOjB1GN5NnKKiK2zbXQgT9x88CHsfA36ye5JYPR58TgIlUPbjeJDSbkGBqDznkZNVuW5wvuQm+XyTKlasCODYpUR22uLTOzA604dYVlxSsuwWOhRh7U82Hj83o1Z/k8eVi79tY2V4h2mLRGushFfRetoUTFiogWH5vUGIhky7TdWVY0W4cflIzQKbFrLpZEK4jjy36Fvt9aKtgJd7JFYtD+T17gN3XxFqr0b64aPGGg52wpr0krV0cieHjSk4xLhS0gvzp2AYXvEo+ymV3ij+M8k35TD6RfitPVO/P6vVF6E29eKmlZsCccLUPZlpdMGP9LTG7SR0gzp1zQFIbmk2o2CpXmzRXvu8mb/SflnfJj2ZYli7yipKqCKT6SRq6t1rSOpmhpsxG1whSsvczFb9992c+uSWs2+nWNEE6Prb75IpSA701uZVmLTM/7ILWBCeF2JrIdistBGDqvqXtSL1W/fjOnzUjPXibTIDLFet68mFzMSkBzfkfQsi9o2c4mwWD3k/EFDRY4g3/O+Ogqj5iyfZIg7wRxOkwAW7bL4Hcgjyg5lL5TnhMomHSLALxWffFoOrriO+NSJ4T5+2Z1VZCCA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(186003)(6506007)(4326008)(53546011)(8936002)(2906002)(26005)(83380400001)(2616005)(31696002)(6512007)(5660300002)(86362001)(54906003)(316002)(508600001)(31686004)(6486002)(38100700002)(66946007)(36756003)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDA4Sk9nVzlvMlhlRGRzTkc3bURsaThSd3lISlRyM1d5RUI2MWordUZZemRI?=
 =?utf-8?B?a1lWYWhWVWErOFJPWC85MFZpeHVrVy9UVS81UlNIcWNKdkMyZk05Vnk4d1Rh?=
 =?utf-8?B?SjNraXJaNkFGTVJLaDhwQlJZTVdKS29CLzRHZXl1a0FpM2QzejlRTjFMWjdQ?=
 =?utf-8?B?SnpCRVQrWWtmQmo2WFRVM201TUQ1czRrVWlXd2Y4c3lFdWxlOTE2VUp0TkJn?=
 =?utf-8?B?ZFVocExYZzI1UERoR291M1RZMFJXZWcwRnFXL1p3OGVwdExkWTAwNkJqMVpk?=
 =?utf-8?B?NzIzcW9sNkxTK3BnUXhMYTNNRUZveGlNTE9xb09pbnF4c2FmelVuVUNzeGlu?=
 =?utf-8?B?ZnNwOGlnOXQrM3haOTN6S05IZldzaHRLSjVPU2pYY2k3WERaWUxRTTZLd0pt?=
 =?utf-8?B?Y2R6ZlY4VFNpR1QzcUwyZWtpNURIN25KVFNjTGdMTEYzVmd5YTFSWnVFbDds?=
 =?utf-8?B?NDhDTVdsTHc4THFBL1BpdEhoWkNFamZlRTRuaDF6aDZkenhodkpuSWFTZ3Qy?=
 =?utf-8?B?RmtFR2Z5ZXZQNlpRNmlOQ2VCV1pubkY4VW1JcFF2Rm96VjBSMDNkTzc0SUhM?=
 =?utf-8?B?NkFWcmw2N2daNHA1K2FoRmUrV2lRbCtjTWlFSHoxbHJ1WlZtSTdmV012d1NW?=
 =?utf-8?B?SVYvSmx6OXkxeDlZNnMxV2JPR2t1S1RlWGFKYXQ2aEIvYzREeFJxbDNsOGow?=
 =?utf-8?B?THA1QTNTanlRZXYxOFVjQmMxaFJoVVlSODVQcytQTGJtSHp0SkZTek82RFI5?=
 =?utf-8?B?NmM4KzViUk8ySlVud3VwOElnZXdFRFRkZEdiSm1PNlY4d3hjTFVQZ0ZKemZS?=
 =?utf-8?B?OG1QeDFaSjRldUphNk1TSVcxYzVKc0x1UmZZWDZ5OVpibmV5UkIzaVgzVFlR?=
 =?utf-8?B?aFRtRHhVT2tuL2h3M3BWMkhDVWsxcnJaRFh1Y1E3cHY5TXFtUzh5bjEwNVlY?=
 =?utf-8?B?VGRiWlZ3NzdKcDRLK2E1cTV4V2F5cWtXb21qSElNTkZaQ2N4LzZxVXNIRmtJ?=
 =?utf-8?B?Q3pjUXQxbkJIdlhOTkNCajBhamtIYWFJOEdleDFvWkJGc2ZKb2dkdnJ0Zngz?=
 =?utf-8?B?YjZMbnljZW5TbndUV3J2RFgvSGVXWFU5YUt2YVZWSFY1Nk54TEFpRWJJR3Fr?=
 =?utf-8?B?R1Q5OG1XS2hDeTFlcFJ5RkozeFFVaW16Y2pTbnBNNzlFYzRRcU1od21LV1hF?=
 =?utf-8?B?OXJYRFU0amZwYXlVYkZKS1BMZVJ4VE1ZN29FYTl5WFp6MjE5dE5tZldQTDYv?=
 =?utf-8?B?K2NKZUxGa0ZIYzdNSDdLb0tDVEg5RmtwTVJFaFZXZzF2U2JBVndDREF4Risx?=
 =?utf-8?B?dnQrdWFOZ3crYmczMDJvRGVlTnJ4VFdWQmhVUGVpWVJsUjBTVHcvWnk5NTBm?=
 =?utf-8?B?VXFPTEhZYXI2dTg0VHk5YS9yT2xyTDNuRGRKcUlGZTlPdE5ncG5wWlozNURP?=
 =?utf-8?B?ZkZqNGVqVFd1djRMcFdJcEZCSlBlVGRQb1d3YVJReFBkNlJEb3hacHVLTW10?=
 =?utf-8?B?MWJUKytKVkdQUk1idXFrdUxTWHd2ME5vRVBlL1ZoenFqcXpxaGZ3dFZOVVgw?=
 =?utf-8?B?RHpXaThFRi9GYWF2dzVQY1RSQW1maisxTnpORGdiZXROZUM2ckd6T2JXZE9P?=
 =?utf-8?B?Q1g5UVpwUlFocVlNa2J0ODdHdUNSSTBGZW5jUnVKT2NxOWNqd1FTVzlxZjlW?=
 =?utf-8?B?MzQ5VnpvclMyVUJuZEU1UE1IQjZ3cDVNNnhDaGE0Uk1CeU1keWhmUk4wTzl3?=
 =?utf-8?B?aVVKRjhQMC9ZeWVvb0tPK2hOSE81SHZacjZDSjdjM2tDOEM5ZHlhRzlvOSth?=
 =?utf-8?B?QlUxb3BZYzJBMWtpYTNYanIzVHUvTE1xSFNHbkQyY1pmRm4rY0NieGRTNTMx?=
 =?utf-8?B?OEZTZXBKT3pKZ0tzTGFhdmZKczQ3ckJlVXhGRlhoM3RYajVNSkF2em9mTGVl?=
 =?utf-8?B?Wlc2Y2pvU3Q4WGt2czM4QXQzRmg0SjdORXBqeHFKUktSWmxSKzZhTzQvQzRu?=
 =?utf-8?B?L3dDWGFpdWpUaCtHdlMxVzVaUDdabFhMSlp6R0xnSUtCZFl4TUNQMVRlcWhX?=
 =?utf-8?B?cW9KNm9rc05oU2hraHRDVnk5T1YyUytaM1lOQlFaZmp4V0VJQXVwYTkrQnJY?=
 =?utf-8?B?STZqSWxSV1cya3RyakRRZ1ZmT1lvZmNhNXNjSjA5SXcyQXZndGVRMWg2L2JU?=
 =?utf-8?Q?Bzt0mbpeFtBECb17Ylq0Hwg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd354440-b61b-4fca-aced-08da02484e5f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 03:44:40.4028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OQE9v3Wa7PzACUruFqDNwMXXm5nLYN7674W9dPhVmJAsIJti+lqakMt7Glhcrzi5R1amcJO+Yh11tsJzELrGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 5:10 AM, Vlastimil Babka wrote:
> +CC relevant folks
> 
> On 3/8/22 02:57, mpenttil@redhat.com wrote:
>> From: Mika Penttilä <mpenttil@redhat.com>

Hi Mika,

This looks like a very nice cleanup and simplification, delighted to see 
it!

In fact, I like it so much that I've got a bunch of fussy nitpicks I'm 
hoping you'll consider applying, below. :)

Also, I'm assuming you've tested it a little bit? (My test rig is boxed
up for another day or two, don't ask...haha.)

>>
>> HMM selftests use a in-kernel pseudo device to emulate device private memory.
>>
>> For now, the pseudo device registers a major device range for two pseudo device instances.
>> User space has a script that goes figures out from /proc/devices the assigned major
>> and mknods the device nodes.
>>
>> Change this use to a more standard device framework, like misc device,
>> which makes the device node names to appear right under any decent user space.
>> This also makes it possible for udev- like processing if wanted,
>> and the /proc/devices parsing is not needed any more.

How about this for the subject line and body? I've made the subject line 
match what other commits look like in this area, and I've clarified the 
wording in the body:


mm/hmm/test: simplify hmm test code: use miscdevice instead of char dev

HMM selftests use an in-kernel pseudo device to emulate device private
memory. The pseudo device registers a major device range for two pseudo
device instances. User space has a script that reads /proc/devices in
order to find the assigned major number, and sends that to mknod(1),
once for each node.

This duplicates a fair amount of boilerplate that misc device can do
instead.

Change this to use misc device, which makes the device node names appear
for us. This also enables udev-like processing if desired.

Delete the /proc/devices parsing from the user-space test script, now
that it is unnecessary.

>>
>> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
>> ---
>>  lib/test_hmm.c                         | 46 +++++++++++++++-----------
>>  tools/testing/selftests/vm/test_hmm.sh |  6 ----
>>  2 files changed, 26 insertions(+), 26 deletions(-)
>>
>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>> index 767538089a62..76f6129e1f1f 100644
>> --- a/lib/test_hmm.c
>> +++ b/lib/test_hmm.c
>> @@ -10,7 +10,6 @@
>>  #include <linux/mm.h>
>>  #include <linux/module.h>
>>  #include <linux/kernel.h>
>> -#include <linux/cdev.h>
>>  #include <linux/device.h>
>>  #include <linux/mutex.h>
>>  #include <linux/rwsem.h>
>> @@ -25,18 +24,25 @@
>>  #include <linux/swapops.h>
>>  #include <linux/sched/mm.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/miscdevice.h>
>>  #include <linux/rmap.h>
>>  
>>  #include "test_hmm_uapi.h"
>>  
>> -#define DMIRROR_NDEVICES		2
>>  #define DMIRROR_RANGE_FAULT_TIMEOUT	1000
>>  #define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
>>  #define DEVMEM_CHUNKS_RESERVE		16
>>  
>> +

Extra newline, please delete.

>> +static const char *dmirror_device_names[] = {
>> +	"hmm_dmirror0",
>> +	"hmm_dmirror1"
>> +};
>> +
>> +#define DMIRROR_NDEVICES ARRAY_SIZE(dmirror_device_names)
>> +
>>  static const struct dev_pagemap_ops dmirror_devmem_ops;
>>  static const struct mmu_interval_notifier_ops dmirror_min_ops;
>> -static dev_t dmirror_dev;
>>  
>>  struct dmirror_device;
>>  
>> @@ -82,7 +88,7 @@ struct dmirror_chunk {
>>   * Per device data.
>>   */
>>  struct dmirror_device {
>> -	struct cdev		cdevice;
>> +	struct miscdevice	miscdevice;
>>  	struct hmm_devmem	*devmem;
>>  
>>  	unsigned int		devmem_capacity;
>> @@ -118,16 +124,20 @@ static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
>>  
>>  static int dmirror_fops_open(struct inode *inode, struct file *filp)
>>  {
>> -	struct cdev *cdev = inode->i_cdev;
>> +
>> +	struct dmirror_device *dd = container_of(filp->private_data,
>> +                                              struct dmirror_device, miscdevice
>> +		);

Let's delete that whole chunk, because the variable is unnecessary, and 
is adding to the line count and mental load for no reason.

Look how much cleaner this it gets after applying this incremental diff 
on top of your patch:

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 76f6129e1f1f..3ec8ca8059cd 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -125,19 +125,16 @@ static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
 static int dmirror_fops_open(struct inode *inode, struct file *filp)
 {
 
-	struct dmirror_device *dd = container_of(filp->private_data,
-                                              struct dmirror_device, miscdevice
-		);
 	struct dmirror *dmirror;
 	int ret;
 
-
 	/* Mirror this process address space */
 	dmirror = kzalloc(sizeof(*dmirror), GFP_KERNEL);
 	if (dmirror == NULL)
 		return -ENOMEM;
 
-	dmirror->mdevice = dd;
+	dmirror->mdevice = container_of(filp->private_data,struct dmirror_device,
+									miscdevice);
 	mutex_init(&dmirror->mutex);
 	xa_init(&dmirror->pt);


>>  	struct dmirror *dmirror;
>>  	int ret;
>>  
>> +
>>  	/* Mirror this process address space */
>>  	dmirror = kzalloc(sizeof(*dmirror), GFP_KERNEL);
>>  	if (dmirror == NULL)
>>  		return -ENOMEM;
>>  
>> -	dmirror->mdevice = container_of(cdev, struct dmirror_device, cdevice);
>> +	dmirror->mdevice = dd;
>>  	mutex_init(&dmirror->mutex);
>>  	xa_init(&dmirror->pt);
>>  
>> @@ -1216,16 +1226,18 @@ static const struct dev_pagemap_ops dmirror_devmem_ops = {
>>  
>>  static int dmirror_device_init(struct dmirror_device *mdevice, int id)
>>  {
>> -	dev_t dev;
>> +
>>  	int ret;
>>  
>> -	dev = MKDEV(MAJOR(dmirror_dev), id);
>>  	mutex_init(&mdevice->devmem_lock);
>>  	spin_lock_init(&mdevice->lock);
>>  
>> -	cdev_init(&mdevice->cdevice, &dmirror_fops);
>> -	mdevice->cdevice.owner = THIS_MODULE;
>> -	ret = cdev_add(&mdevice->cdevice, dev, 1);
>> +	mdevice->miscdevice.minor = MISC_DYNAMIC_MINOR;
>> +	mdevice->miscdevice.name = dmirror_device_names[id];
>> +	mdevice->miscdevice.fops = &dmirror_fops;
>> +
>> +	ret = misc_register(&mdevice->miscdevice);
>> +
>>  	if (ret)
>>  		return ret;
>>  
>> @@ -1252,7 +1264,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
>>  		kfree(mdevice->devmem_chunks);
>>  	}
>>  
>> -	cdev_del(&mdevice->cdevice);
>> +	misc_deregister(&mdevice->miscdevice);
>>  }
>>  
>>  static int __init hmm_dmirror_init(void)
>> @@ -1260,11 +1272,6 @@ static int __init hmm_dmirror_init(void)
>>  	int ret;
>>  	int id;
>>  
>> -	ret = alloc_chrdev_region(&dmirror_dev, 0, DMIRROR_NDEVICES,
>> -				  "HMM_DMIRROR");
>> -	if (ret)
>> -		goto err_unreg;
>> -
>>  	for (id = 0; id < DMIRROR_NDEVICES; id++) {
>>  		ret = dmirror_device_init(dmirror_devices + id, id);
>>  		if (ret)
>> @@ -1277,8 +1284,7 @@ static int __init hmm_dmirror_init(void)
>>  err_chrdev:
>>  	while (--id >= 0)
>>  		dmirror_device_remove(dmirror_devices + id);
>> -	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
>> -err_unreg:
>> +
>>  	return ret;
>>  }
>>  
>> @@ -1288,7 +1294,7 @@ static void __exit hmm_dmirror_exit(void)
>>  
>>  	for (id = 0; id < DMIRROR_NDEVICES; id++)
>>  		dmirror_device_remove(dmirror_devices + id);
>> -	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
>> +

Another extra newline, please delete it.

>>  }
>>  
>>  module_init(hmm_dmirror_init);
>> diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
>> index 0647b525a625..69f5889f8575 100755
>> --- a/tools/testing/selftests/vm/test_hmm.sh
>> +++ b/tools/testing/selftests/vm/test_hmm.sh
>> @@ -41,17 +41,11 @@ check_test_requirements()
>>  load_driver()
>>  {
>>  	modprobe $DRIVER > /dev/null 2>&1
>> -	if [ $? == 0 ]; then
>> -		major=$(awk "\$2==\"HMM_DMIRROR\" {print \$1}" /proc/devices)
>> -		mknod /dev/hmm_dmirror0 c $major 0
>> -		mknod /dev/hmm_dmirror1 c $major 1
>> -	fi
>>  }
>>  
>>  unload_driver()
>>  {
>>  	modprobe -r $DRIVER > /dev/null 2>&1
>> -	rm -f /dev/hmm_dmirror?

Nice!

>>  }
>>  
>>  run_smoke()
> 

thanks,
-- 
John Hubbard
NVIDIA
