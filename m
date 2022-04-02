Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77DA4F0508
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358384AbiDBQpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358372AbiDBQpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:45:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB27F1AF3D;
        Sat,  2 Apr 2022 09:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58721B80A27;
        Sat,  2 Apr 2022 16:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAEEC340F2;
        Sat,  2 Apr 2022 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648917829;
        bh=HL5ErD+PNC54BIsnAcEv8+1ZhI/4B9+Tha0CXuwWvg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZbylgVab8HyjN7gPZNVlQDJjJ8LU7lOLdJv06UIkBC9LH7qM5Zkua4APb3g4Sbo+1
         +qrWrJl+mF3NnwitsoJFXaAySj1MQQdsAI3W7DC5MNpnkmP4QQDdutGOAsKJv7gSHi
         5woLn4CRn14k6JM38GFaUwCcgIEZ5iMxD6cfb3dipuCFmr3myn2nmbSO9mgAVP/o+E
         +R/eaPBjeEwVrIzHZSKE3Xzsr9qAvCkvvDyusKy3hmV+qZjq7c3tqnJOp0EZvuvdYO
         UjAZhv16YRil6dr2GihTY73Y190nVe4KYCHkev/F1wMYdgRbBtNxavQxmK2rPwWjCG
         EquiA8+wDgvLg==
Date:   Sat, 2 Apr 2022 17:51:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v2] iio:proximity:sx9324: Fix hardware gain read/write
Message-ID: <20220402175131.75bb95de@jic23-huawei>
In-Reply-To: <CAE-0n50T9uqcB9EK-RnGXPGhd6RWdrsE9pA5FJY9yC58xd=05A@mail.gmail.com>
References: <20220324222928.874522-1-swboyd@chromium.org>
        <20220327155147.52e898b4@jic23-huawei>
        <CAE-0n50T9uqcB9EK-RnGXPGhd6RWdrsE9pA5FJY9yC58xd=05A@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 22:25:31 +0200
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Jonathan Cameron (2022-03-27 07:51:47)
> > On Thu, 24 Mar 2022 15:29:28 -0700
> > Stephen Boyd <swboyd@chromium.org> wrote:
> >  
> > > There are four possible gain values according to 'sx9324_gain_vals[]':
> > >
> > >       1, 2, 4, and 8
> > >
> > > The values are off by one when writing and reading the register. The
> > > bits should be set according to this equation:
> > >
> > >       ilog2(<gain>) + 1
> > >
> > > so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> > > in the register field, etc  
> >
> > Example seems wrong...
> >
> > ilog2(8) + 1 = 3 + 1 = 0x4
> > ilog2(4) + 1 = 2 + 1 = 0x3
> > ilog2(2) + 1 = 1 + 1 = 0x2
> > ilog2(1) + 1 = 0 + 1 = 0x1
> >                        0x0 reserved.
> >
> > or have I misunderstood?  
> 
> Nope. I hit the wrong key but your table is correct. Can you fix it when
> applying?

Done and applied to the fixes-togreg branch of iio.git but I haven't pushed
it out yet as I want to rebase that tree on rc1 when it comes out.

After that, please take a quick look check I didn't mess up.

Thanks,

Jonathan
