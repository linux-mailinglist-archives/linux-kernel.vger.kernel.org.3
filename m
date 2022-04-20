Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E879509399
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383212AbiDTXaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380110AbiDTXaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:30:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73F52BB0B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laXXx3vcbCupilLseTShywqyssYTlCs8VGp1dWyvpbAwMafZxZHp8vllG0XmZErGysjTDNKGtm5gjCjDbSx/VZh2p+R5Ppw26mCHqHdWV3hm4EZS187xZeGEVpFRXClvm6yHlxCRla85Uq//bfvFmNB+chI8t/6TsDqsiAzzrl8F+NXs3qtkzd4HkHR7QFz8piCn4lodxGpK51Cpg/4EaChCtc21adbpSmtDd5NdHEihdxpa7Bm3MzKMPE2sgtHcOpnGOt/2sBE36bl2fLCAeomYoZNVxaJGK3ZaS0anNlQXU5E7Wg7Vi3MtMRdWQCvwYdiEe+OO0max6WVUs/SsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yjupl42w11wr9qxs1zonzXmKpWD6dCo9i51kn1DPJd4=;
 b=ocspBtWcuXwPmQ992ur+bJCNzMI2mW47Rg7n+jpenFbB8LEqGDL1hfs7I9krbol8QChMVvPlsaLbtI4ZBjbA+ho2FiZ4qfjq6rQ07or+jt/oGh0wooYaqpeZafGfkozYfWys86JltRr726teUu5/ziCwU7qsPzVLVuixEKExs0UspPNlu3y89pxHGBWZiZAXTegOpbopwekAU3Fpr8DJSxBsrsdmrN2JLdK8QJRcytdEfgJphXs6fd1ALSbvn5Iauq6matZ5eTcnrRlUnj+eOT7cLqSiPSRB5sLFiwvdG5kphZ/jj12g6+re2bsYys3H1ezsfdfV/EXICGO1zH97nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yjupl42w11wr9qxs1zonzXmKpWD6dCo9i51kn1DPJd4=;
 b=Nb93N4jAg39EnrFZhAoT9YOVhGsHwuixVJpacHKaBV2jshZF/Xd/fBsOirx6y7vXtg0B1SgSt06RQOGGJk67K/QM/R2djq//4MUiOZoojxh0hvSB1hAiCJDR077l+s5mMGpCKxYJvenI6ylGbn3ow5Jdgumrc/8OP6s8TlkrieH1XJlon/haB1KrXzczfXuXCGqqb/k9fF9850H3iDhA0aWcdHFcD0yIh4mSDZj8ykcwvvLW787rtMXtZVSGtCrMgTfdtGu3M+8XroBXDuqd7lhltkvJLCc7WKCw9L97dSq/8gxWtMLEEU3mZqMrmF+MlV4aR3HtpNatCwIC0eYM8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4714.namprd12.prod.outlook.com (2603:10b6:5:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 23:27:18 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 23:27:18 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] mm/mmu_notifier.c: Fix race in
 mmu_interval_notifier_remove()
Date:   Thu, 21 Apr 2022 09:21:06 +1000
References: <20220420043734.476348-1-apopple@nvidia.com>
 <20220420151142.f60307e749033a24ef0c68d5@linux-foundation.org>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220420151142.f60307e749033a24ef0c68d5@linux-foundation.org>
Message-ID: <87ee1rxrn1.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SJ0PR05CA0177.namprd05.prod.outlook.com
 (2603:10b6:a03:339::32) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ed7e0a7-8388-4482-5042-08da23254f51
