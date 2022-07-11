Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730D6570A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiGKTUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiGKTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:20:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC5C71724
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:20:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c15so438351pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NrYdGTk0yKCuMljUwPZ7/uXlafiom1+RNi/pXfEgS+Y=;
        b=avtznRRY4iS1AmoNE+xFYckNON9ycVHYL5nrww0X0/cL24DXv29e4e7u9Ra3AulsGp
         t8nShsS3H0X29qd3p2cDNwKAQ+T1Lc6bZfy2P+sNHEhC773m5LtNMKtdbh7p4XerMl3+
         WxVrB5yDkfmcO8w7XD9Vna5BS8Y7HSlmDtonN0dcDUgaB+8GsyYbXvPaLe8B8Y15QS5F
         4fpAqxlzmXrZeei0rEj/LduqDgjqPXhsTN5zJeQzqMQGXLs0hKXTbbD81UbEHtdDz6zO
         Yvkseu6BtC9cklXVX5PtKZ568HnkGJJ32D9CrRb+kVJVC4mqqqh2dvIHjoJjg9Mvao4Y
         Lvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NrYdGTk0yKCuMljUwPZ7/uXlafiom1+RNi/pXfEgS+Y=;
        b=QyCeLTxc3rG0Hjis7kkm0hocNa32BM1tJYcoFs9B77KlzoU2mrb+8pSIfNTI9aKpqZ
         VmNB3VmvlQB3S0BieyjipoGlz2kGT5eZ7qdWTpUTnpY92vEyzLRTgs1vBEkgejb477Ou
         ox5ZY//GYSF98ZF13IXjCfJ+IjkS4bHD1I8Px2QXL6xTxAG2CdYBuQy0GNV9zFeXKfQo
         bf3nBRFmP7wYrSD4EsRWGcpR8C4DYXtBZfoOYOc1o8fHZQhH6iZ+RcbuTAcj9tbTdMXK
         OnjU48PWpSocuTlETRVeFYRNJttY2jhn+QyI9bADkEpBQav3gwwMd3rQciC2FUeJ/tny
         d0gA==
X-Gm-Message-State: AJIora8Kk7iOrtWPArmDYCIrQpZcqcg/uPx4CwXn9RLeQSL+xwOQC4mX
        JxTpls4JxVcqsxpQM8q+XXORSg==
X-Google-Smtp-Source: AGRyM1t/be+eF6H+YW5M2kcvwqqjrTB3VqZ6D3Mx34zzp6TePEh7gNQILyffnVjxOuTtoikVhDnlfQ==
X-Received: by 2002:a17:902:8f87:b0:16c:2c88:39ec with SMTP id z7-20020a1709028f8700b0016c2c8839ecmr17150281plo.52.1657567231016;
        Mon, 11 Jul 2022 12:20:31 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:a8b3:6eff:f380:e88b])
        by smtp.gmail.com with ESMTPSA id o33-20020a17090a0a2400b001ece32cbec9sm7270672pjo.24.2022.07.11.12.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 12:20:29 -0700 (PDT)
Date:   Mon, 11 Jul 2022 12:20:22 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     xiaoming.yu@mediatek.com, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Aaron Tomlin <atomlin@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 0/2] cfi: free old cfi shadow asynchronously
Message-ID: <Ysx39t+I56lDGe4i@google.com>
References: <20220704014046.34596-1-haibo.li@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704014046.34596-1-haibo.li@mediatek.com>
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

On Mon, Jul 04, 2022 at 09:40:44AM +0800, Haibo Li wrote:
> This patchset changes synchronize_rcu to call_rcu in update_shadow.
> 
> Patch 1 enables the CFI sanitization for cfi.c and 
> bypass __cfi_slowpath_diag.
> It is the prerequisite for using call_rcu in cfi.c.
> 
> Patch 2 changes synchronize_rcu to call_rcu and
> free old cfi shadow in rcu cb
> 
> Changes in v2:
>  - Remove _run_cfi_check,add __nocfi to __cfi_slowpath_diag directly
>  - Rename _cfi_shadow_free_rcu to free_shadow
> 
> Haibo Li (2):
>   cfi: enable sanitize for cfi.c
>   cfi: free old cfi shadow asynchronously
> 
>  kernel/Makefile |  3 ---
>  kernel/cfi.c    | 14 +++++++++++---
>  2 files changed, 11 insertions(+), 6 deletions(-)

Thanks for sending v2! For the series:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
