Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E0528C86
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344548AbiEPSFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344528AbiEPSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:05:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091A3377D4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6WGE0M9RYzr5or8Is0J+hoSZyXIlP7yRtfc9AICpOOdzbYR7OZ6nY4XU2QisUy+2elg71ZieAOd59s9U0Tv00lJytX74365T6t9N2pVHwSsG04/pglDuNKRoig3hNrxb5rl/WEvQC7OiLbdfgf3i9RwkqodQVQOq2ZNFPAQu2LfLmXUwPIjx9aqnd7h3QpuLBCn061VnKab5ZWfoN18UQI/AxzkV8GUlP1cH5AOKRCzxQQ8wxD1besYua6ag/8BYPgmhT3xa7NpspeKM6RwHhZJ6EHB4cHwtrP6KJyu+qNeZwnUS1kxx3G8C1pkT8fDjg50ZOqCyKPXPfE3kT1NMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8vNbLpH/eTg+95V/YXkaknuNlDRrL63xeNMc0a0U8k=;
 b=TijqBog/fS8lDlKAh+tmfVOrUjbKCc3yowOFl13yYRVzOnmXBINr4yahe84Ok9Ayadt+tLIDcqvC04pNbom5S4RUQFHcWVd0V6VAK43hFG/waRPfWbukvylj8F89Lwldv96wNVU3c74h5lbTM+7ZK3tlqvJrV7jTVflZ6MPXSnAa77yVY7LwfDeb6g1VMvQzYP40aw1/GmbDMs7vdOC7s9xx2Zq3FmXf710O2IshKItpIg6Y33oEL7bDbczn5wTY2IWxlA3VGMGP8kCBNyMm1NmDFdBvoWiIWwPNv7IEHCRya4x91hhBHItHlSiLDR9uNt3fM/V1a7rDlPoYkMpBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8vNbLpH/eTg+95V/YXkaknuNlDRrL63xeNMc0a0U8k=;
 b=VOE6da68Kp8dUWH6xc3XdVmEmXpkbKocj3aqE/zwqZOgjc/uOCLA+4wYxBJNgQx89zICbK5Ji2C2alrtTvFcOmHH6sW3K30SghVF6X+/QT22CdubAvoqtHyA5JSZpT7Iz/ODGWONIMZOGrrkIjlMHSLM+0TStYhz1k9pe5QpGjXUyR7qmnsaDQoX1YrHiTCADEwbDTipP+6FFDv6IFi903dcn214+TL74CDvYU4IASJz6NHl4k/iLPE4bfghPQqgVfsjPruoy1vIPmAzHKjFKDYd1YfaW9D2xE2iNEdEnJnN0k2VaUm16JkSLN56XwMa1xo1KcG40eIZTnuZDQ23yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Mon, 16 May
 2022 18:05:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 18:05:10 +0000
