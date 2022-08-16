Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C67B595B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiHPMAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbiHPL7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB1F8D3CF
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660650294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQ9c/pAyzSt4qpyyd5v9AYo0Di39q7g2yKh2Xw+LqgM=;
        b=PrWzTD7brl3qR4pOu8l3l9S+yCeKm5bjRUWq16wajjcZ5eHbrAtCEOI/UQzAxQ8sid+s5N
        aXrxgcXYQ8f1oZXofvSYuHLET5INgExQZ0tONnElwOtdZ2BHHZFDZ3jutrndPQoY6w69zU
        a6qi9Yks+5wsAf1ycih6Vzfl9J01cfo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-X3Cfs1kSNzy0ZWwHP9Ge_g-1; Tue, 16 Aug 2022 07:44:53 -0400
X-MC-Unique: X3Cfs1kSNzy0ZWwHP9Ge_g-1
Received: by mail-qt1-f198.google.com with SMTP id v13-20020a05622a188d00b00343794bd1daso8248588qtc.23
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=fQ9c/pAyzSt4qpyyd5v9AYo0Di39q7g2yKh2Xw+LqgM=;
        b=es41EOw+Fm7whCXWvhfwcs3m3t4sF7E7UfQuH03I64lvA4qIwubh7DJ4NESIpowVU+
         KFHiOV9BNjn3VuvYFELudJCm8Qrhr0Kf0SiuuWVLU9Nw7WGPdONkZ+9bz1TxfT0j6T3u
         T4KlVBYE1MpsvshvjVQtv2uV1HuUo3AqjggNYhyV0XRVzt8OBQ8Lht54pr3ABrxPIUmC
         VtrFckoDUEDs1ZYqRrW4ZJboQJgzyPjaweblOB12eprTGPmjB2lnbJX4wWV7w6CyXrPy
         un330oRTyWbWC6Ymi787bTAxJC90sY8ugjygGt5vYXZOjsQl322v5kNibbBcHRb73VDd
         kUig==
X-Gm-Message-State: ACgBeo1qGRg3F8Mw4nRMmNMvi/2a8XUu+6rG68dRvDAclTeQVsbwR7me
        bw8lJBmwL0vYhZE0hnioeZAyQeO42w61wAe48epcXi74MS2E5Y5BimOyThlSkUhEvHzRN9bOrm8
        5kAfIXnJ1j8HeQaisE4juYgQT
X-Received: by 2002:a05:6214:21e2:b0:494:6076:123c with SMTP id p2-20020a05621421e200b004946076123cmr2297500qvj.104.1660650292234;
        Tue, 16 Aug 2022 04:44:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Kt/qyNZF6Bq4BTj6XTzy+BD4XG/UT+zur69lk4/rmyVzpi62jIFxDy1PeFaQrLE+KMaM8MA==
X-Received: by 2002:a05:6214:21e2:b0:494:6076:123c with SMTP id p2-20020a05621421e200b004946076123cmr2297486qvj.104.1660650291968;
        Tue, 16 Aug 2022 04:44:51 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id bs18-20020a05620a471200b006b5905999easm7361880qkb.121.2022.08.16.04.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 04:44:51 -0700 (PDT)
Date:   Tue, 16 Aug 2022 07:44:48 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: save LOC in vsyscall test
Message-ID: <YvuDMGHcNtjhhMuq@bfoster>
References: <YvoWzAn5dlhF75xa@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvoWzAn5dlhF75xa@localhost.localdomain>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:50:04PM +0300, Alexey Dobriyan wrote:
> From: Brian Foster <bfoster@redhat.com>
> 
> Do one fork in vsyscall detection code and let SIGSEGV handler exit and
> carry information to the parent saving LOC.
> 
> 	[
> 		redo original patch,
> 		delete unnecessary variables,
> 		minimise code changes.
> 					--adobriyan
> 	]
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---

LGTM and passes my quick tests, thanks!

FWIW:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> 
>  tools/testing/selftests/proc/proc-pid-vm.c |   56 ++++++++---------------------
>  1 file changed, 16 insertions(+), 40 deletions(-)
> 
> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> @@ -213,22 +213,22 @@ static int make_exe(const uint8_t *payload, size_t len)
>  
>  /*
>   * 0: vsyscall VMA doesn't exist	vsyscall=none
> - * 1: vsyscall VMA is r-xp		vsyscall=emulate
> - * 2: vsyscall VMA is --xp		vsyscall=xonly
> + * 1: vsyscall VMA is --xp		vsyscall=xonly
> + * 2: vsyscall VMA is r-xp		vsyscall=emulate
>   */
> -static int g_vsyscall;
> +static volatile int g_vsyscall;
>  static const char *str_vsyscall;
>  
>  static const char str_vsyscall_0[] = "";
>  static const char str_vsyscall_1[] =
> -"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
> -static const char str_vsyscall_2[] =
>  "ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
> +static const char str_vsyscall_2[] =
> +"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
>  
>  #ifdef __x86_64__
>  static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
>  {
> -	_exit(1);
> +	_exit(g_vsyscall);
>  }
>  
>  /*
> @@ -255,6 +255,7 @@ static void vsyscall(void)
>  		act.sa_sigaction = sigaction_SIGSEGV;
>  		(void)sigaction(SIGSEGV, &act, NULL);
>  
> +		g_vsyscall = 0;
>  		/* gettimeofday(NULL, NULL); */
>  		asm volatile (
>  			"call %P0"
> @@ -262,45 +263,20 @@ static void vsyscall(void)
>  			: "i" (0xffffffffff600000), "D" (NULL), "S" (NULL)
>  			: "rax", "rcx", "r11"
>  		);
> -		exit(0);
> -	}
> -	waitpid(pid, &wstatus, 0);
> -	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0) {
> -		/* vsyscall page exists and is executable. */
> -	} else {
> -		/* vsyscall page doesn't exist. */
> -		g_vsyscall = 0;
> -		return;
> -	}
> -
> -	pid = fork();
> -	if (pid < 0) {
> -		fprintf(stderr, "fork, errno %d\n", errno);
> -		exit(1);
> -	}
> -	if (pid == 0) {
> -		struct rlimit rlim = {0, 0};
> -		(void)setrlimit(RLIMIT_CORE, &rlim);
> -
> -		/* Hide "segfault at ffffffffff600000" messages. */
> -		struct sigaction act;
> -		memset(&act, 0, sizeof(struct sigaction));
> -		act.sa_flags = SA_SIGINFO;
> -		act.sa_sigaction = sigaction_SIGSEGV;
> -		(void)sigaction(SIGSEGV, &act, NULL);
>  
> +		g_vsyscall = 1;
>  		*(volatile int *)0xffffffffff600000UL;
> -		exit(0);
> +
> +		g_vsyscall = 2;
> +		exit(g_vsyscall);
>  	}
>  	waitpid(pid, &wstatus, 0);
> -	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0) {
> -		/* vsyscall page is readable and executable. */
> -		g_vsyscall = 1;
> -		return;
> +	if (WIFEXITED(wstatus)) {
> +		g_vsyscall = WEXITSTATUS(wstatus);
> +	} else {
> +		fprintf(stderr, "error: wstatus %08x\n", wstatus);
> +		exit(1);
>  	}
> -
> -	/* vsyscall page is executable but unreadable. */
> -	g_vsyscall = 2;
>  }
>  
>  int main(void)
> 

