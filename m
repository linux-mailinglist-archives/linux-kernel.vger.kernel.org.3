Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAE517022
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385231AbiEBNWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbiEBNWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:22:34 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFAEB7DB
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdISTtQzHJIQNk15v3bWK3UkIjLbmOhLIuaI3QAN5xYDFEppcpS62sAGNLDm/KtLCA9GOxMWqf1rNBghG2YfEq9JuLffxWLJtFWj2QJPBO4TDArYdrbnce+d+nQM5Ze9YmEp5Bz4tPg+Y9EW4oujFK4vtEf0KcSnsXV8B5nmLtjbxMrDUdvX22zjR8PJa8jtRFzZyAWtHqGO5eW+hvz3zN+5kjvHTqW1rIj8kK0/B06n1iTkF/KrKuLT4JLCy7FuPK9x7bp4J75BeIPX+Xr0Jwkzuj6uEfNm0JBrDeDuOI/Mf/nOTO43Rp5ZG8/Z2s4OOLMSx8yhnS1YHkeL7/C/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQPbFdzeLlqQiHAUO1QCh9Ghp2RFzvm0SK2YKv+6SqY=;
 b=LeFfex3iUfRGcUW0uQuna0J8mBVonM+ep+WM9T23joftx9ZTQyTaOtg1sIHKPdOSj4sjhyGW9oI/jfPpdJ9qsqFaL3z5s6jLcJdRinjIEahhb2zjjdi5/dOFwULSWcrEw66khxmcCVvJdAxVp5CBOp2jyHns6dEVTtuKxXT7hxq3OgeO6Fbg6wO+MDA7MCqe907l2kUI1qvRn8MJX2+WKVU+b1LmqccROVgzRMVXTiYmpFtxYMUg/osldOf6/GyDRCwp6Gr8+7l6r0exGJm7e6seERS7abrTcqVw/U5DWF4w8lnNEXI7ZLpeMaGVyAUPAi2QkKMvxcDtzirPHR8IfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQPbFdzeLlqQiHAUO1QCh9Ghp2RFzvm0SK2YKv+6SqY=;
 b=MkRm+WKufrR2yqHnwANymr/GTjTbWqqdc1iszODVdChYxUAXOGG84QxakZBfPEhz+D4i8bsZApzW4rd71jER6IojpJiCQBsFyNeF1OJTOeCkeiOGaqM8acdXv6HI5fewLJ5DTAaxRCTbRHl1r21z/yxGPV7QUI0bFvDuKMRiUZGIHfPMq9NBZZBiV4D7U0fPXV9qMKymuxlB7/Q9UNPJ4NMFnKIE7SBzjEjxBWApzlVJnkt3+TdlD6wY84M+yn+G07uT28W91E3vqEmeLpxV6RWcvhAJVmsz5QgtgG/e2XYXUTQRs6A93/9yZi6ewOwsjV/C7+owP3likMnPEl7rqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3214.namprd12.prod.outlook.com (2603:10b6:208:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Mon, 2 May
 2022 13:19:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 13:19:03 +0000
Date:   Mon, 2 May 2022 10:19:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu/vt-d: Remove domain_update_iommu_snooping()
Message-ID: <20220502131902.GK8364@nvidia.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501112434.874236-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0250.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38c7af0b-9b5f-45dd-3d5d-08da2c3e5412
X-MS-TrafficTypeDiagnostic: MN2PR12MB3214:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3214533FBA21AEBF17E7C4BEC2C19@MN2PR12MB3214.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhLkPGfPdR83O5QcunBkLDvPHXSU1zWFK0ezdAC9IfRVDp3wRWkirrTL0NPX5955+lkLveyr4zZTzCP2SR4sj4Vt2pbVU3BYiXEY623cjwWWvt6j9jkBzUHxXZrISCNqYQXvgZOdpEkD1hNMM932Qrv+bQcYi6cbMAdFc2r5mxvVZ/+Vm1SPSCd3pUaM9b4dpx1eAOHJZbSAtK6x9fkPUuBaQvmen5Y9uyUVKV3UoW2nbSDDZO47PSh8CJDbs5JiKvTiPk4+JRu3egnvo6uRLfawLILqILmK/RQDy7kMMDiHvF7HASfocwqYRtX8mOjSAV/yj9s/Qp55QinOCes5BZ3qcFvSmS+NRzLn/xvTFASNbTriVvoKON2n/2rISvQS0dsj+G49KbFo9s94E+uNa1nG3YlLaY0J9tktWe0kAgCbxw1gbsdS7RzB+oVKlmmH/L3LJZRmc/1264+5qE8GHr9KdzTZCiC7Ur75InDTf1iVR0gBjaWj5KNaL7nj3nV3SVuz6hlong7LK825tW0lk6cd8OJcCfSoRRg5q+6ina7KwCsQkiI0TzEz31M6jfz6QSFe1BGdX+t/RBZORCSRn5IJcBV1o1n+wwsm//w7C3yE4l7JLWHp0OrzCG3scT4psrN15AHm+STuLh1Tf4gkQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(26005)(4326008)(8936002)(6512007)(66946007)(66556008)(66476007)(8676002)(4744005)(36756003)(2906002)(38100700002)(5660300002)(33656002)(316002)(86362001)(6916009)(54906003)(2616005)(1076003)(6486002)(83380400001)(508600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8EbZT/dApASP1H8Dst9ebBsYPrMaQCc+vF6ueAwLXOHNBq3GiUV0MahK6CDl?=
 =?us-ascii?Q?7Dhl9FxYwsv0bQ2i/FGeE3cfcUUSOVyEK1t72tlNroGAZESNhtu4DdRlvP2j?=
 =?us-ascii?Q?eWJap+f7uYMuJPYTbgo/8vucjhqvf/jT4j5YtkYqXpDf8i11iY3O/TCJaO52?=
 =?us-ascii?Q?95orOJKgBmbAw/m7Ufw6QD8cfGAyXwkw3okH2ZMGDnd9NPQaIXYK48QeYKUo?=
 =?us-ascii?Q?jPGTL5ENLc8SdAX3056oF7u3ufM2Hk/JZ5z5ith8YpnDDEyzZFj4ojqKHTYw?=
 =?us-ascii?Q?G1qKXc6W7mw0TK01qyakmfBuZtqTJLpxMzo+gFBVas9K1hqJjBWEZC9Xc5tR?=
 =?us-ascii?Q?hEygQYmDF9/sjWwdLG8NXchunsyOgirCiXvck9xHQ4AmIn/NYSklMpSv9/h5?=
 =?us-ascii?Q?DidTGYA9+DuShApgtfHqQ7TLY88habgbBrp8LxAVoU7m7CzdnAVVjeAvxBeq?=
 =?us-ascii?Q?hL2ScnkmU3NHc4yeDkrKoX+61AEGcqBhF5+71dSuNMLvXJSH5Bjxzl5DOkI7?=
 =?us-ascii?Q?6uUCqp3Rt3kE3GrJ/a6aXpz5zCyUn5hwWfxBzGnUL67xojR6WfbLezAGSo0f?=
 =?us-ascii?Q?hpy/3dsRKDRyuqe3SqB04qKvO3ju/IECrbLh1PjBmf3e2rANrhdRQgIKE+GJ?=
 =?us-ascii?Q?T3KfralQR/J1X6HfR/xLTXrC6Zq6TNkDUbVnze+C6IkwMHVeGkw1WJQpGuwV?=
 =?us-ascii?Q?ZMkOVCsLnFx309cpV31gY4HomVvPzmZAeIKe+KNa7T2FR3EDGvKttS+5bygg?=
 =?us-ascii?Q?7BK5ISflj7l9KWAMgjfYb4D3DFh4OM/mfVAE+79mbdy5wPtYyU9rVO4rbPv9?=
 =?us-ascii?Q?H3wvh6cLBHLIKRLR//H3Dxl+LcXK53DLuELnSmrV1fRD1505TyHkKvauycsU?=
 =?us-ascii?Q?+7XH4Xiyw297tzncz6C4OHN8ltyKkA4HsuGH4OFRz/gu0PtOTq7RBSlBSBwE?=
 =?us-ascii?Q?XOso/5/K9T612NHmFAhRmY2zgATK1CfxbYnFVprifi4gVFZumq5DOuzOjNeo?=
 =?us-ascii?Q?6964veL8V+0KQjjbioA8X6mDXqg/+/w8KZsi9tefQsqJdTfVtzvT3pDvc/Y1?=
 =?us-ascii?Q?RO6f6WvknvIOPWvx7l5kdlyv86Pyna4aOuyLzLGhS1k0anWRo8W+3G0rNT9r?=
 =?us-ascii?Q?LvhiR8+/CP23r9ZtjT65k6xHT/1oCjy7GQOCmRjEZtsgy2qPKyvOc7GnoSme?=
 =?us-ascii?Q?UJIF+P58A5r0gAxCjn8VMuxuMwrBvUOSsaOP9lU1aAmChmPdJvwTFwRyu6y1?=
 =?us-ascii?Q?mO7KYL5bycNlFEMDr8lNWfQtY4HVI7VMtqeoOb4LTZFb2sI+C0rddUWH/XUB?=
 =?us-ascii?Q?XQz868fQHRCxuEg4f6fOV4mHH5oGsL9WeA5e8fQAdn/yqO60WB7VGsgEe0OM?=
 =?us-ascii?Q?z0xTOUUwURvJfN7VuUtThW3l1R8TgYKJtkCmC6I2ZVHAWHn1CJY1l/0YIoOx?=
 =?us-ascii?Q?5to3eTGN9YaLKK3u4hsoivjVuyqSL9GWqAiVMsxKwmbvsbD9taj/1Cfc5Uq8?=
 =?us-ascii?Q?jPbNzf82jt48h7u9Rz4LeyDHfYdxZWmxfT4zoPIZanUc2sK2jEY+vMOJpic5?=
 =?us-ascii?Q?MWllgjie2f2eA9TxVazbNjB+HvDMvCOnJIzKNUfaS4U58x0F5rxhicLMUHtA?=
 =?us-ascii?Q?3OzC7wpCntyhgP06XFUuuQJxml+iJ1vrgobqS7GR6zNT9NERVdlMkU6m/nVy?=
 =?us-ascii?Q?OF3cRmdJHUZOE72UQnrssB4ENx2VwvU5QoeQTlFUtn0ji8HEY/AUhQuKGfaZ?=
 =?us-ascii?Q?nKVwhOaDpQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c7af0b-9b5f-45dd-3d5d-08da2c3e5412
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 13:19:03.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9M3PF6UbmYc6LRkUfBjaUH2P2vVjpVwNFRKmWdM8zDiyWV06aO6HYKI3fdYsMEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3214
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 07:24:33PM +0800, Lu Baolu wrote:
> The IOMMU force snooping capability is not required to be consistent
> among all the IOMMUs anymore. Remove force snooping capability check
> in the IOMMU hot-add path and domain_update_iommu_snooping() becomes
> a dead code now.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 34 +---------------------------------
>  1 file changed, 1 insertion(+), 33 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
