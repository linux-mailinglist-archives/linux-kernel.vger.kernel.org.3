Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40052574081
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiGNAYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiGNAY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:24:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7541BE96
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657758258; x=1689294258;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=vm7jVmtcXKFTtnEez6SLhthLW3mDgl6wqckBIKyZj8M=;
  b=Z9cH9x/epXIoHXUJzOE6FnCtjApTPTno3lkKNPS3afCLZoS3C91G3/UC
   k5sSqtNT4dl7RfDPBL8snKm08s4fgs+SMHu4+6txlNO6Ly2FcbqMUYpos
   Y8HejSeVrMZClqq+BBexgl8zTZCmDZpix7q8QNvksAGUzoGc1Mdk9qxqW
   TXierTZVCcQPWjqasJDxJuFdutkchihAhGLiBARkuQ0LtqTf6DcYncYML
   p9Jj3/sBh2UUP/BGSZGPRcLhDg6kz40wmRoMLt45/un+KayiYqfePhN7C
   /3YI3JIBTXdjeLn9C0E6manh/io/AUpaEvn5/k5XdBA6Vbj5leYOZbw7i
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="268410470"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="268410470"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 17:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="922853630"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2022 17:24:17 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Jul 2022 17:24:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Jul 2022 17:24:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Jul 2022 17:24:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Jul 2022 17:24:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PonXGhuk1UwPhaLx3hpjAr9VXZ4CZSjYqBPxoJUa7Fu+9Y8I2UmTTkfL9IYqs+ecCIM4nKZnA2HoU1aae9l3fXFWHnPErVBAL8f9dcJdeG8A2Ipa+xIYGiRgpT9AKv8abTTBIwNH1DORmHjrNvWG/mN0HSY+ZkaV4OmwK0JTtLIkIpUHobxEhVW0OVlAPoo16ZxxCfKSQHiClq7KbZulszvWi6GryNzHteR0bxlhu2O+NqSaQEe4ERje2DHsnwFxiHFqaRMee0I4lhx53JXyi2zKDpNLlVd2mzAr5XQmuVACFlo+Khb7F/QGfoj9Ho1jYb2iNzZjICKTzANjxUbv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYQ0hreds/B0Ov08EIzEf72+pQLZR42Ocffrsf2q45c=;
 b=UfBSl4ZuFq56JwFnMk5jj6fOc08aCT7TtpxTDLbxSrb2csCrAdKkggfekt3o+ZOQmHI33uHeUrxYjjqcAE/a5ZZ5BOmrEZjKRYt3wKU1KMF21YsiMDpKNq/1WcYXhSSYF4dgw5d4hqXPUewTGLmlhT3N0iTdpxJYp4moHbnuGJKENPAwIOm8H5C/NXw4w6NDz+ScEzW7TSLZexHJOQ/q90SiSZOPScSOMPCIij/a/SkMdXGRPoYHC5HeZ/99rmIlc14IF5ORrUINyn+j+VT2mq1R9WGnQVcD7FPcjMUPQV1wx0ctMZ1YOhPW9xBoB7nFeKGt2NsX9TDrgRjbJw9xhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN9PR11MB5513.namprd11.prod.outlook.com
 (2603:10b6:408:102::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Thu, 14 Jul
 2022 00:24:13 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Thu, 14 Jul
 2022 00:24:13 +0000
Date:   Wed, 13 Jul 2022 17:24:10 -0700
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
Message-ID: <62cf622a32e1_16b52e294ea@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220711232658.536064-1-jane.chu@oracle.com>
 <62ce16518e7d3_6070c29447@dwillia2-xfh.jf.intel.com.notmuch>
 <09df842d-d8e4-0594-56b0-b4bb9ea37b67@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <09df842d-d8e4-0594-56b0-b4bb9ea37b67@oracle.com>
X-ClientProxiedBy: BYAPR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:a03:100::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6a7b4fc-af73-4dba-b83e-08da652f2d7f
X-MS-TrafficTypeDiagnostic: BN9PR11MB5513:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7Pf+rA1nd86MBEI8HA3BZYJWJVBdKbmp1EzDVlFfXiOGVJEhMzM8SmbQdDiOTzDznmVcUC2fJCWQ6vhqDEf3Sv1pOQWwnfPQYUpc7/OIwbPm5VDpSilwlnf4e0Fb0e2NWo0i4mOAxJTcPOpTnGZSE/ZIRUuIHFg40vNdmx3H2W6JvhoR76Po34g7dD/DPFXgw1m/xfwnhwT3olK7wf+Y3vq4KE3FrlnNOC8tPROD5EafYFMkThuF+UQC2e1ZQtZ0dwv9ssRwvHmsFebI05tL97uh1tEhA+WsTDM6Xa4Y1SPTd3PU1UzFwnRUZknPF5hsq00jFLU1z9ARSaLq0kcF5ts/TqRWkiaZt5hMP+c1gUQ2qb0R4q3pie2Ibmj/2yc+2sLURDqeHYTXNG6H+r47EIg6DDo3rN2gxN8kFvYm4dgEqiWJhJ1LV2s9BPp8iqSXqebPRCpyIsvAnaAAoqBt8Ob93DD400y0u+v/wLI/GmVXIrnp/f/gfgtHK2drWdHQKs9Fm8EENUNLDI+RrQR0CbNtD6B0h8WRQxpPfGCvQMMMyDT0y9mPL5hMuNZvf3D2L7uYKPwZCjE97ZhB0QP2dv2FkHEfFVo83i/Wuo0jretHtEUmuW9GT9c2WzXKwpcOyzm185JrC2yNXUPK5O/f4cFI4MZreSoFblbDOpRzKlYZq0znoEbfHe2aKqBbmydoAM/raw4fjoMG//78zHJz0uUB9up3+QMD7w2my/O7HcDnZSLx/mLdCIsGZ22+3lxou5v+Aw6ParJcAvXLn0XZrCbrsf92pLFbhVriL46g9wRn0FQcxGX/6T2Ok1Y6vhc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(366004)(136003)(346002)(66556008)(66476007)(8676002)(5660300002)(9686003)(26005)(82960400001)(38100700002)(2906002)(6512007)(8936002)(316002)(83380400001)(86362001)(110136005)(41300700001)(186003)(6486002)(66946007)(478600001)(53546011)(6506007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WNlxwtLl7qIewAz5Nm4P5v0CjuO1KNn0VQaHJNWcSSbYkb0ixh4Cpfp0VZ2C?=
 =?us-ascii?Q?xhUBoHFX9w3PR7FaEOKo7jmvptvYRloWMgUSylA0RxtglAtrNihkg35C1bDj?=
 =?us-ascii?Q?fUnhY9e+vjvTqmNpPZlH8/86FlE/JlodWnVRy9yOoUE0d8m2F8lgVhK97Zom?=
 =?us-ascii?Q?/2S+erbWEzaOGg12a+mah3Djcvl3ro8K72zf/amA1fr/6RM8bY/JH3F+oniW?=
 =?us-ascii?Q?JsmQXeNshlumy9Sk1RgFKt3E3W8JWuIvzfypv7rME6x+487Tmg6UoR5Pcgme?=
 =?us-ascii?Q?MQv2YHJv1kiqoEvXwnRbhJCc/Tb5OOfvy/8Dtak/e7DSP9NpOZ2qQN1rRXIN?=
 =?us-ascii?Q?ZNhipvusLAyUmI8EJTe6OlbUgpOoMQc7XrgjcjEoJnzK2YAeZwPRLLdA4vBW?=
 =?us-ascii?Q?Z1EIjlnkyiouojXhWnrm6cxQb06C0G5ALhgmLfHPEKNTqTkUDBl9DW8iwz+N?=
 =?us-ascii?Q?TMPNxMihewugx7YeWPkessCUjIxM/4ctVZKMS+F/rBYsZkumiOHn7d8TVsSH?=
 =?us-ascii?Q?c0w9orkNHKGxPpcGZobNnT0PH8Dg8VI//XC5LFmW72/VkOwUh3qtPR+z/seh?=
 =?us-ascii?Q?u+G/kDLiwIOGUMnN9TTvoa/yt2vbbmPoOr8PkRsJyFUuch2vU6yoJiKWJblo?=
 =?us-ascii?Q?qgucObWtnf+dMz4PI0IQV4aTgLBE8dEwinpCz0j9PTFERBatRAM+uHY0LmJU?=
 =?us-ascii?Q?LHWVPJVMQLdwxotCmsYuQVF6MKbbUtuvZGmQY4yBWlmoAO2ZrZeFRg/vBr9+?=
 =?us-ascii?Q?sQOJRGxhv4PnBL07AVnD/cckMLPwqnQTRYjAnRabdnR2TmJxmFnNiRHWQdlF?=
 =?us-ascii?Q?15NUNUSBXSztKgRN14V7ULn0XSG7WRzY4PwLLFfCywyBspArd8PkCt9GQlHP?=
 =?us-ascii?Q?MUwnnsWNz1TP+mTiMTyZH9nrN6ZQzHIC5rxgUVj2XndwzDXzPZG4u02pgmm6?=
 =?us-ascii?Q?ISYfj22CEnlAcYClWK5NsOWLfR9U07jHlI71Du9LcFJadFqTJznhvkPXUYxu?=
 =?us-ascii?Q?6hh01Cwl81Y0gOj2dtdWO9JixQa2KuQ84havJujXimZMzEQ0oNTkgFz3Nd6e?=
 =?us-ascii?Q?ctfQGarqnavxVQAqxQvpVrntRRFdFo4QKDo2bkX3hwSkbPotodOfgxVfGtYr?=
 =?us-ascii?Q?44AJOYgoNi0Gr1V29Ivkj3XeBTssyWHjGxjabxwZdbwRDMN9Pst4YhgdTUvW?=
 =?us-ascii?Q?3EC20mxlg/eOekp7y1zUWZIeENE99JjooQQknwE0KfBTdjvF5eqziogY7QFg?=
 =?us-ascii?Q?BCoEbHwnYGXFZPPvh650tbKJodx1ea6/RCoNxOuDEduJV+OnKAaYCGP2xi6H?=
 =?us-ascii?Q?7xCK+JO91C7MASU7RTRgyB9ukTetmvT2fadqxdXshoRHJPX8Ej/pWYFzxX9N?=
 =?us-ascii?Q?kvSqEezA28DtwTuTVeErQnctrOMo9U/K99qw9k9p3SeqsyijzH71CTiSZLIn?=
 =?us-ascii?Q?xRpj6Tu8/Q1T744UuoxcU6I7bqn7RBy+irhCtgaCbBouzAvXEEcyI3uQtDIl?=
 =?us-ascii?Q?tvItBDcx9OUoUKD7LK6shGzlWImXMITPosWYOZMwydHe5kz7riCmQ0Aszo5r?=
 =?us-ascii?Q?hr5Ts0yURKZUDD8Cfw9zk1VoL/2Ci8SQDBolzjqVu7n2CzRYb7tdKaSVbDaE?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a7b4fc-af73-4dba-b83e-08da652f2d7f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 00:24:12.9434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihfplCBDhZbJYXjI9B1rA/YACt1V2yZGeMC5ZiQMAXY8ZLKLy3kIjFB4RoIgdIONQ95zJTnjOpTSsUeAkq0NzVC6CiJMKPbs/6001wEHkbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5513
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jane Chu wrote:
> On 7/12/2022 5:48 PM, Dan Williams wrote:
> > Jane Chu wrote:
> >> Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine poison
> >> granularity") changed nfit_handle_mce() callback to report badrange for
> >> each poison at an alignment indicated by 1ULL << MCI_MISC_ADDR_LSB(mce->misc)
> >> instead of the hardcoded L1_CACHE_BYTES. However recently on a server
> >> populated with Intel DCPMEM v2 dimms, it appears that
> >> 1UL << MCI_MISC_ADDR_LSB(mce->misc) turns out is 4KiB, or 8 512-byte blocks.
> >> Consequently, injecting 2 back-to-back poisons via ndctl, and it reports
> >> 8 poisons.
> >>
> >> [29076.590281] {3}[Hardware Error]:   physical_address: 0x00000040a0602400
> >> [..]
> >> [29076.619447] Memory failure: 0x40a0602: recovery action for dax page: Recovered
> >> [29076.627519] mce: [Hardware Error]: Machine check events logged
> >> [29076.634033] nfit ACPI0012:00: addr in SPA 1 (0x4080000000, 0x1f80000000)
> >> [29076.648805] nd_bus ndbus0: XXX nvdimm_bus_add_badrange: (0x40a0602000, 0x1000)
> >> [..]
> >> [29078.634817] {4}[Hardware Error]:   physical_address: 0x00000040a0602600
> >> [..]
> >> [29079.595327] nfit ACPI0012:00: addr in SPA 1 (0x4080000000, 0x1f80000000)
> >> [29079.610106] nd_bus ndbus0: XXX nvdimm_bus_add_badrange: (0x40a0602000, 0x1000)
> >> [..]
> >> {
> >>    "dev":"namespace0.0",
> >>    "mode":"fsdax",
> >>    "map":"dev",
> >>    "size":33820770304,
> >>    "uuid":"a1b0f07f-747f-40a8-bcd4-de1560a1ef75",
> >>    "sector_size":512,
> >>    "align":2097152,
> >>    "blockdev":"pmem0",
> >>    "badblock_count":8,
> >>    "badblocks":[
> >>      {
> >>        "offset":8208,
> >>        "length":8,
> >>        "dimms":[
> >>          "nmem0"
> >>        ]
> >>      }
> >>    ]
> >> }
> >>
> >> So, 1UL << MCI_MISC_ADDR_LSB(mce->misc) is an unreliable indicator for poison
> >> radius and shouldn't be used.  More over, as each injected poison is being
> >> reported independently, any alignment under 512-byte appear works:
> >> L1_CACHE_BYTES (though inaccurate), or 256-bytes (as ars->length reports),
> >> or 512-byte.
> >>
> >> To get around this issue, 512-bytes is chosen as the alignment because
> >>    a. it happens to be the badblock granularity,
> >>    b. ndctl inject-error cannot inject more than one poison to a 512-byte block,
> >>    c. architecture agnostic
> > 
> > I am failing to see the kernel bug? Yes, you injected less than 8
> > "badblocks" of poison and the hardware reported 8 blocks of poison, but
> > that's not the kernel's fault, that's the hardware. What happens when
> > hardware really does detect 8 blocks of consective poison and this
> > implementation decides to only record 1 at a time?
> 
> In that case, there will be 8 reports of the poisons by APEI GHES,

Why would there be 8 reports for just one poison consumption event?

> ARC scan will also report 8 poisons, each will get to be added to the 
> bad range via nvdimm_bus_add_badrange(), so none of them will be missed.

Right, that's what I'm saying about the proposed change, trim the
reported poison by what is return from a "short" ARS. Recall that
short-ARS just reads from a staging buffer that the BIOS knows about, it
need not go all the way to hardware.

> In the above 2 poison example, the poison in 0x00000040a0602400 and in 
> 0x00000040a0602600 were separately reported.

Separately reported, each with a 4K alignment?

> > It seems the fix you want is for the hardware to report the precise
> > error bounds and that 1UL << MCI_MISC_ADDR_LSB(mce->misc) does not have
> > that precision in this case.
> 
> That field describes a 4K range even for a single poison, it confuses 
> people unnecessarily.

I agree with you on the problem statement, it's the fix where I have
questions.

> > However, the ARS engine likely can return the precise error ranges so I
> > think the fix is to just use the address range indicated by 1UL <<
> > MCI_MISC_ADDR_LSB(mce->misc) to filter the results from a short ARS
> > scrub request to ask the device for the precise error list.
> 
> You mean for nfit_handle_mce() callback to issue a short ARS per each 
> poison report over a 4K range 

Over a L1_CACHE_BYTES range...

> in order to decide the precise range as a workaround of the hardware
> issue?  if there are 8 poisoned detected, there will be 8 short ARS,
> sure we want to do that?

Seems ok to me, short ARS is meant to be cheap. I would hope there are
no latency concerns in this path.

> also, for now, is it possible to log more than 1 poison per 512byte
> block?

For the badrange tracking, no. So this would just be a check to say
"Yes, CPU I see you think the whole 4K is gone, but lets double check
with more precise information for what gets placed in the badrange
tracking".
