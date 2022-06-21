Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96425552907
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 03:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbiFUBez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 21:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241851AbiFUBew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:34:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64FB1CB05
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:34:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso11837462pjh.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6M/ZhaRuzHnYTsbLAHxqSo2bbqSy9U78hF/+QR70dfM=;
        b=I4p1IoYpmElC76cUbkKYkXQp7StJJvKWulMtJXa3/U22d3MGiMYEMC4om0avJO2NBg
         e3zYCb4Yuy8hAfU1jf88nzRMBEOhqaWj0Ps+nUecHS/POBjS2iyXIYti8YvxQZSxdzAq
         tr09knmwxtqoZq8MBuppZKtnsv68hYVil8e+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6M/ZhaRuzHnYTsbLAHxqSo2bbqSy9U78hF/+QR70dfM=;
        b=wOcJq4gwbU7e580aPEs46BM773m/p2AhCBR87GMuyLzpKaB6XdF8ZF/rF0Hfzgglnq
         xzy/RkTjcKSst2er7vO5WlQSYqipbQOb+sTydoPFtY7fjsx0JkJHo2DEnFIgpekOtU/Q
         yXPj9gy0vXJ6nshXjJoZJKnQwBM/4jofNvu3N0Sil6XLpTbMCJnHHppzDljyt3h2yBeg
         ljAmzWcNr9DcM2vCgFy9x7dPDYVl1DB9hKIw5Wdi5oGBapLHIMXsXVm15rsNfZnhvGVc
         SP6V5hCtXsdZmutTxNycEwICHjsGdi2yTTRJFRv73lF/fqZZtiVP5ajh2XNMRFEW6mQK
         UAPg==
X-Gm-Message-State: AJIora+mj4a/C94Q4eWqQ3kDKx4VKII8iBA5InDfqb1/yZLPs61smYmf
        9UvnWiUZXz0Rowxy8O/6kfSqVQ==
X-Google-Smtp-Source: AGRyM1vwU+lMYxxaYlm2sO1rDi+geZDAyG9CrzcsVKmcuq2m+AJXZO0TbCwJSixRgWeF5Bj1xgn55w==
X-Received: by 2002:a17:902:8bc1:b0:16a:187c:8719 with SMTP id r1-20020a1709028bc100b0016a187c8719mr12102666plo.43.1655775290268;
        Mon, 20 Jun 2022 18:34:50 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4012:70a7:9cd6:3db5])
        by smtp.gmail.com with ESMTPSA id p9-20020a62b809000000b0051c79bd5047sm9747933pfe.139.2022.06.20.18.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 18:34:49 -0700 (PDT)
Date:   Tue, 21 Jun 2022 10:34:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] printk: allow direct console printing to be enabled
 always
Message-ID: <YrEgNX/3VLlO1DHH@google.com>
References: <Yq+Jjoyn/wj7yzeQ@zx2c4.com>
 <20220619204326.556923-1-Jason@zx2c4.com>
 <87letsw8en.fsf@jogness.linutronix.de>
 <YrAC8F8lDc1JNkoq@google.com>
 <YrAoP+UVAKsLlnQQ@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrAoP+UVAKsLlnQQ@zx2c4.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/20 09:56), Jason A. Donenfeld wrote:
> > > Otherwise it looks OK to me. But you may want to wait on a response from
> > > Petr, Sergey, or Steven before sending a v3. You are adding a kernel
> > > config and a boot argument. Both of these are sensitive topics that
> > > require more feedback from others.
> > 
> > A tricky situation. I think John already mentioned in another thread
> > that any such config/boot param potentially can become a default value
> > for some setups; at the same time, well, yeah, I see what commit message
> > talks about.
> 
> Moving it into the debug section of kconfig hopefully sends the right
> message there. Plus the help text makes it clear there are performance
> implications and such.

No objections from me.
