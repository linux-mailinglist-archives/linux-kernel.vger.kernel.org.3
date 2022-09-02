Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F715AA634
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiIBDQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiIBDQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:16:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6CB422D8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662088561; x=1693624561;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TLkvSCc4RnghFi6I0ecaHZqlwzImFpFVsdwbELCN4tQ=;
  b=VJ2RGzCFgFKY9ib7ooug8rvzN6LQHsTVJKUld3AAICWapv5Comr7D8Qw
   NlDcrI7XKYJ8jvS51Pww4oabyM44yy+TRREbudWk0XE+/UZ/d0bGMA0k/
   HVadzcpJ7oI+I/p/fpAM0lN5kKrlj6vzwaIffhG8d5mKK8+hQ2e8gGRiA
   oMHuSRmsM2Jep3ujHlmne+SYbih5toSk4tROVdd0X90e8i9mxYFhxeSn8
   M9SSJH/nwWlNPUkYXS+xqW8QDZP15cz4v3Xl/eeGFXF+JIPkWxHRS3JvL
   KvWVrV7Qp5H0oJSqLdxiti5KPjeFtN2TL5SUdunnNItOSkSBSe/5YmYtw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="357599454"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="357599454"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 20:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="701985781"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Sep 2022 20:16:00 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 20:16:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 20:16:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 20:16:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 20:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XP/QOzem5qJEGol96BklPJOI5uHlMcRsw6wmGwI9BT0r0YXKOSuUpFzbjMzeJWZTDfvczREPiZkIkvPlqXsBzHBtMeNg/iDfJlpvTzT/m+KnWudkPoqIL006rHwOUSPVKZA1vPt8AlVXHJfbngyBUrbEmIuUzmSxXYBkpTkifK0tAgI8GYhn/+miQzO58G8ohA2ukAq9obCxNkQ3b1KUdJQJC5MTCu14kknkMlBWnXu+Dh7xyP17//O71TjrUZr1beXeB64mHRYTnyQp8jcZ2TM0MJemaO+zAjw2LuDJzHpmIq2b1xo14VwbxupPt0msuimnnpsu7vqhf4DjLhnFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZQhVBqaOVmJ+C13EMY8H8VbJ+lBSDeq+lWDdhb2n38=;
 b=igFy2Dh8gHiwLAMwGQhogW34cCiudHxIWKH2dz4qIQrMQN5gX2+Fu8u8zgraJzeePEwdDmNJFUMw7B6KdGNaOknmesdRC4Qlrb5mlb0V9oTJYVaW5exIJE+ajkxFC5uDXHGdrQOhWdgZV7uovsNxpYHFZIUs5KXf+Q+czZvVra0mHJL+5oujLo6b6olHdpR9wm2tnsLhoRkVf+q1ijXlFSbal+Bop79ggCdZntReb/2gDrgpARa3SjZxdZTaV8TR0NN1QjS8ejI2F89JvK1XDX9PjtlNpMjGeUn3uZcvOs10GZyO/vydCGHZ+geHJpP3bCT6L9gxcXEyhDzdATpYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB3933.namprd11.prod.outlook.com (2603:10b6:208:13d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 2 Sep
 2022 03:15:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0%6]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 03:15:57 +0000
