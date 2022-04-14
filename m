Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC977501583
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351196AbiDNOao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 10:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343635AbiDNNjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:39:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2EA29824
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSaaH3qxyd+7gRVTw5dmRXRmDMYB8f+z0rfH7wux5OK6D7/qZ9Hw02BBWoNtt//f/M8qP/7X9mmmXhPjCDYASKWJNGNRzLL64HBL8igurOn99MvHmHMSnqWpruJjGKq4tRQFV6qiiKDfP1DFhK7Z98FBCt70gOHw9GHs4Y/EV3dHt4Y93w2nRP+nJGf/RyU8lWWGX8p0JPna9/eA0mqrh+OVQs5UOiz70ehxeiZg3sBHRImnXTnrNbMUSWbXi6nqP9wT9FoT8oOvhKi//1bMTj51ANPhHsttGkTIAC8v0J6vnlWxbQWxw8p/rT/3Lh3yHUZBeI6LscKIbnAiu/VgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXvfCH4+2Sz5ak1ezXi8XHJnmKDqbrzmEj/9hXGUqKo=;
 b=n4NGh5ZDxNcMiD2aXDMmzN+rSLIzoum0hmc1PeE2pNtdiPaUUlBaLx7yfqsi5kRd6t0lnsBDeDObTU1DnZSSMXOrMSPMQhYG87xxhH/s0FgPfS24t9bUIpHnLeuNeQwQPy+AnjYM0TnHzFXUHyt05PgpzILJ+Gb19wNKaZLTktk8SdGf4zbGhVF/+AnMLtykcLTvr5Dxitt6ZSG5H6f7C9K7xM27QtYUSnlImd2Jin45iLHY3MgPlV3sxo488n5Db7elw/4u5ObRb5RGf3vQqHb8qGsMAzNcQcVigwTSbNdYsiE5IGh17RuB8EQu9HA6fpY/JqN3Ga/2CjdqTvN9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXvfCH4+2Sz5ak1ezXi8XHJnmKDqbrzmEj/9hXGUqKo=;
 b=FQbzE/GIuM1L8C76GS43UnLqugH9oUGZ00BuVLYX2+aJ2i07dlHGyZ3L1NRXojyn4QcwxWALvRBlMTzYxkqUbyU2+MbxJspF6DgnlbYN7KjhrChy0OswbuXVId2OouEJV52HxiNhBhXISEyX98xc6pdt4eRetaYhqwZ0jixXu/9RXh5v4j50oNmuo7KA4waQFEkntjp2hcA+38WLcMYALtB1vvcUVkRgyszAPtbXZJWhieRl7NwPpR0LwvuyJTnCUabhxX39bwnWACF/y3LV6uxacvqBW3XNpv2+jwom+g80TnyXTcY9us3KHgdFSqVpZRWxxgtw0cbWZ4Qno43/+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1342.namprd12.prod.outlook.com (2603:10b6:300:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 13:34:30 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 13:34:29 +0000
Date:   Thu, 14 Apr 2022 10:34:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: refactor the i915 GVT support and move to the modern mdev API v3
Message-ID: <20220414133427.GB2120790@nvidia.com>
References: <20220411141403.86980-1-hch@lst.de>
 <82c13d8e-1cb4-2873-86e9-16fd38e15b27@intel.com>
 <20220413154642.GA28095@lst.de>
 <871qy1geko.fsf@intel.com>
 <5af7726e-920e-603a-bad3-8adb09d2ba89@intel.com>
 <20220413232053.GA2120790@nvidia.com>
 <1c3aaab9-3bd4-95d4-9f9f-4be9e10e6516@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c3aaab9-3bd4-95d4-9f9f-4be9e10e6516@intel.com>
X-ClientProxiedBy: BL1PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:208:256::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41d4e8e7-4fcd-4eb6-67a9-08da1e1b8099
X-MS-TrafficTypeDiagnostic: MWHPR12MB1342:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB134208645FA91C049B3E47F1C2EF9@MWHPR12MB1342.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgvaAgseRPnEIieXwAz/8wqFbUryM8cYKbIji6eXeIIDYuWhfzkxeZY5zyucgKP9PS3FpMWLBd3/7YbVVPUaI33sclPMRPIHu8EhOIiGzJ3qBrUjnR6a3KNdmLiIU4W5e6GjfI5ZvqGv2n8W8ayqyYV45IyGeMniKUvOIdplJzltKsC3YTsh5oYa/211c/IyuFka0Hy1l4KdDFLSZqPiNpE+p9nHFrf96CE5H610S9cJ0ems/XUzhoJXrsmKyV0UIUhSX2nBzsCRMpIHuQ+IWJ173TTQp5w5CX0jAfG3LRsqtvNFqy+BP+SqR6gH7GPfoU8r2gFLTKxRqHJS4AZS2utW3zvId94MBhl7y5df2vcUCawjhdCpu0ojOSG4JOvArnkOWDK31Yzw26kyWfObvtAhrnX3TWpwRz3nOWEK25tFofotO+O3Bu4vlmhHrcKvkaXHzfiEuC2IEF+FMPsqXPNMYbBETwsWSfE3DgAI7rs6Yq2jUhr88IHPIaCzjvWkhxZCmhf09k0kFwsWJS3AB2svyi0wfv/RvRxUm1wiJsISMcPkI3N+tkV+ea4pfggkwR2HmUhf5qG4UkAqBmkMrkxqa0tzhrctK0qPlF28QgDEwoNTmQv6WumcL1jdDVrOGLimeAu3NwpnJJPFEeQuaWQCcCA8m+mRb2FGdkfw2A5ddij+6HMIzUBJz8x5z7p1HRhyhb3x42vjATDPXuGWpY4BaE2TcvNWfGsZVtNCCOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(66476007)(66946007)(86362001)(110136005)(36756003)(8936002)(8676002)(1076003)(4326008)(2616005)(508600001)(5660300002)(6486002)(7416002)(66556008)(966005)(316002)(2906002)(54906003)(53546011)(6506007)(6512007)(38100700002)(26005)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XNKSw/maWdOGIjgQGk/cjbsRh9XzYfBm0mQR/l3uCtLVjwElZHuEMAXJmEqO?=
 =?us-ascii?Q?kS2+kw+wpG9DJKYn2gGuVKajwlVkZ3lE7SK6TaAeyIWOb8cHFRql7adDVd++?=
 =?us-ascii?Q?K7N6uJh1sdT1NMtvdZaBsptHTg1SFKywTtTdrjfWbV5eHv6nS1DrZ0/ANUMx?=
 =?us-ascii?Q?0L6yudAf3n4My0fBeQahwbpm5eA8tYoBOF8ncTHCD8zLGW13Rb8hMUb51xVR?=
 =?us-ascii?Q?uLpRXpWxlfZmV+A13LYUHB952IqWoY2oQEpUxPv2lbI21K7VzSmCV/5SIKCy?=
 =?us-ascii?Q?7+KcztS5BAOsP7xe9S1Nun/o5HPyg6er8rEcKI1fsC44jwY42o/tUaIcMvaF?=
 =?us-ascii?Q?kGO32lGcEPBUzKu2+qgyK3QNLhqWyFwNlvea26ATK1RsyQB1whR39Ae83j5q?=
 =?us-ascii?Q?9wHdPo5hhUCM2W2pD5PEVOhLWCciQWDPeG8WnT1y2DIIR8hOIgeywHxSMDDx?=
 =?us-ascii?Q?yOdRKTTBjEdtp6Sd44hevniS7dvWwL5jOZnw8JFfpnp6Q119Y7+VQN8XplPn?=
 =?us-ascii?Q?t8qKj6MQCngIN71HWxbyeubhMSyqJUgrmfh1UhSvzXcdkQV1TdrtbDCHvta2?=
 =?us-ascii?Q?2oOWayMLVN/TEMsK2PlTj4VGgUTGdsZHKQ1Gmn25731Rp1srp9vKxUm0YjtS?=
 =?us-ascii?Q?peQnGarPFyzV42dI5DZvlqie07tYQ4KKSNa4vpDglW9pqy3gRcQt4rBrOHgD?=
 =?us-ascii?Q?D6okGtu1W5Dx8iGCxo577nsnEfIMTX9K1QbCcqIxEckBmYFqZLFEJP5RTneC?=
 =?us-ascii?Q?Sup6hjiTR5ET98jpJC814ZHl/NyaJR+UebFazGIADDh8mhfF5y9LAQ2Z5uZC?=
 =?us-ascii?Q?RNpp6EIhDNHzY2Tx01cA9vEA011n0LyKTlXg2F+37mlShmWx+oyfjkxIrl1B?=
 =?us-ascii?Q?utQFAMP5/DJ1eK395fcbTA07i+DM7KP5+GDcqvq0NY3oTYa5rTmkHtVNwf3v?=
 =?us-ascii?Q?xxdq3ERWcM7e8qVtXGTtPxzJ00EFOP1/H7O3fKll0mmY8tGOniWH/wPHuUvS?=
 =?us-ascii?Q?oX/vjxZ2Urvb8mftGDqX+0jQP0uBXoZE/5nVfLsHgvHNksRbllYBD2aPJse3?=
 =?us-ascii?Q?27+55MPH+P3Ff5bUKqZVHR6FZZxs6PfZqQ/oADaCHbPwxsuErcL+v9l56IIy?=
 =?us-ascii?Q?rymFuWuiSAm8K52YilXl9VRwUZgC/WhRaGJVeh1x6sRRKruWU2Mmxm5ailvb?=
 =?us-ascii?Q?iAhE1U7yrHpaBzwbX+dvy7aQG61j8njrZllm3TLLe4F8ijydpESauf/V6TgH?=
 =?us-ascii?Q?KDauxsIG0v0F14Qc+1couNYLvnZsqhYmdjn2un2tX7v/bAvtUCKqB7ND2x3r?=
 =?us-ascii?Q?QPGLLhZAWcOJaXjlOmL948U3v01ICBWYdRfZuK3gxhW1VKgp7Le1RtJv7c05?=
 =?us-ascii?Q?3xbL1OwlYLaLuPwMS1LUnkEbf0n6QhBdkh9ZQgzyc4AT5KYWkyscTcCK6H5c?=
 =?us-ascii?Q?8Lag+gXBHr5YHfh+GTf+2y4S4O0Uq3O7MXPa5CGxpKMIeXRHLdQmsfFVyPCs?=
 =?us-ascii?Q?vY5sH6vRN/rqIgJCgY+NbRVbLzORUI5Z5Dj8v2LE7tCUCFUhr1/NNYHmPBWV?=
 =?us-ascii?Q?hdH12pindT70w4W9ep2HIqacrsIZu9UTqCJnoug67FizY2qUg+MJHrMd0eRg?=
 =?us-ascii?Q?3I+ceRghOz1lg4Qo/lWn+/EDOq1/XbbWjmt3hvEaPp6U349kMZa0oSgBOrIe?=
 =?us-ascii?Q?yE6pLiZW+aQnsE+ROlyU7QiFhbOD67hi1cSYgjVzRRG2QaTVu98vUDe9gxKE?=
 =?us-ascii?Q?9cR3CWl9ZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d4e8e7-4fcd-4eb6-67a9-08da1e1b8099
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 13:34:29.8864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fzD3RDhVYrmYHJHY/HGjFzVCS0tL+TY8bybsZqtlSvT9y3yihxcu1xdUTV6TGLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1342
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 12:20:42PM +0000, Wang, Zhi A wrote:
> On 4/13/22 11:20 PM, Jason Gunthorpe wrote:
> > On Wed, Apr 13, 2022 at 11:13:06PM +0000, Wang, Zhi A wrote:
> >> Hi folks:
> >>
> >> Thanks so much for the efforts. I prepared a branch which contains all our patches.The aim of the branch is for the VFIO maintainers to pull the whole bunch easily after the drm-intel-next got merged through drm (as one of the MMIO patches depends on a patch in drm-intel-next).
> >>
> >> I dropped patch 4 and patch 5 as they have been covered by Jani's patches. Some conflicts was solved.
> >> QA is going to test it today. 
> >>
> >> You can find it here:
> >>
> >> git clone https://github.com/intel/gvt-linux -b for-christoph
> > 
> > There are alot of extra commits on there - is it possible to base this
> > straight on rc1 not on some kind of existing DRM tree?
> > 
> > Why did you choose drm/i915/fbc: Call intel_fbc_activate() directly
> > from frontbuffer flush  as a base?
> > 
> > Jason
> > 
> 
> Hi Jason:
> 
> I updated the branch. You can check if those are what you are expecting. :)

This is better, except for the first commit:

 [DON'T PULL] drm/i915/dmc: split out dmc registers to a separate file
 THIS PATCH WILL GO THROUGH DRM-INTEL-NEXT TO UPSTREAM

 Clean up the massive i915_reg.h a bit with this isolated set of
 registers.

 v2: Remove stale comment (Lucas)

Clean the commit message and send that as a proper PR to
drm-intel-next, then everything else is OK.

Jason
