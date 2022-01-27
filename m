Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCBA49DA30
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 06:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiA0F36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 00:29:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:30230 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236215AbiA0F34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643261396; x=1674797396;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A82Disjn13qfCoxYwaMghvS0mioLecy8HdAFet4HbV0=;
  b=eXU+pwFRQdIjAKVWp5CqbdA3Bo+AoVm4alWOZ5eA7AErAlSd/6V8V6T8
   MXm2yrFBA6uGdWuoRt9enDGZheIHwGHi0ZozzmHMFcVdooFOBVsC6Qasb
   NzrXEEB6yMzukB3/Cvrvj9zFlBqASd3/+J7ykQdlgaP3NSQ67NGWs0wwi
   Yp7OY1OxAdd216gWzjtXxwYeFyJtsQ3I0MRoyrxuUga/SamlaDk1mE7VX
   oRdp7jN5FFeMLZUrY5N16gRvYPAOjOMSozAGRTG8r88g71U7QjliR2Klx
   h04/pnI6Pa7IDfmAY/Ka8J6GRghd2xcJIYQWTMFDUyPIG30sNDM/sYt5/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246974624"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="246974624"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:29:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="769612882"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2022 21:29:49 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 26 Jan 2022 21:29:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 26 Jan 2022 21:29:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 26 Jan 2022 21:29:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHFP5rnBjIxjNWDyQiRM9vCFMY7tE+fcrTz+pq8A3PbMxsuvr+0k61rdV6v3XzwuUFMejxR66D8GOVBnnUkJ4jggpjHFF9P9WPhHBKnGy4lM/g7bRsu6669vR5eu3JX0je6m5FMVfL6ZsfPZxjqvmmv2FN68Tyt6i3IAwAZNKegwv5RGUmFe0QXh19EPaPqPd5J28Cs5Z0JHFZUV0EAMQHUClBLZu2D+xtltmh2AA3g+3GflVt0/NmKE+22xYfcnRoNJQ28WVjWA4CJOqLQoOEK+NMwHdLwivGU1scVn4w55gY3UJMh6gtB7IyFlVm877pXovhTyGQEfENOPqUFxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzySAXY2LRlX4bSrU/6ljBfz0vW/5KgZt9ofhvKFYnk=;
 b=SLZu7E5/6qgwxwmtEgD0zb6hanlcUJgcHD5+AU8PrOf0WTDL3bIcQJvfznswNU0wEWzhBFG3fNazAjSHqHHdllOPeLC1+dBSEvGOUxQarVs1/JdGiKSiV68vevPNKlFpmSCDakqqA0cRvGFKvUgzJ+iOsQYEs+iqS+3FVs5iLAJFnw9Pw83cBDUoAAB01l6O1yZplUKlziskYfwSposRviuPpqgCgDhHykRN2gcFtOIO2AKJa/Vg/dNgd1GzUVGR/FwREL2lD2+bxwVXVcyO9vknkgZ18+i64trdnLBTGPP3Odq/C/yx+igniX8zKV/jw/XmZ22zsHf28mCI9HIwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5583.namprd11.prod.outlook.com (2603:10b6:a03:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 05:29:44 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 05:29:44 +0000
Message-ID: <bc07fc43-c0a0-8d9a-f77c-cfce71a069fe@intel.com>
Date:   Thu, 27 Jan 2022 13:29:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: net/netfilter/nf_tables_api.c:2014:2: warning: Assignment of function
 parameter has no effect outside the function. Did you forget dereferencing
 it? [uselessAssignmentPtrArg]
References: <202201250614.Oo7D9VA6-lkp@intel.com>
Content-Language: en-US
To:     Pablo Neira Ayuso <pablo@netfilter.org>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201250614.Oo7D9VA6-lkp@intel.com>
X-Forwarded-Message-Id: <202201250614.Oo7D9VA6-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:408:eb::26) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb7f861c-e761-4954-47cb-08d9e15606c1
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5583:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR11MB55833F58B4343D518B685010FB219@SJ0PR11MB5583.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:239;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EobUPEofMquSt2rhIvUhOUgj1m5I6aLFQJUDs7Fo4SOdMzT5HKyi7UJqEWROyKb/n6pvVFuO6XYh7HA1X5E9DP1ngsl3SEWVXxn2z+5S3JFh4dhQ5+vAOieeYsx4c9igBMtMyI0U+0HKYb4uhuNXXLJwgffCldPC81F/9gyyMJUHBV5QrakccFGTb6l+cjpQLTnqbxKAwv7r8FCT63WX/k+OAfTD+fUM9LxeSbze1gRXD0sF6WIfRfqWtJHuRpOGYnQqJtX91rOXRFtF2BEFhrL2PrdwpKqdvl1Pp/A1bEazPFnAUfJR6foq6CAL/Px7hD0VG5IUc9kZGTmZP+KbgHcuoJGeJnOEpQwlHA18SxRRseCBCyjApaVGqifs6qDWTOeGCuojg2OIDVuR5JukBh5ga81S7OrF13td2yizQTyp0MTqMoVhXotX/JzJVmFzeaqiPizUCwrm9dE7n2fVhv9Mj6VkbXWGgv5RzTSokVWzeFoWqK1j3GYRLbMPPpMPpcKmJ+9xqZ30CMcaFqkE3LCk6edJ2o46HTtL2VXz6GaWxu51FL+1VXFkT5zaJRALExOZi/e0RbRP09o+7j4CfiDvyNot6vngQUPIzveXfim6QvKQD6dUWQsAfxoP3csUTFX6k12qBb8O6JAc9mgdwsKf70LUmP1traynoxiPprBYzXyQU6jKSmiUfEuFvYR1kLVeNjhxb2g97WF+r61I3Ks7cCXVDfktVI1VLJMQE1VfaFG9vLPaUQu2v+Pm6GoP/bVKbgrS6Sbnrm1m5PfoJt/RKwyOW2oY+JPEvPu10HQVOtOpgmf4jq7W8OTeeeKg37MN9Lk+yecXYy/o/dZUDFh0gbFcHcQDduHyqQNvFGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36756003)(6916009)(66476007)(66556008)(26005)(6486002)(966005)(186003)(316002)(31686004)(66946007)(508600001)(2616005)(86362001)(82960400001)(6666004)(6506007)(6512007)(5660300002)(8936002)(8676002)(4326008)(38100700002)(2906002)(31696002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTFSbTB2ZHgrREZiNSs2NXJ2eTdkRVdVMDY3RmtURDVnbVdJT0FHN0IrRUJR?=
 =?utf-8?B?c3E5Smx0RU0xNU1RWkJGQldXWTVkWms2dno0b2tjNnlVUXRZRDJlZlpDV3cw?=
 =?utf-8?B?QTJwRVNmOWlEUzdNVmFLVzhYSnR1YWpZc3BNL0hIK0FwTDR4SldqNGZJS1o5?=
 =?utf-8?B?cStnSFU5UnMvY0RRbkNtSVFTYlJWeTJlODJyOHJHbmpURVpyWVBkck04Y2hp?=
 =?utf-8?B?Y0tXUjhDdWV0QmxWK1Y3MTZabXh1WFQ2L0VlRTN2MXFSM242TVJqdlRmSm9B?=
 =?utf-8?B?dXJYY1ZZWnJyY2orbFZqQVE2am02UzBTNisrcERyd2ZyRS9tSTdUR0FpZHY1?=
 =?utf-8?B?dm4vM0dYekdqemFQb2wwY1JEMXpWQ1kzdXowbk41ZUJ6U2JnNVpVZFNhdmtu?=
 =?utf-8?B?c0htMlV1QXFYYlRhYW5oR2ttTHFxWlI1UUtqZ25EMUdkMmpqMGo4L2M3Tk5X?=
 =?utf-8?B?dGpDbi96dzdVdlk4di9YSTZWNkZ5NERXQTdFWjBnWHhDQTRnTnBPcXprR0V6?=
 =?utf-8?B?Q01NZ2JTcEp0aWpEUms2WkJUT0hnLzRVQmNwUWhpOW5DQnNGTWE0ck1nQ1Bq?=
 =?utf-8?B?NEgxbFl5eENtKytHL0I4emxTazI4NjNQZHdPOU53UndRcFZFV2pPblN1QkFJ?=
 =?utf-8?B?eTA4SVp1UlhTMitrN3M5OC9wRHYvbDY0TUJpK1Avb1RaYmRYcVlod1FCNUFY?=
 =?utf-8?B?YU5qeCtPQlZQZkxIbjVSWDY3amdsVTJQaUE4U0czMjVsc1RhNEVpM1pHb0Jq?=
 =?utf-8?B?Vmd1VnhSTkhvMVNPZHA1VG55WVgvb3lpcHpRVGg4UGNwYW52L2kwdFBneXNU?=
 =?utf-8?B?bUorSElnR2FFV3VKSTk1bmY1YmZPVlVTamgvMksva3RyQmdaSy9OdEJSdXQ4?=
 =?utf-8?B?ejhiS040b1pCRUtjdTRKOW1PaitkV080ekVlY2VEaFlrRTg4M0lMM2JrcVlC?=
 =?utf-8?B?WTRZR2lTa20xb1hQZGEveWhVQUNyY0hLZnZHZTFyalY1VU9rR0g5cmcva1BJ?=
 =?utf-8?B?OVZMbFhGcDRYN2FWRmFtT003MGJLN3ZPaVBCTm8zTWRMMVZHVlpwV0ovTExB?=
 =?utf-8?B?dVlQb2YrbDlydm5XQTNoRVRJSW92aEFmM2o2am05NCtEczJubHdSNC9nS3VO?=
 =?utf-8?B?bGoxUGJad1dsSGhtUGJHaHF3aWxhMkh0OCtXdVhnL0MwbVFJcHF3SWpWNm85?=
 =?utf-8?B?YjlmQUVDbXU3bS81NWRXVEtNUmFSUkJpZDJNOW4wQ1dJMkxDNmdCbnAwWmVt?=
 =?utf-8?B?UCtEUGJFdmxVV1hZZ0ROQUtYTmVpR3dSVFdPYndRNmErUjJZWDVnSkJDY0hW?=
 =?utf-8?B?Nk5rRDdNOTVjMVAxSEphdThmTFFaRm11dkZYTjZybTYzcCt2cWl4WFBBNHUw?=
 =?utf-8?B?WUJ1K09kaytIMmltUkpFZXp5NXd6RW5DVjhJbkJua0NQWGN1Z0tIb25oaWNK?=
 =?utf-8?B?MldXTXdzVDV2cExqZ2w0WW5WMUJNd0UrU1BuMkJSbzF6ZW5zVXZhVDhlTitU?=
 =?utf-8?B?V3N3ZWhzS0dVM1phZDVlR2RabHNNaS92ekszdVRrdEFkY1pvWXZBMFR3b0Z6?=
 =?utf-8?B?QTY0aGViVEVTYjY3VlhsaUpBMmZLRlBhMktGbjlhZUp1Y0Y5NGNUNmxxS0lS?=
 =?utf-8?B?eWNkdTc3Qmx0TnRhMFptN2ROSHRBNGdTcWEraUVFaTROOEZSK3lGdUNZRUpG?=
 =?utf-8?B?SmlpUXlMbnIva0g4TFJYRWpGMmZBeXYwM21GcHcyTVd2ZkhxQ3pScTVaNGNw?=
 =?utf-8?B?aDVqazNSRkJnRk53NjlVT1VGeDFRV05aMElvaXNvbXVLN082VlF5azVnRDFm?=
 =?utf-8?B?anNKYndWN1FBSXRva3VpYk5rYlBLNWxNenBJSlhJTmxWZ3hiK0tNeitmaHVm?=
 =?utf-8?B?bnlZOGc2eVNDS0x2NkxvNVVjaDFVR3grNTRGY1FqZFFLRXNINHB4c2FZbita?=
 =?utf-8?B?aW5TdG1vUzNQUzBiODFYNy9GQnhSUnJBc1VSOXExSVdXRVVyVmtnUGU5THgx?=
 =?utf-8?B?cHkwNGhYNEM4Sy9KbzdtUGlTanRmTmFLaFR4akZoRDZ5TmJRQlltVyt6eXFj?=
 =?utf-8?B?NDhJVTZraUtCMElsK3ZhaURQL2lUVVZkZUo3anpWRGpHMktDQ3ZuQnkyVDA4?=
 =?utf-8?B?V1Z1YTVXYXNhYSs5d2taR1B4RVVtUCt5bXd3QjZERmUvcjBKZ09zSTF1c1BI?=
 =?utf-8?Q?lBsO9oebowHqAFup/rhRlXo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7f861c-e761-4954-47cb-08d9e15606c1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 05:29:44.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FM5xqqhGY9sG8PWiLz4yphl3KunxwKQ1iSQViCikVBNwzqbwY6wIykJH0EYFKZQHWMjblHH9HNCDhzlUwCCUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5583
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 2c865a8a28a10e9800a3dd07ca339d24563e3d65 netfilter: nf_tables: add rule blob layout
date:   2 weeks ago
compiler: arceb-elf-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)

 >> net/netfilter/nf_tables_api.c:2014:2: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
     ptr += offsetof(struct nft_rule_dp, data);
     ^

vim +2014 net/netfilter/nf_tables_api.c

0cbc06b3faba75 Florian Westphal  2018-05-25  2007
2c865a8a28a10e Pablo Neira Ayuso 2022-01-09  2008  static void nft_last_rule(struct nft_rule_blob *blob, const void *ptr)
0cbc06b3faba75 Florian Westphal  2018-05-25  2009  {
2c865a8a28a10e Pablo Neira Ayuso 2022-01-09  2010  	struct nft_rule_dp *prule;
2c865a8a28a10e Pablo Neira Ayuso 2022-01-09  2011
2c865a8a28a10e Pablo Neira Ayuso 2022-01-09  2012  	prule = (struct nft_rule_dp *)ptr;
2c865a8a28a10e Pablo Neira Ayuso 2022-01-09  2013  	prule->is_last = 1;
2c865a8a28a10e Pablo Neira Ayuso 2022-01-09 @2014  	ptr += offsetof(struct nft_rule_dp, data);
2c865a8a28a10e Pablo Neira Ayuso 2022-01-09  2015  	/* blob size does not include the trailer rule */
2c865a8a28a10e Pablo Neira Ayuso 2022-01-09  2016  }
2c865a8a28a10e Pablo Neira Ayuso 2022-01-09  2017

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