Date:   Thu, 1 Sep 2022 20:15:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@intel.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH 0/3] Print CPU at segfault time
Message-ID: <YxF1afJ8oEr6KAA9@iweiny-mobl>
References: <20220811024903.178925-1-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220811024903.178925-1-ira.weiny@intel.com>
X-ClientProxiedBy: BYAPR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::48) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6badefe3-055b-4d9d-6eec-08da8c917437
X-MS-TrafficTypeDiagnostic: MN2PR11MB3933:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKYrShvnQ90VzTQMSvPn+o/Z6X0IRnWjQONckok0v1wWC5MIJUJnoO2ry5W4hquf8UByUXRCuXUBajKJZcux0MmVV9MGx+aVLondIyWmvOIbr1VVbpUneNsutE5Iv/RW9l/dFv1yUMb3mDy8fS3NuKejeZ+uxrXUPIrxlbJx/cytqakkqibs6Adihw3lvgDcGfDdqYi/oCy3D4pweGhlpWdgNm1q72l40O0htsByGy+0uU46+VPYksmcgJ58OXGsbJCtru53r0XvLGr7PXi9tjeuZ7krhDLKzj+W3WiovwDeH8aEEmL/IxR7y38BvLlz74uQb0bZ8o3mym2djYyHSWVJ2nIZYK9z4PXEQYMX2C4WooSAwMNDYAZ7JlwRyu6nBUamtMB4Hq6DyEC0TOb27Se8HgJ+V18lIs45OaLttJC+DlUxGcqnyxNWeIPP0oxtgQL6tUrxDFrMZoCTEra2IRilmTsZszPsBFt+uPt6dPqvX1Bcn9+5kUVJnn1XxuYddh5pqv/Q8ZTsQAIFLE4AnICo5XxLttXyTMJRvXu6KBJF9LE4WocmwumpZA7qqrbXIyp3e/tIvKjyxsUrHiMZUX5C6JkWbc191SKrD2CUIaGPCZk90rawp+9KxeeDmMXLwOV8Bkyh52tqLZjryILVXpTghM6nnq8AbSjLM9cOzL2ul6cXNpJoxj+/LxUY9LcDPUxkE9ZSslL9b7zH3ffIZdcAJwWbIJr7aHPqQVnXI0cbqXAzS8w2MZDHC5n0mugVdXASSwl/tdRSaJXvY7V8xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(316002)(66556008)(110136005)(66476007)(478600001)(6636002)(33716001)(82960400001)(8676002)(66946007)(4326008)(966005)(6486002)(38100700002)(8936002)(41300700001)(5660300002)(83380400001)(2906002)(6506007)(6666004)(86362001)(26005)(9686003)(6512007)(44832011)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7qO6FWpLFcKq0ZkuRS2/XBcjRCohILgrMGQuVLhePelzoYOeJA7lUx5y1Xl8?=
 =?us-ascii?Q?Eb7PmoedSvRRRL45iwXvtw6URkYogMf2QhuE18Mcb2BwrkW3bcqV/bxetNHJ?=
 =?us-ascii?Q?gJKg10bzwued0NtdAp+USDGoehhCqoST1teIR4gh0TS6PfSwD/MQS1RenYP5?=
 =?us-ascii?Q?Q3cL6zw7qp4YElV7su/rmaMXmMQLbuAPzVrNBEtKFeev/fvzHE13fU/ozFr8?=
 =?us-ascii?Q?XbtV/TVat2ET4hOZfQCpqbtRerFosvPJ7xAFcaHS6SnDte66zN+iskyNJznf?=
 =?us-ascii?Q?FcvCujOVbHDe32CH2Pl92e+T/U0N/tnv+l+DljNXlveZ7krF5lSIz1HNQPDl?=
 =?us-ascii?Q?e1IAWDurMea89Q6tvRGk7MuYd6rRWCcY/tuskC5TtjAF7cnm2c7BTvNv8m1a?=
 =?us-ascii?Q?iaC3SwBe8BUVJtv6qoz0iaMVADve5AgRZt2t3eR3SGNCjrtCR4INMqyW2U9V?=
 =?us-ascii?Q?lvrrRc0HFraaNlUX8RLhwN2GbrjOGhGANtUXgLmZRzgkLuWG51UpBubu/DXX?=
 =?us-ascii?Q?vGIVh/lDesHnNG7WlCWKq49NoMVCd/pZu3BpvaP6RZ9BSCFsulyTUOilBrl8?=
 =?us-ascii?Q?jf5ez+JGvxPaLbcj9R52VofVMBBy+gJLM29J0PSOBSYxkeFOWs84DOoFHElp?=
 =?us-ascii?Q?UlI7l2ORlIKk61CS5DlAzzls5R91UHP8B8ERHK/xY194d/MkYZUdvpR6OS5U?=
 =?us-ascii?Q?16jAHiIg5mEKAE95bwdTx5QUHzK6nAI1w9NObghsL+eQKCn1mbGBPI8PPlTX?=
 =?us-ascii?Q?QXjkQV/OH0rTkE9o67zFUQ6fPggAiJdIDn5zs4M8tCnlsDcC/DGutFLBz7Qf?=
 =?us-ascii?Q?/cS6tjNZEdtDXX+dJpWMT8WMidq3xTJWxN9VIhb6OK2VSe7XJtFdv4fqAXxy?=
 =?us-ascii?Q?P+e5C4rz+tPGLv8WCr1eWnnAkY2w9dNly/Mzq3XT2oQhhgTc6BvXtKOMlD4T?=
 =?us-ascii?Q?DR8lPX2VwzPBWn62npPma1Q5z/cGjaOoP3ft9Z5Ph3V6ny2lujBBmucVIr41?=
 =?us-ascii?Q?AgAs7U5+KmJBsa7WQQu0TmodLCVDJNt5Twcwpva749LGjYBKO4TToFxMoKm5?=
 =?us-ascii?Q?loyvKRAzrANejtRK6xRg6Mum38w0vSZPwZ+tlupTSBlUrN4P1fwVpDrejGCS?=
 =?us-ascii?Q?TYHEweoR+k1H0bIFeV1iC/bygnVEjtUsirXcjT/KSMa2Wc4GqcrLobXddTrk?=
 =?us-ascii?Q?RyJwwvI3uAevIx7HoFpKZvJ8KL2v0mNAh6eesFmmJ7pXVHk2eTasO438X64W?=
 =?us-ascii?Q?W27F70/QIYSV4NzNT6H5thPSthkwecnYK36SraW8qqJHvcvnrJIYdjdDvu6i?=
 =?us-ascii?Q?kUShkXyPYIWJuhLBIbA9rr6N40u0sAL8F7M2Kq9cRxyvVbiRSjaWfEx+c1jR?=
 =?us-ascii?Q?hvGWrxWDYvmU5F3q7ofRj+V2iHtKvC1752WwDJJCrXCNfERU/9DDuuHb/9tn?=
 =?us-ascii?Q?n++AyRFljAT1F/IIBDP/ztqjRWlIo2e8+9BjHHBLuJXUxMevTt3CzDezAGWD?=
 =?us-ascii?Q?4RjJ3Fae6ACP5WgRG2uR95Dg9u0Je9JBehgw754k5tZ1kR2KkqvnYlV/yEWd?=
 =?us-ascii?Q?KAiJfViT4nPeab5SreGERQgV197fWg60ErQerh59?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6badefe3-055b-4d9d-6eec-08da8c917437
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 03:15:57.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqO9IQQ2m0egHQDaInRVC+f1YO54RIJZTYop4GEjOR3o4aZF+mynAxuxbNbIwqWp+TyTaFuTAqgdTRu4ZZGbow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3933
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