X-MS-TrafficTypeDiagnostic: DM6PR12MB4714:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4714369FED4A3A63362F8B8ADFF59@DM6PR12MB4714.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rs39ZbH+K/skTOsSOntbTuJ8kUw1HwGGvG3LvUQ5QFjlQ8+e66uQCJb1/gR5Crtx+AyZfOnwYiEC3OsOq6DGcHIiv7UXRF7c8SCsOGX5QDyYONXrKa/QBz9JJodk8FiIIC2fh+e18M2Fjg/K+QrecO8mnYL1M7oqqoSZvJ5ztYpIKBa1BqNxibT8TX1p14du3G0Y1f7fTX6B27ACWgcxpZpSHhUtO3tt/ml5IzG/5w2LIqBG+AhaqmHBF2RDWIzYCsIaUeLd/vVQQdnGL3sGfy5r5eG/u6eW4DnZdnzNZEm43fNdK8TrTPuF8NxdH/iNHlPIVlPpNwr4z9geBlJpztvu0gOqI+mn4aarH2+icVndnuUijyodeEKC4TACKz4nmV3zRkc2wuor2a5nqAuGHsYCJYxScGUvrgKGvzUSGKHHNCt8Phb2pfQlAvAdOZCM8uYtqxT+GEx3PbyYGh5r39ClU198MsHwC7WIox9xRiRJ6xtPnCPQQJTkcTaD1/RdFrhIoG/1Oi1jcN10OSBAk8HlpNTSAd+UjY4kWG2OxjHbWEvZW7EM0EQm5i2Ki7I9CXrsOTg4Vqhqdp84+dLLvw+FDXi0m1aF3nvL1amv+0MLjzeKVMTgikd3HbGoIdyCnNh3oX6R9G1qhBjmWu3caw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(107886003)(66556008)(6512007)(8676002)(508600001)(4326008)(6486002)(8936002)(83380400001)(86362001)(6666004)(44144004)(66946007)(66476007)(38100700002)(186003)(26005)(9686003)(6506007)(6916009)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3FuwqHKtCTxxaVaxr38JYI7zhFhpqifYLQxAHulfaGgEEb4mT3XZCYOZxXZ?=
 =?us-ascii?Q?d2QWdOEp1KMo9h+gC+eamiPjoX0ElYTOplj18RS7uyYlZYnpOJQPRQrXLpMl?=
 =?us-ascii?Q?OgAGX6+dzMal9D9aBRaHNL+rs3DQkKEPCRnWuVNeLLoNqJNt58QecQ1VTeiC?=
 =?us-ascii?Q?EbKOOVlxogbNd54oOF2psHUrkgYfgw5wR6e2WFZPWB0xsuIyxoC9xmapV8L5?=
 =?us-ascii?Q?o3yk8AWUISjXkdAfuXyEaavTFEimztWv+YOzZhsod55PfsLjZcOMZvW9cZk8?=
 =?us-ascii?Q?kVdqJNwbRdVnUNaFAQ7JrloAKCeTuL9ngL5eJkiGM+rUuMa791XNc8KGgGmJ?=
 =?us-ascii?Q?wxcdKpj/LDeJSzQkVl5xkhn+PYTRWJwTo8fhaYIp+1p8f//xWki8SxqNabez?=
 =?us-ascii?Q?gucyR5+0PJL5Gtkqyx5M913hNx/xcaCAuv6qFalEd2A9k0VdnLjCYQuJubz8?=
 =?us-ascii?Q?1gs7BXW2lWcEKRAUbgvQkQVcZ0yI6JQIRf8L7kRTNefvDmYQo5oGALovAlJe?=
 =?us-ascii?Q?4G+dzojg8pvoEWkblI/VqLB2HwxQ1YjU/Z0A0dQSLfSNkUE6YU9mCuIiBanU?=
 =?us-ascii?Q?HIvUbS8Th53naJM5NuL/vI+2u7iRLdxe4nW+yGS+IaVdYsXtL7wuu6y3e4FO?=
 =?us-ascii?Q?rHmVr43aVS5jR3mIthCyKm4DT0s06oQjq5kPW+LAiQYMG8wAEQfqvVwwhiJW?=
 =?us-ascii?Q?Y3R5dmRPH15LxVvd+03QATeUQVlD5VmykZ+w1WBjuWL+4JK9Vnr0CIDweDG7?=
 =?us-ascii?Q?+Zz6XCJrZP0DLehkmv2coA3MVA8bev025rchW3YbYtzoZn5FL+/d9n775P12?=
 =?us-ascii?Q?uHiSXIgOKSwMu5tebqkZJKBdhoYxYdZ+N/rz6VPq87hnI/8M0mLJ1Fi5iser?=
 =?us-ascii?Q?h041Wciu1dcoCnB3vX7p5pALxGAsfs0CgKUuNateyOyvsqWKFmUVNGYrq2lE?=
 =?us-ascii?Q?m8gL/8DRh/5QGAc86KrUcfQPvNMqwc3QV97oOldXcpnDQ7rezcISkyEYb9aL?=
 =?us-ascii?Q?UeIy1x4pnR0QvtwMlcvTlKH2mGqyHwqlu14zocs+CrB7ykPISgvE7ZQsaQ3y?=
 =?us-ascii?Q?I3vG906vKa6/Ynv4K7efFhsb+b63IJV7KLN1bz+FkkaZgbD+h5+czc8rdHym?=
 =?us-ascii?Q?qV/IvQ+iikhcaQ006HnsvdyFp45b8dN+FZUe3cPJBxDJaHf1FWALBoEA7F/T?=
 =?us-ascii?Q?u0qXkI0tPS0TM5A5G1L1T2LXC+hmRJ6VDvoNQl/aUl9blES1FSavsPRGOm0I?=
 =?us-ascii?Q?QvFA+3E/vTfjteMJGv+RTeBQxiP102No8pAGM0wHObcGkwtSftEjJJ5caLAg?=
 =?us-ascii?Q?Ll1HybA2RC5Na+pZRb4dkAqbnLUQdH/Bopb/E+gBQPOwQMxKbWU7GLVF60u1?=
 =?us-ascii?Q?AJuF3KJ+nwVbSS8E0vlJB9acPQ2Z/FZMCMDI/zPIjhu3614It05nip2hSaSC?=
 =?us-ascii?Q?2qUZOCXzTjB+7jhGvtzIGeiPBHPlbg+A9KmCZ/kKX0C0rrS0kLPwVrw9kVzf?=
 =?us-ascii?Q?n9/+sG6NPKYKKBThXKfuNmReZ9bQ+nOAuUkwrT2ZOzRoGQn+4hcGnq10O6zG?=
 =?us-ascii?Q?NutIrnBz7nfQz4U+WJ0f4HWmQZR02GhVj9H+TyZnX28qMKvZkryyOM5eJmoI?=
 =?us-ascii?Q?J+ZN63B/dokWcpR938H/EIJz4otK8OiQtV8hRRmxA9Oass9PWHfDPCn6J0nD?=
 =?us-ascii?Q?HlmSG+7Zox1TRNhqwcS64gSlGWlAXnwGCsjf9AXo0POyGlnqpq3sIZpdI2Hl?=
 =?us-ascii?Q?scq4lt92pw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed7e0a7-8388-4482-5042-08da23254f51
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 23:27:17.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEzHoB3omsm8zmnXzWLOqh1XnFAsjDnQ2/OuBNj3PQj1FW4aArWPlRREruQ9SocFhGPlZRHOUbJ4bznqXtG5nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4714
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 20 Apr 2022 14:37:34 +1000 Alistair Popple <apopple@nvidia.com> wrote:
>
>> In some cases it is possible for mmu_interval_notifier_remove() to race
>> with mn_tree_inv_end() allowing it to return while the notifier data
>> structure is still in use. Consider the following sequence:
>>
>> CPU0 - mn_tree_inv_end()            CPU1 - mmu_interval_notifier_remove()
>> ----------------------------------- ------------------------------------
>>                                     spin_lock(subscriptions->lock);
>>                                     seq = subscriptions->invalidate_seq;
>> spin_lock(subscriptions->lock);     spin_unlock(subscriptions->lock);
>> subscriptions->invalidate_seq++;
>>                                     wait_event(invalidate_seq != seq);
>>                                     return;
>> interval_tree_remove(interval_sub); kfree(interval_sub);
>> spin_unlock(subscriptions->lock);
>> wake_up_all();
>>
>> As the wait_event() condition is true it will return immediately. This
>> can lead to use-after-free type errors if the caller frees the data
>> structure containing the interval notifier subscription while it is
>> still on a deferred list. Fix this by taking the appropriate lock when
>> reading invalidate_seq to ensure proper synchronisation.
>>
>> ...
>>
>> Fixes: 99cb252f5e68 ("mm/mmu_notifier: add an interval tree notifier")
>
> Do you think fix this should be backported into older kernels?

Yes, I forgot to cc stable sorry. Do you want me to resend with
'Cc: stable@vger.kernel.org'?

- Alistair

--=-=-=--
