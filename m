Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC1350A5C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiDUQ3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390712AbiDUQ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E397C21E39;
        Thu, 21 Apr 2022 09:24:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8083E61D0C;
        Thu, 21 Apr 2022 16:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F26FC385A1;
        Thu, 21 Apr 2022 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650558252;
        bh=MOPueyE9NIXkT/ATECPBN+Gv0vBI/El85kaJXW7CqO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fOq2f1GyWMr3IWUctveZ9t7w5wvQ4QLpW5yiWXkYCOaRWZP3YjrFHAC+r1PjLDV8G
         odMkyofTPMJ3AnnqeIkobgzsTkaLuCrus0t6n/ay3PqmdO73Ez3qAw5cF3xFx34lcC
         pqggJa+Mlzj6KNAnP4H+EicvPKzCGz/7yPoLy/Bc=
Date:   Thu, 21 Apr 2022 18:24:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     heikki.krogerus@linux.intel.com, nathan@kernel.org,
        ndesaulniers@google.com, sven@svenpeter.dev, alyssa@rosenzweig.io,
        marcan@marcan.st, martink@posteo.de, saranya.gopal@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] usb: typec: tipd: improve handling of failures in
 interrupt handlers
Message-ID: <YmGFKdVAuG5JEfzg@kroah.com>
References: <20220409130013.1474412-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409130013.1474412-1-trix@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 09:00:13AM -0400, Tom Rix wrote:
> clang static analysis reports this representative issue
> core.c:516:6: warning: Branch condition evaluates
>   to a garbage value
>   if (event)
>       ^~~~~
> 
> In cd321x_interrupt(), a successful call to
> tps6598x_read64() is the only way event is set,
> and if a failure happens the irq should not be
> reported as handled.

Please use the full 72 columns.

> 
> Instead of initializing event, rework the
> usage of ret by initializing it to IRQ_NONE
> and then setting it when event is known to
> be not zero.  This removes the if-statement
> before the return.

So the code today is correct, but clang is wrong?  We don't need to do
anything then...

> tps6598x_interrupt() is similar.

This line makes no sense, sorry.

greg k-h
