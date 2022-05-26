Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48FC53483C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245169AbiEZBkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiEZBkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:40:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2490A9E9C9;
        Wed, 25 May 2022 18:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkomaV7CbOhAcjainTvxliPpZSHFQp4OpXLIOE9bZnLK9pt7a8AHDv+2wmdcPHzj90CtKGMmnIxtIgjSdp+/YWt2+PKK/BIm1c7IKgCWJXkHFWylbPeSmNSc261oS4w5hdhz8hnQkONv49aS0qG4911SFMTeGqZ5pOELp7/Sxf4aPa/HOTfK+/K7pP4lXdWph83Um11kpDr5MiVBrJ9GEgusv2t9svt+o3W5Y1NXu52fAuq+DxTEI9t23veR0/XXIMoD57tH50kl86DTTUClmpDoplL0+5S8Bjph8OBt2kxFKj55FzqDL/2m17tcwgTgd/mBCgOuvcB5VWbvhrgCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsOmawRqNbcPIBFzTVggIjeM2cLvhIgOZYMdfCRxcrg=;
 b=LxUUkXjeTXEE1NwGEN1vyjuUrZnCVBFL0KvEuJmy7CidGcTkA2EaCttfqa/e84ooIdN7QkHu99UhHcm0TEjaPfOaSKIis2mYsNJ6/NWFUbI8QR820mPRR/a6OLOrfT1ULg+XnJfg9yomA+bIWe7F0ELhEo2RPzP02s0XKL64H3eYzDrif6eAHg4IaYEULi4gsHEGQjumEZPkrnvXrABbTh9FkUTXhxYLVIHpM0PY0r1ZlwUQ7dtvXQfctH5prmllVAKqWxicJJTr9NLSnzcrlUdUQe78FKtHvPGGC0DUugAcaZ7DAApBR+y4M7cHIznkrKHazX3dCLL4kzcUGVKwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsOmawRqNbcPIBFzTVggIjeM2cLvhIgOZYMdfCRxcrg=;
 b=UWyh4QRxNNKIOKh7s9peha4cwLW6YOswLbNv44/tVCUr+dsrjNP2kW1qaqxKKPJ1/KQ1hl+P3i8ITqN++lwxQufx3A4oq6VYfMkfxTfeOKQw5LvRFBJqAHDktzcg48KM4DiEJtf8QsZXeOZu/q2Crd8BJ3hruSMcX0RRqt2fftyBGB6gN4F47u70RwTyTnwnQ7IK5eXYM5eWEmfNjYJwrJ7gmiKsemGrBEQpMSjfdJFgzIyr9QPNdtc/PQOeYJmUdvYiOuQAMAC4vvh2yRi0Arflv0TN4YQbS3DLRYMsNJ0e3aXfPdhbyU7sUBEnEZAr8qdlEHPu5SHru94rvwA8Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 01:40:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 01:40:03 +0000
Date:   Wed, 25 May 2022 22:40:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "yuji2.ishikawa@toshiba.co.jp" <yuji2.ishikawa@toshiba.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Message-ID: <20220526014000.GJ1343366@nvidia.com>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <63369db0-cf7f-aa53-bf9f-de2b0b2289ac@linux.intel.com>
 <20220525182644.GF1343366@nvidia.com>
 <BN9PR11MB52769A5FE5B8291F7D47D5AE8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769A5FE5B8291F7D47D5AE8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c3aeb99-e00b-44d0-cc1f-08da3eb8a786
