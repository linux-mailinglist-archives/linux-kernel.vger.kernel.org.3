Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC56B4B26A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350360AbiBKNBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:01:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiBKNBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:01:49 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06877F05
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:01:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fl6wsX7Gtl1Y3FsMpqGAC0ff8Ht+datnyRfded0YyfTX/f7PFGMnoGRNaVUFhTNxHwxzny3C+y4cvGewLG9pTzqbdpr402JCJlSI+TZc8KmTGgVMNjYNk5LfZMd+RjihS2lTFGaPkaeBJCib0HN5cfFHk+BPUe5LV+V76RFtG9B9JFg5Ff5uCwv6JthKf9yYSQcf9M6/HTfDvkQEbM3m2j4cp50OBWxsGiHPQHM2j+6GGiTSE02zmwRmn83C9h6L3IjWodKbzveaPXs2mgVMLSNG2EopJ9Inp6lqC5JuwViwMzCIqu4esW36xX49dGkuUfl/Kgdd2O3RqDKbZg9XxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfDqz9hzZm+9PusWUazJegCbuKLLJ7isyvUn5G2Qc30=;
 b=ObczyQ48vZKggZ86cuwh1cCP/9m+0OseOxFuB3AgUhzbLN06Ss6eVNT8rXGQAcneymcMWpbhNcLgIpRaTpnQhyv17xMyEacaRS+bZ3bDyEqKNk2fuRto0UezW/gKdsBN7jaZWhW1CjjkFhmVDgIWjJbBpxQveSyGXmw+aeAREvjKaGBQDHFYj7OYD4kf9k5+Qy57hErbd1d3HTNYHqnyodeCbFoYWQ/epaXdqwXw+EYLcjR9mdsck8UL19zlbpgxul4dSg5saYx3unqen962MsUHg4456qHAuyqskY1gaorjm2WMesyx/UHWn4MJPi1ReNe0KYbEnYrX/fx0QYbrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfDqz9hzZm+9PusWUazJegCbuKLLJ7isyvUn5G2Qc30=;
 b=gJE8EvfzrNYj8tQbu9X8CJjpdHQVqyE8fW2NM7Xfaa2HszcdvxUBD1Xahk74dVILEGaQohiC5LLmpS5Q6p45nFlFhGwUwV0mcGI9BIGO7BT1D0EPeBeQSvyBP4IvBOkOYcsBv/GkQWoyPKTIfd1IqSSA2p0IpPR+b3YMsLrQWLyFFMff4pGdrFbi/HbYx1ErFubr0GEDhxTgalfY/DRNZVrBUXJ+5mJs2Mq3y9g5hDR+qU8B+OD6MNVxjwM3zY8pfyZT6zfZbx3pIjlemvu/ovJzimwA8nnhlbZCtD7XuOF3ZOuIQNgOEItSZYLkTImGRlpGt+TbTkohBk9AHYpdAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 13:01:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 13:01:45 +0000
