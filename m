Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF3A5A74F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiHaEX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiHaEXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:23:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9201CB0A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661919774; x=1693455774;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i65h1tDliA3+xye0o+BN5JUJBFbxoZVbV0uN2OpbmBY=;
  b=fndPLLvMj9P1DgBQMrMZxdqs7xY+THJrDt2NjJZ2PtA8w4mdFTM+fJZe
   L75x2DQPdWIug5XbvlGEmu2YxHch23iKVZ7vxIJUR+UuQ+BfBt8alIuMp
   LphuJl7U6ixockrXkniEynWMGQF+gG+uV+dzNMSYtCML75fgXGeMefj9z
   dGmUorqZy1tP4zrR9igPpE7smYAEKZgwAob5RbluJXfri5XZHxKt3KBD9
   Ai4OlUt/yDXyGL/W/U8dPHNNiJuTjcIeyruKd7+urHSwpjvuyelubCS0p
   CELDYm5v0jD9Z3vLDMfhN7p2PcTz9Iw5Z0Sbv9DPa2ovSXkzLxpW9SqQv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275771994"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="275771994"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 21:22:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="940300772"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2022 21:22:53 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 21:22:53 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 21:22:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 21:22:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 21:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sxv2rqNkYZ0eLcZgPe37sgmpPo8IhthNX9UonfnWa3p07G+fNf1hZJYzuHmBNtSeF63peD6xBugiRDHguSS2xEODp+ylOnrlQwzOb5v4uwaG7k9du4WAQ0s4cbmvSTRz5FW4WvhMM4tF5knBlPxY1Q/2r5TAwlg0wET7GQpZLQLrlxeYevY8JXRLUIMvay7whx1Isc7j4vt+0m5UTcR8JqQeUTRV0Ow3QPhXLUaaAxsnRdKOd1Va4unWc6Af0nN5X7ELUqaU4OHhNPHu4GHuZ5bF9UUf8XtRFJu3NCwd9TZfRzYr4GLDi+Ks70HJccC373AF4PtHXBNdpTXCkDMUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRPfTIltKjLcAYiPAVvb5Der9zgNhM92iPzz31SfVZs=;
 b=R34NdD/cdgLe8KN4hiltSA7cvSm1hXetKadX0hgj1Rl17qeTN3f+NO6whf0eHEDqhJjs+u2X+FH6+xHJXCLwsM54uVeF8mt/oV7NBmDasnmEDAbHUY2SPABH3Ijet44eKS3rixmw/QJnp6JdYwnRJKsrcVsSOGNH4T/FvsXfuRRiRy1ebeVdG/Qjaf8aVd72MJG9HcRgiFvLe5VP2fWqhSCjuPYtJPYeixQ1tzkWjjwmUL0dI0t+VDCTidSWgeE5IAWA3j1NbejacFRaxCyT0HZLpEYl88szvy/qESM1cNCCJ9T5JrIh4S/25DScb7Bwfn3c0UTvvPMJaP+zxjF+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2221.namprd11.prod.outlook.com
 (2603:10b6:301:53::18) by SJ1PR11MB6204.namprd11.prod.outlook.com
 (2603:10b6:a03:459::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 04:22:51 +0000
Received: from MWHPR1101MB2221.namprd11.prod.outlook.com
 ([fe80::e9a3:201:f95c:891e]) by MWHPR1101MB2221.namprd11.prod.outlook.com
 ([fe80::e9a3:201:f95c:891e%7]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 04:22:50 +0000
Date:   Wed, 31 Aug 2022 12:22:45 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <hch@infradead.org>, <m.szyprowski@samsung.com>
Subject: Re: [PATCH] swiotlb: fix a typo
Message-ID: <Yw7iFQGpStC6YodP@gao-cwp>
References: <20220826095046.880626-1-chao.gao@intel.com>
 <cd53526d-2564-996b-7b0d-d1fe9f114590@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd53526d-2564-996b-7b0d-d1fe9f114590@arm.com>
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To MWHPR1101MB2221.namprd11.prod.outlook.com
 (2603:10b6:301:53::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbe31e7c-6445-4d12-51af-08da8b087778
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6204:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxF1TJQQvT11JMW+8ScVL2N724TJw0KeYgl7jODOzOh2ItWLjpH7L8cDevrTGDsozxmsV46lB/xv+VDJrBIwS2xsEyHPY56twvtu7LKc7nunM1i8tf9eIdREd4949yFhmfJHQYRCS35ALF5ymjPVb9LLBnsou2zOPCcfIoNbKWUh8QAI0TwAd9wiJBGi9INSOWzDuUHe3m2wjpuoy8ANoUum/hujdAi33GzP2LTz8LvoKFwHMmFehzBsJDDJHaiigrYqanDa7aTaYVwjWCcAB1IA3KUtLHkbFDNPud8MUluFH5P5c8V8j+QUIM1/75WvTQGs/sKeN3Pm8HrSBPoQpyQVaeFZ/kqzKfxrROstqPCL0UjfwaDWOxRNpo19iKoWZlbytsEI8rSIHzvrMGND8PurokNpmzWfq5418CnFNtk0vn618YWA00G4Mhikk7GAuHiDEh73ubYvSXoEU/76wZHf0GvT6R9v1mpwbcsTXG80ruSXCRCsq+tkVcwWPwulZmWzQ8cvP3LU0ovDTatmDr+UwQbimh0uCnosLHqucvSqNeK4iGbKSYw7AX9eq6SpOIvBefN+WPRqeGDjFNUNgNf5JNq9qmoWnBr4hRvXJOErbyGgXrPh7mvKAo/0Rpkttv2rz51B2ugG4D+gUNN627EKwGkmpu3J+Laho0m0Fh8zePg65ZgxIGWsNYha9NF+0qGH5W8aWdyP5OnsJHviuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2221.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(39860400002)(376002)(396003)(366004)(5660300002)(8936002)(41300700001)(6666004)(186003)(9686003)(86362001)(26005)(44832011)(6506007)(6512007)(2906002)(316002)(6916009)(66946007)(478600001)(66476007)(38100700002)(4326008)(82960400001)(6486002)(8676002)(66556008)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fcg0b6wmxfXkOGi17fVoeZxr22GdX7gS0cFnluYHdzsHBaqtRZDX32DKqw7G?=
 =?us-ascii?Q?FnlKi8usNltuUuMh2OwwBvYaat7EwlG6mbNE2SyNrN7JHdEkBgFFRm6Fj1jd?=
 =?us-ascii?Q?rwo/g9x9+0tUAQNgr8qVdicA7aSihh8gAGQEcOV6TX+c7qICD8oDAA50syx4?=
 =?us-ascii?Q?ok0f3qiOjk8CO+Zeq3y38lE9gJvbkCS7glks9mwv0CwDfo3yvfuFldknlsY8?=
 =?us-ascii?Q?KlW1lPmi7oH9wbMnuSJdSwLY0SkrjH4g8APbbPCF+o8VYkmW1/KC7eFY3Kor?=
 =?us-ascii?Q?zTNGQ9T7KjVloW25OSsVLfkqQAfWgz4QV3fcnk35OxmO5SDTxjRNqUGUbNjK?=
 =?us-ascii?Q?j6SLaBYHAXRXdbHsynOfv1nAAtIuWiff/SkK1En42LHBoQ7M3TPNmXdh67jY?=
 =?us-ascii?Q?SCympYXaj94jV/UYervT1Rl92rAgGDHAXVBH2Ka12yEiKnkwqZfWl6eeVnkg?=
 =?us-ascii?Q?TtxEPP5uITg211cJ3JNbU2EWVnywobGWr8reCpGoZPU8B2PF7yWPwdk62RIj?=
 =?us-ascii?Q?x/jQqRA8eXKT5xEKoguND3BYyIYVMGu6IMpuunmKZJkOE4cjhk7ZgxlTKjGp?=
 =?us-ascii?Q?bvXdbUfbwrvsP8SsItNfQc0El2+tbhDyBTx+mr/Yn4kIVkxJIB9ug6rCD5l/?=
 =?us-ascii?Q?G4uKIN04lYzB+UES1oukgYq9UrcpVxEsCDEz080DXgGQaSGO5RxjchUobUez?=
 =?us-ascii?Q?12z9DoYL2U9kOhvgWDgkqKrD9oxrbhSg2fucj/CXJcVydE7fPlpqz/kcK0GI?=
 =?us-ascii?Q?/gVq0H2TCm+OmmgN075vzrmiAHcftzg9EPf7dQxRUV62JUqCUkPyoJQpjYGP?=
 =?us-ascii?Q?PQQWpYcrSUEwFuPsCffU25uzJ2shAMjPTfMBfFo0bbmK2ZwQwsgd5/NHhz1w?=
 =?us-ascii?Q?w/w4lZx5BXDQ+la6pCv4FkZC6f7L1nbrj75wjFYgzhZNXx1dWzb0D85nfzQF?=
 =?us-ascii?Q?zr0BvLLZOAyKoCTJFM6I/a0EnCN9Y9OCTWcn5q8SXHmnwKrPoZ3uDEseYiuq?=
 =?us-ascii?Q?++HFBueB7XFN9lPfcPiVv69Ty94z7ljFxgch8f9nxAmOjondel26X0c9EqIA?=
 =?us-ascii?Q?N0AER4LvL6pmFsWm0u1SiYpopWrI2K6qRGXLTgacaulGX0O+VET68X3dT4sY?=
 =?us-ascii?Q?B7jEvTZT97ebuElfhCRXcQja9l4+GCkWp/7i1Hwjx8tiiYc4hB9Oxg8dsjow?=
 =?us-ascii?Q?2lk5kVHyvZx+ykh/ad9AcUO526aIYlB4/0kWlQWLcZk72jAjWuY277efKIFk?=
 =?us-ascii?Q?XGznkoTe612hIu0QVU1UpEz4p4KQohprnQpt815wcfPaBefJz01TpojwUalF?=
 =?us-ascii?Q?0iuUCvoGtj6ImXBilWbmvMo3IspmIehioL+9aoRsVv3I2w+G4K5fhUIj4zX1?=
 =?us-ascii?Q?D3KZ0/bcOKNJGyZXxKYO27Q4cIZxpDbs6gv8RVaEszeFQeL5fGRGA9VtJ4Kn?=
 =?us-ascii?Q?1+GBtzBCLfZjSyune4W4I5/aCC5ewytZOKk6a+eNr+Dke8OVW19dMTC4KdAa?=
 =?us-ascii?Q?826rNPii/CzAqq2onQAroazhbxkWjyvLYOnP3vX4uD4DmJ0m4yjTnJylzbr9?=
 =?us-ascii?Q?VDKXo3gQQoOYj7ENCuoXQ1NNd4r5vKFkwYOiE3TY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe31e7c-6445-4d12-51af-08da8b087778
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2221.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 04:22:50.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDTiPWJtFLMdR91N2+qFrr5u4jXtjM4LL9OS3XuIOTsnoEuDpdVPPe6VjobRxYoJuBshqIaXBNqNUya95GnQKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6204
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:23:51AM +0100, Robin Murphy wrote:
>On 2022-08-26 10:50, Chao Gao wrote:
>> "overwirte" isn't a word. It should be "overwrite".
>> 
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> ---
>> BTW, I am wondering if copying the original buffer to the tlb buffer
>> unconditionally will leak the original buffer to the VMM, especially
>> when VMM isn't trusted e.g., by confidential VMs. Would it be better
>> to zero the tlb buffer for dir == DMA_FROM_DEVICE?
>
>No, at the point of dma_map(), the buffer contents are owned by the caller,
>so if parts of that buffer are sensitive and shouldn't be exposed to DMA,
>then don't map the whole buffer for DMA. There are more DMA API
>implementations than SWIOTLB.
>

I am not sure if all existing drivers ensure that all buffers allocated
for DMA_FROM_DEVICE are zeroed/poisoned so that they don't have sensitive
data before dma_map(). If that isn't the case, bouncing the original contents
(left by the previous user of the buffer) effectively makes the contents
visible to host/VMM. I am afraid it may be a concern for confidential VMs.

>The whole point of bouncing the original contents here is that doing anything
>else effectively corrupts any part of the mapping that the device may end up
>*not* writing to - see the whole sordid original discussion (but don't be
>confused by the fact that the caller's original data happened to be zeros in
>that particular case).

Got it. Thanks for the explanation.
