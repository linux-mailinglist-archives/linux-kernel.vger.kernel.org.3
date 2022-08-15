Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F05592845
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiHODpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiHODo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:44:59 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3844411451
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGfGbTVeXy1kbMIVSOEX4CgrCgwae+9Qo2irMeZqXKAtgk/hCBxSX6Uay/W7LsoYotPwAlWo8IqVeSYaSTq33X8YTzgsV3mW4JtRAd2aIgWX0vS1fbyUUxB4QRzS0tmQxeo0lix5QHIQ/5VMAyGit8BQZmVzrWjjkNj2gZOjtxT3CoHNVAt+KNV8jMbxbD3xvywzo1v5JcccvldIi/wbu+BGmZyoEBARxrdUUK3ZFX28WSz1bTHxDF1LuAkE5IVEOwfxVbaDq0PFAQif9lYOpf+zPJTT3e2cr2Lh/n/nqUj1qtvgs7ajx6UtmU4RUtESyTX7ZJ3aKCiw4S1VS1Oh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZFrh2vshhSEfOF1ysRcQ3ru2F38Oy1PQdhfxM9eWmM=;
 b=EhkHuvv8i5r1e3g+DiQwcENZ9CtyBBNbn4PNfZZkYoHcD2yVUbEP1dqQfcgo95BQXhLIglack18Pxqw15SJlIVrrizyuN2zOo17do/o7anVDqIjhc3XOoZ2AzU53DgSR23Q+eOqSd5tM4lCeN8aN8EVh+BxvJIzpHLwmG7m2mJTpAE/lJTri/4OcvyD/5Raevc3P1GYweP1aFIjTSfgh3C+fOATjngHzrCq5On9SMQz5dXOtfvfU00YK9G72lgoKg6x/F2ROcujiPwGnifccL2e3zYzJHlPSD+AFmi3aR61Js1kXmGJDO26pDiMM/VcY0PLtBgozHlbcILgFRlPsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZFrh2vshhSEfOF1ysRcQ3ru2F38Oy1PQdhfxM9eWmM=;
 b=jwgDi5Ga6De2Fiw+a7DTOElS1scmsihstXu3VeFRGp8aPVcQLje4LtOHC5wqbZMsWLa2ulRdYvnjESSQPLOwFgbYy0VeIbbFlqqRT+7BFcChBIgXfimvWO+lpEskGphXCQdbHcLKzOA9vh6GCYOuGF3f3g1MlbrJbj/U8z0B7EnHsyGA4SWDZcC/YanSboea6kyZqo9OKcoamworcvJQSt+4zTdXRa9AcS7875Fz7ZzQtP1JyTXTi7DLUGL10SudEI+ki0l2sn9cZ3ZvHHN1z3wQLEuOh4A0rSCOG+nbqYX8qtjHxAReivFge7+f6GaXbtyi2JBQL4581MO7+AGWQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 15 Aug
 2022 03:44:56 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 03:44:56 +0000
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
 <8f19b172d32be2e889b837f88b1ba070bf2c97ee.1660281458.git-series.apopple@nvidia.com>
 <1ec090fa-f93b-c197-e5b3-ff2b0d5862ef@redhat.com>
 <87lerqw72n.fsf@nvdebian.thelocal>
 <58be2b37-0c3a-06d8-35f5-50bf4b765fb2@redhat.com>
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
Date:   Mon, 15 Aug 2022 13:21:56 +1000
In-reply-to: <58be2b37-0c3a-06d8-35f5-50bf4b765fb2@redhat.com>
Message-ID: <87h72ew4p6.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00f99bdb-8fba-4469-3c63-08da7e70852e
X-MS-TrafficTypeDiagnostic: BY5PR12MB5510:EE_
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2B2XYLzq4cWq3ZKOXpW72XOmCeW9aK7EnhTw6O4g29AudL4We16yH8jJiM91TLB3bHZOf1GqHRuNYQBzHjMCf/vM73L0Tom5dK3IVxkN5DjK5wNeQSwGxu1kYtGSmAQwDfsBJLZ3/oR0K8bTj9FrVJ0oCQ5fPkZ7rL7wbmqYOHrkctNSbWB9BDxTvrvzrv/yyQ/hNqeR5IYz6oPyKiDpJTJ1WCMrQhezAz/SyZtBMcQvkuvHDSxNqsNWSTphmf4lviG8nLkX+lfky2caAPJ/F/qclQ0jkcNh1qwh6/6of7yM+sgxFmXfkA+PVsa3gCUJxM5/S4Q3Mn+ZU+dbBxK4tytoqV3HlOt6f5+3MXMbH2K2HO/k1pdhJId1B7nm/8iNldl2YSaXrgdmBwDxFOMnZR7m8dmpIvh+0b3ZS7c/QmNSS1BVn4DI4ej+iDFx6dt6ZySVFHNwR+D9AFar2ZFK6F0HGdTdYmftwf8aWnGQPqQ2pxXKoVwFbNTpQZyEooEsU+0cpnZ0bnCSooDO4wxn1N+DpMJMJvkPgu/qNhalViFxf6LQwl0YjM6PDXdjh16tnfVtto978nhEfX80rnnfrBdzYcRnHudnOI8DJA+dAzEwx8xmgLsZ9gbW3OtRARUzXycakpz0yS7jkPGSrTPr/Ag28JXi7MONrXP2ZZzi18J/0qf7Jbejez23w7jMatvTacIHTH8XVo7iEvwk0xObB2PV4FjmMM1kVCKIZCmWHQiLBoSOHhHrYIVsC1+2DmUqIQmt/9SmwVYOOiHxtketvISyst5eFvuBqmKKvx1ED0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(5660300002)(66946007)(4326008)(66476007)(8676002)(66556008)(7416002)(2906002)(8936002)(41300700001)(316002)(6916009)(54906003)(6486002)(38100700002)(478600001)(9686003)(6512007)(26005)(6506007)(83380400001)(86362001)(186003)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dERmbS92RUwxZDA1R0QrMDRhZ2wyR1ZYcXZVNVduRDRBdldqSFZtc1ZlYXBJ?=
 =?utf-8?B?YVdacjgyOXlOYnNvMFNLWlh5Wlg1UndYMXRNVnZOcTQ5MjBXbUhJNjFPVXF5?=
 =?utf-8?B?L0REV1pNV3NTZFdHaWd5YkdvRmNLMFMzUUN1aUkveWJtZVJsSlN3UDFLR2Vy?=
 =?utf-8?B?MFN1M2FpSk41bnJVK0pRYW5za1ZGcitleEg4NmgzWFpOMTl5MWdmZ2wxK2lK?=
 =?utf-8?B?NEZFWGttNjB0NFpFd09WMGN2d0hjeFFGNTRkRXhvTWFpdHY5Sis3ZnQ5Q3hj?=
 =?utf-8?B?WlBXM25kNGlTQ3hHVXZlanEyWEd4ZTNQTVBPeTkzeUdqN2t2VUhXMWhvY0RM?=
 =?utf-8?B?MzVIVHhPVEFYa2s3RWtUanlhY1VrZGF2MCthZGJNNmdTaTEwZUZabHlTUjdk?=
 =?utf-8?B?d0FNajFTR1p6ZTBRWUs4K1F2SDVwRCtYRXg5UEtPS3RwWkRGTjNVSzVhcmJl?=
 =?utf-8?B?VE9vaFJtR3BYTHdGRG4wV2VtUjNub1NKR0hycVVkdjQ5SkRocmlKMU5tbnl3?=
 =?utf-8?B?NnU3MjBTdEVEVEkyUGQxZkpZR1psbFhXc3k3ZGVvL1ZOVHM1NitidEM1T295?=
 =?utf-8?B?TURuWGpacHlMcDFvcElPYU5zOWhIandLdnlsdUI1RENHeTlTMnRPQUhpOTJm?=
 =?utf-8?B?NFAyMzZBL24wOE43czlGbmN2cUM4ZnZGLzN4WHU0a3R2OGFKbjBWT3dkMmlq?=
 =?utf-8?B?ODFoSWpidkZxN25NNzlCcDQ4Z2hXaW5KNGN3eTdQL1c0ZHVkbWIvNXg4aTli?=
 =?utf-8?B?Q3Y0dnRyWkNyYjRXUERqL2FBUHI4NFhMWUdidmRRQk5pZlB0M2JrNlVlSVBV?=
 =?utf-8?B?R3lNV3k1TlNCcE9ndXBSeWdsc1JtSFg2cFg1and1WU85YjNJSk1ZQ2h2bGxm?=
 =?utf-8?B?L1RodVpSRElibllwTEVJZm9zTzBRamVRVmVEd3BzWWxTcEh5Sy8wdm9YTVVU?=
 =?utf-8?B?UVYxbzFSM2JGQkQrcnY5ZWpGdTd6WCtzWVZJcHd6VmkrRlVXb20rNURWcnZr?=
 =?utf-8?B?YnZJRUJrdE95RGtkK2s3UjF6bTRCeWpFMVl1T2JiaEJuSktBRmRncWFkNU9V?=
 =?utf-8?B?eURkVUtYQ0YwWXltR3NwZ3YyZmFyS1lBbDZTN1ZVejk2M29MbFZVODg5TDQ3?=
 =?utf-8?B?MWUvNGJ2OFlPK3VFaWFFY015RGRGT0FVdVM1ZW9XUnJqZmMzaDNSQVRJVVlY?=
 =?utf-8?B?Kzd3UXJzZVVZMkM4cm1sWEcwY3Bod0xSRHlwb2c2TGlFWGJ1VTg0R3docWJi?=
 =?utf-8?B?dFJOYWFyNWN1dHBQZVdnbVJjQTh5M3dka2IrbTNOL1RMRERDSDVuenAxcnQ0?=
 =?utf-8?B?d0ZEUytqZi9KK3ZRM3JNc3BzTnNib1R1NHMwd1JybEhYbUM3Yk9zU2tYaFRB?=
 =?utf-8?B?YWt4aVIzV0VHSmlWZXhMU3UwRVdUMkJ3RlhldzF3K2Z1OFNIcFB5M0UyTDQw?=
 =?utf-8?B?amxGYkZNamQ4WGtQb2VSMWVKdXdxRnVFNmFHcjZxVC9hVzZBZ2dRYUpDWTFK?=
 =?utf-8?B?ais0QTZIU0JaS0drbVFEaVFKWGl4ZWxaazNBQWtJVFRrbnFiUkhwOFg4WU5v?=
 =?utf-8?B?Vm5rTU9aV1NRRlVlUllZdDBSVmpYQnhqVVYzd2UwdWhtQ0ZYV2xzZzFCWnpR?=
 =?utf-8?B?MFB0bmMwSWNtNnoyeGgxTXNjcnZCZmRrcitTZ1FZWVU2R1pYcmVudmRCNTF4?=
 =?utf-8?B?U1VuRE51dGpFUVNaZFJBWjczWHhaNkpqcUxYUHpHcGhJdUJPeHBqK29OZ3pV?=
 =?utf-8?B?WlAveDIyWUJ6aDgxY1ZMRFNERWVNSGpSLzdmYzZCdzZJR01jUUc1eEl5NEw2?=
 =?utf-8?B?N3dNY0JnSVh1ZG1ST1hIU3c2WmJrRmwwNmphR3lZdEYzcnF1ejg1bloycW1O?=
 =?utf-8?B?MXdnZ0JlK0xkZHdseU01am9vTG1sVkw2Y1doVzdKeFVDd2pueWUrSW9NaDRV?=
 =?utf-8?B?eG9aN1lPU05jdS81SFZac1hoVkhVYzl4TlZsTjNGQVFrVGNGclhZejVGL2pM?=
 =?utf-8?B?aUVUR3N0L3hRMFV1WUxsNXRJaVFmV29aYTQwZnRwQnR0ZVBraFo4ckFjTHVK?=
 =?utf-8?B?S2FoWVJ0UWo1dmp0cnZyS3VJdXpCQTIxMWNkU3lDRmhQeXI0WE51SWJ6NGl4?=
 =?utf-8?Q?JA6yP9Jl4YmmwhslwS3IuID5p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f99bdb-8fba-4469-3c63-08da7e70852e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 03:44:56.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpuZqtbdHQoa9vGij/RfyNuxhLwI4uz9T6EHJHKjWULIe9flwrWV886cGK3BnaZ5i1yhIBz87huBOu1XAA+P5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
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

