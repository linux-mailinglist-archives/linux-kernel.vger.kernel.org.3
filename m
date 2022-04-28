Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADAA512E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbiD1I12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiD1I11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:27:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68C59D4DE;
        Thu, 28 Apr 2022 01:24:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74A0D61F97;
        Thu, 28 Apr 2022 08:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA10C385A0;
        Thu, 28 Apr 2022 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651134252;
        bh=7Qn4QH+TeAmEKVEjCdFVC71kSPqcGYshxtlJcIsHtmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wWlT5w0nDXoBbWDRSYmJ9MTt/Ykz36DoTHIWkhyeVDYGkurfe27rq23L+lpr+3Hlc
         eKeGyJoTE0gLRmJuA3nUNCYtaBGmRI4j87gJa27jrO6FlijfGQEO43Y0nsMbsIGWJl
         DrN9OKf25kTv6t3fdxmZGFQ6AqrrnmkfIVkFaxyk=
Date:   Thu, 28 Apr 2022 10:24:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, quic_psodagud@quicinc.com,
        quic_tsoni@quicinc.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCHv11 6/6] asm-generic/io: Add logging support for MMIO
 accessors
Message-ID: <YmpPKRB6FS/5pKjK@kroah.com>
References: <cover.1645772606.git.quic_saipraka@quicinc.com>
 <3de35c9f4a3a070d197bab499acefc709a6f5336.1645772606.git.quic_saipraka@quicinc.com>
 <YmorayBozWWRlTpP@kroah.com>
 <96dc5e2e-5d88-52ce-c295-779603e668f2@quicinc.com>
 <YmpD3tIQK2iiqt46@kroah.com>
 <CAK8P3a3o7BacAo1fWOLvVxyMrfNV95P1-wUB1t5deLah=nZOwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3o7BacAo1fWOLvVxyMrfNV95P1-wUB1t5deLah=nZOwg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 10:18:36AM +0200, Arnd Bergmann wrote:
> On Thu, Apr 28, 2022 at 9:35 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 28, 2022 at 12:59:13PM +0530, Sai Prakash Ranjan wrote:
> > > On 4/28/2022 11:21 AM, Greg KH wrote:
> > > > On Thu, Apr 28, 2022 at 09:00:13AM +0530, Sai Prakash Ranjan wrote:
> >
> > > -D__NO_FORTIFY, -D__DISABLE_EXPORTS, -DDISABLE_BRANCH_PROFILING".
> >
> > Those are compiler flags that affect gcc, not kernel code functionality.
> 
> It's normal for invasive instrumentation to need flags to disable them. If you
> look at mm/kasan/Makefile, you see
> 
> KASAN_SANITIZE := n
> UBSAN_SANITIZE := n
> KCOV_INSTRUMENT := n
> CC_FLAGS_KASAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
> CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)
> 
> all of which disable one of the instrumentation options, either per file
> or per directory, in order to break recursion.

That's not for logging stuff (which seems to change the functionality of
the driver), it's for system-wide profiling/code-coverage/checking/etc
type of stuff.

Let's keep a #define at the top of the driver for the drivers that
absolutely need this feature disabled as it is much easier to track that
and to see how it affects things.  If you put it in a Makefile,
reviewers will miss it and wonder what is going on.

thanks,

greg k-h
