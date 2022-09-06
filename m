Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E45AF051
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiIFQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbiIFQXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:23:51 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770582729
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh6aqHgEa2m0gC68OvWEKf6CLUy10jVN8aMpNawfHOOF4NoBlWRHKYE5OVdBneAfNgOF07w751BazuC61gBcQefgJGFgrWlkimW5qLLY97d8BL1Tc7Sd+N3LnB/VcDJJ8vIAi2vjeZ5j/MSAqE58xG9jBahh2+jI9Mnx9SUB7pXEzPyTRrLNjUyFriR7dA6gx1GTn8bo/S2lzyZs/Zm4wiQLNhJ/YyVtXUM4T7RrzcIDhwt5qdBTGpXjB04UE9kht5HsrhuvGjaTtTAfxo7IZ5uqeE6uSJyepdD4Y2tseZwQJ7MpNfELVMv18wJYNxlCaSRNWQeiOwjB++sdS1f5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tJN8vNg07BjDFs42ZA4tdhVuh6OjUp+5qv04q0uZbE=;
 b=L9UutWIIxqVzyLgq4R5cVLQlBJ2kYdlwK1uRxSA80QIjZCgNQ6KdHkaYR3xGYd0kPx3XslZD5+gNo6xzgeqrCrnkvm5EM2fqcAGOOq+x3SS2JSTjsN78ZXMAC0HBz2vVTb5gQMnU1XQDv6dDEb8/Q55RX2c57gm7LYhnMP/DJI0JPblSirbC7sPXVNnNmhX0IqppPVIvsxkDcesYSjsERmo24/Svt4xrWIWoOlAutkgSNEipSmpWuoZJ4NdsEPfdNIt0aSAxjgqIo5zn+oP8QYlj/+v88a4dqzOTHa12uo5N8q0jH1MwESTBvwFYQv1+NA3YfCjBHk+qOF3pawiatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tJN8vNg07BjDFs42ZA4tdhVuh6OjUp+5qv04q0uZbE=;
 b=gyiGsh5yHodNk9M0E0rGw94ZjHl+OQsWv/E9esi092pxuMAmi1R+qABSVv9FNF2ZOucG3lTzD/8r3H9Xo3cc/0y42DJ7cvm58RrHDzbNgSZbPTHazOpSEj6swC9weHTxOZooEXMuqGLoSoDBsObpy78LNxx9ip2h5/Py0re8JC2HzB9y7QSQsrOtCNjIyhTiexNwuO+DdBgplPtIJm9cPiyB1G/8zEs1A7RCGnxd/8rvSIl9P1MMpUVCXk/53qmhshBR7x3Z9pHfes+iFhRi4Ymt2gTPnFA4KGLtWLTecgGYBY6gyfXvwmI9FiQiwQMe3/Xklfmh74CdgHSqpfNcqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 15:53:45 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 15:53:45 +0000
Date:   Tue, 6 Sep 2022 12:53:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.19.x] AMD HD-audio devices missing on 5.19
Message-ID: <YxdtCMbrDQCc5N42@nvidia.com>
References: <874jy4cqok.wl-tiwai@suse.de>
 <20220823010021.GA5967@nvidia.com>
 <87h723sdde.wl-tiwai@suse.de>
 <87ilmjqj1f.wl-tiwai@suse.de>
 <20220823202824.GA4516@nvidia.com>
 <YxdqP9i0bEwUg4VJ@nvidia.com>
 <87edwofqkd.wl-tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edwofqkd.wl-tiwai@suse.de>
