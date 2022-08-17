Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881F6596E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiHQMMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiHQMM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:12:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7756883F4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660738346; x=1692274346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rv0ydixdIY8tuYR003KurvLYm3N3u5LUO2dFoiHMJWE=;
  b=mPiuejQTi/tDSjkQjazkzPO6B0w4DUOu0lLbLKczRaZD9RV+5OcDPO+F
   toXuyUxe8u24fX5yVYkz35AEJkRv/qFdr2KLiwf6ENfczdjAcBcmV4eBR
   MSOjynuZWdvLUuj/PxWyvbfhr52OvWy9/+XAE8HU6hcZgd0c0dIuv9wHb
   uBldCgDsbad6QMa5BZ0zhasPkf2TuDgCOltbqoQtPPqqrIfJtqEWPDOrQ
   sJLg3LiorY8iGxvV+u3DFeXRXFqhyQuJOh7U/UaQOLuEcQEj00z8pKuxT
   kehz1UDxuq2l77u4fKk/kpcmp2UfFvhUCD4xLKEV9MLeZOLQIAPyE8woY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="292472146"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="292472146"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="675620559"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2022 05:12:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 05:12:25 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 05:12:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 05:12:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 05:12:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdHo3bKTyikFbbXRysHAyU/xK+Sx4KKfdp3tDASrA+1s1Ng/9pybGijGkoZC60q5dEAbhkuxdtyWkohUcT/zLP76Cs/IZq6saWr6/03eCntLP7yMCb0jBPqgJAnuM5ZAsQhecAu01PwU7kn5TVwvOjshL/KnHrpMfUTN7rFq9kbzRtC5T71a/S2MhnYzH4iglHlDVed/9DUyn+tKjc0apZrekLLPzRcL7AHZ2FZEsTBQIserVYwRC2qNs0Rm+Gi2NlkGCZnPpg2zgWXnABHKjG3tqaa8Qp2ObvYrYtdh9lwi0ruonQWthzOIxvGQyrgQ7qgsDlE2LQ+LzGRxXCkPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmvFKPA7r4RmXxbJchaJ4uuLQ0XhqrfxH6YSfl+Ixtk=;
 b=cPGr7q/0lnl70Gy/I04T0AI7P90FQHSH0I1CXk6r6OWqAyrRaz0IQo/vCoonDK14oYhIL+CH7IqTkNpnTFPhGNsePfLlXI//IxB7sxZKYrI1+r1FsAPfjvBStAdHO10gGjRJSeYtQFiHyzrecBlhnKb1pDZGkBvjTwzoMDQTrAa5m4mNalDQx75IftS5BDSSirqMJzZLLlnxlBSRg7jpQ1gPR2PHJpcDzKO6gO7C/ZKR59nftlXx7LyZ1h24aUI7UW2cybrXh1JSh5b8QRWHKyTP4+BVmRzT+/mUxOrJItDqUVwpu4XWMk/xgdO+SWIea2BtlUmrTaD7npGmogUlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SN7PR11MB6826.namprd11.prod.outlook.com (2603:10b6:806:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Wed, 17 Aug
 2022 12:12:23 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%6]) with mapi id 15.20.5525.017; Wed, 17 Aug 2022
 12:12:23 +0000
Date:   Wed, 17 Aug 2022 12:12:05 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ashok Raj <ashok_raj@linux.intel.com>, X86 ML <x86@kernel.org>,
        "Andrew Cooper" <amc96@srcf.net>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?=C8=98tefan?= Talpalaru <stefantalpalaru@yahoo.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode/AMD: Attempt applying on every logical
 thread
