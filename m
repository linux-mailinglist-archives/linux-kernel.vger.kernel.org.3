Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084CD513077
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiD1Jw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348882AbiD1JmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:42:19 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D4D972B8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:39:05 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 46ED12FB; Thu, 28 Apr 2022 11:39:04 +0200 (CEST)
Date:   Thu, 28 Apr 2022 11:39:03 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        will@kernel.org, alyssa@rosenzweig.io, sven@svenpeter.dev
Subject: Re: [PATCH] iommu/dart: check return value after calling
 platform_get_resource()
Message-ID: <Ympgt+2G8fXD1w5H@8bytes.org>
References: <20220425090826.2532165-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425090826.2532165-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 05:08:26PM +0800, Yang Yingliang wrote:
> It will cause null-ptr-deref in resource_size(), if platform_get_resource()
> returns NULL, move calling resource_size() after devm_ioremap_resource() that
> will check 'res' to avoid null-ptr-deref.
> And use devm_platform_get_and_ioremap_resource() to simplify code.
> 
> Fixes: 46d1fb072e76 ("iommu/dart: Add DART iommu driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/iommu/apple-dart.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Applied to iommu/fixes, thanks.
