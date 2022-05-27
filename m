Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3B53647D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353431AbiE0PFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347518AbiE0PFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:05:31 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B821207F4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeTeE3UIijd3A13GngijCh46xxgpPqDjhI0VfXgDCrt/nob1CnWhJ65HFIba5VX3sYA5BLiVdK4UQ8iGpCMFpfAbZ3jVsupdsW/qJBVUnxYwVV44I5B918p6v/ZqhpHIc8tjwiodmVqpTbueEZw78bAkz0SpgN8N9rMK0Zq9UODFK6YY2YCtrgYvANlrfx1StxvX6l3HS/9cN6GXd6IrXs9v57mcb9107htvOcYtatIqZYe5aoztWoFeMahI5SBPaR9jFtrHybnMiSLwIFMXwerYb3xjpKvD49lZlU1so67M2JbddnxIXfUkOQeWrgNvFn+xSZkc/yHnGTPBHqN/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykZGjH3xcAWEDyCHYPW1DnaFQ6xsKfbInosl8jZjuzM=;
 b=bWbQxmloCooEiW6zcYhJKwWnG5lpNsVeV2KsjYdmuO82hsF7DUoJuMzA/1JyXsml72Uhsuytfjk72vEtLZmHsK4fRnvj/5N7jCfVZjlyxbMD979RAbpYjihHumDDEEh3zSx+wiRC05SdeoR80YmNRAHYfiP3C7QJYT9sRqjkEyfaY639p8GqB+irR3dzKnNh8SCbZBjhKWB3u/N2Kyhz/BghZ61SyXPDlE95C0sI+Jw8grIvFZg6sNKNVuY0Ms8rGtrSyTheZ15Vf4hTjjj//pKs7eY4Oy6Qo4rgCA9DzWObJB8m5xyPjujRy097X0yoS1pQ3I0Sw3NZU67RUHtD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykZGjH3xcAWEDyCHYPW1DnaFQ6xsKfbInosl8jZjuzM=;
 b=FXxp4qwvO5pPMIedTJqf8Oz9DQ2FqwTxjm0G65xMHeWBTjTwTwsrAMJAz7p/yABstzbySrKNhMoQKzCkRjx+aAsN0KFFjD310zrl3LtUNd9RZMlnm2zM2IoB81z5ouuNCpOeMSdEx9FqBC//2pQ/b4r6eZO2zINYP1XI/8LnxQzIvD0wAFvaxXnb0KmxKYzi3xeBzPk/htrGIqxgNUYveFzHBmRW8S3MdisbzVchOGd1bjhits3vNg0jaueGgmiAha24im1h24zy8b2884uI/mgfbTu5dXZmnGRhKkSFKjACCwewzh1s3c0yWZAiiclIRocLetD/odqJuxfiwElALA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB2973.namprd12.prod.outlook.com (2603:10b6:208:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 15:05:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 15:05:29 +0000
Date:   Fri, 27 May 2022 12:05:27 -0300
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
Subject: Re: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain
 free path
Message-ID: <20220527150527.GU1343366@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527063019.3112905-10-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0103.namprd02.prod.outlook.com
 (2603:10b6:208:51::44) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a824776b-8399-438c-2f71-08da3ff25651