> On 15.8.2022 5.35, Alistair Popple wrote:
>> Mika Penttil=C3=A4 <mpenttil@redhat.com> writes:
>>
>>> Hi Alistair!
>>>
>>> On 12.8.2022 8.22, Alistair Popple wrote:
>> [...]
>>
>>>> +	buffer->ptr =3D mmap(NULL, size,
>>>> +			   PROT_READ | PROT_WRITE,
>>>> +			   MAP_PRIVATE | MAP_ANONYMOUS,
>>>> +			   buffer->fd, 0);
>>>> +	ASSERT_NE(buffer->ptr, MAP_FAILED);
>>>> +
>>>> +	/* Initialize buffer in system memory. */
>>>> +	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
>>>> +		ptr[i] =3D 0;
>>>> +
>>>> +	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
>>>> +
>>>> +	/* Fault pages back in from swap as clean pages */
>>>> +	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
>>>> +		tmp +=3D ptr[i];
>>>> +
>>>> +	/* Dirty the pte */
>>>> +	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
>>>> +		ptr[i] =3D i;
>>>> +
>>>
>>> The anon pages are quite likely in memory at this point, and dirty in p=
te.
>> Why would the pte be dirty? I just confirmed using some modified pagemap
>> code that on my system at least this isn't the case.
>>
>>>> +	/*
>>>> +	 * Attempt to migrate memory to device, which should fail because
>>>> +	 * hopefully some pages are backed by swap storage.
>>>> +	 */
>>>> +	ASSERT_TRUE(hmm_migrate_sys_to_dev(self->fd, buffer, npages));
>>>
>>> And pages marked dirty also now. But could you elaborate how and where =
the above
>>> fails in more detail, couldn't immediately see it...
>> Not if you don't have patch 1 of this series applied. If the
>> trylock_page() in migrate_vma_collect_pmd() succeeds (which it almost
>> always does) it will have cleared the pte without setting PageDirty.
>>
>
> Ah yes but I meant with the patch 1 applied, the comment "Attempt to migr=
ate
> memory to device, which should fail because hopefully some pages are back=
ed by
> swap storage" indicates that hmm_migrate_sys_to_dev() would fail..and the=
re's
> that ASSERT_TRUE which means fail here.
>
> So I understand the data loss but where is the hmm_migrate_sys_to_dev() f=
ailing,
> with or wihtout patch 1 applied?

Oh right. hmm_migrate_sys_to_dev() will fail because the page is in the
swap cache, and migrate_vma_*() doesn't currently support migrating
pages with a mapping.

>> So now we have a dirty page without PageDirty set and without a dirty
>> pte. If this page gets swapped back to disk and is still in the swap
>> cache data will be lost because reclaim will see a clean page and won't
>> write it out again.
>> At least that's my understanding - please let me know if you see
>> something that doesn't make sense.
>>
>>>> +
>>>> +	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
>>>> +
>>>> +	/* Check we still see the updated data after restoring from swap. */
>>>> +	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
>>>> +		ASSERT_EQ(ptr[i], i);
>>>> +
>>>> +	hmm_buffer_free(buffer);
>>>> +	destroy_cgroup();
>>>> +}
>>>> +
>>>>    /*
>>>>     * Read anonymous memory multiple times.
>>>>     */
>>>
>>>
>>> --Mika
>>
