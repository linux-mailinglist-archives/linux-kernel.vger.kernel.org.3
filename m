Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DEF4DBA9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiCPWRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiCPWRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:17:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E304DAA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcF/zxRxfdAVzseu7vk8DlRE3P+2itYB/N/nCwWDh1e83iUqqn6gjV3vvGQWs3sWGJ8HO/pM0eq/udHbCB6ktgCSAWj8Z36tOCtzXhaty2/0yImMl7Oa7cAiN6Fy2Z6oXsDXpr7Tzocs3lSGDGkroXfCi2wSLCPbYVMhORi7qQeBAHoqeC/gU5bKSZc//akwBTPPb4qDCyoOWYoPuvNRGwikTcf1Z8DMzMyacnXL2Y5tCN4f+W6qE15O8fCU1eTrKSwo/y0TQiOGcYtPWtQS9TMVIgqnv8MrxqE1fV0kaNGVjxiXR0onXX3ZI6zQDVcHD6RX3Ex1zuH3NxvXWJEF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3eT2Pp+9qC2TBX6pfNaaoCnfZPulrMCpqo2FXk5B/o=;
 b=hjhAvCjgYuCVzS/Yt8jm4gVtuoCz5uIOapBTFFuLQrwouSOQwX6uwv3QwuYcyYatvDAujwe1JOBcY0DQKaoITOVJ4xQ1+rvr90vgY5bf1lii2AZnzr4bxEdNudGY1BOatRjWIbdZ79BgDyNGKueshZBnU7nTmcw4EJIM6PUuBb804P4V2P1sOx3Wsyq31avqIO43XSdW2Dxvulcd4zToT5Zj5pi0x6pg+jp+QyPcfF3kIPNCEvyfM9XFhDusZqfTw2QcDEYqyc0KwcSeuWU8ew30UFxfoviea9BNAq+jv3SUCRWecekp9kewGRg/lT01EqEjsq9yAwgy5LjgTM6G0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3eT2Pp+9qC2TBX6pfNaaoCnfZPulrMCpqo2FXk5B/o=;
 b=QkACC29fy2ltG0gk+S7C5JzxshG51bXomYF2e004J6KCSTYC63wF8nP2Hxx338dVsAQsdBGWAFQDRYO/3jjENxMoUwhZn0CSMHzRjvEb5O+HiNVOxYuo1Z0ocDXjSbIq3WyHL6jYPnvEbio7WdaHunBwfW+FuRGNmdOuPnGc3NZMiP8v1Bau0C/tpPPaehTtuD6ny19tRvYvE0MfQsYjs3muJ8FzUTyeO6Sce3ipDZSLKbY6d8kEjNfNx18Ju/CcSXNQNmMbQs5swrpWajFn40d6X39l/eTbbTvQw/L8einwWS3ypw5BePuYaLzMOhpqNcXEGvQrzzbSLqfnSKx6eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 22:15:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 22:15:52 +0000
