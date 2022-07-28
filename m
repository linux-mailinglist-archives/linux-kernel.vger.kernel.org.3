Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7078758448B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiG1Q7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiG1Q70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:59:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E20743D2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrcgS/jbUikNcoKcc75GVK8qvsvXkF/ckgC7Z4TrCPVPPpc4/AaJyzcv/5l83gKJho4i5JqWE2h+LBYEpwP0mNmd0QVByFeU6JPBB5TjeQCl1heLxyzRE9O3IT4hjdK3ioLuetcX+XlKJnDBrLsHVr+i47N4owmwQQfBm/PPGSqCgxUz536H+VfCrLZBRIrFE9xOM5Pzdj2KOOjyK2wA6WpojIyo1QtOUQZip+Hgp0bkD37WA/P4nwteqGIe1OvnCcwvyrlwdnx8fpBe0qXuEaW8LwP/RS9BS5kSGp19GrJDv8IiV1tdCqvTfW403vTLBxjUKGXXmXsBWovIFFsVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbwfqx7c8hn2p8x1zazq73bZbbCOyYIOP2KNYo4hnkk=;
 b=fZQT90jHvrALGtWaxGJzNPa8dnmUpKKqDmYDLP7iM5y4InGccomCt0Hgq8MS8fjy6cgoxCN09W0IBPbw7UOiMMwHbI58TlmTgRzZEQMbAEGazv5lReJdTEdAo5rdvvBrCukJ/OdGDFTrNpIjxnISO1IDJ1kiocSvjvA+x8Whe9VZnt3+bnQDuujf9XjNyBRQ1Fd67opFTlf8K01Ebw4jtIdL2e/WTxeh0pCaEDPAicgu5FZrq5O2BlmiTnbBdkS8vWBEX0GhwffcSjSAjVb0hIijmjUjCCfNe0B4APxIhNqut9JNKu7iY4LWekOCJtyQa9fBuSMirXGiwezECh/58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbwfqx7c8hn2p8x1zazq73bZbbCOyYIOP2KNYo4hnkk=;
 b=YrPgNzXV8qw068Qu7ia/GIxSOgjrIa/XOlnZ57pQwMWdu5MnbRut/F+qNaqczmdIRi+l/TBmcM2wSeTiqdX57ZilHa7w67WzJjhiQcyBtXZeLizezdMW3SCqfFev2zVdRkO7oDyvPJ0orWIi2yR2NH0JdtBf0Oj1eb5OEvjNfLh9rQ9aCrJmvRbfmFL+8/88AljpZSDTgzw3y58K0c21rTacaGtbS0mqHgyGnhVqPM/CYP4H+E4wMlJmXhIehkknIN8C7uLQUq78mLcybXHhyUOdUf0jPnxddVTJq6VkJP+xOy6aC3mO7xdtg7sl26Zvb56GU02FmF5dGYfKWHbdaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 16:59:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 16:59:21 +0000
Date:   Thu, 28 Jul 2022 08:59:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Message-ID: <YuJ6MXoNTj0RKCb8@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220727115339.GM4438@nvidia.com>
 <BN9PR11MB52766C3D37FA985DEBDC30C78C969@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52766C3D37FA985DEBDC30C78C969@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:208:2d::46) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8867778-66d9-4093-db60-08da70ba8422
