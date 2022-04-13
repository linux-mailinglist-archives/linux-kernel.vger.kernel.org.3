Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B220450006C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiDMU7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiDMU7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:59:40 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1025E7304E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:57:18 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id b17so2532051qvf.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZGg9v7EK00Y3HMnG9AhwKOPJdSP7gnweZeMiLC7mrHg=;
        b=IBaaTg2KPKEOD7CKJwlh1c0WzJu8QtsBh183IfTV2l+Xv5VUr/9xtOIO1xO4zagFi2
         qrjEYMFPqftityRly+DtTTJAFgjRKzijjglE+Q2YTiY3xg5B21Wdo2zL4BcOFD7jf/fQ
         CGJ+6RE4FYkndwrHuujQfzsZh6brAN7Iq7VP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZGg9v7EK00Y3HMnG9AhwKOPJdSP7gnweZeMiLC7mrHg=;
        b=zwzcx/+E5uTZUE21jymy+/tabAcEH6GfNpIzNQ1vieXWwQaHWREQAOc81gmQEItCKv
         sRB9ZSTOT6De3A2X/il7N/iGaUBUdlG9T235vqNDO1Ekh+2PZ7NDecqoL7whidi2sFby
         stagKO5G3ZkBzT5LxQu/UF9VBPwHO74zY7Kr80367LiIuMpnrllVGoT2mlRrHI4/L6nX
         /mhHqWtlNB6HyQHO01V8OXQfzp6iahKdCLr2GLkmdZVT5kH5k1O9Ae1dkd9/tJCMKZ8m
         yXJ5qlToaubjJLMVL38dYTBA2dL5JVmJpDfwCQsAVkB6o6K9RCj4gdWPbgr0n6ooG7iE
         fvUw==
X-Gm-Message-State: AOAM530xuiHSn5jWd/BXlmOT+IIKftamvvXXjRxluaAJOqWFX7TnvEL4
        7BI7OVtz88XOw8wN3vtxGWE8IRdzY1GFUw==
X-Google-Smtp-Source: ABdhPJxqB+3XkCUJcHQJd7LqO+J8n8XJYpP873Fm+iKuxdmJZO1KNPnr2OgeVuAWU2LKIWlCpcwkBg==
X-Received: by 2002:ad4:5ba3:0:b0:441:32c:767b with SMTP id 3-20020ad45ba3000000b00441032c767bmr9761573qvq.9.1649883437183;
        Wed, 13 Apr 2022 13:57:17 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id p16-20020a05622a13d000b002e227782e9asm23424qtk.14.2022.04.13.13.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:57:16 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:57:14 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] lkdtm/bugs: Don't expect thread termination without
 CONFIG_UBSAN_TRAP
Message-ID: <20220413205714.scrrktpq43kzryim@meerkat.local>
References: <363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu>
 <202204121440.FEE123D7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202204121440.FEE123D7@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 04:06:20PM -0700, Kees Cook wrote:
> Also, Konstantin, I note that
> https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/
> does not have a .keyring/ed25519 directory. Should it? 

No, because it's not a "pgpkey". :)

> I added one
> locally for at least one other developer, as I use this setting:
> 
> [patatt]
>         keyringsrc = ~/korg/pgpkeys/.keyring
> 
> Am I holding this thing wrong? :)

Nope, but you can also list multiple locations where patatt can look, for
example:

[patatt]
       keyringsrc = ~/korg/pgpkeys/.keyring
       keyringsrc = ~/.local/share/patatt/public

In fact, if you take Christophe's patches all the time, you can add a keyring
ref to your tree. The process is documented here:
https://github.com/mricon/patatt#managing-the-keyring-large-teams

This way I'm not managing the keys of your trusted contributors.

I'll be happy to explain further -- in fact, I'm happy anyone uses it at all!
:)

-K