Date:   Mon, 16 May 2022 15:05:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] KVM: x86: Remove unnecessary include
Message-ID: <20220516180509.GK1343366@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514014322.2927339-6-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:207:3c::42) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a34949e-04c0-4efc-b8c4-08da37669e17
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB133759AEF706DFF9D7D42F97C2CF9@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWBTw9tJy2k9O+z//eoUm2JA/cilv4ZtRqiSimuMyDBTJsmPhQOW0zivsK4zKp0ENztXF1Agyq7b9wqbznFQlsP2CaAGnIR5teUZIAxSZ93H3KyH+tqB1X3aWXPPIvVuhvT4kqOkCkz7CyVrx8ElAVmxI47Vm7gBXzdxRMETMfiiRygkWa6WvKdOtCnHFzfhWEYJ+wf5RUQ86c8cz1haXv3R9w9iSjVttLNAfwRHgkBQ8RLAqNemjauFE8vkLBH+xWBRiK/vf7+AIxylabFSZqYj2NNYaJkJKR1ZyQ3E+aXEVRISxts2vpLfPmKm8dGljnqAFd8/Sy9dWC7Sh6W8LeBpxj2PUXThSIkE5SdTyJ+SKp3TUJbsByl0yTMI4qVh9kkT7USAMmYvf3SOG4td4Xpd64xwBKjJpVmblRlSru9TtDXlLrMC+YhzMBPlHvRaE0VhDh+nwYbkNfCVG68hhzP19mmJwMD0uvxKVCm1k3IC3dN74fOor3sh8E7Tgapt3L0y5l2cQbryO2xYbd9AyTPJSY/+/BJUDcWYnqGfRyNqSctAWzA+sIN677NLy0eJG9wVVkIPPA4rP6SpOYT5Qkmwhp8U2u/O/+7awLHty9otoRq1c05CcCD0KANqC5IlqHTKGeWINK8D+5L0rXcLRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6512007)(7416002)(86362001)(6916009)(36756003)(508600001)(6506007)(8936002)(26005)(186003)(6486002)(316002)(66476007)(8676002)(66946007)(4326008)(66556008)(54906003)(83380400001)(1076003)(2906002)(33656002)(38100700002)(558084003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wC3DUY0lYbmA8YwxCAJ2Iv61p6tTFp69TRD+Y8VFsPde/xS54j/xRbDwrVpx?=
 =?us-ascii?Q?bBI43ySH04NE5vNS88lCUHjFeH7FfjnFZM57P0/ggDD1alCZSsBjy2OKU3sm?=
 =?us-ascii?Q?193sNYPNrCoIvWavKDCL/lOb4cuZRnAczifzHXbk2PmC0ZIlK+ezAK2vgQHk?=
 =?us-ascii?Q?FUK4miXW2Vvy3Mo6+wOH85I65zj2zfgJSbYnx0jzpEt+Z1sKL9Lk7XA1R5RQ?=
 =?us-ascii?Q?lj18KHWmuqPPX5IFPkUdrNUk9DsAyRY2ejzL9UWCf/CO8ji5E/1uTp5TPmkl?=
 =?us-ascii?Q?ovp7U0m8tOhPduGp5YUzKRisDpwVDUgMVKqMQWxaercCMI/DiIyzxXKWaxfp?=
 =?us-ascii?Q?+8x2dgij3nIl9YBu0xi7ZlPmmZWgvBIcKLcqN1Bctp5C2QfdjJTVgus7cKoU?=
 =?us-ascii?Q?EdlGstcOC8/RwfIM1kP2mXjXqnNKO1UayTyRf3ccdQEB4p07x1h4GoNghf6c?=
 =?us-ascii?Q?DiKnYfzai8paq46rASNb3whiKiHnTakQzDA56yLyvqf8XwhY7FRHx3bV9VHV?=
 =?us-ascii?Q?MolapGC60w67lR6NV0Ysk0uw4sCTbgMHcSZp4WzkdqPowCt67sjeVC4r5iPe?=
 =?us-ascii?Q?gh3228s3w5gxfDbcvuu5hgvXU44x4Y71nYICMbF7S4C97vSL2mxamNBMkW3E?=
 =?us-ascii?Q?0Xdooazk+/WNtUUIUwqVJQbOBE9Hb0/yyrbX/54NJqrJV1KyWJuzNbxirzq7?=
 =?us-ascii?Q?NoHGIXzDaEfWoipoKGcmh/57wA4cxdLeFRfGfdRpqpllhN0InVH96+bbv0Ls?=
 =?us-ascii?Q?gZ56RnP6YSiZj7tMVJjVo/pjXH4NN/9m6CPt6CFRaK3DHs0emW29VXx6HtZC?=
 =?us-ascii?Q?U0iURV/BENrNDRgiPeRsi/uBYnJDjCZFBGWHvxsAOtOdoWFunQW7PKMm5Viy?=
 =?us-ascii?Q?XKaVQ4zQocmHT0xKYp+w7Q/Z0bez7Tq7ESc68rbUZbnFygQcRdZq47k9BZiL?=
 =?us-ascii?Q?mTHY4lB8mTQakb3LUkoAJvdQLASOnCiLgYM5jG78hNfG0/4LJ9zZzr9Uw7Mw?=
 =?us-ascii?Q?iDXymx9MtYt+TRp9NWCy8bNrrUWbjneAw3s96qC5MK17lpllnEqwKg71C7/A?=
 =?us-ascii?Q?M430rzTFM15VQFLYwbX38BOEWI1RILbrXKRnYKAZ8wUZpXZpPcEEWneQQmgG?=
 =?us-ascii?Q?RDQ2qDORK8/lOABi9hX9ByAoiAHj0Rm2rTMEiYMQayAmHDP78XQLHM2ru/CK?=
 =?us-ascii?Q?3JKdnKEw+A1napee6lp5b+uZIxGcRMG0Qv8DNM14V6PZdXqSbwb3Z3OEpHpK?=
 =?us-ascii?Q?yKBBXAHaA4LAoMhGhPCIId/jyBz7vYls9aI+7HG/TQRNkPMuUJUaf/AJVB4z?=
 =?us-ascii?Q?JRFRL0P54PsllXQK2j5AKCdmRx7E0cGP9q/zxYr2eOQ3vJE8V1odElLetVJN?=
 =?us-ascii?Q?bBrK+OeBu5jk67i8Hd4AKJZ9z4GfXY8658PZ82lAoV0ixbBnApXmcwXZRcSd?=
 =?us-ascii?Q?l2v7CmM/DzpfU2cBpmS5ZcVYlMrEmS2q76W5gOigLPz+wP7Uz8rH/slxvjx7?=
 =?us-ascii?Q?FVE7ovU2z7+G3Lr87SP/NqPG3AXeXXoxs/M0KxfkEUVGo7ITyUQ9ZZscWcdk?=
 =?us-ascii?Q?9Ed7pkE+KszxmmBINQUEnqog+DwUZGnfWXfO/k2kZv4VHHziVor6jQ7vf2Gd?=
 =?us-ascii?Q?jU7+F418vE9v9+utY24vhAjk0v04eiIPSosYt1LaALWa1AUeriWEc/u8Ljf3?=
 =?us-ascii?Q?Z8buEPkVRDP406jcfgux2RTo77AcYsgKf7+LwO9XvFwhs3QqJA5BMWNhw6+7?=
 =?us-ascii?Q?9xd9u0ID+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a34949e-04c0-4efc-b8c4-08da37669e17
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 18:05:10.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6rc5pm/x2WpIoM23dv2mhUPHjiLJp8E5FqmD/T1OFgV4aREnCMAm0nfqQCSw0bG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 09:43:20AM +0800, Lu Baolu wrote:
> intel-iommu.h is not needed in kvm/x86 anymore. Remove its include.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/kvm/x86.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
