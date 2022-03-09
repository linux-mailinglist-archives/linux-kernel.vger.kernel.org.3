Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4CA4D3CF5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiCIWcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiCIWcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:32:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294BA121508
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:31:40 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id mm23-20020a17090b359700b001bfceefd8c6so347917pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YtMiAQVcqJmUl2Jhh2s380MpLw79gbxQw+DgAZeoBMg=;
        b=XWeB+Dw/RrmNcxHKbChlu74y1pW1pqOrfrz1WpFM1voJLaeSEq4GQEJjQwWEVesyt7
         g9P6pip4Eu5HBy1ihQXbaxCX6T69Q0tFQKWP8Zw8kOvVnXv9iJZPTOVIw/DO8uUwPHvT
         ovuwHPTLxyIwSpJ9PMl5I5/28oZXyZGVoZ6+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YtMiAQVcqJmUl2Jhh2s380MpLw79gbxQw+DgAZeoBMg=;
        b=MKCxyd5dwI7nEu66ZXICaaSOVIQ5Bvgt709XZDmA+gqj8WwAKqUUUALhYYx9BAiXtd
         CYE21+T5oTzI+2/hbAN503EmxNyzGL0QWZXaxE/psEpoR88g3YqqsbhTeoIn299pPluM
         MKYTN5bWh/bCu3JVTxwRBMZeHqQeK5F8R2Vo1mmn/HkjqXKbIAMX0PXJelq86E2EkAlz
         Vpn2dyT0yUgGAUt1Jnoc5Ozvbaq/ICLOVj/BcB3vLCw+2tebKz2Ui8qaTvgChdIRA/+E
         RviGXQq64ige5qJEoNJRmmp9RlACLUATsChsL68xjVUsCIeUNYlm39S4sq3CocNYnuV6
         mEdA==
X-Gm-Message-State: AOAM5322vRd7r0kRoItVStYCX6G6JH15JuEsfiak8SqflXyvpRVJzlBt
        2CXa1acQwFDKMXmDqVZGX1dIxw==
X-Google-Smtp-Source: ABdhPJxtb0B3Pvp6vpmnto557ZxxRMJrg/fxwhQv/DeXUyBIV4oHiqYxjEsg2faAMMqldvbjBpwRAg==
X-Received: by 2002:a17:903:234c:b0:151:e633:748f with SMTP id c12-20020a170903234c00b00151e633748fmr1879568plh.81.1646865099673;
        Wed, 09 Mar 2022 14:31:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l17-20020a637011000000b0037d5eac87e3sm3207326pgc.18.2022.03.09.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:31:39 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:31:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 07/13] task_work: Introduce task_work_pending
Message-ID: <202203091431.AC8705612@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-7-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:48AM -0600, Eric W. Biederman wrote:
> Wrap the test of task->task_works in a helper function to make
> it clear what is being tested.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