X-MS-TrafficTypeDiagnostic: BL1PR12MB5256:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52566E8657A0F2D386EF436BC2D99@BL1PR12MB5256.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hK9j97MoFANU1dtsTS5FXzxR4WaicMOSnxEzOtEPZ7adFRxvRzsl9FeimleXAvnWaewJuVin8yKf6xmtfiXSyf4p6XUsV2pujRiR78vCgaUYOFbuf7G/F6Kwz8H8o6gT0FpNUK9+EpbOPu+rsDpGoi/KAFqZi6xbBPfl/4RZUt6OMrkF/sW13D0+NRlQtOW2Mgz7Z0ajVUjl19fl5X/WI/XeZJMIMuuPwjgKjoepw9M3JnIN1tg4lQBHdJ1A2vbiHc+frRx3obXBXpan7TCsnjpTAE8rC58OOwU0cLb0OTcByMBhnGJRPfSSxlf7O7C4zygj/BKEXSD0gT2ActCIZmbgvxGMZuLvAs29T3qppQEoHJOIh/OswU77TPenE2MMa7sIc+BX+xLZlN00tBN0Rf0SGFIHIlODn9B6vMWbL/9IWSjDWRC5hj6X1qOIcH+ztRy9sCPX2nDNNgFe005vhtAgNTFDUuo/MjxndfBe+GcaqW5e4DkV7bE16Di9oyzTTUz/l5d/bh3utFGVoWS8YSDiJIW/aufm6C0+WymuJURxg+VB/ZAHuXIqBYkBF/83OJyqM5b8BFCnC5O5tbFsdvV++5n1KjWLuQiz4De0CukUZwVh0MsH5sXtfjY1ftIdQ2Fve1DYZzEZHdM65IMH7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(83380400001)(5660300002)(316002)(6916009)(54906003)(66946007)(66556008)(66476007)(86362001)(36756003)(6486002)(4744005)(508600001)(2616005)(1076003)(7416002)(38100700002)(8936002)(26005)(6506007)(6512007)(33656002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+E8tFhFCbzlwRbTy2MpfvfQTeE+0glU61/n66lmRkMQw4uqdySmBO2gTTIk/?=
 =?us-ascii?Q?hEoAapKX2TJgtuyhv2KFFsXTS3jx0xZKnpb+W1fGCzym32KjgeIThR3GbDwP?=
 =?us-ascii?Q?DwjU4zeiaoDk90cLk2fTTwv1U3PO2FdgXN45eSAorhOBHQVLDgz/gsERLgrw?=
 =?us-ascii?Q?UKom7/zQAMsLTnkU+Lqcbz0Bhd3PwvnTFnB03/EYVJIkkaZ6o8F0AqBov3as?=
 =?us-ascii?Q?uiPXgOZRnDjvD2s9QMuq00uTwQXLT+lV6Vi6mw847tqYgqRwjfz8+WPAgNVX?=
 =?us-ascii?Q?ITYANTqoY6jvb6jzPKCnWnQs0pJXsO7/3RoG6g9Yt3giLLy8D37maFreCsAF?=
 =?us-ascii?Q?A7ld/VcOq1SDeEoY6ElO0X3pZFdM9bfELW1v7TG7SHU5V6COvEpDd3rYgtD9?=
 =?us-ascii?Q?1KhsV94qKfE2zKqwd1o6fwa+0zW/la8gx5TltFUh7KElMBRvwhHd85e4/84S?=
 =?us-ascii?Q?QZmYbjOIQ3yMnEgPegZNP3z8X9LkjoLOcxO5JUeMOlCyJR+5wT5wjx76WCXa?=
 =?us-ascii?Q?v3zwN4KREMIGJgk0bt28J9WHfEyX6mRIAUm3TjNxRjcfFZCdQu6hAbr+tJ6W?=
 =?us-ascii?Q?QR+c3SMuNamai6THVNBXlBKrBQCL+qiHqGpjQllCjfjRNiR+fNM819fKB5te?=
 =?us-ascii?Q?1wmAZX+A03Tw7/s20f4Q1zqZOtXv7w/LZMlaV0vZpeP5adxIJYB/o65pBZ/S?=
 =?us-ascii?Q?ZGGTMyPvg7Y8P5afoTngf8pw96tljvpwxHriMbr8tW9p9nwZRnwCgS26f+bX?=
 =?us-ascii?Q?A5F1/Tz8lVWpwPWkuzD5VGndkPwVg64yF1OjdK9Dia9TFfgRhpGCqtKgFLhx?=
 =?us-ascii?Q?dpa5bNKUxOG42aa2PIrrg2qHmFG6OHCZQxVkWiWujY5SOPRJqL7tbsGsvXMU?=
 =?us-ascii?Q?6BQjAEDu90Y2QUBzQ8JAS73SGlomlCLc9hkwEHLE6p7TS5fun4H1Px+CoHnu?=
 =?us-ascii?Q?2fn+O+DzXf/8FAydsuuQABKA36ragxL1H547v5eFvSLP4EDuEawL/M5sRAn1?=
 =?us-ascii?Q?m5d+uh0uPNYpobJEhY9X3Fbv3g2gn5fJIFrdCkQ7cMNMGuUv1Irt6YEq6fBz?=
 =?us-ascii?Q?wM5lbXAkCBE/cVFBIJhngt3dllKDq+1/dyluD2iQL7+CfntSSmix5kGfztO/?=
 =?us-ascii?Q?H1JkO/da5SL5J2Q9roQZ3mrUasv/L7drAbBp+WPNh/F5qAcBgEzkJfUjJ1nk?=
 =?us-ascii?Q?4E9f29rqWji4ZXnhopMuixzKNKkW7fBEu0BLRiHJem6d1OqoxchE4LPwlDvO?=
 =?us-ascii?Q?pBtjOSVzL/JprWEr2hLiKZKNMFC6hLSNAV17+oRIrnQKgUg1gC/wTT0QGXdB?=
 =?us-ascii?Q?Pjr9cPJaVYOthfm5w7NWFV2oYIztl6YwliEmurrtlxr1Ftz65hPQRW3d8wG5?=
 =?us-ascii?Q?LANEYTW+CuL2/E76NlcDWWH7mKsDInLfTd/i4mLrd9IYaLvAY4k4j127qZ0y?=
 =?us-ascii?Q?RmfespkqjRGAUHBI4g8ysWzVbpoZLu4+DeXWNal2sbrDkY7OiGcLQ16U5ZcH?=
 =?us-ascii?Q?01zkSTQ4QELc5gMoDFR3ECiU/Fu6JdPTQQoibGs33DeW+9jdEM8Y2jQg4QQx?=
 =?us-ascii?Q?Ci0vP2Ajqhh0QLiRWCuwWjSiutDmnozhI8nnuJSL4xjCpymswTg9EGx4ibQl?=
 =?us-ascii?Q?W3/DgEh7EHUBFvm0UIUChjfmBh4sOPbDOu2HLfVZaQrDzR6KrT7nwn0LAStg?=
 =?us-ascii?Q?ey0P3FKnTd8Luv7YII+XVD+H40QRBV0LZM/60pIQhOH01yw40NzaojByGULt?=
 =?us-ascii?Q?t+dUHGWOQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3aeb99-e00b-44d0-cc1f-08da3eb8a786
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 01:40:03.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64kup6Msg0HoQRhp3WyGVgiOgGgbAZnMfjqMvxxNmM6WzJN1NhlzuCzDEKx7DIMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 12:43:25AM +0000, Tian, Kevin wrote:

> iiuc then this suggests there should be only one iommu group per atu,
> instead of using generic_device_group() to create one group per
> device.

Sounds like it

> > rejected then this driver should have a IOMMU_DOMAIN_BLOCKING and
> > return that from ops->def_domain_type().
> 
> BLOCKING should not be used as a default domain type for DMA API
> which needs either a DMA or IDENTITY type.

New drivers should not have a NULL group->default_domain. 

IMHO this driver does not support the DMA API so the default_domain
should be assigned to blocking and the DMA API disabled. We might need
some core changes to accommodate this.

The alternative would be to implement the identity domain, assuming
the ATU thing can store that kind of translation.

Jason
