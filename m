Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D864BFF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbiBVQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiBVQ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:56:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D66616BF8C;
        Tue, 22 Feb 2022 08:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A187B81B7C;
        Tue, 22 Feb 2022 16:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEC3C340F1;
        Tue, 22 Feb 2022 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645548975;
        bh=XMbNZ4Yp3pB5CJy39MFuU7DbDGAoq3fnEia6T+9MnuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHZa6HWm+aag/twDn8vXkbA3dW4OCEZh7yQ/XwHoIWj/Srx/UQcevPHhwAukvOxDJ
         mBlnC2442ILKmdamqHIfIUyU6/oW+K2HWJKOYtUQpUe7ZDiCtMODNt+o6LspCMxnbU
         Jm5N0YkFuFoVEu+u5A4IEETNv7F2AxIg4sXnkGuPpywcKZewYHf9r6mrGJLfhrKgzq
         UuE9+yCTjGM2RbRReFJLQ9mu9qyBC9c0N77xeb06xg4ezId+2Hk+CPehprGB678O31
         4/Lv+MkxKo9pEpgdGult5zkQj3XAQnXoGmSVaEdz9x2wzp0shXBRalF66xuy5qb7Wv
         kZlbQ8b5DsEYQ==
Date:   Tue, 22 Feb 2022 08:56:13 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joe Perches <joe@perches.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, colyli@suse.de,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Message-ID: <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
 <20220222165045.GA14168@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222165045.GA14168@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 05:50:45PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> > On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > > +/**
> > > + * lower_48_bits - return bits 0-47 of a number
> > > + * @n: the number we're accessing
> > > + */
> > > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> > 
> > why not make this a static inline function?
> 
> Agreed.

Sure, that sounds good to me. I only did it this way to match the
existing local convention, but I personally prefer the inline function
too. 