X-MS-TrafficTypeDiagnostic: MN2PR12MB2973:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2973F09E4C584C556986C9C4C2D89@MN2PR12MB2973.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqN7IEeAuff32enjMLc/jgLmopceA9g8KdqqPdZTgE53nxsXBNPLAbfqhGvznIvMadMiG1gufNflGSXxeTnNwVBwCjF+cCXAfLJ8qHe8VgTHzb/VVXGgXuwxqQPh9WGfRc7XCi9wQ5XsYsZktIYMYkBEu6DNmLdplO7v7Lbt4GaCnAytgdF0HM3bMlGGj/G4mA8l2xDPT2RIiRcgMT7gXnGUILP4c66xHHgJ6JPTSBCAsFYudkv7R1i3OdKpG3MaWLATt0PX9lI6sIemHl2RUvYZbS6tG2zv+ql/AMzhk6oDgTfSMbxjPbzPgm1drwS+uws9bOqkJn0sPDAdoCsktz6I3K6eAjtCf2h24CxkAhQFK2d0y9jCe0k1nbIgAkOYBH3NCLSVanhbGnbUW/n7wT+1/ku0zcS1aMRYfRhZ5C6e4rHFqCPlkX+G19F/D07PPm9s+tfLp+7rZSi9EIvE7NbxKZw5XFsaBFrEJwWqhoJ/XZEnWcodggGlOB+it9qtYw3qVZAXcTAqRwNgsG3ofslhKiyx7cIVBmqyJsXv0L56RPr+L/e3yn37kI9Cuyr/Ot+V8/z7wBvFR+Zt5FCzxYwxuK7V3D/FK8fEmbYJo2L7gyxsdfZfbz7Pk++scROY751ePHnB663UI9c6bv2KEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6512007)(86362001)(2906002)(1076003)(26005)(38100700002)(36756003)(316002)(54906003)(6916009)(4326008)(8676002)(66946007)(66476007)(66556008)(5660300002)(83380400001)(7416002)(33656002)(4744005)(186003)(2616005)(6486002)(8936002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7mrGaHuvN59HmcZWHXaLdN7Btmofhq1MflcwBRC7uEJExhwpJxjUJ/2WS45e?=
 =?us-ascii?Q?jjxGjEz2+3BlLQtl+Ri4OSEkMPbNbB6K59jdI6+aYhaS9dOPLe1duZ6NJ9n+?=
 =?us-ascii?Q?Xas4Ozus58rExKXv6/gr3ho5l2U9uBZzEYEOLmdgICLwLp//XaeUrAGnuu4U?=
 =?us-ascii?Q?32UoHugdpK5bGwkscfWGqqXWIUStR7yt9fKobbfmcbpxDBsk8Om6HhN6o4s3?=
 =?us-ascii?Q?NDMf8fWaD3BSLD1rUD+yxAUFUEwhbC0ZQQnDRxobK9AqUr1Ro9WtVGPUCel8?=
 =?us-ascii?Q?gd/SOaOj/xQSWq9RB94FfSWNaHomwPXWS8LPkaXRPwxDTVLVLNbxFLrC1D6i?=
 =?us-ascii?Q?yOcvU+VqDKMdDIU3OdZIGb+1DUGn8UHwHcNPojRiDHGsFhShikwdaUTutgFM?=
 =?us-ascii?Q?ZJDciPLLbxwfDKv0aRiZ83ref2N/YLpyHlBhzcXqJzl5i7YcNAmif5vMga2b?=
 =?us-ascii?Q?mavvGmG8QO+/uhhOlGf6zn+wsE0IJhzcHhAvYA2HEGM2hXJDxUnpYKoS5mKQ?=
 =?us-ascii?Q?f6/5UgR73L3IIqxAnPmH1MuyDUyX+kqCTyh5Jbe8cpQ9GidMN26f/K1TcOpU?=
 =?us-ascii?Q?fqk7Rkv5nBZeB9rdf/MPybvzi+GesK+60YGIch1NkeC+uD+DzYEYLi6T+vsX?=
 =?us-ascii?Q?dE0s5zhp7fBagzRPljtvnWOyxuL5hW1LzwFQLQcjnD9Tr1WUwFSiVBXvSEtF?=
 =?us-ascii?Q?kcha1sXMaCPdpufBn8Au7cF2s4OqUbABeV72PAuuZGzhEsUa9Vafjr08MWpi?=
 =?us-ascii?Q?/7BdZp5oybiH5NHOjVZJh/DHFGp68F33uQk66tRg1HClhLqOwDnavA5PJ0sK?=
 =?us-ascii?Q?zlajhpxIJLz/mF7Zxs4wV7NvJbNIW0cO9gA7RgSzYXxr3zrrN+b+KJMeQNSM?=
 =?us-ascii?Q?PM6nNbGmHjKOEWIB0wJTZnupDwnIbxtykdL6v0hGdzblDCHx9GL9+Mo/Ng4B?=
 =?us-ascii?Q?0gAcMfHsXhqhc7AprGntY/j+92WimgIEdUQxq925ZS9vxMlul636UkzWPgn+?=
 =?us-ascii?Q?Rh6VE/5u66NQAtnrB8UQwJAimLRCLZreTNSQyihsTnCwHq0XMJv5Moq5BNDh?=
 =?us-ascii?Q?r/l5SDfZKV103gbc4OZPdjUsZ8e08a20pLzm8icaSMhL4ZyGjnxstSa9899y?=
 =?us-ascii?Q?N744wYfpjZQdC222xbUQfbCspvggp98wVdl6adoAhlVF9dZgFnRVTA1y1KUy?=
 =?us-ascii?Q?3erOkcY+QZqPkl33R0k7J+IZHax/8ycakfu0LzQkxteyg1fe/t8GWM2LcRaj?=
 =?us-ascii?Q?xVxNbeT7Pv7yJQmY83h1h4T39y931lKB+PXlxeyoEnbOnRcBy1hP68rItVdA?=
 =?us-ascii?Q?eAwkKBb6/vHGoIu4AyUv/r3X78S8y9keMs2SAkUfyL5wbcoBaH0wbeXEixOk?=
 =?us-ascii?Q?hgnMYzOFOCWSdlx21KIy/EvjiUfndsCqB0CfxDbGcFOH9llhRTQVLVvqnm0r?=
 =?us-ascii?Q?eNYZcK9oXAF2UbzHVt9AvqyJfNZM8C5jmb6BZ21eaISisqLM81RK1u6/rgaW?=
 =?us-ascii?Q?GPF07Ifpzq2jzTZoKO6+X5ItRs2L7PstADpBmid3oQMJe2BAWDbUOI8KWLHA?=
 =?us-ascii?Q?EwE9Sx5Mf0SD6DWiSLc6A9+CICtI1DPCRhM3qnww+uMOrRfROAz9p5/4Cp7n?=
 =?us-ascii?Q?Njfqx2qh6CrVu/mLy37jOiwuMyFv7cdiWuomUgDJhHsedpMpw49oDTQHjl70?=
 =?us-ascii?Q?+VyiG4U9vFV0/IVyK4jG4Y89hc8GwtHZ4KUvWTcizKiiE0GDbWIVCW4PgWp3?=
 =?us-ascii?Q?0o6PG/NOrg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a824776b-8399-438c-2f71-08da3ff25651
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 15:05:29.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcVjVZBJcfsu9l3bDRXjKpx+i5Eozp+OGS/F1XlBNr8DBH5zmfdHAh2XHVYkeqU0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2973
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 02:30:16PM +0800, Lu Baolu wrote:
> When the IOMMU domain is about to be freed, it should not be set on any
> device. Instead of silently dealing with some bug cases, it's better to
> trigger a warning to report and fix any potential bugs at the first time.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
