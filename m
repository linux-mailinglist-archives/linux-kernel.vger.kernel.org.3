Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332894B7982
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbiBOU6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:58:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiBOU6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:58:47 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F927FE2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:58:36 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so93024ooa.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5a/x3EJavPanZMZjjHQuhtSqRRw7tRmuA9y5WkmF/+k=;
        b=XA8VgW55ty5IpGeDK6Vzu8dPwy0r6ikLvR+GeTgZMQgjM6+GqLUSF27l+SDKbSiIjo
         vbmfyga7mb6xzawblwN/+KYsNKXsYT9YsCRhvGRoNYcoTT213kkkqZQN6Y0uAw4ByKlh
         o0/MfrY7EdPTzNtPh8acoiFtnfe/xqmNyG8Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5a/x3EJavPanZMZjjHQuhtSqRRw7tRmuA9y5WkmF/+k=;
        b=HlAX+316rkm1ix5GWTlZzDNlhVYFTLnfxQPw9+jY1Jbo7FWwipTkGx/opmQ3cyxHxp
         CUt17zOMwq5kwtxSOSACpPUuPVzmluXG8tX2qHf0faX6pYB3R1jzQofb7SkrcFok3tfp
         Px8rcDaD7Or/H1U+rPrkU2Fz/p3/bPawo6yQM/lCqZNKXE3QmF9x6ZA47mVa7RjF5lZ4
         SON1n2Ca1CsR6X5+jFX8PqqjKO/8TxJVXlrCehRu+sk8iOdlqYRa1feLN5q6VhXsWyCr
         2VPxHQ6sIXCBS72S3gL0nYoZ1maZBQGcw2HXb71R50Oi83E1snww5w3i/f2LljKatxRV
         toog==
X-Gm-Message-State: AOAM531iCHs0alRnG3ll269MMmTGZzibohYgN/0aLRxRKi/ktRM9Aqfu
        At0szAO/GN0Zx0D8nWw2bzo9/A==
X-Google-Smtp-Source: ABdhPJwAZKcNRIrTVH75KyUp18uzB/TIylfFk2VoBD8kUxZAJV2MNFjuPFxTFDIbk4Up7UwzslCi6w==
X-Received: by 2002:a05:6870:8c2f:: with SMTP id ec47mr339909oab.117.1644958716083;
        Tue, 15 Feb 2022 12:58:36 -0800 (PST)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id y1sm16998142oad.38.2022.02.15.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:58:35 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:58:33 -0600
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tools: Fix use-after-free for realloc(..., 0)
Message-ID: <YgwT+WEjZS3bfnS7@fedora64.linuxtx.org>
References: <20220213182443.4037039-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220213182443.4037039-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 10:24:43AM -0800, Kees Cook wrote:
> GCC 12 was correctly reporting a potential use-after-free condition in
> the xrealloc helper. Fix the warning by avoiding an implicit "free(ptr)"
> when size == 0:
> 
> In file included from help.c:12:
> In function 'xrealloc',
>     inlined from 'add_cmdname' at help.c:24:2: subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
>    56 |                 ret = realloc(ptr, size);
>       |                       ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret = realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
>    58 |                         ret = realloc(ptr, 1);
>       |                               ^~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret = realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> 
> Reported-by: "Valdis Klētnieks" <valdis.kletnieks@vt.edu>
> Fixes: 2f4ce5ec1d44 ("perf tools: Finalize subcmd independence")
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested this patch with the Fedora rawhide builds, and this does indeed
fix the issue.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
