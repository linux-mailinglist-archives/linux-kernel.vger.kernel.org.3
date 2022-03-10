Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF724D5012
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbiCJRRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244244AbiCJRRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:17:05 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565F3186213
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:16:03 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id w7so7247376ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=im9f7by7aGXOO+TZZQNnb2KIlOuQvzBKwx8HD64EYiA=;
        b=Eib/uCZyn0+INuEMXw5mnfIb0ym7lVaTFBob1AYHWH1yDsWLS+oO37W6XBwro4GEaM
         G+mgaQ/wxOrrJuamrtWFxVZKUr5iIXfalnEMOILIOmwW1zxkHp2VZARoRmVVxZUbJ/1f
         OXk3aG+sDTRLBtd5FXPmgr8EntaLdX1n++g9bLWjrYtuMggosleaJw8YZsFQOKR8ZDcz
         5kXoDBTb/U7lPpNNP7CAZfO+Fr5NSFHwzd5kKVJ4y6MCjAsrdtJTzuEc2rF252DfPWJK
         7oYlKN56iyw1mGBFXC8whWtcluDpanz2W3zq3SuUYcoq0+5UJxw8FSgrHSfvwgAEX52Z
         hYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=im9f7by7aGXOO+TZZQNnb2KIlOuQvzBKwx8HD64EYiA=;
        b=Uq4xpdUurzG6GatYpupLdQGl7l0GCwxL94nMBM30ci9rrGJMgkP3L5mWYylQVWS7jH
         j3GkUKQMznIhIkMDkuH3HN1bbNknVXfHbsRQj2m8YfXJEQgxbF9fbRTuhwvKLSWrDpX6
         TrVJ5Y7WXql05h56lVqVh5upXEmQNcOKRDfNVdyCVnKmee4ZmpIY+TfYiccp6Eb5bKEb
         mlTgt6/c2QAfMm9UufzLL0Imrde4PI0FaRkhayX9iqD7jGE1XNFqjFvoNrsHSTIkSstP
         FacKCHbKVas9ei0xidYB8VKy5q67aw3d5/+dpamMArnSgvGLsnyUXBD++UwuECQb9KzQ
         KFxA==
X-Gm-Message-State: AOAM53215oYuICb6Z/8A1z+hko3JbTI50NhoNpoETnay4/Umk5VkB5m+
        TT/QF1qTQ/uWAwscGy6FqTdR24X9eqx0dIhWrTfGkQ==
X-Google-Smtp-Source: ABdhPJyVN/Dg8yK30V4HA9/fOQMTChhT+M2KPf05rK/HCxdRlxCMHJNoc+M5jEXqmzruXZSNcn4HWvqUI1h2JEQEPd0=
X-Received: by 2002:a05:6638:f95:b0:314:58f9:5896 with SMTP id
 h21-20020a0566380f9500b0031458f95896mr4926817jal.228.1646932562537; Thu, 10
 Mar 2022 09:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20211005161833.1522737-1-lee.jones@linaro.org>
 <Yicwb+Ceiu8JjVIS@google.com> <202203100851.C00D9AB73@keescook>
In-Reply-To: <202203100851.C00D9AB73@keescook>
From:   Adam Langley <agl@google.com>
Date:   Thu, 10 Mar 2022 09:15:45 -0800
Message-ID: <CAL9PXLwnBE3jMucyTJ6Yo3nM7MiYWFZokrwXvAGer=0cjsuuiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sign-file: Do not attempt to use the ENGINE_* API
 if it's not available
To:     Kees Cook <keescook@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
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

On Thu, Mar 10, 2022 at 8:52 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Mar 08, 2022 at 10:31:11AM +0000, Lee Jones wrote:
> > OpenSSL's ENGINE API is deprecated in OpenSSL v3.0.
> >
> > Use OPENSSL_NO_ENGINE to ensure the ENGINE API is only used if it is
> > present.  This will safeguard against compile errors when using SSL
> > implementations which lack support for this deprecated API.
>
> On Fedora rawhide, I'm still seeing a bunch of warnings:
>
> scripts/sign-file.c: In function 'display_openssl_errors':
> scripts/sign-file.c:89:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecat
> ed-declarations]

The `display_openssl_errors` function should probably just call
ERR_print_errors_fp:
https://www.openssl.org/docs/man1.0.2/man3/ERR_print_errors_fp.html

The `drain_openssl_errors` function should probably just call
ERR_clear_error:
https://www.openssl.org/docs/man3.0/man3/ERR_clear_error.html


Cheers

AGL