Date:   Wed, 16 Mar 2022 19:15:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220316221550.GS11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
 <20220315153620.710a30fa@jacob-builder>
 <20220315230457.GO11336@nvidia.com>
 <20220316135004.61ae1611@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316135004.61ae1611@jacob-builder>
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eb8dd55-aa3d-46e4-b721-08da079a8872
X-MS-TrafficTypeDiagnostic: BY5PR12MB3827:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3827E38C5733561B4DC738AFC2119@BY5PR12MB3827.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxWUpi8t+7Lq46/a0FGYMARc0lCEn3BFuaYAX0bzVnpnOqBWTouDjj8H2Q6st0eeWiVl+i3Het2SYoEJ3AbqSDTEdt2iIsijJ9D/tKxelHfBEGgc8cdbcZlGnlmn1eeahLHH/6Fh1PvFcsaZ6pMNtvYm2nblRdjmTNAxzQ8hH8hrmIBIrQRMPEni6xZN0Y13qC/Rt85Ou2N5PY33BpeJRORce9GQ5oNwGvC3hnloMh3UbpJenZKuLOflXYrG1uhoRG8y+1DEAwY/qTgZtsHGJYNBQuW1Plft6NIuFlefu4M1rB5jeA/Nys/+KbVlogJbClyPEq9IeSjfcOedoo3e0b60THJbhw7wGsYz5wz320ld7ltxyhlUd4VXrhgk6yCdr0RFmgSx/pQqUAcPijZqTFp2AsKM8CQZEP8XyEp7mpFB9euw0D3HEcLEA63UehrQv/TON1+OrMGsBr1/NT/QpPYfmkP+MrIMPkO2uHNSXPhm7ohIT0er+1pjW8PJAr95DEx6ScVKAGPe69enJPw5p7FfF++ZDhg6mAOUiX/48QRXKgsueLD+RN5Db9nZ8v1LH0QLg050MS/B6+jJhJL0Ac6kTByyJjPK43BWtXL7+jwnMI+9RC1Pn9rw9TWmpyLPBjJq4VZumihblNMW0tr9/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(66476007)(6506007)(4326008)(508600001)(316002)(66556008)(6916009)(54906003)(8676002)(33656002)(6486002)(86362001)(7416002)(4744005)(83380400001)(186003)(1076003)(26005)(2616005)(2906002)(6512007)(8936002)(36756003)(66946007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3KCVqboiDw0T7O9ntX8amiQtT+RoLoY1lc0u/lLC647bV/jZkrHeiVjeg/hY?=
 =?us-ascii?Q?ktUz/Lghe4nFVb0/tZQLhyH2WG4IOL8NefK9vTF8sT143ZsbfhxMwEA44htA?=
 =?us-ascii?Q?VElwun7l4AQL5n63p5SAc9GPEHsB4D0RzlZQHD/TzUUoI73b+OiagYGmpGzs?=
 =?us-ascii?Q?kEqR1jHPyf7wHyYw3yNJdkybQh1OavFNEWTtz/ZHrCIBc+UeTN3doz9Yfyb1?=
 =?us-ascii?Q?sDdQdQkzapu4oTG0Eyn08eb6HYD2Lq/Syo3WuzvUE5NW+FOQj2v5FKYaDsLz?=
 =?us-ascii?Q?S+PIWDaXoXedPxzhtlNeyjdnuRLyJD575ls/cYJtgTnnS0z/m/iwDaMaRSxp?=
 =?us-ascii?Q?bZ8z5jsYMSJrXWYmMoYE2UqJrOJ7dFlXNmZaXuLsJqj/fTWD9lfxDJC9FneE?=
 =?us-ascii?Q?k4hnaLgNGmMdSGymZ81YW949oAPaY0kgKhdQr/zFq2W1zbsz9527d+h4Bppb?=
 =?us-ascii?Q?W2BFUDvQ6APa8MWXKq6Q4+b1xKq2dbxrfIVN2Ir/B/pZSeFQv5B5VZ4V7/QP?=
 =?us-ascii?Q?QDr39iHdH5bdHZbP6vek3WrhX8Bf6VH7YJDGL8ErZ6rnjg/vqLNn7KIEatH/?=
 =?us-ascii?Q?Pwgg5yxnzk5E2aYBs7XEum7h0Y08g1glqFlYHZVe2UH1TiWQunMmMfDvMrmo?=
 =?us-ascii?Q?dG/RtEn5+bP9DUIlJP2oOqkjac7x7kqSfWoFWhRcL9fVzTE5ylRDuOYbn2id?=
 =?us-ascii?Q?8Ik+dxkWzhWFWqBYjJoCRFlILdQhQ37q/0sy3OJSg2gjKyM6OXT5UPh2qsJ4?=
 =?us-ascii?Q?8hfJiFjvOXZQvV1Cg8ozJCKExoPMr5+NvpdqtbCPUxkwKo+nnGVVG0zG2aqx?=
 =?us-ascii?Q?nejXtkLI43rOCjH4eStscD/rd6jkOrvTdxK4JAwVnsuAod6tsBepm0qK5o4h?=
 =?us-ascii?Q?Ty5EWgpHvrEW9oItJdLwn3ItpoOz54tyqJ1ZwWR1fsdIRweLJEOpzveNOlna?=
 =?us-ascii?Q?zaR0GdU6DQOJsUHok/HEj4SmzsoghH11RL5lwB1meVNMGb7o6uZfFpTJCS/0?=
 =?us-ascii?Q?zkTAXaXwWcpd70szklU7ra581b9gHzhYCQCLybHchXSt3zl+A72RbfXFfC3B?=
 =?us-ascii?Q?HcEngazyFPMTVuU/JFc0hHLJzhZwKGl483/bdPClNTOtXbJ9vKxiYOXyZtHC?=
 =?us-ascii?Q?abX6crWsAbq3BiB6G+TI9TGrl1FfIcSF5wFbD35W/VS0T3vMhECpfzP3hTaC?=
 =?us-ascii?Q?AjYsPiFWqYsTvwx7dhODju5LHUfR1gIPcvCEhIFKo0d3KIXbvmv3BHPZFqDo?=
 =?us-ascii?Q?IsRRBy8v6zNlvDXUQLtESNjXZnoLc5ng8lqa9tnHKgcBuOJHDtfgA4b1RByO?=
 =?us-ascii?Q?bPKOcCUZ8f+ySAoTYPSF1sDzInSwbJOWru6Moaeo/kyoI4K0TA3mLJ8UKnNU?=
 =?us-ascii?Q?XtTJ3Rena+1zD5+ACZhd2rFzTgEC+Is3T1EOgmvQ9Vb5DI/5rHGWZsvO2d1K?=
 =?us-ascii?Q?vGfC41PtUr1j4XHcfms12dZszAi/5X/6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb8dd55-aa3d-46e4-b721-08da079a8872
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 22:15:52.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYdoSO8odqo9nu0pX0/yxzqbwZcpj8agK5Q9TopccrCGWVy+CRLvGv3ZScy4nmdF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3827
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:50:04PM -0700, Jacob Pan wrote:

> I guess a list of (device, pasid) tuples as you suggested could work but it
> will have duplicated device entries since each device could have multiple
> PASIDs. right?

Is assigning the same iommu_domain to multiple PASIDs of the same
device something worth optimizing for?

I would expect real applications will try to use the same PASID for
the same IOVA map to optimize IOTLB caching.

Is there a use case for that I'm missing?

Otherwise your explanation is what I was imagining as well.

I would also think about expanding your struct so that the device
driver can track per-device per-domain data as well, that seems
useful IIRC?

ie put a 'sizeof_iommu_dev_pasid_data' in the domain->ops and
allocate that much memory so the driver can use the trailer space for
its own purpose.

Jason
