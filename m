Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEB15363CB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 16:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352988AbiE0OMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351047AbiE0OMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:12:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EEBB491
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 07:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqO/8Cnk4OOFRnT2JIwPHisxpDnsWq34QUQiP871S2kjfhRVh48y0lvGNwQTkCWyRJ78ZQNmqpSPEK6VsVTc7El1Vy4VoJnpqpX9yrWO8H5id+Ll/Q7dhx/E1GHbLT5idosh1l99hEpWv0dUcVeT/E/bk4h928JGG95QLvoaTVCOsEpJ9CpJb0weVgp3J4+usohCGyoYZ8LNSbDL5MruVCejEYWmOB12ZF7xIlTdWBSiI2yEu1Yj/6r2g9OWzUcGsewL4UgBGvRmAurI0Kyzz9kzNggwqaSQ0C4oo6yX8gAr/wdV86UsocLBqY1V1s69UCG3AqXad5VDO9VvFRpUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KulAAZ5lLbtrGFi+wpv4P/21r45x4jg9D63Mvda3NIk=;
 b=R1B0jkTRg3cLgl5GP6pkpMS+gT786zJ+4J4jI4fPHGqZDotQZ71iiCsx3l/sgamZSZug+FwlOQwiB9JSeQZ3hufySLKDVbm+LhSqs6Lu1LnuZ68j67loiIaTyBdhyEghRcxyEybMgT2NfapdmPLtuHRWUqNWT8LuLu02/KvufwuTjw1luextv6gloXYUm17ZTw5/6++s27U/5saTyeqtLu79VctCNNG0wRi22cQgbXtpm4td+c/u0APU6RpVaTjfsEBkAwp0v4SOsjYsNazQYqihXoWTQR3GUIdQ5zcLGYrh3gWSv4PffMBMydar7v+yfKuAzF84jHWHNSNYHzsRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KulAAZ5lLbtrGFi+wpv4P/21r45x4jg9D63Mvda3NIk=;
 b=Tmsm72P1oPJUBk951ouTBvtRsjJLsgiylwbL9MoieCr76IvKcR6/0mfc17y/9jcCqc89aJych2tGb9C/4JSTa0eS4oie3YieLYbCdQEZanu1ai3AFbgOh7unixJZ9wI9P41Ul82HxNteLSidUMCGGGzimwVU1Vdi7BZmTgcbn0K8/IQiM+wVABQj4j7CuoZ6kUrhZKSF/ekH6Uof3qPKmEIPZtKI79RTDAXsjeURunfZH2EOPCIMYYMdzW2pNugllm8uQtouFpH1gwkYh08/TxajKcSjtGO/705DYd6+p42df+3Tj2C0wgu+TO1i0MUraEJY3z9pke3hVGkOALZCBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 14:12:02 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 14:12:02 +0000
