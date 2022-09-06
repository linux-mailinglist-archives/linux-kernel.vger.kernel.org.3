Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA55AF07E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiIFQeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbiIFQdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:33:35 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B302832F0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljF4Rewa+LxK3JqSx+wVr3w44eQGtL6vBX3hwvQDPlZHg8RG27FJFafnY+SR61QbWb32ztfVFjAkAOrcccCMFtUeC4v0DaE2C7zuru1e1n5YmW8pu2UbbNWsThsIBLZBQ9TEeHrkV3RHnJ1ILPW7xvYghr+EPmKY9BWFWpEPZH4yEIL2sKMhAEWZVxcocq96l/KGMz0EWNCpN8Dz74qAwyWw/9irkrc37g/MJ4oXxzfJ3qW+mzzu/48jYJqNUcG3d9aIoE53BUUequ8fYrBG4W+Ki+pIq4Tv18G6A/UfhylLm/F1CAie4+ndi16QEnHLpPi8a+hoos+qElTde/hJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgUNBIy5AKDahSlkRCppvLV/00V8sqjsw38hifBHDQI=;
 b=VUP+N2reB4H55Mrl3W8p+iQFB2pupFmfKyb3k9cmrrsqWeo5fwRRZFXJLTY0T3UrHwBZGZCf/XuMqc0i1KkY2EERRIP/mq+boX3ASGLn/lPDthgzRizPKIOD4iF/Hct6KlkoGsIR31GQWLSZvxHUB0F/7uagUIV2SIImExrDcwT1+b4lkdJJYItQ7iu5JGy7hivo+dm0mDCwJKuzQlkIi4n4PyZq7egRDWYl7Pbvt42fd2T1sLMAdBkw3I6DJj2WRwQNCCkwtwbDYn+aY9LU15VYiw3AfecacCNe9gjo88Rj45qKzekeAVjWahUvTZvpsRIgB9Eipnu+HNM+cU3Oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgUNBIy5AKDahSlkRCppvLV/00V8sqjsw38hifBHDQI=;
 b=Q7c8/RuY+HGFAL6t12fYgIvC/tBaRZj4JZ0im3L5QqUY7Oocy39aeIDR6Qbn5kF9idHqJNCwzhRKDRwiVhA5ShuWYlo7H58LWhkTtliy2rYkmnK9vWCn+H4uUC1euhHMLtx1w4o/jd3X0VOEN6x7v5QoeoF4LK1SVbn2vmqR/qokA0uzhupXw7ECIKsrh0Zn5CnMvYTUW5JMTQfjIFUpimoiVLZeueyObaOw4Q4XGrw7SbEn8mGMgC224v8Stj3Tn1JcZ1jGaWYAxAQ5Qb8V8dMyhOclKGC/X5Sx0iaU0t7Od+9sLYuAo6e/bvCjuP/KONRFF2+hl843BPyyfbhgCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 16:08:51 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 16:08:51 +0000
Date:   Tue, 6 Sep 2022 13:08:50 -0300
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
Message-ID: <Yxdwko2HIugmppl+@nvidia.com>
References: <874jy4cqok.wl-tiwai@suse.de>
 <20220823010021.GA5967@nvidia.com>
 <87h723sdde.wl-tiwai@suse.de>
 <87ilmjqj1f.wl-tiwai@suse.de>
 <20220823202824.GA4516@nvidia.com>
 <YxdqP9i0bEwUg4VJ@nvidia.com>
 <87edwofqkd.wl-tiwai@suse.de>
 <YxdtCMbrDQCc5N42@nvidia.com>
 <877d2gfq0k.wl-tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d2gfq0k.wl-tiwai@suse.de>