X-MS-TrafficTypeDiagnostic: MN0PR12MB6271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3McMyEIgsVeudFC3yLD0kSKCLMvbR1zKLgL8SeeKje800Ffy49F6MO/uIXQr6GYAEglWkm5jijx+oWWCiCJzAu0UexcNFAHibEGV5xvZWlVpNKqlUk11LyhWqh5bOhCBQ+2nIeGVGVnzI5lYaC+y6w4k3A//oIcfDtA7QynNfFtnatlm1ZIzBI7xQZca55KETKCTQjX+K0PTnImAe8t6OtobGSF14eeNhBHe5WlWgZissrfoDbeEoy1QwgRv5BafjdVCp+VeUdqY4DuwB1NZHsqMS65xiG+QQCf9GHPs1v46opp+/7ySOptsUs3mzzpJflZ5cPcdp758h+IOhn/+6a/23gAMpGRFQtOKJnF/+7tW9JHNeKITPd+I0YmiKac9Td7nJCgZ55sxphaEcfKDQnnlVq+E39sb8tUAsNb02VSqBUk7WRsJHWj8ZoWzlppe216EM9VlucJY2OMvrQ+/73yNN38gZQ0UEp462hImmN7vYnXQY6PKPQpfRLxa199ROJ2HB3KfuTPQAkOHHIcN5IlzH6RK1ynH17Kpe94D1ri1mqFvpSy1WfpYVfJAbRdK7iMrQnzdjnWNVl3i2hrddAEhzqsWwElvn18FsYM8FnoP//5393XV99GrI4/WSEVWVUgfqzT+frBJwsnkZ0Mib5Z563CnOhkFWiSnyWx0mDaKwCXLKjiy5+FO3UfSRLMzG5w5/UGzomZo4wClCDJAAEOTcmvXzv5VftG6pJSf2qTfpZeVbRhBfO0OCeFefJd+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(36756003)(7416002)(5660300002)(2906002)(8676002)(6862004)(8936002)(4326008)(66556008)(4744005)(86362001)(66946007)(54906003)(316002)(66476007)(6666004)(41300700001)(6506007)(26005)(2616005)(38100700002)(6512007)(186003)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ew27bYPqxqRkosDyX4G4BcykDHnlchghGStmpDjxmjIRk+ln3WO0o6MkiY+h?=
 =?us-ascii?Q?8D/FlyWoHUOiXtRr4oy+xOaVevK8LGj6RZjl0eY1NGtqhUW/W74cbnjCKrls?=
 =?us-ascii?Q?qNEqVZG+fPLhxfuT0UG/Zgk45ydKDZwpsZ2MjwK9lFSK0bgrq2c0hD3twlq4?=
 =?us-ascii?Q?K1/Vb3Vbl3MLoz2jw6Kh+b4wUM52fQB4/DGK0Askd1zRQ4SWkimuMrQMDEP1?=
 =?us-ascii?Q?RhmSVAn2HKOAptHxhCRo7casKQpWkG7S7W3TwQwMmyH7HvOfonC1JrE4hjnD?=
 =?us-ascii?Q?GlXOSIsq6FyNDvq2hVLPAEF3PQtlY5fm7/1OeR/KnI5AipGIPYNx77RtIYRj?=
 =?us-ascii?Q?r+SOWi0g3e3xVw24fYu/vlPCRDys0Ffzmk/cKxsK801yVq7oYmFRtYNzeF57?=
 =?us-ascii?Q?5zVZvNRvo+jdj6jxKVFUTUBv4N8LYduZ2Eig1woCbf9g6baPIzAj2heLhysM?=
 =?us-ascii?Q?GwQm6JYzPQfF9o7DTGTDmbffq5uDUOxYAUWwXjN3IJH5GAz88Msh7ruvUGRw?=
 =?us-ascii?Q?W/0IsuzsyKa3+mCO+x3NvOP9ari3CONsLUXRjt2F2pfIlDlzYVUjVfnvStVU?=
 =?us-ascii?Q?1w+770eJm5hbHBHXGXocN6V4ELR6uH+AnQciIHebjhee5m1rxZxoJIunn++F?=
 =?us-ascii?Q?UgtnoHmXHYN1ImveLlzL/237jt5p+E5h/PE4uXH5JKIpycxevXjKemVXloWz?=
 =?us-ascii?Q?5hwB7FbkvWz/SyK/Vd9YGX39J3u0lD9W9n52j+SojiLpumQmP4srYp2pSLZk?=
 =?us-ascii?Q?CgushiOXkir0OvP+lVPSavHWRv79wUIx1UFn4ubGXB+HElxP9TG2Lkum8euR?=
 =?us-ascii?Q?QiycyGyDc398mivDYNlFNkEo0/EEvQZQdJe3Uo0iGS2qiWUzpbzk4ZRY2C1w?=
 =?us-ascii?Q?84h6MVkbD/2u7/W2GM8gFMyWT52ZiLyCNqkBHc4/xh2jlDRJOakPgKZ92Q74?=
 =?us-ascii?Q?oN4QN8WCk8snIgunGRQtdZ1sKPiCV8Q7+CmMbx/B8Vz20dYtDTNZ2WLfAIf9?=
 =?us-ascii?Q?LzQsh8f5ggPgdSWzNDATuvyp36ooumV/XXWdVwZhukd2bwqgZ68/PT5wfElg?=
 =?us-ascii?Q?tTg0hpPoSGkIoPYuE0/OMziCekTVoWdRrEvYCp0dJNcA2xQCl58/ZUdif4Lv?=
 =?us-ascii?Q?lwas1iatyCYFr/Ao7+bqx+HqLMpCoOKeEpa2tmVRXCkH1pthAETy2gbCTAt+?=
 =?us-ascii?Q?+xFWHNVdVSV0SZT22q0su/z9J4kDv2YorK0AxAp6+LLIVD/+ZiApaYSuYGtv?=
 =?us-ascii?Q?ECm3HRwL77erPSOgTETRSacEqAd3LvJY2CSNxUX0Hglm84DfW9Z9agaaAXDb?=
 =?us-ascii?Q?8CwWP8GtZKt4ke32heBG9+qgoTrYCUfPzP6Ai/yYWVMW/ZaMKYOEUlOvz5nu?=
 =?us-ascii?Q?z726LOqO5DrDjW36RjH6tLoJVnTLlhLxzyKElbP+/HYM0DxaARJLE5RiBcFi?=
 =?us-ascii?Q?eBnz3u6xxRWOQXlXzA88XwEfIGavYlKzszS97D6cNt42IrXeJI90JyI/bv3d?=
 =?us-ascii?Q?N7uPb0eULKSqIEOO+xK9Od/sQUqTNWkbpZ3IHSz5Qv3uhk4rN1o2z1/rmicz?=
 =?us-ascii?Q?0nT37+SaVTChDdsYDetdu/uaSsckeG6G0x02QvSj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8867778-66d9-4093-db60-08da70ba8422
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 16:59:21.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnjxKrT2Vkd1bO+we5qHdQuLtGL5RqVZOo8Y/FFaaMAWVVsfvQ6UFgBL5EDZE2Js
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:06:47AM +0000, Tian, Kevin wrote:

> > Then we don't need this weirdo check in the core iommu code at all.
> 
> and then we could also move group->pasid_array to device->pasid_array
> with this approach. Though the end result doesn't change i.e. still only
> the singleton group can enable pasid the iommu core can just stick to
> the device manner now.

I don't see why, the group is still logically the unit of attachment
in the iommu area, and if we have a multi-device group it just means
we iterate over all the devices in the group when doing pasid set, no
different than a RID.

Jason