Message-ID: <YvzbFXnBjNjK+UJK@araj-dh-work>
References: <20220814120026.16118-1-bp@alien8.de>
 <YvtcGEHX8eSFpALX@araj-dh-work>
 <YvuQgx698T5cgF+C@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvuQgx698T5cgF+C@zn.tnic>
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68b4b688-aaac-433b-135e-08da8049bdb8
X-MS-TrafficTypeDiagnostic: SN7PR11MB6826:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAf8xZkWngojqUDd3BvpEt/uVMwITgQtzbbXEdVAlRRCoXsRvX9UlFcccY1EFtMxwcL1vWSEY2ecpqRwlils432NR2gWcZAraee5TR/Z1AmEuTv35NqES21nR8ph3S8ByoyZbd77VIte179W9YDs8L74fO+BeBDjBz9HlujWwKRS5qC9QATR1PTAHQ8x0QIJ03yWnG5GBQTEU/ZBdf91V/NgYKf0DqetftQZdw44p/M2OUQ+5PVedZTf/VYh9h6LQLlH6HugkH0q+NWsoYVMAS9fWKEKvLeJd32UiSEp4EGizCaNNS2MT1VbZ5r25kECRc9m4MNI94WoKd3l5//2Esgt2MnkgvFy6T7VnK0VEeZ1JuDVa/Lp8YcGrTXw0wW9+MycGSImHveIzE/5UPI/evAxsZI0UK38ZWSrZB8Rry2C7Yn4CjUACidahNM3WdrAAd0MTFLRBVgKlS1QqY164JOnpY6Zn3qTCK/WI+5V3cDFSFAwG8lDBenVifmGncQcpialziJHAEv7MGuYKfy6eIm6X8ax5gd3p+k2QVQt2VtmXsk8JEaLNDwoB4T7sJSkcKXcQqEBmvEzvnoa+fMqY2FnymxsiUvBt1lPhTRNlHfRTSfQdEbODqjZCiAjPJgOp3j+n/1KBo7nwfQGEXN69gKBfAjb6b0FwWvMvjHsVu890FkyUQgc1Wfs6lOm/+2NcPKNYpieMVaeQtTE0pIJilt0PjW8vIC1w56eKlgR3Hd/pcjsVlwWBsj2oiMxlw+658G0G2CqpTfLTYiNT8vFzG3lBPXuB1qEPDDZfmRvwD3WJ/wjHxvkI+g399gKFBAM7VnszDcWaOrtXW8dl9Do3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(136003)(376002)(396003)(346002)(44832011)(33716001)(2906002)(66556008)(66476007)(4326008)(66946007)(54906003)(966005)(6916009)(8676002)(478600001)(6486002)(316002)(186003)(38100700002)(6506007)(6666004)(86362001)(6512007)(26005)(9686003)(8936002)(82960400001)(5660300002)(41300700001)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oB53ieemQ6UsRj/Tx8KSOlzrj21PiEGGlj47n/al12CkzcD+qdWSvEHkt01X?=
 =?us-ascii?Q?3MPAADGn8bHqX573gHMV/eSlX+AVSwMYJx3hC9Py1o4PveUvCNrm/D+I/rSK?=
 =?us-ascii?Q?B3eR182j2DPQt1EJyfBgfe1hkwF00pcwaKFBGmeylN93vAEQ7lfIPbQJfq/0?=
 =?us-ascii?Q?1Js0GFY6fcrvfu9kbjrEmK87XnREh1nvIs43DSYYOYgF74w7jD5cBnKFA8Y1?=
 =?us-ascii?Q?oKUVlhZO81tjGyDHiU3KwW2yAlikMZw35Vq5MvERK43slk8cgH4Gd8GaM6mU?=
 =?us-ascii?Q?DDtUlZfTN4MH4YBtJd0JvqIMJQeoYszXxxlI54HY4rzKP8+O6vo/06AnUtty?=
 =?us-ascii?Q?vOAaheaqIB3uZr8VJNMlz0RoPbD+Ea5DADfxofdFpCWvWdyFz+ZS48HesrcO?=
 =?us-ascii?Q?bWFAnXrOrNKazDFrhAKStYjEm2KIWahm8BJwSzIldVuMtLL5HgUiH4kK6eUp?=
 =?us-ascii?Q?EfB4k/iD7rDTf/jP3z1IUw83OvYciBGkIqlALQ5TOwQd+QHNeTNe9JmYnLWL?=
 =?us-ascii?Q?sztNnRGw8bEL7uxcV+P4t/A3uFPtm3EtroO93M3n0Uvffqia4m71/FuWuOsS?=
 =?us-ascii?Q?ZfAfhrTo9m2t+MdKzX+2wJ8ZG2ilVbhw9jy4p9hS3JJ+1LISOMMNmBAacOeM?=
 =?us-ascii?Q?y8n3rTcYbR4fh0R1uPOhT4KUmYK0+Th0JSYxzr79J2Fb6XrTFZtMvWAem2Ga?=
 =?us-ascii?Q?PkweE8c9db+TEUckJQCkbU8u1FfMkt7haDejT2PX25S0dsXBfSn0L1wm2BXj?=
 =?us-ascii?Q?WiMGOQFLTB2NlvtQRGy/kfyBMxW6xZBT9yEJqwWZg9JTLV7HFW5rrDzT7gr1?=
 =?us-ascii?Q?cYWY+K1Nc3xAuPkAxyZHnVJjGZzZl0vmRA5JgrjTS8GdHiJTr36DKq7kaMYF?=
 =?us-ascii?Q?PVbM/3Z4NKvT5m1byuOUq1OrDXr9fPR4VWy7wujILXwFOqde96xXjB/KlwFi?=
 =?us-ascii?Q?xCLh4TK6MaE41lZDSK7W2Ib3jQBHhddQbKkfI9WJQ7BsLP1DDXEjIzHXZHFI?=
 =?us-ascii?Q?PXGe4ZQkyOO72URMJDZNGWirVpURUIUj/ICGYsGsHwv6dMH93siXdvQnJd45?=
 =?us-ascii?Q?z4s3LNJH1xTZ8DL9kslrsfy8GqrpD3XTPvs/2rDGG1ZXoX2GHsETtzw8HI7B?=
 =?us-ascii?Q?fIZryZKBVZBvzE/inW+1DpcJpY3gNXo3YsDpmq0NVz3qm5W/Oz0s2pw+jWaU?=
 =?us-ascii?Q?pJE8ywLaqwkgrWnddIxjQSsuXJbULKxLrVcjz7j3TVmC7xpTB6zURxMj6GbX?=
 =?us-ascii?Q?2hbaXFW69/qk3emHh8iAeLpvZ28cwsZ1NdaJnoVTHwb5ZMDX218veQt8CYSa?=
 =?us-ascii?Q?tjRMM885B648pRhOi4XMGWlr2f0J2JYY+VwX8pnl9UdSlnqn2bEnzGK4MTHX?=
 =?us-ascii?Q?USTS7SLyP3FKK9RdPzoROLC5fqhhE76cbAYvYOKdpl3dGyynebHVf/4p3o3a?=
 =?us-ascii?Q?QtxE37dKmqL3YW4ZM2+rxRodD525P4AcPdQQSWQL4B9svqTQVIBU8CFiJ3lm?=
 =?us-ascii?Q?REZ3TEtBQBHOPNR+OOqxvi9V418LOfRTC3z0KLIUyP+VcxTAzWnOV7oPbLhV?=
 =?us-ascii?Q?lffFy/yzwpXtYu4G5HZ72fksans6G8EgFY/6VeBqMdMI6tCEsg6WkCxnKovH?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b4b688-aaac-433b-135e-08da8049bdb8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 12:12:23.1521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uml8lFRndS61Ghy/NfMt1EnOEarVwZp6Hr0ggWborDKGT0v/X+B4wibaogCQVNfqykO3E8HwbYL+FgB3f+JdnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6826
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

On Tue, Aug 16, 2022 at 02:41:39PM +0200, Borislav Petkov wrote:
> On Tue, Aug 16, 2022 at 09:00:14AM +0000, Ashok Raj wrote:
> > A re-application means, you want to apply even if the cpu_rev <= patch.rev
> 
> Yes.
> 
> > if cpu_rev is > patch_rev, clearly its ahead?. say BIOS has a newer
> > version than in the initrd image, do we want to replace the BIOS
> > version since we do no revid checks here.
> 
> Can you even downgrade the microcode through the MSR?
> 

Instead of doing a complete hack, could we maybe revive what we attempted
in 2019? At a minimum it will work for both architectures.

https://lore.kernel.org/lkml/1567056803-6640-1-git-send-email-ashok.raj@intel.com/

Testing microcode update is more like a unit-test and we have no luxury to
get unlimited upgraded revision numbers. But most often we might have
at least one microcode, we can play around with it, and get more results
from the community.

Back then, we just hit a wall and there was no oxygen left in the room :-)

Seems like now there is a real need for it and everyone can benefit with
something that was proposed then.

Cheers,
Ashok
