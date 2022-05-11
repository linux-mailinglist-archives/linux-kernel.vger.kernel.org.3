Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C769522DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbiEKHtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243125AbiEKHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:49:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31689A0D3E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQfj+ceHOWjvkvFZfL1cGivrrE6Yx79f0upzO0vLIkhZprSt9/xYESEml15upo2YnTcrNHdZVY7pc7NGE/U89xn69S+BWwogWwGZFgATY/EYeLbwX2VGj36Br3sFN/YX067ORcrSk/UgOJbhslnV/NUvOmzr7tE+FgZ8VK/bJaPmPBN+zv8vZQRiX3KuPkXSKvjqiGUhRwyWOnX6u88oKRLPCxpNPIsUJRWjSQf6nGzwfNhV6yADGhLYetUlcKB8RLjMpWh3zs6oiK57EDJmq6OUvBoGoFDiBwkZktZTQuOq3m74N1waqUDuH/cHUBfANwUzqtVGK3ObkDPP37u7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Djz8AQRn1xix8a7cJ5vYXWnzBAPfIkjyGFigQ3aqJI=;
 b=W+yqlnVlUFovViOC6eyuPHTle8N1uGOI3on55ID/iIHzM5pG5JwRw8YDuB6DL1m4Cq9w5iDmdQ4QBcC2q+uRa939zH5L6/+bOiusfr4nHc3OmAW3pHCuNOAcY8FIN35oSXAzGMruIZ3o+4OgUgRhPF6zUKkKEbqgPh6NKmHOeZPYaZqTc+TLOuzYVY+NZ6pe31EGOdxCO4AfqZu4vTX7LC4HwGUxHeA6os4ukhMod7X8+JQm+SyBv7ZT407QIsFyEXZDj6Hs9rSFT3mvVCL2whJsTWEfl6CWekX2/u9p9HXlwKmbrc/uIkdz+LIkioACRUZM382HeeMdPovyufFlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Djz8AQRn1xix8a7cJ5vYXWnzBAPfIkjyGFigQ3aqJI=;
 b=YznzsdCPPOtznu//z4XDf6JPqs00jOqjbYAn0d7XfctzqNt8SbgOYZ6XAUp7hpsRnre3WaYVd+UUSrfGk6XKPTm4EzqNbBF4lI4AANeFD+UAhYWw6wJLJwzSn7DONyerwHITJU2IujdElCyT3pwJRjcxzmG5RWBD8a9JrawEf/vQSK2FzRM4H/+j0XBUndZYu+iLIY55RBYDd+xmRMWdUGmzNVGos6vjo07AQTFeB4Suy53iJzpv7Vg4yTGJFbuYM4X7RnREkm5RiTDAOu7J9aNJlBK7PXwdGNuooFs1qgq0DvqEvS1Ys1q5B5mwcM1gSJHs9CxERlS1bsRPZN9u+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4811.namprd12.prod.outlook.com (2603:10b6:5:1fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 07:48:59 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:48:59 +0000
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <87tua3h5r1.fsf@nvdebian.thelocal>
 <CAAPL-u-0HwL6p1SA73LPfFyywG55QqE9O+q=83fhShoJAVVxyQ@mail.gmail.com>
 <875ymerl81.fsf@nvdebian.thelocal> <87fslhhb2l.fsf@linux.ibm.com>
 <CAAPL-u9FvCfgA7xsqStLNZ=W03iyWBmvHrpVzPKyitsGN2v_KQ@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Wei Xu <weixugc@google.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Date:   Wed, 11 May 2022 17:34:58 +1000
