Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D747E471ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 00:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhLLXef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 18:34:35 -0500
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:25025
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229579AbhLLXee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:34:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIVQkiHGhwTzCGqmw6NDN02BbP1tdOo8ccsuZmM6n78S+ZBu54uSpPzNTRrwarOKXkfXmDk/BtW+ODGdPL0molGsrwl6dHEHcMTnOftE79CeCgkLvkYBCAMVVEy7qGxzWc4fdC0xFFPxzdkNSI4x4Nw49hAczpWzBDcE9YG41sthx99Lnq3EavTNxVdLxWU0p2O1yvxHmhChkjpsfM0N97Gib8Scea90fAt+eKvXcsljms3SPr09JZNbPjQL2vm/jwf9cL6iwQL4Dlgm76jUt4sqG1Kfo/UWxC1zbgQoeBdvhi87tSZ5XeWhnfRR0GRXBwmOh68ZkEIED/0KKw7p3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSXm3V4EUDq6ippmmJvI2c2rchvv0sU9WxGskmACnd4=;
 b=nBFaqQO5vd32e2K2v6RwKWFysUIzZaUh7yLAKyEtgOc3jRrB+tFEH/mdBVbISZSAGyUjnzeP9AttVrGqph1m9tr+uEoI+ajnzh0Up6flsTLzUkLBYT3JLZsBIvyY4MrZHPmxMWrjwBPBvQGgJXp0gCS28vbxCxMixBf8KIT+RgWljXmCPKGrE+xtMrIcanYbXSaWIXWBc9bH3x2Cm3INIZKGQgzlVbwVQyJ9g4f8VUJgplvAniUkFHJY+yd2D/XeC+DURRT1/oKVsTVf9jqhBINYMU+w0TEVbk2CkOkrI0Pfj9XAKT1Zsb+m7Ha/SXUoPozoTE3M3GM+8PD1OYo+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSXm3V4EUDq6ippmmJvI2c2rchvv0sU9WxGskmACnd4=;
 b=q3+5EBNg2NHYLtHnhDJpAT16w2YKmmaWfIw88PrnIZN/925mi+i3sNsEY7+IODheKOVki2sBxXOud/7SDaE/jiiFc0fllGTpziR4iSHHpnYOKrb76ypzUBsE1r03BdnWZgD48OflJC9EqZLHHt8+oBDqzJoNeVFN06q0HwCSRuKBXBS1iDsxuFvHxJliHdcLNc9uLBvCCGVdk3QN7/XmuG6Ex92SoAT87CoU2/3iA+qQnsMHXDwaynBpTI7X152gHe/sufGL4yaV+cnPkUcvSo90ztSxDp9OmpP6QVVTbZesREiC1XSuW1ywAKkQ0u/PE344sqjMA/QnbBSwbm4Gog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Sun, 12 Dec
 2021 23:34:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.017; Sun, 12 Dec 2021
 23:34:31 +0000
