Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C7E5754E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbiGNSYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240635AbiGNSYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:24:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CB22CE00
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657823049; x=1689359049;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jr9UvIC7zjBJoh0OGfUlYE89Y2fvCmM31rb7l/8Gwyk=;
  b=ZgteI1T3n2xkciny1tpFVa4yn1k1galY9l0NgKBixMLLe31WXuCl9tXm
   iT+DH7hU+iEc7Pp9puW11xMeVo6x4vbQFtj1/jyjUtOUWI0WNZ/BmrxSv
   DpwmgYsyzkovaNMjToltiL3TcUnX2bMK3TxMWk4ZqNR3WWsBHkxbFuGGp
   W6HgPriuZCKlyVSILPklXOn785cokCnRqJSM8LlEx1vlKapx7Qv/sZKey
   ktVFs3xxlb7weDwjIMaT3QyjWdmBtFvUrnomwydJOyhMCiPG/lQXVCq+9
   /ZyOKY8gkmsduqTi77yKqMiFodk0aU2k3mMgycYSE/eJZIF8sRHWdaulj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371913785"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="371913785"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="653990166"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2022 11:24:09 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 11:24:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 11:24:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 11:24:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA5+vCRtP5axlgEhGmA7UmygBi4KzapmPbisNPDIXLQFMoXuGrJfw30ZY/EkD6cfhPTlx+EL+Rfnvua3I0jbwc4VX+1XcT4WhdLPA4MEbbV+Xmvuw9KdWIBYUaWJaBPeskohq+yZEeRkd/v9s9K3rM8IAbW33+nWr7e0QX0vKBigNQ6uWCxKEzJcDH+yqM1Dot3NbhZBxrTwgp/AG53H4wjy6UjHZMF5AvvHkWihwR1f95uMQh4vkd7sIWEdoSQrsxj2QZIGjHb29+tubYqCAp7RTThivcO8sK5AtbOGJZpcwZ9H0BRJTA+iuxaroyVTLB2HK0K4BCm6996cJgJJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jr9UvIC7zjBJoh0OGfUlYE89Y2fvCmM31rb7l/8Gwyk=;
 b=c+a7yCDq41dJPgAN7AXEyVczONGKFY8lNNP+8PIc9G6YnrDHmTJCE78EthTcC5sQFGJ1zEX0ZUAvb+pnCnWyJkVSFibdohz4SS8TbawWaOJTuh8dcyu/+sexqucZpBSaRW62yF/ysguxPXkhd5Q18xP7BZta30lU2YC0K4VvYGmURV02CzynkRJRp7cS9I0uYHX94cWIlFg0t3dfF5K/8duZf/eEvlSQd5fPk2D/usKVk8dQEfuL2AWilR1hV+3hwZeHve3zSpYNO3O0ZREyTK/naRld9fhGey31OWDcqGVu/KXRJYgTRfX05mqZ/QFWkHCv1hYEcgAwRJI0bKn2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB6169.namprd11.prod.outlook.com
 (2603:10b6:208:3eb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 18:24:07 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 18:24:07 +0000
Date:   Thu, 14 Jul 2022 11:24:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v1 1/1] nvdimm/namespace: return uuid_null only once in
 nd_dev_to_uuid()
