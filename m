Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836E350A69A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390573AbiDURKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390553AbiDURKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:10:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C37483B7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650560864; x=1682096864;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+9L3WgZMQo1Nom2YGiXL5Myl33J0x5MH/35OjmV4aj4=;
  b=I6Mlx6E6dv3L6bh2DX0Lx9GnBvIkXj9gKosaZxJKtaOWLRPnvEyZe/8I
   yd4coBkokAqPX4DCtzOt0QrkyUSJiy7BRzVDxgKWm9ithcWtW46ee+TXe
   tJYeKaeHSESUb0aq5n5dV33frBcUmTfmUqlkGA8kP018xyyE3bPRO+X5v
   +6JHqdQTBQiX5HDu+uvxPa/8DPv2hpXPZ6uFRgstv2IvGkj0hYgVXbD8x
   ObDq/mGBJaWrUz0m8dFIyMLSPSZkYuYTxAdgykXItvhZByDO8kjC0utdc
   ryuvnmrliN55zq09WE7g7hjlo/4Y9d0bRpSsI59L6tsvk/6pmW3DSt64k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263887888"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="263887888"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 10:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="533470446"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2022 10:07:32 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 10:07:32 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 10:07:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 10:07:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 10:07:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBbIChO8a9HZyjO8Huf/CnJT7ELtuMZ5rvmcFndnt7DD3ZzT/4gvsGTIGgp8pg0NroaH8Ic5qCsC6mbCLueS6BolUgP/QzGu3z79VnIKZ4DR84pxMKu1MaYcBUsdvnD+qBh4mow9RoA4z5MDwKGH8lKhV3SIBn+zo2ZuI0fbM07HAYv+W/Wg3Udq1D7bmKr7VPFlJ/IbncX6JKTi1rJwudoKytjSPXiKj+uZZwVOZvDluMFePmVOoT4B09VyEK/eC9tvhs63Mt1AjBCdMc2U/kXAuPMyQdI0L9cC7E+JrTkF3SoC7Ue4v5k7u7TVqcDjqA1wfn/7WSMkkSDv9kO1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K70Ig/nb8ouhYXj3VXO0HS8QdEHj9VRyji/VcsTOIY=;
 b=VkM20EXtx7gxfu18M8OSKUuVi8P1GmUyHsv2P4TF1uLiIAV3dAZCZsIp9zlxv9KFLHrSR0iB81mNZZ8Zp6ZZvordqJKkJah2dFCTO71+oUWZT4/BupEhRenO5hDkP2rXUmVQiue4A5OsjUmgUlaQED9rUTcr/6+2aVJk1hJ7hTEP1ZXrwxJ4j6tQJYsYjEA4EgGpDcNyoeAvJOQK46JHdAmNvLik5VHrPFeHwiDbk+an9BURykrk1VVCud/Fgt/h+a2QJz5jyub8mSif6MX9VMcEqoJXHxwMHncfAJm8HixcHWKGx2zaLlThfsSHn5l8oLhc6dUJ92hoMTbPEVRF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM6PR11MB3468.namprd11.prod.outlook.com (2603:10b6:5:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Thu, 21 Apr
 2022 17:07:29 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5164.028; Thu, 21 Apr 2022
 17:07:29 +0000
Message-ID: <dd27add0-fb45-9b99-6ecd-84c4b3b28ef8@intel.com>
Date:   Thu, 21 Apr 2022 10:07:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v4 4/8] firmware_loader: Add firmware-upload support
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kbuild-all@lists.01.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>
References: <20220419231658.664388-5-russell.h.weight@intel.com>
 <202204201956.1mdJkUkr-lkp@intel.com>
 <YmGKZtdKqtNg1flU@bombadil.infradead.org>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <YmGKZtdKqtNg1flU@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:303:83::7) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5019d6a4-cdd1-4653-037e-08da23b96ae7
