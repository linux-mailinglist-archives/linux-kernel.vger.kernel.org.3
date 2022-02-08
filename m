Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5834AE520
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiBHW73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiBHW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:59:27 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEF7C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:59:25 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m18so826827lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 14:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItA6TI8Ni0PvSK9MRYCU3UPCNW2YkPVfVW+7WyXcgIY=;
        b=afjxbKw+HzBUlQ3VvuygQbzk9tugRPl9+vCKl+hHOnudj3FtAdcYJm+J0obNuEvQkF
         mMdDm1UwYtIBcQYD+5S69w2LC/oAIIi/zEFuRkTuJXaT25X71WtPXS4N9QxghiI29Zw6
         K2PCvrwgk7c+ntSYrQLtBLuKdljo30Ej3qX5OIQqDw9temAZsjNWDUrOXXTu/gYTG+0B
         4IHqkeQKU0bmSqngH3QnAumzP+5C6EPz0BRZ1WQ8bNcJX8DsOqVPh+foqEjAMVhADIvv
         fJaCY0xTm3hvMswNVpOcc3EIMuqy51gbtJE7qUz4sn7uTHYRZmCOEQWmQZNFkthU435E
         H9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItA6TI8Ni0PvSK9MRYCU3UPCNW2YkPVfVW+7WyXcgIY=;
        b=cJUToYhzLWaDY/k8diAzBwUfwnun9MKEF2otGIMy6A/jNRPfoBnx9xg5H2D+DEQnZH
         c+AXuX5njIgIOUSGs9PVBzkBMD8TM/GkiTjWj1z38hX0Pqy/jJQj6JIEyD+HlKCBaMrl
         mzXaOWPoi+fzTDuYfgkFqoamvObcYrCT7VR4btXtpc8D259EMDatKhuvUqNzb/T1tEHR
         oken1ga89YQpcN7RuTdWkBqlHft4pM+fYvQ5/TxAyPatTWbfvLBlOl5QG9+/DvAZwiV1
         ilP6rsPrRYc5Q6UI+7r4QL9Ikly4xOJHWF64y3hlLKdNBXDXqEGfSfzvWi9UALcy7L6M
         8rQA==
X-Gm-Message-State: AOAM531X0YROoZ3I8m/PNP5WPKVe3QqW8vavwE75DrMUVb70csmHupNt
        64vhNOl82tEQaDECLtDgYUKTUNTnf92l/tZ+A0vnGg==
X-Google-Smtp-Source: ABdhPJzrXjvmHbg4P8xDaIMkX3/azpSsByQPI0FL0T+S/upQWiXIjKfa7421S1XvVu6Ron9ZMXcooOEZEXBDJE9GEbk=
X-Received: by 2002:ac2:43db:: with SMTP id u27mr1290745lfl.651.1644361163719;
 Tue, 08 Feb 2022 14:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20220208225350.1331628-1-keescook@chromium.org> <20220208225350.1331628-2-keescook@chromium.org>
In-Reply-To: <20220208225350.1331628-2-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Feb 2022 14:59:11 -0800
Message-ID: <CAKwvOdm425gzxFbjcq8UmWOiBNV_POYemFgqK9CyZtdyg=Z8Qg@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] fortify: Replace open-coded __gnu_inline attribute
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> Replace open-coded gnu_inline attribute with the normal kernel
> convention for attributes: __gnu_inline

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 53123712bb3b..439aad24ab3b 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -2,7 +2,7 @@
>  #ifndef _LINUX_FORTIFY_STRING_H_
>  #define _LINUX_FORTIFY_STRING_H_
>
> -#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
> +#define __FORTIFY_INLINE extern __always_inline __gnu_inline
>  #define __RENAME(x) __asm__(#x)
>
>  void fortify_panic(const char *name) __noreturn __cold;
> --
> 2.30.2
>
>


-- 
Thanks,
~Nick Desaulniers
