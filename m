Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF11D536476
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353568AbiE0PBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242146AbiE0PBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:01:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBE01207E7
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjJ6oAM8Og1pyLgBYu8TfWEFks4NNur4vBbVF6MsVnScGu+FNQvI3WfNu9mGkeFhkwK4A1qEb/d4rXz6I/P7vg4WiYdJck2Ha2pt/AhnTdmAunGVac4coOLy1KoIf8o89eyjNycl63UduDyBssS37Zczn0v/YjXamR9kdxVyGuwLf45Qwh9SVoKN8dSll9ukrHg05y4tZmkXTfbwce8viQMFhzsrDIR8AiU9krlgHB8di11h0Yt6BQ16p8PFJOSFbTAQfllBI5P+/90X3bdHW5deHOerYT+R9oaSZDMvz8RdzIdW+aK7SS/B0FoZpVjr53kbbWOOR6zo6TgTllT3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnvTbULxqOoreW5N/kn084SUILCWwVaurzqcD2Ts1bg=;
 b=CWsX9PrKw9+JXIKHMOaL8A/SpOTbaEqrJ+sWWHRAHHIFVEAR9mi+cJa/AtLEktAdtc52xNxvzkjoIlCmp5Lkv2O0G+N7dlCC4nATLwT4NAfIzpaTFEgMFsT8msMpCMbQLSpB7V4hCllcYmhdvrqZt6qnz7KQbMP91pxp1qfU3UOJZALtuAaOSXQ393X9cxjRBtyKefVMqqAu4Z1vo4dkdvSlQiwvcMjlF9xx0aSMsmWnwu1hDYfJj+VERLvox87uJ26PbaFrtvsh8KDSJMDRIhVBCK9D8gNHpHGik3o4Jn+2KBUHhxwZ+Q8gMaTbPX9OwwezjrGr3433rk+iFOfFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnvTbULxqOoreW5N/kn084SUILCWwVaurzqcD2Ts1bg=;
 b=eTRHgiTegO8FAdqEDVNQfvymCC4ovgap8fQ2m9Vo/9kLM3MHGLPrBaFzXFsU16AzRvNijiyyyf+/9W3zTx9ThHlUYo7kxZJictVwWaad5D63+izBoA3MydTXscPaByWbwqa7Pc1Z+MlVrICPaHrFFVdPPJHcNTOf2K9yqfY18PvrUzElIoKlC7ougfI6IcpXA971cgqqxGYGcnCCXFoaMIxl3HpQzP/lGwvdFyZwbeOnMjiZ8S+c8RSqPX+yYtyp2DFwLwWfhqMx62xqVEmigdDCKs3rpUrSUNrZRrbvsYJkPkJBnjQ8M6ML/+/kad5VmTGpU4lqQn1CS9TFrJTvdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1151.namprd12.prod.outlook.com (2603:10b6:300:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 15:01:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 15:01:51 +0000
Date:   Fri, 27 May 2022 12:01:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] iommu/vt-d: Use pci_get_domain_bus_and_slot() in
 pgtable_walk()
