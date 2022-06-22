Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D15555578
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 22:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiFVUq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 16:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFVUqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 16:46:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174CE1A3AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655930784; x=1687466784;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=fCBnPHKQRj9A7pIdNQ+pN2HDJqeMHoU6ZLLhRFs0pGU=;
  b=fetswX89IdXWxbuiCJK3FQiz2Rwt1umm9dEs7hSUP49BsVFaUObt3fdy
   eLM5yJXqsQ2R0f7/y8LE+3nn2klDzwSeIsPdFEJta533eAiOpFLeRqz4L
   h7cS8JzNX/nLkrsu1ygUZ9qrEJZ57daB8QeJOitzbDes2/mrVS0YnXoOf
   d9ZUWa7gbyulWwXoEpHmltsQ3VY3EqDawt5WXpXh9q3XJGPk5Ipv9kYdX
   z6LvxukHwDnJcwbGPx7Zuyog9nkNUjUjLe7YGom6khSmYPJ5El32kMfaj
   3rcHgHi2zJdHZ6c/i6rexSB+fbO4XZkwkxq/CnRjZQfVbBfRMrYFm56hy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280589589"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="280589589"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 13:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="914864259"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2022 13:46:23 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 13:46:23 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 13:46:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 13:46:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 13:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Spi+Q0eHQWHw15KBi4MgS5X2RhvnLZj3VN6b2GGjKMabRnYrsLiYgoOaMUslBEbODe98XeZcB0/vNHvVewntSBepTGrrdn+xfrQMueDv42bXfK2kU/5GMQyOjUZR9liSI0Aq/sRDp7YLHWdUaKRjg+bQilQ88GgSEvI8xM14QVDxTtjBT/ha49QBRxYb0E99iMV/lNuBG6SNyBHsp6B8DDPqNkN5bvRopFBjLyFUnS3KbMrVTcxb8vyLgN6AZx0F1wGHNNEoqzNLWBfIhjg2SGyu/6Kx1UEOZZAHGxlQ5LbknE8yntmzsqUBB6r9W/3lXlT8FcGhDLhuCSc/OAS9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqTc1fRZ1SR775L3aWT4duDKblsXWRWvqBT1QcqUjQs=;
 b=lCzslOr04VlXlvG98xWBCAKie/ti6ntvk/h0qOAUzuai0gFH1R95/wH356Yt8AFXqOhB/wsCrIrCTuYU06bgSQstIXmS83zdeTpLbYL8oUMhC905DHXjxsNFkOHclbW9L3D8r4cNWomVdS1aWUgG+NUDiZsEDyZTKx3wyRIZnhH/BhZrNj30y7FV8BDYUOfgijNq9y0krYRkAxcbbIrLXySp925g0PEPV32Km9bL+cGzgAHmG26XDmvdRpiJsGd+Ndfzo+r2pp1hZb3AN/GDLijhIoq9PW5q9PIfny1JnHp33agBpwln7l1ZbioOdem1llnqJ1l9kmAia3BX15Cg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by DM8PR11MB5575.namprd11.prod.outlook.com (2603:10b6:8:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 20:46:20 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::9c44:e158:13c8:2c74]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::9c44:e158:13c8:2c74%5]) with mapi id 15.20.5353.014; Wed, 22 Jun 2022
 20:46:20 +0000
