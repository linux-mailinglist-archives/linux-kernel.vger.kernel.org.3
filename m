Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A4526162
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380072AbiEMLuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380073AbiEMLuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:50:40 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513FA1FD1C3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghoEPAxc7AS8jUHz4ceE3MzU/KwSWBwNhEiQrAblj67acESv2RC1+d05wskAYf5xesMNj6z3TqlImREvJAgPXFhU67gkcnGFgnNpFVCTYUS60sIncVCeOcGICjh01TWonpSuWL+z/6Tm9szX2bEclBLi1+j2vL8YDxSLwEtF1LrJFCyClxREs2Icxvz8iqKATpKV3x1c4Vn/8nPmxAGRB06XC8DdT+bctWWQKXAq3m2gYCTA6ABYixpZMWr9uOK339APh6NsuaAfNyPt38TgqLWxuFKwb43K1CrRUmQAmp7MwCfDQ7svZgJeV8zauUNhmiSpUjnE7h9Twn0O9LysVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVIWLwUxml4ojcsu+LMFgtuAD55/JykRq5UD2SzUPF4=;
 b=k8pptYvRtmKrt7qQDy4LbxFyLLARtilUu5xa93iJD5iyYcEZ9Hq92Zy/oYEvmmkBzVH9Wf4acGVsbZ9E4aVpn2XHUxEYwnM04SiPG9g7/1dEoiGlntiBxGTkPfclAV8ff5hBwgKBVliImgVwGH1U0xEEzADFC1d9lH85KAAkjpO6gCWxVR7RDI8hw2u7rrWQql/N7Wde8A2j4nhElt6V3EAZkFEtjzy2GD0D7kTwDzjcH59fVTjHiS5VUdd+jDBLqfsoqQGW5u1hwsYdgi9YS8UwVLfKlcE5cxRyV8wgGl7Tuv6YNMjsk3ZGxl4/a53RYBlFIo/2XOv2JcrbVMQINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVIWLwUxml4ojcsu+LMFgtuAD55/JykRq5UD2SzUPF4=;
 b=tLZuTmaM09PYfqvQMp+b+wEg5piX5CHHQBOWoRa8uDqmubHkpQno1zZ/jVlA5CtycZ9WuTEcmrgY8zuAEnJUmlKw0I0ka7d1Ue/KEddNf2mVtcZECGlFLtR943TrRELar2PTWC/sRShFHZdyrloP4jYWt5WO7haMjyPxInOyJpO2A+xwODXSuWvxAK6flxNRj8ZYoYWWv9SZWL714L188tucF49Ua30O0pdWbBkDdrgy2jHTEceXtMH7CSj+239Cq88hD5/gWFJZWZWccKaoUgcGa16n4YcY3ED/I9IPSoEihl6GbcJYzE/IBKmVk5q+9xpElYCao6p12GSxkXb/Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 11:50:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Fri, 13 May 2022
 11:50:34 +0000
