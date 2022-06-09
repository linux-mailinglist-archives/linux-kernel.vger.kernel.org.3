Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A66544DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343844AbiFINcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbiFINcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:32:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69641996
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqa0THmhxlrh0pQEytmAyOFLRIG1//70HbVuXWqEdr4RwG7Qn4psC9JAXQLbSE6GUz1arN9R8+Ix9qfDeiU6L5BI2/cYp8R3V/aJCks/lA2VgUshmQKcugXdJLosDoLRJtJD0tFgMRc4Mti9dKpFWAFIRO6bUyjWK+JtcGB1P4tmDh13E5mi+klRTBdPR3d+3uKAhwNVpalZH3U2bXTLYioy9EWkSFRwkte3BULimnDGf/StsvaoF3pHXD+KDDXT0ESYyEHUIGnF5rrLVYFThdYlGddi4hT+gYQzhoxsLmj2HwR/cWCC3hXuwDtcIJNwFFJkY65Cb7Op6ZGz75ZijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRI5AEoVjMsG4vnhJ8F8uBq7UrrAIQcFjacnO+wwl6Y=;
 b=AizA1b8H769yY6LgNOKHWNN21H1r0Gq58OF1aXT0lvwC+XlQAG/d5JsNTJpYRt8cPrVDfKbbQQwB6WVOgaXPJgX7428YT9C2qMgNLl2SUaZcqlUMdui3NL0cSMAC5lrXzHZgRLz/52He2N34bL+FuaebQG2/SptdNXNZGq6WrUKq4dTsgsR5n3vcze44F0k3O3GESSlqpKzy5ysC3abMTwX/VKqWVa98yIPvc+JjawRcwKO8rfJyLeDz4EjrbVyLzgj8QPDWUckOMriQYZQzjXQsHQVpXHO4YAHlSavwc7QJGD1QF4PX6C8B40B6d26I1Fy0NOzURs7s/W+1+AZhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRI5AEoVjMsG4vnhJ8F8uBq7UrrAIQcFjacnO+wwl6Y=;
 b=r/s89mEnW3M5+J0+yGNIGvAp0fztIHKtz9BYwkXIkNp4aV2gvT+sM1r5TCQEjDLEsYCinKGUWvYQZyGsFq9igkQT60I630RmAQnP6ygVbIeevHwiAqzIKMFHgz2SH86pSpSnsNWHANxOoOWixTmIregj4l/fH+cJN+xm5iYkyh1t9hUvWG6HfyRXMfYKzOZOAvp0QjzmHC8b6bzLVi8pauHmPDoLxlZRCPQjH8IpFWlsQOoSZw4kw3Y91Z3J1rGBjHTk5Z9jCS3zyvhiBiCQPkm6j/m3hUVFkIqSEyNZikqDjYVjNuZbijDUro3gazKQaVvnWkGQFDNRMQLWK4Q0DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1746.namprd12.prod.outlook.com (2603:10b6:404:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 13:32:35 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 13:32:35 +0000
Date:   Thu, 9 Jun 2022 10:32:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Message-ID: <20220609133234.GA1343366@nvidia.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
 <20220609124934.GZ1343366@nvidia.com>
 <9a339b42-2993-f7e2-3122-764a486e796f@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a339b42-2993-f7e2-3122-764a486e796f@arm.com>
X-ClientProxiedBy: BL0PR0102CA0054.prod.exchangelabs.com
 (2603:10b6:208:25::31) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65894b57-7b5f-4bfe-3df1-08da4a1c8395
X-MS-TrafficTypeDiagnostic: BN6PR12MB1746:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1746F8923B15927E5103E16FC2A79@BN6PR12MB1746.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NMrKa5gv7OhkOidQMdm5Y+VHovrXL5u6KKE9y22Tkq/uyBbCWnH+q+a+KcNQCXxFeA4vLYdi6GaYsiEWSaGjDOfIOqY3KAW0atGTCr+akH1vk395xbgacL03cL6e0KMk5BBrk1u1L4AFTGOF7bMNjqM8dp+cOiy1CJzVeSaIvBCAbyZ4CJUiWVa7LmvmR96APnQ3Ua+7MuGNRYWZ/G618+qkUGbJ92iuzdm0lzB81llEzvII1JIOYEqn1VPiNuxe79k7l8qvVLy5MUGNG1YLEAgSgGMenmpysDq6HgHIMWUn+PA21I3YrEff9diMH4cTFKywuvUEjIctpBlg9FPQx1mxFNI/9jfdoq6VgpKhfXTWOqmaQnyBFcBfPjJ6mORlLktVDQcFyhCUMjXxyE8ooDJqroBmPDJQaR8CSbpEilVQZHKGsPhFKlcwBwZDrLzue3iNJ4E8n7L6cnm2Lk/gxOExIycuyXeIoMmsXUCOx9FcklIXRhplbrVDFeMUohL/vbGElvFsXFSMI967T4jm2KNDTWI5e8wBJYjI4+5wrr7NuKKM7o7LwBrmUBhDs9LnNnFAsXDgx+sXj3JCZ5D9hWD6Rna7VrLMbxz+9QRfLg+u/ndJBhdp1gexP+P3OV27ousu5P3PvefP28zFDKLkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(1076003)(66556008)(8676002)(4326008)(66946007)(186003)(86362001)(2616005)(7416002)(5660300002)(8936002)(6486002)(508600001)(6506007)(54906003)(6916009)(33656002)(6512007)(316002)(4744005)(36756003)(2906002)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8LoouH4JBUm+yL/yXgRaRgLYCystTJqFBtPv/BhH65xz86QQBI/k/bQkYIr?=
 =?us-ascii?Q?U5NbZVci85BR7r51KQjSO7iSNAR7oPHW/D8bCfNmou8Ny5pEZ8vrYqgtdIr2?=
 =?us-ascii?Q?ShRb777rmkGrdQeUiY/fahrrtAVXfZ35kwQCv/oMup7+NZDkafMnDIGsRz+S?=
 =?us-ascii?Q?7h96a44yjCfexAdmPdvrAwo+ksPpi925gTxmSfl1edH8frzFqknHq1TZj72+?=
 =?us-ascii?Q?AkTcGP9uiq4K5v9s6M1rA90KM0NL0YblIGXRadBRlufQZl7LekL2X1UXLDdX?=
 =?us-ascii?Q?u4VKMcSnGidH4eFEzlCPZ9P9htba/82Sqqn5MBodBOZvfevm3jo27MGRA4DM?=
 =?us-ascii?Q?ayoyLNkhb2oz480IzmafZmFvyJIVAmx1NWnjYChLnFca41jRInTDG7FiP1ld?=
 =?us-ascii?Q?aKUhrXWP7UUVrMFxN3nRrXMRNo1NqVeT2ynUYqig0fyBR9qJ1pMqKr0WbJxQ?=
 =?us-ascii?Q?J3oZ8cf0p2KUPgL+RlLA0XX/TkuWFwPMAVfGn5s7AVfTrtisGx+52+USAbSx?=
 =?us-ascii?Q?naoshB3TmtNeitv7JsBKOk6ZC7Q/1FTJyGBX9E2SUoOTG6eYYB52zo0p/Pyf?=
 =?us-ascii?Q?186LJ+ZFG1rhkU0129y4ax7yyoTlU6UrnyFLnVfMrsT9RfknSFoPVBiwUS24?=
 =?us-ascii?Q?D1Uwi2hrPbv5Qn7sKbAgh3ZCjWrq64xPHXnGoRRBcd8zIRuoUUS6+Zv+1AIS?=
 =?us-ascii?Q?AUuMhwn1Ch4ekc9nnRU3K6vj2PfX70/UaG9lA/rYl013j/7HYe7ts71kWxS0?=
 =?us-ascii?Q?VhAg7xXbVZL+uuKX1aY2b5iDBSO3g45HWiSDYa09fD5JYo0ntCmJxKd9PKt7?=
 =?us-ascii?Q?Z8Ce5qlunXX3Tp3LWCZfJisBZGcSPESOUIJtiNvdYimUsOdHUIEXhl7UAK51?=
 =?us-ascii?Q?tt2UjwvougvAM4WyR5am4dLFrJht/WJuIxqBddVnMS/aIaCwGbWiLpI4DUYk?=
 =?us-ascii?Q?+Sqspwu28oIURX8ThZZoPcl2zb47LK3SKRQfvdplMrwqQ/8DLeJj2ph1gPFc?=
 =?us-ascii?Q?8QyepTEmQ0MQoJ/aONXIEt6b7whbmPCKHlATt/1HbMd6QPtxd1jd3glsNf8j?=
 =?us-ascii?Q?zU7WRTu79xAOFHiV7z9A87eGhifBYTiDrZ2xno78f8q4XKgqFKhmhZl5SsyU?=
 =?us-ascii?Q?gCUbaoAyRVWgIMXbgPbk1yp/zvs2stj6Dgz5oYXLRbAcTcP2KcmwLpv0fJic?=
 =?us-ascii?Q?+GVGV3s8LKFGd/3mp2arub5xICv7fHqJNH3E1O/uO0lltqsKvdjL+11l6v1Q?=
 =?us-ascii?Q?m6H+21rhF3IxSwoh4bNJZNGFc+/2JqeLaXgOU7aWwJouf9Gew5QbdmuF+qY6?=
 =?us-ascii?Q?in3mXhq3mge508qqSKChXrUUGxuSsTfLxZJT2ChEnmZ/wvglgt+ffvs7VX0a?=
 =?us-ascii?Q?XUn+dL2FNA5N6jnpdanwctLunIaCzW1GOqB7eLnRYs9IxOcX9McpZDrEGauR?=
 =?us-ascii?Q?NSWu7/8bO9b5CnxzRrjJXkZq1Zhe04sfjXdOYk9cx3B9lQHkzEVWvO1Ted0V?=
 =?us-ascii?Q?qD/ddlVYwwoU0rWc06mrozwsaZm4TFwgMAq8tv7mr1hW2IXE+nLLU/cJh0B0?=
 =?us-ascii?Q?8HZ1f7z4MqBTBXi22+oFJ2DRzjdBKoOGuJzBO/C0o2HGqpt6KpSsfPzz1Mig?=
 =?us-ascii?Q?RB04Yk7tGjBIY22ZjbZeP4i1xAoj/sNJlhSAj5dcXKKqfZvgpQe+OBvEj3+K?=
 =?us-ascii?Q?bdrFxSxBv46JeEkWed8vzLjCxCfhqBDahuE85NgKLdzY6a57JQ07Bdn5LfLl?=
 =?us-ascii?Q?ZgA0WEyy+w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65894b57-7b5f-4bfe-3df1-08da4a1c8395
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 13:32:35.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dRMrHxKbKlrfHaiEH5AlqCHOQtrsNMTNzsj5S1YfyV1kf0XBlYXlWlv1SXwgMSo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1746
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 02:19:06PM +0100, Robin Murphy wrote:

> Is there a significant benefit to keeping both paths, or could we get away
> with just always using RCU? Realistically, pagetable pages aren't likely to
> be freed all that frequently, except perhaps at domain teardown, but that
> shouldn't really be performance-critical, and I guess we could stick an RCU
> sync point in iommu_domain_free() if we're really worried about releasing
> larger quantities of pages back to the allocator ASAP?

I think you are right, anything that uses the iommu_iotlb_gather may
as well use RCU too.

IIRC the allocators already know that RCU is often sitting on
freed-memory and have some contigency to flush it out before OOMing,
so nothing special should be needed.

Jason
