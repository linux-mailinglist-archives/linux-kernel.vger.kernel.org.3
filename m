Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6DE4D3CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiCIWaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbiCIWaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:30:07 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4450120EB8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:29:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n2so3221804plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S2mqitR+6+seBnK4mF+GbsCg8piisX4jMlIp8/6TlMo=;
        b=FS1Jd8icwEmHQD1R9Cf2KytIbxAgUj08E060zxYiAc8v4c0uEXmZ/Bcq22FyxE7bRr
         GNL1uIZ7SEg311+XwtAI8BJ8HNIAwDaaeR3dX3ghLYm7dwvaGHHHl0mLzk4H1YC/X28t
         W+Lz3O5fch943Y4QpW85QoCCbBCCle+ZdE9Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S2mqitR+6+seBnK4mF+GbsCg8piisX4jMlIp8/6TlMo=;
        b=Qljk5QyBosa7bw9qWEOHmOjMQ0q4Sl1oXFjT8x4XHSSZtBrU4LVRpHRV785oV9qYqF
         6ip3HkK258dCfXzYBzlXG/q5lbb1ocNUknF1Hh2vH3dw1ZqZ2rqrqPWi2jNTpBzyw0S0
         XTJYLtOAVYB9bsSQatSw+NrN2vR01dyYkKph/Yq0qCP6Gt1WYVeOhk/CcVPg6Qkx+I26
         RksPgYiKEV9SAU9SR2u0iG2o7mgkhGiFOUwF/cOTHzJuYEjAnd1ejmDg4MkkhaDYQdQM
         p2xWZ9FJYhf9cnpwuYkWnlEEsFNcbzsHzEifQJ9kkxN7sIPK9qLlTuql45nPV+YvvrrP
         U6aw==
X-Gm-Message-State: AOAM5304XCneApbvAHgSy1DzNpbKyeeYrCRWqzPwqith1yEKZYK8y7IB
        vtPPHZv+VaOyl7GrFEGDKbnxUQ==
X-Google-Smtp-Source: ABdhPJxQ0VJ1nsc26FC2IVQBnsWu9B36wHneIBVVf37NWL7QTG/Lew09RqwF5nD3NrzcueHBd5ctZQ==
X-Received: by 2002:a17:902:d2ce:b0:151:6781:affa with SMTP id n14-20020a170902d2ce00b001516781affamr1710269plc.168.1646864948350;
        Wed, 09 Mar 2022 14:29:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id kk5-20020a17090b4a0500b001bf527073besm7953825pjb.10.2022.03.09.14.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:29:08 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:29:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 04/13] ptrace: Remove arch_syscall_{enter,exit}_tracehook
Message-ID: <202203091428.4441E0F@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-4-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-4-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:45AM -0600, Eric W. Biederman wrote:
> These functions are alwasy one-to-one wrappers around
> ptrace_report_syscall_entry and ptrace_report_syscall_exit.
> So directly call the functions they are wrapping instead.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/entry-common.h | 43 ++----------------------------------
>  kernel/entry/common.c        |  4 ++--
>  2 files changed, 4 insertions(+), 43 deletions(-)

nit: This should maybe talk about how this is just removing needless
indirection in the common entry code?

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
