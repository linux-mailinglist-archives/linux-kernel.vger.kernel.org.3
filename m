Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0521559BE61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiHVLXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiHVLXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:23:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240FCE034;
        Mon, 22 Aug 2022 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661167411; x=1692703411;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uvCidEoQv6QRBz5uvxwrlLLy8HmD7Jtc1iWGfeJjsc0=;
  b=MruzZEERVtX71bPsVDY9dJrtmHDjN8+MnHqUPwob+5wTW1lPQIX20ToR
   vO7a2IXqonYaAPUNmqWekGXr3AXzt6p4h4zixqBH/PwVP8xAQEYqcBWt6
   mBodEjuSFxoG0PQ7h9SHU/dSTa6YL8qr6bEh3+wp5uHP/3XH/gwb1pUu6
   DqqN9V9opMMmHQB5YhYVVRJlNtQ6sdZL2Jdk4vKQr+jAESdli8FwhEgeU
   UPwZBkJYKhqls5MpHme2lm/9HsuECbvtyjZ05G4ej7jsNk5vIKKQ/APD/
   AbTUwrVj0/efg439rtAN/6a9198VTA13xVHT7a8HS/OXfUXTl5UMHW6OK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="294177197"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="294177197"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 04:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="605266381"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2022 04:23:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 04:23:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 04:23:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 04:23:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FayQmdODNtM1vLi7e3oOUSQk/sP3k67/eSr62xCDorKNJFz7/lYHftZxKrYH9y2HpzU+bWfiK9VcxCYkakXjHI0Opz1HcFmKm/s0pwre81XlxzHMKgmUFrw0BnSRUcviN1CMkQtR7tvaDVoMg/k1zRClbHrhVEluZZyyGZCiOdPF1TU80pEEv5u+P/eq9DmvpDBJuyrKjqznGiTlsIk9v4desAJcVpqZ5cG3knR8qfSxgJfI95MCbZscN7J8TXd7cRWPtWDwCHlitw+kiUp0Yhffy/GOAUsrgpa2Og9FisfCSo1UbQQCv6RBuCM2WIdfMBJDO6hnWbN8x2XSR/4b3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jtx0MLwSDdFGj+6UimyVb/M6Lqwouw5jNwQMDcPNOCE=;
 b=Z22rKmyh9R9YZ0dtIjfzvqIydyOol+HVEJk3OrKFlVbqCBfKGi3c4UQ0dfxIIai8s0mMbUy7qifo/WGBW9eSCorJNZIEaek7yBXkv/wqjqPou4xNdDYJU+lDavIQ3K4OD9Zpl/dzqNj7Y4LoCJXAlloDtqfgW7ZwYpfrWpayPidqo+mB4GY+hICICaqRsR/or2XRRonTACOZ8+dmDdqFttfh23YV0td+5oInt2REJMrXuECRQxzuLoFRw23nCNZR1eo+a/DJk/87y18LZzUB8MMKrzs6ZdLlFXs+POvacmvPE9+q46mU3w3UMqspqS3WVO3iMimhKoc1obbWhKuYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by BYAPR11MB2582.namprd11.prod.outlook.com (2603:10b6:a02:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 11:23:28 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::9d94:4bbb:2730:639d]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::9d94:4bbb:2730:639d%4]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 11:23:27 +0000