In-reply-to: <CAAPL-u9FvCfgA7xsqStLNZ=W03iyWBmvHrpVzPKyitsGN2v_KQ@mail.gmail.com>
Message-ID: <87k0asqzko.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0101.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::42) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 011d3dcf-05aa-47df-c199-08da3322b52e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4811:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4811E94263873C1B2A8E04BADFC89@DM6PR12MB4811.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cuMV8vGdOPnVOsdwSDKPDUVMKBpzcoY0gtzUDrbtuOOlXgIPBjIiCNiwKv3Z1qCjg/FAmrgXBobWM2BYXhFahGNg/kVY+GDSLcWRuDspV5g+U4V1nyBlHWPLhhIDphWRohe8sm9KyXxLTdT6RBL8/4CFMNeUVGzIXPsZxLAE/LUY304yNRO6F1rn4yKy1qkVCbjY0MGpqM/MsBIrcoLG0Bx2jap7NnMuRq0XsD1WIZWE3Magh0BqPy6SFvjMRXOTiWDDVYWYb3M+FxmwI/CRgHG5xQiPJ8cFtRiuvmmHBh/TtJ1gXzBVua2B3WJMLAoyvBdWTt0r4x9akslYm4lGicVL2UEWuz2A02OyaLbOKKJXZYM7qaiEdrTU1qe9khA/Gn5M6Qfi4/iqH0dmSJkNrSzAIx9ftvGGfJh9jkegNjPSedMpN28EElAAL0rhrNAkZE3b3tcfzDvGqAPpcKusn4nABoTJwThB3CVZd1MowZ6JOs170hX30vafai4KSOrzjaVMi9CkhZrbxxWm4t5HzSMXYQexGADTuac89skV8aB7mkk8ucQf1xcvcI3UPGY0xmXMa5qE/468KazTa3zPtss6FjPjCx5mLHH3ixFEslDWZexwJrR2EaP0GRZPWSYtrqHEOLONrvo5nR+gRXSjDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(6916009)(54906003)(66946007)(8676002)(66556008)(2906002)(508600001)(6486002)(86362001)(38100700002)(316002)(8936002)(83380400001)(6512007)(4326008)(5660300002)(9686003)(7416002)(26005)(186003)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gn4i2TUJe6YDkoxirXX3E6DnMDrYUTHbiRnt1pIbyFond6ID9rNx4f5myMrW?=
 =?us-ascii?Q?D7k/YUirE3+YHssehPTZPo6Ndn0mAzL4M/wHYgxnAxF4FDtWjZBrJE3YeEXH?=
 =?us-ascii?Q?niCWiXj0ymvvyXONT8Dqw3cJjjQie5AkR5fCHsCo97P9JWMlYK5do2lLPSYV?=
 =?us-ascii?Q?b10uUSXZ7RNFqD6QVOvSezVagABnoz3IaspylNDKLhV4/2AH4MW2Jo5vzq1z?=
 =?us-ascii?Q?IkAkYq0mVkEwPRU61BazblimzHffIneHi82MwlPQS9AWCfh8JBtcE3EzqtA4?=
 =?us-ascii?Q?VaVG5hxYq71/2noHdBVn8xNiSlRovdfRJBM/9zVHR+l1ip/6hGHP/cdNiJCE?=
 =?us-ascii?Q?mjphFEM3t5sBjW+OenvBxs5SLIkJeCHsBaZDin6E+tlJQyXBbqEBIn7raj8u?=
 =?us-ascii?Q?B35H7Drj0cPAiluxZOkJU7TUh/KqG3af+SdToWsaIUrodvW8mckESVSrIdhG?=
 =?us-ascii?Q?oUU4XXUw25Pyzru80byTLe3HWtDVUJz7wSIeOsiQoOqDG2Luh2nhcbVU4IKl?=
 =?us-ascii?Q?OEOVS94erLgsf1E+nF94VCFCIh31p0l4PjEp9ecMZbHGHIJGZ10Dai3mgUwG?=
 =?us-ascii?Q?zsg1Qd8iDYnTqEoENq3xEUBmmnzfDaZh9mgBFC4+VeIQ6eVVm+cIeKJjpMnl?=
 =?us-ascii?Q?20g4XjAkT3G0/ZV6KWbz/fisXIQ5pwh+ln5rsiGcMeZGs6WK5B/LRaXFtDK1?=
 =?us-ascii?Q?U+KjlUXkGhJxDOocnOIzwbefVjMZdrVfmYni6B+F+jcUyiIffCKLTDID2FKe?=
 =?us-ascii?Q?FqZA3+CFCisesOHrgFA/vvbolLpjksY00eSVyjtlfTDCsmhqbw0kZb/YpscD?=
 =?us-ascii?Q?ngP8xozx14RjrYpmlU8W30YIfp/0uk9YRoRM4v9lCO/HMSJrG75HPPkJ/j1h?=
 =?us-ascii?Q?apGyMgVz8tPfPYM/aAe9worBskoZ3asMIHl12koZfcR/BDz5LSfHj7KNu/hm?=
 =?us-ascii?Q?bagjNIs1S6YLhJW55jw4nLlUSs/vRoUQCwboejG0rvuM5eY87UQDaSgX39wB?=
 =?us-ascii?Q?ATinBS3zPy/hzQnqrMFo8zQjS9WwyQUUWS7zXsernsmzzLhvy+Y6GuU+ADVA?=
 =?us-ascii?Q?f9xBCan/8E4ml+2IwWCmggj4+CF1NVm2Ee+csaJC8X+CiCPe88x0vCw7Yy8V?=
 =?us-ascii?Q?KkMiyysDOv5vAxcYSqhXqY0ODxAnd6jIYXpC2t1q+/haZCOIE41YMIf3sCFQ?=
 =?us-ascii?Q?ANih0KCHPCDWNH+uVjE4uYW3+AnqP6BOXFrxgEHFeiQWNi42qddT2gv4IEPH?=
 =?us-ascii?Q?M8JaI9qS5x2H2SY88GU9cJHJ0g5KqnN0939jHvcTdcUfdf/io0TtFlhF1cYC?=
 =?us-ascii?Q?B1enV+7huHsZ3aM8sieOjRpmgD7/qM4sb5qU1tr6F4RFQBwePPIZKr6MO+uP?=
 =?us-ascii?Q?rGPst1oAGx9I2uHvFVzPaq86/RDKc7t/zrra/EeF2JF04IHuJyqUANCOpr0f?=
 =?us-ascii?Q?kghmWVKmyhYFLmCw8rNepuVgodX6gV5KXUDA2i5kixTWzHZP9zqU6Bz2OITN?=
 =?us-ascii?Q?DIht2UJpfupH/T3ExD8Ewh4gpJmiG2+CgAm/ZGH54zIw+C9hmRegZYGRh+KY?=
 =?us-ascii?Q?O5sNKbfpRls9/7RC5gcVgitNamfepE1kmxIjVuyMDMX0TIHo28KK8S5sP8Qz?=
 =?us-ascii?Q?fpamE3l9r10fpIVPaosyhuR2YtKGufZal1IOkaTD77FQX5AfogTnDXN1hHEa?=
 =?us-ascii?Q?tUoVMGt6Ug2xkJMI/pZEUlkW/i35TCDxWg+UZg5p0OMmamIZoM5ADKC8mH02?=
 =?us-ascii?Q?Oaj49zTzVw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011d3dcf-05aa-47df-c199-08da3322b52e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:48:58.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/VJZkHDLLaADgoWjaNHbGLiB2n7cFB5I0ACg30VuV5HXvZc8VhH0QJYXE2T74+1ZqygkOGjID6izLCht5qgWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4811
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wei Xu <weixugc@google.com> writes:

