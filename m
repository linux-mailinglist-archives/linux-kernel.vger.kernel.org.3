Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9184D5B280E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIHVCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIHVCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:02:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1905FE3D53;
        Thu,  8 Sep 2022 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662670938; x=1694206938;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZHGFzjHLbfE9/ZjQvGcifnbyNFN7F3z5YJX1amaq7G4=;
  b=IXy7t/PF2pzAqxVe+qabFZLfajPavi36kuUFjgCh3VxGsJ2LeN+zIOoO
   braEY7CV+834Qh0RIhMv+faSNSJAsA2Ov69H66tPyPgydZcr7sU1iAdpB
   eG0AbAcX7kUvO+Me8tBnWSF+pnJXfod5TOx77a/Wx8TSF78qF56pwtb+i
   ovA9hvGR0DumV0Mstm1oDwWFsq2VOcynCBLYcBdHb1LuYvY4s4EpEW0o9
   sQb86TeFdXpbReba+Q0hEKn0GzDMRq/gmsOyBTZJL9ePC5nzF74CbF8OL
   Q6HHJfeWMwQjLiP9Aro5qGNRt4BSDcn+rDgquSbSw7ChmheQNNoJyOAZi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280350651"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="280350651"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 14:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="566102401"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2022 14:02:17 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 14:02:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 14:02:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 14:02:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 14:02:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFYnQTLSufLa/9l1p2fQtXkZqUIKtAwe9+zJd1MYYGgcsK3Vwbd9a/Yvj34x7dtUqN0lEWphX6Uf+Ehs9dY8fiEGY1Qf1Wi3V4f51Mfifyg/D/RopPZhvTldzEAp5lubRdxeQia8eDigoaQlO44G41XVf2TwjqGwaykyt5wYgSKvFgi7Lxb6qOFRHzAPeDkT21mxy7E36tMbd6vI3BQopnx8mPZ8Zwoa6HH5NUksxxlosuAyCwi2ZVLOmNe8K7B0Lug18lgXPLxOb1hzwN0tk30SUyav66SRo+0eYaN9YrhQ5jG5LmmXR/h4lVITkb/9JJtQxNB/h994PHFx48wszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZeBYmEPdT5BrhX9+kMN00XxTsoabXW1aM4aKPDMZg8=;
 b=ihQbS58QfeQ91LzzPTKuHpJl4VxGroMlxEJago26ctirzH2RM1fRwcmMg/2drbnSQrv5tLo1T3tLy+zzrOXi1KF3vLSrrB30oGOTHqT0aHTZSOxbjQW7GCE4pz2UEG0/6vitYlenVAbEFLDH+Va7OZtLK5f/pCqAf/Wp3WqC9fnp2yccc4aQ9tKnjjCaH8GEopmtmkxJhsYezeuN6XoBZZABYwKVDwD6o9C9h8Nu4xkUUY5ePu9v/Nq23Gs+nkLP1+l/DurrPjBETTL6VzQTJE0UCkdNawVKgkkyr8jmaiAfqWLwXlCCG90TqSJNKcAdLHFc2E+RNdAw0mn1zSqg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA0PR11MB4670.namprd11.prod.outlook.com
 (2603:10b6:806:9a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 21:02:09 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 21:02:09 +0000
Date:   Thu, 8 Sep 2022 14:02:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Jonathan Zhang (Infra)" <jonzhang@fb.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD
 mode)
