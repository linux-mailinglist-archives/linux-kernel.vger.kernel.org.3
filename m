Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F9454CDA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348067AbiFOP5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244556AbiFOP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:57:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2854A35DDA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STWkxDwiOaF1veoV3LqlS8qoGsH7Ehm5MybdRO1ETaOPg43dTrg/xW9vnD5uil1o/YcNT/uMwcttLZbKucbBZDib+djeoMLHmgXgRcTWlmjFWmWauo819tIiEE1Uswv5u4Yzf2hoIuM8nCE/Ns8WJiMpn8r8epPrI8ywApDlTBjrs13AH6gWLKUefLvTbXHYKxN3Bg1HYT5Xylc8UKIWJZnQ0AFwVz4iahMbNQ1sOMhKBQH4K0FmDqFwGDJiU2dqq2emN3/OREqmkEFYlxfxFSEqRfQJ+dGVLHPgw4hmvGtLMrVzoWV0ngF5/iq4WK39iRG7bvGexugPka16zS3vTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEzbIDp9zj6rBGQcK4bkjHgfgya8Qrxn4pmhNztBATg=;
 b=SWVnlHBqQtWKEiF4VZzBKQN8cBGb8YTv5upkaGH67IxBQdYvmA5wVEC6iH9yRbmVdl/FjXaMqpXViu4v+B54HL14b9blSRjORxA+nSmFzeOuf5FJG1s8pnDUUjTul8aShKh112+ja6JBgxYaJGsJ7NYXohALLCXY2Ka8RI0Xn+R7q6qt4xxy/GeHvqdsLK7udPrPXnhz4g9SLgK9kKf7+EzFTglCihjaVFkimEjrcloemhaj7oxiDvS1epHKBZUHBWrxj8Yp90FtfqITksQDCGJ5Y0adXxzlsXpABzV1mnh33A6sM9rmVWju1Sv1ZgnPA0nv6G6ZaWtmG8ucG0YzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEzbIDp9zj6rBGQcK4bkjHgfgya8Qrxn4pmhNztBATg=;
 b=PRVxQCo5OoeE4fqShh7i36TsZ/HAQUH4TeZoIt1dbIX/GDH3KU7unViTBC4odAePzlJPmtNHIh8PcxNhy5omPje6VNtHZkB+lcdlNegIFGckFFO5PbidRqZNBaOc9uzkgNDquDljrrFQF5aehPB5lpOozL6lHWlga7rT9XIYT12DU0F+7VSUMC477PbZzZLdaSXKcPd0ay5AjktN/PBjmHiod1rwNfOUSVzVJNKEA7Zn/Zsp0rwLg0IsNBgdaxFqDBJXvWxskMmXZdwfWl/gt+GXnl3fdXhgzf19WScV5CNps7emXhdEXFvHt70Ni7JhtaV0hgjvs72Jn8pfmRbmVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Wed, 15 Jun
 2022 15:57:02 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::b991:fe0d:8981:90bd]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::b991:fe0d:8981:90bd%9]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 15:57:02 +0000
Date:   Wed, 15 Jun 2022 12:56:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        jhubbard@nvidia.com, joaodias@google.com
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
Message-ID: <20220615155659.GA7684@nvidia.com>
References: <165490039431.944052.12458624139225785964.stgit@omen>
 <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
