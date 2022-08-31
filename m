Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC775A8657
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiHaTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiHaTBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:01:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A83FB7773
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:01:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u9so30288046ejy.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0guvX6CdC6+lkNNlrZup+CjHGuoRwmgwPktN8aSa5Dg=;
        b=cW7QRE50uRd1u3+fTEsX8n3iPW03Ajb4IjDv4d12ILcNWH6K4Wl3TLUWfUjqQQjukT
         inHeaIkzIB8xjOmMh/4xBOXxYmse3IBrP0LiIZc0bAzKqYA4XxgYeXhiE1/yPLcBIMs7
         Jij2tNtEBtAdZ2xMJl/rG3GghtwopHPetwqPxsl6YqudSKBAyf24ZAK6LBpfUyoyuPEO
         iHkERF6Np6lC7bcqR7kL8CkHgsMffRThNmsJ7mNxIOD+Fw/uoWGJ/YhZlVt4ECZPGOAZ
         iwtRzjFHNEd7PUILk6YglflgGfBIZ2tuA3IKYNKil4ZNrXTzAjZu9HPqqg+J75c7sjKh
         8dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0guvX6CdC6+lkNNlrZup+CjHGuoRwmgwPktN8aSa5Dg=;
        b=x2pin4JGG1o81LCh5g+kQdWpStPzAbosMlXx9SXhVhqD60K2EM8N+Yy3DSj9eAcU2E
         fMBTS1vn2PCcPjdIAvy1Mo8AhfKkGwjYl+D2JNgw7s71WWGJ/UEwM9VeWNEKPRIdcwn0
         5SdNcmdA5oB19x8KKiRv4ev+EXt4NNe/Ec9Zx5dx2PqsVYuRxM0oL2RB3c4SlD2xY5QC
         33c3LcodrGghQMXcvzcOompCZsJYnJMv2JKd9Ek1ZGY+7IFlYA/+8Mf4r/4xlKL2WiQK
         lvZGqCCPQIpBQe+tYnjhHnxKDjyfyJChaFAtjLgOjCec4yl+rtKUqSvxv5iWzrARLBCr
         5z/Q==
X-Gm-Message-State: ACgBeo1NraF8A+11UayS/1X/Y/AmufVpWPA1ucxrlCtg6cbfHAXNo9rp
        XgBFU9jcwO7nGhX49GJHrzMnrzVAWeQP6BwCdNzEMg==
X-Google-Smtp-Source: AA6agR5dencj6+Gxk5MgyF3/1d0mP+Bbv9YhUqKLvvR2G/Ig/K/ygovKx39x84jy8+l4/Ghhz3TS356SXIqxFmyqMHk=
X-Received: by 2002:a17:907:2724:b0:741:4a1f:6159 with SMTP id
 d4-20020a170907272400b007414a1f6159mr14075478ejl.542.1661972487230; Wed, 31
 Aug 2022 12:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220831181140.842093-1-keescook@chromium.org>
In-Reply-To: <20220831181140.842093-1-keescook@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 31 Aug 2022 12:01:16 -0700
Message-ID: <CAGS_qxoqRrQmECRNAx092j=PArO00NPHansYd8+6TkuFgxe4XQ@mail.gmail.com>
Subject: Re: [PATCH] overflow: Split up kunit tests for smaller stack frames
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Wed, Aug 31, 2022 at 11:11 AM Kees Cook <keescook@chromium.org> wrote:
>
> Under some pathological 32-bit configs, the shift overflow KUnit tests
> create huge stack frames. Split up the function to avoid this,
> separating by rough shift overflow cases.
>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: Vitor Massaru Iha <vitor@massaru.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202208301850.iuv9VwA8-lkp@intel.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Daniel Latypov <dlatypov@google.com>

It's sad that we're forced to do this to eliminate such warnings, but
I like this organization a bit better, actually.

I wasn't able to reproduce the stack size warnings in the past, so I
haven't tried to do so here and can't give Tested-by/Reviewed-by.
But I did run the tests and they all still worked for me.