Date:   Fri, 27 May 2022 11:12:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     keliu <liuke94@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iommu: Directly use ida_alloc()/free()
Message-ID: <20220527141200.GA3227994@nvidia.com>
References: <20220527070307.2359150-1-liuke94@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527070307.2359150-1-liuke94@huawei.com>
X-ClientProxiedBy: MN2PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:208:239::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70fa6f2f-a2bc-43d2-2a66-08da3feadecd
X-MS-TrafficTypeDiagnostic: CH0PR12MB5124:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB512486E88DB52E159373F594C2D89@CH0PR12MB5124.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZTFmdzIv4UtYQkJs2YREDYXLdzl0M8C5U4vHBfO2aKTMJrN6IOGSOi6EqVXJwMaddfo9hIa34jLncYhC/5Fv6zd7XkxWDxUdwMfjTCv5WkmcI/a3HZYdiXrVkPzMX3cReWN9N8Tk6U7+qGyJAg9gOdb2LVoEBrckQvLO+DW2OE2Q371A6xlQmz3pZFRo39t/xcrnIK7D52AIkfcjprVgf3LuIdr7nvTqK3kKlcN/kpfI8w+bN39/3t9ZeEt4bOHYEGARA/tMBGL4RvquLejVGEGxRYh5DWiaJ4RslVNDzCPZ3fegJZekYlU46uR1q9j0q1Cetu66iFWwOIMY0qnwnzs8VA7GWr2az/y9libltI3Hui7GZeai0p5o0JwKHECE93lXWp7jcaclVQZ/gifD4gclVU2xE+B5Q0Z4G7THsbSTxrd+0az9SriQhB3kZSfz3pcGrl6PfgcmZ1p5S1bEjV5FexWRap00e3mMTXBXnT3nRfD2GMLVlPSq3cBO3uUckvX32jMDF9g5A4qJY25hAU2gXlL5HnhH6e0VXaaVzgDN62oeb4ZLqD/OXznnEH5eo2z4KmIyAD+sy0Nw76KdPw4ZM7r//hcf+zdjjGr1yoUcEnaK2WqUgRb075wKzkhtpTv6s5XYXpIeowOPL8uog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(4744005)(66946007)(33656002)(8936002)(8676002)(4326008)(38100700002)(6916009)(83380400001)(86362001)(316002)(66476007)(66556008)(36756003)(2906002)(6486002)(26005)(508600001)(6512007)(6506007)(2616005)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?va3HiLCubSYOHX8kW/8v+RXyWNlrNgfY7hPHkNk6wSRvTS4xO3KfHu4E+Zi2?=
 =?us-ascii?Q?A4QPDQdpebbxjJDQl3yo4J7wc7qT5sr2DTYXe/9nZLPZQrsGTMnoK09V3csG?=
 =?us-ascii?Q?LPlp0QB6cmJhea8sceS+cq2tY9AmbjHTCXukwfN/L/n61Z3sKNvvb/OLV/P8?=
 =?us-ascii?Q?Ag0Bf3xcVIV3/0wlonu0W05rL+ehb8gcm2dnEbkQuJv6de52U2IbUGkl23h+?=
 =?us-ascii?Q?7H9wAjhTXUyb2mmezHgpZsC+b55FG/d4TRZPGgiwvWOBTGH8cJ+OpbQfD/g3?=
 =?us-ascii?Q?IvYHFhp9nT8wsDwFa7DCPawVez/lb8DmF0rHrAKwm0vbFwbtnGAf8XnPulW5?=
 =?us-ascii?Q?Kp/Sz+6eY3VSaNUjecFAjNuUPWEtg6l0fXxfsS+O7zOFrtImT/3mtFyoWtAO?=
 =?us-ascii?Q?Wi2bHtqsrvLGjRvCPoWlvcuvX3oH1InvNjdY0/LGJ2VmLk6GlpSLIkyRU3ir?=
 =?us-ascii?Q?oTRw76V5+5lLf7357XMZojxxoSb2c8j25gmt1vhPNvOmQCQQNu4GB59SZBcX?=
 =?us-ascii?Q?Kjg+ZisR5OauIUSm9ow61W0jHrgG7v0OD/d/QcqiZvVd2IQeAn4QWoi17pDf?=
 =?us-ascii?Q?naz5mzuoSt04qcUcml842qLcEKdkzyeWh81dPlNK0M5THfmUDHOLD5yuCBnq?=
 =?us-ascii?Q?J/6knQCHxnTmpN21qg7SJtbJa6tM6fkckqsJ5d4jZu00AUwzUkLTXHozRKTU?=
 =?us-ascii?Q?mQpFEXgX0F70PJu2AH5j1XGstpQX/xqW4/livQUTRy+HOK8OYeocH+XOCRv7?=
 =?us-ascii?Q?LTiyeseA4i48M87QGZJe1FWc/FXopEZ9OOinEnEsLRvG4+Kbd1TnIr4Z55NH?=
 =?us-ascii?Q?aXYZGhcxZU3VTVK00PtEr1+IXzDxn1tR1LianKr63dARToDOnh0J2tmcL5cS?=
 =?us-ascii?Q?WBTxpn8tjflEGsDqEbbuHXeGl06jPwaCYW7DboMwNuvNrd1VB2Rb0Ee79W0E?=
 =?us-ascii?Q?HFspYsdjBAYxlHhiUs2zptu/hUmCvROQD3GuZnlS/xMvxmRc8LBkMKqnYGW0?=
 =?us-ascii?Q?bw9VYf/WTWrs8mbCzt863K+N2T+GvNpekjA3Aee1a+OcD5zNUbVoyvTU8q2S?=
 =?us-ascii?Q?qcw8MbGdP1jBfk1/ozKFI2jSPKq2V3Y3vfASpQ+xdKFcorcwMUpbXFkZzVHh?=
 =?us-ascii?Q?txRC47yHiXG0BuiARaUbI9FUhT8SFYSYbssDBs2Ot31jL8QFrb6cjXBBOZh8?=
 =?us-ascii?Q?Gusg5RsSFvAxp7x7sK4fWQ/B2MJRzEI5cWbkOn5oK0calN494rfVxKs1JIts?=
 =?us-ascii?Q?8Z7bUSYBvqKVd/2Ll2K2drLdPQGUedexn8RtGhUpxvWNcE7YKVXRCqEwVeRT?=
 =?us-ascii?Q?owFmmHzS1LrX/LD8m5vv+BzUyvqGuV0nDj4YSjI7ICbnQBcXNq+KxVztysoC?=
 =?us-ascii?Q?AV0i0cADXEJD3b6br7xRINPmhtU6ew6McL2hPFLbV2KVoekpXcygLFbt8QSX?=
 =?us-ascii?Q?7PCuHQKD6yIZAEoUA6smoxKH4kY2D2kdq+HWiVqC/jyZZQQper31w0vZ3+7G?=
 =?us-ascii?Q?3ZH1HsJ8BK1ao4o+vDD0RT9m4e7Cxqlg1u77/NXxCihNyzJHdzDmMou2dFSQ?=
 =?us-ascii?Q?1cnuUpFN3/mi28rSjLY470hDAQkDG2mhEF04WX+BC4X9ykFKMDaP1pWm6T5S?=
 =?us-ascii?Q?B/8saJ4qtj6dirjBb54+5c+eOkPFUPLI6VhquHsAoJ+iVDDWpp9dftrQbH36?=
 =?us-ascii?Q?926zEz4dQxnDvd28JZSyt7DbkcPz2aglMAkdJPqHh1bQkOmnPKsRn18CrvCC?=
 =?us-ascii?Q?3YXuBFgBsg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fa6f2f-a2bc-43d2-2a66-08da3feadecd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 14:12:02.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Suli0oSG5Klu295VtN+L4u3ulw6u0d61kHxTsT0jHE0Ld61blZziGIK2J8tC9EzN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 07:03:07AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>
> ---
>  drivers/iommu/iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
