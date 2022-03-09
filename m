Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE274D3D15
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiCIWhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiCIWhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:37:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B91216AD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:36:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so3590550pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FmpTWN4T4djFzifgdW7xTG68jo1eOkFvfiyN6GxfsZU=;
        b=hvIqZw4AKd2bH3e95nicvcqmIukTQbZd40KsnkkiGKvyXtoulo2r1IX23KcexV6U0w
         l0SzLC68k3tXSiVSxOpy8i9Ni2lLvHrobFu+zrbiCY3vYhdAr8zazS8KSa2z9cme58iv
         FEZyhNRCHAZ3F2KVp6dp2VdWY6SLQujdyV3ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FmpTWN4T4djFzifgdW7xTG68jo1eOkFvfiyN6GxfsZU=;
        b=2q27m3c4THdck2aabPQXK2Qsrv8erCT+iRE7IjfzR6zF7avBw8SPEw+J7aByxRy9iV
         By+KQa9tgTdpgCz9cQB9sSEzkS4UkxAtd5H3j6z8RLsVOn2AjLm84JVt6luL1arMz5yR
         a2Y3In4h1Xomevwyo0HG3zLV2BZhqSqPtSo5sdzyopUCyUGYsaqouleeIOml3yNGHwjy
         NliKAWStQyaIdr2hhLOtOGs6pCn2LjWajJiONRJniuDfRmgZXtOz9+uv7kpQ8CKdlIpv
         ObFRIPk2vvECzjsLw3dLjC7w8F2/C0OzTIU6ZG+wyVydPRkxE5K/UXQOETkt1w0vqD00
         n2Iw==
X-Gm-Message-State: AOAM531ubtXDXSmAqKyVQzIpYeZWGySvQevA44ru3v+xymR8M+w61w0h
        mmV2/vmrEzxQpzp0aXcUeLHEdzRYpAttzQ==
X-Google-Smtp-Source: ABdhPJxQitLcXeTLZ1hrDFoJSxWNlyNub5e4cU/hT9gC10JLChMT93GRq2CM3TKzF7PTWN2/xzOEGg==
X-Received: by 2002:a17:902:6903:b0:151:6781:9397 with SMTP id j3-20020a170902690300b0015167819397mr1995753plk.137.1646865376671;
        Wed, 09 Mar 2022 14:36:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w27-20020a637b1b000000b00380437ab89asm3320926pgc.50.2022.03.09.14.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:36:16 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:36:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 09/13] task_work: Decouple TIF_NOTIFY_SIGNAL and task_work
Message-ID: <202203091436.24F9B63B18@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-9-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-9-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:50AM -0600, Eric W. Biederman wrote:
> There are a small handful of reasons besides pending signals that the
> kernel might want to break out of interruptible sleeps.  The flag
> TIF_NOTIFY_SIGNAL and the helpers that set and clear TIF_NOTIFY_SIGNAL
> provide that the infrastructure for breaking out of interruptible
> sleeps and entering the return to user space slow path for those
> cases.
> 
> Expand tracehook_notify_signal inline in it's callers and remove it,
> which makes clear that TIF_NOTIFY_SIGNAL and task_work are separate
> concepts.
> 
> Update the comment on set_notify_signal to more accurately describe
> it's purpose.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
