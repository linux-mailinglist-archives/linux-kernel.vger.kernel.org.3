Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48864AEB9E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbiBIH7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBIH7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:59:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83290C0613CA;
        Tue,  8 Feb 2022 23:59:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B02EB81F46;
        Wed,  9 Feb 2022 07:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40946C340E7;
        Wed,  9 Feb 2022 07:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644393554;
        bh=o3d1r5nyYz91T6wRpb3Xtl5wpWAZV1OgB32q5ncAlFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6K8ICjNzVwQMg3o/1xmH8e9ryafuMmG/zBsENYkvwq1JaMNJqT82m0RCfmIAcQe4
         VN5pL7WQGMnRtYtzz45d//+LYGaPCF/meyjILIAslS3JOGyuyZ3ZXj0qiwmFX0z20+
         35AG0nLwpfvAH9c3NN0pId8FaPa5IQre1LEolBTNkssvJ6KZjb4g/hIhDRTSC09vwT
         aSrcWXN/p0WsI1rbdwAzuhwyTkLA5Yfj47Lsth2L65pBvPqcsi6n0sbcATz/w3iPdI
         E0FMKUqqk3ZRwNlsIGOZpe4edmBV39Cm+y0WYTsUfVP34lDGRXu4MoV4d+bYKmfD4h
         uPOZG2uck6Wrw==
Date:   Wed, 9 Feb 2022 13:29:08 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Paul Davey <paul.davey@alliedtelesis.co.nz>
Cc:     Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] bus: mhi: Fix MHI on big endian architectures
Message-ID: <20220209075908.GA10700@workstation>
References: <20210812031700.23397-1-paul.davey@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812031700.23397-1-paul.davey@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 03:16:58PM +1200, Paul Davey wrote:
> I encountered some problems getting the MHI driver to work on an Octeon
> 3 platform these seem to all be related to endianness issues.  The modem
> interface appears to require the DMA structures to be in little endian,
> however the MHI core driver was assembling them in native endianness.
> 
> Using little endian explicitly allows the interface to function as
> expected.
> 
> Changes in v4:
>   - add Fixes and Reviewed-By tags as requested/offered.
> Changes in v3:
>   - removed change of doorbell helper functions db_val type from
>     dma_addr_t to __le64 favouring doing conversion only when writing to
>     context wp fields.  
> Changes in v2:
>   - use __fls instead of find_last_bit in pm_state conversion patch as
>     requested by Hemant Kumar <hemantk@codeaurora.org>
> 
> Paul Davey (2):
>   bus: mhi: Fix pm_state conversion to string
>   bus: mhi: Fix MHI DMA structure endianness

I've included these two patches two my MHI endpoint patch series. But I
hope to merge these along with MHI host cleanup patches separately for
v5.18.

Thanks,
Mani

> 
>  drivers/bus/mhi/core/debugfs.c  |  26 +++----
>  drivers/bus/mhi/core/init.c     |  43 ++++++------
>  drivers/bus/mhi/core/internal.h | 119 ++++++++++++++++----------------
>  drivers/bus/mhi/core/main.c     |  22 +++---
>  drivers/bus/mhi/core/pm.c       |   4 +-
>  5 files changed, 109 insertions(+), 105 deletions(-)
> 
> -- 
> 2.32.0
> 
