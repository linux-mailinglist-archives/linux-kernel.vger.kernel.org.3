Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24D058BCD2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 22:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiHGUCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 16:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiHGUCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 16:02:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C86B63EE
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659902566; x=1691438566;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eZhSk4JqhGyjyBaoLXap5bauJGgnGOzgQ1GdDV54m3s=;
  b=hGt+L2+q1LBv/uBU0odkHrzyof1HomCntnm4+QPteyaV8tOdtVkaIQW2
   0l+Vq3fRLx1oBvh5ELbJgVoW5BwRfOFInrXUwWPbLak/UD0xP2Br1GjLn
   xSoqSXi8E66Aebo99FqWQd29Qyme50rxaR5J02wxXCPcgUQG3xLwqBa1t
   b05S3LynpPpDRvL17aJOvpTyMgLx1Rf3SAnca58ldDhvdKYVcnFZLr9kE
   dyByxOMKza/5Mewt1VJgX9hbwuf5OlONa5maMU7pCN2/RCNivDmIVv95S
   30PH1l1aDmIV/SWj95rZIWjVBmubIhRUS4c/CgkOLJy2gwb0fmBazKWxW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="289218728"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="289218728"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 13:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="632622915"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2022 13:02:45 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 13:02:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 13:02:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 7 Aug 2022 13:02:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 7 Aug 2022 13:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YryvFJ3/vgvNn9cTsFuZMAbXMs4V8F6GyPWSW8aR4bnVqiZZlYXyp1g4ZDxMxSvVvS2ukRpDRXC81iCvnMx7gyldxqzmsYsYvIhQhjZCUGYkfhAHxC13rD/sDqPymoeluM1tUzVJwxgVlb/PO2hH7jdUaUuGHmm0wVg5L2q91JyA/EbZaCZk0CBkbhPwQa4sJjEuy3WeIk5AcLRrsPldNEKaeQkFFADw6YwFtu0m/DiXQmMvuCm3huPMdLDu4jRwtR1scX/WmfLoefGPHwW0c9CqU86/nOZiyGRdu64xrH/yoyV+DBeII20fWNeX8AWWz0OV27PhjdzASuTKAx6RwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcki/RA9luMF6Zp/ZeMfjPRwnETi4FIahOxAEG0pPx0=;
 b=IEnzEutdy4KOq/mFtCOr965WWOUzPDjFFf1b0k8LpjF3c14/ev7axwyl9hUZkYUC/Qm10biZmopDOQvH1N4SwF9G1CRSJIYZJh8uUCIkit6KtMOdnjCtORRSPJ2dWScqQLsc2ji5uGqVkqwkEcL2vNTzvbvC3wRHg8cgZ+B3bhWhGSLIiSFtAJzl6IenL6nDGfTeSzxUIh33YNCazTETq9eHgYK2ve/z9MeAOTBopxQB+C6KmyzfOTEZbRWrYEdTT+5yAzUC/xLYe8LP9/9EQ/4w5CSl23/PMGSz1wT0Ewg6Ezpy+4kdw1yHwkP0XDKiBnpIYGwhp1p7l31W22N8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM4PR11MB5534.namprd11.prod.outlook.com (2603:10b6:5:391::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Sun, 7 Aug 2022 20:02:42 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%3]) with mapi id 15.20.5504.019; Sun, 7 Aug 2022
 20:02:42 +0000
