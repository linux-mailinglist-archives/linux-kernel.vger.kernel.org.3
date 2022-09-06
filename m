Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76C15AEFF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiIFQJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbiIFQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:08:43 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FB19BB47
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHLjvTitugnNz59y7odCy57GPzbh7xW7XlfXXs+2g0DHsmuF9PBYoUSaOCE6o8e7zTaVjxufmPO1MZsxzUpZnrLxQgyylWAWP8lU00kdwDbGBr4vxkBFlPxzXl11BqoYbE42KsLbOo4TPBvjlvZsmMObtOO38T0WK47fFxFbJA8K8SWLDAUyGdyqKIluKimMsgl4/Vp6tOCuzxPX3jhy0eroE4HoIR8LLn5ihPjstPdzGRz8li2eZaxI2JQjAY8RvbfpjOwPdTf7NW50S/XuKA4KZ7FKlhhTZJhSaO0AfcdTijE7odqaTschBCjd0amcKVYxWPuRkCI15OL3WLYZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85zNFP4iOcjSRuEklV+/IZ4dHqEv1vmNtNiho4vIu8U=;
 b=kWjeNz35qsXYkky2VQJPVhyS9U6sXHY9L3Yx8LKYvhRmbiSN2tFjCh8XYKoAca6SFS0WwcTovG3gjAi2TCGD5bKS5yi3EGXUY6ys2g7gp74p6vZHylvBf4xrhPz2TJ4RQr/uD8mN/pvR3LYggwtL/Yf1+cyviJE+pSbX/3miBsgyIJgTtkRJta4NdYKVLbNT+vNbayax6pqkFN/oxdtGADVgNY5mq2XoIqQQKCjPYOMiADeFoBWikelYTMM6iNc9jq8pOTA8Bf2lO64CW5xE1/8b8CLhE3US2kJR1Po63P12Lm/7+HjYjsz2F+j5TqkhCFK4NLmyJaMbBsucSs8Bww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85zNFP4iOcjSRuEklV+/IZ4dHqEv1vmNtNiho4vIu8U=;
 b=BpePv8xGT6pleJKvFWrAgrGGjFZyLh2hMKb8AAtMc7Lb5F3uECQ3yb4CqSMc5WOvK+j1H/1PRzK7Sxz6xui0Qd6lfedFylDn8Hf1UOHQlXRErx9vK3SvjrjutvWiasxfjuKy5nPShFKOUqxhaeb0ankXQuVyiEYYNm5BFtLFD+h7H7BeL5tc10zS+ZgO/DjJmQVR4tJyQ1/TYvutWUduVOeVS++apuWaCD4VftibPtYjO9Q5d0o+o9UTmz1TMrGZGslzrL4wQmPjBkqQWQ4eEr6wAkcdfl5bp9xyXu6BZ3RzQ91uUrBsYT8tGu14l/LsDM8Nv26BcFeRl2UTcPhzGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 15:33:22 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 15:33:22 +0000
Date:   Tue, 6 Sep 2022 12:33:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        peterx@redhat.com, kirill.shutemov@linux.intel.com,
        hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Message-ID: <YxdoQR30GXfTH/6K@nvidia.com>
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
 <YxdPi2E63aO0Dgyd@nvidia.com>
 <4516a349-49cb-fd7b-176a-f1a9479906d9@redhat.com>
 <YxdZlCly2ad1rtcI@nvidia.com>
 <40486dbb-9f19-6fa6-d46d-99d2b033883d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40486dbb-9f19-6fa6-d46d-99d2b033883d@redhat.com>