Date:   Wed, 22 Jun 2022 16:46:16 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Zdenek Kabelac <zkabelac@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <intel-gfx@lists.freedesktop.org>, <chris@chris-wilson.co.uk>
Subject: Re: [Intel-gfx] i915: crash with 5.19-rc2
Message-ID: <YrN/mI4Qlo66qBmg@intel.com>
References: <584ae788-05e3-5824-8c85-cbb833677850@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <584ae788-05e3-5824-8c85-cbb833677850@redhat.com>
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5edec8cb-540b-41fe-3e5c-08da54904319
X-MS-TrafficTypeDiagnostic: DM8PR11MB5575:EE_
X-Microsoft-Antispam-PRVS: <DM8PR11MB55758E8D994E4033DCAF20768BB29@DM8PR11MB5575.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tgu77+RgFdbH5ifTiTVZG+Gl35k9AGPWVGJWRU8we1T+Y3RwC8mNrTU0rDiG18VjOSUABXtPi+rU0DitMik5t3TT4mdZOLCwj5EEE9mYfyJtyEbMJIIq21LoRFW96A45Kndod5Xxoyg3nS4ROukOvIslZ4JWbSHzmTwarWrbrkXRsAqQNSi//SLmvQOVBvKnWstIht8bbCsmwE5+Qjiwizkb3vDCttOQigvCQGLdO3PbYa/wh+BRu51cu8ZPGjKxBr2XI6VcQvDj0uA8QTNFOohnfCnQctxawIhkoOG7ibDZ+eZd8bEz20OsIVNsQvnwudK/IJks7/wObAsBJI4WEJBcy15OVFBE3EcolOP6X2Er8we0/paL2QM5ov+4IGWv4bddgroR9Nz39zz6mMPwDXM0eZ9SY4PZZ4Ta39A1xyVnA//yxkx2orAwBL68bGfT7pmPJmmsrlIXvZK80gdOigbOP1UKmatdW31unKYZcCdgn6CVwWCt5uDA/EhY7hYkbXFO4WlwiPI747PxS2YSIiBRGXLlAaxrC57D8/mEv0B9EuLdnWNsBR4oQ2fSnFE1TAyRyTiugg+JtxHi8nHQNILJQJr8jIAIKN92XOneMr/Wll7v/Plzg4VzO7AG6yqtQeapZgSOdtaTgF48+IA5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(396003)(39860400002)(346002)(6506007)(186003)(26005)(5660300002)(6512007)(45080400002)(2616005)(6666004)(966005)(6486002)(316002)(6916009)(8676002)(41300700001)(4326008)(66556008)(66476007)(66946007)(8936002)(2906002)(44832011)(83380400001)(38100700002)(478600001)(86362001)(36756003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SBmoU+lJebM2SocowbJ/9Hhhjp8PGYrF09WZVj95X/UlzaxNiGmTWRJExu?=
 =?iso-8859-1?Q?nd4MuJaVtEWTjmzXM2W35emI2CgIIvcKcUh9CSd5s7hqrJfyP8oLkMpszB?=
 =?iso-8859-1?Q?m0LSgajlSebU07o6PUInstbsjK+GszC/5HRKG1iFWZKXCC2TC7tG8FwZiD?=
 =?iso-8859-1?Q?CIqUsCkKFBHEYaE3GM/u8yoXbLGGLXpbnM+8BA5g809yur4EMuYcpMUaIR?=
 =?iso-8859-1?Q?Dt2cH7lfMi3VjQ7nGOrKjpWlqYFSw9GJajkDG7nx9eTsPJvNxHLYDrqnS3?=
 =?iso-8859-1?Q?xz9wKwWwPOwAsBfSJHPa5jtCs8V6H9h8uR8QQyJd6L79S7XLpOYcTC3QO/?=
 =?iso-8859-1?Q?Zg1yqh7ez8UZQiAepIAmqjWyvT4ZEWoXkw80hJML9rw2sjCae/+ngX3iNO?=
 =?iso-8859-1?Q?wiUQjC32dW7qCkPOPE/bcXP+ZuQ2FyaOPit/n+AGW63o1v73d3ERXQH6xO?=
 =?iso-8859-1?Q?odBKg+SimfvvfWRd0PZVxatxDtIw9aOOxjJiMRxwE2pte9wyN4ajM8qIUt?=
 =?iso-8859-1?Q?zf1Sb1o2Ycy+zUTBeiAyfZ6ddNdzJQRHRmxYHEtMaR8GgovMbwVKzXoIUt?=
 =?iso-8859-1?Q?ss0VCWJ/XRpYgvep2r3FG+IiFcbBgJoEJc7aAXn3LWBrgKwc+4xKliOpYR?=
 =?iso-8859-1?Q?XAM8QAQUKCZBfM40DSBVvazRHKT/4RdDDHXxGhnoiuxcZIJ8fYwiXjAGwm?=
 =?iso-8859-1?Q?wN1dQNOCYXPns8oNimqKgCatl2GAPHsRwQX3eY6209kqY6glNDjguZg47X?=
 =?iso-8859-1?Q?gE00TbpUbtvA9KXoSaZavw3aS4KcCilbC6t+TSfS3QvfntK6blPNW+GF6E?=
 =?iso-8859-1?Q?VGYKYykAix+h0Sbwqf4vdpitveFXyUkRbTNjWmVf0Fce4ubRpwPnuvZr8/?=
 =?iso-8859-1?Q?NpCNesYIzyIyfvrUJIHb2l87SqoKDLrB08LYrJPXnrL7bT2hh1Oc2PIgv9?=
 =?iso-8859-1?Q?NuBGyhbOiQPoDo4YrgrxTjZ2JGOpjOJdTH0T/b6WVIPjBRYQYowQsYxyDU?=
 =?iso-8859-1?Q?VfnGJj3l04tzCcbkOyqpvTVDQQdnE3fXOzc4gOEHDKYjzC6WlV6RK22sTS?=
 =?iso-8859-1?Q?0ILGgwvSdZlwWKFJTZ6mLDgBUZmgghflz6VCsP2wi2kkHHejhnfiU9uaEO?=
 =?iso-8859-1?Q?Dq8qh3BpGC8FAUT3qJp8zrrxaYG1fa39C5PEE7CwkWS8XRleMyuyoBdVp9?=
 =?iso-8859-1?Q?WYXbmClV6iPVL+trtQ6dlcFqJN0w1yUA+yMqWdGaU1g1rh6lBXT9l8aD9n?=
 =?iso-8859-1?Q?uDsq6vcd3HsGeX5S7Zl8Csx4aGnSU61uFXjaMKabzAR97Bfecxc1yTKaa+?=
 =?iso-8859-1?Q?dlTHS4oG5aOAwELYHtotr6jtaVEIsDQy3m5iaEYhlPtwUelOCzLP6U2Tay?=
 =?iso-8859-1?Q?vCdfDsi0IZVkz8H++oeMKYnkBdkILfTkZBybAMqD64vWi4+3l2lpbPRRPk?=
 =?iso-8859-1?Q?GWCWiKZ3lJg4KWiSSOjS9vU2BhKUbFLuhVMuntlKsrhhpOrGJxE3fhM1lX?=
 =?iso-8859-1?Q?tKqyu/dLX0F8bFdNUR9/2GToNqknEe3dXiNbK6bHOX3xPT0w6rOzXgTnU2?=
 =?iso-8859-1?Q?4mqgqeUWmgt1H4v1DtyjWxheaYt8GEr7sJ+pNv4lBz1qW43gnGJqpPs7F4?=
 =?iso-8859-1?Q?q4Udyf9FJBKmgCvPcI5PjAvGvqcU3tqKNXliND0Cdf2/flIId/ZOoON1Er?=
 =?iso-8859-1?Q?LhYRXrzJEJxm3jNGgOqO40X2CneOv6/s4TukKEJolYAfMSaBsBvseHyMKL?=
 =?iso-8859-1?Q?1JmCakqP4UYVFLpQJM4jMW49ysFbVr+4RV9QMESrM2jbso0rryzSfHMV9j?=
 =?iso-8859-1?Q?JZU6+MedPwXXx6bM94R99W+DQIzFVqQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edec8cb-540b-41fe-3e5c-08da54904319
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 20:46:20.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGTOSUAgd/Caby12O9HdYNHGeBjhUfG5BJ/tjgBZ3+hOdeBiHiLJqHqHUOopEj7XDLwgv0QHVo4iHxadvhObNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5575
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