Message-ID: <631a584f46cc9_166f2946@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <631980ff90319_58016294cc@dwillia2-xfh.jf.intel.com.notmuch>
 <17F02AD3-D68A-4E6A-A549-A47611B335E7@fb.com>
 <631a47b0326e_166f294a7@dwillia2-xfh.jf.intel.com.notmuch>
 <14D1BEC2-4921-46AD-B767-3A7E555F6E97@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14D1BEC2-4921-46AD-B767-3A7E555F6E97@fb.com>
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad78b93a-e0fa-4fcb-b188-08da91dd64ef
X-MS-TrafficTypeDiagnostic: SA0PR11MB4670:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2UjK/EhpfzPeq9waXEHvVFk+wwll9hZFskZF/Q3tl/f6YNEXCCMWnSzKDYDujfSC00iDV2/rSz/HFlfBQapRwTRO7v92RaZYv7CC9Df9g6sWOu33MR2evfULMWae+aZsVHIdkBLlj3rwysx6zks58jWq3I9LtS1avzK2RHP7pzMDVVonctEJUORiCCQ1qfOc4BOlLgsHGSuGMNG8ePKlP4uHKlzgxWqtULJzfVa/aVQ9jWMYqnlhRkXcT03xowEOJFdOctnMxai1uWcyapq5+aCzfbdV5DrUawpMijijVtfPdl2FP3iYc8ghcXO9FGMfnGzcdFM8J4q8OM/IY2dpsd6FhtQvFrllbiRqraRKK34qO3gik9aFQ3L8smZXGNw1L8/tZt6qwySVQ+rP2l45WSh3vgElqm2v8l+A3HsrE3QrZl0xKx3QUxUPrvlDdhxMWizZcQS86udmG/147E4DxTFU9YcYiyZ7i+01R+NxFMKvct4YkjdfuPXhzreCNpciWeBXUGR5rUUhKXZtymZUmDkASArOVbI3Klh5GuQWQ+BdUJmiTPC4kKoYJpm/9VTkSKnhEj5YSoXiRmQVBZkzKwC+4iCQFypkmpBKBlmKH3/DymUpGy3u4RIqFvbDYZzyH+cSRJSulRCzoF71xDL/GtMlmDnWbmMVZrd3k+gGJTC+c/CxVFEqViFpzSXFbVIbosF8H7gggH6dj74oWVdeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(39860400002)(346002)(136003)(83380400001)(54906003)(26005)(6512007)(9686003)(316002)(478600001)(53546011)(110136005)(6506007)(186003)(86362001)(66946007)(66556008)(8676002)(4326008)(66476007)(2906002)(5660300002)(8936002)(82960400001)(6486002)(41300700001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnQyQ1lqcmhDQW5MZm52c3RVbkJwRTlaMTc5Y3FlZVBQWUcycS9oRUFBRzNt?=
 =?utf-8?B?MXppbE0vSEo0RDdoZmh0azFyQTlaVG9DSmVLVE4wVEo2TEpWZmxqd3NyTVpz?=
 =?utf-8?B?ZTIyYW82eHRJSm1IWXdqS09wcm82Z1RWYkNZNzQ4VGVSdHVDSHdJczNhN2V4?=
 =?utf-8?B?OG5XT1ZrMFV2c1MzZFZkdnRsTS9YalpMUEpQK0FHZXppZTVDaEdBQnc4Zll3?=
 =?utf-8?B?bDh5Wm1SWjU5bXhObUNQdGc4ZDd1OGFDSmFSaDZQQ0xHTEtSNCtaYVFjaTZK?=
 =?utf-8?B?OW1waE8xRXZHRmp1QktLc0tlSlJaY2d5WEZkdEtXdFpoVWdYcDlBTFVMWUwr?=
 =?utf-8?B?WHY1VVFQOGNXR0J4TFNnczcyVjRVYUorYVkzVVJoWUxXT3k0cGpyQTNCK3RL?=
 =?utf-8?B?SXNkSHo3NCswK0V0MW9pa3h4SjFEREVRSVBtcE5nSWpuU3dLUUFZMXU3aXdT?=
 =?utf-8?B?UVA2OWtObWZEenN6QVVZUjBCSlFjSlVuTHRKK05GL2RINWF0RVZtdXZFZlFR?=
 =?utf-8?B?VmdOQlZtVzlsYXFWeUlEbU9nTFNWY2pydVdxZkJGT2dqeFQxR0hBYTIxcXZq?=
 =?utf-8?B?WWhHbE1RL3JqWlVMWm5NSkJJRnRabC92M1NHNjhZeG9mYUo5WXMveGlReGpk?=
 =?utf-8?B?aHNWLzVFbU9XV2g5OFRveXd0VTZySE5VZHZHazA4czFqOHNzNzZ2MnhLeFJD?=
 =?utf-8?B?TCttTU1vcVB2WGZHYUFQMHZoUnljYS9aL3NkbWdqZllBekNIV0FpMVNzNEFP?=
 =?utf-8?B?VmZIekROay9YekJnemNuRTl2YzR6NnlSOTFGRjF3RmdHWjJIU3VhVjNMWmZ3?=
 =?utf-8?B?Q0c1dk11dmR6QnFGbzNWRUVsMkVPMkpOOEZ5NTNDblYxckRWRHE0eWhVeUJC?=
 =?utf-8?B?Ky9YVHdDVE1UM3FIeGEwL2hFbjJQYW1XQUp1NzZWK2pqYUdVdDNYUlcwdzhr?=
 =?utf-8?B?QTdaUXVvM0dMZE5NcmlZU0krTnpueXA5cTJDVmUxZEQ1cU5xZVBRaytrQys3?=
 =?utf-8?B?NWFHZkNQeDBhRmRlUzc3Vlk1ZEQ2ekJHZ0xvQ3NWeXJFclR2eTc3YktzOUEr?=
 =?utf-8?B?MTVLQVJVU000eUNycmpWekZCVEYxK0syYVpKWUJ1R3BHUUtzMTRYYm1scHFu?=
 =?utf-8?B?SWtwbzBxQ0RPbkVGQzdrMm9uRldLbVlKdUFjT0JzdVQ5bVJhUHpjZWVia2Qr?=
 =?utf-8?B?aklTeDNSVmJvakN6SWRDcDBPakRCNVZuRmJzRVJUem9FQXJ0KzVhZHlWejlS?=
 =?utf-8?B?bElpZFkvQ2ptTVNLWS9XdUlkbUNHMUdCUVp4eXFvWWJLZnkwbFk5UlkrMjhv?=
 =?utf-8?B?RlFraFVQNDIrSGR1NEdTS2Zoc2dtTjR3bVZPRlFTQW9Vc2VmNFpHTWpLOWZY?=
 =?utf-8?B?OE5kRE5SMzJkcXlWdWJMWXFHZG1JVnAyQjNGTS9Bb1hzdjFSRDhYWjdRcGpC?=
 =?utf-8?B?K3pIdVprTCsvQ2JXNnlpMnVrc2FUaTZTcXFpdTNFMlpXd2xzN1R3RmlKekpL?=
 =?utf-8?B?M3RieGdyOVRkZHp2UUgwOFBHL1k5TFAzOCtTbThHYVhVa2d6NzU2T2p1K2U4?=
 =?utf-8?B?VVJRd01LcXBILzhhREcxVVo0eDRUYmlGSTdFcnZIamErYkppUEphSVErWi9C?=
 =?utf-8?B?Y3g2dmF0Ny9WN2NQT3B2THZxOVlKNEhHR0JyemxvSFZCYkNzUk9JRXBObk9B?=
 =?utf-8?B?aWI0YXM4bklRWjBOSEVYckIyUktlRFpYSGU4V2E2RWNqR045UEs4dzgvWkZ0?=
 =?utf-8?B?VGRCci9CamlNQUxWdC92U3VsQVRQanhyU2N2SGp2M25DSWZnMkZKUDdzSVVE?=
 =?utf-8?B?S1JFbENQN2RsTVkrRGVRK2g3RGprVU9hYWNzR2ZtdU0rcWNnMWVrU0hHR1ZI?=
 =?utf-8?B?TUlkU2E1bWE3ZlNWdTNTek92b3h4YzllMU1YM0o3c2h6NUF2cWlKcmZJaVo3?=
 =?utf-8?B?QUpzUGtGeDBnMjBKQUcvTGF6dVVacEpUSXdCY0ZiWHYrODNJOE94MHRrR2lN?=
 =?utf-8?B?cWQ4L21VV1lmMW1ZbHViN3ZHcklIL29EWVJZZy8zZ1ZrYTRXendCdnR5K0o4?=
 =?utf-8?B?bWg2WnBlV1VVTEFMazdDdVZXcWwwV0c5cWpteVpGMnJsVERBNEJxZVVkb2U0?=
 =?utf-8?B?QzZGdWl2bWZscjBWZHdVc0x2Sm81MTJDbDlpb1JCT1FLWWpmL1QyeUUvcEJX?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad78b93a-e0fa-4fcb-b188-08da91dd64ef
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 21:02:09.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4ZMmmeLqTyUiI0LLFmm3TVMGs74GFLb4MXf2lP7WHiAiBclZ+ecIaBhEUHFWFIGQqW0M8361Uzxx+M8aPzW0O7OsX7FV/S9OQcgysLapUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Zhang (Infra) wrote:
> 
> 
> > On Sep 8, 2022, at 12:51 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> > 
> > |-------------------------------------------------------------------!
> > 
> > Jonathan Zhang (Infra) wrote:
> >> 
> >> 
> >>> On Sep 7, 2022, at 10:43 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >>> 
> >>> Apologies for the delay in getting to this I had hoped to be able to
> >>> finish up some other DAX work to focus on this, but time is getting
> >>> short so I will need to do both in parallel.
> >>> 
> >>> Robert Richter wrote:
> >>>> In Restricted CXL Device (RCD) mode (formerly referred to as CXL 1.1)
> >>>> the PCIe enumeration hierarchy is different from CXL VH Enumeration
> >>>> (formerly referred to as 2.0, for both modes see CXL spec 3.0: 9.11
> >>>> and 9.12, [1]). This series adds support for RCD mode. It implements
> >>>> the detection of Restricted CXL Hosts (RCHs) and its corresponding
> >>>> Restricted CXL Devices (RCDs). It does the necessary enumeration of
> >>>> ports and connects the endpoints. With all the plumbing an RCH/RCD
> >>>> pair is registered at the Linux CXL bus and becomes visible in sysfs
> >>>> in the same way as CXL VH hosts and devices do already. RCDs are
> >>>> brought up as CXL endpoints and bound to subsequent drivers such as
> >>>> cxl_mem.
> >>>> 
> >>>> For CXL VH the host driver (cxl_acpi) starts host bridge discovery
> >>>> once the ACPI0017 CXL root device is detected and then searches for
> >>>> ACPI0016 host bridges to enable CXL. In RCD mode an ACPI0017 device
> >>>> might not necessarily exist 
> >>> 
> >>> That's a broken BIOS as far as I can see. No ACPI0017 == no OS CXL
> >>> services and the CXL aspects of the device need to be 100% managed by
> >>> the BIOS. You can still run the cxl_pci driver in that case for mailbox
> >>> operation, but error handling must be firmware-first without ACPI0017.
> >> Firmware-first or OS-first applies to CXL protocol error handling. For CXL 
> >> memory error handling, the device generates a DRAM error record, the OS
> >> parses such record and act accordingly. According to CXL spec (section
> >> 8.2.9.2.1.2 DRAM Event Record), DPA but not HPA is in such record. The OS
> >> needs to translate such DPA into HPA to act on. I am taking this as an example
> >> to show that OS CXL services is needed.
> >> Instead of using ACPI0016 to tell whether the system is under RCH mode,
> >> I suppose one way is to check “CXL version” field of CHBS structure in CEDT?
> > 
> > Unless the OS has negotiated CXL _OSC the BIOS owns the event retrieval
> > and translating it from DPA to HPA. I do want to add OS CXL services to
> > Linux, but only in the case when the BIOS is actively enabling OS native
> > address translation which includes populating ACPI0017, CFMWS, and
> > devices with the HDM decoder capability registers instead of DVSEC range
> > registers. Everything else is early-gen CXL that is 100% BIOS supported,
> > similar to DDR where a driver is not expected.
> 
> 
> It makes sense that the BIOS and OS need to negotiate CXL _OSC so that OS
> would take care of address translation. That being said, only DVSEC range 
> register (but not HDM decoder capability register) is available when the device is in
> RCRB mode (section 9.11.8 figure 9-7) attached to a RCH. This type of
> configuration needs to be supported with OS CXL service.
> 

So that figure does have the HDM capabilty pictured in the RCD upstream
port. However, Table 8-22 does seem to incidate that Type 3 D1 devices
are not permitted to have an HDM Decoder Capabilitiy Structure.

However that then leave me confused about figure 9-8 as that shows an
HDM decoder capability in the BAR and not the RCRB. Is that picture
wrong with respect what Table 8-22 indicates?
