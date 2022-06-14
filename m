Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9B54BCBB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352207AbiFNVYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiFNVYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:24:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3801C50B2D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:24:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E69DEB81B79
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 21:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC62C3411F;
        Tue, 14 Jun 2022 21:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655241877;
        bh=+RQt2hOB9p4fUSoPh40Dqnoes2869OaWZvlo4exv6xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nfej7XUtOHMw+HnL1NzLJn6B2Nn0wHFAIuXqxQ/+ARRKo2U7dskcFH1CbYkSlWr6t
         UyNC4lrz3IABFlUOnIc9u8h3lYhMKjhH2plPGDFsE49TGuVfmxkGB1U5kTspPPD1s7
         ffEf97WR26vUOcpaM4BtrbKRdainAFRb+WFeCU24KTwKhn2sKbqbT1J7GAi8zNf+pw
         diQRmBrAMFAI1FIkvXOx+iGwrwG3WYEWz/1eEzl6uXHx2VBFgcVkOJTmySLNjF4GFl
         +JLS/UnPx6PqYammuaBGJ6df6w30b0z4Y7/VCT06mWzIsnpe+D7lXo6gAFABO9fJ9W
         mzwKwKclXIAVg==
Date:   Tue, 14 Jun 2022 14:24:34 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Erwan Velu <erwanaliasr1@gmail.com>
Cc:     Erwan Velu <e.velu@criteo.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] nvme: Ensure char members of struct nvme_id_ctrl are
 null-terminated
Message-ID: <Yqj8kkqwb1JA3qBe@kbusch-mbp.dhcp.thefacebook.com>
References: <20220614210902.744318-1-e.velu@criteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614210902.744318-1-e.velu@criteo.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:09:01PM +0200, Erwan Velu wrote:
> +	else {
> +		/* Ensure that model, serial and firmware fields are always null-terminated */
> +		(*id)->mn[sizeof((*id)->mn)-1] = 0;
> +		(*id)->sn[sizeof((*id)->sn)-1] = 0;
> +		(*id)->fr[sizeof((*id)->fr)-1] = 0;
> +	}

But the last byte here is owned by the controller. You may be truncating
information.
