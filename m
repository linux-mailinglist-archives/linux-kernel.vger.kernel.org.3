Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67263575694
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbiGNUtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiGNUto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:49:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A343E47
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657831783; x=1689367783;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nCKhDVdZan8jXuM0r8UVIPCKswyLArcRMn8LPmBdZ7Q=;
  b=Qtc24ym0szm7woW2IAsp7n/tXcZ1ID55IhRIh6KukfjEWF5of/fdmVhw
   YwrAE2xnqawbfyyU00CiTSqMNEM3SyLVlEDnEROx+r71zquMFzJMXZg/h
   iVJPCWPiI71ctwUASvRiWEWheE3O+P+NzFV2WmuQlJAmK1wzMkIZbixde
   ws/BV0LEdneDF1ESOFr70QZE5kEn1bNSOLXx/aXLgRgXwq/wnGqAaSMIO
   txSfs3JmrTq/MhyzOBOcRRzB8QrsBQP/EXadG6HHDYlIs/xoK6Dyz9ndg
   Z+vpU3lpdcMMShwKVUrfxcHr8S3Rq9D6HWeQQDWG9T5a4oehokVe61Se7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286765206"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="286765206"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 13:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="663929008"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2022 13:49:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 13:49:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 13:49:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 13:49:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zsd3TrMr74y0Bx2Y8Jpo4dz9YMz673vijUcC4Rr6/j3tvZi+A4fpeV3IY3tYsitN98kFA7H9JI/FuChGrz3MuZkOS3RymcJEeI71gkkI830UViF508afYMv4PMNXjRcynAp/mKMhC0h5scP2fH5BDhFuB00S5H9HYAgtYYW0+ugtn3uHG9FXKWs0+MiWQd/ph8gCrn4NpoOwhme7Z20Xj4slllAVWLToikGJMJUqFsU9XG4OWBMxrwfsSEtZvRyQvTh6Jz+oERMX/JuD5RbfCotJiWvrSSVpoCQIDv89Asw9pYuTgdHQuy2yWofpUoUOIxrWggUFbn6UwY+O5dSUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GohrAh3t9iOn35fddzjTmCTsPJGZtznIy+G3rWAwy8=;
 b=gJjw0DKQ668nT9EDqOyRtAKTjWnSJ7p7ibDv6iZWJegZkfQsFmgYBMbLvQ4cG7d62YlPwynJVS+COxnAw9r9VVx38nDJr9eJqSRCpwlZSdZZM4GujWheQ6aJURQOj+iEC8XVhePGsodraAOoAeDpwkAjbsA5zjp4P0PjPnm/NyJzt8pp44HpYr2CzdTw2I6kHKhxX+3umByx5VPbAM+OnP8OVJbj+hw69zyhhDZmdB0BOExUuXrUO8+X2JJBjfQUngNLsWYpbGXicJlvqDOgEvu5m6xzb/n/hysbNUuR5J9cn0ArAk3qFsg+h3gWwuVlyEZxf52fSAYM8qwe7f/C1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6512.namprd11.prod.outlook.com
 (2603:10b6:930:40::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 20:49:39 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 20:49:39 +0000
Date:   Thu, 14 Jul 2022 13:49:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v1 1/1] nvdimm/namespace: drop nested variable in
 create_namespace_pmem()
