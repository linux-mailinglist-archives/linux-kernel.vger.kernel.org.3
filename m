Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCAD56B6E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbiGHKJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbiGHKI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7B6B83F17
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657274934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R31VwcSPJiQ7JIw87RxF+TN0+eL/CdtqRF2EIROnvwo=;
        b=T7WNCl10ejr8JfsUKnYtlPUzCCtHbJ3xwtQpTZWTYJkgcR2VKAhFdU3/59H9Ow8//0N6Ka
        tuck8qPXAnLjH6EpN4ZHZBnaOChNqlEW2+0VjPv8RSHgTOLlKMpTMqELMfz1/lcpczxDD3
        rnf75MeJL4fxVFPXgyiRhMu2V5ebqUg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-Om5y2iukNWWCmCNwCqmvOQ-1; Fri, 08 Jul 2022 06:08:50 -0400
X-MC-Unique: Om5y2iukNWWCmCNwCqmvOQ-1
Received: by mail-wr1-f72.google.com with SMTP id r17-20020adfa151000000b0021d6c4743b0so2891970wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 03:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R31VwcSPJiQ7JIw87RxF+TN0+eL/CdtqRF2EIROnvwo=;
        b=C8znvYARVtUc3doJk5O93hXdfqIN2qKeYXfjrkSP44XthodNWQzAf8hCkyqgJSyn/u
         nIxhrUBkdR2T3/U+JokS8aBPUkVrvpmzx1Co1GRAdh1Ukre9DmIcU1Dv/8ClBi0Yz897
         tGk/+/oc2auYCQv0NzHQBH9VjZcuUdqb9oKCavG9HQb06gvX0a/JlAojvbj5odJTNI5b
         n1RwqMI8+X0tLWNhF3Uvh7Av8C2gTwIUEjYBOQ05LHVW/ZceJ9l53kQxy8WJS3jqIJM2
         L/Lt91l82tJYMS38RitaneSbTNSGsCkJoUqNwIENbXVfaMh9ONyb6wy69ubOH+1nt7IR
         E3MQ==
X-Gm-Message-State: AJIora9R0PdHnczW+qYBscwFeDyotJADoicJzQ2igNJE75o9ghQM42f3
        g6qOF9diUvj79XiRdmk90aoQeMeQKi8E722m07KYFy/HwID1YcVOFkf8MlQn6LxjpDtAREEdiC1
        CpJBaLlJCs18ytBQUwUJJzUJv
X-Received: by 2002:a05:600c:4e8b:b0:3a0:5826:3321 with SMTP id f11-20020a05600c4e8b00b003a058263321mr2822306wmq.108.1657274929750;
        Fri, 08 Jul 2022 03:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1syukJVbZC5Q5vHTRyn7SXZAqXHIKjGpeSBXFwl4fsGgBLNx7VcuUla/SxRd4bJfBA7oD8ULA==
X-Received: by 2002:a05:600c:4e8b:b0:3a0:5826:3321 with SMTP id f11-20020a05600c4e8b00b003a058263321mr2822281wmq.108.1657274929580;
        Fri, 08 Jul 2022 03:08:49 -0700 (PDT)
Received: from debian.home (2a01cb058d1194004161f17a6a9ad508.ipv6.abo.wanadoo.fr. [2a01:cb05:8d11:9400:4161:f17a:6a9a:d508])
        by smtp.gmail.com with ESMTPSA id z10-20020a1cf40a000000b003a2c7bf0497sm1654705wma.16.2022.07.08.03.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:08:49 -0700 (PDT)
Date:   Fri, 8 Jul 2022 12:08:47 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Tom Parkin <tparkin@katalix.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] l2tp: l2tp_debugfs: fix Clang -Wformat warnings
Message-ID: <20220708100847.GA26192@debian.home>
References: <20220707221456.1782048-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707221456.1782048-1-justinstitt@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 03:14:56PM -0700, Justin Stitt wrote:
> When building with Clang we encounter the following warnings:
> | net/l2tp/l2tp_debugfs.c:187:40: error: format specifies type 'unsigned
> | short' but the argument has type 'u32' (aka 'unsigned int')
> | [-Werror,-Wformat] seq_printf(m, "   nr %hu, ns %hu\n", session->nr,
> | session->ns);
> -
> | net/l2tp/l2tp_debugfs.c:196:32: error: format specifies type 'unsigned
> | short' but the argument has type 'int' [-Werror,-Wformat]
> | session->l2specific_type, l2tp_get_l2specific_len(session));
> -
> | net/l2tp/l2tp_debugfs.c:219:6: error: format specifies type 'unsigned
> | short' but the argument has type 'u32' (aka 'unsigned int')
> | [-Werror,-Wformat] session->nr, session->ns,
> 
> Both session->nr and ->nc are of type `u32`. The currently used format
> specifier is `%hu` which describes a `u16`. My proposed fix is to listen
> to Clang and use the correct format specifier `%u`.
> 
> For the warning at line 196, l2tp_get_l2specific_len() returns an int
> and should therefore be using the `%d` format specifier.

Acked-by: Guillaume Nault <gnault@redhat.com>

