Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2175966D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbiHQBfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbiHQBfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:35:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E84594108
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPgSkBKkvLgmcC96Cm6Q79XgpcmCx5+gCRxpXESvwui6djiWTVZqvR/3Tm/yqHIzHgzTn34johDzr4nIt4basbrqTPIBhtP5QkfIqAuxq1R/GYF67b2docvS/CXcb37CYfYOCXfVGNKMf3uuEj4rmMnfovvxZ1sbirz2mS5YcmHuIcoip7LLdViRlU+XSJ/hlMQDii6U6hL8RAU2IHe+FJS7I2Sv8F6CyVz5g8wEKTx2E9UZJ0qCcbanxeVM/ndj1VRk2Fn93r1r8RAQg2O5H5ML04zSnRKCOWMSnsLacsgvy1+vWKtC+1r8EIsXQShbOXd9tw+Lz9rcHCKNGQiN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvZNxmRMjyqOyaOLcR126cQRUDMUUvEHfNIwcC3Umu0=;
 b=lNUMAq5Or7p0fIuLQPiXGLPHfkxVjRR0IoZHip0UwvhRm98hqN0Dd1lBuxrJDCcOSI6nFdKHhlKYbZEZHIG9n3NFrn7qRMVN+yhdYL6ZPwJYdMijrZ5B8cFVSLTN0VOTqiCrZkW4LVg8VKfOIPa95MxGV+u9zxzKqPqiZQOtfBQiy00mFhlPAb7Z4TKT3u7ZSQYMqv6GDium2yMD4Pc7rFP6o9d2iuWwa8bEdSrwUyFzSdPSVLwsRgxWZl5Uzo9MfWyTGBtLyVacCLro3Y0n5q3eI8G5eTvQo4KPF0HXqe8Md8qJV2odjU78Q6vOsHcy3jeT/cmGz0wCxaDyLJFnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvZNxmRMjyqOyaOLcR126cQRUDMUUvEHfNIwcC3Umu0=;
 b=cXgjseDC2r1xc8EnPlsCCnMHIGvD69J0nwvke70yxFJ417Zpc+oTbYActXoIi7UYdj3Vam1KI34eCBalWL4RdYH90bgXzceQpgcez1HgbudDEILjwYj+LZGWa/8Fy/N76hajKTEzbAAnSUyixyZESt/vQuCzZ5qRbtQzF4BrS2fOZG6cndl4LvQsiA9XcK7cVM5kYQ6fDUmHUhUNPevnM4w6QdQ/ovNfrLammWmqSSezRPOuY2Kr8hKdSikCZ/YYbToZr9GrT+tmIhH2tUZxhZvvYSmcTfh6s71z2ZEPEuW8Dp/WJGS/8+suwnavYraYhvEMjZfMf6ylq1kwI7wQvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 01:34:57 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Wed, 17 Aug 2022
 01:34:57 +0000
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
 <CAC=cRTON4s6LJ+09mg4SxMjNirBih3QSt6cr10gNjs3k0o+BgQ@mail.gmail.com>
 <87r11gvrx6.fsf@nvdebian.thelocal>
 <CAC=cRTO6nWGus4v=MhZZeE9hdjM2A5bChHHU_tSbtFD95fFi9w@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     huang ying <huang.ying.caritas@gmail.com>
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
        paulus@ozlabs.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/2] mm/migrate_device.c: Copy pte dirty bit to page