X-MS-TrafficTypeDiagnostic: DM6PR11MB3468:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB3468F2597B7BCF174DD67965C5F49@DM6PR11MB3468.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4v4riOytLAUJSqK22OVYm6p137ko6wmPv+pzP33065ESP5LA7T1Z8kvdNfH2dbeyBQPLzKkBtz6zBRTs2jhfjBJ8ZFneWvLFMo7oYRcmDtXbCwOnAEdx8/6K4jUGS7ufYWnWc+8q6fumJbGPuPi8k55myZuKtCoUEVx/9ZaJkqP30OXyvd/NknvA9Sb4EuiC1qilbiwYsB2hSbn/64+sEmWsPjNUzKsPLhsIix8B3OsDadVtMQP7trGYSdG0SnwagEZqWgdLYSQ1JLJ8Iw4ElFuxRpnAlEEcsBQq7BOLLdoQ0KD4prjmF6gdevWapK4r/R7Z0CYOllPj23LPvvBsM98CHuT1siQzDNi41x6JqV5zYFeSH4VhMXkUXNwoZ5o82IpGw03Jqy1/uIaZ9cBkCMYRjTGgQ13Q1n5+3j57FuaQ+o3YK4+so0NGc1MBA0E8OT4jsY64hw4U186pR0lpF80FA/xX3YOHJfSb/CVEJYVNfZH9gSXCsG1jQmu1FrWKdxnMk5kH3v8P+NtdJaRIKXWqaaR10Rum9MiuG1lFlEpb5QMu1Be9B6wREnfWEwefoiVYrZzegkT1XRUbH0sfIskPLh0CDHYvCo9Imq6zeW/7roo+vuBFpIrsfrFfFXZLPjkAU/IMCDI9SBwHbJprASRc4jXUIBjMwk8kDCnEDKZFm2drG4dNDHACMGYy0/xh5hOQwAGsm5Pdrl3lKwQul6mRVaG0XRcqsnDjTfWjaDMqt/ISlUW1SomMR4mD3zW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(558084003)(2616005)(26005)(186003)(6512007)(53546011)(82960400001)(6486002)(31696002)(38100700002)(508600001)(66946007)(86362001)(66556008)(66476007)(316002)(4326008)(8936002)(6916009)(8676002)(2906002)(31686004)(36756003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNtMVVZT1cyQjk2dFo5QXYyZ3VWNkI2VmdPZE9WZ3hVaGpvKzFjemxqZUdZ?=
 =?utf-8?B?ajZFZFlKU3NrbkkwbElGM3pSbzZXSUtINWtaSHN4bzlxL05zUkdqZUg2Y0Nu?=
 =?utf-8?B?MGRXdTBEVmVscTJMRnkzTHA4T2lwcjNkd3FhT0NZOWxRNEdOcDhlblhuN2hM?=
 =?utf-8?B?djRQSXBlQVZPODFDbDVXR0p0d3JIOTBWSnowRmRzM25wNTU0ODVSZ29pU0R1?=
 =?utf-8?B?MkZNWUdtU29LM2hHd0NzNzZ6Q2pHdGc1UnJZbmFZeTZmUlFYdGM1TUF4L3RO?=
 =?utf-8?B?MGZEV29LK1FTb1JLN2RLWjBZdmNoUjJ0S2RqMjU1ZFZUUXRROXJmclRab2d4?=
 =?utf-8?B?Y2U4N3dodXA5bUtKY2dmL2gvN1hpVWhVSjdYVVVrTyt6dkRYSjFEakZKd0xh?=
 =?utf-8?B?WWlMaXBkczJKVTAzTWdZdS9SaUx4SmFQWFlGMTRZQ3E3NGVvTU5Za1A5RlRr?=
 =?utf-8?B?NFcvYmNNSnd4dXFRVkg4dTA2U05WOExlbEIvVnFPdDgyaVVLNFlscXNRNTU3?=
 =?utf-8?B?SDh1NjN2YW5sQ1Z6K2Jua3FEUndJL0NtUGtNbE5xM0p1ektmRjB3SXBhVHdE?=
 =?utf-8?B?Y1VDQmp6UTVQbjNuWXRYT0xUUEhxbWJNMC9mdHB3aDl4MWUyeWI1NDk0VVla?=
 =?utf-8?B?MW9BM2FzSm41SnVlWkdNS1B3VmFUN3J2K1ZaVTkvQ3RBTFNxTXJUWFJqZUlM?=
 =?utf-8?B?d1RlSmZtOXJhZ25kQ1FURitaYkdTeFhLdXM5RDQ5cnMzL3VDNUE0T0RmQVRR?=
 =?utf-8?B?RFBPUWoyamVUd1JIclBXZWFwbDZ3bmU5Q2hMY1pBK0pxUXp3MFpwa20xWkFr?=
 =?utf-8?B?eHFLekZYQzFkMFJhQ2JzLzRaL254Qmk4bndGRjVDdUg3NVVVUnBFVHFSTWdX?=
 =?utf-8?B?TXMzU0hRUXA0cGFlMUtGMU0veXl4REJmRDZQUU1MellnWlgrL1cwNTJ2YzRr?=
 =?utf-8?B?ajV3UEhYd0ZSNTIrU2x2bWxjTjI4Ni8wU2h5SDA5R3hBaTQ0QjFzY0RtSldZ?=
 =?utf-8?B?VHYzdUFjU2dlRVY2di9LaTUxS0pQVE8va1N1VWd6SWJqVVpnYTl5Um1pVkdO?=
 =?utf-8?B?TTNCMTJnMGpVL0NlU0FqVi9ORkVvUWFNNDdObGNPSGVoUEU2dVdpdmNOUncw?=
 =?utf-8?B?Z2M3U2ExYXBjcXZSVEZOUWxtSU5aSTlncU83REU2Q2Q5R050VEFSVzA5ZWl3?=
 =?utf-8?B?c09OMHBWVEtzYzZQTnJ3Yk5tZjRRSy9SaEpLamlSNDY1d0c1SDFReks5dk93?=
 =?utf-8?B?RVFISXNLUmhWQ1orb3l0VzQ5RU1xTFgxVWp5aFdlUklUOWFiZDd0QnVvM2dp?=
 =?utf-8?B?WndZMkJNR1pLMG1qc0lZekZ6eUg0V052REFUUTBtVW9wZ1RLNlV1c3FDSXgw?=
 =?utf-8?B?UkV1aldVOE9oalJWNkQwSDhtNE5XYlZkb25UYzc5R3ZSQjlFSUVETWFxbEM0?=
 =?utf-8?B?b0lLTGFsb0pkWjhTYXZGWTVmZUs0YjJnSzV4NWhHdkN3TFd4MXVKSjd4cFM3?=
 =?utf-8?B?ait1ektDYW1LdDBPRXBFNy9OUEg3UmJjUFFhTVNpR1pYc09ieWk1NFRiWVZ1?=
 =?utf-8?B?THpuUFJEeWU1NXphcXhrNWozVDZhVXNJalhHaHI3eCtsVHpzdnVxRzJ0OElY?=
 =?utf-8?B?b0FSK1JwTTV4eXVvV3ZDQXJQYTJxQVFvUE5yVG5CSjVMRURnUWNrdXNiektV?=
 =?utf-8?B?OXdYOGsrTktQb2NNYnhud3BXcm1KRksyTzcvaDVBRkRvQjVqNkg2YlJNQUlX?=
 =?utf-8?B?b29xVjVxZmhpVThnc1h3NXNYVlVPdHUzSHI1Y2dvY2tsWVBJNEk0ZWdmSVZy?=
 =?utf-8?B?UXY0QmxlUURobGJUSlRQVVhKY1hZa0tIMnBhMHZxRXdwalNUVlB5WnNQVnZT?=
 =?utf-8?B?M01MdVZaUC9TWEhnZ2Z3ZTV1ck1xVVhadzE4QjhGblMzOTNqbGxHZEFtNXB6?=
 =?utf-8?B?VzBBbU5jVjNjYmJXbVNDR0g5dFUwNldFSnlUbjBrTVAvd0krMXhVRDRMRDc0?=
 =?utf-8?B?VlJ2UFJCNTRHQmhlWUJTcDRUenoxQlJ3TTNYQzJWVnZaU3BBZk92TXdubjVx?=
 =?utf-8?B?S3FzZzdJeFJ1ODlsYjNUMGZGa0VIQTU4ZlI3bjhLVVpXYlE0dUxsdUNvSUZY?=
 =?utf-8?B?ckV4ZlJ5Z2xHelpSSTZPQUZlNi9yUkJIbU9DOEp2RU9XeGc4Rlc0eEk3RUZW?=
 =?utf-8?B?SUNmZ1IwZlNFeE05MFJyRHE3TmdCbXNEZDZnNjhMK2p6TlE0bXArUGdoRm1B?=
 =?utf-8?B?MCt2WlFXOE85ODN4TkRLdmNOSXlSQS9kYnAyOXVkL3IyS054NDNiMTdjTGdi?=
 =?utf-8?B?ZExiQ1dLYzYvd1BJTldTM1ArLzJhdm5QR1h6aHVkVllXcS8yajZ6bDgyZ1lm?=
 =?utf-8?Q?2loskVqY+JRudONU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5019d6a4-cdd1-4653-037e-08da23b96ae7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:07:29.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqSmT+LQKZZNcALMsBAyVArP6yy5QEoWRoaP7bE8V51ivsv814ylZ5OyAOkHZYddBK46znvu+P04G/rQFCqaJQHmJ25u7n/nmSKAvevJ4iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3468
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 09:46, Luis Chamberlain wrote:
> On Thu, Apr 21, 2022 at 02:32:00PM +0800, kernel test robot wrote:
>> Hi Russ,
> Russ, can you fix this with a new set?
>
>   Luis
Yes - I'll take care of it.

- Russ