Date:   Fri, 13 May 2022 08:50:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Try info->iommu in device_to_iommu()
Message-ID: <20220513115032.GM1343366@nvidia.com>
References: <20220513003233.4442-1-nicolinc@nvidia.com>
 <6da2adf4-6717-b562-5ee3-7e28447aa65b@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da2adf4-6717-b562-5ee3-7e28447aa65b@linux.intel.com>
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5933c9f4-6994-49cd-475a-08da34d6c9e5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5112308DCA58336F1ACE6D89C2CA9@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UyjT7k5IVFHz2CUDy13PfVd/nPYYYrSZ5DVffGWw2ettKJH9uVGe6gs5wXAtTCtenuN0JDoBqktVRm4zjQ33wsKmPlVcbuUqsCGZf+pN9cX18keCuRf/rPgtW0TbMLhsAA8d3RihWk1a3FjAHIIuipGvQekc+fvcZMYHNyCTP1oP/Fa/dtbvFYh6bbJp8pmdr7z3KQZPYo80+j44mSLgoDWYZ8i+q3bbpadlgzdQk8vyKTGAi8TgkOe/8NUzWHoWHL0i4ZrFPLynX7e5/UkgFEZWt+70oOaa99Ebh7i/SWstzSSqw2dYT3cYs4qm3CIxERvx0zNQVzUeLdk9UnKkYacs/9r40I1h91vlywGHDAsSSc7rozBa/mYOvvCkUhn0sN0LKL9Tz5jYXhZQ4m24Yh9RpQ2SmGFZ3P33+mXpIZ8xHFsO5ySvRjas2IUJuyKt0iCDxyuEJRqV80blDzIZARIoraCEZJCdSq2CAZueQT7c6P1rJI2pElGfXbLxybP3I3fg/GuZRL5eWZWnJucdYzKQcClBUAgDxv7BzEGrFs/TdO5l34dDVg9e4s8DyNIp3V28x+yw7H+prQsbJxqm3R84KfuZzwmwWnF8cSCgYpGPCQA4fbN/g14sEGt8e+9FhPvgZqi/djjavDGrhzCzKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(66946007)(53546011)(36756003)(8936002)(38100700002)(316002)(86362001)(186003)(1076003)(4326008)(66476007)(2906002)(2616005)(5660300002)(66556008)(33656002)(508600001)(6506007)(6512007)(6486002)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mzPVEpopD+SEItTKWNAVMFjBHevmaZ+4scnADk47MitJLNZVSvytpdwfiYkZ?=
 =?us-ascii?Q?z9wKOZW+WavXjcSxgnqRPIEnXY7S0cK84ovLHN0mGv1lUQHvIXQzdBXgOixj?=
 =?us-ascii?Q?hmi+Y4OneVfxfAW+ZfvBPE2WPllI1xZxTIFUL8ZFZNQ5SxmvEPRvPiguoaps?=
 =?us-ascii?Q?AT6OvNKmDnG8fPcQUTwGG0/ED/R66fT90IeBcya5sOF3JbTli3mYV+gW2SEb?=
 =?us-ascii?Q?6XXdq8K3+7JpiaDh3vMPLCNeLpBkLCnXEGUuiJxGtweh20l3OqRbiCH/mktP?=
 =?us-ascii?Q?RUqdg5p9YgR9W4pISPENeqGFJpwslXcfEqohL3OBmTxMtbgbJfMefJJ/cnh+?=
 =?us-ascii?Q?DHSc7MrZXb6/RvHLmRvIhExiIMpvs5g41ySvuBpS5/8d4pEmYPluKgZT4zcD?=
 =?us-ascii?Q?+6iYtFSH172qgJKDqJFNDhdr39XXH9l/ve7agSeq4XIc5S52e+azIDt/IrWn?=
 =?us-ascii?Q?zgmo9bdDXLuv2wTreINseFvZxFl7NSPy5HqQbYCVSfXOKQcFBmxmEEVUqL3Y?=
 =?us-ascii?Q?JKr8WgffkkCmUKCxZNu99LYjMJ2Uj9haFuy3I5EZZ2Saq1iEofgrXAEse4K3?=
 =?us-ascii?Q?11iC8b6d0/Rv6h0mCYdAbGhHuni5nkP3oXzej2n44OgV8jcNjbIb2PDz/8IQ?=
 =?us-ascii?Q?zSH+CMYMEWI/G+bbfmqKUKfeh5IGYC3Kg/ku/D9wMgn64ITQLxAtqulNkmqL?=
 =?us-ascii?Q?zm58Uf/8/+C/gGi53KEUHTgMFsXve3gJTPzoQHFEIHbHwJtMeB64mr5QGACb?=
 =?us-ascii?Q?u6tOPx7FsExqNj//TW9Aeq50OT5/13ZLhFLFi1qTVC709ynJrPZKISil+aWb?=
 =?us-ascii?Q?1HnhlQjWVk0n76iauDjOWhD6+Z4J3qPF055IoQPCpLGxB6UUPegKaDQ0Uzi8?=
 =?us-ascii?Q?UvC8BgoR+XUDm9+w59I1TGuYD1B2gbtE3YtEkuV//CzVSTkDdMYY1S9komw5?=
 =?us-ascii?Q?tf1oR9CRjSsAU66U5MXhhEBjAupAKHJX3OiQykIBJ0ahe9nGbKubNe+O71rO?=
 =?us-ascii?Q?I4V013ac2WljHXRfmBih3HLK+WlQD0clz0vmyDJDevd5fsvN7JyY+Cx63Czo?=
 =?us-ascii?Q?IBm1jlMwuYWNsysrZDHKEvRznz7t9DVf8RXtRdlPVJ/i+VYoGVNgeBd/BqYR?=
 =?us-ascii?Q?FyNU26eXJk5LWzQcCq5c/ic/WibNsX2y6sMDhJ97V7BKz6gxLTAOoTv4gT7q?=
 =?us-ascii?Q?0SM/zll6ykYpZmHeUPI2MOQ6Fwlczt/nibPtZb3JJdKCkv27mMJS0XBoL5UR?=
 =?us-ascii?Q?SzE1kz2BhZar2Cino/w9/x659w7W3+FQhNNGXExjGrSQN+QNYw6W2bs/wqKE?=
 =?us-ascii?Q?DsbRL2BEC0OnAb5EGBMO1whtCRFvlI6kiw9aanLcNSp/g6y4artr4UA8ghNR?=
 =?us-ascii?Q?E3fijEc2FueqX5qEJvly65zcbObLq4xOsP/4kZjoSK8uWqkBYnoB3qA98UNG?=
 =?us-ascii?Q?TF3vyA3Qcgisvlx5cASdbTxWaf/KGFyVrtKc1vyxohpWmpwshB8Nn6B0L04R?=
 =?us-ascii?Q?DXgy84NiyeW9RZboMaJXRbNaaNHYcn30CVEJVzkWhtXQeH7dNHH61sEjwzNn?=
 =?us-ascii?Q?h69FTntVBWjNxqKw1c5wzeXwKm2kUDFlDtrDkCWj1oKRHbs/BV1tyuPdmDmq?=
 =?us-ascii?Q?vwJNAn0CPWQsOrAmIrJavLB0v8y70lxkXUhtrXJgoW1rusfOHcnZWdKZvG1O?=
 =?us-ascii?Q?MQr0pVOLD8sdy8lSoW+FEI/8UtLISkG7zDKYxBuWxEknPl3d7tPiyG71FuXd?=
 =?us-ascii?Q?X1q9PqWQ3w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5933c9f4-6994-49cd-475a-08da34d6c9e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 11:50:34.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqyVPjqLtP89djGfXnDzL4RGx8TgfskP57JjFmay+c3AJG8pjAJjn/9G6y33UjFm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 11:32:11AM +0800, Baolu Lu wrote:
> On 2022/5/13 08:32, Nicolin Chen wrote:
> > Local boot test and VFIO sanity test show that info->iommu can be
> > used in device_to_iommu() as a fast path. So this patch adds it.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> >   drivers/iommu/intel/iommu.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 2990f80c5e08..412fca5ab9cd 100644
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -777,6 +777,7 @@ static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
> >   struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
> >   {
> >   	struct dmar_drhd_unit *drhd = NULL;
> > +	struct device_domain_info *info;
> >   	struct pci_dev *pdev = NULL;
> >   	struct intel_iommu *iommu;
> >   	struct device *tmp;
> > @@ -786,6 +787,10 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
> >   	if (!dev)
> >   		return NULL;
> > +	info = dev_iommu_priv_get(dev);
> > +	if (info)
> > +		return info->iommu;
> 
> device_to_iommu() also returns device source id (@bus, @devfn).

Those are in the info too..

> Perhaps, we can make device_to_iommu() only for probe_device() where the
> per-device info data is not initialized yet. After probe_device(), iommu
> and sid are retrieved through other helpers by looking up the device
> info directly?

This design makes the most sense to me... Nicolin you said there was a
case where attach was happening before probe though??

Jasno