> On Tue, May 10, 2022 at 4:38 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> Alistair Popple <apopple@nvidia.com> writes:
>>
>> > Wei Xu <weixugc@google.com> writes:
>> >
>> >> On Thu, May 5, 2022 at 5:19 PM Alistair Popple <apopple@nvidia.com> wrote:
>> >>>
>> >>> Wei Xu <weixugc@google.com> writes:
>> >>>
>> >>> [...]
>> >>>
>> >>> >> >
>> >>> >> >
>> >>> >> > Tiering Hierarchy Initialization
>> >>> >> > `=============================='
>> >>> >> >
>> >>> >> > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
>> >>> >> >
>> >>> >> > A device driver can remove its memory nodes from the top tier, e.g.
>> >>> >> > a dax driver can remove PMEM nodes from the top tier.
>> >>> >>
>> >>> >> With the topology built by firmware we should not need this.
>> >>>
>> >>> I agree that in an ideal world the hierarchy should be built by firmware based
>> >>> on something like the HMAT. But I also think being able to override this will be
>> >>> useful in getting there. Therefore a way of overriding the generated hierarchy
>> >>> would be good, either via sysfs or kernel boot parameter if we don't want to
>> >>> commit to a particular user interface now.
>> >>>
>> >>> However I'm less sure letting device-drivers override this is a good idea. How
>> >>> for example would a GPU driver make sure it's node is in the top tier? By moving
>> >>> every node that the driver does not know about out of N_TOPTIER_MEMORY? That
>> >>> could get messy if say there were two drivers both of which wanted their node to
>> >>> be in the top tier.
>> >>
>> >> The suggestion is to allow a device driver to opt out its memory
>> >> devices from the top-tier, not the other way around.
>> >
>> > So how would demotion work in the case of accelerators then? In that
>> > case we would want GPU memory to demote to DRAM, but that won't happen
>> > if both DRAM and GPU memory are in N_TOPTIER_MEMORY and it seems the
>> > only override available with this proposal would move GPU memory into a
>> > lower tier, which is the opposite of what's needed there.
>>
>> How about we do 3 tiers now. dax kmem devices can be registered to
>> tier 3. By default all numa nodes can be registered at tier 2 and HBM or
>> GPU can be enabled to register at tier 1. ?
>
> This makes sense.  I will send an updated RFC based on the discussions so far.

Thanks! The sense I got from LSF/MM was that we should initially try
keep things simple by limiting it to two tiers. However I don't think
there was strong opposition to adding a third tier to support
GPU+CPU+PMEM, and it does seem like it might even be simpler to just
have three tiers and assign devices as suggested.

>> -aneesh
