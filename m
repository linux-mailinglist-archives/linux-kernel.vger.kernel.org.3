Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66E45AEE9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbiIFPWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiIFPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:22:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD616241
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey+NKP+PkfUvkcsPnwuBVOdSch/XhRq0Ki8TpB6WmArfMRZUUrY6T1mNE6WB+MRX55qwGwv6Ir9h1K61fJguVehDdQRW79KgozZObolplc4QgS/QuKj5e1kqL/iG5Xf5t0DX8u7o86j8NrMCd4nJr7kxBjtQVDtiV7S+QdOeHs4lCTDCV1OW+V7kt8ieImirWEFxV4HB3BLpn5JbsyCr/4uYN+M3nyE6DAsLsjcDHQiTVXdXEzKkoRtkD3Nxu0z3l24xuY9/KliGkLQC18ECgGPuM97zZiqammfxmDOnqhD/2nePKIBCSiFWoRqR6sBqbGp3UKcX0Q5+oLYg2BM+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjcFJuczjfMk63Wmdu5f6/Yso2XfwbYelLaouT+i8Ts=;
 b=LMYppf1ANPZEotV9KwpibfIg49j89fx349VkvZPWCrC0A38P4m/DRSCUPSmPlSZFvJNtytEaT3/YzPdsMHun9IEwaxj2m/dZUZGQSa339hgWLA6y6aPggt9bW2J1XPqOp4BxG/2BzwCja71bcYYVyh6xq0+Xv4m79kWG5ZmGcC6jqI+XXqdLYMDLAgbqQ1mBrF8BXX+4Py9ittJ/WB8rwt3YmsUmebMkwT4egFGGf7GJ/olgxFCunkG5pC8Xh3HSJt7ZoYc+NtS+IagBsq4BTrlKYdB5rfBZRVc9QnRnV1Wxss8bt2sWbyb6vUIuPKmsG8jL2Gv62qP1K+O3DOpjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjcFJuczjfMk63Wmdu5f6/Yso2XfwbYelLaouT+i8Ts=;
 b=qFmR+gm1L3La/rIvaqYcnssg1amMltk851TwASp+nZnTVHGQyBVw0921Uk2wkUNkV33Ah4HRLBZpEta17QZpQIbRbEQDg9gDyB+7ZlCpqCEcEEYbUQHbr33G9iQnPFpNha8SCplZNqNtLYDayqmjehWcRAb6Vh3TV4UcXVGzeFTnew+eVoChQ0cMisX0KBl5HZnYhzYtjAcPnUqZsG2q3lAwse2CfgMl+Zr2cJ9xGaBCsf0PZmJfqfOe4GoUjiTrN49r94WfapfFrOs35rTUgrniTujyQO8/2/2Te5X7XOAwr3W7j2ADOy9zA3oWKI8VBiot75biQ/kb9hzw3xvmtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Tue, 6 Sep
 2022 14:30:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 14:30:45 +0000
Date:   Tue, 6 Sep 2022 11:30:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        peterx@redhat.com, kirill.shutemov@linux.intel.com,
        hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Message-ID: <YxdZlCly2ad1rtcI@nvidia.com>
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
 <YxdPi2E63aO0Dgyd@nvidia.com>
 <4516a349-49cb-fd7b-176a-f1a9479906d9@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4516a349-49cb-fd7b-176a-f1a9479906d9@redhat.com>
