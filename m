Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D723C5962C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbiHPS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiHPS7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A8480E86
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B55061453
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34836C433C1;
        Tue, 16 Aug 2022 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660676392;
        bh=Ho0zP0tjQ5vo8CvRRj/Yp9BYqpgN6hZxTc9hBSwpJt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLAqWpKFE7/Q2xz/1RM36PQ4Ky8Xy+Emnh7gYOfh0g17UUUTfh/vXcXyCn9AmOK03
         3IHEeCROFVguFxE86RLvqtz0ai7XTbNSGjdNEfJ6LZ/9H/ZkXZAYMxMwCItAbl2OTs
         40YliqLfzFWAUiK/goTrz/t1GK0Olca8tmKSQWUL1RO5gnCpAPavrNYb354vQFPCGt
         cVk+LQCC+sZxMPaCf9uBB4YwuSmBQMYvmKxdUQXdJ9qgycHLjJCbwBwoUUkXHSaV93
         r1syMAyXciFHW6mWf0otMqp0LHItGSVDjSDzX17ueCyQNApgnPMfdepEmP2xLoW2Yr
         iZUmhwDOc+rtw==
Date:   Tue, 16 Aug 2022 12:59:49 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Message-ID: <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816091808.23236-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:18:08AM +0200, Fabio M. De Francesco wrote:
> 
> Therefore, I have two questions: am I right about thinking that the pages
> mapped in nvmet_tcp_map_pdu_iovec() are allocated with GFP_KERNEL? 

I think you are correct.

> If so, can anyone with more knowledge than mine please say if my changes make
> any sense?

I think it does make sense. I like the code simplification, though this use
was't really paying the kmap penalty since, as you mentioned, this is never
highmem.

You should also remove the cmd's 'nr_mapped' field while you're at it,
otherwise you'll hit the WARN in nvmet_tcp_free_cmd_buffers().