X-ClientProxiedBy: BL1PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:208:2be::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31ecc236-6791-4176-32f6-08da901d2202
X-MS-TrafficTypeDiagnostic: CH0PR12MB5026:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqulg8r9sWvU3SB7dvTYHp3a4XzAJldbu8I8Uc2TpSWQcpJyNa6pZhRyEYUi7uErxPjTeXGoItZ7vZY7TrTG+f3U5pt9PbWPoZ/HMWowuzLwi/hjbD6JZp+Xx7mxMVlg7WcalL/KCDiDjTp0/AAHWwm2uwGzjL126cbsTMJfOl0J+t4raSRnfZomj6lc5xgCFozibRODH9AlCyouJ4t72HQqx9wZk2J2ohswxncIQsDyn2DjtrUbp8K2KK23JNfqdkuc8ThIH+HrwaWqOpXozt6wsSkJCFCpj8jeZbXfqRnY53Wy5Zei+xAoXyzYqd+dY6V8ZKwA9IGI8jys6sFzGsz83fAUP1fkTDN/gwjsbgj+2dShdkMnobUckKrYYi8eThCYXbtrzMlErMA+sRgApjcu5G6Hfpvgv/CKSRGF5x2wD2k/aE8yzI6JGWxkNoH5WUORZWdCFMw5rJKhy9T3TYoTxn1lAGuLwKSd8NH/7je2/Ak5Z1cLV84ao4XWBlkI5Xk7VaLk8vgacdFym0QaiEZhHu+ghiUt1hV9TEduRbOa86Sui69CLhGrPjSVRj50V4B8CjYdUg4EPhHgFQC80bUQESJ9hcZnDGRWPzr0/NU4+oweAEBcmqdBLSC/sbh7PdHsaBoiXJl8+Tucvo8DZeNE+GNjn5fP/rKKcPKffRWyyQvzWSUm0wVcjBJ08OfhR8LnaRzZEjqFPiEW+t18ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(316002)(38100700002)(41300700001)(36756003)(6916009)(54906003)(4326008)(66946007)(66556008)(6506007)(478600001)(8676002)(83380400001)(6486002)(66476007)(86362001)(8936002)(558084003)(186003)(2616005)(26005)(2906002)(5660300002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZbF7FP8mYqYoJHcO5yBGRUTbv12lkchZ3sNFPRJIoKlmXMTutFqR0Dz/oOpK?=
 =?us-ascii?Q?adPDYDhvl7aOLqhWJIEgNFvvoIdp7w+Ot3mT8GpBlBCDNmdO7dS9hV9sf/Bv?=
 =?us-ascii?Q?zjA7UQj7nncb6gEFhjRVcv3b8x5OgZsQafRNWDVwponsj5IulgTSEKM7PpMT?=
 =?us-ascii?Q?NWnjBtFN5Z3Zxgpr0K0mein3GSN26mubyFdu0Q7tR3V3xV7+kcFQCzQ2o2A+?=
 =?us-ascii?Q?7oRsmZG0+fKqAfGoWZCzETEoDhdBwcgUQ1Dg56QEjXuR0rutRl9ntAhoyoXh?=
 =?us-ascii?Q?KJBIXG5kIFHGCsFrbOrUwuGZHVw4ckeIEeowU+TmsgppQGQbkWaytE8DSLw0?=
 =?us-ascii?Q?iGJdeCNvvKIz0Kfza94UbwwMQgKqVwPNOJ1ojmJ4l9ltFiCDXw8c9OU3P3Kz?=
 =?us-ascii?Q?Lf2vk5nPBqto2tVxIN3MX4W02IUgRobLPVMEInucemvsC2bg5+kuKFBzUpPy?=
 =?us-ascii?Q?dBIwWsmIqzdsoPGAUXgfT7T82yHcbCBFG6bvCGbpPHvwSAUxqh+E6LPFOVaN?=
 =?us-ascii?Q?n/ICRvyXVOTRVZphFmqVGm2mkJ3PFn+uz2qYGCz23Milno1kpFOThtc9fswg?=
 =?us-ascii?Q?wC69sWK3OQMXoML3tUptZ94KeD3hF2EfR9h5fJj243FUV8bgI2udgnvtNjbb?=
 =?us-ascii?Q?aXJsknFhYYQxHe7LudpeO8titnEKMxCZhTO71VtEOVIysXU0mRpRI3FwLUO/?=
 =?us-ascii?Q?/n9MF1CsLHOuOh+zmebJ2ep9nB3YQLfjAOrJpweYhDF8ozhvIMd1tRinasff?=
 =?us-ascii?Q?YnctdXvgPxYGo/F+Sylhr0r1Hd/0ysfQIiuK80PwPXWc+c+nwMNZCLk4YiF1?=
 =?us-ascii?Q?42IrspYP71ZV60vL0PX2GB1WraZB4IHktFP0P7lxEq+Y2PrMY/AKY5+4wWIX?=
 =?us-ascii?Q?wu46Go3AYufJQowlSpeBFbjnfYAcq0qEsyBelnUt3iNMZN8vHFYvZcU7ilgW?=
 =?us-ascii?Q?dIsMJSvbBIpGQNglLiSF894WG/RTCJ5jje4lx7beTrinS9xYOcUonTUxIu+4?=
 =?us-ascii?Q?EuJWf6JktrJ2+mMcBTGBqd8zTAJB9q3xpAt4kgOKSB9O7r9E00cKimzwBXKL?=
 =?us-ascii?Q?lDeXDzmJztKrzrLI5KsXXkpddWauzRRsaF+QzdGYfk/f5MkeJNazIzRR/qvU?=
 =?us-ascii?Q?gN28/rBMDm2DskUMZboKOL7e14Rg3NqzvPXIGwXNbe5SLirsutO3tRroK/VV?=
 =?us-ascii?Q?dH8g23SkSzZznnmOcCmKuR9EcjzoMrdklg5yPeG9k5f0hPvzInvavLueGAet?=
 =?us-ascii?Q?gHDKb93RqDPYL0qz3FQNxygJZNReHDuFDI7myvBuKvTixWwjkTAFGSJagapQ?=
 =?us-ascii?Q?l1NYJKOJvi7WSttcXa5tXDsIfw2LgeWaBQjMe3XE+9a2Mw8M5cDadfURFui5?=
 =?us-ascii?Q?bqHpyFsjREgRmbcD2CGluL4wNo39Pz+3aczhRQsj4epy9kyfB2TVGccmN6En?=
 =?us-ascii?Q?jr0GYTq3gOZh9npJtOh6PXEAw/gWUTyD+Yw2IwyLCwmpO28yytjvrt8dF0p2?=
 =?us-ascii?Q?S4v1seL2AzSTzXLDqX3BCy5OFFyx/zAHpmL88omwhnLQWoCJzHkyMsSXnROD?=
 =?us-ascii?Q?nV1AO2KL3bCWentCp99PVk+en88sQZ6tSTNBU24N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ecc236-6791-4176-32f6-08da901d2202
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 15:33:22.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAYWzqMobjPYE13FZTYr9n+x0o1vhuYAnjNh2oYb5eIxk6/7gufaCLpEIOBpUD8U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5026
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 04:44:20PM +0200, David Hildenbrand wrote:

> ... I do wonder if we want to reuse ptep_get_lockless() instead of the
> READ_ONCE(). CONFIG_GUP_GET_PTE_LOW_HIGH is confusing.

Yes, that is a whole other topic, and you may be quite right on that.

Jason 
