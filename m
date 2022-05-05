Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFFF51CCDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiEEXuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbiEEXuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:50:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623426006F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:46:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e24so5579255pjt.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yw+RudC9dXxTNyd08I4c9F1iC0vSj71b4807D2ENyg0=;
        b=NZAdUq3eQkkEjioMnYxo2p6HTLdc/+/uV5EUpuUkngcU5zaHoGzgoDh3jXbhde867e
         UMnDJVg7wIwGVpLgqEz2YzgYdN2MD594I7oMqa7ywLBIBUc1Pg2RtYUCI3YDpoBfilJN
         XvEnDN9IHObMOrLPQRzUP4IxqJV1eNIZIMoco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yw+RudC9dXxTNyd08I4c9F1iC0vSj71b4807D2ENyg0=;
        b=scuBRqavpTz6Vr5V8q0AJe6Z54qTjs5OYvqlXfPfzup45WdWjymPUzDQAsbldYxKdz
         C2wWb10R6W5xicvIVb5gZye8jmtLypOOQ/rl+qI4hRM1icuX8q92FWY2eOchFz1w2cIW
         J0If+EsNYLdSQxRKbgp7Dz1RrZeKZQPBL+1dqF4XkgqeUwYcuD69lK4c7WwRl7XT4SFH
         Olytz42EbCM0QL69HK5G9M8Sz180WkqLruQNaE/M5ddTlY1Kq6b3cLua8HbJ6h88wxSc
         RbiDjXYiyQgPdWkDXp2NPf5dQTu94OAE/YWIHsNtVC8fQnwT4q6kBW22BNz0jpaj/nGs
         vOmQ==
X-Gm-Message-State: AOAM5335jZuLRQq3lAyfrrvgfniNlc6pQFUbgPEz3Fel12UxwPuNiGsm
        Rpq4jONewjYQ9GN7o70CIqWkgyY3sE1z5A==
X-Google-Smtp-Source: ABdhPJxpqOVx1rXjHtnD+1wrrBg3FAaBVM+nT7erVFbHEee79ijJCWp3JJyLqiecAetvZyKuwaDdQA==
X-Received: by 2002:a17:902:b596:b0:158:f23a:c789 with SMTP id a22-20020a170902b59600b00158f23ac789mr600387pls.57.1651794394897;
        Thu, 05 May 2022 16:46:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709027d9200b0015edb22aba1sm171401plm.270.2022.05.05.16.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 16:46:34 -0700 (PDT)
Date:   Thu, 5 May 2022 16:46:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v1 1/3] kallsyms: avoid hardcoding the buffer size
Message-ID: <202205051643.1A8E38C7F2@keescook>
References: <20220505191704.22812-1-ojeda@kernel.org>
 <20220505191704.22812-2-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505191704.22812-2-ojeda@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 09:16:43PM +0200, Miguel Ojeda wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> This makes it easier to update the size later on.
> 
> Furthermore, a static assert is added to ensure both are updated
> when that happens. The relationship used is one that keeps the new
> size (512+1) close to the original buffer size (500).
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/kallsyms.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 8caabddf817c..880c4404731b 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -27,8 +27,18 @@
>  
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
>  
> +#define _stringify_1(x)	#x
> +#define _stringify(x)	_stringify_1(x)
> +
>  #define KSYM_NAME_LEN		128
>  
> +/* A substantially bigger size than the current maximum. */
> +#define KSYM_NAME_LEN_BUFFER	512
> +_Static_assert(
> +	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
> +	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
> +);
> +
>  struct sym_entry {
>  	unsigned long long addr;
>  	unsigned int len;
> @@ -197,15 +207,15 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
>  
>  static struct sym_entry *read_symbol(FILE *in)
>  {
> -	char name[500], type;
> +	char name[KSYM_NAME_LEN_BUFFER+1], type;
>  	unsigned long long addr;
>  	unsigned int len;
>  	struct sym_entry *sym;
>  	int rc;
>  
> -	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
> +	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN_BUFFER) "s\n", &addr, &type, name);
>  	if (rc != 3) {
> -		if (rc != EOF && fgets(name, 500, in) == NULL)
> +		if (rc != EOF && fgets(name, KSYM_NAME_LEN_BUFFER + 1, in) == NULL)

No need to repeat the sizing:

	fgets(name, sizeof(name), in)

>  			fprintf(stderr, "Read error or end of file.\n");
>  		return NULL;
>  	}
> -- 
> 2.35.3
> 

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
