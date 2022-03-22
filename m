Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A874E3E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiCVMRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiCVMQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:16:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53EF75212
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3UXT5aW3jITjUtJrwEktGdfKeh8Udy9mF4yaMacGU0vj/TsGanjyf7Q3MfJ/U+X/TETwSBhovI41o8I+B/31DBQhssf4yfWptN6EPRMhhn19JbxdY7s+t4Bz6HdYiQpNKtauBWPs9AmCkuOSYmP46Lnkx2/4DfHBcYSqNs/u9TTZ8kyk/Zom4XULwwJB0rSOHFeZxH2VBHUSePfWcmrlf14SEihSgRUv5Duh6AyKw/Ufs0/LBPRLHvHj3gR9q+X7lF+x1/dYpWu5paQcLsqVtlpRwKs6SaHdwsMFY7isxwUro+0vh7pfGmjUMWv2maJorQ9eqXOYTiE1bwaJWpj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/sICpqMA2qREnwegtdbMpQ4pqTJRjQiPrcVvjVTI5Q=;
 b=a36efj8E7vgXeDgDcONVycTUOgXS+u9UhPPW1YtNYETxGSLMFg2vx55R3sj8ZeH4ypRkoYVE2rVO8Rcdl/N0h6eQnJgOto7YNEIqIrjM07uaPofA3ukv4RWIkvC6SCIsjoeWycqHJjU0THnRO9cQFgElRkB+72HyMheF52FLd8F+Y7PSPo744ROzN86GjGtl9KJEi1f0VNlkSew3eStfhZAxG5irhJ3qek82OeYnocgd0WKbU/M1iYyWpIWzPgl0scjhXjF9KB8kkprXruPLwmoaXOKKzreEZyEVMUBLlzlyHEL5ADVQAF2mv2nCs2JJtNU0GSdQYocMDdx4lvLRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/sICpqMA2qREnwegtdbMpQ4pqTJRjQiPrcVvjVTI5Q=;
 b=bQ8VocR/9wanL7MPrrFwSy8SBDTfmzjjrdTC8DiMmDtCzVPzYkPC5rRNQv/wU18gCNhkCNDHd1l68iJt81+ZIp5iCfFcgBmkD1m38ewXUEkkUZrby7n9VIJTyHHJ38+QUFB2PlW74/EZ1RAJbK5v8vUyzBSJ7+n5Vfw1bwSbb9idFHJhOZFquQ6OiDWJx0aVi3gPeYxz83f5eqKXYhk2Jirx5i/m92zQMRU05OzBvmVG+qO8uW46WH9Px3y1py6jcHeqMytpvdxcJb3Kx9dcWusF5B9g+3qMT3bwUEvW5p0OmYm/SMRy7DNOIgVmxeGGGCNJOVQF1PrE5P9DKQkijw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW2PR12MB2393.namprd12.prod.outlook.com (2603:10b6:907:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 12:15:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 12:15:21 +0000
Date:   Tue, 22 Mar 2022 09:15:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <20220322121520.GB11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica>
 <20220321124346.GP11336@nvidia.com>
 <64fa931b-ea2d-f425-5baa-654216bac779@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64fa931b-ea2d-f425-5baa-654216bac779@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:208:e8::42) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a770cedc-b401-4519-f5bb-08da0bfda2eb