Date:   Sun, 7 Aug 2022 13:02:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rik van Riel" <riel@surriel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
Message-ID: <YvAaXet3sBg3mRDe@iweiny-desk3>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-6-ira.weiny@intel.com>
 <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com>
 <Yu4t0jkpIY4grgxL@gmail.com>
 <Yu4wON0MRGH7h5Jv@zn.tnic>
 <Yu+Nwbn4CZUmyD14@gmail.com>
 <Yu+VV8xFTYRh0D0a@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yu+VV8xFTYRh0D0a@zn.tnic>
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68e83432-3b36-465b-5ad6-08da78afc959
X-MS-TrafficTypeDiagnostic: DM4PR11MB5534:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsqreczwHND9ztNXO/xGfDx2WZ52/XYZtMIrjQTby2DA7/BmzYYoMd1uFrQF1gZWoXLYfPXCfY1Qi16K55x1L+4GutLXGR9Z/A3VYxdoUJjd+JvcLTQs+xsXTsJPRQJlE7Fm2eFyY8M0+O3jJUqSPW+v3EiN/Du9sIi46XhTIaPANrGkHKAmW4RA4AvfdzasGQup7K4SQd0pu5S6+tNMiDruEwiT/dWObNjcySJfFrI5/2TCYPelTj0GhgG6e6jRmmdfmNKs+louS2uSzmlyLoRcNCpRSMplFEX/pEsfYppRYossxr9EqYwW/F5M+WoDWyukd+K5kQCyRW6RlXm2gq6qXn9CmMejQDUHQnaPuPCjMZaz4studIJEUvInqAkqy7xre+1otlhDOWA6D698aYd5PC8o5Fz+cYTnxewYlNUYX9TkpuOz/5XGVWOCoYGUmOG9hxA6VwhCyImcDiY2zXbUtsXven7Nvd9B5S6f8vulW3cgBSwpMw7N/AQKYNGHEMnXzc3DBMWvK6k0qXC/z043bthwc3AxTXhjVAiJ4amAbuaZXBnucf7enoV1jyaDug0/xVy7AQyyOJmePQb/yY91oqpQDm+v2uAVmJY/lRSTs0pLHTRa3IfvzhvJ1+2hG95FJsFhRl8mNa1jJvAtTp7syQ6GQR5txkBFiq+7Vd1hktZiVdI4DrGplujo+xkkJ48LP1U8aZbTVuXa3sJGjof7ov4HUPqFm18Jc+g2vbwLeT+Xtg+JInycKjna+MnK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(82960400001)(6512007)(186003)(9686003)(44832011)(5660300002)(8936002)(2906002)(6666004)(4326008)(8676002)(66556008)(66946007)(33716001)(86362001)(6916009)(54906003)(66476007)(6506007)(41300700001)(966005)(26005)(478600001)(6486002)(316002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qjhX9Uo3r715HwOjWXKcZDf0c+fMlsn/pOm2QyePo0QjLAvshzDbed3Uysny?=
 =?us-ascii?Q?Lk61kiBQBhyXkyLOcOKTxmS+lQGxoTU7gW+zvTvSSNNp/Jsol8CfT/uP9dy/?=
 =?us-ascii?Q?OyuKn2Aniw9WAphrwlka9dy59rVJrdEthFRrPsJRbktf4pc7tIjC+NZcGCQ2?=
 =?us-ascii?Q?egzh4ppPL80MxnmOQKzFiwP7BavkFC6XU9y9mlZw5OeTNu4XbbNb4mctWTen?=
 =?us-ascii?Q?RL3skf04IqoBLqFRowe2O/zbOTNkCZ0FBeWXTdYBIxCpY7YjouAL+mfVy2/5?=
 =?us-ascii?Q?Y0RyVNLasNo/oAvZVsGTuuQkmmlJ3A4enDtSf18OR3TQ6WjBMOdVV7Hrl0Qe?=
 =?us-ascii?Q?IIxjS7vuWwIP9q9uKDTZ89U1GoUg2b9mnjRVni9r0SAZkOfwLUXZCEV9xDq6?=
 =?us-ascii?Q?WsHWq+kRAeoKcARGKgamnQZK+usM7MXyoGwN/laDiskjk7YOJWOgJbuBnBk7?=
 =?us-ascii?Q?ZRDIg2Pc59eA7QNh3z4fzNu6wPg/Ve+WBfDaMhZxtZma+VuBxsgACSgGeeFW?=
 =?us-ascii?Q?O1Qr4Pm2krs+IYnA97mEcPnK29/hOl1Jvvcq9Az/bdB1MQFELhihAF7O/KYt?=
 =?us-ascii?Q?hdeT9rExGEa5ihlDQoTYnW/avBdQQbpK48Kg54qi1QwjY9wDqlasCGekeevX?=
 =?us-ascii?Q?MK7ghd0bmy6Qr3MojQlzuQMIQ0bAY4vpzCZqOhWZKxzV1vSUabRpacORSNwY?=
 =?us-ascii?Q?MLPNoN2i2yeT+bEJGbaAQkyw/arL571nYdRR5PakOgc/U0SrO6f46wpj/lmp?=
 =?us-ascii?Q?3A7HtJGk/s9BP7D7lPxUjH21cXCm721/ATFJfS/Y08hxv/bSmaGE3rW9cw+J?=
 =?us-ascii?Q?5M1i92XzJsVxv+O6FObKmc9fVojDoyQK6zrNnXE8SgdVil6n19ZI6yERuR1l?=
 =?us-ascii?Q?Oma7pNAnxN6Gnm46HC6EfCLw/p+T7gs3ktbWGz7TZndAo/2gb760MVBvstqV?=
 =?us-ascii?Q?2mmfEG8sy8KCRYyUiOUCUDFM3L6pRIUfbPqCpd6JcVa8/STCSLZBaISXz51+?=
 =?us-ascii?Q?eYZ129MnDE018M2N4czA2JofUIxrj1123OW8h/iBjH7IwJg6DWw5xQgHHVZR?=
 =?us-ascii?Q?H9Kxtp6F4MDXvUEqxywo6Q8N8wfKkAXjkQYB84sNTd3MEgOPhzI6l196fa8Z?=
 =?us-ascii?Q?pz+zEZTihkfsYqUpBb5l7MEJKzs7lUdbXBFrPI4Du7J9JKuNm2ziUAZWpbxJ?=
 =?us-ascii?Q?4iQVSfmNk8e7uJGuzGfNXs/f35aDJwWHmR1H7t/edHJYuc4gAUIg4UtcaZnp?=
 =?us-ascii?Q?dKK+TNJCrcqjOtgoGjDgdiwd8uZc1bn1wu0gg0GB0f+6MTec0yGk1SsVm7f2?=
 =?us-ascii?Q?3CXfGZ8cveBULYO9Dz7hUsXwtgOsPvLI6FPBhIzmm3o8MNQi8vwbG8GmNAMf?=
 =?us-ascii?Q?M6AQzm1Dx2LO+YtES1SU57TYjnpyBYMFfnUTNct56eBBNwwJjRe1P9i89/+5?=
 =?us-ascii?Q?nmE4J2xKA9XUFaotElZikVhAypWc3qEqJYE5NZk4FWyLylDc2x+KoEC+JyDx?=
 =?us-ascii?Q?rtbG9LdtJPu5zS/ORYgSX1GM++Grmh89MJk0w+DgyyRBgwQ8a0WBmqd+58qE?=
 =?us-ascii?Q?SF/9xW5+3FIFhsbwDCNw9LrqEtyMEGlQtza3enX4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e83432-3b36-465b-5ad6-08da78afc959
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2022 20:02:42.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eP+yPNow2bzfHyIdWNdvTmiukjNhyIAIEe6e2upCpXsEC3bup7R5LH6bN5e16eCtLXKOer4u6l3hrXaP9DQZQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5534
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2022 at 12:35:03PM +0200, Borislav Petkov wrote:
> On Sun, Aug 07, 2022 at 12:02:41PM +0200, Ingo Molnar wrote:
> > * Borislav Petkov <bp@alien8.de> wrote:
> > > With the amount of logical cores ever increasing and how CPU packages
> > > (nodes, L3 sharing, you name it) get more and more complex topology,
> > > I'd say the 2 insns to show the CPU number in every exception is a good
> > > thing to do.
> > 
> > We can show it - I'm arguing against extracting it too early, which costs
> 
> Not early - more correct. We can say which CPU executed the exception
> handler *exactly*. Not which CPU executed the exception handler *maybe*.
> 
> > us 2 instructions in the exception fast path
> 
> 2 insns? They don't matter at all. FWIW, they'll pull in the per-CPU
> cacheline earlier which should be a net win later, for code which does
> smp_processor_id().

I agree with Boris; however I feel that I have to mention that in patch 3/5 you
also have 1 instruction on each of entry and exit to push the extra stack
space.  So all told it would cost 4 instructions.

Again, I don't believe this is too much overhead but I don't want people to say
it was not discussed.

Ira

> 
> > - while in 99.999999999% of the cases we don't use that field at all ...
> 
> See my text above about the ever-increasing complexity of CPU topology.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