Message-ID: <20220527150149.GT1343366@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527063019.3112905-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:208:256::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d637f5d4-f7ee-4359-8098-08da3ff1d465
X-MS-TrafficTypeDiagnostic: MWHPR12MB1151:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1151C88560E98698CAD44118C2D89@MWHPR12MB1151.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Cx+pPcdRZaOVdd7xENPp0fJ4jeKra84pRT+MJNkk4yzvMBtAxyWUZG3aZDGn6QKI6vZezCcD/NPXA9Jn/ode6TqsuXdi1BgtocTHR9fISpfbfaKus9+3YaK2o75xPga9Ge3afRtDNWhwH/YGjdlb7FPX6EdppvGa6S+R33svoPZ1GIFNFE5YeuV+CVIyM3OwrDjr/ni2eCAl6YSNGtlyVQQXMeuAZNDz5FPLssqAHXeXCnt6EAHpECMWfQCbvosTANuMK02u+8QD/03g/7ZEe1ADpByhgEtJwBrbiF5/Nd8GZXgEAp1LYuamBx8GyirApMkWhGesRTY9whVsMa4ZHiEc6JAYu2iG45cU2E4Cnta88wNBeIa6VCl2HHGauyMSZSxNXOFeyD/J9hcRYoWkhq4TPJ4MsiRUno1E+9CFt3DldAwJlcViwAwFc3DSLlP+MyyCVWlrP8xfEnUDYTw50VarxbKqc7zmThtIFQYi0jC/u21+c1oF007a9NSAsWlZ9oG4Zuiwtqc2Xp5ikMlzvPO/edfdYtycK1pP9xDJHi93f+Fum+UU1/erSUF+ymWGS1kFnn6HYzT9gJX+DXuQBDB+Osod15ofY0b9gUW1slIFcennpoF6C/m/xRepO2cZfemCAbGBhpt77Y1LkPPSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(6916009)(86362001)(66556008)(38100700002)(66476007)(66946007)(316002)(4326008)(8676002)(54906003)(2906002)(1076003)(4744005)(6512007)(7416002)(26005)(6506007)(2616005)(186003)(83380400001)(36756003)(508600001)(33656002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?smgNU+2zC+cfpS8VKeIuA7sUfQ0vhmkoc7xBjJW6X7UPXWdt4wScPgy9ROvm?=
 =?us-ascii?Q?JbkwqyX5ETDQm+YvtDb/T0jSMHaYRYTxcpuTJbOihQIPfBzaDAPMtHNFt7S3?=
 =?us-ascii?Q?+lImOZXTHDaeklRekNgZMa5RTmomQb3BQAM81od6EunJWATvSil0nsrzsj3p?=
 =?us-ascii?Q?SmvGQUi1n9BV43a7OyrlO4n1BLqzMzSQThkiGL6YSxphP7Ng9LVWT8gYNlim?=
 =?us-ascii?Q?dLXQbPeHiWMBUASFP/emuBYCwsL+v8gedo5O00sN5zetHG7wGqYHQYxrJvlt?=
 =?us-ascii?Q?tktQjEMxindnsQ4mcpzbvMkhkQtE60/8xhT6spJdaV4uHiTTLHRsvMcK9VlK?=
 =?us-ascii?Q?5WLNe71HbjO94YpvfE8vwb+Me/yFPtvAM3YxcUyllE1xlRiCSmRjWUpJIysE?=
 =?us-ascii?Q?NmwzNz8mK1CH7MWSt7qhn0aPRt3kpzdxSLejjwyxTR+8MptzYiIdzsSe3jTb?=
 =?us-ascii?Q?DZi9dP+6mGwKFuzhj1KwIiLScRXgpRkTShXgIm6fM731pDo1hm7TnXOHtyyh?=
 =?us-ascii?Q?lB0Q0N5vU3mVordzsHLA9QmHFTvJghDDjcj6LDxyi6Q5yUoYSo2fvIiMWiUW?=
 =?us-ascii?Q?o7yYO1mp3waxc9EvLd4MqvLRSbXWDiluyhZQ1/neGi2OTKwpbOfUqZo44Wu4?=
 =?us-ascii?Q?sfCAPiXlMQgkbts3KMDwBp4GfN7VsCTEexHMgKHMkH28UHoqsYNVmFakxetK?=
 =?us-ascii?Q?9XYSpG1j5QGCZayr5tYAS0Oam20E6WiQmZ2XkL3lVUzddoVBMzDwRLZCVkyO?=
 =?us-ascii?Q?u3iKulW2pPzd/KEW7MJGTHWGMYvJ5KEbnjV0RugKhBFYjsWd8cOfGITZpPuK?=
 =?us-ascii?Q?W8XugTCjsQ2HmOa80IP8Z0oueRsFZ68wCNkJgtPFV6Wy8KC+TxeigOQOfAEh?=
 =?us-ascii?Q?moTmzcodwqfVAMoT8NTb3g6a0NAy6Ymnl1g5DK1lxeZabnRJtPF8Xy0n5Kcf?=
 =?us-ascii?Q?moLM28c19Mvf2Mzt9YJDwbHBw8+4x9sqz4i5IXsDdbCCEe3/GlmrIXtzzWpk?=
 =?us-ascii?Q?z+ksoOpFM7PRcOLeYGOJmgLNyhd6o9G3HZOx2hndV+ccFet/b60D3RQeHK/I?=
 =?us-ascii?Q?FoK+bmpf4NCLrycO77I6Bw7DiSvWGjjTJjUPzU4fsWq1Oz/7riPU126Zo/qe?=
 =?us-ascii?Q?WkcvhPDYzXRL1oqy1jQYTZ75/0pn8Iz40fZVLBT4WtPiZMxbtA3jnGxufzWr?=
 =?us-ascii?Q?1tJjkYr3kV+EkLBSud2muS6ObjVmVsxnkl3Qzls1RtS1MHYHnnNKwx+0BWuE?=
 =?us-ascii?Q?s7ICrEh1TVX6ucnm89xebtcwLTThcJetEOYXf+5Y7KlpM0K63VVMlMAzIWEt?=
 =?us-ascii?Q?928PVwnzoc3ZlkPqUAkZJabG1vHVpsO0XdGET7rkQEIY2rwryG4jUc64Y/DV?=
 =?us-ascii?Q?+uTUJGemASczhKodK+b8ErjuxyKawz2QmXt8JjJROcj7ecTVOVTgbYrOS4Bf?=
 =?us-ascii?Q?w3byXuowbgCQ6LYwPTT/TH/W+abFEFR0QBHCind3e3vntGvJeojm1rISTLw4?=
 =?us-ascii?Q?09XncT+swZTcCK3niZLtvQHGcnvdY6YSOQNEo3DTu/n9MwG40vB2x44Rd3HG?=
 =?us-ascii?Q?mMu14qYGIkPO4l/JqTrbrP9ZGvEElL6KHpvxa6e1ILf0tBCzKQ5mFXkwD1LG?=
 =?us-ascii?Q?oe7PEXWJlaYKbA9GPKr2QyB39tb3G5Yu641+niPnqTFmo+l3++r9VpZy8l9S?=
 =?us-ascii?Q?b4pxv7zuDvIJf7qGoef7ixoHlueczK9oiDzjBIglRrEvUPLyT+Dn4OefyUPq?=
 =?us-ascii?Q?p1PE4QdSVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d637f5d4-f7ee-4359-8098-08da3ff1d465
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 15:01:51.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZngngKIQCISj4SkY2Joa5tUT5EJJK5EOhZSFWqzSqo/8F82LeL1hdWUq+d0U3Xq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1151
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 02:30:11PM +0800, Lu Baolu wrote:
> Use pci_get_domain_bus_and_slot() instead of searching the global list
> to retrieve the pci device pointer. This removes device_domain_list
> global list as there are no consumers anymore.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h |  1 -
>  drivers/iommu/intel/iommu.c | 33 ++++++---------------------------
>  2 files changed, 6 insertions(+), 28 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
