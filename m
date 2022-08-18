Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6976598B72
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245452AbiHRSnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiHRSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:43:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F842182E;
        Thu, 18 Aug 2022 11:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgdVl7cQKHQ29sI0D07STPk/1HvgS6ho/42Ht1pFMHlh7ahzUALlZno2AHoj5Xrp4dc6YYJi1Rxk/u292mJr5aCduXYaX9JkbX+r9Y9XVD8olllXVIzk+DiqIYDox4OAqVw6tYryyLu6g55FhoVFvVQqsZSTqG9WYAYc9BPIidHkiW8yuHjKn8cLE/DUd6XOjLgZvVhYwm+boGXdaq3wgUjuh2s851NOUFzYpETs3xzKcjrxYDl9TDf+imKt2HfsW0efpcXFNG7fgr2R0dZwSyhUN/0FdKEnJ6OfsQ/NxPmSvBBymdAsaL6uX/CVrN08m2juKrAjah/dCnOFD2qDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjA2vHrTZI95iVXqEEdviIhLxQ0DcbkDxvY2wDolwcg=;
 b=JpcMcK7uYW9J30oSRW+TzQMk3Q6vgOwiXvxhadUSlF/D+loui+Nq7pcEkLCcVZwVlEqEbtpSTf3W18l5kj9elP7Wr1rlsuNsQbYmwHdKD4nSgsBMsi5yJplNbtPUaxJXZ9chXcaxVs9JAKffu9A99NkUHCeOsJKHX3aebMtmdOkJF+57y6ieVrFDGBk2usZjpDTgV2UowXlCh1qwNCyQ+/YylNVdeETzgvfWA/37G5fvxYbikvWwhNVrG7SnI953CZerXBc2AA91c0K/9a0o8Yqva9Wc7WwIeeRebyRuQBTMSC4rkHBwkn5v1jvLj65hh9Y1YH/nnXoxIKNvweIT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjA2vHrTZI95iVXqEEdviIhLxQ0DcbkDxvY2wDolwcg=;
 b=D+OnvKSCESaxlivsMBqnIA9vrfSXDXadwAOeXprV87hh56+EOp3bmDDdWZoV24xyFgbHTc38gXg0SDJiO2exYz04s+rOL+G0B688/S9JJETpOHMIoxexYVssF8qLFWWpX80kCO33bVLfZOxrbSQ7hlV5YFhsra1EsTniMjt2bhS3UA6/QbfaaCz5NalkcU0JasPt9rkUrGKjddQ6B+oebWvZDgD28UMZzAeb/E2GXyH47G0D+yW7iEUBKFh50kuid1nN9rNlCMis7SqRClcyQBXZeOF6RIxZNNEbxGl6lSKo8nXd9pBt6kJOUeQmk8GI1HaT8x7DpGrmdUQIxeWfpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 18:43:16 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 18:43:16 +0000
Date:   Thu, 18 Aug 2022 15:43:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] flexible-array transformations in UAPI for 6.0-rc1
Message-ID: <Yv6IQvlfU7BPHrHK@nvidia.com>
References: <Yug4IJHugXBzPWFH@work>
 <Yv4wUJfrkZ0tmCin@nvidia.com>
 <e2e9fcfc-0bfa-c25e-3084-200ae448697a@embeddedor.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e9fcfc-0bfa-c25e-3084-200ae448697a@embeddedor.com>