Date:   Wed, 17 Aug 2022 11:27:17 +1000
In-reply-to: <CAC=cRTO6nWGus4v=MhZZeE9hdjM2A5bChHHU_tSbtFD95fFi9w@mail.gmail.com>
Message-ID: <87a683veip.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3de5dd44-cce8-4a07-f9bc-08da7ff0b1b1
X-MS-TrafficTypeDiagnostic: CO6PR12MB5426:EE_
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFkTPHPFrZv1t5x/R3l1QrM2Nbd9Rr1elaRoZnOilyFDpff2rYByXpINX4r6u85nkyC6f1pbuO1laH2InGk0E4SRuZvVPsVsVKTCAtM9qf2xwYpy4UzVQ/XWAx0YdrLyikogVCfheZ+thlzL72fGdWwURurKxTlwIs7TfRHsWy/xvilUQrFLl0HxAYqy8ExfOlmQqVxZWDaFSgrI6wKZ3B9EVRuqBuLloN8F5XsNacqdkK64MkgEUGPBA5EZ93s0g1kF1FRbGSCVCFIb/NIeI0pvXoEzAXEMAFkaisiLx5x0+qsA5XKlTg4y3zruQqZu0PMy3riZ3FHIQDxorw34ExUZJ3w6T3mXHL0MhXatt0dLejOrQ/1awZcRYnowGch3Wu5eK3zU5PDzIPfpUafaRTQKxXmtlLrZJorNATyMcPXS+oXfhygRVfkiyU6zy1ci5KgRsHFPnMO27d1PwZ6kqExGlwrwHau+sh0lpRG+TrfzS5WV7WwrNDI4MKsdG3EHl1Jt7kfPlYoHYTngei1ZoAGiAP7C2eqyZvifnb1TTYsbheaT+5ReKXf3lvLDVaze5gD4OMCWpTDKmsQVt2DnHzmLbLAYg9jb63lFe4nLlXOHirZnfxKYlSIJH+xKVi8zoNpYdgJ+smIFyzJcpCnKDxVVWaZDhGpllrl9WTHY1pmuAL2EbLaJg+D78ndkmVYeBhQenP7UVECQAx4Ol1MH0/ZW07YQ7jg2FLyjFHiJQVvny6ezQ+1MaYyYyOonyJYr6jGZdoXJXpWNbStyvUJkruDJG0c/nlkzXP95GHT6bkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(6486002)(8936002)(54906003)(83380400001)(8676002)(66946007)(6916009)(66556008)(66476007)(4326008)(316002)(7416002)(5660300002)(6666004)(6506007)(86362001)(2906002)(186003)(41300700001)(38100700002)(9686003)(26005)(478600001)(53546011)(6512007)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?62bfuV/8FDa9SZ2F7gXDKW+Q/Bw2vNwofspfmgpJoX5YrhcHBZL4ymwdu84J?=
 =?us-ascii?Q?R50Hbfxdg3HvFVMGwr5pH13nvA5lnQJ5J4bCauooCxtMXOC8XgIa62gu44bF?=
 =?us-ascii?Q?tpSjL6a5W/8iKI1QWklYzJFJcWGhoB6TVG1WI+9n5R7APpBt1BycQBMTSPVe?=
 =?us-ascii?Q?MT8GCRXzyIaXnD0bA3KXi96ZVWN2X+EmgOALEG3FupGjO/EBRzoDYlLTyJ77?=
 =?us-ascii?Q?nPvz5WaTPpFMVTHlWGbeKr8S0lDefmHfMLWXcB1YLvNa45jcuB/O2lRniZAB?=
 =?us-ascii?Q?k+mWBpbClSADqrcP1s9xokP+2FZpZX/G7xDbUlAwwk0ARBQySc9IsEzO0RF2?=
 =?us-ascii?Q?wx4yf9UUPqmu/77XbrRUSYsNNUQCfXZEtNNi29xThsnkD+gyCchOKNHjvNXP?=
 =?us-ascii?Q?NtH+nghXTHmT9QoQNPKS+dygCSfIl9PlqgGKP17xIZg8Eldl7ugOYRqNdi8W?=
 =?us-ascii?Q?2Uf/mlpewqd3fmWXshMcxM8skVY8XCFb614LbePAT3rXrQ6JUIVaZIv1n2PC?=
 =?us-ascii?Q?ukATThWD0SLIwc6h57LI4u6zdDCK24FN2htOpjG0waAonWnuPir6LiBsOhlw?=
 =?us-ascii?Q?13vxtCbv1CybnAVeuu3PPk/7vFonsiKklrFTHLAyRUeyPm7g9O0QkvMUIYeu?=
 =?us-ascii?Q?Wqr0gwtAYeLey4J2ZU6V26f/CRW6AJb7dTyy0NAXoRewOqXhTQsAr6MS/MUu?=
 =?us-ascii?Q?FI0OE1h/JbiQiJ+EORRYv20SkiLkI/9RtOGkzHppC2YnRSPF4ufrLRWjiCnf?=
 =?us-ascii?Q?dtHEITCKg3Mp7t5vgP4Khqwj2B04PUg8dTZrTIkOp+cmWEPcjSma97NNKU1I?=
 =?us-ascii?Q?ICjWDzIWrq+fZt58ZmMvpR9hmP1JkF+sP8n6aCJVlsV1Gad/Hs2AX2B6xhI6?=
 =?us-ascii?Q?PCIcPYp4L5KkZl5artHs6PPJV/yjvMLsoppu/GqUFwRn9t2aZnJnYx2joBUz?=
 =?us-ascii?Q?l9ATmz24i6rkqwFpeN5munV270SkcbiQ4zz4EW/gM/j/Dz+bTTloC37C6Sr0?=
 =?us-ascii?Q?esc/f6V9tim12jXC2pkBmFPIjjSUgvWm3bYzEzNJ9sl3Dl3rpVdF0AwQr/um?=
 =?us-ascii?Q?DBwUaQ5vtHfnEEOKXn/rzSNUhlKqoqs1NGKJe+R8DYdcf3myr63usPTIKYvv?=
 =?us-ascii?Q?SJ43vUjHB/sucONTQGA5Qv8yKu/IqG60Fx/GIHVCutqoamzuKPltcRZpo1+P?=
 =?us-ascii?Q?8FQBUTyzH/6XCfzG9Grz+T+Gz6MTosmU/A9Mw+kq5pecKI8xAowcZB2c1GQK?=
 =?us-ascii?Q?1rF415HtVf9GGzMfaa9wbmtbR15KLtJgJanzVLjWBG6RKvCDKTbBlEMLkiVT?=
 =?us-ascii?Q?I51BFnA8Q9ltXzUSF3Hz9P7KchMwtsiAtwDVelw1rCYrQx5btclS8HMfA60Q?=
 =?us-ascii?Q?/ltL7MP5rSN3sB37zSoT/VM1FNgO/yJYt3+i0fsBNveLuzSW69Sksh2AaE4O?=
 =?us-ascii?Q?18EvNYGDkvAFfoLhim1LohxupXtbLLYAQ/A2dBKjruJ0obZSaZLj88qizipZ?=
 =?us-ascii?Q?6yeC0tPwcO5NcReEUmMCtejxmiOVkPr2InxwAyn4mXJ3ePNTctRK8xIeo+fT?=
 =?us-ascii?Q?8aZxdc12DWFESZh30ClISEFxysuBYP8I7O/0bolJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de5dd44-cce8-4a07-f9bc-08da7ff0b1b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 01:34:57.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlgTPeSQXteui21Y996dV3AWzU5Zr9+TVYJoURW+cHSpAW//AyL4BMK4tDzD2K/REm/WtpEGfcjb97UxqsAtTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


