Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D751E55B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446030AbiEGH7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244789AbiEGH7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:59:05 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8658C62C0
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:55:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 7so7886373pga.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XQZ0jflEj3ZwDdXxvsSFNpBxdR4iKUh7DFg36P3Lf1Y=;
        b=k8XL1BxUa+Ec15LWWdxguxto1dBkS3U+zppqYT4iyKpNspFGDOF0HcTPPHLJiBCUf8
         mc2RdLx4q0nCJo3pVAqXd1FOWoJAB6bxaNyJQ728vG67Uwa0An65tEsYUBt/gPrFE/IZ
         kpjen0oZQ2DGUSJzCUW3jrRPoMQN+CdVKI+EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XQZ0jflEj3ZwDdXxvsSFNpBxdR4iKUh7DFg36P3Lf1Y=;
        b=aQMjgw5QLTXdL1NLJX7lD1a43v/oQ8UBUCIihzNhfxXjiHjQgNfYbVAH4HBb6FKfz8
         sM9OPS+8HOuPEapJ9vvi6JBoALkdv8gGhtb8yJo0UbCCNrhUfDfwz9rQJp68+vS/qKB9
         N7ssD9ozO0+bibIkUeDE/L7v5zWYr5+XNmodpDy3nmJp5dJ46RHrlSRwHlzLFQrkviFR
         CXzFujzUeele3p3pWbMvy+JVVZYxFwvTj1yVj9h5ipoQRO2TjHmc/vcFcOHNA6Xm9dEK
         2TU5i7eNpVVSpzPsDj4Z9q9ZNj0u+EvT3+e47KeT3VSrauv1MWlu9wLFcXMEfM2rsUAz
         oyzg==
X-Gm-Message-State: AOAM532cwruKso5mGHXiTKQZeRDCHIdN9i12xL8hy4IIsLr+KpF4tkNB
        PyjTH+IfiDuzs2NsmGuu9hrNFw==
X-Google-Smtp-Source: ABdhPJw541yvtB0SwHhc57WgV9+sbvT2fz/QLC9JKaka5Qzd+gH8Uqv9Lfa4rtVSJySmpReUn6jBAQ==
X-Received: by 2002:a05:6a00:1411:b0:4fd:e594:fac0 with SMTP id l17-20020a056a00141100b004fde594fac0mr7330862pfu.79.1651910119067;
        Sat, 07 May 2022 00:55:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 14-20020a62140e000000b0050dc76281besm4643503pfu.152.2022.05.07.00.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 00:55:18 -0700 (PDT)
Date:   Sat, 7 May 2022 00:55:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Wayne Campbell <wcampbell1995@gmail.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 23/23] [RFC] drivers: android: Binder IPC in Rust
Message-ID: <202205070050.A870AEAC6@keescook>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-24-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507052451.12890-24-ojeda@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 07:24:21AM +0200, Miguel Ojeda wrote:
> From: Wedson Almeida Filho <wedsonaf@google.com>
> 
> A port to Rust of the Android Binder IPC mechanism.
> 
> This module is a work in progress and will be sent for review later
> on, as well as separately from the Rust support.

Is any functionality missing for this driver compared to the C driver?

>  12 files changed, 3400 insertions(+), 13 deletions(-)

The C driver appears to be much larger, so if the Rust binder is
feature-complete, that's quite a reduction in code size.

Are there any other metrics can that be compared in a direct a/b test?

-- 
Kees Cook
