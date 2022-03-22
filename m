Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1EA4E37DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiCVESc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiCVES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:18:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5EAE09D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:17:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d76so2464894pga.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1SX7VG7pcFZQTL6ghZ/zYF6sS4uvEZ0uS9Ptdb4LiaQ=;
        b=UYRR7DOJp+47629aFz0Vdy2LnsEHUTiyqbRnOeLHCm/tpXSA3Fl58WaYTxmuPMqD+M
         9/TJ+vj1PSdG9oX0jFzKLOOJ+CPj1Nyx2iZ6KYzYleGNoAOegMo/WhQfwuNDeiwcsZ8g
         2X8Fj+beFHqamZYWsKxa4waCD/QqE3MUFY36k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1SX7VG7pcFZQTL6ghZ/zYF6sS4uvEZ0uS9Ptdb4LiaQ=;
        b=FDcNmy8Rdm4bCFRIx0YdZemesgzbp6PtaMI5Sok13zK8XiwSKAorQOZDp8mBk+SDyq
         Qxx3RgdjbPNRsJje8CfOXpCKZ9AkYxP1imfbl6Fk3fKxajngYWmTVqoHnqBWKp82bDKC
         QWq/y4dN6nxDyHScr9rXSExtS0tQVCcHLNHixvuavLf8cXvMz0NCTwvkgg7u6EX8yzE/
         VdlC3H+Zt9H9qagBsqxH1AhUVwYuwAeYh8Ey+G0zuMkuakX03Dzi2nLB5T91bhwvKUJc
         KntRPaVLKdDduzOKklozUJe9KqrmXP+XP8joM5oXX5cYtI070Ww4YHrKSAe8+06KgKEX
         1J6g==
X-Gm-Message-State: AOAM533/FSJO+vXu/oRg8SpP5urr0Rjz5FMj6Dc8GQyVLYEqmDnKPnH/
        kvCM8jCjvBwpyxPL8E3ha+5BYA==
X-Google-Smtp-Source: ABdhPJxs0Y5O8LkJlXrrvhdEL8fgYGIzetMPjEFGIwlWa/F8vit8lWjvms4F/1c+Dv7cFyN0kigQGA==
X-Received: by 2002:a63:5024:0:b0:380:83f7:1603 with SMTP id e36-20020a635024000000b0038083f71603mr20118067pgb.289.1647922621067;
        Mon, 21 Mar 2022 21:17:01 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:51af:6dff:4acd:7fa5])
        by smtp.gmail.com with ESMTPSA id j14-20020a056a00174e00b004f776098715sm22006057pfc.68.2022.03.21.21.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 21:17:00 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:16:54 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v5 12/20] vsprintf: add new `%pA` format specifier
Message-ID: <YjlNtkNP1FJ4XEyX@google.com>
References: <20220317181032.15436-1-ojeda@kernel.org>
 <20220317181032.15436-13-ojeda@kernel.org>
 <YjSSI4cmGblm+6j7@smile.fi.intel.com>
 <YjStnb7nNTC3kYw6@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjStnb7nNTC3kYw6@alley>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/03/18 17:04), Petr Mladek wrote:
> On Fri 2022-03-18 16:07:31, Andy Shevchenko wrote:
> > On Thu, Mar 17, 2022 at 07:10:00PM +0100, Miguel Ojeda wrote:
> > > From: Gary Guo <gary@garyguo.net>
> > > +	case 'A':
> > > +		if (!IS_ENABLED(CONFIG_RUST)) {
> > > +			WARN_ONCE(1, "Please remove %%pA from non-Rust code\n");
> > > +			return error_string(buf, end, "(%pA?)", spec);
> > > +		}
> > 
> > I'm wondering if the Big Scary Banner as trace_printk() does would be better
> > (in case we can tell that %pA is used in the code when RUST=n).
> 
> Good question!
> 
> The advantage of WARN_ONCE() is that it shows the stack so that it is
> easier to locate the caller.
> 
> On the other hand, WARN_ONCE() is a bit misused here. It should be
> used only in situations that might be potentially fatal. It might
> even cause panic() with "panic_on_warn" kernel parameter.

Stack trace is certainly helpful here. So maybe dump_stack() instead
of WARN_ONCE()? I guess I don't mind WARN_ONCE().
