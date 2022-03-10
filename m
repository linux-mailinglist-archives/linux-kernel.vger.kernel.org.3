Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EC34D465D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241819AbiCJMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiCJMBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:01:01 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2049.outbound.protection.outlook.com [40.107.102.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7DD42481
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:59:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt9iaCREdZqd8J8tzzBx58yA87vYI5+UTLuxS7iryF/6ikble2HMnQymNH5zCFYs/si9JWDEyq1CcCKLCceAn04w47o21MNzNJmdy8fsISF7SIhF9huITSahvIrU8InNn+lCVDcuEv5lNlYXjs9i/6Zwb3skAKUDW8lVj8AcLgvql2OALg/t07U7rk1prhgiHNEYM05pi0kRnyggMzU2CD9r9P7hBk+rTJO3Kgj64ejh35OwPIwmxpA9qOYk1zDDpTP90vuyp8cozLNQ3g/QWXbNUviSvJNDmC/AngVPFWWN7+vEs7Kev0uj0qDDABHWfjSLdnDtWa/tPQGDhpzBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyfZAyVxNys47go1nLxf43REYE/MKyfCPnkdvYKqWDg=;
 b=UFh5a42yQXEnhsUGwlXwmpS+EglNu2O1iZOfNA2z7Lua4G8SLkyp1J1kj11IndMW3RAhkVHpIYGgkRk7NzEMAxuFV7UuG3LUjQXSgrUO5nEdZ5jC1J5pKiAX7Qbe05vlhoWvziC3kIQ/+4LmqZbZkZlls5Pc+/uxUvnm7rCIeFXh7Xt45Yt7hpDnF4OxkcsFrflBT2oQ8CAyfyfgDPFylu8Dr6z1XQZ+/K3Gm/X/PfWWdZC6YkQfo8uekFJOt7EslRXduxC7at6xjVll4ClLvvonMDr4JyjqocX6tzlX0e/fI0H2mr/8jaCLgH+klFvnWOsk3sIKwhGbmIr75Q/fMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyfZAyVxNys47go1nLxf43REYE/MKyfCPnkdvYKqWDg=;
 b=M4qvLexcS0PcT6Yao+8a2VgBwjYRYl9tXWkzdegebEmB3BVJHYPcN7KmotXJLqYmO51iO5jesfSaSQYXxRm5ia0oGQLA2wFeDT1bOtaKdW+Uo0yG38LDTwThLTuwTco7OPm/FHPWJOo3EAEbSKG1ZtRhYwHywmxgRAouIGPtHRm8hJUNuMZJpLZBJYJ/qDxwf4Iqh965URfeaU5ZjjuUdyyB90Jv7WkPE+1w+r1GtpPr399AjhAICJ0J7j+9pLgIrvrPWdmCsi62JZlxArrazyFrAh5Dz888criGrv/xYCOpHz+ex+AdX0+t7PGjvClqvvArpk+D/6VOY+wx6FSbig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 11:59:56 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::152f:613b:7041:68d6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::152f:613b:7041:68d6%7]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 11:59:56 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Mika =?utf-8?Q?Penttil=C3=A4?= <mpenttil@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] HMM selftests changes
Date:   Thu, 10 Mar 2022 22:52:41 +1100
References: <20220308015705.8424-1-mpenttil@redhat.com>
 <7fc9cae2-04b3-153c-f826-e565a1beeb2d@suse.cz>
 <4c6bc437-32ba-7bfd-05e6-b555a1a13776@nvidia.com>
 <f36ae290-979e-1f6f-3169-edd5f729a971@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <f36ae290-979e-1f6f-3169-edd5f729a971@redhat.com>