Message-ID: <62d081604e658_1643dc29440@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220607164937.33967-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220607164937.33967-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: SJ0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fee325e-20bf-41a5-5b1a-08da65da5e30
X-MS-TrafficTypeDiagnostic: CY5PR11MB6512:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BK1F8ZBrHy/S1OjsjmnKYjovLUOyvMmRayYtXQfURpiz1G2EX8Be+unb7Ku7m8qdG5FRhQfnYNh4r2MKu/vb+BEBJv4bTEfwdBrArk93c06TQ15Ruy29wQpdReVwu4ohu/WTsrIgypA6BLVTuVevQbjjXmfeAbEyLkbNXukIe4xDn3JDlQnvhk/SUu7gt59hXeHAJQAg8EW6g6lNjYNcf6mEKTb0Tv93umhVkcoepI8F8H5nju54WYW9gov7pjgqjptO9bPXJEuWXvzgu5iKjBBAfecVfkRnLJyUq+sdk+nenMDjqIecdYli1MUMIBz7/bkOqd5jewop5/iZouNaBpU8Sg7mLtKIlA4+2+P+mq9pSF2H2Zn/MlYrgy/uC1AoUdLZdzripbrifLXAXkcXT/DGI9RoI//KPVrmtmLE1QGjSDd9fXAPr1SR+m7WT10nkd0DY+4zyLMLbFTjqwsG0ndfWphpTLGhML/S/kWt6ruqCIhaQxGvXSk/I7ynk688Ffqcg3XnDMZSCXzirXgfISZDEdCdS2WfgLERNiR5O23NUa6QrozroEkpKFcxnstvCXW2OuaAB9sDW0NNroPVPELmEdhA+cf9Kt5zumtjk0Ex4cpT1fEE7M5ZVASggi2Q/z4hd89rfRB7STvmNdLbxo/mAE327m3J10sdwD9aMBfYVEiEenUhQc1j+q79RyY/S8FXJTMERr+NA4x5UqOhgeJzP5BIuFC1246o8PDuDJfNQXjbSJ9BhBJ9CafWz926c1msaIOuY5D4SEasz3dQXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(39860400002)(366004)(136003)(54906003)(41300700001)(6506007)(478600001)(9686003)(316002)(186003)(6512007)(110136005)(6486002)(558084003)(6666004)(38100700002)(8936002)(86362001)(5660300002)(26005)(4326008)(66476007)(2906002)(83380400001)(82960400001)(66556008)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y4Msy8T5LC5HqyomHYIDu34WuW36aUUM4+atkWRkWelR7bMerQt79sSs+m/r?=
 =?us-ascii?Q?N6CU72ibLQzqSjI76QoxYes+5T+XsOpW3MeQAOQtox9zG3dl3aQFB/U8kSGu?=
 =?us-ascii?Q?tujMLLGDOgHfv9UwJh/YkqIzqBkBTk8dSPwKDhe4DrKmKLLKeFhppf/3VKNn?=
 =?us-ascii?Q?5r9OYNInLeyZyMnOW1PeGvOuo/UisdjCPKlvdH0hksofAgTxDO1XGJCx1MSB?=
 =?us-ascii?Q?eH+bHEeG6bqlC/CVNbhaoi5tlU7ZTcOfGL3gOyEVjhHWf75Vn+cWcEM2fSWB?=
 =?us-ascii?Q?/ND6cFE1r7k05eGhOV+/PLiBJ/bh6cBF5PdpwkK2wbeIgIjVOhpqPGxCds92?=
 =?us-ascii?Q?DOSNwC0+cK4s/B4bFuc+50uDMQ0fqvHK793eLpoVB0aH37aMa7tNadV/zvJ3?=
 =?us-ascii?Q?rTQhUJcsDxbsqR47XDvxyHiEYm3ohDrG29N4CgoW0x9lrEHhF47BwlyahaC2?=
 =?us-ascii?Q?CRfKw9eLqYiCtlcDzlxxzEphgfMZnTfNO/pz0xQHM82mJ8KXbM0UcoqAmd3L?=
 =?us-ascii?Q?qkP0+2taCsgbML7V/U5J6fuZrUPNWhFbUi5/bVGHN/4QLScL+hUeLDHk3bYD?=
 =?us-ascii?Q?yeBT65r+0vdqD+Ds+tuOx1gV3PVWlKbJwaQxTa7mjokn3bFTU8TA9VskKW4m?=
 =?us-ascii?Q?vHdZDD4GrX+rHpDUlpMWXY8XdQwCYcd/54vu8WLjQfixqLqwPjOQpIo10a1K?=
 =?us-ascii?Q?EtJTTIPcm/bRGiK8lbXTYERmthnf1FWTgJ7FL7aRl1YZfHbtulpbgFgVtlvi?=
 =?us-ascii?Q?vH77pfq2Q5KlE16uXpTQuXMomceHYWBlvjuOxFiAA0Is4MUQsj0+m8M3nkkY?=
 =?us-ascii?Q?7y1QIryYUpj5xGyAz4LHgBgd1391aoXXikgEW7CRjItba19X/kGIzhoiQNKa?=
 =?us-ascii?Q?MpNhKLGxicQoOhFEzvsL3NjyCUQsKg4hQ6W8b7Zgb2OL0uC9esJtNO8J3mkG?=
 =?us-ascii?Q?770sIUv4KGxFPxuhC0i8fx5zcObSgqbF9gb7e79gyPHHH0XC/O0YvtLRz+Z1?=
 =?us-ascii?Q?II3RiAmHulx+TyOO6A9x3m7Kc666Yo8Rm2myN8jI1F49WTXCRt2sgaPRNrww?=
 =?us-ascii?Q?rgLwVsjKma/8moMA7Edpa10B4N8zORYtK33tZ9k+TQcpQw0aa8ALiqdEpCW4?=
 =?us-ascii?Q?qLaSKPgKoUBnfA3Mf9xz/9fw3Maki6tmlM3r2SFrLoDYFkub4ONDbWroiODI?=
 =?us-ascii?Q?mYw6Ot8NedCLIjVEyDJjnpdyn+sl3r5ZF2hw1s6oXy0EOOkF7DjGxV6XbFlN?=
 =?us-ascii?Q?qnt51AB4wcI8w4pa9GazQNtHpTRoGZWSmjPXDvR4fqOyY7KnJ6RV6xQcdEXI?=
 =?us-ascii?Q?Xg9JKqnfGCCzvtktQom4IgUghBAa33oDPAaNw6YuTHeErFH08jCuZKqoI9wv?=
 =?us-ascii?Q?yNgHcBXNIPn54n1EtoS3kyHJf2YBQ+qvAbBN+YrukNK+A22AfqdJKid5rZrx?=
 =?us-ascii?Q?N7A7CElPRUXKXqNN7e0Gk1rmvsBgyXZjWqPujSV/AkPvzhHrDym9g3vJJEEG?=
 =?us-ascii?Q?3M0T2wVysbZgESsNh7xqr4WZiHqfea811gX1xDC2EGgac/ap4xewN2lBJUPL?=
 =?us-ascii?Q?p/SdzzdBrdi9I/6bCv1Pqi9bVfBCSsVDZ5wcEdZeF//rp7XOW97LjQNkjK1W?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fee325e-20bf-41a5-5b1a-08da65da5e30
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 20:49:39.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEJ/DK+nyCLp6ZhNq5CnnUibFaji8h5xSY2F396T1U89IyqKBDvxOcPihGGn/YTQFawPn403jpK2L0nKjNN+dzjPPRUYFnfxpoCCZfuKSMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6512
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

Andy Shevchenko wrote:
> Kernel build bot reported:
> 
>   namespace_devs.c:1991:10: warning: Local variable 'uuid' shadows outer variable [shadowVariable]
> 
> Refactor create_namespace_pmem() by dropping a nested version of
> the same variable.

Applied for 5.19-rc.

Thanks!