X-ClientProxiedBy: MW4PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:303:6a::34) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7253f353-db00-4d9a-db94-08da4ee7af96
X-MS-TrafficTypeDiagnostic: DM6PR12MB3964:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39647A0748585F2204A6DEDBC2AD9@DM6PR12MB3964.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6yaqb+qkVn36T0tE2eMaqXM696fmmFL2+B0Zr3x63JgHC5wulOztwriBf/TbD9Qi4xM94kaCQ8A9SYZZw9e6MzsDEz+Q18oktH8l3hC0xMPOEw5kymUPVQtTwjvI2t8AfA92THGszTcCmrOaFJuZ4nSDO141ddV/xCC2ZLiYhfy2qmJ/nInwHLd92j9WIMU6f1ujHRIsxEcoqsW+ihG96H1/e2hcuAK4E2eH0c06uoeZBj3ErZmy9XRtFhpwbrnvDjvN51O6It19es3Da4cprJSQaNSLy1/eQk5KqPpzsWqyL68QB2JghPWYhpU/EGxnOtcZQuTSZ+POVmFW8ZbW9/e59aH4fe4eLxTYmfSmJGyi8SiZxGDef+x+j9U/Clrasyt37q3uE6VokDU/uFULzHJilR4lV3Wq1mo17b2L84EyrYEjHDrHPALdbqQtl6HezHY6c29EPp4ics/gwdY4zqajyocn2XHHkZyw/FlB0qsccKhcP36e9ILSOCV2IXn6hU+NM9x0oQICpzn5K9XeGn6NIUORAJNXhea2FxQCOz/Hrvcg3GKLbOeaPWuhJ/pqNflF2bjH8gy3b1zMrUrEbwHZpfNB/oVg6RgRNlNcTHXfLzj2YPTrM8iqftDtnTR+mHwQG7nSLV03UEGbYix2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6666004)(38100700002)(86362001)(5660300002)(508600001)(2616005)(6486002)(8936002)(1076003)(4326008)(66946007)(8676002)(66476007)(316002)(66556008)(53546011)(36756003)(33656002)(83380400001)(2906002)(6916009)(26005)(6506007)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NVHqJsUWzwGVWf8dXU97r9XwYZ6KEIgIddkoaLsEdFkXQV51HVswy54dHJ+J?=
 =?us-ascii?Q?9OC7CYUs7IKLTKhXnl3CI7ic6m20J4BeUvUBpS869HCQZQX7/887n2wzlXFH?=
 =?us-ascii?Q?jIRCKHBeRlppzwKHAh6pn6yuNLQnQN1Vm1O252JZAPcBtvY16U4d/5Dlckis?=
 =?us-ascii?Q?lof7rl3eUrDJlvbbTwCHX7AsGNppt8tlm7OI677e8hbZVJVD0lObHTSBjMS+?=
 =?us-ascii?Q?OPwwLqiNudetUcCDIS7DiADGRw7TLCJvcvB9C0YojY/AQYzZvQAyS/9ZaY91?=
 =?us-ascii?Q?XMu6aTeMA8rEHPugyUCGScuH9WhnsogI/VzpQdh/wczeuT4cKYKP+J8RjR+n?=
 =?us-ascii?Q?u6zcz4NFN9xCjWTwdqqJOF2Zu9zSKm0WfhUO08lqpBn04AIhaZ45MxZVLoW7?=
 =?us-ascii?Q?XQuFn03WoZ2QZgOuhowbcE8d1P2DIzROXKE+K9pVHYNAGWkjr22XYEP3EAue?=
 =?us-ascii?Q?X+UMgB5A1Nmj7K1y8xB0WP85pUyAMO3SWrtK7Yc+EHYwdFveBHXeZApTPuWf?=
 =?us-ascii?Q?j6DVK+2tICZYOBGLdvHCyEPigOfpkUSlQQslCli1bHZ7ghcwA1D1PKW5agCL?=
 =?us-ascii?Q?cqhlS4qIKfLuV7rt0PKVAlUWypUz+5e27BrpueCSmgNivXyfSqHv10bgdrEJ?=
 =?us-ascii?Q?5VBe9IOqncenICQPsMV0NzyFRumVUlSHsaSwmS78DFJ3rg7eTyKXrO2OqE2R?=
 =?us-ascii?Q?+94/ptMS721irpzJ4q5SAivtlgITirjdEnQ4LuthihAvQWuzyN4VrMtTADhp?=
 =?us-ascii?Q?tXbRNAf2/X9GBAINKZ6CNCPORhJ/K1inOVLjmnH0XeFfEDszeledfiIzy+hS?=
 =?us-ascii?Q?96OsCV3Bjg5uIhAJfGTO0vgrfP67Vs32lVusRuDRin22mJPq2Y9r0GFvxgZ6?=
 =?us-ascii?Q?VJlAzGAo+PN7yXGYSbNgAKI8nznN/QyZy+ZSxfOSBPZy32RJHC4KlsxTP1Qv?=
 =?us-ascii?Q?lbj4cOf2P5eZX/xHvQQaGW88tTV5X70v6SEYwpXvKoIXm4uoE5kKzWI8WBCq?=
 =?us-ascii?Q?qfIlQc6doT2aEc7YKiViz+dKSNJeiqT6IqthY4eOsdUlxlbb7vUxgD65AIYw?=
 =?us-ascii?Q?12sSQDEjP7qlw5WyjWif12wRMeIuBHy7U793B4f/hFnXzHGgD5DaALF6cypN?=
 =?us-ascii?Q?3hzy2DkdGn0UXoER5myZkktY/cn/UQ2OTOq6ucBSUn9oqmy0n/bzVW/0PD1L?=
 =?us-ascii?Q?6wr7IB/A9S8s8TwXTnr9ta9JovKdztYcIn1DYU9h4nLEvT4hMLjUhTjXpRj0?=
 =?us-ascii?Q?4YARSzZnrdY4CkXct5ZZmZYwgFIocjD3qkxIXhrKbULtC90LStK91U2U1Igc?=
 =?us-ascii?Q?xPlbCS/jtBJwXiva0Q4sy98vYMGrClBiOezvkzWS8B1gIR+4/jf/eucS+hfz?=
 =?us-ascii?Q?c8DgXVVqOAYsCJUXleZk2kOOnar+Kd/AuEZi1Pdq8EVepYoTE9AH0k7NLGNo?=
 =?us-ascii?Q?hvZX39CfT2CQcGZTm9lGhxl2SecThPsqO7VRL9GlLMv032+gBiym/Ym9R2TW?=
 =?us-ascii?Q?7hsPcNBlkTID12S4on33YP/m7T/iuWXgooI4657H5IawTQYDv+Y5l+7Z1EPI?=
 =?us-ascii?Q?yUx8TkQ/gz/8FNsLX8D9S+RUz2qL+bbBqpBV4nH94+CU23a41HL6/T4DkY/E?=
 =?us-ascii?Q?FhefK/n+NVd3PD4lIQ5pTFMLSEZpX2SdfGCema2KgGqnCfPo34B/T0RAyi5D?=
 =?us-ascii?Q?6NBwuQKAcuvXB0JqKtA9OPeyEVtEcRvJjUxv+6ZDkxZmhUSKQRyPi38K6K81?=
 =?us-ascii?Q?hsq6nh8a2Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7253f353-db00-4d9a-db94-08da4ee7af96
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 15:57:02.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGIeihKxuFqYNa9GNkTk67lg7N8H1NEEe1Zye1PvSII9NSnP8OQEeOulH8ZEjuYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 08:29:47PM +0200, David Hildenbrand wrote:
> On 11.06.22 00:35, Alex Williamson wrote:
> > The commit referenced below subtly and inadvertently changed the logic
> > to disallow pinning of zero pfns.  This breaks device assignment with
> > vfio and potentially various other users of gup.  Exclude the zero page
> > test from the negation.
> 
> I wonder which setups can reliably work with a long-term pin on a shared
> zeropage. In a MAP_PRIVATE mapping, any write access via the page tables
> will end up replacing the shared zeropage with an anonymous page.
> Something similar should apply in MAP_SHARED mappings, when lazily
> allocating disk blocks.
> 
> In the future, we might trigger unsharing when taking a R/O pin for the
> shared zeropage, just like we do as of now upstream for shared anonymous
> pages (!PageAnonExclusive). And something similar could then be done
> when finding a !anon page in a MAP_SHARED mapping.

I'm also confused how qemu is hitting this and it isn't already a bug?

It is arising because vfio doesn't use FOLL_FORCE|FOLL_WRITE to move
away the zero page in most cases.

And why does Yishai say it causes an infinite loop in the kernel?

Jason
