Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDC64C1AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbiBWSZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiBWSZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:25:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549BB4A3EF;
        Wed, 23 Feb 2022 10:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645640717; x=1677176717;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KOlk+SezhjxYdcMm/JnFCgIInarI5dhjt9cjWcgPX9g=;
  b=f86A9m5jYzCcPX2djqgAtr+vAouNNFTsoYJ38rHJZDE+L9bZrd/XeVHs
   33vdQpcR/Lqf8gFmlAdffhEZdP7S0mNcQx5J6c8eZXPzw1K6sU0uB/f+1
   Dr1v3g+AC3Z7yubo7Wh/vdOHUYKg50yYrkjamQfzEGgsSoiyBBfYm0v4r
   fgDpAkw45tqciz72PLSuw1GfitGphnH+51+Tvq1T928YYsRxG3kgEJOtb
   B34YnsJkcR/K6VavGxXswBiOvrTIPgj4SBV4FhjZonU2dHmXMRN4arewQ
   3vcKVLrY3wjbJyq7MedJZKi0WZSNLeSiuvBR8mj+jjGT95XqpdS9Ts+Eh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315276276"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="315276276"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 10:25:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="548382795"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2022 10:25:15 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 10:25:14 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 23 Feb 2022 10:25:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Feb 2022 10:25:14 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 23 Feb 2022 10:25:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gelwDmtHtlD44zGvvNjq0bZ7m0KR5Q+VGP8l0ksU7DvJsZ/uGWEXWpPVqlyKUiF/McakbBHZpE3qWdbWtpMDkuPcAh6b8N4Wppm02YoxwVaIgBzmrVtLq0/+IJWVjPkh06UK0JkPyJAep4lwTJoRf8LmjOEymZHaH5L4G5f6gyh+3loWfYqmEMT38uFO7FsrXPzolxdGgspdETO8Z1sMV0d50KURjGKNYR99Zns9AFV2OpiLhM9PaOfchFF4Z01izb7L8vS6PehyTKvzr47s32sB1JPcaMkJPMHOm5oy6UzFO6PJtrb+2EJZLlRpwiv9WncswC/beG0PBXCbssecDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdWGWo9L+oh3JTl6ClFEzUmVraSeuvhPPxrN2v+5lkM=;
 b=b7PrP4v/zu3ipePVivqGG4NHN6E2HKAnruiPbhrAwOk2lleprLq6Tl0h5P0Uff85fNZQC5MfeGLBwJiXkA/rwfZ/5ouZBaMtYzdR6qIhQRdqMIDzC5qvpR0NMS7Z8TRDp8vCEszC+phayVHDHluhbjsZeNCSbgt6QsRyuPZG4oH9mcjBibi8GUFD7c2QUfnYAv+kodAPWgRP6gvo+PMlmV0mHabpDOy7PuiIssob/YORYiAtxMGJV8DyTfAtk+5w+S6+402A9xpBOKXiyQQaVQ5BtPn06kaeI6C5bSN3eXDMPE+5jWXlOj71lWSdxDL/nbOdIt+k9gh1BBZh8wnq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB4609.namprd11.prod.outlook.com (2603:10b6:5:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 18:25:11 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%4]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 18:25:11 +0000
Message-ID: <e746026c-33f3-fd15-5303-563b3eb761d3@intel.com>
Date:   Wed, 23 Feb 2022 10:25:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH V2 00/32] x86/sgx and selftests/sgx: Support SGX2
Content-Language: en-US
To:     Nathaniel McCallum <nathaniel@profian.com>
CC:     <dave.hansen@linux.intel.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <CAHAy0tR-64vxtFo4KXiJP_va2=WF++Q6gDaPksNxiaSB5wWvhA@mail.gmail.com>
 <86495779-a9c5-45d5-0017-c491bf6354ab@intel.com>
 <CAHAy0tQYBD2b0jdim=6Zv+hwskyd1FhpycyGF+1FBHDih9TP3g@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CAHAy0tQYBD2b0jdim=6Zv+hwskyd1FhpycyGF+1FBHDih9TP3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:104:5::18) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: accdb8a8-715a-4141-5cf9-08d9f6f9d3bc
