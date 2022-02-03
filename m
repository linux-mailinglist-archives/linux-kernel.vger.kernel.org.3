Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1944A8CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353902AbiBCT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiBCT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:57:48 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66DC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:57:48 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v3so3177733pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cGaByQ8siwOwFo3H6XR9VUUbom/VIgqp9w81CSI2uiw=;
        b=T92D31tAA5MiwOX/9m3Jeiumqwj0pecFkTk6CBukk20nvgu17OaKXN1AFtvgv57EKK
         jq70zxVaT7TPIB4Bc5IfKaIOWLzMDOYLs5SbK3iI9pc2pBwVHPciHGucPx4g5p7kADlq
         kbnX2qlS2n2xDOjJdk6xX/3F428RmLokW3rrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cGaByQ8siwOwFo3H6XR9VUUbom/VIgqp9w81CSI2uiw=;
        b=l/VpUGV9m8QCFBy0u1L4hCleQNfqUOpZm6mY8ZDRdGShFj+3F2uC23ydHYxKVaMvUr
         I2BEThlY47HvNClzhIChcENVlQIveMkss8Gb7NrXrKxtaXZAl+5eawAacx9XKHiD+Yqg
         AQPC3vuNZ/Mzu9n7234BHKqtxFkB4F2xAwgZY5/Df0apmdCIAVs0mKJnsSKfjoDbx2SM
         g+sMOU3BzDx9NCwd1h1WeoXTSEuHVYGpraX8/d4OO4APOHS38B8QZMtdjE1wfVNqbVeC
         rbmvejgMDEydCwaWEI6MfOfcfiqmFuUiFEJCbrLuJPMUwk1nGFqIkUUL2Mmf+z1JI6Sp
         e9ZA==
X-Gm-Message-State: AOAM530cKZwv4QqAPf994ySGh5osFGcvsxBoTg/EHcGmbD5EOj7nMBJd
        3HLPZm9jIYdigRQXjF3IOVo2zg==
X-Google-Smtp-Source: ABdhPJzbNSRl7D+yCCPxB+1tEd531BtF9DNUrQKCK6weQRbjWpzkV6o1fNMvnURTVpjTcfO9QN+K6A==
X-Received: by 2002:a63:d80b:: with SMTP id b11mr16714952pgh.189.1643918267952;
        Thu, 03 Feb 2022 11:57:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ck21sm10231314pjb.51.2022.02.03.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 11:57:47 -0800 (PST)
Date:   Thu, 3 Feb 2022 11:57:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 0/4] fortify: Add Clang support
Message-ID: <202202031157.E18FA7BAC@keescook>
References: <20220203173307.1033257-1-keescook@chromium.org>
 <CANiq72mnF5qxfHGoDmvueMY7n2us9ZtA-u3igCJ+QjcbfKMP=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mnF5qxfHGoDmvueMY7n2us9ZtA-u3igCJ+QjcbfKMP=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 06:47:01PM +0100, Miguel Ojeda wrote:
> On Thu, Feb 3, 2022 at 6:33 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > This has been updated from feedback on the v5 series. Builds correctly with Clang 12.0.1
> > too now. :)
> 
> Looks fine to me! Thanks for the changes. I assume you are taking these, so:
> 
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Thanks! Does this tag apply to the fortify-string.h patch as well?

-Kees

-- 
Kees Cook
