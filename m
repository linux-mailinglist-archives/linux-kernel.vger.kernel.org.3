Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B051DD0D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443556AbiEFQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443554AbiEFQL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:11:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFE03B026
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:07:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30856CE372E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9ADC385AC;
        Fri,  6 May 2022 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651853243;
        bh=0P7/WGJCYHt435lwImIJcvUvwlWu+QHXkyE1lQQbags=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKyJZZCmEzRQ4LARqny8I4XWojwmowD0nj/y5A2VC5LR/gplATsWWXhGKYnGBSRft
         kKfJRL3x24JUfZ+g142St1pIMb2msv8PFvo6B77rtWgtA1LHLynlOHPH0AlcY7cWfV
         IxVihBnan1xn6/8+nixYw5ENw4+0zAmY2QPfcHF8mzPq47SJ6OdedwZC5wcNL+1Kml
         uTb1ZEx/F1hYLeziEjfGxVMxJgDDkVrHrjrunQaxjFM+mV7sN6KV5Rx3oXGqJR7mkc
         s4SNDhvOi2ZhluJq4JLvkWL1I0Pi3qwyIt4ot8yWl1K9zuhH8xhODFTAyWUSJN306U
         ZrAjP8NTChY+A==
From:   Will Deacon <will@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, robin.murphy@arm.com,
        joro@8bytes.org
Subject: Re: [PATCH] iommu/arm-smmu: fix possible null-ptr-deref in arm_smmu_device_probe()
Date:   Fri,  6 May 2022 17:07:05 +0100
Message-Id: <165185066572.2780646.1953515178264833558.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220425114136.2649310-1-yangyingliang@huawei.com>
References: <20220425114136.2649310-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 19:41:36 +0800, Yang Yingliang wrote:
> It will cause null-ptr-deref when using 'res', if platform_get_resource()
> returns NULL, so move using 'res' after devm_ioremap_resource() that
> will check it to avoid null-ptr-deref.
> And use devm_platform_get_and_ioremap_resource() to simplify code.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: fix possible null-ptr-deref in arm_smmu_device_probe()
      https://git.kernel.org/will/c/d9ed8af1dee3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