X-MS-TrafficTypeDiagnostic: DM6PR11MB4609:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB46090123BC1600C7C4EC1C51F83C9@DM6PR11MB4609.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9YZoaNsrIFKwbo4HlPQb3C9QBgWlSz2kX0VhxkhHD1n6y+Ggo+byE2uIpkr6PLl+m5YNmgkMj6vczal2ECluM8Te8fVnLPEh6I07C7g+5WQHDQ7z2waOJYV3J4C+bsyTfGCCjy/ZucJEc5pJjusEx3amKLgblqgd57vsyujsPN1X7v309dGWPkYji9A/5BsaUVAsAHYItzC3kiU23LLul6Nc1rwScnXmbHY5e8lLydi3nRp+xG97gTZ6E2A1z+Hi8VZ9xtwO+pFjg8pGLOrEH0n41zCtPE9qrELIxsLw0SPy244sIlxRwZklOk02NRCexTnkn2GVlbiHvK2Nr/bjGNHPzygQBcf4N1dHyguhx0Izs98stDdGpljDcaiZjeSVborETpkmedxOlhc88jOOjp+gC4MrjI9Dp9c25aQx0nsOBEH72moPfPeMmS3SFcDQKSh2bvHFgYjrySCpCCug+vWbPBnpkByVt5cXl7R0ilWdKTGtS262GPJOTd/hE4Kdk60QrIKAUD5TVoWMtIqRY6suhDSFIYkup+hq5xht2SjN5bL77N4TRPsIvtmhO1aJluTP+BdTprs0oADTnR1drkW5BE9VmeBVILzN8uzKGSOjJCoCSeFi42Vb85im+LZG0/1Vutld9HR7kNx8nNXtu5OPXf6fMxvnFBsKocBebFRVHZ0MSyuG0ynIGkM9B/WzGBNXRfPXnYRQpBIwcOMrEPpzin0dA/dySYLX4uZW7g7m1r5/dGApBYFQpzNCts8KozvYUQs21qKSS9cMeKnyxrAxl4T5KOlQCmS5xOjxT4WCnGpA/Fgva5SP4SdtQYXenPpyxxp8bHPwNGUna6lB87376RrPObZNS0h/YZoIDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(36756003)(44832011)(83380400001)(30864003)(2616005)(186003)(26005)(316002)(54906003)(2906002)(6916009)(4326008)(38100700002)(6512007)(6506007)(8676002)(53546011)(6666004)(7416002)(5660300002)(966005)(6486002)(31696002)(66476007)(508600001)(86362001)(31686004)(66556008)(66946007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1dEQU9JTWpKbmNLbEV3RmxQZDc0SzI2VXgxNWtmK1NqN2o5QmpWekwrYjM2?=
 =?utf-8?B?ckRvbldVV0pFeG5OaG5ML0pRZTlTSUkxTDk2M3g0czJ5cEFVR3pMdWo1THBQ?=
 =?utf-8?B?QVlyWElhSkJ0QVB5dGJXVnZ4ME9kcGJkM2tyc1haWkJUYS8xS0YxUWRXUFRL?=
 =?utf-8?B?aFRuK0M4WkVYWE9mdGtXWmVHeW5CcUEzYitxMHlyVDFNVC9iUEFvUGZtZmpt?=
 =?utf-8?B?elRYQ29XYmJmSDJLMlZZRld5cEI3OGlaWlI1RkloVXhuV3VwV3VnbHdQejE2?=
 =?utf-8?B?SnBNZHljNkJENFBsblBweTdQbnFDZmorb2tEcXlBV1BlRm1mNWkrK2ZkZEJX?=
 =?utf-8?B?a3o4bnhKTkE2MWU0MjFkbFpVNVF5WERuYWVSOGpVemlFSk1kamg0VSt4OTQ0?=
 =?utf-8?B?QXpHdjAyTkl3bU1ST01xNlpPeStXWVoxRzl0RmhWTjdlZ0FGWEM0WkpHZnl2?=
 =?utf-8?B?RFBaQkNSMEd0dG0vVm1ic3pPZWYyYlRpbXpxQUczWEptZ3Z2c3lmV1Q0RDhv?=
 =?utf-8?B?SXVGZ2kzdGNsL0FkYkdvRTZGZVFDMzF0VXhGb1JoMCtYdFlYdmFMaEVxaHl0?=
 =?utf-8?B?NWliclNlam1vUStlYlF5MGppbU1tQXFIa0g0b0w5aUdTZGpySDJuZXJuYkNL?=
 =?utf-8?B?OXg5YnZ2TFBmVytIOVg5YTBzYjdSQ084VWE1bXNnNm5ES05KM3A0LzZRbmxB?=
 =?utf-8?B?MDRZT2ZFbFZOMEdnV1p2K3RDNityNjI3c2wrVkJ5RmZDMGtHTWc4WGI0OVpv?=
 =?utf-8?B?cDdnc1JUaWJiUlpRSElxZ2J2WFNqTEJ5cWRETG1WZVZQSWY5MDBRRFdaaUNH?=
 =?utf-8?B?TEY2K0NyMFdJeHJISmtWeVFPUlNCRjk5c214RjJ4L28wME9KS2lLVi9abFYy?=
 =?utf-8?B?Z09QdDFJVE5yUTU3S1JMcnB5Z0FjbFpWNFNHSnpBMXRxNDZCcEQxV1V2VUJO?=
 =?utf-8?B?M3ZNWjBNZ3k4YzBXR3lMTGd4VFF1enc0RXU2b214ZUIrcTVDVGQxRzNoaU1z?=
 =?utf-8?B?MjNDYXRDZ2FKVzcvamdTNlV2dkQ2NHRXaWtRVkRsSlJoeUxhRmFCV3RrYjhP?=
 =?utf-8?B?Mk9qQ0s5NkV6UHU1S2VhYlZjTi8yTzljZXpLK2kyOElVbUtzMlhEYVZNN1Nx?=
 =?utf-8?B?WW5HM0thQW1uV2FZdmRLOVBXNFFaR0RtQ0FyV0FxUXNEdXZwc3lOVDI5VDc3?=
 =?utf-8?B?K3pXajdtTEhKOEllMTE2cElLZHhxMDNNNkI4SDJGK2JLd3U0SzQ4ckdTV2N5?=
 =?utf-8?B?RWF1UnM2MFd1R3JXS216N2cxaVVONEgxbS80dGpaZ3gxS25qa1RKYzdqazRP?=
 =?utf-8?B?KysxWDZwOHk1UTRjNTVXamZjSThpeXJ2QkpROXlXdFZpeG5IVHBpc01tZll2?=
 =?utf-8?B?Q2ZmZmZ0TVBJQ1FYVmVoVmRrRFd1TUJRZjVrTHFCanRkalFBQWdxTVNEbjF6?=
 =?utf-8?B?SHBGT3kyUTFpdEtaOXMyQmlXeDlOcTFFckp4c1ZIVGxKTXNaUm1aaUFUMVI4?=
 =?utf-8?B?REIreDByYXZYZEZhajcvU2J5UXRJRDlWc0R3bDJCcEtIK1lWZzN4dmJ2Z3Ez?=
 =?utf-8?B?UTRSWjdSRWN5UnkwVmRXNEo3aHo3WlNPS2hyYmF6QWJVSlRWS2RDanhyZXdu?=
 =?utf-8?B?UUpxeHBvdXpjQXpLeGVqWFNqaXVvU29IUUN6VWI1OXk5VFU1ZnFOcS9Bb05z?=
 =?utf-8?B?cmc4TEZ5VmZxMXNZVUltekx6dFA1Z0dlV05TL29XUmJFYWxHUS9Yc01CQXEv?=
 =?utf-8?B?OFRtNDduVE15bnllclBOdHFIUWxPV05KbFFlcFFsV0YvdGEvVS9naTBBeXdx?=
 =?utf-8?B?S1NSdWNBak44ZGNHQVkvdGlhcEk2NEhqMU5YeUVGb08rVTB4K05vK1pLeGU1?=
 =?utf-8?B?a2J6c3VXblk1dlVWbnU5OTNIZUN3RFNYamR6ckU0SVBkWm1hZkN6aFdUUHc4?=
 =?utf-8?B?YldLZUwzcXJXOG56M0pqYVVyVEY0Mk81UVdrWlJTMzhrUDE0RnFoMnhMUkRq?=
 =?utf-8?B?VXFXcXduaTVUaWtnTFJRK2VXTFV5YjdWcy9aeUEwcE8zZzZnOXNkTk53UzhI?=
 =?utf-8?B?TUNHRmxTZGE0UGtCNmFEQkRpb1RvQXh1QzNoUGZsTkV5dUVHWXFHSDBEVHhI?=
 =?utf-8?B?bkQxWThmZVNwUzJFUGJBM0dkSXNuNXU0NzFCdmx4b3ZWSU1QTEU0OHozQXRE?=
 =?utf-8?B?YklUSUp5clFGN3ZVcm4reTdqRmM0VGNyV2krUVN4MHllenNneXByOVA0Z0tG?=
 =?utf-8?B?S2U1clZkUjRaMWl2MnZVdnd6MWR3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: accdb8a8-715a-4141-5cf9-08d9f6f9d3bc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 18:25:11.6136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhXtE5pVkGeQexMm457bU9FBsZMJChN1dypOzFX+w5tzLeN26e5n55PDU8kR7XleNBglF4bAzYob/qLaFqDD8shCupL040TRWea7XMdL5zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4609
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathaniel,

On 2/23/2022 5:24 AM, Nathaniel McCallum wrote:
> On Tue, Feb 22, 2022 at 5:39 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Nathaniel,
>>
>> On 2/22/2022 12:27 PM, Nathaniel McCallum wrote:
>>> 1. This interface looks very odd to me. mmap() is the kernel interface
>>> for changing user space memory maps. Why are we introducing a new
>>> interface for this?
>>
>> mmap() is the kernel interface used to create new mappings in the
>> virtual address space of the calling process. This is different from
>> the permissions and properties of the underlying file/memory being mapped.
>>
>> A new interface is introduced because changes need to be made to the
>> permissions and properties of the underlying enclave. A new virtual
>> address space is not needed nor should existing VMAs be impacted.
>>
>> This is similar to how mmap() is not used to change file permissions.
>>
>> VMA permissions are separate from enclave page permissions as found in
>> the EPCM (Enclave Page Cache Map). The current implementation (SGX1) already
>> distinguishes between the VMA and EPCM permissions - for example, it is
>> already possible to create a read-only VMA from enclave pages that have
>> RW EPCM permissions. mmap() of a portion of EPC memory with a particular
>> permission does not imply that the underlying EPCM permissions (should)have
>> that permission.
> 
> Yes. BUT... unlike the file permissions, this leaks an implementation detail.

Not really - just like a RW file can be mapped read-only or RW, RW enclave
memory can be mapped read-only or RW.

> 
> The user process is governed by VMA permissions. And during enclave
> creation, it had to mmap() all the enclave regions to their final VMA
> permissions. So during enclave creation you have to use mmap() but
> after enclave creation you use custom APIs? That's inconsistent at
> best.

No. ioctl()s are consistently used to manage enclave memory.

The existing ioctls() SGX_IOC_ENCLAVE_CREATE, SGX_IOC_ENCLAVE_ADD_PAGES,
and SGX_IOC_ENCLAVE_INIT are used to set up to initialize the enclave memory.

The new ioctls() are used to manage enclave memory after enclave initialization.

The enclave memory is thus managed with a consistent interface.

mmap() is required before SGX_IOC_ENCLAVE_CREATE to obtain a base address
for the enclave that is required by the ioctl(). The rest of the ioctl()s,
existing and new, are consistent in interface by not requiring a memory
mapping but instead work from an offset from the base address.
 
> Forcing userspace to worry about the (mostly undocumented!)
> interactions between EPC, PTE and VMA permissions makes these APIs
> hard to use and difficult to reason about.

This is not new. The current SGX1 user space is already prevented from
creating a mapping of enclave memory that is more relaxed than the enclave
memory. For example, if the enclave memory has RW EPCM permissions then it
is not possible to mmap() that memory as RWX.

> 
> When I call SGX_IOC_ENCLAVE_RELAX_PERMISSIONS, do I also have to call
> mmap() to update the VMA permissions to match? It isn't clear. Nor is

mprotect() may be the better call to use.

> it really clear why I'm calling completely separate APIs.
> 
>>> You can just simply add a new mmap flag (i.e.
>>> MAP_SGX_TCS*) and then figure out which SGX instructions to execute
>>> based on the desired state of the memory maps. If you do this, none of
>>> the following ioctls are needed:
>>>
>>> * SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
>>> * SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
>>> * SGX_IOC_ENCLAVE_REMOVE_PAGES
>>> * SGX_IOC_ENCLAVE_MODIFY_TYPE
>>>
>>> It also means that languages don't have to grow support for all these
>>> ioctls. Instead, they can just reuse the existing mmap() bindings with
>>> the new flag. Also, multiple operations can be combined into a single
>>> mmap() call, amortizing the changes over a single context switch.
>>>
>>> 2. Automatically adding pages with hard-coded permissions in a fault
>>> handler seems like a really bad idea.
>>
>> Could you please elaborate why this is a bad idea?
> 
> Because implementations that miss this subtlety suddenly have pages
> with magic permissions. Magic is bad. Explicit is good.
> 

There is no magic. Any new pages have to be accepted by the enclave.
The enclave will not be able to access these pages unless explicitly
accepted, ENCLU[EACCEPT], from within the enclave.

>>> How do you distinguish between
>>> accesses which should result in an updated mapping and accesses that
>>> should result in a fault?
>>
>> Accesses that should result in an updated mapping have two requirements:
>> (a) address accessed belongs to the enclave based on the address
>>     range specified during enclave create
>> (b) there is no backing enclave page for the address
> 
> What happens if the enclave is buggy? Or has been compromised. In both
> of those cases, there should be a userspace visible fault and pages
> should not be added.

If user space accesses a memory address with a regular read/write that
results in a new page added then there is indeed a user space visible
fault. You can see this flow in action in the "augment" test case in
https://lore.kernel.org/linux-sgx/32c1116934a588bd3e6c174684e3e36a05c0a4d4.1644274683.git.reinette.chatre@intel.com/

If user space indeed wants the page after encountering such a fault then
it needs to enter the enclave again, from a different entry point, to
run ENCLU[EACCEPT], before it can return to the original entry point to
continue execution from the instruction that triggered the original read/write.

The only flow where a page is added without a user space visible fault
is when user space explicitly runs the ENCLU[EACCEPT] to do so.

> 
>>> IMHO, all unmapped page accesses should
>>> result in a page fault. mmap() should be called first to identify the
>>> correct permissions for these pages.
>>> Then the page handler should be
>>> updated to use the permissions from the mapping when backfilling
>>> physical pages. If I understand correctly, this should also obviate
>>
>> Regular enclave pages can _only_ be dynamically added with RW permission.
>>
>> SGX2's support for adding regular pages to an enclave via the EAUG
>> instruction is architecturally set at RW. The OS cannot change those permissions
>> via the EAUG instruction nor can the OS do so with a different/additional
>> instruction because:
>> * the OS is not able to relax permissions since that can only be done from
>> within the enclave with ENCLU[EMODPE], thus it is not possible for the OS to
>> dynamically add pages via EAUG as RW and then relax permissions to RWX.
>> * the OS is not able to EAUG a page and immediately attempt an EMODPR either
>> as Jarkko also recently inquired about:
>> https://lore.kernel.org/linux-sgx/80f3d7b9-e3d5-b2c0-7707-710bf6f5081e@intel.com/
> 
> This design looks... unfinished. EAUG takes a PAGEINFO in RBX, but
> PAGEINFO.SECINFO must be zeroed and EAUG instead sets magic hard-coded
> permissions. Why doesn't EAUG just respect the permissions in
> PAGEINFO.SECINFO? We aren't told.

This design is finished and respects the hardware specification. You can find
the details in the SDM's documentation of the EAUG function.

If the SECINFO field has a value then the hardware requires it to indicate
that it is a new shadow stack page being added, not a regular page. Support for
shadow stack pages is not in scope for this work. Attempting to dynamically
add a regular page with explicit permissions will result in a #GP(0).

The only way to add a regular enclave page is to make the SECINFO field empty
and doing so forces the page type to be a regular page and the permissions to
be RW.

> 
> Further, if the enclave can do EMODPE, why does
> SGX_IOC_ENCLAVE_RELAX_PERMISSIONS even exist? None of the
> documentation explains what this ioctl even does. Does it update PTE
> permissions? VMA permissions? Nobody knows without reading the source
> code.

Build the documentation (after applying this series) and it should
contain all the information you are searching for. As is the current custom
in the SGX documentation the built documentation pulls its content from
the kernel doc of the functions that implement the core of the 
user space interactions.

> 
> Userspace should not be bothered with the subtle details of the
> interaction between EPC, PTE and VMA permissions. But this API does
> everything it can do to expose all these details to userspace. And it
> doesn't bother to document them (probably because it is hard). It
> would be much better to avoid exposing these details to userspace.
> 
> IMHO, there should be a simple flow like this (if EAUG respects
> PAGEINFO.SECINFO):

EAUG does not respect PAGEINFO.SECINFO for regular pages.

> 
> 1. Non-enclave calls mmap()/munmap().
> 2. Enclave issues EACCEPT, if necessary.
> 3. Enclave issues EMODPE, if necessary.
> 
> Notice that in the second step above, during the mmap() call, the
> kernel ensures that EPC, PTE and VMA are in sync and fails if they
> cannot be made to be compatible. Also note that in the above flow EAUG
> instructions can be efficiently batched.
> 
> Given the current poor state of the EAUG instruction, we might need to
> do this flow instead:
> 
> 1. Enclave issues EACCEPT, if necessary. (Add RW pages...)
> 2. Non-enclave calls mmap()/munmap().
> 3. Enclave issues EACCEPT, if necessary.
> 4. Enclave issues EMODPE, if necessary.
> 
> However, doing EAUG only via the page access handler means that there
> is no way to batch EAUG instructions and this forces a context switch
> for every page you want to add. This has to be terrible for
> performance. Note specifically that the SDM calls out batching, which
> is currently impossible under this patch set. 35.5.7 - "Page
> allocation operations may be batched to improve efficiency."

These page functions are all per-page so it is not possible to add multiple
pages with a single instruction. It is indeed possible to pre-fault pages.
 
> As it stands today, if I want to add 256MiB of pages to an enclave,
> I'll have to do 2^16 context switches. That doesn't seem scalable.

No. Running ENCLU[EACCEPT] on each of the pages within that range should not
need any explicit context switch out of the enclave. See the "augment_via_eaccept" 
test case in:
https://lore.kernel.org/linux-sgx/32c1116934a588bd3e6c174684e3e36a05c0a4d4.1644274683.git.reinette.chatre@intel.com/


>>> the need for the weird userspace callback to allow for execute
>>> permissions.
>>
>> User policy integration would always be required to allow execute
>> permissions on a writable page. This is not expected to be a userspace
>> callback but instead integration with existing user policy subsystem(s).
> 
> Why? This isn't documented.

This is similar to the existing policies involved in managing the permissions
of mapped memory. When user space calls mprotect() to change permissions
of a mapped region then the kernel will not blindly allow the permissions but
instead ensure that it is allowed based on user policy by calling the LSM
(Linux Security Module) hooks.

You can learn more about LSM and various security modules at:
Documentation/security/lsm.rst
Documentation/admin-guide/LSM/*

You can compare what is needed here to what is currently done when user space
attempts to make some memory executable (see:
mm/mprotect.c:do_mprotect_key()->security_file_mprotect()). User policy needs
to help the kernel determine if this is allowed. For example, when SELinux is
the security module of choice then the process or file (depending on what type
of memory is being changed) needs to have a special permission (PROCESS__EXECHEAP,
PROCESS__EXECSTACK, or FILE__EXECMOD) assigned by user space to allow this.

Integration with user space policy is required for RWX of dynamically added pages
to be supported. In this series dynamically added pages will not be allowed to
be made executable, a follow-up series will add support for user policy
integration to support RWX permissions of dynamically added pages.

>>> 3. Implementing as I've suggested also means that we can lock down an
>>> enclave, for example - after code has been JITed, by closing the file
>>> descriptor. Once the file descriptor used to create the enclave is
>>> closed, no further mmap() can be performed on the enclave. Attempting
>>> to do EACCEPT on an unmapped page will generate a page fault.
>>
>> This is not clear to me. If the file descriptor is closed and no further
>> mmap() is allowed then how would a process be able to enter the enclave
>> to execute code within it?
> 
> EENTER (or the vdso function) with the address of a TCS page, like
> normal. In Enarx, we don't retain the enclave fd after the final
> mmap() following EINIT. Everything works just fine.

The OS fault handler is responsible for managing the PTEs that is required
for the enclave to be able to access the memory within the enclave.
The OS fault handler is attached to a VMA that is created with mmap(). 

> 
>> This series does indeed lock down the address range to ensure that it is
>> not possible to map memory that does not belong to the enclave after the
>> enclave is created. Please see:
>> https://lore.kernel.org/linux-sgx/1b833dbce6c937f71523f4aaf4b2181b9673519f.1644274683.git.reinette.chatre@intel.com/
> 
> That's not what I'm talking about. I'm talking about a workflow like this:
> 
> 1. Enclave initialization: ECREATE ... EINIT
> 2. EENTER
> 3. Enclave JITs some code (changes page permissions)
> 4. EEXIT
> 5. Close enclave fd.
> 6. EENTER
> 7. If an enclave attempts page modifications, a fault occurs.

The original fd that was created to obtain the enclave base address
may be closed at (5) but the executable and data portions of the enclave
still needs to be mapped afterwards to be able to have OS support for
managing the PTEs that the enclave depends on to access those pages.

> 
> Think of this similar to seccomp(). The enclave wants to do some
> dynamic page table manipulation. But then it wants to lock down page
> table modification so that, if compromised, attackers have no ability
> to obtain RWX permissions.

Reinette