Message-ID: <62d05f453b73e_1643dc29412@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220607152525.33468-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220607152525.33468-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2129e1e-bc4f-48ff-3b25-08da65c60a05
X-MS-TrafficTypeDiagnostic: IA1PR11MB6169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UADIKgV8wcX9wPI3qgmRa0em+4dUSNeg8zK+y9/SdfzjqKodGceX1GMuuHrRZkxr0dwWu4zp0QVZtftrGvLo8j57DMhPlu/mj4p30I16MH4E+8V5PXHtLpj71PsjGDWdg7mpLXfPGhzg1RHPpLS6sKxdJa4vbeNg3LGR+jM4zd52iQt75H2RVWEe68mDGJgDTF5C/HGVcAgtTbxUdaq5EzC1jvwXahUNhbgQJ8WtWz3S9BvuVUwYUXnZWZFkTsC1rUzp6iiaP5OZmKHSzmtWGuAxBZH9fkre9Gokfjm/loHKGDri/agz9Np52tFFNNP2ZV05PyjxUJvljbY9tg49UJdVwNY8bi3isqsUBT7kNKU+iNmDYhnSO/P6tWrq+kr2/OEzxIbpZjPG7zRcEureehlcsL6ts3+OnF7vGkFwOjpwVJi5ezhCpvNzpIUAf3rhJmhzsmTW/Sc81tvc3fYWm/LJ0B+d4h4S+34zJfksl1otAAhyF/RKPqQgiMQ4HtCyEPY9Fs+mHKG3ZPgYEhDccCDm6bM6pldzwNoBHVOY0Uhsm8INP7UXimS9HBVIZxTTvMXinPZoiYxVokGt3tGYfgUbN0n/7FEIWnhmfI5JVXdUwF3rmI1FIzYGlVo3Ev5zrEsgY1ptegqAi3r1QhQZwsacOAwiPHrgeJ6+8HWLnnvJPwkznerokFIH86G/Dj/sGG8vgracgbsZSXKmQ3hFQJnOo9er3GNngcavIdu8Bl5uHkG8aC9P7+BJgfn9kTQNeLaQs1T2fzXA8EjxSXiWdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(396003)(376002)(346002)(8936002)(5660300002)(8676002)(4326008)(2906002)(83380400001)(86362001)(558084003)(38100700002)(82960400001)(6486002)(478600001)(66946007)(110136005)(54906003)(66476007)(316002)(186003)(66556008)(6506007)(41300700001)(6512007)(9686003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G/bftyYd3hFAabK9cljpixMFO8vQeGjsMLPeKqxeQ/hgEixroeZXM7mmm/fK?=
 =?us-ascii?Q?UWqoXOyORUMtYmcgrvg80clPH6SMVYuusk9HHAik/Fcgb+9PS/0Y6DTSxweY?=
 =?us-ascii?Q?R0RSQDGLsZjr9SfO0kUT9CUIBk6J17o5vLx9mHY04Vgoe6wGV5vM1nlijUwT?=
 =?us-ascii?Q?UanlvDF72MTVaz/ypCk3zKlso0hlDlUMbiN1QOkicemzvlg49pcNFulXdgV2?=
 =?us-ascii?Q?TRiEIqGVXyBVgn4mU5HkSH6UHjHsQCoiUqlcw1bTghGRSFSEszBFzCrkXdVj?=
 =?us-ascii?Q?fj1ZwXUPiLaz45XFjKsIXLgX5xxIWS1U/rWZQYSu9w52C35DuWgpz5SXe6BB?=
 =?us-ascii?Q?bRZbSy7UICnu8dkzkmLJihnLhXzOsFICNUvzGfZUxjxwSEk63c7IqLAT/wu9?=
 =?us-ascii?Q?dIkxHP2dXp3T3n+TE/y/iwenoIgD06Lai0KJ+JknvQaeBk8hfEATkuoy7PnK?=
 =?us-ascii?Q?+mpilB2Wm+i9+iHpy1rRPGcyzOIh/9fIMmHT15xE6kR3cugnmttRlfyxPq0L?=
 =?us-ascii?Q?stjUR8L1xpbNfy8xBpf7eYVAPYWMUlmZ9bUcYQvP16f5uemKvzOvTZTXlzj6?=
 =?us-ascii?Q?r9jXX8uZ7IJemO85ylzZ0nWcYYtv8wfckjb4D4FGwka7E+YbxjQ2PxQnOw4q?=
 =?us-ascii?Q?lg5J+pJG0IpFS8TxcYjCnQ3crZxaxlqp3vpBo+jIk+u2cyNO8m0b6/muR3Sx?=
 =?us-ascii?Q?yVT4WsYSmxlOdZCaZuhC0OSnF5xnTUdd2Nl5geMM2yenTAYw17O5d/QW6OXA?=
 =?us-ascii?Q?FvIRWEZs/qBNl/AHhrWZH/vqE6QD6sz/dYRjS4UMW/6eLkzBj8ycQ2x5aZGi?=
 =?us-ascii?Q?FJNGGc6rsQnK+6dRv0gh26GAPRhu9REuOuGR0OgcEm4DSzUQkHtkpkfa9uMW?=
 =?us-ascii?Q?9QsllhEEMrS5iNfwoFwBz0IxTcESoRF4rmptW5zpnw41GB63W9VI/S1mH4D1?=
 =?us-ascii?Q?eOR+zgyM83c6hqsQYZ6iT0YXQbq55TxILEw14ZvATcAHIXUaISwIt1HgxDwJ?=
 =?us-ascii?Q?jjWOIcMri7EjQ86WR+J6dnFMpvtocmPQc1iP/NdAzKQrkAJpKHX+HFaaC3fK?=
 =?us-ascii?Q?EOVWTxqqw/pciNa0Q41DTU4yncQku2D0wrT0WCuNcrFsREGf9c8OFDtORt89?=
 =?us-ascii?Q?eds30/SHxkohgtA68p3j/AtDi7n/E8PROL4pST4csSbzf8SFS+m56p8VLpM4?=
 =?us-ascii?Q?UZ1JK+V4Y2eBCEpSC40zxm7ZPQJgrxK7D+koSrNfDB9aZrTjMvWYznnuHrvu?=
 =?us-ascii?Q?nn8nY7U8Gttx1Qcc7kze4nDhfHJzIsqeAKTcZFUMCJCjQovt420tVgCr/L9w?=
 =?us-ascii?Q?QcIwGG1DjIfFwJF1AVQbSRjqnOZM+/9OTnVpZ6WirWcJoWf2+m+wm3/vbiQe?=
 =?us-ascii?Q?LQwews0Eft75gEWrWjiKAqWYdw52HrQsi0VFHR2gqRaAd7mNDEhyh46SE4Sc?=
 =?us-ascii?Q?fdsnoEDqAK/ini4NcyNomASgeqWpqktyIWj6JGdp4XtyGbUmijPOGWk5QwpR?=
 =?us-ascii?Q?2ZNv89jPJU9x8GeAYP0ggBV0nHVxxXLJF81ZXqmMXdTeCK5XNQGCi+gD+YOl?=
 =?us-ascii?Q?JClgYUr/vKqMPi4jhe05lC0dL3o2GXgGIEkfGx0N8zT2kYlrTXS6R7G50o7j?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2129e1e-bc4f-48ff-3b25-08da65c60a05
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 18:24:07.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cuRtySOGZXJVpGjmV0q/7EGk7D4j9nme3iwLhHkUZJHyEW0tP53HuC4MUpV741hr04RfOMMilHzpM1fpG8ZGug4iXaYwOrBG3vrN2eDnAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6169
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
> Refactor nd_dev_to_uuid() in order to make code shorter and cleaner
> by joining conditions and hence returning uuid_null only once.

Apologies for the delay, applied for v5.20.
