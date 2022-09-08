Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678275B295F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiIHWbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiIHWbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:31:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F7DF8259;
        Thu,  8 Sep 2022 15:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662676304; x=1694212304;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eRy0J1ip2P735gracc/k0OEPFlcuojmqIgzD/I7LbXA=;
  b=MmqJoD79+jZXtZnBK2twL7mP2QtUtPRN9hp5qsDUWZdOpI1oRm6/73Dh
   gvm75UHYms8N8u1aDu0kQmz24PkbShlt7PF4eVMmnX7ON7Cg6rh3JKBrA
   sKkZEiw48hGDDbBut8PYAvpiW5qB0QYQe2C9oD1w58qvhUCGFXRQcP5xf
   sviDE/ec1/37CjiuuQIiU8mRkfXFt0dBcNs+9efvKNfpVxF0QNif0J14U
   /OPKe4fTr9McdebaIaOeNXIvUiiSjDT8vYzLuoe67aa3kN0wBEJ2WuJss
   UdOZrPlV59198IbjMOjmYfXYDNHgIvwFIg7iyaCeyrQuDF29FwytgMW9S
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="383633812"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="383633812"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:31:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740843019"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 08 Sep 2022 15:31:43 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:31:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 15:31:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 15:31:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJVpCox3ea2LIjO1h0B9j1EvpMUX8KfyCjWFdA70Madak9u8MhfU2V/E6KEoyBIAnSZxjdbzP0PTR3rkeyB5hhGdrKJQcf6TkYt2xZwk2uke6odSVQGWMv1kbUIPz5UOYHW52ta8gh/5vc9y6a7LvG0KM+086/PSl4fOHbESB4a2zxS3Oo4MwgLO4rE+fXfMF8ty0LE8YKYEeQaR602MB9SOfOk1pt5aa1xopobdMJBxGPihC+vBh8yqp+S5AyI+AAnqPrrKMXXRnr3NRwiTgsM+QksQxF2eAqX7ASy/Dz6ZSWPrkIKuqlCuvDlxj9EIgxul/SG+RBRV4wkm1sZL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0fPuCMP9e8zs/NdyU8HcxYxd7PWRQBgarDXIWJctXk=;
 b=W0wUlIDUuG8DODyWCg9/1pvfom7xiPJ5cmq5XqE1n6wR+YKpQRsyPYgx7Y65f/XWPCwVwNQgMc7Au6fG3kcGlPwQiwUIFG09fQFR0Lp9a3UaLcaEPYkW4hAIdVACWDsLlHBg2UuJe+F4kcAC/1IP3R3/q49sIV+FvKrA4CtJxTBHpSl6bDdvb45UjHzITkjw7jCmT6rlTPbJF3I5ux9hNHmBdmrxxoI0NKf2ZA1vUs7ToHgSNEoAxeQqV4FSI05dERIOkvhiCrmSx1ijnBEMOWgCXR6/ibfWvq5f3MOdEzfX3gksR6hTfYAER8IwZyq5n6J4yYjS89GSLsD15Dt09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA1PR11MB6685.namprd11.prod.outlook.com
 (2603:10b6:806:258::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Thu, 8 Sep
 2022 22:31:24 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 22:31:24 +0000
Date:   Thu, 8 Sep 2022 15:31:21 -0700
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
Subject: Re: [PATCH 09/15] cxl/acpi: Determine PCI host bridge's ACPI UID
Message-ID: <631a6d394b4ef_166f2947c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-10-rrichter@amd.com>
 <DE840F3C-0CBA-49A5-B9B9-9D279FFAAFFA@fb.com>
 <631a5a27f22ac_166f29479@dwillia2-xfh.jf.intel.com.notmuch>
 <485824AC-DCEA-4DE2-A331-CAC5DE901600@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <485824AC-DCEA-4DE2-A331-CAC5DE901600@fb.com>
X-ClientProxiedBy: SJ0PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21507434-209f-4134-eb85-08da91e9dcc1
X-MS-TrafficTypeDiagnostic: SA1PR11MB6685:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwgqp0JnQ2m+A3diKjIl59SJkFfkPJA6UyrQ6BjQFlDRrrZ6P/1r3bdw2uFhuLXnI5Fn79LNBtGBllz19jpD6VPxrtmsYkqGplZFnLsntAwMUSbFtwKAkGoVXIK0kt1niLVqwjF3sLZWlXMxWSwAnAtRk1fACO8QjEsxFI5TeuGptYMo56g5bpiShG4bsg3PWH3EkDrV9F/WqtE3B5dALrcKJ312VTWVrXLOhstrvzbcsyMq9G05FzLQ+0f/YxTZ2c6LePTwufNgN9TqT/Nwf9LlMzE92Fqy5A1/eEKI8fEEQRZS5GBVUMBGcGZyyqN51WQAfW4pqP8AslbS74yOGPHii3AD5UOBLmFB20FOcLzoH7kQcS6EvxyFoCIs3AdA7dMh5dOPCiXSbDcCcL+Ad0IJRf4hbBT1+voGXZshJifd2hWkzIBxhPLsGHWf1oUeD1gpHGyBPdHifCbZGm62que+Zp+fM8WVYR3MVm8MEgJ3m7KVwbGixDz5nYFFKUylTXB97j2x0OQJkVeHUACA6q+fC9Vm2+/D2tKMBCBJqBzCyOc9FuJTETa/dnoOMJ1txVKH3NGkkbfl36SoePBTCP4zOKzyhHD6k19ZlihDgJP8lwfYOk6Umiu+uRVBAknq75ymrzJN71YpkYxbJywqtB9e0lMxeQp3jnWp9XZ7ZXOzcXEQVcf5u2cAK7qPJHiRs+KEA0hgUYDaBZa/1mrYPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(366004)(346002)(396003)(86362001)(186003)(83380400001)(38100700002)(8936002)(4326008)(82960400001)(5660300002)(66556008)(66476007)(66946007)(8676002)(6666004)(2906002)(6506007)(41300700001)(9686003)(6486002)(53546011)(478600001)(316002)(110136005)(54906003)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGo5VmpXenZiZDI2OGs2N2pLK1BuaVBIbXIvOFJBQWU1QnMwazJFWmlYdDd1?=
 =?utf-8?B?VWZZcHFyYitpZDBxNjRrVnVEcWNjMlgyVi9SeDJ2dVd4QVdERlp1ekJuT1RC?=
 =?utf-8?B?K3ZxV3FPOHJYeUtpWjVwVGJYSkkxVlR1eFlGSVZBc2xxd25NTXNtaUlndEpu?=
 =?utf-8?B?M08zU3lTYWtwVjRhZnpWYXRhWmNKZ2JhNWhnSk84Nit1NGJpNUlrK2lhYWZI?=
 =?utf-8?B?N094LzlydVBjd29paThjTEljT0grbU5lcUpNOXRhNG10eTN3ci80eTRoS3BH?=
 =?utf-8?B?YmppanUwUTQzUkpQSkozSVBwYkJOclZvRHVFV0dyeEFLMUlLNHlTalFDbDhP?=
 =?utf-8?B?TmVzUUNGUUozUU0vdjdDbGhCSjh3SG14Rjhycms2WjlMYWhjWFN5TDgrQWxn?=
 =?utf-8?B?YlJUdkpOYUhucGlnQ1FjdWN6eEVNRlBkWG1sM0ZGQVJqRk00SDJnTTBuSmRH?=
 =?utf-8?B?WnUyY1FJWnoza3NybTRYTG12Yy9maGo0Ti9HK0RSazBaa3JuUFlCRGlsb0xL?=
 =?utf-8?B?Y0hHN2VQN2NTL0J6UjBEVzJ2aWozOHFmS0ZuRm80cG1Bd0U3Uk44b3VialQx?=
 =?utf-8?B?THFzend0bVBTMCtXOWZpQStrcFJzOHFiVDJzRXp5M1E5bEJoeUQvREE5cXRw?=
 =?utf-8?B?ckY2NEdXUmpYN3k4YTVVdDV2dTVCY0lITTE3VG1HcSs3YUR4Q0Z2WDVTb1Jk?=
 =?utf-8?B?dFpSZ2dkWEFOT25rS3NLdCtJNlA2Qm8vcmZta1VrdDB2Ullra25GWVpWN3Vp?=
 =?utf-8?B?eHFqUFJTaW9qMHVrWkIrNjFZeWVHRzJ0aTBEOTRxVnZhSVQ2QjN5eHNWQVJ1?=
 =?utf-8?B?ZnB5QTdnNVBjMHdRYlRZVGYvbEhTMUhJMGtOc0NlVEppeFFJTGFJUDVOVzZV?=
 =?utf-8?B?WHBnNnptUmVsT2JCZlN0SlhuMGZyVHJKSkU5aUZ5T3h0RHBlc09CTUVNTklQ?=
 =?utf-8?B?R1d4SUZ6Z0JzN0FZU0xaZkUrWDFGbjdYclVqUVF0NmVNUWFFM29jcWtYSEh1?=
 =?utf-8?B?blh4VHJWdTZONTROL1IrdTRGK3FBRFBqLzNWQTVrTGJyM3BEakxoSzRqd2xY?=
 =?utf-8?B?ekpSWHFiZDNjVFBHUE54emdvdDR6ZUI4d01veGVURUxuTDE2VHU4dmF5elB4?=
 =?utf-8?B?MzlZb1phSGdaTjhEdXdVZ0tMZ3I4eS9vUjR2alFaajVuYmxyZGw4aFlRV255?=
 =?utf-8?B?OE5DcTV6TzNNMVhlRmxQQ1R2aFNjbFYzMEtDaXpiRDIySkgrMHhlcHpQZnpk?=
 =?utf-8?B?UFhUNVptODJlaEN5bC8veFY1Z3IycWkra25FRER1MURQYUlWK1RVdnlyQ2Za?=
 =?utf-8?B?a1ZZYm5zWU9SbkpmRG5CNHlMTURhenhNNlRKbmNnUHdTK2J2MDFjSFRnR01w?=
 =?utf-8?B?bC9pNHBPMURpM1VzSGhqb3lHQzR1VnV5YXVRcWVOVUVhODdydHZkb0pMZmh0?=
 =?utf-8?B?NmJta2g5ZEN6ZnFRZmlPOXVRMG5BM2NTS0FOMzRjMy9qa0tZV3BFREFzQmJH?=
 =?utf-8?B?eDlCbU1wUmpObmxVOG1zQ3NjM0trcUVDdkltYlh2UDNldUVXMGFCbVhtelNM?=
 =?utf-8?B?Y2lVcSszd3pEcmcvdXk2NUU0NldUdHpQbk5nRVBjY1hsWUp4TGhZNFUwZkFN?=
 =?utf-8?B?UWxIenJGemhiV2FIb25EdFdmNkc1RnRuRGJEQUs5eFVyMXpNMFVWaWpVRkVj?=
 =?utf-8?B?bS80dkp0MG1KbU9vN1VMUFJobFUzcmRaNHBsUlZHakhUZ2hkZUtTVG9iZUZY?=
 =?utf-8?B?TGtpcnVsZG9SQnhUUEo4ektvV09Kc3loOFFCR1A4Q0VQOTJaUW9hSkVzakha?=
 =?utf-8?B?YWVSbGoxdmNnY1BDeElBVkxDRTM1MXRpT0pUUWJ6VHlIOGVMMXBFVTNtZnU5?=
 =?utf-8?B?ZEJIM3dVaTRtcVB4ZkdkRzFwMWJObUUydHIxYmlJZm9xVjZtekIrRmcwNlRu?=
 =?utf-8?B?R0pUc1dwVkJRZEhLaGJiMk9GUzkvUFZMa1N5VzZBaTJHNXNrdEVSbytIRDhn?=
 =?utf-8?B?eE5GM1ljeW5rU2phMm1YZ2tRVnQva1U5R2g2UlYzNDhVSXJxcEpZbVdxVXRV?=
 =?utf-8?B?eldWNmgyaE93MTMrMGtuaWtlTlR0dm52STFsQnIvUFA3N0V4NXJwdGlTckxU?=
 =?utf-8?B?dEJlSjh2emFkMDJUSHdyYVlDNXZ2NUhSUHd5YlRqY2R0VHBlK3ROYUtabGJJ?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21507434-209f-4134-eb85-08da91e9dcc1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 22:31:24.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xx47BT+e+3RnesOFJ9XgrdP3v3QzNX5SH/WKulailDKYnvAP6hAJYONg/A9ZURxwTqXrry2GlRNB7IX3LENUeUep1mby3DbbBRXEuTS+h64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6685
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

Jonathan Zhang (Infra) wrote:
> 
> 
> > On Sep 8, 2022, at 2:10 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> > 
> > |-------------------------------------------------------------------!
> > 
> > Jonathan Zhang (Infra) wrote:
> >> 
> >> 
> >>> On Aug 31, 2022, at 1:15 AM, Robert Richter <rrichter@amd.com> wrote:
> >>> 
> >>> The UID is needed to read the RCH's CEDT entry with the RCRB base
> >>> address. Determine the host's UID from its ACPI fw node.
> >>> 
> >>> Signed-off-by: Robert Richter <rrichter@amd.com>
> >>> ---
> >>> drivers/cxl/acpi.c | 12 ++++++++++++
> >>> 1 file changed, 12 insertions(+)
> >>> 
> >>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> >>> index f9cdf23a91a8..b3146b7ae922 100644
> >>> --- a/drivers/cxl/acpi.c
> >>> +++ b/drivers/cxl/acpi.c
> >>> @@ -368,8 +368,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> >>> static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> >>> {
> >>> 	struct pci_host_bridge *host = NULL;
> >>> +	struct acpi_device *adev;
> >>> +	unsigned long long uid = ~0;
> >>> 
> >>> 	while ((host = cxl_find_next_rch(host)) != NULL) {
> >>> +		adev = ACPI_COMPANION(&host->dev);
> >>> +		if (!adev || !adev->pnp.unique_id ||
> >>> +			(kstrtoull(adev->pnp.unique_id, 10, &uid) < 0))
> >> The UID field holds 4 bytes of ASCII characters. kstrtoull() would fail
> >> if the UID field has value such as ‘CX03’.
> > 
> > The UID field is not 4 ASCII characters.
> > 
> > We went through this before in the original code in
> > drivers/cxl/acpi.c::add_host_bridge_dport().
> > 
> > The CEDT.CHBS defines _UID as an integer so use acpi_evaluate_integer()
> > to retrieve the UID to perform the comparison. I thought there was an
> > errata filed to clarify this, but it seems the current spec still just
> > says "value". The CFMWS also places _UID values in the target list,
> > those are also handled as integers.
> 
> ACPI 6.4 spec section 6.1.12 describes _UID, it says the return value is:
> An Integer or String containing the Unique ID.
> 
> In the BIOS I see, the _UIDs of PCIe devices hold ASCII characters (not NULL
> terminated). 

ASCII characters without NULL termination means that data can be
treated as binary data which is what current CFMWWS parsing code chooses
to do. I think a spec clarification is needed to make resolve the
ambiguity.