huang ying <huang.ying.caritas@gmail.com> writes:

> On Tue, Aug 16, 2022 at 10:33 AM Alistair Popple <apopple@nvidia.com> wrote:
>>
>>
>> huang ying <huang.ying.caritas@gmail.com> writes:
>>
>> > Hi, Alistair,
>> >
>> > On Fri, Aug 12, 2022 at 1:23 PM Alistair Popple <apopple@nvidia.com> wrote:
>
> [snip]
>
>>
>> > And I don't know why we use ptep_get_and_clear() to clear PTE if
>> > (!anon_exclusive).  Why don't we need to flush the TLB?
>>
>> We do the TLB flush at the end if anything was modified:
>>
>>         /* Only flush the TLB if we actually modified any entries */
>>         if (unmapped)
>>                 flush_tlb_range(walk->vma, start, end);
>>
>> Obviously I don't think that will work correctly now given we have to
>> read the dirty bits and clear the PTE atomically. I assume it was
>> originally written this way for some sort of performance reason.
>
> Thanks for pointing this out.  If there were parallel page table
> operations such as mprotect() or munmap(), the delayed TLB flushing
> mechanism here may have some problem.  Please take a look at the
> comments of flush_tlb_batched_pending() and TLB flush batching
> implementation in try_to_unmap_one().  We may need to flush TLB with
> page table lock held or use a mechanism similar to that in
> try_to_unmap_one().

Thanks for the pointers. I agree there is likely also a problem here
with the delayed TLB flushing. v2 of this patch deals with this by
always flushing the TLB using ptep_flush_clear(), similar to how
try_to_migrate_one() works. It looks like it could be worth
investigating using batched TLB flushing for both this and
try_to_migrate(), but I will leave that for a future optimisation.

> Best Regards,
> Huang, Ying