Date:   Fri, 11 Feb 2022 09:01:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] iommu/vt-d: Some Intel IOMMU cleanups
Message-ID: <20220211130144.GM4160@nvidia.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b687888-e6e6-4c11-a1de-08d9ed5ea83a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB45252DE0D7A2A28C93277456C2309@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLwVtY74VQkaWxVnk0ccARdbPVJx9PAyS8y+yZCZEJ4LXDhAygZtwkulnik9dk8lt3Q6reGVcbfTOEXkIRqelgNZKHrAagQx6TPbhR8sx/nuP/Uh89alcj7u+a199iZFD8TubxWGJLklVGViZu/J+2D8yddhedaFQbdHWgOeInsvFCQvVG4oyshCEoGPCb4pWVlksiaObp5pfU5SR5qays/LS+VZt7ReWZEsGz+YFktQ3Csvcq4m0Gpg4eFcLu13DesDfu2qVw5qUW85W6L1sWwBahWm5FaiEpTKy8wDfjwReowyELGRcP0E3rmwgIoqlRMfl1HP1jzNfHZlTMSu5jfNZqJyevAbgdUgQV49+kqhbRu/GcEhSpSq7NfCOg15oSYglrSS/ZMqYHdkPUqIgpUVegharErrqej3ESjB7b/oitjlnKEBh/wNKvTrL1ywR23/mcEcc+GnwZWyIY67flJuLeT8ehb71r5tXWTc12JdhrjKR+SsPzqBVauSZsxmcMWRGdUBj+VZWOoGRK+8hGaD5rFz6h9cLAfRHYSAHQ1690ABLMPBy1/R1G8EduKHQkMYxsfq3mRG9IS44aUDRGfxSeEduRQ5p+N9v9qHG5L/IGSPGTf01jAXOlE7qzsnQsw943Ndf66/4RUEutptDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(186003)(5660300002)(316002)(2616005)(1076003)(4744005)(6512007)(83380400001)(54906003)(36756003)(26005)(38100700002)(66476007)(8936002)(66556008)(6486002)(8676002)(66946007)(4326008)(6916009)(33656002)(2906002)(508600001)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SM8NqVo6U15Xkn4mgwHe7bkAqbQf9JKEZTS51HCjM2iBdqEk2ipD/VAlbStz?=
 =?us-ascii?Q?f108VbzWHjmk3jovhdQ4Pc7TVC0MwP92Cbvy5GccwTQipl+X18m+3qFUjSyG?=
 =?us-ascii?Q?PUWwdMOk0sJEaFadlNS9BW3VLqhDE+0NDpOrLBJD3MGw+Whz1UJldcXVedU2?=
 =?us-ascii?Q?VKzT6R/Fov4ybLeDw+EQ8wLQcpa+M56DcS5CtVguwJxv3fZq2CbtiVxRX8Va?=
 =?us-ascii?Q?ii78obHoW7Ey8pnYCAkQwt6kRYV4HebiIisX3QiKVgqvdV94I71Vl+LcRMXE?=
 =?us-ascii?Q?dkDfK1GWzlYBn+XO7f4QrJtxoSplsaDD+2rV3mSMtM4TaYR8jUXlUtcWecF3?=
 =?us-ascii?Q?yA++QDae8x4CCfNTKMMXAG0VY1gtWaqye8y96Wda0LEXm4zM63TGZY/RIaoI?=
 =?us-ascii?Q?943kZvgyexeCMIifCydVXbmry2ZCnl7wCoascDi9cQn5Edj/lOQOyFBSn+6p?=
 =?us-ascii?Q?XZc89ndWoiaGuyajf5bgMTzkOrjpAvNQ6nAGAKOmfJi9kBBuRZOWlyd/O+fL?=
 =?us-ascii?Q?bGKHwD93MN63TKLBNhUSDa3RmdqlRg51jaEezrq/pyfBxbj/SDtTTxoIIVG7?=
 =?us-ascii?Q?k9YldDKFzQQQHmkE8jUQkXq7ZLmfCBn9vvPytoEFcxL8gS4rryXTg1B9XgSN?=
 =?us-ascii?Q?dogqlBim3A+9G6R+Pzp851UtVbGD0cZroWtSTg2COvrt65bUk9c0MfwFX727?=
 =?us-ascii?Q?NrjFVeKm0TuxpGl/ZTRrPqEfC6XxfY9pQcbcsELqbFhJ7NAKsKsIGAv5YXDR?=
 =?us-ascii?Q?RhCXA8xih7rDA7xbCTHSWYoctRmPKWSXQEqvJS8pUuS23DQulGJN4qZ1XDdJ?=
 =?us-ascii?Q?yL8p4oJD1Hka2GVy6lTERXeU2XyNn7V0SPUoQViojG6XhpapLj0uJeIyVzA2?=
 =?us-ascii?Q?exzEaqHgvzFT33V2ayMJSemE5BlbApwNSSj9zU/hl2u884KR4FpGxWFF0K45?=
 =?us-ascii?Q?5s/whlvxHAuCZIwjGea6xGC0uSaKCxfRZpbufL1QnO6FI0g2iDJ1qR5P3w5b?=
 =?us-ascii?Q?K81uRmN20MftG4PkDhFjaA9bu5BOVX5M6zzL2355zWPy9WPaYeNxfEhd8fkw?=
 =?us-ascii?Q?TYixpzmTU2/ZmGK/T/dvFjSgx6qTqECmucIXydeCt5nl2Bj9WSOhgOV1hbbh?=
 =?us-ascii?Q?e/Hj/Vbj5Vcqda6AsaY3nHvPwzKJRFXs2cIQNqgvjNZ0fYvQzRtWV3md9e+I?=
 =?us-ascii?Q?HSYO8E31NDjk6hvUo1TAMKROTWATN10p8X2pDdcDB2f3s8w6OUwEyg+V50s3?=
 =?us-ascii?Q?467fKIvg6Hiya19vTneD5Fn1QkMeiRJl7oMckNMA/tAopkEiW/kNFszsxevq?=
 =?us-ascii?Q?DxS8GK9OFOKw0KJxKUU+MKIKEmtnABrzUYBK9w6++L+fYN0KVcLp1vg+trg4?=
 =?us-ascii?Q?ENO5GYHR0E6viMcsWTbYBYLLYXQS1xAI488mI7jWt40dER5l98JflqMhmyXh?=
 =?us-ascii?Q?oN9p5GsjcpNWd+K8yc7u9ukWArBV19m1itipipQA8ux2icFleFWruL5xC6NG?=
 =?us-ascii?Q?ffSVpyTTj54QBqkxM4qc+YP9BZEnlDU48DtnZ+DMQfKyqNAdiNy1zJwOMX2U?=
 =?us-ascii?Q?mvYB30OZVpnRFxp6euU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b687888-e6e6-4c11-a1de-08d9ed5ea83a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 13:01:45.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNacWvpyowZukG7zZkKFf2yK4csAyF9gt1Pgdu/yyQnQ2BCGaoktzY5Ds/XDr+3Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 02:41:32PM +0800, Lu Baolu wrote:
> Hi folks,
> 
> After a long time of evolution, the drivers/iommu/intel/iommu.c becomes
> fat and a bit messy. This series tries to cleanup and refactor the
> driver to make it more concise. Your comments are very appreciated.

I wanted to take a closer look at what you are trying to do with rcu,
but these patches don't apply. Please always sent patches against a
well known tree like v5.17-rc or the iommu tree, or something.

Anyhow, I think you should split the last 4 patches out of this series
and send them seperately.

Jason