X-ClientProxiedBy: BL0PR02CA0120.namprd02.prod.outlook.com
 (2603:10b6:208:35::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 926d3612-e421-4c36-e2c2-08da902216b5
X-MS-TrafficTypeDiagnostic: CY8PR12MB7610:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBVpar/P3GhmMx2OfvBxnHmy/jVxS9mzJUil7i3KG+BsblYpODeLlcRhy2UNYcQ3DIGUP5mjyJzbqmcgfGM5/CWJXhYERXl8MTKicaTZZt7GmV4aRxDROwA56VCDFfqtRI3LFNxAQI5zuSD3YJqSw14HuiWmEtikLjwX6rg21O3eiHbEfI4Tfau2ty4FJs0fRfTP8Gcu+mqOmjD2BbBsw8t5nM1b0szclcWga60NT14In487Yw8oX4o+2pvcfe/dK/Nfk+a7Op2hBNfwu+53vSR2dP5/3eGuIPdahAO5875HjlPdIUhSBzBtYyukhTsM6yXcKbWuuxZC0ytOlVQuRigPaLi/zNg0lhaLxyVMcVMh5q131UMuaEd7HpBGLTKvAxkhwNcLaIUNwnzzoiPiPFoBwTSmrqsluCbrjk/xUoR9M8aKl9EJVl1h3+QPLp7PeCsHCjyZvEAoluNuThUpNH0HdoyIfwF6h40yRIwZtFW+R6AV+N5CJSemZeO9PYzjR1mAiDbQdp41hxHPSpXG2qjnLmUIF5htj6Q2QpXi3Gq6FJQrxMOvkfqbWpahGyy6gwREcVmbCkQ0xrnFiIi+zenOUJ2aQpeaJn4VT/STXOMyXTG8obyfTMod1T8rk9PJvM7dxOrkFlB3IYXAQuA6Tbs/gi2xCbGlP+zhTZ0kRlrlerPV/m0qVCncH6W1ihJTMyX65Lj4ut95Oxuq8p4CEAt1xQFKm+iZ7xG1hMvcqPgyMJ14rQtb5TOGKyQ6/0Tpvj4LDtk3V2eh553u0TYPYjGNl+Evwf+NTg+MkqWJReo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(6916009)(6512007)(8676002)(186003)(54906003)(2616005)(26005)(41300700001)(36756003)(38100700002)(316002)(6506007)(8936002)(558084003)(86362001)(478600001)(66946007)(5660300002)(66476007)(966005)(6486002)(4326008)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ocs6kgRHsnzOxa1lHUJyldh7Q/Bb+fpulJguH8ouzOJRhNAV7ZqgoYXXJhld?=
 =?us-ascii?Q?WY0SMnZo7LvkBEhe0DmWA+d+ojlbbEc+gKCdwvufOi45g4HP0p8enuGxwSIQ?=
 =?us-ascii?Q?qtPzs2dkP3ayDbwxn5y01te+LzpErLIvIV3KTcCwLS23E3TUvXonaz1kbDh2?=
 =?us-ascii?Q?bqhZ0XfLtd+VivuT+jWm8iogGjdv/CpTfH5fP0L0PgKIOZs+LjdrgMCrRWCK?=
 =?us-ascii?Q?mxhhtcOmQ8drKupLcg7m3cojj86bF0vCVDXGP/ODzMxhf5zfx+IseeywSxCV?=
 =?us-ascii?Q?Qpj0/mCbt2YXAgSwMvwFfKpKI1CyB9fBXq7azUTNYPNbsir54PpjqkRA1aLk?=
 =?us-ascii?Q?a0slBZulZ3MB3x4qNKfwg62ghFhdACE/tLgvxRP9mBjB11bfbmYVdOg6cWQc?=
 =?us-ascii?Q?//9LdcFCqesYrII8qPc8QuLDJ+PkZtDWrKPaJ0Zt3Dcybpd3cx/bW/e4Ffm5?=
 =?us-ascii?Q?mvrqEPCGk3FSwkLhAn1PL8jjwfmpIxU0/DmLhvFYwVsgi/16lXLYLCOOHyNx?=
 =?us-ascii?Q?ApLhgRHJCS5DcnImqoBk+tqxGbM1+j6t6kdSkFqv3ROQuyckzDEqccuMke8X?=
 =?us-ascii?Q?51oW8PZ6P/of7gbSStCNCRFVR2w9hV1qbP9ZcrgUINzyTuflaAM4dHUY6fXt?=
 =?us-ascii?Q?gM9DeutOos+3l4ieErb8lY6OUlrimAPJ0EaqnKsY1+W3QfwaPen7ViZejoZO?=
 =?us-ascii?Q?jhQvCJCW4vi0RLGjojHJkqQYxNqxfUwcjv9E6IkSFNejb5NB1KDRJmZ4cwwt?=
 =?us-ascii?Q?4ZwbXmTPyb9Up5YdfnOwxoQ0wfaHGwGCEreYyFHeE5pJhBiOZwwgUFRbqfY9?=
 =?us-ascii?Q?mr+wOmB/vByuKBw8BWJecXIW/ZM5aX6MCmGpMw1nz66Zr/afU/kP6GM5E5zi?=
 =?us-ascii?Q?3XMC07J8l4lLKA1vZr3Ia8cDEmKaCP1xpVkkLstHUk7Li+1n963mDP84Nz5j?=
 =?us-ascii?Q?ml0KHTVh2EkLpDPDZlsRLuiPyjIxBHkDFj0t1a+R951VzEyiCqsf4WoWsqYI?=
 =?us-ascii?Q?xXQ1UGZiYgvQSgSXslTsP1/bHOzlVO+gx9bgfO2P7QCCLwEPhsLS1SJX54Vb?=
 =?us-ascii?Q?oTBQ6g+v9h7zNjnHJKMeoWdbDTwKBUipEy5OXacCzvMCimnh7qlOaAGWCPHA?=
 =?us-ascii?Q?otVTpYEZgnmTCeNjBUOpw+AAFdL7PJ6dUjVCROq7FD8OyrzVlO8AwhEeSWu1?=
 =?us-ascii?Q?1HTkGueteTQehVsDw4wtLEyrWv2h2O4o++YD/xiIUA6iaSbR6tBfa99M2RAj?=
 =?us-ascii?Q?FHKXx5zhmPUqyd4j26UcYgOqEj2QG4gErzotAZNcNi66LoX4A6GlYDCe2iiH?=
 =?us-ascii?Q?hpcknv3RK0fYqPxFk5XRfI7lH5ZHWnOxhZwQvChG5FBL2/OTepMpHDL6XBpB?=
 =?us-ascii?Q?wa4su3P7DLZIHC3nlgrRC1rj2QSnlocOxyboUOWlZH8e6dCsMYdFmxShVb8U?=
 =?us-ascii?Q?rTseiKhomZ44O5m2xzB6EcfYDwJhGB1Y0t2itGPcg5mPSeoqUuamsOk+RmGb?=
 =?us-ascii?Q?fbH+BHaKc5rn+qFLaLT2JO6sL/NomUrSEWCpUK2gU8aV6uOEW2klFNNVJMAC?=
 =?us-ascii?Q?fdm8+vfAE+poPhmkdVWWQHQYws8RPH6UMF+Sh6cD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926d3612-e421-4c36-e2c2-08da902216b5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 16:08:51.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fav9oGBuVMqQylJo3Wp9pidzuJ7HSjrxZZo2w7iIYuMCd3Q88AbIrAP+EhzeavqD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 06:04:27PM +0200, Takashi Iwai wrote:

> If you can send (or point) a patch for test, I can set up a test
> kernel and ask reporters for testing it.

https://lore.kernel.org/all/20220823202824.GA4516@nvidia.com/

Jason