Date:   Sun, 12 Dec 2021 19:34:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Message-ID: <20211212233428.GM6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YbHie/Z4bIXwTInx@myrica>
 <20211209101404.6aefbe1c@jacob-builder>
 <YbMYkKZBktlrB2CR@myrica>
 <20211210123109.GE6385@nvidia.com>
 <20211210100545.373c30d1@jacob-builder>
 <BN9PR11MB5276CDA4303C18369178DECF8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276CDA4303C18369178DECF8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40fe12c8-d9ff-4e4f-4649-08d9bdc7f239
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5157DB83AC9DA7CC2266C042C2739@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMO1+FPw30kAnVj/ge9gwO2D8VBz5AI4VZOklVOfd0EGLsRA4bM8XAiP4Bt12CbOZNkXwmnR4YdwAAfrL5kVjEBXGUyFRFXsqyDdzK9x/+S0/sA099P2mf67/XGso9TN6cQ9ymjqQpzvsISb/d8d/nW6CsTgVax9cj+PaiJOAfqB+0zfccZ+5HQPlZG8dE9RL13TNlIsHoNEK0A04eKou0BdD63BNzKCkH2pw3H2C+jM9TOj2/5YQc3Mzl1ykVSRR5ttY8dqob4SVLz2PHD3PVK3efZKEIS/iWkqXnL1n5ixEQ0gsn9Ahj7ME1UAoLj1EwpEh2bmZnt/ivuPjfW+W4ZuvlMHdF13FnWzuleBbYTceJrBhdtavzQzThe2BuK8ThK69oqqBdylVRszVn6+Qwsg1nQ4sfX+xXh7t35HZPffQPxyw0UyPukNkZpL2czu8hQX/dql8Y5gCkr0VJN9h3YLttt7TuTvjSkkpziSdIFgDnJNXwioAJaU8NCCYMao8bX6ya48MWZl9wm9h/vxxEdbRHnP6OvyFk38de19YDavATX9toX3bcZ4FNujgOdjDDWLxm1W3HFtdL+jDkWZMRNUmBzRgz7iWBmFu8wQcgkJIyRLXK/fiB2E4PthFjaD1DOPiwTBJLNBUS6n/AE4KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(66556008)(186003)(26005)(66946007)(66476007)(6486002)(6916009)(2616005)(4744005)(5660300002)(6666004)(1076003)(33656002)(6512007)(83380400001)(8936002)(54906003)(86362001)(36756003)(8676002)(7416002)(316002)(38100700002)(508600001)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk52bkpsQStpenFCdEliQTRDUkFZL2pKdnhSakR0SngwL0o1V29rdzB4WlZI?=
 =?utf-8?B?UHc1bVlZOVkvUmphT09jbTR6R2gzY1FKT2psRzVRbXBYSDhiclg3UzJMOHQ1?=
 =?utf-8?B?UTZrQmVhRjYrQks1aXlRS3IzZ3paZXVWTnJ4aFIwMlYvZ2FnTDBWc0RSYkdV?=
 =?utf-8?B?c3pyOE9UVExOUWVoQkJycmFJTUtzYXErN0VpaElrU0g1djNNbms0UUEzQkp6?=
 =?utf-8?B?bERlT0xIUlBIN1JmUjhFRllZdXdiYlNKZHFFVjROWHpDUG9iSEF4aHNOMVFw?=
 =?utf-8?B?eWg0NjhiZXdaZjlKYXRXNTl6WmlzY2s3NVdhK3ZmazFIS1ZYQnpxZndoVS9O?=
 =?utf-8?B?VjNQakMvTGYzWEkvUnN0SDY4OFZ0YlVKdnkyLzlJcjlYZWpOK3NxNk5PWHAx?=
 =?utf-8?B?QkV5S1ZPNWU1YWoxemZBQmlxY0llbmVVRkpleVZpWUMrZFJIaDhuK0tOZWtT?=
 =?utf-8?B?ZFZ3VzRpQnJJTFRGeFRmRWdQU292bVlQSCtxRjNLRHZwTzFyNXZTd3NYVUQv?=
 =?utf-8?B?VFltMUNmakg4emFsM1IrQXRkbE8vWnJMNE1lR01Gekxsd1IrRnRZUklFN0U2?=
 =?utf-8?B?MllvOWU4akNFR3FBNFFhdHVmdGdnN3h3aVJJK2hQajB3ZXNobXRzWTlONkRL?=
 =?utf-8?B?N1M5WWVwMDg3bXpFS0lzUnJLYlc0MWRGU21VeGtEaU1LSGpza21JYUNNemxP?=
 =?utf-8?B?dGx2M1NkVGJSNGlZNEQ4SnptVTdsQ3Jpc0hyTmlCcVRsTDJhVSs1aU5yaWhY?=
 =?utf-8?B?bGRCLzhDMnQ5c3JQclpCN281RzZqZ2l0QTl4VkVMUUZQR3NCbG1NMTUyQ0Vt?=
 =?utf-8?B?TTMydUJnK2REQndmRVpreDNGT3FvOTZhSkczZVV4UXV6ZmMxblVtZWhpU2dK?=
 =?utf-8?B?Nzc4bFBaeDh6QXJxTmNBM0hVcGIvZUdRaWdzVUEwWS9tREFCYzEvQUd6R2pS?=
 =?utf-8?B?STVWbEVPTlJnamFhcmNzbDd4dGY5ZXA4ZUlMSXcvaW9XTXNFZ205M3NhUFpj?=
 =?utf-8?B?OW5DblMxK1FRSC91OXkwdC82Wm9ES2NidzhmZm1kNXBQcWs4a1M1TUZRMGlC?=
 =?utf-8?B?RkpiLzVFdkl5ZWJLUVdQdEFYWm5KRmQwZWR2a1NwOHBlOVd0YWQ4amNlT1hF?=
 =?utf-8?B?VHJkNkI3dStTZmUxbnNPRWptVTF4dC8vWEFaTXNzQWdwTVdBVFV4SG9Nc2Fl?=
 =?utf-8?B?SUVOVy9SMHF1K3JQUEJuUjdaNUxWQ2lZbzkrdXJnNnhrSG41cFExOUZNdnFi?=
 =?utf-8?B?aEZjK0xLbjFvVUFWc3NGK3BZMmlZNjZlOTlaMDA4K0hDMkUzRng5OFptcEFk?=
 =?utf-8?B?UlR2bU9GUDh5cUoyNVlZa1M5Rld2V3hCQWladFl4VnVWcUcveDJ5dEpLL2VD?=
 =?utf-8?B?MG5pTk5HTHp5dXVmR2NibFBENTZ4clhCMEZHV1l6U3FRK3VPd3hhaERkdUFa?=
 =?utf-8?B?dEdTTFg2N1JRcEErQTNTUEE4ZHNSYkgvQ1VRaXR0eEtiRTJvQVlnUThCQlRB?=
 =?utf-8?B?eHhXTzMzbzU3VWZGQTAwRlp1TTJWREhYcVc0V2loYzdTL05yS0xDc212MzZh?=
 =?utf-8?B?bnhQNmxEcFN3czRhSmJTVVFWdzRkVk4zeXZmOEJEY1FqOVNuRWxoU1RUS1h2?=
 =?utf-8?B?MnpNOURyU1dRRklKUUVFdE1nN05hMk52QXBWRENwcWRWVHdyMWtERlBXV3lE?=
 =?utf-8?B?aWFORlljT0JCNitiNlBkUVRXSEpyMnRnbUhFK3N6YUVuOXcxZW5xZ01LcGpo?=
 =?utf-8?B?QmhZWjBFQlFLTUVIUXVFZnFqVzdaT1dQbTc4QTVlVjVDcWxzTzdnR1Z6dU55?=
 =?utf-8?B?OENvNzBxTXZ2Z0pvbGI1VElMQ3NpWEY5Z0haY2ZEdHdyV1lIMGlZRERBTkJE?=
 =?utf-8?B?ME5qRVdneWJWY2djaWV4TnRoa3huQjJkLzJCRkkwMEIveTY3NGdHRzlQZUlH?=
 =?utf-8?B?T0dtMjdYWTJHMnBDTndGMkErRU1hUnVVbTFhNUdVNkhyUEpBQ1Z0UXM4MEpV?=
 =?utf-8?B?QWI1bDcrTThVc05paFMvTjN1UmU0dFhQVytuTjBndUFFWlVMdnh6UStOMDlI?=
 =?utf-8?B?UEt3Z1YyeWFrRmtEVG0yUXFDNnpON1FXSWFRL3F1M295NFBTaEQ3RDFUTmdv?=
 =?utf-8?Q?L6GM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fe12c8-d9ff-4e4f-4649-08d9bdc7f239
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 23:34:31.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p77fnnE5tx/5TZGE2x6PZhCD3L91wI+8AM2P/dAFWtoYZA4Q9aKBVtoEPPeX3vdI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 08:39:12AM +0000, Tian, Kevin wrote:

> Uniqueness is not the main argument of using global PASIDs for
> SWQ, since it can be defined either in per-RID or in global PASID
> space. No SVA architecture can allow two processes to use the
> same PASID to submit work unless they share mm! 😊
> 
> IMO the real reason is that SWQ for user SVA must be accessed 
> via ENQCMD instruction which fetches the PASID from a CPU MSR

This really should have been inside a comment in the struct mm

"pasid is the value used by x86 ENQCMD"

(and if we phrase it that way I wonder why it is in a struct mm not
some process or task related struct, since it has nothing to do with
page tables)

And, IMHO, the IOMMU part of the code should avoid using this
field. IOMMU should be able to create arbitarily many "SVA"
iommu_domains for use by PASID even if they can't be used with
ENQCMD. Such is proper layering.

Jason