X-ClientProxiedBy: BLAPR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:208:32d::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9726fc4-8b62-4219-dfa8-08da81498304
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2tqOjC54e/0Z8Q3Q8Osu6pOONDnebWbVRhHndOyLPzKeOOAM+U5axQn99upAAK1r852/8N+t1UEeGniu6MmOXwKQdn1mV8SQpYwkMrBwnRmDr2Ttl3PvGhqDEw/Yv/rZXGoNCu5EBtvnbap58QtPL1Q1y5l9DLuMIevf8StDYdOQ28e5qG79x/5dKMykVYVBN4OOBRrthYthFkf3LNOkZwR90uTx5LyDxaaLw+ZFFMUqY7eRkTm05BkgZCRPycqaSMXwCKFWBuXAgKyZ0Hshrwe5O6gNbdmvcES8/NzrTIHipT8dsPKRXl5cXDR4Xcppa1fKgcnh5YjTVYU2ZzPSjcqAW3adYVYSfbDVrItXs9pUS1UzIm88sDeRCSVI6Wwlcm8qzeGN6lrtfaVFsyuWgOGaWaOchXy95v2qgKQ7mrQ6IROAJnald6athPuIAzhzASSgzjl9mv0W+gUJsOEAXmMkN+lq0C2HfBprghUJnGZfvcSC9eice23bJPcm4BQNO2dyOKq8hUtzEPKADzPkc19j0o1HohKYh8+JJj+o6hB1ybhqyzoN4sUVh0NHr4o/31q0lA5ROoIxUlJyq7X70LVwutnBQTeGZBuNE19jenR8D5kS7Rs6N7eZ40378K8jz0w8WvHVLLeDSqTvqf7A0Yp0Va44DGHoYW2tUQRzBlUSS/1gbZan/DGFnB6VpcKagOQKqPJwHt6lXSiF4UiiMWZ+lbhUadLL8o+hZzyR7SKspqPu3Th6ylJQ7+Nlu90PqVqh6tmKham3ga66EMh3SL74BsJE4qq/ABGP69NyGbj1mcGE9f0xtKooypzMg9H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(36756003)(86362001)(66946007)(38100700002)(186003)(2616005)(83380400001)(26005)(6512007)(6506007)(966005)(53546011)(478600001)(41300700001)(6916009)(6486002)(54906003)(66556008)(66476007)(8676002)(8936002)(5660300002)(316002)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/sRhLhmf3oh84ERETJuLTo5vQA/09rjbor294hyazOIHPhNxMQvEZ2diSQ3+?=
 =?us-ascii?Q?Tyjjv1LfYLh0R2wJPSAB8iPTAaTsvJGde7U9Ku+M8r2m9nfb/ueEn5Sclrxd?=
 =?us-ascii?Q?n5GNqt6lcnWG2affOMXLiS6dmriw89d8zEkseioSSOul5aOQCChjrkz/b7bE?=
 =?us-ascii?Q?EWd9FrVxy0cxko5j9x6Uraa8JPuTCMtTZQJm0AxrbuEerwM3TmFBVvsPnIHc?=
 =?us-ascii?Q?lsX2+EFbm1Fpnh6D6a6ZvxJWiU0LCJTFHghUfnSgcH0DsOh07IxB2Uj1n8cv?=
 =?us-ascii?Q?cX4Jk4FH2zlocZMRxECvnXV7Phd+yQips8frwqvD0LJqVXPBcq1FZOfNbaqa?=
 =?us-ascii?Q?1vmqoPw42TWUHOWqY/6p2Rmw90++RxpIXu6CyYZLq71fq3J3ltlxVRk9OVcq?=
 =?us-ascii?Q?3Cz45aAX7dx1o0yaO0l6CTC6RahYhP4qWVuVLo/HVuxU3KVgeCqEDPgWnOzP?=
 =?us-ascii?Q?CH6PyZ1d2W+o3OqnbR0/58OIclCgPY2QFM3kyIGTbesC8u3g7LDwLIPBOqFk?=
 =?us-ascii?Q?ogOMij8sS/ZZWm30760a+6aNklpoOz+5asDx+B9SvWgtM0Dn6F4hAVhAAqAV?=
 =?us-ascii?Q?bOSRqoNjy/r+FIpi2M3gwaGQwVPmtmR/fZNTOaHLuAiAgG0ypqmGClbKJkNQ?=
 =?us-ascii?Q?lJZq18zWwWm0KZAtP9MShtBWZBj1DYs8Ea1xPFpIREVdPWQzBY0xJcbrXRrk?=
 =?us-ascii?Q?op5VVLE1GEkp0QQtv9mrtIZBslmM9MfG+7KFWzPJI7r1coMinA7BLMNSCjUo?=
 =?us-ascii?Q?h/+L8SNEqtmxcPpdXX6W/udMc+NGQ/TZOBXOaICe7jM8yxZxht1nFyXJbMhZ?=
 =?us-ascii?Q?tG4jXYO7SPwA87RiHGu0V9mRVvXRb+2e3Bcgv43Z7972+BP3gBxUaddB4WvJ?=
 =?us-ascii?Q?+M63rHVL0T1kEqnBbz4IsQJewkoJ/fJetllfYeKU8fogp8em92bqYo21SbhE?=
 =?us-ascii?Q?g5RMvBm6T9v5cuH6YQcAuWJbB1lSqGdwQ+vmAXTDr6QJFV7XN9GRk1nesT+q?=
 =?us-ascii?Q?4igPxyCmwp/OWEM27C17KnBglb8vlOsX1dPEa9gbf0+hkA2iYmOBHGUayl49?=
 =?us-ascii?Q?N5N8o1+sSperPR/3CfmVsksW+4YER6gPIZ1UeepqNMn/rBd/80y3T00va6FU?=
 =?us-ascii?Q?9FLTjSqFXu10zAHFz5hgS5WsLMqq3CDk8al9+wLttL8ooxiAh5jc9vTXTYkN?=
 =?us-ascii?Q?/TyLqu1MpbDi2gwFesLvVJyqVPUYhuBTwQk9XrGvb92YBxcPMk7phnDpnQkW?=
 =?us-ascii?Q?yZAvaVPxIqeIf/kGzzLlgxx8PJ/ghJJsR1so2D92RgeazrTWry5NrErTBDa1?=
 =?us-ascii?Q?JJvO820U6RCX61gIuxsaqUek9EDTSgVdQu/S+DTDnfQf9SOJXBPtXWHHD8tW?=
 =?us-ascii?Q?7u0BTA5zSLcLPbHf6muhcyckOE0v+D6uqIN7vQMtId0Jac5dZ22sBjx3ZoHk?=
 =?us-ascii?Q?HOiHsiquHD3NwMmAhvuRuduajFT8eEZ3dCa0XD0/TDHqArd4Ai33q3OxN1a4?=
 =?us-ascii?Q?nT2ycnyEHBFNf/iJCU+No3l+85oLXyeaceNATbPf2HXX2hsQWORSR998QsaY?=
 =?us-ascii?Q?GIC4h8ILKw4a6F+Quz0F4CcSQ2gY/YOXzB7Sop7E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9726fc4-8b62-4219-dfa8-08da81498304
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 18:43:15.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GovGEdWkWEls7Rtz5dV4NPP3X3zr2cJ//wWmARuVtz9L87QdoUOvBnMevBUVWcq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 09:21:54AM -0500, Gustavo A. R. Silva wrote:
> Hi!
> 
> On 8/18/22 07:28, Jason Gunthorpe wrote:
> > On Mon, Aug 01, 2022 at 03:31:28PM -0500, Gustavo A. R. Silva wrote:
> > > The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:
> > > 
> > >    Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-transformations-UAPI-6.0-rc1
> > > 
> > > for you to fetch changes up to 94dfc73e7cf4a31da66b8843f0b9283ddd6b8381:
> > > 
> > >    treewide: uapi: Replace zero-length arrays with flexible-array members (2022-06-28 21:26:05 +0200)
> > > 
> > > ----------------------------------------------------------------
> > > flexible-array transformations in UAPI for 6.0-rc1
> > > 
> > > Hi Linus,
> > > 
> > > Please, pull the following treewide patch that replaces zero-length arrays
> > > with flexible-array members in UAPI. This patch has been baking in
> > > linux-next for 5 weeks now.
> > > 
> > > -fstrict-flex-arrays=3 is coming and we need to land these changes
> > > to prevent issues like these in the short future:
> > > 
> > > ../fs/minix/dir.c:337:3: warning: 'strcpy' will always overflow; destination buffer has size 0,
> > > but the source string has length 2 (including NUL byte) [-Wfortify-source]
> > > 		strcpy(de3->name, ".");
> > > 		^
> > > 
> > > Since these are all [0] to [] changes, the risk to UAPI is nearly zero. If
> > > this breaks anything, we can use a union with a new member name.
> > 
> > This has trobuled the RDMA userspace by creating new compiler warnings..
> > 
> > We discussed this and I thought you agreed not to send these changes?
> 
> Yep; and as I said in that thread, I went and removed all the changes that
> were causing trouble, based on this report by 0-day:
> 
> https://lore.kernel.org/lkml/202206241055.Eh9MKMAE-lkp@intel.com/
> 
> For instance, 0-day reported this warning:

Yes, I took it for granted that the patch wouldn't cause more kernel
warnings :)

So, this is what we ended up doing in userspace:

https://github.com/linux-rdma/rdma-core/pull/1207

So, maybe it is OK.

Jason
