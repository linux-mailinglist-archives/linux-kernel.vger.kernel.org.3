Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F37587E41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbiHBOjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiHBOjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:39:36 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130044.outbound.protection.outlook.com [40.107.13.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368FE18370;
        Tue,  2 Aug 2022 07:39:33 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=G/ijuTGkDZuQoHhsAzqRD0bxnIFfchCwQrUsD2ILL35IMSZPtFIOb9pW2HXfO7fd+DKAiYlVW88oxa4axzFE9onURYEdW4NyFTRrZm9b17STZm7y9zbNUGqk8RN5zyHkUJPiImkAMbn37Bqlx7HooyBwaxFfRBp645hOgLhBK2HwsvlZ+ww1gYq6wv/Lj2LaNE7AQK4STqNmS3xEnLab6pb3TvPSdGB1dz3zn2DqZq+le2MJtmaZvYos6r/XS4GHtwigUyZy7x6csrE+bUPfA/ECJLZAO+HbODj9TP6B4SIvB8sEFxCN9UevRil+P+NSBdNZYxREQW41cUvSVZGCnA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3GvsCfZ8zm3mjXxo0SNerz/pnc375+tlcV5xXoMgnw=;
 b=e0SGJtjksQJi/W5pFkmi9LWqAnNOVkFLr3GT9Wy3ek5WNAhkHl5u75GydRWTQ4qslYOfTOOEH+gBsNzYNq6qyLNhlweHVGeknXxcQDzmZ3dEYMQOH26FHfMy4FUgq1iDTIufRX+Orlh/qprn6tsbtyG93Ta3kNtSRo/5z6SWzojph28TMjBGSH9k2oTrhlOD3/FbCA8psKD/KbP/IZMlaworb40aQtDgAfopxnM6tQ70qvLAEZ5ANIhfndSwPXMIH+i5uIX4R6sQBAnUhwBS5mEoxyVH4rS+YGGZQ7WaZGT18hRVsxanALBbyS/Ki6rVQ5k05QVo/Z6X/bQEUexrGA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3GvsCfZ8zm3mjXxo0SNerz/pnc375+tlcV5xXoMgnw=;
 b=w5huj5Dnt0JFHCp8piBGnV4BD+MN/nRL+q/NFnQRnlMR3OtYG9kHE7UnO5eJ8r6l4zkUzkb12vZfFX1txmqWj01NQh420sjkVe97p/E6hJBsQHtWurbaDhgqodYyn2trPyFvo9kuipn97NmbbOlIGct4Ar2PN4Pg+9UOjZZsCdw=
Received: from FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4b::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 14:39:29 +0000
Received: from VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:4b:cafe::4c) by FR3P281CA0068.outlook.office365.com
 (2603:10a6:d10:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.11 via Frontend
 Transport; Tue, 2 Aug 2022 14:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT042.mail.protection.outlook.com (10.152.19.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.12 via Frontend Transport; Tue, 2 Aug 2022 14:39:28 +0000
Received: ("Tessian outbound cc6a8ab50b6b:v123"); Tue, 02 Aug 2022 14:39:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bc206f62ed8809a5
X-CR-MTA-TID: 64aa7808
Received: from 8a85b536ad0b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9AE54AAD-71B7-4CB5-A7B7-64220D50C2CF.1;
        Tue, 02 Aug 2022 14:39:21 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8a85b536ad0b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 02 Aug 2022 14:39:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1A8I7RFR+ErUICpL662ZwBeLAD62sVDMhEnqhoUquuSkhlPZHEx7maMEyY1DBQCu57oNCUh/GLsMVl5P3ifzv3kWkBKXCO8SKZ/2SwepnQICliJBlznt2UcFt6Vur8VlguoUhQUW7nGOJgNv6Jjnz9IKzrTwECm20bD5JDRryt3zeaKFmMKt9Af7caEJIXVogHY8UYjYgLY9EVqcjd9QhDekPEsozZnyQwt6CJf2Jc7tlOJg/ZAxHx7nqQ5fkUe9+0hopYpVwqzvMYrW5gDu9lIbo9QSX0uhVSQmCUqZoJlbTPo4Anu/QtS2EWknh/hezDLGEzJT5K23/uettW50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3GvsCfZ8zm3mjXxo0SNerz/pnc375+tlcV5xXoMgnw=;
 b=NsDDtDV1rR6c+u9xNbt2MwWZyvr3hbbfoBKdrtKqK2f9NOfzw+3yNALLaP+GvV20edXBiDCDaMfvdDil5GXN69X51X0KHVwToFRFLiHdHPU9eL5tFnbYs+46FtcZ3HPfhah5OIQSs3sSchoxMNMYGaiwNtDv4BW4U+mLPOSDsEYHr2ZbZdm9w5xPCABocmOJpqxqYbqY7p0Va7YfmzjtGufNiTqlNpgXu9coM+IXnoSlRXAoWcODncXelrPxLnnYixQNxEEelhnazY3MZDrmcUaw7ApX7gsSz/38U/syeTf1ARb0LHJMVU6oNudr4m9HR4Ft9KgK9eZJfWWFXHfZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3GvsCfZ8zm3mjXxo0SNerz/pnc375+tlcV5xXoMgnw=;
 b=w5huj5Dnt0JFHCp8piBGnV4BD+MN/nRL+q/NFnQRnlMR3OtYG9kHE7UnO5eJ8r6l4zkUzkb12vZfFX1txmqWj01NQh420sjkVe97p/E6hJBsQHtWurbaDhgqodYyn2trPyFvo9kuipn97NmbbOlIGct4Ar2PN4Pg+9UOjZZsCdw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6803.eurprd08.prod.outlook.com (2603:10a6:20b:301::12)
 by AM6PR08MB5013.eurprd08.prod.outlook.com (2603:10a6:20b:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.13; Tue, 2 Aug
 2022 14:39:17 +0000
Received: from AM9PR08MB6803.eurprd08.prod.outlook.com
 ([fe80::4cad:8ea2:a247:6bce]) by AM9PR08MB6803.eurprd08.prod.outlook.com
 ([fe80::4cad:8ea2:a247:6bce%8]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 14:39:17 +0000
Date:   Tue, 2 Aug 2022 15:39:08 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Olivier Masse <olivier.masse@nxp.com>
Cc:     sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
        christian.koenig@amd.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, clement.faure@nxp.com, nd@arm.com
Subject: Re: [PATCH 3/5] dma-buf: heaps: add Linaro secure dmabuf heap support
Message-ID: <20220802143908.24vemxeon537cad2@000377403353>
References: <20220802095843.14614-1-olivier.masse@nxp.com>
 <20220802095843.14614-4-olivier.masse@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802095843.14614-4-olivier.masse@nxp.com>
X-ClientProxiedBy: LO4P123CA0560.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::18) To AM9PR08MB6803.eurprd08.prod.outlook.com
 (2603:10a6:20b:301::12)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e32b375d-7f76-4841-2762-08da7494ce04
X-MS-TrafficTypeDiagnostic: AM6PR08MB5013:EE_|VE1EUR03FT042:EE_|AM7PR08MB5381:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uj+eZuQbafjsm6suRuYZsG2n6X8cr9w4uelk/2vhZ/8WUA1Q3Ucb+ZiFqvo3CGsBGL0xTVJIVADB6rp+HN/lqUVBrnyRu9iyNt0mabnx5wJ67evelXBS+iCSgIV4sb/4LecnCDjG0gV2RMqJeDjYTA3bOWOq9ebsgYE6b7evOiwcj7YhSSZIZikEFw9l4EmIIQBGdttcZIsq6wOUHmklogHFaCDr172IjLh351tWjDvAh0TT2GMX/ZMY04dgwGAsbZl2q01+bgS1VyLkClUzmCULS88hpZrv6fZUggHMRA8naCEbuHw5L0Uo/yaQQdHdIPBXmwhxkxr1Y4kvJpSG3j2tfrqFRx62FY19cMjbiAB+Sn6fZ6HGrkPkCdFpdLxx6Unf/VNo3UM7/pZln2e08tscqgIL0FoE+ozAUTLqAzGW/X/wYOXDzpVqicdPNRxaHRnYKFjd2bqkrEZXus48iPcI+Ih85J8/6nDrbMAROiSojK3iIk6okzFxaBb9IzdFmNQXq9/d1Qeb5vSJ7EUFHysokJ6+wt+Jv51neVLhqvCcTQ8qZjl5Mp/8m8BWPuTB8rmNrKnkd8Mvb1HWRduIL7uKgMuDqcHbR9L7IdiqjLxZ9/om4GD3Nwa5zCe5Y2ihszwbW0ol6D9YOeaClbqmV0Mn/eY/4sVEWZRYhERVuEqh7Vf7p5Ba9nRq5+Ygllt1
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6803.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(136003)(346002)(366004)(396003)(39860400002)(6666004)(30864003)(478600001)(41300700001)(5660300002)(2906002)(6916009)(33716001)(316002)(6486002)(966005)(8936002)(44832011)(6506007)(38100700002)(66556008)(66476007)(86362001)(66946007)(1076003)(186003)(8676002)(26005)(6512007)(4326008)(9686003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5013
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3c79e63f-0606-4358-0e8a-08da7494c70a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvqMI5xsf1souf/NNv+KILF+Dm9DsCoJ3C8GX+cjZPt4eM0030xYVYTUBjTqwtWXAV+pvhjsRNRuRrZSHVN2ZBKAf/F53ACrdJs96vMnM0jL/9LLUuL5/glmoOfC7Kero6vsB7adNzKDo4oaO+fxeRa0D6vn3BWhipEts7f2MM4eOTywvuQMUbr/VZLulPv7u06pyIcXf4i5u12SzdNKduDPzLNSUissx+l3kVJvlRPjcn3mM1WdEaG5dNzQCS91O9prJVYLT73wcgm2TgKq6O4KgSbGeYlSFq0PVASwRLYkthEgmxWjE7q0uc4MYqdrhluTY5T4Ps7FPgfh202qUttXuKsLMFQVOldBNqWn5qhaJ8z5I5CuhV0U9OjoDHF6F6Aa4xjylYDInPW6bPKWm8sQCYIh800IO/gMJewvw922mqn+OaItUcpcXraeZx4z8G0eviPQROPmuKq/PJPxhsjkaihv313uPBz+Hvcclbn9s/MSz9i/Gn314tfIB3Cl8Y0feZT04dIM+FO+nAUl9ESrRFz5xy7x8NhjHY+dRBvg8IIurmm+eLv6/7YVv0hNJGwc9nNaszafhZOwo050o3xcE/QjIxFu8jxNaNaUTMLCVugf5zvUAkj6M8V/A7yiSYmT0V1evPLOYrU4e8EiRy4fO+bnEogutgt70h5nZYsQfTerrDTHwqjHL3zRWewJhFOIxoIUHckvreY5Z3w/UbWGYpNlSeChuBTKnt2vRv437rUrsQZjdaeHoVij5VeA
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(40470700004)(36840700001)(41300700001)(6506007)(6666004)(9686003)(6512007)(26005)(33716001)(316002)(40480700001)(478600001)(86362001)(82310400005)(6486002)(966005)(81166007)(356005)(40460700003)(82740400003)(47076005)(1076003)(83380400001)(336012)(4326008)(186003)(36860700001)(30864003)(450100002)(70206006)(70586007)(2906002)(44832011)(8676002)(8936002)(5660300002)(6862004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 14:39:28.4988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e32b375d-7f76-4841-2762-08da7494ce04
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier,

Some comments below as I mentioned off-list.

One additional point: some devices need to know if a buffer is
protected, so that they can configure registers appropriately to make
use of that protected buffer. There was previously a discussion about
adding a flag to a dma_buf to indicate that it is allocated from
protected memory[1].

[1] https://lists.freedesktop.org/archives/dri-devel/2019-September/238059.html

On Tue, Aug 02, 2022 at 11:58:41AM +0200, Olivier Masse wrote:
> add Linaro secure heap bindings: linaro,secure-heap
> use genalloc to allocate/free buffer from buffer pool.
> buffer pool info is from dts.
> use sg_table instore the allocated memory info, the length of sg_table is 1.
> implement secure_heap_buf_ops to implement buffer share in difference device:
> 1. Userspace passes this fd to all drivers it wants this buffer
> to share with: First the filedescriptor is converted to a &dma_buf using
> dma_buf_get(). Then the buffer is attached to the device using dma_buf_attach().
> 2. Once the buffer is attached to all devices userspace can initiate DMA
> access to the shared buffer. In the kernel this is done by calling dma_buf_map_attachment()
> 3. get sg_table with dma_buf_map_attachment in difference device.
> 
> Signed-off-by: Olivier Masse <olivier.masse@nxp.com>
> ---
>  drivers/dma-buf/heaps/Kconfig       |  21 +-
>  drivers/dma-buf/heaps/Makefile      |   1 +
>  drivers/dma-buf/heaps/secure_heap.c | 588 ++++++++++++++++++++++++++++
>  3 files changed, 606 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/dma-buf/heaps/secure_heap.c
> 
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
> index 6a33193a7b3e..b2406932192e 100644
> --- a/drivers/dma-buf/heaps/Kconfig
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -1,8 +1,12 @@
> -config DMABUF_HEAPS_DEFERRED_FREE
> -	tristate
> +menuconfig DMABUF_HEAPS_DEFERRED_FREE
> +	bool "DMA-BUF heaps deferred-free library"
> +	help
> +	  Choose this option to enable the DMA-BUF heaps deferred-free library.
>  
> -config DMABUF_HEAPS_PAGE_POOL
> -	tristate
> +menuconfig DMABUF_HEAPS_PAGE_POOL
> +	bool "DMA-BUF heaps page-pool library"
> +	help
> +	  Choose this option to enable the DMA-BUF heaps page-pool library.
>  
>  config DMABUF_HEAPS_SYSTEM
>  	bool "DMA-BUF System Heap"
> @@ -26,3 +30,12 @@ config DMABUF_HEAPS_DSP
>            Choose this option to enable the dsp dmabuf heap. The dsp heap
>            is allocated by gen allocater. it's allocated according the dts.
>            If in doubt, say Y.
> +
> +config DMABUF_HEAPS_SECURE
> +	tristate "DMA-BUF Secure Heap"
> +	depends on DMABUF_HEAPS && DMABUF_HEAPS_DEFERRED_FREE
> +	help
> +	  Choose this option to enable the secure dmabuf heap. The secure heap
> +	  pools are defined according to the DT. Heaps are allocated
> +	  in the pools using gen allocater.
> +	  If in doubt, say Y.
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
> index e70722ea615e..08f6aa5919d1 100644
> --- a/drivers/dma-buf/heaps/Makefile
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_DMABUF_HEAPS_PAGE_POOL)	+= page_pool.o
>  obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
>  obj-$(CONFIG_DMABUF_HEAPS_CMA)		+= cma_heap.o
>  obj-$(CONFIG_DMABUF_HEAPS_DSP)          += dsp_heap.o
> +obj-$(CONFIG_DMABUF_HEAPS_SECURE)	+= secure_heap.o
> diff --git a/drivers/dma-buf/heaps/secure_heap.c b/drivers/dma-buf/heaps/secure_heap.c
> new file mode 100644
> index 000000000000..31aac5d050b4
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/secure_heap.c
> @@ -0,0 +1,588 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMABUF secure heap exporter
> + *
> + * Copyright 2021 NXP.
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/dma-heap.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/genalloc.h>
> +#include <linux/highmem.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +
> +#include "deferred-free-helper.h"
> +#include "page_pool.h"
> +
> +#define MAX_SECURE_HEAP 2
> +#define MAX_HEAP_NAME_LEN 32
> +
> +struct secure_heap_buffer {
> +	struct dma_heap *heap;
> +	struct list_head attachments;
> +	struct mutex lock;
> +	unsigned long len;
> +	struct sg_table sg_table;
> +	int vmap_cnt;
> +	struct deferred_freelist_item deferred_free;
> +	void *vaddr;
> +	bool uncached;
> +};
> +
> +struct dma_heap_attachment {
> +	struct device *dev;
> +	struct sg_table *table;
> +	struct list_head list;
> +	bool no_map;
> +	bool mapped;
> +	bool uncached;
> +};

I think dma_heap_attachment should have a more specific name,
otherwise it looks like some generic part of the dma_heap framework.

> +
> +struct secure_heap_info {
> +	struct gen_pool *pool;
> +
> +	bool no_map;
> +};
> +
> +struct rmem_secure {
> +	phys_addr_t base;
> +	phys_addr_t size;
> +
> +	char name[MAX_HEAP_NAME_LEN];
> +
> +	bool no_map;
> +};
> +
> +static struct rmem_secure secure_data[MAX_SECURE_HEAP] = {0};
> +static unsigned int secure_data_count;
> +
> +static struct sg_table *dup_sg_table(struct sg_table *table)
> +{
> +	struct sg_table *new_table;
> +	int ret, i;
> +	struct scatterlist *sg, *new_sg;
> +
> +	new_table = kzalloc(sizeof(*new_table), GFP_KERNEL);
> +	if (!new_table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = sg_alloc_table(new_table, table->orig_nents, GFP_KERNEL);
> +	if (ret) {
> +		kfree(new_table);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	new_sg = new_table->sgl;
> +	for_each_sgtable_sg(table, sg, i) {
> +		sg_set_page(new_sg, sg_page(sg), sg->length, sg->offset);
> +		new_sg->dma_address = sg->dma_address;
> +#ifdef CONFIG_NEED_SG_DMA_LENGTH
> +		new_sg->dma_length = sg->dma_length;
> +#endif
> +		new_sg = sg_next(new_sg);
> +	}
> +
> +	return new_table;
> +}
> +
> +static int secure_heap_attach(struct dma_buf *dmabuf,
> +			      struct dma_buf_attachment *attachment)
> +{
> +	struct secure_heap_buffer *buffer = dmabuf->priv;
> +	struct secure_heap_info *info = dma_heap_get_drvdata(buffer->heap);
> +	struct dma_heap_attachment *a;
> +	struct sg_table *table;
> +
> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
> +	if (!a)
> +		return -ENOMEM;
> +
> +	table = dup_sg_table(&buffer->sg_table);
> +	if (IS_ERR(table)) {
> +		kfree(a);
> +		return -ENOMEM;
> +	}
> +
> +	a->table = table;
> +	a->dev = attachment->dev;
> +	INIT_LIST_HEAD(&a->list);
> +	a->no_map = info->no_map;
> +	a->mapped = false;
> +	a->uncached = buffer->uncached;
> +	attachment->priv = a;
> +
> +	mutex_lock(&buffer->lock);
> +	list_add(&a->list, &buffer->attachments);
> +	mutex_unlock(&buffer->lock);
> +
> +	return 0;
> +}
> +
> +static void secure_heap_detach(struct dma_buf *dmabuf,
> +			       struct dma_buf_attachment *attachment)
> +{
> +	struct secure_heap_buffer *buffer = dmabuf->priv;
> +	struct dma_heap_attachment *a = attachment->priv;
> +
> +	mutex_lock(&buffer->lock);
> +	list_del(&a->list);
> +	mutex_unlock(&buffer->lock);
> +
> +	sg_free_table(a->table);
> +	kfree(a->table);
> +	kfree(a);
> +}
> +
> +static struct sg_table *secure_heap_map_dma_buf(struct dma_buf_attachment *attachment,
> +						enum dma_data_direction direction)
> +{
> +	struct dma_heap_attachment *a = attachment->priv;
> +	struct sg_table *table = a->table;
> +	int attr = 0;
> +	int ret;
> +
> +	if (!a->no_map) {

This looks strange - you're expecting this driver to be used on
regions with no-map set, but if no-map _is_ set, you don't allow the
dma_buf to get mapped to any devices. Doesn't that mean that these
buffers can never actually be used?

> +		if (a->uncached)
> +			attr = DMA_ATTR_SKIP_CPU_SYNC;
> +

If the CPU can never touch these buffers, is cached vs uncached
meaningful?

If the TEE touches the buffers from the CPU then perhaps the TEE would
need to do cache maintenance, but I'd expect that to be managed in the
TEE.

> +		ret = dma_map_sgtable(attachment->dev, table, direction, attr);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		a->mapped = true;
> +	}
> +
> +	return table;
> +}
> +
> +static void secure_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
> +				      struct sg_table *table,
> +				      enum dma_data_direction direction)
> +{
> +	struct dma_heap_attachment *a = attachment->priv;
> +	int attr = 0;
> +
> +	if (!a->no_map)	{
> +		if (a->uncached)
> +			attr = DMA_ATTR_SKIP_CPU_SYNC;
> +
> +		a->mapped = false;
> +		dma_unmap_sgtable(attachment->dev, table, direction, attr);
> +	}
> +}
> +
> +static int secure_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
> +						enum dma_data_direction direction)

If the firewall is preventing CPU accesses, then shouldn't
begin_cpu_access and end_cpu_access either fail or be a no-op?

> +{
> +	struct secure_heap_buffer *buffer = dmabuf->priv;
> +	struct dma_heap_attachment *a;
> +
> +	mutex_lock(&buffer->lock);
> +
> +	if (buffer->vmap_cnt)
> +		invalidate_kernel_vmap_range(buffer->vaddr, buffer->len);
> +
> +	if (!buffer->uncached) {
> +		list_for_each_entry(a, &buffer->attachments, list) {
> +			if (!a->mapped)
> +				continue;
> +			dma_sync_sgtable_for_cpu(a->dev, a->table, direction);
> +		}
> +	}
> +	mutex_unlock(&buffer->lock);
> +
> +	return 0;
> +}
> +
> +static int secure_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
> +					      enum dma_data_direction direction)
> +{
> +	struct secure_heap_buffer *buffer = dmabuf->priv;
> +	struct dma_heap_attachment *a;
> +
> +	mutex_lock(&buffer->lock);
> +
> +	if (buffer->vmap_cnt)
> +		flush_kernel_vmap_range(buffer->vaddr, buffer->len);
> +
> +	if (!buffer->uncached) {
> +		list_for_each_entry(a, &buffer->attachments, list) {
> +			if (!a->mapped)
> +				continue;
> +			dma_sync_sgtable_for_device(a->dev, a->table, direction);
> +		}
> +	}
> +	mutex_unlock(&buffer->lock);
> +
> +	return 0;
> +}
> +
> +static int secure_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> +{
> +	struct secure_heap_buffer *buffer = dmabuf->priv;
> +	struct sg_table *table = &buffer->sg_table;
> +	unsigned long addr = vma->vm_start;
> +	struct sg_page_iter piter;
> +	int ret;
> +
> +	if (buffer->uncached)
> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> +
> +	for_each_sgtable_page(table, &piter, vma->vm_pgoff) {
> +		struct page *page = sg_page_iter_page(&piter);
> +
> +		ret = remap_pfn_range(vma, addr, page_to_pfn(page), PAGE_SIZE,
> +				      vma->vm_page_prot);

If the CPU can't touch these buffers, what would they be mapped to
userspace for?

> +		if (ret)
> +			return ret;
> +		addr += PAGE_SIZE;
> +	}
> +	return 0;
> +}
> +
> +static void *secure_heap_do_vmap(struct secure_heap_buffer *buffer)
> +{
> +	struct sg_table *table = &buffer->sg_table;
> +	int npages = PAGE_ALIGN(buffer->len) / PAGE_SIZE;
> +	struct page **pages = vmalloc(sizeof(struct page *) * npages);
> +	struct page **tmp = pages;
> +	struct sg_page_iter piter;
> +	pgprot_t pgprot = PAGE_KERNEL;
> +	void *vaddr;
> +
> +	if (!pages)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (buffer->uncached)
> +		pgprot = pgprot_writecombine(PAGE_KERNEL);
> +
> +	for_each_sgtable_page(table, &piter, 0) {
> +		WARN_ON(tmp - pages >= npages);
> +		*tmp++ = sg_page_iter_page(&piter);
> +	}
> +
> +	vaddr = vmap(pages, npages, VM_MAP, pgprot);
> +	vfree(pages);

Similar to above, if the CPU can't touch these buffers, what would be
the point of mapping them to the kernel?

> +
> +	if (!vaddr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return vaddr;
> +}
> +
> +static int secure_heap_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
> +{
> +	struct secure_heap_buffer *buffer = dmabuf->priv;
> +	void *vaddr;
> +	int ret = 0;
> +
> +	mutex_lock(&buffer->lock);
> +	if (buffer->vmap_cnt) {
> +		buffer->vmap_cnt++;
> +		goto out;
> +	}
> +
> +	vaddr = secure_heap_do_vmap(buffer);
> +	if (IS_ERR(vaddr)) {
> +		ret = PTR_ERR(vaddr);
> +		goto out;
> +	}
> +
> +	buffer->vaddr = vaddr;
> +	buffer->vmap_cnt++;
> +	dma_buf_map_set_vaddr(map, buffer->vaddr);
> +out:
> +	mutex_unlock(&buffer->lock);
> +
> +	return ret;
> +}
> +
> +static void secure_heap_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
> +{
> +	struct secure_heap_buffer *buffer = dmabuf->priv;
> +
> +	mutex_lock(&buffer->lock);
> +	if (!--buffer->vmap_cnt) {
> +		vunmap(buffer->vaddr);
> +		buffer->vaddr = NULL;
> +	}
> +	mutex_unlock(&buffer->lock);
> +	dma_buf_map_clear(map);
> +}
> +
> +static void secure_heap_zero_buffer(struct secure_heap_buffer *buffer)
> +{
> +	struct sg_table *sgt = &buffer->sg_table;
> +	struct sg_page_iter piter;
> +	struct page *p;
> +	void *vaddr;
> +
> +	for_each_sgtable_page(sgt, &piter, 0) {
> +		p = sg_page_iter_page(&piter);
> +		vaddr = kmap_atomic(p);
> +		memset(vaddr, 0, PAGE_SIZE);

How can you do memset on the buffer if the firewall is preventing CPU
accesses?

> +		kunmap_atomic(vaddr);
> +	}
> +}
> +
> +static void secure_heap_buf_free(struct deferred_freelist_item *item,
> +				 enum df_reason reason)
> +{
> +	struct secure_heap_buffer *buffer;
> +	struct secure_heap_info *info;
> +	struct sg_table *table;
> +	struct scatterlist *sg;
> +	int i;
> +
> +	buffer = container_of(item, struct secure_heap_buffer, deferred_free);
> +	info = dma_heap_get_drvdata(buffer->heap);
> +
> +	if (!info->no_map) {
> +		// Zero the buffer pages before adding back to the pool
> +		if (reason == DF_NORMAL)
> +			secure_heap_zero_buffer(buffer);
> +	}
> +
> +	table = &buffer->sg_table;
> +	for_each_sg(table->sgl, sg, table->nents, i)
> +		gen_pool_free(info->pool, sg_dma_address(sg), sg_dma_len(sg));
> +
> +	sg_free_table(table);
> +	kfree(buffer);
> +}
> +
> +static void secure_heap_dma_buf_release(struct dma_buf *dmabuf)
> +{
> +	struct secure_heap_buffer *buffer = dmabuf->priv;
> +	int npages = PAGE_ALIGN(buffer->len) / PAGE_SIZE;
> +
> +	deferred_free(&buffer->deferred_free, secure_heap_buf_free, npages);
> +}
> +
> +static const struct dma_buf_ops secure_heap_buf_ops = {
> +	.attach = secure_heap_attach,
> +	.detach = secure_heap_detach,
> +	.map_dma_buf = secure_heap_map_dma_buf,
> +	.unmap_dma_buf = secure_heap_unmap_dma_buf,
> +	.begin_cpu_access = secure_heap_dma_buf_begin_cpu_access,
> +	.end_cpu_access = secure_heap_dma_buf_end_cpu_access,
> +	.mmap = secure_heap_mmap,
> +	.vmap = secure_heap_vmap,
> +	.vunmap = secure_heap_vunmap,
> +	.release = secure_heap_dma_buf_release,
> +};
> +
> +static struct dma_buf *secure_heap_do_allocate(struct dma_heap *heap,
> +					       unsigned long len,
> +					       unsigned long fd_flags,
> +					       unsigned long heap_flags,
> +					       bool uncached)
> +{
> +	struct secure_heap_buffer *buffer;
> +	struct secure_heap_info *info = dma_heap_get_drvdata(heap);
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	unsigned long size = roundup(len, PAGE_SIZE);
> +	struct dma_buf *dmabuf;
> +	struct sg_table *table;
> +	int ret = -ENOMEM;
> +	unsigned long phy_addr;
> +
> +	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
> +	if (!buffer)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&buffer->attachments);
> +	mutex_init(&buffer->lock);
> +	buffer->heap = heap;
> +	buffer->len = size;
> +	buffer->uncached = uncached;
> +
> +	phy_addr = gen_pool_alloc(info->pool, size);
> +	if (!phy_addr)
> +		goto free_buffer;
> +
> +	table = &buffer->sg_table;
> +	if (sg_alloc_table(table, 1, GFP_KERNEL))
> +		goto free_pool;
> +
> +	sg_set_page(table->sgl,	phys_to_page(phy_addr),	size, 0);
> +	sg_dma_address(table->sgl) = phy_addr;
> +	sg_dma_len(table->sgl) = size;
> +
> +	/* create the dmabuf */
> +	exp_info.exp_name = dma_heap_get_name(heap);
> +	exp_info.ops = &secure_heap_buf_ops;
> +	exp_info.size = buffer->len;
> +	exp_info.flags = fd_flags;
> +	exp_info.priv = buffer;
> +	dmabuf = dma_buf_export(&exp_info);
> +	if (IS_ERR(dmabuf)) {
> +		ret = PTR_ERR(dmabuf);
> +		goto free_pages;
> +	}
> +
> +	return dmabuf;
> +
> +free_pages:
> +	sg_free_table(table);
> +
> +free_pool:
> +	gen_pool_free(info->pool, phy_addr, size);
> +
> +free_buffer:
> +	mutex_destroy(&buffer->lock);
> +	kfree(buffer);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +static struct dma_buf *secure_heap_allocate(struct dma_heap *heap,
> +					    unsigned long len,
> +					    unsigned long fd_flags,
> +					    unsigned long heap_flags)
> +{
> +	// use uncache buffer here by default
> +	return secure_heap_do_allocate(heap, len, fd_flags, heap_flags, true);
> +	// use cache buffer
> +	// return secure_heap_do_allocate(heap, len, fd_flags, heap_flags, false);
> +}
> +
> +static const struct dma_heap_ops secure_heap_ops = {
> +	.allocate = secure_heap_allocate,
> +};
> +
> +static int secure_heap_add(struct rmem_secure *rmem)
> +{
> +	struct dma_heap *secure_heap;
> +	struct dma_heap_export_info exp_info;
> +	struct secure_heap_info *info = NULL;
> +	struct gen_pool *pool = NULL;
> +	int ret = -EINVAL;
> +
> +	if (rmem->base == 0 || rmem->size == 0) {
> +		pr_err("secure_data base or size is not correct\n");
> +		goto error;
> +	}
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		pr_err("dmabuf info allocation failed\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	pool = gen_pool_create(PAGE_SHIFT, -1);
> +	if (!pool) {
> +		pr_err("can't create gen pool\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	if (gen_pool_add(pool, rmem->base, rmem->size, -1) < 0) {
> +		pr_err("failed to add memory into pool\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	info->pool = pool;
> +	info->no_map = rmem->no_map;

This kind of heap probably can't work if the region doesn't have
no-map, so I think it would make sense to enforce that no_map is set
(or ignore regions without no-map in DT).

Cheers,
-Brian

> +
> +	exp_info.name = rmem->name;
> +	exp_info.ops = &secure_heap_ops;
> +	exp_info.priv = info;
> +
> +	secure_heap = dma_heap_add(&exp_info);
> +	if (IS_ERR(secure_heap)) {
> +		pr_err("dmabuf secure heap allocation failed\n");
> +		ret = PTR_ERR(secure_heap);
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	kfree(info);
> +	if (pool)
> +		gen_pool_destroy(pool);
> +
> +	return ret;
> +}
> +
> +static int secure_heap_create(void)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < secure_data_count; i++) {
> +		ret = secure_heap_add(&secure_data[i]);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static int rmem_secure_heap_device_init(struct reserved_mem *rmem,
> +					 struct device *dev)
> +{
> +	dev_set_drvdata(dev, rmem);
> +	return 0;
> +}
> +
> +static void rmem_secure_heap_device_release(struct reserved_mem *rmem,
> +					 struct device *dev)
> +{
> +	dev_set_drvdata(dev, NULL);
> +}
> +
> +static const struct reserved_mem_ops rmem_dma_ops = {
> +	.device_init    = rmem_secure_heap_device_init,
> +	.device_release = rmem_secure_heap_device_release,
> +};
> +
> +static int __init rmem_secure_heap_setup(struct reserved_mem *rmem)
> +{
> +	if (secure_data_count < MAX_SECURE_HEAP) {
> +		int name_len = 0;
> +		char *s = rmem->name;
> +
> +		secure_data[secure_data_count].base = rmem->base;
> +		secure_data[secure_data_count].size = rmem->size;
> +		secure_data[secure_data_count].no_map =
> +			(of_get_flat_dt_prop(rmem->fdt_node, "no-map", NULL) != NULL);
> +
> +		while (name_len < MAX_HEAP_NAME_LEN) {
> +			if ((*s == '@') || (*s == '\0'))
> +				break;
> +			name_len++;
> +			s++;
> +		}
> +		if (name_len == MAX_HEAP_NAME_LEN)
> +			name_len--;
> +
> +		strncpy(secure_data[secure_data_count].name, rmem->name, name_len);
> +
> +		rmem->ops = &rmem_dma_ops;
> +		pr_info("Reserved memory: DMA buf secure pool %s at %pa, size %ld MiB\n",
> +			secure_data[secure_data_count].name,
> +			&rmem->base, (unsigned long)rmem->size / SZ_1M);
> +
> +		secure_data_count++;
> +		return 0;
> +	}
> +	WARN_ONCE(1, "Cannot handle more than %u secure heaps\n", MAX_SECURE_HEAP);
> +	return -EINVAL;
> +}
> +
> +RESERVEDMEM_OF_DECLARE(secure_heap, "linaro,secure-heap", rmem_secure_heap_setup);
> +
> +module_init(secure_heap_create);
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.25.0
> 
