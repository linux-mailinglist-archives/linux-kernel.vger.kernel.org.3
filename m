Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59919568FAE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiGFQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiGFQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:50:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1792A425
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13D15B81E30
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AFEC341D3;
        Wed,  6 Jul 2022 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657126248;
        bh=F167wtkTNZtyyf9YrvPnC8w3YEcKUnsaIrAwzau8brU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xr/0Ykm2GD7gP81AoM+oV9gChYQpIasEgsbr6/M07uvZ8pQ0UFbYDDbhdGUB46SZg
         qKOlZ2b6tTYE14H0mAKA2fdXuyAyBrOu+XhQb7AGxnCOWJmXKFg2NtL3pnaBL/iEih
         qahWjnBz3zTnOFyP5adEMUo7Be6YerGf+GUDuc69t5tJjvkEcenIy38SuSu1xHR7HS
         bzX20XnJD61M6f5K7tL4nWwxS6Jru2P2c1zuzXnQrHIMNCJUdnB1pjsu5kNsfWmgJG
         J+KT3KXqjXKtlD45ZsdHJvuCI6smxtAYWEf0RP0hVyTGyuDwWufifgcX5L29iRMHMl
         VmiIGZOajNz5g==
From:   Will Deacon <will@kernel.org>
To:     Guangbin Huang <huangguangbin2@huawei.com>, john.garry@huawei.com,
        mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, zhangshaokun@hisilicon.com,
        liuqi115@huawei.com, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        f.fangjian@huawei.com, lipeng321@huawei.com, shenjian15@huawei.com
Subject: Re: [PATCH V8 0/2] drivers/perf: hisi: Add driver for HNS3 PMU
Date:   Wed,  6 Jul 2022 17:50:32 +0100
Message-Id: <165710315423.2548450.10557426132028892739.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220628063419.38514-1-huangguangbin2@huawei.com>
References: <20220628063419.38514-1-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 14:34:17 +0800, Guangbin Huang wrote:
> This patch-set adds driver for HNS3(HiSilicon network system version 3)
> PMU and doc to descript it.
> 
> Change logs:
> V7 -> V8:
>  - remove overlapping fields 'event' and 'real_event' of config.
>  - Link: https://lore.kernel.org/linux-arm-kernel/20220525005211.57059-1-huangguangbin2@huawei.com/
> V6 -> V7:
> modify the comments of Will Deacon:
>  - Modify format of event number shown for user.
>  - Add a trailing space for func-intr when show filter mode.
>  - Format the bdf number as the way "b:d.f" when show bdf_min and bdf_max.
>  - Add subevent, event_type, ext_counter_used and real_event for
>    hns3_pmu_format_attr[].
>  - Link: https://lore.kernel.org/linux-arm-kernel/20220427121000.56026-1-huangguangbin2@huawei.com/
> V5 -> V6:
>  - Modify prefix hns3_get into hns3_pmu_get.
>  - Some switch cases return directly.
>  - Modify failed log when io remap failed.
>  - Link: https://lore.kernel.org/linux-arm-kernel/20220426132822.51735-1-huangguangbin2@huawei.com/
> V4 -> V5:
>  - Add COMPILE_TEST and include io-64-nonatomic-hi-lo.h as suggestion of
>    John Garry.
> V3 -> V4:
>  - Modify the comments of John Garry.
>  - Link: https://lore.kernel.org/linux-arm-kernel/20220329113930.37631-1-huangguangbin2@huawei.com/
> V2 -> V3:
>  - Modify the comments of John Garry.
>  - Link: https://lore.kernel.org/linux-arm-kernel/20220228123955.30284-1-huangguangbin2@huawei.com/
> V1 -> V2:
>  - Modify the comments of John Garry.
>  - Link: https://lore.kernel.org/linux-arm-kernel/20220117015222.9617-1-huangguangbin2@huawei.com/
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] drivers/perf: hisi: Add description for HNS3 PMU driver
      https://git.kernel.org/will/c/39915b6b5fc2
[2/2] drivers/perf: hisi: add driver for HNS3 PMU
      https://git.kernel.org/will/c/66637ab137b4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
