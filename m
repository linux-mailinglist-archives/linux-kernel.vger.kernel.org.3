Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C47950CA99
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiDWNaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiDWN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:29:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36360060;
        Sat, 23 Apr 2022 06:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A7E0B80AD4;
        Sat, 23 Apr 2022 13:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F43C385A5;
        Sat, 23 Apr 2022 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650720388;
        bh=vZepI/YrdkIUFcAgba62MT7KAC51SG3flI+XjUdGxRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ivQiMhs4BxbWKlILamBe7PSi0gj0SsBCKwlJfC7AxyfULzM+tEQOn431tYSHfKYmf
         YwqUOnXQqjfjlteva+DXzkeG8sEKGQCfq3qYKKarMFxOV0uP5wiGlQtcmbVxcHTU/x
         PBfW/Xt86yNFS5SnVyu0nwKu9xj2onlbqGOwUwY1FpE1CEXdrnCqYfevlIIB1g3gLS
         /NRs0wWQr+KPTeWXCJlXVJKsHHnPH2ATA39IsOcEQw/bbvb3QkbS1dV0OmY1Z/6ytI
         0diu1QfUJ9c8+yCn2aD+B/HGk+g0y3EWOHPGtVVsg7cwOSikSSqy0YL56TPDzov0yA
         ZDVGBIKEZ7asg==
Date:   Sat, 23 Apr 2022 18:56:20 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] MHI MMIO register write updates
Message-ID: <20220423132620.GO374560@thinkpad>
References: <1650304226-11080-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650304226-11080-1-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 11:50:24AM -0600, Jeffrey Hugo wrote:
> In case of MHI MMIO writes, the register field write function needs to do reads
> before writes are performed. Propagate read failures such that callers are made
> aware of those and can take appropriate action instead of running blind.
> 
> Optimizing the MMIO initialization function to use mhi_write_reg() in most cases
> should also be done to improve design.
> 
> These patches were tested on X86_64 architecture with Ubuntu 18.04 and SDX65
> attach.
> 
> v4:
> Address review comments about log messages, and a missing blank line
> 
> v3:
> Noticed this was reviewed but never picked up.  Rebased to -next
> 
> v2:
> -Fix testbot reported missing set of changes from pm.c
> 
> Bhaumik Bhatt (2):
>   bus: mhi: host: Bail on writing register fields if read fails
>   bus: mhi: host: Optimize and update MMIO register write method

Series applied to mhi-next!

Thanks,
Mani

> 
>  drivers/bus/mhi/host/boot.c     | 22 +++++++++----
>  drivers/bus/mhi/host/init.c     | 68 ++++++++++++++++++++++++-----------------
>  drivers/bus/mhi/host/internal.h |  7 +++--
>  drivers/bus/mhi/host/main.c     |  9 ++++--
>  drivers/bus/mhi/host/pm.c       | 15 ++++++---
>  5 files changed, 77 insertions(+), 44 deletions(-)
> 
> -- 
> 2.7.4
> 