X-ClientProxiedBy: BLAPR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:36e::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14f805b1-75bf-473a-6f01-08da901ffacd
X-MS-TrafficTypeDiagnostic: CO6PR12MB5460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uk2GzdICIxqqP2rZ2kPuK2wncFK86MwpAs+sN/BL4ZC74dFvkz5wIL6bTaprevXGABQ78vTe9ERQaEhylfUJ0ONhokrVUdHmGsmdaxMZB2UqdD9tkli9QXihIZZyaLVE25Kv40rY/1TJbX57s90vLN9VkqFv0Y73aBqcttP86JINH3Gd0KuSan98wCEZN02y0lCbhEWkmufs4NG/Myj8wPmOoF3U8DFamj0wj3eAdX/z9E08NPpavxMGaCEMPOeiULXLZA1vPEqRaKP4FqHnPxRWbDyR3gE4jR7/jsMurtVh91grqmK5ii2nH4CWd2tt8/yKlkVdJHfgqiDpiV4HMkXAMMWqnzlLrNMfrOsUv+eXVtkiUV3KzX2p8Diag24Bjs6sZdz7oS470YW/2IWqqWpsHqGQD2p877ZpMMG6dq38VKr4F3nDRYAaec1Ne1fNuu71QGfi4NDKfOPsdYkPEXVEqjMRyauDujcbXuqPAop2ouE5nBixMFGSgpeczPA2aQswTZQB7dy79GEkp1qB6KRCWgv4zJq9jx9YmAMB3DitooFEIHlKd0eVrDAK0HHdN9bfOvZoar4wULGAilOxoxWzRKcChZMRCyuLTN+qKslM3wozBGtMR3KGf1WTjPB0q2lkMZqicLZCf2Hlv6krwMWgpk6nYRXt0CUkLcKG8TETB14zOfB1ynYJ50ghv3rFBtYX/C+1zN2u+kGy7cy6vFIwPlIhYBiSkgIzux2vHeBY4h0GQAXfhlU6r7lCYCN8SX1XsLGlc9nCDPvkVSNWXan493hX0m35OuUDzAm6UTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(2616005)(186003)(6916009)(316002)(54906003)(41300700001)(38100700002)(6506007)(66476007)(36756003)(6512007)(2906002)(478600001)(5660300002)(966005)(83380400001)(66556008)(66946007)(6486002)(8676002)(26005)(4326008)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IFYeoqHZIA2+2cwxliH4LGFSeWZJGKqly0UXw8IsjpV90WEOpldxd50g5YFl?=
 =?us-ascii?Q?2bt5gN3sxYEQOuGb3ujyqcF/NjsQXyVs3opFdT61Wbhfwt21cjU4icOnSLiZ?=
 =?us-ascii?Q?jheOJ6b0ahxqcxrcqeCNj28SpAJUxGAbrjcqpfLsNZAIUZMn1dWRQIPfuNeC?=
 =?us-ascii?Q?Noheei/B/JelV0kakW0JsSvdsEiHIvXkCp9nfnTvWjVgeR/HgVvcbQlkGF9U?=
 =?us-ascii?Q?JPVAbhrSaaTZj4uHy3Ez5qaheV8p9cfo1rsssqVhm+54qvG/Bmqtchxm8l+n?=
 =?us-ascii?Q?cUTwcEWlgdUOAMybQ3wpjf+tjW/OQYj1ZVo4oSnigHdVC5Ntj2tDlFb4olgk?=
 =?us-ascii?Q?8YYu8lu8qXskRNS0mpE86arof+nc5lwbGWXQ2558ZsHXQtTvk9vQiugjMt/9?=
 =?us-ascii?Q?Isa9AfSTbGI/PzfWdDQ7ibtLpNGO7VIYIRkuRv7B2yQO3Za+ONc4O9qiIxWo?=
 =?us-ascii?Q?wwHrRVfPNgECQ6ESCfRCtx3cCxcD7dwktIo9+1FY2GwgzlLEV4GswfAdmR8L?=
 =?us-ascii?Q?0Hh62SymiegZAfxZMUrp/QKDlxAMaRlJUMQVB+Vuf9s5JkWUPYzIkhFRdvkY?=
 =?us-ascii?Q?adTe7WD0Se4HDausnNEWtw9yLtFpJ96R4mEn00F6iU3rTQMRaR1a6z1J0vbK?=
 =?us-ascii?Q?aDlcRKAqjAl17ubnsYhheitu4F7DgJovqoOGIZqj4qJPGDtutRUKj+TJo6+Q?=
 =?us-ascii?Q?8h24GjteqnMeB0x0MlM79mdw7HLQ1Mq5cOJ3f5fI+e7Y22am4YOLQG6H0FtV?=
 =?us-ascii?Q?aW4Qlvz+aAxulobeAqm1XNY69aKR2/9RBbD6ChAjKYTZEJ2dFIYfPlS0XcF2?=
 =?us-ascii?Q?c0gBS9YHxkIw3wvj1a8aNMiDrE4nFFIEVmeCNTABvx9QFuvDEkOx5F2PF/uw?=
 =?us-ascii?Q?KtcuTb61U7H6N1N+7du/sUa5ZRQ1CPa5FmpMOO0VSkpa4DVVDAto9pxqT+9F?=
 =?us-ascii?Q?pFSxGmhH9CtYKFmEr1LsMyj37DMVl778UMTMrTOF+CJDRow21iDQiD7gKFmI?=
 =?us-ascii?Q?1WVSN4qxBlzdV3pV3b3r61hLQIvd6773GjiN23JZbavYFihhbKHXD93M30zM?=
 =?us-ascii?Q?X8Ii2QdarNavJ1AHGDkx1SvDUSSdpssYyFcs1Otdmmof4CpL8rqHR6lMTITn?=
 =?us-ascii?Q?uxYL2yh72ycnvDoZYlRyN9vRaYw9CGjWj1oURyWV+7E4UhpGWuHTWBfQ6/Ut?=
 =?us-ascii?Q?/awIApAvSGS77n/wwNMx9YTjmox+GDQ8GieplxlOyDPX/KTL7rLs9d1yJGlm?=
 =?us-ascii?Q?9yR19ruBp2Xcdr+35GEW5voOpmIeP978+XOJqW3liUEZUhAlLgK/AvfQsd8P?=
 =?us-ascii?Q?n8Y8tQB9daHE+SAhrivG5H0rMIICTycobcdFR2f/x3hT3ws3W3ndw8XZW8q7?=
 =?us-ascii?Q?N6hKmLAwzGAI8BF7l+azcl+qX4wAjyDKrB7Y5QvzbqCI+hOVBME9VRhQt8xp?=
 =?us-ascii?Q?ogr88IgrAv5JUoHUpnFMEtnPvq+VJX4qezDyyg17d3moajwGAsD5B7cPGykh?=
 =?us-ascii?Q?UuVXr2bNMeo0Z9OCNv+GVMnmVgJyst04DGZCBD2RWHwb26rX1vHI6TQsXh4f?=
 =?us-ascii?Q?p09buGAaKBEJFNmhp2SiDBjPqVwJZg49/cZFz79m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f805b1-75bf-473a-6f01-08da901ffacd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 15:53:45.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HJibaH8rd0xobp/ypoDUdYOYCT8uF5b7Pa92CGI0372EIUM4bjuF7TysUi4s950
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 05:52:34PM +0200, Takashi Iwai wrote:
> On Tue, 06 Sep 2022 17:41:51 +0200,
> Jason Gunthorpe wrote:
> > 
> > On Tue, Aug 23, 2022 at 05:28:24PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 23, 2022 at 01:46:36PM +0200, Takashi Iwai wrote:
> > > > It was tested now and confirmed that the call path is via AMDGPU, as
> > > > expected:
> > > >   amdgpu_pci_probe ->
> > > >   amdgpu_driver_load_kms ->
> > > >   amdgpu_device_init ->
> > > >   amdgpu_amdkfd_device_init ->
> > > >   kgd2kfd_device_init ->
> > > >   kgd2kfd_resume_iommu ->
> > > >   kfd_iommu_resume ->
> > > >   amd_iommu_init_device ->
> > > >   iommu_attach_group ->
> > > >   __iommu_attach_group
> > > 
> > > Oh, when you said sound intel I thought this was an Intel CPU..
> > > 
> > > Yes, there is this hacky private path from the amdgpu to
> > > the amd iommu driver that makes a mess of it here. We discussed it in
> > > this thread:
> > > 
> > > https://lore.kernel.org/linux-iommu/YgtuJQhY8SNlv9%2F6@8bytes.org/
> > > 
> > > But nobody put it together that it would be a problem with this.
> > > 
> > > Something like this, perhaps, but I didn't check if overriding the
> > > type would cause other problems.
> > 
> > Takashi, do we want to do this patch?
> 
> I really have no much preference regarding the fix for this
> regression from my side.  If you can work on it, it'd be greatly
> appreciated.

If you say this patch works I will formally propose it, but I have no
ability to test on this special AMD HW.

Thanks,
Jason
