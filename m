Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD4B4E26C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347525AbiCUMpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347520AbiCUMpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:45:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006868EB68
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTemh7KwHM86gZrBQM1rwG9eoG+/kVRicT2/1Mj9gnjRr2N+KAIPfWYXX21Fz6jC9hz7rn3zFVhCkyeRaaHkNsWvP7tiUXGMK4UCRs7IDJtAzKMVtdCwixwcshtAcuBjK62ij06KLjrSBp60uYqvTSV2gcAh35jsikejoi766Wvx8U3jrY94dDZJhn//OmY2GukanVitqm7sdb4t4gzsvLHXoQYSTchtUmpMoH5Sx1RnZLHETu7LNPED6whbRTc/9VAguzPQDuRkPABfVm0MkiM1RTdJ0TfxfGJqgnqkGBeIGVWXEbof7DWjbLMtI8kAFxXFJniQ335Lazve5/gTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBNil5mVh8o/cmRpq0YDQva/oklpR9szRA6gragfhOo=;
 b=IFmuVcOBb2Bt1NykodnDuaHcaUMTVsqOlyFWGzB45wsBwcIsknqJhsDj/K+RmEAIx+/epG+7KOXOg6ZL8EX73fGEpm9NzrVfWM/fBPQhSx0FRQe6OeVjexxmk5hIBpUODxkofzQhL+S80h2+ZPs5E/oYB84qQIFZKzYl9W4kO7oLbFrCYr3D84L2vATI087Obb1BPeCmPDxMu01DlAaJE4OQI/i759C2xeBO8fYjNN76vZd0y5Y5mvZJ43gh9dX4f5xd1mOimPRZddwsPOQ2mswJHykF+dZ+Q55AVdcRGTKaPBe0+hm/E9+/VsEXx+YMT8EYGD3/ffULQmr2SfQ+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBNil5mVh8o/cmRpq0YDQva/oklpR9szRA6gragfhOo=;
 b=MtbS5jVAKpDEEk4Y8TbDjwb2DUnOjAeqqN/SpQhDtGfwUXRN5kNhLyYoHpJYhO4OhL5sUpHAoQMb5TkLI4HQWKtyzKqNVScttLVfW6Mihl72eY5EyT7OvofX3mLmJNjpVmmVcFKmw2JZSxhgTC3nZl0Gn+IGy1INA/qqSQCv2RlRs0f3gBz7yaiFjUymDbNxWiEkoxhpzvusgTelFNX+F7NdDVYj4Wid82O0nefiRCYlyWiGk+YTrboWAOdbqzmogJ8NtD46b7eURWqC8y87ZUsrCsWp25ZjzYNlM/B2LD2chtWP3jeY7g+3l3KjeEYJY0WbLNL8agVme3ZESD9jgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3430.namprd12.prod.outlook.com (2603:10b6:a03:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 12:43:47 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 12:43:47 +0000
Date:   Mon, 21 Mar 2022 09:43:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Message-ID: <20220321124346.GP11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjhkmDEGwF4EcM8R@myrica>
X-ClientProxiedBy: MN2PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:208:d4::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31829158-9103-452c-435a-08da0b387176
X-MS-TrafficTypeDiagnostic: BYAPR12MB3430:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3430E9D2919DA2615B92459DC2169@BYAPR12MB3430.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkvQhS/bJkqJE1lwqdUXWGguoMJExpwYl8buOQ9UXgeCPDSeTrfXom4vpmfNppPFKDv/GxHKyodXGKXLEN/jUF+dz9GSrHTcSVadPU8Fp1MeTViPyL2CuYJ4N17ZUzuDf6OjMJs7eGQVYrLD2A2n2QXhB7JMz4CEo3HyYTWcA49V6i/Znljk0cP99g8vuJAtGJPQ6lO5g4V3zyGb7u5izcTcfwPGHYN2us+8/PnTVSxnNeoy7gLbsBfN/QwzKWuGkk47IAHCPlpsoPgxMDJGv4/IsaJke7p5xLSWfIpHgxlKJ3MuRvzRu3vZJNwf0AU9H4ILvcJVmW11kQZyRV4VZFucCQ7BE3U4nVnryqzS4bCGxeUgCxkxVgKePciaGSylBVgAKkxZGxNpc0MJi1qYLptlbsp7Mmp3Z1402s+J9fW9EeZIbAQl9JTHD/T/aDZPk0Fv44CZjQUdMO9ukqXlJCdI++YgmZ7KubUr0WvZEaTQInnxTdZtS73fiJrQiwNM4xsBN4pzhgPQzrRh+LKgST4GPP3wzGkyjX+ppNXR/MxzOG9UkxIKzYGaMmGnVocnJjZIJe0Cz0SmlnedQnAcV8XNmqH/vmJOL/qkJvsMZh5nh8c5GpgQSVSh2APOf5s43vaNTzU+9c0cTpNs4MSIlVxBpEa9OEFJcT0ctr2S+aYKQSo5TC2/E2GBMlh3Visy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(86362001)(2906002)(508600001)(8936002)(4744005)(66946007)(4326008)(66476007)(66556008)(8676002)(316002)(6916009)(54906003)(6486002)(6506007)(38100700002)(6512007)(2616005)(26005)(1076003)(186003)(83380400001)(7416002)(5660300002)(36756003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BbauTMU3bJxQFd6iCptuLkKAgDUlKzKgY8ZsV3mzOMsdSwev9aHac+pJefaX?=
 =?us-ascii?Q?g+cPXazp3pODoFU7uWQ0eAyVlJf7AJBG3qTQ7gE0PzASyeWxPvoKv6bgYhHo?=
 =?us-ascii?Q?myMGpvL8mTlxa9R04hE/NMk73JYcIV9cZXMZOThOXsZmD5Fc87TrC+lFO0iq?=
 =?us-ascii?Q?6JbytCJdHTjRKysVCiyBiqAhOguoIKDW9Tkz1IKJElHrC6WEJBTKGqvU+brM?=
 =?us-ascii?Q?RvZXTi1xGvpRGWNZe96KpnZ1V6x8WS22HvmtjgV5IMoQFJf9JqnjULPfM2qs?=
 =?us-ascii?Q?FRh66wxbuRxk+Y9cyIt3sMPVgKzltU2SjkiHhjxUeDrMmqpKuYbmfIJEil0D?=
 =?us-ascii?Q?6ur+iPdGhVeU/av5m6JFgFAa+aJBjU8hpxQL84gYRh8omnSqfc890Uf6Y0GV?=
 =?us-ascii?Q?v5TjAzUL7tp5N0QHBv6RKkNTLhI9rrrK/4ISiMgAkYjeLpHMATFqFTgm3MAL?=
 =?us-ascii?Q?8YLAFuyyqgtJu+s56VhE5560T2qJuph+DFjpcuwPhu+8oFdhwnj5+TmdVtaF?=
 =?us-ascii?Q?/5UJTJpwJjH9O0UpmpeD41rpEWfHittj/3ShgEp/mXetVz1nAy+36h+0imwc?=
 =?us-ascii?Q?pztv7hunCXApYjsxWWuh6ZOOnZGqnefjzMV/Yr/iecfGhyD7dHmlZEKQ5LMD?=
 =?us-ascii?Q?jTWEx7QK4pTlC+sbusSGWnRdiKaPluIcocZRZYsmLXA1n7dplUKEIQgvLRuD?=
 =?us-ascii?Q?aOEqYoXfeki0voODFV1nF+QKwqwr9iO7uIvRVUgu8yk1oXTz41HzpNQVPsmn?=
 =?us-ascii?Q?lN1os0nl0sekZnWm6abO9Id+ycaS7SnBZtEvr77EDT6RxeZIoXTwLzcYUtTR?=
 =?us-ascii?Q?GllMPYMUWX5vlL3dNqia55TbBeuHjBufizH3y2aVL2gWYqPizcekepBGmZQS?=
 =?us-ascii?Q?ZEZae5d1n0iEhbmi99rCBNjixcSpRSlHAcZ2V5MFcMy5Y53SbaiNzzUq0rXt?=
 =?us-ascii?Q?UY4lRzWhxVPMDOhs+g5xQ5CKDImBZDyIXRn/Nfdq5FMGDH+dBhT/vu/9xZyK?=
 =?us-ascii?Q?quGQAJSC3KVn6fmCBPHuuvRD6Rh71CEi9+RMeBhk/DasU4kxIhguskGtIFDf?=
 =?us-ascii?Q?agpk2+a4uNs+VVJvSzJnJwO06T0/Kpgm94WhXdbWpXbuZLfjsDNcJLWpluMW?=
 =?us-ascii?Q?L8asvBVfHX5G4+8ifVRTw74uzKUmwQYKFpcAtubR40Dnjb/fkH+jdaknC1mN?=
 =?us-ascii?Q?WBTCIk6DIRnYZxdrNhiQlegz6OPerM57E5G0kYpmsQ+ohNli5+ZoiT4qF50H?=
 =?us-ascii?Q?USCWVn8jVL5M+0Z8dpStW1cvY6/E4J041IgTf/heo2+0a3GGTNwNXGIRNWlu?=
 =?us-ascii?Q?wN1gsstaBWVBG9UkJEkicjZsA2C6OCw0KxkTzY+/VfnBIRTxVmvGA1d/6oPg?=
 =?us-ascii?Q?mUG/5rufWVTyQ1hOygtRPdJsbVJO2aDwW7vR2Ocygtw+N3MCbKfhEZQaiggq?=
 =?us-ascii?Q?Nt1imsCyRV8IQytfCAlaSR2Ui1nrihVm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31829158-9103-452c-435a-08da0b387176
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:43:47.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfuWImIcTVdU3CB52SVn67Qc1GROdygrhCfxE0E6ouCzlPHqUPLwyphDd/SHfEDU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 11:42:16AM +0000, Jean-Philippe Brucker wrote:

> I tend to disagree with that last part. The fault is caused by a specific
> device accessing shared page tables. We should keep that device
> information throughout the fault handling, so that we can report it to the
> driver when things go wrong. 

SVA faults should never be reported to drivers??

> A process can have multiple threads bound to different devices, they
> share the same mm so if the driver wanted to signal a misbehaving
> thread, similarly to a SEGV on the CPU side, it would need the
> device information to precisely report it to userspace.

I'm not sure I understand this - we can't match DMAs to executing
CPUs. On fault we fail the DMA and let the process keep running or
SIGSEGV the whole thread group.

Jason
