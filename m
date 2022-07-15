Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532E1575911
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiGOBTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiGOBT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:19:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE173D585
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657847968; x=1689383968;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=/HNnetT9GpL/r7xH7vH9OFbrbJXDu8nihpCE/gJmuCU=;
  b=Ncwxx9tKYIlVqB1wWVXMtzIjcAWjVaiclZQxTPodPrJO4YQX+vQrB1Kq
   sLTDdjgucuccuYWbbEOTeY/wHOl2otAs9IR+dWugp6AM4IUzDqFCExUCf
   myPd+0ymnzkaY4msksckC/8O2qKlZjRI5KwZ2HI0Jrs9ZGQ/GK7ciSEXo
   fIkYErIPcH6hy9WJt+UVo35ZugR4EG7NpWwawxaJoteijrLCni+s9GYhc
   YYGot7NFE97Qs2Q0RRHvp45gFULesyK5lSeK9aEdsvkDDOHYgzPwSajci
   pPKR6hTm1u7yqBrRER1nygi01SKMBDdSGEZY/iK3EWzRCxNMAtwJr/kau
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="285696669"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="285696669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 18:19:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="571323338"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 18:19:26 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 18:19:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 18:19:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 18:19:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POT+CQZE3YzX0TMAHw8dcdgs45CkDNJX+midQYcnwDV4RhJEgs1PMDQb2zqPsBb8s7XF4lxx1Ry/Mr47jCkCgS0KDQJ0uCgxwK9NVXxOfMLdedNPv26MGtRWYIa6GPmTn0wlvJdE4zSfx9mzlL46OoRoGoEpTkKDIMR7r8RU7DPaltsZ7796rOb7n2CNJMDGvF6/lUUmyYWUsjcNWKZ6Cp8AneJnBFrnQRe+b60EgUGJTDDUXnVDhF0bqe7vKSF6sGDh+iJpWHJPRbovLSeUnuNul3Dl/5dQTcqRJtGIgSI5WPUABuUPzngXMPwD/ykI4V6hTmiOW0UQ50iptAlY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwoMhoHwRS/KprBT82l80aNjCPH4iQ9xHqGyDpheJWg=;
 b=WbIiX7xsHfJaD1Kueh6OJJerxxzwbJi6rvge3/gg1ny8kze18xJKdA/Op4yRs8asyZ1d968gq5tdHKQjqPLmrdzCQOkrjnJgmn/5hl3hNg9fDx+DF2tmh6wA9i3XlOjvCyRVfQs52G/LfOE7656rlsltk46Loj5fSieXOJS1UBfT3aMWLoAeSxRh/5IJI72Adx5BHNVMNVVNNHSyqMJc9UG1K0c/Cee7mRBsa+wOG2X2hsgW/Jexcpqo3N7qQUBbE/E5LInX+SS+N8V16puZpFQyjF7kayLjnZ/KWF/w0CF2zic4Sr/PYRScThBV5DksEVXTHzjAA6hMM7xSGogmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5648.namprd11.prod.outlook.com
 (2603:10b6:a03:302::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 15 Jul
 2022 01:19:19 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Fri, 15 Jul
 2022 01:19:19 +0000
Date:   Thu, 14 Jul 2022 18:19:16 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi/nfit: badrange report spill over to clean range
Message-ID: <62d0c0947c3e6_1643dc2944a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220711232658.536064-1-jane.chu@oracle.com>
 <62ce16518e7d3_6070c29447@dwillia2-xfh.jf.intel.com.notmuch>
 <09df842d-d8e4-0594-56b0-b4bb9ea37b67@oracle.com>
 <62cf622a32e1_16b52e294ea@dwillia2-xfh.jf.intel.com.notmuch>
 <8b13446a-65ac-0cbd-6c17-0f9e1cfbb048@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8b13446a-65ac-0cbd-6c17-0f9e1cfbb048@oracle.com>
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08b0b3ba-6904-4f6d-5d5d-08da66000a95
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5648:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nFMnybyfp95o2CMA6D/tZb/UyzE+jmdlFVEZ84fNOu/ARBwD5YQvTCpW1LAVFwLZN0/ZHSVvlrId1/vd1NQ5bZ+X14tEyM1c8RXtREsoEg9XhXN06P/W9b7wMX4qkCMprGzqUjIHFvxE5PFN/zFKLIuHjo5Q08Rzg4RnQ2xY+bfN7zlgLCA1Dm2A/ipDXX2rjoKcYqSOylkraeGLd9G/lsfxepsJ7+smOCHooea/m7jTYtFp+3GCdj6eGhErye+PtqHg6wCIEgokSgCHm3CmfqJ/wl5df7fmUzF3AliuOk847RbATPdmNIp/YQ2udJo1YqHmtW8FERhS/wSAiWV6WKbwCUSqzY7Hk0NtaTzb6QNYUhRquBEA/Pf0uopUbVGlHRRxLkDHozrvai3IC1GPvZox0WotySkNvkXOP623+plr8MBwRzYfy5bCyZsvgnjT+7bgHWPEhOIsEJtYqLcj2m9dIjGut2Cwj7bns82YVOdNimuALjIxzjFVTk78xUHlY5z0eyEG0SySYxagRMg1Pmjhx2vYowP++5ojM52Tu03g22LT8kfQxxK5APEFz54vw4BSbmXp6B1ldApDG8ssiZRxVi2/x96RvMYRVGIPgAhSTCyhiJtvdQPHVwxhFD03qdrDvj6Jm7CK0jfu0Clok31kn78fKVYU6bKu+z3TtmbKnGKCU7FjBBBuzmHQ/a48QXjKy0QquOUMw1ksCOGc/h9HzYEiAF0SISKnO55up/GJP2/KF9TYD8cn9Ugzak+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(136003)(346002)(396003)(316002)(6512007)(8676002)(66476007)(41300700001)(38100700002)(8936002)(6666004)(2906002)(4744005)(26005)(86362001)(478600001)(186003)(66556008)(6486002)(82960400001)(66946007)(5660300002)(110136005)(9686003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkyGGYFi/y0CRXyAhLFGE5hOP7TkIL12OjMTiEmM7d1YydOY31I0Gt/YPWVD?=
 =?us-ascii?Q?ACZqkcYyzsIrTGGaoyAFytAk3g6zas2NJE5LzP7tOivBmMQEsDHJQAO5dBun?=
 =?us-ascii?Q?NpNevyWfE/cJRNtesrOzZE9C+rmLD2PQ4iVGny4nyOFaZbFolAN6Cq0V58SG?=
 =?us-ascii?Q?tMiJrZaEfLHvfWFPh+bXtAzarZEJn1GW1+KjRuyIhRlpbu/V7Aa3UcF3gl9+?=
 =?us-ascii?Q?H8wo31WTnLx6/xWQh9OurfiQJMZprFqzi2SFn5Q2knMXLIA0ObeqicDtsJVz?=
 =?us-ascii?Q?FjCTj1Fd73df+slN4U5fOGrKPxrbLV8Cr4kWcJN1HnqY31KR09tRB76Dw8y1?=
 =?us-ascii?Q?S7tTeOomOuQAS4NFCSLyQC0v81UsFOGr8u5yzPOnU5fa28jdlt677lIE4LQQ?=
 =?us-ascii?Q?nkesH9SpAZtPjMxobPXA6mfp7amF3KHA3/AS2MgvLqJ1vxeqWG9xZ7Kjdpw8?=
 =?us-ascii?Q?5QSBG+HzJNXKpTrpBdeZBl0Lu5Nwfxbxvlivx24fop7dVeAcNPW60jjVF8Cn?=
 =?us-ascii?Q?JJcSrzJhJkctKVAII3YrIR5BABL9nSbVSgZApfwdlZkclzHp2elb1cJHJru3?=
 =?us-ascii?Q?v9KNIedh01HdiV8yg0g1A40DxaqgQyd6dDhUt9Dl4YeCiGjplLt7HyDJUNWf?=
 =?us-ascii?Q?Cn/Rt+qAEJ6JYM3YzXM6/a0CNz5L0DcOOH/awH8OIVV79tXcuTnjLD3mX4zu?=
 =?us-ascii?Q?2wDi+441lkSf+FHSfYvhlnXowQ9rbo68Pc/NrJ7b1UgMpQoZVrzba5A0tFLV?=
 =?us-ascii?Q?11/1dT+AdpMpaiuCAZhK7fNuZwnA77n5wJ+ABZoOUq5b8P6pdwPasBkBXceD?=
 =?us-ascii?Q?2JspnQn5weDEcq+5eaGzioVHD2ldKWN5B3RyOS0KQhPVz3NpNeHdcYSUUAA0?=
 =?us-ascii?Q?HxIDfdRFjMEQnyFpM2vmTxUOiCIO9HtJ+rYu4Qm5A8Tp9Tnc1HL5li44mMI6?=
 =?us-ascii?Q?V3IUuqJNVC4A3zELxn3j9NceFlbwxYAj6imLFcey/at9GTOMxElGvBXPSPd8?=
 =?us-ascii?Q?yzDfYV9YWcTJGqs/4kPihO6lDnNe9iNovU1Oed/OdyCkMgmFSUh+vcMktb5G?=
 =?us-ascii?Q?92ixUY3ePjUy/FPPiKSnLtcHmacZz7IC6kMhigmqsJdvbOVRdjS04FBBcFpe?=
 =?us-ascii?Q?IOIeKwm0E92MZQPMY78ctPylthIrzd3QP3WvxHCS8BfogAr1HEaJ+VkUmdIb?=
 =?us-ascii?Q?ARH2YZK/NDW7D9E6deHAAozaqzl366dwESYuOq8lg+T+JJMeCPcSAK4KFkU0?=
 =?us-ascii?Q?vyY/RL2UcbdE2OGPPxqU3192YnlQ6lgApwhew1wSE+mK4OtwOMNtDCCLX34j?=
 =?us-ascii?Q?Ty8XTxKmnf6Ox3wNdbJCn6yyITSa1ymtDPXnVXTc36fa0lDUCYTrVsvWXqur?=
 =?us-ascii?Q?WZ8BVyvAIKy6S+WUjG/QwD4XAlpzO/8TvuRfrPFM3KFqwUxI8TWeZu3yki2c?=
 =?us-ascii?Q?eLNtNp3gTPDfbaEP/Dv+6k/TNFjvr+LZucUYQJfINfzyUMefre8H0fZhng9q?=
 =?us-ascii?Q?0e7QFcd9hLRT8wujOssbWzOJudFKmeLp0FmiIlIFgLk3X2hghh8GVZJOXLEC?=
 =?us-ascii?Q?1fq1FdZf9dbhHwAvAqqtcZL9ut0uKc0D1FL2DW0kRebftMmE2pOeOfMwQ71F?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b0b3ba-6904-4f6d-5d5d-08da66000a95
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 01:19:19.1659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVOncNNqtWZYlqr5EBTcwFhg+qCJkcfDnfqmuPAxbzpU9iR3+jGyZYxUIXnaUIRnpZ+g5fg3Us6kd8Onldkg9+BPJJZ/aftUOnn9CxFneNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5648
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jane Chu wrote:
> I meant to say there would be 8 calls to the nfit_handle_mce() callback,
> one call for each poison with accurate address.
> 
> Also, short ARS would find 2 poisons.
> 
> I attached the console output, my annotation is prefixed with "<==".

[29078.634817] {4}[Hardware Error]:   physical_address: 0x00000040a0602600		<== 2nd poison @ 0x600
[29078.642200] {4}[Hardware Error]:   physical_address_mask: 0xffffffffffffff00

Why is nfit_handle_mce() seeing a 4K address mask when the CPER record
is seeing a 256-byte address mask?

Sigh, is this "firmware-first" causing the kernel to get bad information
via the native mechanisms?

I would expect that if this test was truly worried about minimizing BIOS
latency it would disable firmware-first error reporting. I wonder if
that fixes the observed problem?
