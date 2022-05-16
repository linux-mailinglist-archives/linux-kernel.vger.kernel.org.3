Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16336529494
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347496AbiEPXCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 19:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbiEPXCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 19:02:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D5F2AFF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 16:01:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id bo5so15356219pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lGx5OaF/nNf+wAk/UXSTp7o/h1yC5nC+cmEZ08o7IyE=;
        b=H6Efosz+U4jL2Q/PRaySKd7X1SckPh/0vK1RwkUKGINiTgldM9LZ6aaqeeIxLJrjyA
         0TyW5rImHO2dZuioVDvS5m2xiA38/mzt0eoPEITqOTx40PddhxtCCtpekYSjT4Dt5eQT
         prIv07wrhhjPwKg9g1h+ACZL2KBo8DGGfraR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lGx5OaF/nNf+wAk/UXSTp7o/h1yC5nC+cmEZ08o7IyE=;
        b=f+avSYjy2552JQ7xSjPNTiYYIz2zFqBYrc2fhuFVkxCFvL8OdDr7t7DB257uf56G79
         4lcVNnzwi4lGg1wEubaWq+G2iwwnFy3tirS7JDwQEvXU6ign62gNSowQuJscIWCQDATJ
         3C1cVNed3P1IycNuW3vIP14I6ybXIatEvetrDU6Nhsd8pNmsJfnPbERoqo5mFWQcG9BJ
         6YYD6SKYHAYSZw1kKuIVYkOy66sGBNXmC3v2Unw0I9dzqYG9Py5iOwfji0UVMNDAzP6v
         1bP9O0SRb6xP51KXx+QVn9THxoI/JCPdITHOYX/t5rsGUYVvVs6rui0w81AvzjU9Blvc
         mhCw==
X-Gm-Message-State: AOAM53340aYDeJVK2a63HGMvns2V+INpyRKb5GIvRralfSZxLeyyYrAM
        9w2rpp4ouzvkrA5bWgZXKQM9Fg==
X-Google-Smtp-Source: ABdhPJxko9JuM1KI2cl8VriIGs+4kOv8T8gQAgbApOgjucLuTCSJVO9OOecJiH06QAjAJNiIJdWiqA==
X-Received: by 2002:a05:6a00:174f:b0:4fd:aed5:b5e4 with SMTP id j15-20020a056a00174f00b004fdaed5b5e4mr19751789pfc.39.1652742118486;
        Mon, 16 May 2022 16:01:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902ea4800b001618f5186f1sm1908968plg.80.2022.05.16.16.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 16:01:58 -0700 (PDT)
Date:   Mon, 16 May 2022 16:01:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib: overflow: Always build 64-bit test cases
Message-ID: <202205161601.14C4F8DF@keescook>
References: <20220511174531.1098548-1-keescook@chromium.org>
 <CAKwvOdkXUiB3T_YkcqDZAkdvN0=cB2NH-i6jj+Y=sL8r9VCJ6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkXUiB3T_YkcqDZAkdvN0=cB2NH-i6jj+Y=sL8r9VCJ6A@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 02:35:45PM -0700, Nick Desaulniers wrote:
> On Wed, May 11, 2022 at 10:45 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > There shouldn't be a reason to not build the 64-bit test cases on 32-bit
> > systems; the types exist there too. Remove the #ifdefs.
> 
> I think this is breaking 32b ARM for clang-13 and older?
> https://github.com/ClangBuiltLinux/linux/issues/1636

Ah-ha, that's the combo I hadn't found. Thank you!

-- 
Kees Cook