Hi Zdenek,

On Wed, Jun 22, 2022 at 01:18:42PM +0200, Zdenek Kabelac wrote:
> Hello
> 
> While somewhat oldish hw (T61, 4G, C2D) - I've now witnessed new crash with Xorg:
> 
> (happened while reopening iconified Firefox window  - running 'standard'
> rawhide -nodebug kernel 5.19.0-0.rc2.21.fc37.x86_64)

any bisect possible?

if possible, could you please file a bug?
https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs

I know I know, the account requirement :/
also on main kernel bugzilla is probably better than the email here.

Thanks,
Rodrigo

> 
>  page:00000000577758b3 refcount:0 mapcount:0 mapping:0000000000000000
> index:0x1 pfn:0x1192cc
>  flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
>  raw: 0017ffffc0000000 ffffe683c47171c8 ffff8fa3f79377a8 0000000000000000
>  raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
>  ------------[ cut here ]------------
>  kernel BUG at mm/shmem.c:708!
>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 1 PID: 42896 Comm: Xorg Not tainted 5.19.0-0.rc2.21.fc37.x86_64 #1
>  Hardware name: LENOVO 6464CTO/6464CTO, BIOS 7LETC9WW (2.29 ) 03/18/2011
>  RIP: 0010:shmem_add_to_page_cache+0x48e/0x500
>  Code: 01 0f 84 0a fc ff ff 48 8d 4a ff 31 d2 48 39 cb 0f 85 ff fb ff ff e9
> f6 fb ff ff 48 c7 c6 70 01 64 bb 48 89 df e8 f2 99 01 00 <0f> 0b 48 c7 c6 a0
> 1b 64 bb 48 89 df e8 e1 99 01 00 0f 0b 48 8b 13
>  RSP: 0018:ffff9ce7c047f6b0 EFLAGS: 00010286
>  RAX: 000000000000003f RBX: ffffe683c464b300 RCX: 0000000000000000
>  RDX: 0000000000000001 RSI: ffffffffbb67b8e8 RDI: 00000000ffffffff
>  RBP: 0000000000023f97 R08: ffffffffbca122a0 R09: 64656b636f6c5f74
>  R10: 747365745f6f696c R11: 6f6621284f494c4f R12: 00000000001120d4
>  R13: ffff8fa2c6ae7890 R14: ffffe683c464b300 R15: 0000000000000001
>  FS:  00007fc1cea31380(0000) GS:ffff8fa3f7900000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f6972e228c8 CR3: 0000000104ba8000 CR4: 00000000000006e0
>  Call Trace:
>  <TASK>
>  shmem_swapin_folio+0x274/0x980
>  shmem_getpage_gfp+0x234/0x990
>  shmem_read_mapping_page_gfp+0x36/0xf0
>  shmem_sg_alloc_table+0x11b/0x250 [i915]
>  shmem_get_pages+0xaa/0x310 [i915]
>  __i915_gem_object_get_pages+0x31/0x40 [i915]
>  i915_vma_pin_ww+0x69d/0x920 [i915]
>  eb_validate_vmas+0x17d/0x7a0 [i915]
>  ? eb_pin_engine+0x262/0x2d0 [i915]
>  i915_gem_do_execbuffer+0xd43/0x2c00 [i915]
>  ? refill_obj_stock+0x102/0x1a0
>  ? unix_stream_read_generic+0x1ea/0xa60
>  ? unix_stream_read_generic+0x1ea/0xa60
>  ? _raw_spin_lock_irqsave+0x23/0x50
>  ? _atomic_dec_and_lock_irqsave+0x38/0x60
>  ? __active_retire+0xb7/0x100 [i915]
>  ? _raw_spin_unlock_irqrestore+0x23/0x40
>  ? dma_fence_signal+0x39/0x50
>  ? dma_resv_iter_walk_unlocked.part.0+0x164/0x170
>  i915_gem_execbuffer2_ioctl+0x115/0x270 [i915]
>  ? i915_gem_do_execbuffer+0x2c00/0x2c00 [i915]
>  drm_ioctl_kernel+0x9b/0x140
>  ? __check_object_size+0x47/0x260
>  drm_ioctl+0x21c/0x410
>  ? i915_gem_do_execbuffer+0x2c00/0x2c00 [i915]
>  ? exit_to_user_mode_prepare+0x17d/0x1f0
>  __x64_sys_ioctl+0x8a/0xc0
>  do_syscall_64+0x58/0x80
>  ? syscall_exit_to_user_mode+0x17/0x40
>  ? do_syscall_64+0x67/0x80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>  RIP: 0033:0x7fc1cf28da9f
>  Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44
> 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff
> ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
>  RSP: 002b:00007ffe5f52e1c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 00007ffe5f52e250 RCX: 00007fc1cf28da9f
>  RDX: 00007ffe5f52e250 RSI: 0000000040406469 RDI: 000000000000000d
>  RBP: 000000000000000d R08: 00007fc1ce938410 R09: 00007fc1cf2fa4c0
>  R10: 0000000000000000 R11: 0000000000000246 R12: 000055e2dde0d340
>  R13: 0000000000000114 R14: 00007ffe5f52e250 R15: 00007fc1cdc49000
>  </TASK>
>  Modules linked in: tls rfcomm snd_seq_dummy snd_hrtimer xt_CHECKSUM
> xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 ip6table_mangle
> ip6table_nat ip6table_filter ip6_tables iptable_mangle iptable_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter ip_tables bridge
> stp llc bnep binfmt_misc btusb btrtl btbcm btintel btmtk bluetooth
> ecdh_generic snd_hda_codec_analog snd_hda_codec_generic iwl3945 iwlegacy
> coretemp kvm_intel mac80211 snd_hda_intel snd_intel_dspcfg
> snd_intel_sdw_acpi libarc4 kvm iTCO_wdt snd_hda_codec intel_pmc_bxt
> iTCO_vendor_support snd_hda_core snd_hwdep snd_seq snd_seq_device cfg80211
> irqbypass snd_pcm thinkpad_acpi pcspkr joydev i2c_i801 snd_timer i2c_smbus
> ledtrig_audio wmi_bmof r592 platform_profile snd memstick rfkill lpc_ich
> soundcore acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sunrpc fuse zram
> i915 sdhci_pci cqhci sdhci drm_buddy drm_display_helper e1000e mmc_core cec
> serio_raw yenta_socket ttm wmi video ata_generic pata_acpi
>  scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath
>  ---[ end trace 0000000000000000 ]---
>  RIP: 0010:shmem_add_to_page_cache+0x48e/0x500
>  Code: 01 0f 84 0a fc ff ff 48 8d 4a ff 31 d2 48 39 cb 0f 85 ff fb ff ff e9
> f6 fb ff ff 48 c7 c6 70 01 64 bb 48 89 df e8 f2 99 01 00 <0f> 0b 48 c7 c6 a0
> 1b 64 bb 48 89 df e8 e1 99 01 00 0f 0b 48 8b 13
>  RSP: 0018:ffff9ce7c047f6b0 EFLAGS: 00010286
>  RAX: 000000000000003f RBX: ffffe683c464b300 RCX: 0000000000000000
>  RDX: 0000000000000001 RSI: ffffffffbb67b8e8 RDI: 00000000ffffffff
>  RBP: 0000000000023f97 R08: ffffffffbca122a0 R09: 64656b636f6c5f74
>  R10: 747365745f6f696c R11: 6f6621284f494c4f R12: 00000000001120d4
>  R13: ffff8fa2c6ae7890 R14: ffffe683c464b300 R15: 0000000000000001
>  FS:  00007fc1cea31380(0000) GS:ffff8fa3f7900000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f6972e228c8 CR3: 0000000104ba8000 CR4: 00000000000006e0
> 
> 
> Regards
> 
> 
> Zdenek
> 
