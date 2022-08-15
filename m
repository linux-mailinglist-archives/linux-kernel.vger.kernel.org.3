Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDDF5927E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiHOCxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiHOCxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:53:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096C713E11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8BU7DdRtzmCZxDpyjCG36LvsSc1xEUxwDR1sDL2spP7zL7INonbMoCwcYRQUFMEEyB49pE4jczFBFkZdHYYdfghG5UVngB7ecwJCVhWtiYDLiIhcTvx6brsw+1rgEBCqCQdXvX04ACOttqBCmrRMpyX7IBRj/bKFWpOyVBogUOdTemdW+qbg1wEpiT4x8l2kG23cq20aT6E7UcApq7778pVlfLjl04GFncctpenyT+XyhY93Vv9xOezj+gX89SRQG3JnDmMzJxfIauiJyKY5k1Vj0+Ry9mT9Ql3YNG99wnpF6N3zZE84gBslCPumBKaB2pSCE8Ue7kQlXlKwTU+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R67TDDCgzx+HUCVv27GsLOD6zQFgthHasASlUDbNu6g=;
 b=Tjb7RraRx11B/Ebrmm4i2syp4ck53iBNe2NVZtAqccIGa+fUV8F+f6abgBi9KT6uiL9ErezKNaSu6Sb7hxxUzfnQsVBgEIPd9ErcTONS93gDvEbS/ZSydHCHWWBAFKuFbDy769eOaU+VB0rS6/MFERkBPWRcxkg2bWLAzoX2WepPoq7iO0jGJEXjX96v7lpfnoJimVyFZTKhHy8z13tXVXITtQAEI2CCpnp+tu9AgAMZlCRieQa0XksFu/L7IAzmK2OgnfxcJhscliB96VjRNzEueFGkr8sCut4p9aCIZ+uyj+8tEqB7YjsK5rALKkHMxj7l71jdz63vn8Fs5fBxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R67TDDCgzx+HUCVv27GsLOD6zQFgthHasASlUDbNu6g=;
 b=OdcQVzC03hW+F/Tnv8uiIzEl62yDDliCy6eZ4wercKJCjCPWPmrCWBVam539sxbOUpNPHonECw/M4x3YikA1p+omJ74CW3DD3QHJgx7Qz/twiI4jmy4dsDashjn/OdR4O3ajldjg0C4eumzlsDToWOEURQ+Yl4Yq45RtRP1waXyrqrm4v/fK55tMDCGl8sZd8LRA/pnZcC98Os3Q0qyx9MS+KKjJ4yvAkF+dGk3NUofQTQKHvdoOzsei7FImE6Mj1IqZ74Y+g6H152DdPUZRk7U5L+vphNs+KA99o2xDMrs05EKJth1hLRoOnbtgDsoAMQfy+s4W/2ygOZ/VhZWPaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BN6PR12MB1346.namprd12.prod.outlook.com (2603:10b6:404:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 02:53:42 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 02:53:42 +0000
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
 <8f19b172d32be2e889b837f88b1ba070bf2c97ee.1660281458.git-series.apopple@nvidia.com>
 <1ec090fa-f93b-c197-e5b3-ff2b0d5862ef@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Mika =?utf-8?Q?Penttil=C3=A4?= <mpenttil@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linuxram@us.ibm.com,
        paulus@ozlabs.org
Subject: Re: [PATCH 2/2] selftests/hmm-tests: Add test for dirty bits
Date:   Mon, 15 Aug 2022 12:35:48 +1000
In-reply-to: <1ec090fa-f93b-c197-e5b3-ff2b0d5862ef@redhat.com>
Message-ID: <87lerqw72n.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SY2PR01CA0032.ausprd01.prod.outlook.com
 (2603:10c6:1:15::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3414976f-51a6-4654-d3d8-08da7e695ca0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1346:EE_
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdf4E4KtCecf/cpEmE0nR3gB5FL5TDCmvNV51iwmBaSSejBzU8rfqSCMuLABHTEIsgywWd0uMBjVREIOL6pKfYLgYjHmHx4P4O8iNoOFU5GlP6IaeQkyHUuZfXIdo6VpgMuaa9TAKGdHo7GTKS36U1qgFgFjv3f+UZIR2BFDajkGy1Lw8FSMDA2l8XwrWN+GG1DxXjiFWM9C5DOk3dSVVzkbIef4aQwloEaKxt2fscRJWyILjcxdzK3dcaxC9DldEsOM/VBpM0NS2ue9wfcqsWOHfdOa2DFqgF/uHmDXchC7BnVim2a25tYQwy9dAewYmniBTbH8niBvsGHT4dEnu7WJ3Hd15zJoCckEP5Wsph0GHRxo7sa2jqR/yeITCgxScjAIdpZVz0+rAAVSJg2bheXljDlU4L+FGL/Lzsq+AZJpo/Ep+x3BJnfiFJ/ceER53IKrlxZs84NSqlZkFpUD1WF8S92Oy1ydvB9sX4+2kCVmrkrmSe5V/H6kluiAjXxCuvut/mb/GpjwPfbbyd/QjkMhfXLNnlpOhxR7iUjw5ni2OKbWZErVkY1fCEKbc3tgrYJkhjO2RTlLuBkjKbjhV6WKS/Ncmc21lNV56DmObnJ43SLUkx1iVjs4fN6bJhq7Il2CUFJYa+6k474PaOVwlgU4zAOxKM6bEtAckf4eBfEXUcpwlNCQ7KCrrk4OQcN+hv7bE2FFRLD2zVmyFmuvJEiefNKpsf5NXmgAnxkSo0aZZIgJGKvMkAXm+1fcGXTx41/UfHRX2HAncA7DBnEcpWOObVes+S5VHnUCBeUamiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(41300700001)(316002)(54906003)(478600001)(26005)(6486002)(38100700002)(4326008)(7416002)(5660300002)(66946007)(8676002)(8936002)(66556008)(66476007)(6916009)(2906002)(186003)(86362001)(6506007)(6512007)(83380400001)(9686003)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWg5ZDZXV3g1YVA5OXRpSmszbFFWNElwMUo5UWxPTWRwMUdJSGVtMzVxRUx0?=
 =?utf-8?B?OXE4b3BET3R1ZTV3MHZtWWFXMzZuV0gwa1BWVlRLbEtxVE81R0hWQ0VTUTRa?=
 =?utf-8?B?SXpkbVRjVjRGQjZQSDdxSGdFRkJpUENTTWhxenpYanNGV2VuTWgzdFlvTWsw?=
 =?utf-8?B?SlF0QlRqSXJyUE83K2YzaVlSdU01SHUxa0x6K1VHM3psUlloR3h4RDgzZ0Jr?=
 =?utf-8?B?UE92UzNFSU9YSnc4L0xlMGd6Yjl5L3NMVGFUdGZBS0JUTVlXT0l6MnZaK1VV?=
 =?utf-8?B?WmEzZWd3dGJqbXdqQW5LZDlHbVlodlI1YVJEejVmUmhFRmM0d2RHMzRjNDhw?=
 =?utf-8?B?QVNMeWVCUms0eTRFdThLamw1SjZZdTJ3Wks1MVJLMmVGMnpHWGNKVmlrajVU?=
 =?utf-8?B?NzhDR2lpNG40THp4NXF3SXd3L01ycUFCaklua2x3eE9EY0c2cXVoMHdMWXRv?=
 =?utf-8?B?MHdmVE9tcG5qZUNEUy9SdkZiS1QyL1VxVUJVWUtvSVlSSHZpRVFQMlZUVGxX?=
 =?utf-8?B?a0VxdldYWW8vM05JalhLWDZhR1Q5NkNkV21UdzdsYjMrME1ocm9OZGdtM1A3?=
 =?utf-8?B?T1pYMjhzbTFYQzVxbXJZWDRRbjBYai9ZTU04Q0hqUmZoRE1tZmh0bVJGcXBq?=
 =?utf-8?B?dG0vTDEvWC9YUXlpNXFvN1dKMWZ4SDZiSS9LQmJsL0k0U0h1V0lzVUhBdEVm?=
 =?utf-8?B?dkJ6MVBzQ3kvYjA2MzZ3T203cXhNcHpxeTdOaGdwTmJPVVI4OVQzeWthQkVh?=
 =?utf-8?B?RUZSdDBvYmhGLzFGOVFMbWg3eGQzTkwwam5uamxKbEI5SnM3Rk9vUlA0MDN3?=
 =?utf-8?B?Vm5INjRiY2FyM1VtR3M4SFVMUUVmVmpKZ25acGJOZGtTSmE2Z0RXcUJqRllt?=
 =?utf-8?B?VVI5SU9iWDVTWkJmTWxJa2c1UlAwcGFDOVZDR1JIbzI1WXZzQm42MTFmNDFN?=
 =?utf-8?B?bm1TYURGK28vQVV5alFWbFROMHpQbmtXN2cwSGdQT25YWmMyUFBUTFJwY3FO?=
 =?utf-8?B?UzNqb2xxMXVZWXdpSmtydXNMS2VRV3dhREFTVDJRVmEwaFNUMW1OWElnZU5K?=
 =?utf-8?B?UDY4aGZpeUw0QzIwd0ZLYjBHZEZSMEc3YTZEUWdIY2xqUzNtTWtYVVRSTXhV?=
 =?utf-8?B?SE91Nk8yS3FaekREby9wNllqR0xUZXhoYkFWaWdvT2JjYUhjcGZHd0JYSFAy?=
 =?utf-8?B?SUlRVFg0NUNIbDlPUk00YW5DUXpTL1I3Q2hDTDBjRXVOZVRiVlJRcGkvOGhI?=
 =?utf-8?B?Vi9oc3NBa1NOQXBpT2VBYzlZQzVNdmo0VHFVbDdoRUFqS2ZCREdQSnVCYStk?=
 =?utf-8?B?b2toTjAzNktySkZ5VkNTenNkMUwva2VYNU9rZnk2UTNMcGtVc3FZMXJuVjh3?=
 =?utf-8?B?MmJKUE5ZZDV0a1pNS25VSGlaK29XdjNOUEllZFQxaTZHWFpmMmdwYi9ZM2JD?=
 =?utf-8?B?czkra3RCNUNGRGkvWGp6TGlUOTRTd1RLR3RnQ3RrUFhVc3RPaE5YMHVPT250?=
 =?utf-8?B?TDg0SWRuT2VRY3lJbk5RT1RsUTdPM3l6aVptMHlXYi9nYzhod0I3UkVwQ2xr?=
 =?utf-8?B?TFF4amdEZDRuWVlDK09oWDJrOWcrMWhuQTNhZEVqYjNpVWtOUE5LOVFPUjRU?=
 =?utf-8?B?Ny9xbjkyRnV0UjRoN2V1b1FUcHk0YVNJc21qdHdubjFPS0VLMVZUSGxqMVg3?=
 =?utf-8?B?WnY4SnNjVmNVREp4MU9XTWQrMkdFOVd2dXQ4VU5qMUxueCtuNFF6TnpFcFdG?=
 =?utf-8?B?R1ZMRDlvZHJqSGVuRlc3RXh2SFNpOWhIZ1Yxai9BeFhIcTZ0bmpEek5DVnhZ?=
 =?utf-8?B?MWdSN2Z1bUQvcXExdDhZaXhWV3A5cFBvejJKMnhrTDFHak5WMERLMkp6Wmhx?=
 =?utf-8?B?Mll5ZEV0aUxXSklKcG0yVFJCN3dzQklsUWZ3RXpwR2xHT013QVNIOUo3YzhB?=
 =?utf-8?B?NTcvL1FVeFU4aDMveXVvanVWLzNreXhwaWJUYmF0RWFGSTNBWG15akFaR0Rt?=
 =?utf-8?B?a0pqWmt0U3p0SDJvOFhNRS9pcGN4eTJyd1dja3lqYm5oMFpMdzZna3JtVDEz?=
 =?utf-8?B?WU1WSFlMNFErZTZ2eW0rbHBuRjQ0bERpZVVOM3FzTmw2UHVxNnh5MVpMYTZo?=
 =?utf-8?Q?CkCzL8AnnlmLU29/NiiOFcEJ0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3414976f-51a6-4654-d3d8-08da7e695ca0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 02:53:41.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHz3LEJLjeicdQgMQtPSuqFIboqa/b4I51Xs1o+Bgds8iEUgYuccVgwaP9OnKREaZsOLtosvmI0/Jry4QAFUxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1346
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mika Penttil=C3=A4 <mpenttil@redhat.com> writes:

> Hi Alistair!
>
> On 12.8.2022 8.22, Alistair Popple wrote:

[...]

>> +	buffer->ptr =3D mmap(NULL, size,
>> +			   PROT_READ | PROT_WRITE,
>> +			   MAP_PRIVATE | MAP_ANONYMOUS,
>> +			   buffer->fd, 0);
>> +	ASSERT_NE(buffer->ptr, MAP_FAILED);
>> +
>> +	/* Initialize buffer in system memory. */
>> +	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
>> +		ptr[i] =3D 0;
>> +
>> +	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
>> +
>> +	/* Fault pages back in from swap as clean pages */
>> +	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
>> +		tmp +=3D ptr[i];
>> +
>> +	/* Dirty the pte */
>> +	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
>> +		ptr[i] =3D i;
>> +
>
> The anon pages are quite likely in memory at this point, and dirty in pte=
.

Why would the pte be dirty? I just confirmed using some modified pagemap
code that on my system at least this isn't the case.

>> +	/*
>> +	 * Attempt to migrate memory to device, which should fail because
>> +	 * hopefully some pages are backed by swap storage.
>> +	 */
>> +	ASSERT_TRUE(hmm_migrate_sys_to_dev(self->fd, buffer, npages));
>
> And pages marked dirty also now. But could you elaborate how and where th=
e above
> fails in more detail, couldn't immediately see it...

Not if you don't have patch 1 of this series applied. If the
trylock_page() in migrate_vma_collect_pmd() succeeds (which it almost
always does) it will have cleared the pte without setting PageDirty.

So now we have a dirty page without PageDirty set and without a dirty
pte. If this page gets swapped back to disk and is still in the swap
cache data will be lost because reclaim will see a clean page and won't
write it out again.

At least that's my understanding - please let me know if you see
something that doesn't make sense.

>> +
>> +	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
>> +
>> +	/* Check we still see the updated data after restoring from swap. */
>> +	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
>> +		ASSERT_EQ(ptr[i], i);
>> +
>> +	hmm_buffer_free(buffer);
>> +	destroy_cgroup();
>> +}
>> +
>>   /*
>>    * Read anonymous memory multiple times.
>>    */
>
>
> --Mika