Message-ID: <87r17aow5i.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: BYAPR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::34) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7f023b0-9fc5-4c01-afda-08da028d7ec2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5188:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB518896D5FAE98B2755866878DF0B9@CH0PR12MB5188.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2+RTKvGWFsvAp6fjPeKXZzORBYeNSr4dDD0BpRKZJD2kutvibm06UxjWgYRyEDVFnBnWbkepEwvfoQ9Iru8SOpgJQqTqfC1xZB3kkiLIU7P4bc78hh+vGi5Jx7yZ+d6kV957gAnT5ps8v6dVTjIxhEMx7CLFYNhDptCkbscj5sKvQpdHmxftaZ6CRkTOSxIyt3+Ov19Li0sso0t0zQygCWkRds8ka5h/T6sWk0jbRzATpdlevmO7RC2yYttUxKN3gDkfdAwzgwTsLLlSYDVhdE2NkycvjYvyRIn1vtVBpjjkobAWdDkv2aghjLAofrSqDcxoOX0ZdZoDEFXxTDAiOdIeCsXASBz0GPVadPxlrqx3vapHxf8emh8I4JyjBFUFrKbzp8aQYQTN6nCBySpQ+3AmVApdUNIvCUTFJHn0sJk6tCQ7zLB3NZwbNxW53Ho6JaswZj9L2AzqaFEaFM/7+4DLDatS3nNBy6vDNMzZ2S7a51p19Ww6T5ktfIWLjbGSq9GwiJEJN36v0kacHvq9XS7pwvGdXN7Rj3kWkHaFnBoDmOQRuVdUb0Yb1BPyt3+EmiHG3aWTsS93JzBeqY7eoAuE0KxXAPNhDjq9JhpfCirmtaD5RE2n3zr+kf4babH9udwABf3/ErUmuXX6urQnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(6916009)(186003)(54906003)(66556008)(6486002)(6512007)(316002)(9686003)(33964004)(44144004)(53546011)(8936002)(26005)(6666004)(38100700002)(83380400001)(86362001)(8676002)(4326008)(5660300002)(2906002)(508600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUlLUmN4UW5kQ3I0RHgyQ2xJMUxDaVR5ME5XSVhtd1VUQ2JNRzRONDlEcGdT?=
 =?utf-8?B?c3ZTc1hmaDk0TWlqaTlLcHB1dlYrYzA3b3JTSmpoOWZNSVZhNGRCaXlYSVhB?=
 =?utf-8?B?cDF0Z1JDbC9Mc2F1djFWOVpTc2FzU3JWSFhtWkZSRnNKY21yUDhmWitTQm5p?=
 =?utf-8?B?MWxSQ1ZEQzJRT3pXS01WbEpWRE1ZUSt3QWJWNSs1QWN4QkhhUXN2TGFlWDcy?=
 =?utf-8?B?VXNmZ1djRlJ3SFRUbXhrM2MzSk80M1gzSnJoL1BBeUU2UkxxanZNSktGUDhQ?=
 =?utf-8?B?OEx6Y0FkZGUxK0d5c2NMbVA3TnVTZWZqLytXYXNjNHYzbjNUdzY3UHlzemdW?=
 =?utf-8?B?N2tMcmM0V2kzWFdGWnlmbndNMENiQVNlLy9vdDlrOE5OR1IySEVHbTVPNEdX?=
 =?utf-8?B?bWhMQzZDaldkSHZ2VzVkbDM1K3FYVU5EdVlDRGlIUmVQbnFSVkJ6VThnNklq?=
 =?utf-8?B?TWVRZkdhb0Q1UTF0NzBLaThodHE3dWs0UkJwbmE1bFZ2NGRsa1d0bytwbjRE?=
 =?utf-8?B?SFFIQ0ZmQUhUMTNlb1BaaGx4OXNFVHhCUUYvQ2xKSDlkb3VpNURhV0dVcDE4?=
 =?utf-8?B?dGVrRlhvZUorenZnQ01XaUxvamF4VGRyUW02UTkzYTlJVkYxMjZBUUladnpS?=
 =?utf-8?B?TElGNncvcG0zNmZPSGw1ZHp6TEJFbXdlVStJNGxsdldTeE90ZzlXamNjMXRW?=
 =?utf-8?B?aitnbU85cjRXRitVRmZUV1dZaTBIQ1dLRzZKVlBkZ05UNHBOdk9jRDhPREpN?=
 =?utf-8?B?ekRvNjFNK0JnSFV1L3o0MFRWeEtxS1lGZ3VYSWQxb2xOcDFJNkt4ZGJUc3d2?=
 =?utf-8?B?VlA2RkJVdjRCUnVWeWZaWnJNRmJLRUZnYmQ2dWNONGdtemFaV0Vldi9sUk81?=
 =?utf-8?B?ZWQ0aVczNlNKWjlOM2VNRjdhSmdLNEpVR2MvdWk1czFXQ3RWNDBNdXZWQnB0?=
 =?utf-8?B?NVFYOU9tYlhGdk80cXFDK1hwdjlHcjQ2SlVFbVBOOGJiRVJEeldHYndha0N3?=
 =?utf-8?B?RndtQVpwSEQwMG5CNFE3QlNwM3pabTJybHFrME42ZkpETy9wL3FUZnVCM3Bl?=
 =?utf-8?B?VTNURElkY2EzVnd1a0ExV1RJSzBBZGlLRExaTW9qZlg5SXgxOVNUSkwyNWdZ?=
 =?utf-8?B?c1d0SDJzYVVQanR3L2o5dU5PT0t6UU1mUjVreWVQZlFiYm02YldMT2JhbU1n?=
 =?utf-8?B?OS9nK2VpZTNnTnNHWDhqYjBQUTFlQnpoK1RkS2dUdFlrK3U2cFlJUGUzZkNl?=
 =?utf-8?B?ZjMwMm1HUTE1cXI2WUtnUXdVQnVYWDQrbzBMZXFDT0ZvdzcxaUh2QXZUOVNX?=
 =?utf-8?B?SWcySG9yQWxDRDJUeEhoSUFQdENZSVo2N2hEcHh3N0pTOHJHc3B6dWErMTE4?=
 =?utf-8?B?dGNyMVRvbUtlbm4rYjN6K3RuN2JHMmJLaUptcUtkelBvMXRVbGdiVHJBR0JJ?=
 =?utf-8?B?WGVmUDBCQWt1WVFPamJPenBvM0hiQXVCQ281bWlyekxMRndQNWR4TXhKZ20r?=
 =?utf-8?B?UzBnSktINHVIQ0QralJqZmdlQUc1S2xEOTI4eUl6dTJkVTd2QXFtc3BWY0RB?=
 =?utf-8?B?YmxUaGprTldPK1BVL1RIU0JtVEdoUThJTXlXakxtRTNJMnlaVTZLdkJ3Q3Rs?=
 =?utf-8?B?UFNkMUpEdW1ySEhNOVF0MDdkbnZmeThPTGl1ZnRtZ003UStMZ3YyY3ExazF6?=
 =?utf-8?B?L3FtcnQ5NmhSNWI5dTRTNlhDTFVGYnMyKzFJQ25nUUR6aXdieUhFZS83MzR6?=
 =?utf-8?B?ZGxFWXFsN2huZ1lEb2lDZmZ3SWdIUGYzaVJNTmtDMktpNWx3ZHV1Vkk4VEZ1?=
 =?utf-8?B?Qlo2a3hyOXNwN0pSUFpFS01naFluNzFTOWt2RGpwYk9FWk40T2tvU1c1L202?=
 =?utf-8?B?K1Y5cW0wVVV2cTRQcndkZ3ZjbVlYMDY0L3JVcnlSVDdRN0hsajVxMlVKMUY2?=
 =?utf-8?B?TWp4VmxNeDlMczRnN3FwKzZFT211eGFZeHF0V2NBTkFNcjNOMDFxTDc5L29s?=
 =?utf-8?B?M01mZWRmUHBDaFNQcjZzOEszRGw2RXpkbTl1ZHhxdGN6NE9LYVhtVjhxL0VR?=
 =?utf-8?B?dlY5RWpkMksxRzNqbUpQaUNRb1doN3V6eUhwcmZlcjdVTTI5TkxIMnZtOTFV?=
 =?utf-8?B?cmoyVEN6cFBxZTFqcEZYWEgwV2oxaC81VGR5V3pLN1pvaFlBNmc3SVRXWVVl?=
 =?utf-8?Q?rpf5eY7DA+Kr8hCRA8uk5sM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f023b0-9fc5-4c01-afda-08da028d7ec2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:59:56.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekFZOuf0/gSOeA5+7AdozAQA/bmgY6KJnNHIQm8zm0HTiqLB5NClw/zTjV+zxzltREMuJfVei7o/bgdfX+byVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Mika Penttil=C3=A4 <mpenttil@redhat.com> writes:

> On 10.3.2022 5.44, John Hubbard wrote:
>> On 3/8/22 5:10 AM, Vlastimil Babka wrote:
>>> +CC relevant folks
>>>
>>> On 3/8/22 02:57, mpenttil@redhat.com wrote:
>>>> From: Mika Penttil=C3=A4 <mpenttil@redhat.com>
>> Hi Mika,
>> This looks like a very nice cleanup and simplification, delighted to see
>> it!

Agreed, thanks for doing this.

> Thanks!
>
>> In fact, I like it so much that I've got a bunch of fussy nitpicks I'm
>> hoping you'll consider applying, below. :)
>> Also, I'm assuming you've tested it a little bit? (My test rig is boxed
>> up for another day or two, don't ask...haha.)
>>
>
> Yes it passed the tests with the changes.

Feel free to add:

Tested-by: Alistair Popple <apopple@nvidia.com>

It does currently conflict with linux-next due to the changes for device
coherent memory. So if that series ends up going in first this will need a
little bit of rework. It should be fairly straight forward though - the mai=
n
difference is that series introduces two new extra minor nodes.

- Alistair

>
>
>>>>
>>>> HMM selftests use a in-kernel pseudo device to emulate device private =
memory.
>>>>
>>>> For now, the pseudo device registers a major device range for two pseu=
do device instances.
>>>> User space has a script that goes figures out from /proc/devices the a=
ssigned major
>>>> and mknods the device nodes.
>>>>
>>>> Change this use to a more standard device framework, like misc device,
>>>> which makes the device node names to appear right under any decent use=
r space.
>>>> This also makes it possible for udev- like processing if wanted,
>>>> and the /proc/devices parsing is not needed any more.
>> How about this for the subject line and body? I've made the subject line
>> match what other commits look like in this area, and I've clarified the
>> wording in the body:
>>
>> mm/hmm/test: simplify hmm test code: use miscdevice instead of char dev
>> HMM selftests use an in-kernel pseudo device to emulate device private
>> memory. The pseudo device registers a major device range for two pseudo
>> device instances. User space has a script that reads /proc/devices in
>> order to find the assigned major number, and sends that to mknod(1),
>> once for each node.
>> This duplicates a fair amount of boilerplate that misc device can do
>> instead.
>> Change this to use misc device, which makes the device node names appear
>> for us. This also enables udev-like processing if desired.
>> Delete the /proc/devices parsing from the user-space test script, now
>> that it is unnecessary.
>>
>>>>
>>>> Signed-off-by: Mika Penttil=C3=A4 <mpenttil@redhat.com>
>>>> ---
>>>>   lib/test_hmm.c                         | 46 +++++++++++++++---------=
--
>>>>   tools/testing/selftests/vm/test_hmm.sh |  6 ----
>>>>   2 files changed, 26 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>>>> index 767538089a62..76f6129e1f1f 100644
>>>> --- a/lib/test_hmm.c
>>>> +++ b/lib/test_hmm.c
>>>> @@ -10,7 +10,6 @@
>>>>   #include <linux/mm.h>
>>>>   #include <linux/module.h>
>>>>   #include <linux/kernel.h>
>>>> -#include <linux/cdev.h>
>>>>   #include <linux/device.h>
>>>>   #include <linux/mutex.h>
>>>>   #include <linux/rwsem.h>
>>>> @@ -25,18 +24,25 @@
>>>>   #include <linux/swapops.h>
>>>>   #include <linux/sched/mm.h>
>>>>   #include <linux/platform_device.h>
>>>> +#include <linux/miscdevice.h>
>>>>   #include <linux/rmap.h>
>>>>     #include "test_hmm_uapi.h"
>>>>   -#define DMIRROR_NDEVICES  2
>>>>   #define DMIRROR_RANGE_FAULT_TIMEOUT 1000
>>>>   #define DEVMEM_CHUNK_SIZE  (256 * 1024 * 1024U)
>>>>   #define DEVMEM_CHUNKS_RESERVE  16
>>>>   +
>> Extra newline, please delete.
>>
>
> yep
>
>
>>>> +static const char *dmirror_device_names[] =3D {
>>>> +	"hmm_dmirror0",
>>>> +	"hmm_dmirror1"
>>>> +};
>>>> +
>>>> +#define DMIRROR_NDEVICES ARRAY_SIZE(dmirror_device_names)
>>>> +
>>>>   static const struct dev_pagemap_ops dmirror_devmem_ops;
>>>>   static const struct mmu_interval_notifier_ops dmirror_min_ops;
>>>> -static dev_t dmirror_dev;
>>>>     struct dmirror_device;
>>>>   @@ -82,7 +88,7 @@ struct dmirror_chunk {
>>>>    * Per device data.
>>>>    */
>>>>   struct dmirror_device {
>>>> -	struct cdev		cdevice;
>>>> +	struct miscdevice	miscdevice;
>>>>   	struct hmm_devmem *devmem;
>>>>     	unsigned int		devmem_capacity;
>>>> @@ -118,16 +124,20 @@ static void dmirror_bounce_fini(struct dmirror_b=
ounce *bounce)
>>>>     static int dmirror_fops_open(struct inode *inode, struct file *fil=
p)
>>>>   {
>>>> -	struct cdev *cdev =3D inode->i_cdev;
>>>> +
>>>> +	struct dmirror_device *dd =3D container_of(filp->private_data,
>>>> +                                              struct dmirror_device, =
miscdevice
>>>> +		);
>> Let's delete that whole chunk, because the variable is unnecessary, and
>> is adding to the line count and mental load for no reason.
>
>
> Agreed.
>
>
>> Look how much cleaner this it gets after applying this incremental diff
>> on top of your patch:
>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>> index 76f6129e1f1f..3ec8ca8059cd 100644
>> --- a/lib/test_hmm.c
>> +++ b/lib/test_hmm.c
>> @@ -125,19 +125,16 @@ static void dmirror_bounce_fini(struct dmirror_bou=
nce *bounce)
>>   static int dmirror_fops_open(struct inode *inode, struct file *filp)
>>   {
>>   -	struct dmirror_device *dd =3D container_of(filp->private_data,
>> -                                              struct dmirror_device, mi=
scdevice
>> -		);
>>   	struct dmirror *dmirror;
>>   	int ret;
>>   -
>>   	/* Mirror this process address space */
>>   	dmirror =3D kzalloc(sizeof(*dmirror), GFP_KERNEL);
>>   	if (dmirror =3D=3D NULL)
>>   		return -ENOMEM;
>>   -	dmirror->mdevice =3D dd;
>> +	dmirror->mdevice =3D container_of(filp->private_data,struct dmirror_de=
vice,
>> +									miscdevice);
>>   	mutex_init(&dmirror->mutex);
>>   	xa_init(&dmirror->pt);
>>
>>>>   	struct dmirror *dmirror;
>>>>   	int ret;
>>>>   +
>>>>   	/* Mirror this process address space */
>>>>   	dmirror =3D kzalloc(sizeof(*dmirror), GFP_KERNEL);
>>>>   	if (dmirror `=3D NULL)
>>>>   		return -ENOMEM;
>>>>   -	dmirror->mdevice =3D container_of(cdev, struct dmirror_device, cde=
vice);
>>>> +	dmirror->mdevice =3D dd;
>>>>   	mutex_init(&dmirror->mutex);
>>>>   	xa_init(&dmirror->pt);
>>>>   @@ -1216,16 +1226,18 @@ static const struct dev_pagemap_ops
>>>> dmirror_devmem_ops =3D {
>>>>     static int dmirror_device_init(struct dmirror_device *mdevice, int=
 id)
>>>>   {
>>>> -	dev_t dev;
>>>> +
>>>>   	int ret;
>>>>   -	dev =3D MKDEV(MAJOR(dmirror_dev), id);
>>>>   	mutex_init(&mdevice->devmem_lock);
>>>>   	spin_lock_init(&mdevice->lock);
>>>>   -	cdev_init(&mdevice->cdevice, &dmirror_fops);
>>>> -	mdevice->cdevice.owner =3D THIS_MODULE;
>>>> -	ret =3D cdev_add(&mdevice->cdevice, dev, 1);
>>>> +	mdevice->miscdevice.minor =3D MISC_DYNAMIC_MINOR;
>>>> +	mdevice->miscdevice.name =3D dmirror_device_names[id];
>>>> +	mdevice->miscdevice.fops =3D &dmirror_fops;
>>>> +
>>>> +	ret =3D misc_register(&mdevice->miscdevice);
>>>> +
>>>>   	if (ret)
>>>>   		return ret;
>>>>   @@ -1252,7 +1264,7 @@ static void dmirror_device_remove(struct
>>>> dmirror_device *mdevice)
>>>>   		kfree(mdevice->devmem_chunks);
>>>>   	}
>>>>   -	cdev_del(&mdevice->cdevice);
>>>> +	misc_deregister(&mdevice->miscdevice);
>>>>   }
>>>>     static int __init hmm_dmirror_init(void)
>>>> @@ -1260,11 +1272,6 @@ static int __init hmm_dmirror_init(void)
>>>>   	int ret;
>>>>   	int id;
>>>>   -	ret =3D alloc_chrdev_region(&dmirror_dev, 0, DMIRROR_NDEVICES,
>>>> -				  "HMM_DMIRROR");
>>>> -	if (ret)
>>>> -		goto err_unreg;
>>>> -
>>>>   	for (id =3D 0; id < DMIRROR_NDEVICES; id++) {
>>>>   		ret =3D dmirror_device_init(dmirror_devices + id, id);
>>>>   		if (ret)
>>>> @@ -1277,8 +1284,7 @@ static int __init hmm_dmirror_init(void)
>>>>   err_chrdev:
>>>>   	while (--id >' 0)
>>>>   		dmirror_device_remove(dmirror_devices + id);
>>>> -	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
>>>> -err_unreg:
>>>> +
>>>>   	return ret;
>>>>   }
>>>>   @@ -1288,7 +1294,7 @@ static void __exit hmm_dmirror_exit(void)
>>>>     	for (id =3D 0; id < DMIRROR_NDEVICES; id++)
>>>>   		dmirror_device_remove(dmirror_devices + id);
>>>> -	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
>>>> +
>> Another extra newline, please delete it.
>
> yes
>
>>
>>>>   }
>>>>     module_init(hmm_dmirror_init);
>>>> diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/se=
lftests/vm/test_hmm.sh
>>>> index 0647b525a625..69f5889f8575 100755
>>>> --- a/tools/testing/selftests/vm/test_hmm.sh
>>>> +++ b/tools/testing/selftests/vm/test_hmm.sh
>>>> @@ -41,17 +41,11 @@ check_test_requirements()
>>>>   load_driver()
>>>>   {
>>>>   	modprobe $DRIVER > /dev/null 2>&1
>>>> -	if [ $? =3D=3D 0 ]; then
>>>> -		major=3D$(awk "\$2=3D=3D\"HMM_DMIRROR\" {print \$1}" /proc/devices)
>>>> -		mknod /dev/hmm_dmirror0 c $major 0
>>>> -		mknod /dev/hmm_dmirror1 c $major 1
>>>> -	fi
>>>>   }
>>>>     unload_driver()
>>>>   {
>>>>   	modprobe -r $DRIVER > /dev/null 2>&1
>>>> -	rm -f /dev/hmm_dmirror?
>> Nice!
>>
>>>>   }
>>>>     run_smoke()
>>>
>> thanks,
>
>
>
> Ok will make the changes and repost,
>
> thanks!
>
> --Mika

--=-=-=--