X-MS-TrafficTypeDiagnostic: MW2PR12MB2393:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB239373FC12592104DFBB4E3DC2179@MW2PR12MB2393.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kz3wPfPVZjrwnbovWe1vPE1Hvd6oTgmJ+SX3dFQQygP1OUVsuOAsB1fv80uNpbrLRAXea9RDHC7qAtGo2768ecGnOTgU9m9Wlzi415Kw81Fnk/0YLyNwHbTI0D2kjk1Y8mGSDEjy9sdr5BFW2IQY+9VwWTBxvQqOUYFrUazP31GFihOvB8Pa4f/TjHF7e4NEEHikRqnYQPdV02CJ7v492M/IcH7oMkkJTrn5X80HjImyggsipPAFRioi24uGRKg+BgLpZ7ppUP/raqvcC7nAQC+Vhh47a3ShJ6RV0AUaxFKhpN7i7eYof1cAFLMfa4R0Vy/8T642ocTtxYiDBbLrH/+fBqwOrDsG/WQKZcBzk/E/bNjL6tZ0dT4/OvMSR6Z9gBCSkKQbm2Q7xfGRuVPcy/Cu+CgV5XPHNNtm1DkuArBARcQGtGPH5a2GHMKpznYMyRCZMToOHuVACJW/P+CRHoWsAM53Yj+OklPhfegUkhAUjcgnpmBXI+UWxYiB0Gpy3wNWjw7sp4ib2X0OxyZrrmdmbm0anHRiksF4SLlmOTxVLWFw3F5vy/YEwCKfXu9YT4txM/9LzCWy+3Vb59arShJI4zmfgsA4LTlV04gTHohiqDhr52LW6flhJFrJX9zM+v6zReQIl5XIpJQtT3WsTkxwrIf3CFzHYJfFhWvMeb6WuYGqHhz1k7Id+C/lpwjh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6512007)(8936002)(66556008)(66476007)(508600001)(86362001)(4326008)(6506007)(8676002)(66946007)(33656002)(53546011)(38100700002)(36756003)(186003)(2616005)(6916009)(1076003)(26005)(83380400001)(54906003)(316002)(5660300002)(2906002)(7416002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OyvP5SaPyxBapWwc4lw1TY63szSLIsQD3zMWeeP62KsS8sXPM9CytXvv/ecL?=
 =?us-ascii?Q?el1phWXk7i+aRnVGmc627SMVdN+7G8H8HFoJNIOUd1+BNJfwX0EuxL4IgVVn?=
 =?us-ascii?Q?d5TdA+SezjiNDgzVfvllDRcFnHFv4X/3b9A7F/s+0Z4OTiIojBswPMHsk9fi?=
 =?us-ascii?Q?aJRAcQEUSbmULiayyZUQ7ARUlPjJZ1ik402jL1ZB+VOzFYIKTncHWiTBTiyu?=
 =?us-ascii?Q?aXYyNpmGqSQ+NTSuEqMAKAGBIebdsZ9jYVw1rGTZXq39jQmg4Dyc9LgffhDk?=
 =?us-ascii?Q?J8+k/FYRPvsH9NF+Mr2ZCEnq38M5ocoCjU2+DQGBL6Lx+p7CQww6hY3Mgm0p?=
 =?us-ascii?Q?Vc78ty229t07Xv8UOtJNE0I+W7veo4UuFEmuTZ7Jk6JidY56r0QZ/ieWr6IY?=
 =?us-ascii?Q?dZLygAqJX4IFN8G2dmApXOPzlU1zqd2bT/YHURZ6FvNJxZM7Xv4RvkGd+aD7?=
 =?us-ascii?Q?5rqlzZwx4qqYbsQvpnVJvuMb4qsASGaKYuinwUdXvhy6UiIYMofdWEtLfkrA?=
 =?us-ascii?Q?7ZCQiFtmWEsqKn4vlIr5rNz5kATxnkgPg3Mk0sZLgZVk+oY97idbpUktKDKU?=
 =?us-ascii?Q?1fHy4jr56ElKVR7gLjtGDJL2A1uoNmDWmWR7PQBAGQ6Uppw1IXfc71+9tLtY?=
 =?us-ascii?Q?FCcEPiCRLzS9cTgNzvmduHp+eNsoGwzANQdL4eDtrtGVJ3YtVi7yHl3geppK?=
 =?us-ascii?Q?ru4wkM9ZEPz3Mx0jl/uDMF/re9SLiyyoM7tIh+gAF7wxayChLa8RJ3HOhbhX?=
 =?us-ascii?Q?ggoHmUnTeiQArLT5DTX0WaROmIeE8X61MDN48022sdPj4I3jJytvlztes2xl?=
 =?us-ascii?Q?JM2Af9CEoQE2VbHcuDxVLA7iTGzVCrziC2IRJwA/bTWdb1+jFlbHd4A544rp?=
 =?us-ascii?Q?jiD77bFuMfEh29JMYQV9+FzqNfREvGucZ7aaxzWNpwt0gc2v8BK9g5ay9WdU?=
 =?us-ascii?Q?uboUQurwebDn+zWbhM3clRYbgS418MRIEFGm9Z4I9KWXKHWGcNEqS36g1q8o?=
 =?us-ascii?Q?f+mHWxye9uMc95YdTl+mmRP87HLsluW31lLnBv+eCzhR2e1fJQz9Wli8wvtB?=
 =?us-ascii?Q?19HlhjNNhF5CF2Tz0XOBQCOoIFYxoHE1QXUtAcfhkkIbz8viKNYYUxSxNUZN?=
 =?us-ascii?Q?i+c2w/4SVA57jtcPPht9t4yx4o4omL6s9E7cOx7hLbkA6JQqvqeIndcuzUkt?=
 =?us-ascii?Q?PUrUmBBK75KdOtD1cG8CLybB4b8pJemieRsVjHIaRO/r+mtNQ6JDLsUz5nZW?=
 =?us-ascii?Q?Fs4+QN1Xq4MtM/61awpJAzGSUKQM6bkzKautT9vxA9fKkuWstpao90o5sYpc?=
 =?us-ascii?Q?SpUkFpwpWvMChNhtx3P3lKKqwiFTSHenaSA2+fILDBiUBdP9hpMHnLJWGoyF?=
 =?us-ascii?Q?EOvy3SN2OkHL6mvaOcUQOADcmPbfsj0Da5gv+Z/yCHZse5tAfZS0dIAbIELM?=
 =?us-ascii?Q?SB/t/QAZvD8V2LMdFbzVhDaGSj9eX6AP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a770cedc-b401-4519-f5bb-08da0bfda2eb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 12:15:21.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NogS9V4zAEikSB6J9W+PPVI1dsv79NlJiKd0OX3g+98Vp3N/fLk+NY8jloP8otmV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2393
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 01:03:14PM +0800, Lu Baolu wrote:
> On 2022/3/21 20:43, Jason Gunthorpe wrote:
> > On Mon, Mar 21, 2022 at 11:42:16AM +0000, Jean-Philippe Brucker wrote:
> > 
> > > I tend to disagree with that last part. The fault is caused by a specific
> > > device accessing shared page tables. We should keep that device
> > > information throughout the fault handling, so that we can report it to the
> > > driver when things go wrong.
> > SVA faults should never be reported to drivers??
> > 
> 
> When things go wrong, the corresponding response code will be responded
> to the device through iommu_page_response(). The hardware should then
> report the failure to the device driver and the device driver will
> handle it in the device-specific way. There's no need to propagate the
> I/O page faults to the device driver in any case. Do I understand it
> right?

Something like that, I would expect fault failure to be similar to
accessing somethiing that is not in the iommu map. An Error TLP like
thing toward the device and whatever normal device-specific error
propagation happens.

SVA shouldn't require any special support in the using driver beyond
turing on PRI/ATS

Jason
