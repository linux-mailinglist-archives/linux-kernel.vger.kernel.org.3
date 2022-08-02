Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B083C587589
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiHBC1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiHBC06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:26:58 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0FF3334F;
        Mon,  1 Aug 2022 19:26:57 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u8so7737377qvv.1;
        Mon, 01 Aug 2022 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u28fU+R+WkgdZ5gz5xlAlhxJAk8+lyXhIpNWs/Glats=;
        b=Aa1C+05f4YxiyfU5sU+7I8eAX+hOoGVREp0LuGol5AfJ0d3TKqx4yfdlD0RxKMwWag
         ixVS5lXND1ngqkjC1z2/oxuKr/Q41NZ5SPPF3VGdxr4rN+7hHq0PB9Ntp6C7nAjMdfpN
         S0ZjJYx6dFOpU162ZxjMW1JTms6f4ELG5Y45rNG5i1QmHsdLK7SsxsMflMVc5kSuNxq5
         9HG+yCrlJGc3/HiLwyEiBobzJVXhVX1Vrrp+Z0YnTQAgTuGtW5wR7EQgfp8WrgZQod73
         1S49EYF7AOqhhmZN8M6iOKzhq8rNd4pkFMJOG10FaPEYR46Co9TMFpSfpIngaciHhFsr
         hujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=u28fU+R+WkgdZ5gz5xlAlhxJAk8+lyXhIpNWs/Glats=;
        b=4uubVYbI+CQpunmlBwGa4jSjAzn6UOB24PXHb9W1MjZN7mZ0XbTNTY/JvJfHhhyQjO
         g9tqnjkixTlDgtAgi/mk37uXG96j5s++bR9RwunYV5sLetiwrO2/9+Pij4ULHKzG7dAm
         6g2lZuvJ4fWIkORJLFACtjcGUTTEeeFhKsfVu2UYxO3gF+HyBPFUBi7c9qu+QTPnFNgr
         vldXst/AYheVGtRin0G+cY+SzfvWVGUiVv8eLo1oESP2Q14vjaKufHGpV4JGiu5zi1GO
         9HWaRsqx34z+PDJr9P9aDVQDaWVK/hgs/STJexv2bVhLZdIPHx4lMpHMQXpy3eDbKXqk
         R/6Q==
X-Gm-Message-State: ACgBeo16vagEQZzgAhGxXifKjkllslRRy63Kx60zrU+45XypqRsgOSzQ
        YG6JItdN8LkB/pFyd1Mqbvc=
X-Google-Smtp-Source: AA6agR6nD2Bp+uyWh97Nql8sC/wG7nk1w3U7QXnt2trf9sOEolxXG7rmKnjBDfCp14XbNxCHLHaq8g==
X-Received: by 2002:a0c:ab07:0:b0:474:9c36:413e with SMTP id h7-20020a0cab07000000b004749c36413emr13197580qvb.56.1659407216557;
        Mon, 01 Aug 2022 19:26:56 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w16-20020ac857d0000000b0031f0b43629dsm8522404qta.23.2022.08.01.19.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 19:26:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3506127C0054;
        Mon,  1 Aug 2022 22:26:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 01 Aug 2022 22:26:55 -0400
X-ME-Sender: <xms:bovoYkxwkD_v34-ab_5DweaJYssJqGhdld2Ccadx2rbkDKzb4ow6PA>
    <xme:bovoYoQ0aouSZX5Lte8ymFjz7s1k9jRCjl5iBYRpUNb7xL1KDJ_KzffZv1OmamlP-
    5Wq1ar1dow21IAYig>
X-ME-Received: <xmr:bovoYmVMd6Ayez-qGcpRE7vaeNsTA6vQvP1sXQKIHsyY-aNm7v81PDwcx1MSBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvgedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepleetgfefieffieffgeduudeigfefgefgieevveetudfgveeigfehgeei
    hfdvkeetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:bovoYiixbcnNnJ_oWmbzZq_CRTh3xPouZ7Jn1weF70CKx3igTXw4Sg>
    <xmx:bovoYmAiAo7ZuZ1Mzs6nSPJiQk-ZbGorwZ6p4FRr6KiebRABf5ohmA>
    <xmx:bovoYjJ_MdNqHu9WpyaPe08he2PcVuI2lBE3Kn2fJluIzUIEeJioBQ>
    <xmx:bovoYq4MtjbhCs6ZTD67rpi5XwTUysbVZLCn1Xv3BRecI3oflQKWkA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Aug 2022 22:26:53 -0400 (EDT)
Date:   Mon, 1 Aug 2022 19:25:55 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v8 29/31] MAINTAINERS: Rust
Message-ID: <YuiLM6ca8Ih0WiS3@boqun-archlinux>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <20220802015052.10452-30-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802015052.10452-30-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:50:16AM +0200, Miguel Ojeda wrote:
> Miguel, Alex and Wedson will be maintaining the Rust support.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  MAINTAINERS | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64379c699903..a4f90593b59c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17477,6 +17477,21 @@ L:	linux-rdma@vger.kernel.org
>  S:	Maintained
>  F:	drivers/infiniband/ulp/rtrs/
>  
> +RUST
> +M:	Miguel Ojeda <ojeda@kernel.org>
> +M:	Alex Gaynor <alex.gaynor@gmail.com>
> +M:	Wedson Almeida Filho <wedsonaf@google.com>

May I join the party and become a reviewer?

R: Boqun Feng <boqun.feng@gmail.com>

Also given their activities on GitHub, I'd like to encourge Björn Roy
Baron and Gary Guo to become reviewers as well. Of course, they need
to be aware of the possible upcoming email volume and sign up themselves
;-)

More eyes (especially from Rust language experts) are helpful ;-)

Regards,
Boqun

> +L:	rust-for-linux@vger.kernel.org
> +S:	Supported
> +W:	https://github.com/Rust-for-Linux/linux
> +B:	https://github.com/Rust-for-Linux/linux/issues
> +T:	git https://github.com/Rust-for-Linux/linux.git rust-next
> +F:	Documentation/rust/
> +F:	rust/
> +F:	samples/rust/
> +F:	scripts/*rust*
> +K:	\b(?i:rust)\b
> +
>  RXRPC SOCKETS (AF_RXRPC)
>  M:	David Howells <dhowells@redhat.com>
>  M:	Marc Dionne <marc.dionne@auristor.com>
> -- 
> 2.37.1
> 
> 
