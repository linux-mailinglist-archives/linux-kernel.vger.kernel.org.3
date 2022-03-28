Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FADD4E9C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiC1Qnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiC1Qnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B193CA6F;
        Mon, 28 Mar 2022 09:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ECEB61490;
        Mon, 28 Mar 2022 16:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EF7C004DD;
        Mon, 28 Mar 2022 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648485727;
        bh=5X3VzaKGXv6wzStW8GD1dizbc3RlHFRryRbv7GAqST8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l4Xqc7G7xuR8Dq5RaxuxUrp1zfwaElk1uPobKgX5pGlX5NTz+g9zq8Q59IWiWmM6H
         vNdc7WuniKq5ERP1hk79CMO4YO0yecuxgBHDH98tFbuSnPH0DXCudAshvpEV+e8aU9
         hhZ2DF0gWLb0ekFKn5e+pMb+k9IMWus10WH8lRARWRPl4VP+NX7BfrOKdwr9FXPeXr
         L3Hzl7L5JMmwqumQYy1PTW7cbmvg4MWRg3tIsZ05I0rqqckO9j3G+HPpXaBO5uD0Rx
         o/wJLFLpEQlWNeowh80GRvR7obxNDjxEAcTAtOG0BvlgcBp0grPpDnNKkOJeEkp8M4
         pL+nKI0WASY1w==
Date:   Mon, 28 Mar 2022 17:49:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] iio:proximity:sx9324: Fix hardware gain read/write
Message-ID: <20220328174944.2c8d3460@jic23-huawei>
In-Reply-To: <CAHp75Ve+SiiAM6VkiwPt95w68KEDk46vXR6ZzjOR7ZgaeZ80HA@mail.gmail.com>
References: <20220318204808.3404542-1-swboyd@chromium.org>
        <CAHp75Ve+SiiAM6VkiwPt95w68KEDk46vXR6ZzjOR7ZgaeZ80HA@mail.gmail.com>
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

On Mon, 28 Mar 2022 01:16:10 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Mar 19, 2022 at 5:58 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > There are four possible gain values according to sx9324_gain_vals[]: 1,
> > 2, 4, and 8. When writing and reading the register the values are off by
> > one. The bits should be set according to this equation:
> >
> >         ilog2(<gain>) + 1
> >
> > so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> > in the register field, etc. Fix up the functions.  
> 
> ...
> 
> > +       *val = 1 << regval;  
> 
> I see it's similar in the original code, but this is still problematic
> from C standard point of view, i.e. if regval = 31, the C standard
> calls it UB (Undefined Behaviour).
> 

I don't see that as a problem as regval is coming from a FIELD_GET() with a 3 bit mask
so we can't hit the UB case (can only be up to 7 - well 6 because of the --)

Jonathan


