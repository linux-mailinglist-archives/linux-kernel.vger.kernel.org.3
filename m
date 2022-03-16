Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5038C4DBA55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356693AbiCPVwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355069AbiCPVwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:52:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5E111A2E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647467461; x=1679003461;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hdm/NQccx6fS/oY1kFHg3WW8vR8ZAljvUW85E6KUWS4=;
  b=g5UV9Vah6h6oFLrIyFuZ1C7NFaUB9vPGP+WZivv1xBXRujRRq0ekREsy
   IfgaUK/IkXU67N52RQsDo5llJhPWVTOW/rSM7Cypb152otJn/jsPPnCCQ
   NVLgg8AA4+9xEuPIzR0NFsB1MxqVI0l42ZZC3tkhCK/JAvZTStTGNZfIG
   Ghtsmdh0VGD5QRLwT709hLI8IdcBmCoDrF0tgQp/SDabX+ec8iAOBGhSQ
   7fEetJkFL50IjOBsff1QCA/EQoervtuaSNx+BOVhrxOLeY1WSxZoNz6Hz
   suc/nk1vMyRkSaocK28UGVrpPyiJ7yzXTN+sJPfWCs3z2gNaHuA9HUfcO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255550808"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="255550808"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 14:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="820975431"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2022 14:50:59 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 14:50:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 14:50:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 14:50:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSB8TwVKZVZCDqobVNFPp2i86c81UlYlvhGM0hFA/qQOlkyTGdIA8gchurNTmMjO4XCQ0WM3aG2omgQCxjbBYPIGRWEqv+Xqb0BnLZ7LU6bkSpp8QZhLC7Y3XcMCzyfNMdhdT+d0FIJTlt4fyMU+P3bBF19THTZdF77LhJdtNucMnGG87LSpHv07bZLHUrwk7SoDpHRyskUC7eo2WilcPbUd9HqDTsBh6I7rmMHae/bIdlhS7kU7JhjKwY1QPYWDcPAUB2AZdLS3j60C5IO0WBJqDeIiYIw/iSmlhQqMF/pn4/m6yE5ZlDKbz+V4CGfzNLwPc+2cInEMU21Xxn2FMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVPQPOlxs6gHveQRPNGrH6ErK4I4q/9tcrePxmf4RyE=;
 b=I3tABNLa09fnKFl52be8pL1Jwk8ZvLPD2CpXi0rqxOJUEZXkAI/D0Mp6SbdyOcJqdGn2R30G4kdZ8xOGDuRXSCYF1VcjrzMfgnC6Bw+wk+fgIffXcHpF/bqdUm5thDxPMw4NieFS006UM6wSxrwyCuQhNY0yM2nZ+QVFBQfqlnWTikRsL7DEh/ZqgI7B/yhMVIQNWRK4o+UwGNpMF6s5Qfu2x0Xza0mJbtXqeGYslyaQYbjE5sRrrzoSufiS9bn1TJAfBHzIEu3Bz8ziFOqZNn0xCFnuT/q/LtguRD60XyniLKYcwgGXxmvYfCSR/SRuL6G9S7N711G5Pdca1wPSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR11MB1638.namprd11.prod.outlook.com (2603:10b6:910:e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 21:50:46 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 21:50:46 +0000
Message-ID: <7d6d9455-e516-e1a7-6dad-a0f9d4936b26@intel.com>
Date:   Wed, 16 Mar 2022 14:50:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 13/21] x86/recstrl: Add per-rmid arch private storage
 for overflow and chunks
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-14-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220217182110.7176-14-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::17) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98207f53-9836-40f6-7366-08da079706eb
X-MS-TrafficTypeDiagnostic: CY4PR11MB1638:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB16384CDEFD8E18E421915EA4F8119@CY4PR11MB1638.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJo+x+zwPao1HPdF0UlU2CtDr5cbfYBWJCMkzOr8JkgGVRGUdYh9fObnZgAtoIbdhVr3YzwltcPAByEW3IgDVsClg9d9kM7ww0MrUohjiHazSm76c+MfkJ42P17DIv3yf9B5aKNJG+30QFy0l0rSmPyuCzEUFcuR7HK39TCYNMIvYN8OkBSMuWS8GQNpJ92yOXU/DBFZDCCemLpsngKy4WCZxY8hO8AeufVS6TuOReKipWX/GpLCSyrNJPVQSj33dRL/W9L8fObsRblB5GFCcUEMGDq7UcfDTtKhtRoGxKtmcG66PTj/kOVAtMfbxgTWp4a6+Bgw+WcNjPm2tsCdJKWA10KJF9nsE7forUd1loqvsrx7jgYJA3PQmhWYFlmmbpcfceG1ZsTlW2+eiAOohHzlLnwyvRi6W+liaSrUXorjNp+fTUcBgEKn3hg0KHOZNV9FwvjOXchEqpvUKqltd6xkXYecpNyEjRptrmptf9GEwkhWOWcRhPeAkYXcomnML2yI/IjWUj9BcCzhHyr2ca7qHHYkwsVTUG5Guwd50UgGDghkVwjosM3EE91gLYUfTpodKGilc1mNQBy2OfA9YIa469CFedLHs6ELJPKDCYXB7MBNjP+5/ctyc6Xs9gCEeKVZ7Wm1Pd+F++0IZUIEaqTQMxx9UnzzA7ntH11tvp8zJvZuVoZ7epc8g+oZvlKy0VUQthgAwD5Lw3kNkDr8zXAl6MXnw4oEMyvTjhQ4MjgjoSK8bciEjxP0KwfdWcb9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(6486002)(5660300002)(38100700002)(7416002)(36756003)(8936002)(6512007)(82960400001)(44832011)(186003)(2906002)(26005)(31696002)(54906003)(6666004)(316002)(508600001)(86362001)(66946007)(4326008)(53546011)(2616005)(66556008)(66476007)(6506007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Y1Z3FUaER2M3I4MTJBV1RwRXU4aTRZMUkwRzk1R1NNeTdvRzRwUWZua0hC?=
 =?utf-8?B?N24rM0V2aUptZVdkYkhSUHh1MjFmQ1JESzExR0RsQy9vZ2pDZGp2Wm04VzZN?=
 =?utf-8?B?U1lrR0U1WVVLYlgzd3FkNFkvelJ3Z1RaTXNZWjZhd3ozMHFYbkU3a05rRjVP?=
 =?utf-8?B?UzF4RC84RFFjTXhOR2tlcGhNWnZkcUJTc3gyT1hmQXVOZjBSa3NQbVJLUTdv?=
 =?utf-8?B?OTJwT3ZFOUtTRWJaYlNqODRWem5tczVQdEZsTWZKVnF3Q1FPQjR1b1Yzbm9K?=
 =?utf-8?B?eWRCNnZlVnM5M29ZVnJ6OUw1NElodWtaM3pNUUNxdXBZaDNyZHN1ZWJvbVZa?=
 =?utf-8?B?Q3VUeis4QmMxajRDWldNamJFTzU5aG9hYWNhQmNlQUE3REJLbld3RTdrdkRO?=
 =?utf-8?B?eUVGNkdMZnBRdXBJV3lLSlA4NEdRSXJTNFpRWDFaaDlzWlJNZGJnalBRWHBD?=
 =?utf-8?B?NE5HNnJGTWdobVdYbGFSbUhLK1YwUmV4b2tuK0ZOd0YxcGRtQ0s4aUEwaHlU?=
 =?utf-8?B?UEVqbUlnYWU3RS9YZlVaaUg2bndrWVMwUE1DRDNGaktITzFxekhPaml1bmE0?=
 =?utf-8?B?NzBLbHgvZTl4a2Y0OUNFRWhxd0dNTHhrZHNFR2lhT1dzbVB1RFp1RWJEMXRC?=
 =?utf-8?B?NjFUWTdaandka01wOE5qcTZaNldobFRDOG8yZ25tNkRZVk5XNW1reGxmTFc4?=
 =?utf-8?B?ZlZmNUFyUFhXOG8vaWxST3NzZWg3MFJ2OGh5WkdSSWppT0hpdDhiUmw3Q0RN?=
 =?utf-8?B?SFUzWXI0ak9jRytwNGp1eE9kVFhoNTg1N2JYeXY3S3dTV01EbGlETElKVzRB?=
 =?utf-8?B?QzVQV015VmdPZExJd0d2OWh5NVJMNzlUWmQ5RHVUdWRqT2E2OVl5RXQyZWZy?=
 =?utf-8?B?UHRRcHkzTlhqR2ZJb05vTmpOZEc1aDV1T0haSTk3NUVGcUlweWY4V1RwU1Vh?=
 =?utf-8?B?WmMzL1VZeFV3Vlo4S0cwTUJ2MnV1RjRubGFyYTNFYm9aVmtRQU1kL2ZoWkRB?=
 =?utf-8?B?S3pyTnljM2twQ2RJOGZoSUFzdjZrbTVLY2tseDhIeHhoRE9EelZqaldTVzEx?=
 =?utf-8?B?enVtK1Z6d3FCeHB4dExZbjNBT2VFNVRWbHpYNFIyWDg4eFlWbDRXTjNSQzNi?=
 =?utf-8?B?dFV4akY0NGpnc1g3bXVkanBJVm43ckpQWjJMTVFkY2V6U3NiaytrWDFEVXJ1?=
 =?utf-8?B?K0pqbFd5L0EvdGx6dUZHQjYyQUM5R3JFV3p5MkRBUDFTSVZRNkd0eGdLaGln?=
 =?utf-8?B?OWx1bUZGZllaNjg1QmZ3bE03TkFKSEpEaG9oaURtT2FtT2NSOHE4a3plNjF0?=
 =?utf-8?B?bTRHZGJNTmQ5aGNIMTR4djFpRkFTVG81MWhYTjdIZjlDSHJQKytKYjJpVWo4?=
 =?utf-8?B?L0pLTDRvc3lNVmlkV3lLVHAxOFYwVm5hWHJmeDgwLzhmNHJJTjJtODRaUDls?=
 =?utf-8?B?WHg3V1FLUzNlSkdLbURxdjVHR251TWNTWHhuOWVTRXc3MUVFdGZUUVBpWTFC?=
 =?utf-8?B?NDBMYVNaN0cxOFBhN1VLKzZmMGZHajdtZ0M2bUdJbXEwYTkyeFZneDBRUTlI?=
 =?utf-8?B?SU1Td3hvWmVxSmpHQ3h3SUZMbmdhL0RvVGNnZXpnaWVEUDFpOEY4VFlJblhP?=
 =?utf-8?B?YmxhT2ZCd2hySkp4ZCtubXVEM1U2cVZkVGFnajFPeE54dCtzdjZRUDIwUnVn?=
 =?utf-8?B?eGRrUHQzd3BHTzJPek9IVUVKaG1keklxT1RHOUcvOHJlTzYwN0QvTnhUbTRY?=
 =?utf-8?B?NXZzWlFmMmJ4aEVFQml3b0VQL0tKbG9QSCszaW1BT1Z1T0RvOGg2RllrTkFI?=
 =?utf-8?B?TzNHeklEZHYvcnNZdHVjaXlpTUNtNnhwVnVQZUpJSi9PNWppWDMxdDgxdjRD?=
 =?utf-8?B?WnZabWVwUzNmanE5YWRIcXNnK052MzdWTWcxbmhxU09aS2ZmYzdpRG1NL3dX?=
 =?utf-8?B?djN6MTJZSkZQMkZDUW1pYlU5NHh6M2xXaC9aVEpBVVNmN2R0ZFZHVHdtdklT?=
 =?utf-8?B?VUFtSytzaE93PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98207f53-9836-40f6-7366-08da079706eb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 21:50:46.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SgWRXBJY9fzBIZYIclTqGhB61I1GkqvhmjZWFV+PcO5qOdBo8X+1pE5Zg4NbZ9Eg6LvTPvtHBLy7uiXKZCgvWusjiCSiPXxooh/SPdpU64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1638
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Note the subject line: "x86/recstrl" -> "x86/resctrl"

On 2/17/2022 10:21 AM, James Morse wrote:
> A renamed __rmid_read() is intended as the function that an
> architecture agnostic resctrl filesystem driver can use to
> read a value in bytes from a counter. Currently the function returns
> the MBM values in chunks directly from hardware. For bandwidth
> counters the resctrl filesystem uses this to calculate the number of
> bytes ever seen.
> 
> MPAM's scaling of counters can be changed at runtime, reducing the
> resolution but increasing the range. When this is changed the prev_msr
> values need to be converted by the architecture code.
> 
> Add an array for per-rmid private storage. The prev_msr and chunks
> values will move here to allow resctrl_arch_rmid_read() to always
> return the number of bytes read by this counter without assistance
> from the filesystem. The values are moved in later patches when
> the overflow and correction calls are moved into __rmid_read().
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Reinette