On Wed, Aug 10, 2022 at 07:49:00PM -0700, Ira wrote:
> From: Ira Weiny <ira.weiny@intel.com>

Any feedback on this series?  Or has Rik's patches been accepted instead?

Ira

> 
> Changes from RFC:
> 	Drop patch 1 as I misunderstood the code and it is not needed for this
> 		use case
> 	Combine patch 2 and 5 into a patch 3 which stores the CPU only for page
> 		faults
> 
> Rik reported that the knowledge of which CPU's are seeing faults can help in
> determining which CPUs are failing in a large data center.[1]
> 
> Storing the CPU at exception entry time allows this print to report the CPU
> which actually took the exception.  This still may not be the CPU which is
> failing but it should be closer.
> 
> Dave and Boris recognized that the auxiliary pt_regs work I did for the PKS
> series could help to store this value and avoid passing the CPU throughout the
> fault handler call stack.
> 
> The patches I sent for RFC had a lot more overhead than is needed to report the
> CPU in a page fault.[2]  After the discussions the generic save/restore of the
> auxiliary pt_regs is overkill for the current use case.  Skip that overhead and
> only store the CPU in the page fault path.
> 
> [1] https://lore.kernel.org/all/20220805101644.2e674553@imladris.surriel.com/
> [2] https://lore.kernel.org/lkml/20220805173009.3128098-1-ira.weiny@intel.com/
> 
> Ira Weiny (2):
>   x86/entry: Add auxiliary pt_regs space
>   x86/mm: Store CPU info on exception entry
> 
> Rik van Riel (1):
>   x86,mm: print likely CPU at segfault time
> 
>  arch/x86/Kconfig                 |  4 ++++
>  arch/x86/entry/calling.h         | 19 +++++++++++++++++++
>  arch/x86/entry/entry_64.S        | 22 ++++++++++++++++++++++
>  arch/x86/entry/entry_64_compat.S |  6 ++++++
>  arch/x86/include/asm/ptrace.h    | 19 +++++++++++++++++++
>  arch/x86/kernel/asm-offsets_64.c | 15 +++++++++++++++
>  arch/x86/kernel/head_64.S        |  6 ++++++
>  arch/x86/mm/fault.c              | 18 ++++++++++++++++++
>  8 files changed, 109 insertions(+)
> 
> 
> base-commit: d4252071b97d2027d246f6a82cbee4d52f618b47
> -- 
> 2.35.3
> 
