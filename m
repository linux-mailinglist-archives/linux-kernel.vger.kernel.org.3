Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B341B512D83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiD1H73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbiD1H71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:59:27 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E505F26B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:56:14 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C5365452; Thu, 28 Apr 2022 09:56:11 +0200 (CEST)
Date:   Thu, 28 Apr 2022 09:56:10 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        jon.grimm@amd.com, wei.huang2@amd.com, terry.bowman@amd.com
Subject: Re: [PATCH] iommu/amd: Do not call sleep while holding spinlock
Message-ID: <YmpImoyEN5f6pvnl@8bytes.org>
References: <20220314024321.37411-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314024321.37411-1-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 09:43:21PM -0500, Suravee Suthikulpanit wrote:
> Smatch static checker warns:
> 	drivers/iommu/amd/iommu_v2.c:133 free_device_state()
> 	warn: sleeping in atomic context
> 
> Fixes by storing the list of struct device_state in a temporary
> list, and then free the memory after releasing the spinlock.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: dc6a709e5123 ("iommu/amd: Improve amd_iommu_v2_exit()")
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu_v2.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied, thanks Suravee.