X-ClientProxiedBy: MN2PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:208:23d::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaad170d-f856-45f6-1d48-08da901462c3
X-MS-TrafficTypeDiagnostic: PH0PR12MB5450:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04wpOzXckxBXRu6os36Og5MDFwuuU+s5EeeOZPAhSyWdf7KdsCRtuWYd6Y24wMmu7yDbhcgTPXQt/Pw4GlX4yjmZZVkZxTbrMWAx0ozmSgGiFzy2UvAGre1msEhkT0YjRuT5wrULSQzLM3x1Z/OpZY5KuuwBS7M/tBpgxyt0evkJ+55NM09v39kMuzoodhR4FDCFMkLeRmhKVFR1Za3VUKOe+isLsJyS2RYPCB3vBNt+C5tHwjUwQnmL/FD5lqWm6zZJwDS9Jalc5RmPRgHidvIIRf85bzP9BU/D0MSHqMDSMLURhBwxhPJrchAHtAGvGfgw920ZWGYA4oX1PdSkwyx0MWaug6ZjofAfyRN2bsadTm0A6jfii/vAjd+8GRrhIcC4F56uTbaz20rfzXPfC/9hod/cb+YWVuunGYT9X7aiVMZuowbqzjVZ68LjYQ4mHrH/eyDhWl5pz2YCdDp1AN8W7dqGdxHIyys9eHk2938wlJjWQLw8ffmpqBUYJkZfeARuYp/j7TI/UoByMZ3E100mgjPX0tLMvBajGwT4EvoZqUM9d38ZyOY2GxMFLtqLPe61t1kv4Ce8Nj2SdX0/J6AtNXCs6pg7OknwDNV2qwzF2yuVmHyodJbvLGuZBPs6yRpBgmdHKgBuN1nLPBoXzdgwvfzi5lIS1JfyuBWPbZTvZAAVWobTCLZ4Qj+v3wX6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(6506007)(186003)(2616005)(5660300002)(8936002)(6486002)(6512007)(86362001)(26005)(36756003)(478600001)(41300700001)(38100700002)(66476007)(8676002)(4326008)(66556008)(2906002)(6916009)(66946007)(316002)(83380400001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6RDNXSohu7Q32klRKDUBhqxQXeNH+D5UowIim2D28snJbxj65lKJIL/kK5MS?=
 =?us-ascii?Q?WCMGlXD9jWV+J52D9EdOBR2jRdf3tks8KsqDAu1aNVubcSfdLw0yZZAs7+gc?=
 =?us-ascii?Q?M7ATbM7aX2AWUugdujJSS8zK/09XvS3yHte3KJklfGJqlBKS5drcOlm4uD+W?=
 =?us-ascii?Q?GwhYF0pxnXjaRD4VvwuzqSXXMONJTMX6YWGwd66ql8057joqmvIpvk4K8JSV?=
 =?us-ascii?Q?4RZ/KlC+HZtDfkHcPy41eF4oQuOtHsW3kATV9Yby2a9rxbhgsCr257QSgQU1?=
 =?us-ascii?Q?c8OvQP0TBr5BW8Kd+cWGTlGGupXi5ZTQ40vYqNlTuZYdIOGhzd8ytZGYLpl3?=
 =?us-ascii?Q?ZSlCLZ9iofrbZmDnHmhQ1jg9ABJnuFwgphYnm7Ody7XHNM5n6fAmgIUrVEYt?=
 =?us-ascii?Q?teQTQ9gYqmI7VNyRPsRUyEn0/L94l1trRMqLVecvP+W0d97gQmWsip2HENrI?=
 =?us-ascii?Q?xdOEzrcuphpKWbrU2IptrbOvIuCxAYlrQ3sO2CYIFb8RkpAmsI3ybf8g0LsZ?=
 =?us-ascii?Q?NsB06Uo6q53Oc9ewzc/VxfURB9yNRUyIiN5EfKAtHxgnL3IqrDS+tW0INuYD?=
 =?us-ascii?Q?9vGlpSPkUOsA2KRzRXatGMTDjcpafbCBQzLux3XccQQhHE6ne5c9dHbrBPw5?=
 =?us-ascii?Q?Kl+xwBQ/3VGGZRTniKjaFkwBnXK+neNcmxxy0oYdHt2J8UkKxxXxzP0yelRc?=
 =?us-ascii?Q?wnk5jidmsxreRpcunRyeiIsLtrH0YChF12Com60SOs1qJMSLgXmtPq5tV1LQ?=
 =?us-ascii?Q?uxQtvL0a8pDaxia/N/OfKKy8Wt/KHqwYCMXt2ykS2FAy4HKUPzMajjUB8L9L?=
 =?us-ascii?Q?aoXAkXSfIYqS1i8OTedTXvXtOVo0RONAVWvbYbl4bOQ9+XwQMKs1aQNVB0Md?=
 =?us-ascii?Q?xEdq7QgiaPrWdOlb9WoaHYdocUyKiL/CKjxxBP+Rix8ux4tgd+JGeUD+vdLw?=
 =?us-ascii?Q?OMevGDLwPjEfgSV8vbcCRel7Iz7jWQnbSuJmMauAuyKQdwIaddi1GLRaoRKC?=
 =?us-ascii?Q?zJMoKPKgncXdiJI7XuChUnU+/LcGL+FVWbNPdw0ZSMoQgA95gjIeTzLXVzul?=
 =?us-ascii?Q?b95cJ1Fwn3FQMkFcEMriuiF4yrJs599ZIClBglRZOSqpWeY+y88v6ctiLJGL?=
 =?us-ascii?Q?6n4fLNOZKvwvpolPc8pHy9jWSDi2pWipj9aaQoS4Db7Bj5QtORvIDXPCwRIv?=
 =?us-ascii?Q?ySBzozugCUX91cXmDrLgFJ6fBSGweKGr33jVqw+Qb7znsiy/z94EgRNi0QO3?=
 =?us-ascii?Q?P1I9IMrawHCq9TVrhabf5FpSDqPF4Tfurh/n5/XjfpIJoe3bCMf/IOXKIXy1?=
 =?us-ascii?Q?aGm4hY4m+aoANATamLUtnSWqo9i1Nm2wuSbYICpireY7h+ML8odEeEt72M0S?=
 =?us-ascii?Q?ETsIdLkcN9wu7aiJl8cVQm//kAvySkn3vLr8zvBkEIgHf3kmr4qKCX4ZreLl?=
 =?us-ascii?Q?tSkQxgoc/wpsbkegps7sEODS4x0M4+sL/Ij/CfxAamD16eFMeG0fWQ/OiqAz?=
 =?us-ascii?Q?JojkVU3FK6OGGcZ85gcdxpKQG/lglKqScpODRIsr8amXwV48pePwrF3493Iq?=
 =?us-ascii?Q?23X2/5/k41hALQ0mrAZOX+z+JBl8foWY3LXW9Bc5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaad170d-f856-45f6-1d48-08da901462c3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 14:30:45.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTqXEqlflDydwtI+DNQgOVWm0sm96+h3V0bwn8dPNQldPaySPyPzNrrTvnGbiuNC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:57:30PM +0200, David Hildenbrand wrote:

> > READ_ONCE primarily is a marker that the data being read is unstable
> > and that the compiler must avoid all instability when reading it. eg
> > in this case the compiler could insanely double read the value, even
> > though the 'if' requires only a single read. This would result in
> > corrupt calculation.
> 
> As we have a full memory barrier + compile barrier, the compiler might
> indeed do double reads and all that stuff. BUT, it has to re-read after we
> incremented the refcount, and IMHO that's the important part to detect the
> change.

Yes, it is important, but it is not the only important part.

The compiler still has to exectute "if (*a != b)" *correctly*.

This is what READ_ONCE is for. It doesn't set order, it doesn't
implement a barrier, it tells the compiler that '*a' is unstable data
and the compiler cannot make assumptions based on the idea that
reading '*a' multiple times will always return the same value.

If the compiler makes those assumptions then maybe even though 'if (*a
!= b)' is the reality, it could mis-compute '*a == b'. You enter into
undefined behavior here.

Though it is all very unlikely, the general memory model standard is
to annotate with READ_ONCE.

Jason
