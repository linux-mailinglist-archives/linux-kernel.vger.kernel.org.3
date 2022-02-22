Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA64C028D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiBVT5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbiBVT53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:57:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D1EA8EC8;
        Tue, 22 Feb 2022 11:57:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DFC2B81C64;
        Tue, 22 Feb 2022 19:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95C2C340E8;
        Tue, 22 Feb 2022 19:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645559821;
        bh=IRRUSdLETAOrVQqHjzSOULYJd8z2xUvczM2ffIfQJO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RprbaORm3tXLLYNuyG+hAlHiHwMGMzmWW+64ONeTyE+H7NyvjSA/HfcYkHJIILnfR
         aZ6YA9SRbz7M9HsgSbsHLf7n7Q0wL76LTefx4iKLDhtn4nXSF/cnRzV13lL+uK1arP
         DxS3KPBDDnPhbaD4oogYVGAUhl1Df+HneQYC3Ve0qG/KcSY+j/9N5T0+BV9eLG01CW
         AJd+HRYMHOsC+mg5CvOkr0YTtvhl1BTNNEDhjgu8LvrftkOy+qzWYzmSsM2LIMPKIu
         HAwVdxCdGKOJEvLKb5WnQIS8J5nz3sfagv1oFDXvIC0j9oS8Cn9OmY9J1075Gt+60w
         1PLxYd10AtETA==
Date:   Tue, 22 Feb 2022 11:56:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <YhVACzTEylUg5LJx@sol.localdomain>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-7-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-7-kbusch@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:31:40AM -0800, Keith Busch wrote:
> Hardware specific features may be able to calculate a crc64, so provide
> a framework for drivers to register their implementation. If nothing is
> registered, fallback to the generic table lookup implementation. The
> implementation is modeled after the crct10dif equivalent.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  crypto/Kconfig                  |   9 +++
>  crypto/Makefile                 |   1 +
>  crypto/crc64_rocksoft_generic.c | 104 +++++++++++++++++++++++++
>  include/linux/crc64.h           |   5 ++
>  lib/Kconfig                     |   9 +++
>  lib/Makefile                    |   1 +
>  lib/crc64-rocksoft.c            | 129 ++++++++++++++++++++++++++++++++
>  7 files changed, 258 insertions(+)
>  create mode 100644 crypto/crc64_rocksoft_generic.c
>  create mode 100644 lib/crc64-rocksoft.c

I tried testing this, but I can't because it is missing a self-test:

[    0.736340] alg: No test for crc64-rocksoft (crc64-rocksoft-generic)
[    5.440398] alg: No test for crc64-rocksoft (crc64-rocksoft-pclmul)

All algorithms registered with the crypto API need to have a self-test
(in crypto/testmgr.c).

- Eric