Date:   Mon, 22 Aug 2022 12:23:16 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <qat-linux@intel.com>
Subject: Re: [PATCH] crypto: move from strlcpy with unused retval to strscpy
Message-ID: <YwNnJJuQdpTo4y7Q@gcabiddu-mobl1.ger.corp.intel.com>
References: <20220818210003.6649-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220818210003.6649-1-wsa+renesas@sang-engineering.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DB7PR05CA0044.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::21) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c595f64-5ae5-4664-9315-08da8430bc3b
X-MS-TrafficTypeDiagnostic: BYAPR11MB2582:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asuvRWMR5mXExuuLKSJwjN5A+qEpS1SyauMBJJARK7sXEdH6+5HlEhTszMOytWYR2tiAZUjyn7qOgcPFt0jtzfe0zsiTE765x/p9PkAFXFvUVWSI2dVe5u/j9/TU2uOO5OusIZ0ZkRs4KhFkab170kQN6KxWpKXLXerwlF+0e05GrzkY2ngBu6S7RYvZTaoWypJ2XlIj5AZX9BIMC1TklcybSmncn3JqB5gsFGiCPM07wyEHqmcbgYHyYEN28aqEc2EEMOjCIUJKUw2RQg01+URBsHl5oS/myeYwScFFV66FMK4omAS7+NhSkYkQsPS4JrOq7Mdu7MlhTrpjNC8surRWukdvKs3dy4VE0mLA9LaVfR4jr21Ai4JnLBEgQ/ufn6+GiMGXvnh2wGaRKkOph2DYNHERWDOax65O2nOsgI6hhpgOp8wOqtC/Ic/BLubFRRfsCrqbomvn6hy4ZA3PJN74FqJ0qI8lbopMb4yfKwU8osGF8fVA9kGSL9R6x523GZKhzBDymYwPvADei1eMpFgZWjofG7i/99hsMzUi1m4rM5nBEMdu9GClyyYKy1cYF7geWYXytieiPNT7ci+E+JGUO0ptJHJBgF5te6BmPV2ATwQL4ruWX0sVzwkmzW68DEqPcqJTQ4OigzsH0gFg5DjsMnyPQbJSoM5nsCpVBfVW3ek6vkafk5znkpeWGrIHqAo0/JyaxMqOj8Zlltnu5eqf+s6OULP+lKYTELIRwK2YQhKfVAt9AntS+b3fpuVyzpUpBG0/O4UmY+7+VkLvq2JMMJlfFRdpe1ud83AA9fE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(39860400002)(376002)(366004)(41300700001)(54906003)(478600001)(6512007)(6666004)(6506007)(26005)(36916002)(966005)(6486002)(44832011)(186003)(316002)(38100700002)(5660300002)(66476007)(66946007)(66556008)(107886003)(82960400001)(2906002)(4326008)(86362001)(4744005)(8936002)(8676002)(156123004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pliyEhdFGCzNCkxvyeLtTZNLscy/wfJrOv0H7+Vb5MkplvyDHYI4U7a/Sv/t?=
 =?us-ascii?Q?Lk2NNziacci9/uXokmneOErUUDe/XPHEi0g2ynxmCAu/NVPZOzLZNMesn9xm?=
 =?us-ascii?Q?bNC0EV/rDifXL1+EalRZyDD9R3m9hhL0yru7hbiLxNvjf8LTaq1A6/8tOv/D?=
 =?us-ascii?Q?MCDALrNIQazD62Dq6VoMKJUZpwTKtwigVQDWKd71qKhbH7oQaN7v/pjV73x2?=
 =?us-ascii?Q?RnRJl/XhNkAXGyxNBb9UeNygeb3Tv6Lpn5U5wAz7qFgORejx+5ze91SgkbPp?=
 =?us-ascii?Q?ESDSH3+d9UGnoqKcw+zlF4FjK/9QHp63m/SMywMq8sSNruLCVQnU7SobDjH6?=
 =?us-ascii?Q?9VqmmBnRdU4YpsJh2seCo6ABLrB8Ftj1qXV3lotgBPImOH9lBOGTK7jz4Hx/?=
 =?us-ascii?Q?c2olwSuq9CDaaZUvCpyg/S9LujqHa+sfQ5nCoYmEG0C85q3xkqQCAjtcvQri?=
 =?us-ascii?Q?/NsT4TUJV/MAgpyOf6nOenD7zc7fTxcjuhLv30WYZknemY7LLagwO8gcDFfu?=
 =?us-ascii?Q?T6OXbPxFDqrx/rVP+H5LAoZo3BzmPOr+R0KwvMR20APZiHM5tY7dFYU8WKdM?=
 =?us-ascii?Q?unikn7S+ENr1gALQAUUicqo1K799TGTiBuaxAJzaf0k0HQKCYOBoRz61wW5V?=
 =?us-ascii?Q?80X0bcxK66n0e6uer/afFOUqS/yI9sJPKNYhuFFWMlCCZJVMSCuFA5N0StyU?=
 =?us-ascii?Q?qqlVAy6SDFRyttfWmf+iaOUUlsVupVCyhIBVlZmZAXJV2mjjwKkHGvl53SnR?=
 =?us-ascii?Q?k1sZGk/DYRt4vfms80hehI/l1fX+hvFfG3Z71hynhIVv0+xiAw5Go+pLtShF?=
 =?us-ascii?Q?u25r5XjYCnk7FU2oGqRkch8TnYQycaF8oZe7QVqTTyV/YRQXE2ibSJAegIFP?=
 =?us-ascii?Q?cEAj6676kvK8uK8HPH1Wvul33oMweosYe5ImV/Bb9AHxiUac4R/thw38SsBv?=
 =?us-ascii?Q?DswFl44mZtcPz5dg1QaP47Ny8m7OMG9ABgcYJY1BrqWDzj0HyQJJiDm/Y7sJ?=
 =?us-ascii?Q?de3mJ8FivlpOevJD4yQC5pmAwv5rTguEsfjQueeFZl76w4QmbKaJn5N/1v4A?=
 =?us-ascii?Q?gmXcy6ZnzUItLmEekCF1gcf58xUkcaZMa/ksDg7tGbyfqjkr8a7VGwKmYtbp?=
 =?us-ascii?Q?wPEEzV2+0szGHbzBB7y5V3opbP2pB0q6BplNLR5C9tOQh719udCtWiXvDHo9?=
 =?us-ascii?Q?IY5zlQjLsAyLvDf9872E/JYC5Iu9CSK1vr+x6YjZYY3PRlKzB8J3JMyTjaS3?=
 =?us-ascii?Q?3MJtYlivWfetOVw7v2BV+Fg6/STv/w7nUz9f69VrIh9FcfK5icxDJaG1n7NR?=
 =?us-ascii?Q?DxS8mTGzmtd9e8VazO0hRkMVLX7OI3SGH7cZBxaj0b/t1QVg0oOnRIALvG3G?=
 =?us-ascii?Q?QjyTTRWOznmHlYUS9oKwoN8faiSNSoF/dA9a2n6LV0ibc8Yld94A9Q3aDF3j?=
 =?us-ascii?Q?c9hkb+ys/PxTrjf+9/AG3yhO6om6BQ1Ioow1iUQ0zI29M19fekWamB0sdP5o?=
 =?us-ascii?Q?JCBQwUATOIznpw8M82mafDLM+vDFBEhiNfdFBDYHTwDUcOTndC8X2vP93jO3?=
 =?us-ascii?Q?VE+w4YPOJP1rLS0ubZ7ij0+m6Z3CbP2qV6gQJK7osE7nf/L/nVRzRuu1TW69?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c595f64-5ae5-4664-9315-08da8430bc3b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 11:23:27.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiNT6ekiN3vhogKOjhxlWI5i2zHR3ppKLqg3cva/yEwILXakRR03w4aRdt95ad7cxBTVfvIq63Qj+Mp08dqfjhZZGPbJXq5VdRw2xr4p4Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2582
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:00:03PM +0200, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
For the QAT portion of this patch:
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

BTW, should the patch be split between qat and marvell/octeontx?

Regards,

-- 
Giovanni
