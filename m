Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4325883EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiHBWLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiHBWLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:11:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9657332DB6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:11:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kb8so13730787ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=k6pIxoS6xr69cL31tnJGd/edjv23VUk7urmVJKHeHw8=;
        b=FwrSh8M2yilbskdsO4gXxUoC2Ed+FeryminZgruVH00UecbUpXqRgNsVHrZfOtz6xc
         ib05vYtYPKWhkIqV87INC126FLDR+3Wl/KgQ7OB87pUtFbUh3h4sX0GHaJUVqmIocbuN
         5gXLQkyeN80KnkVUepMPBUS/nqR8X4BXEHwZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=k6pIxoS6xr69cL31tnJGd/edjv23VUk7urmVJKHeHw8=;
        b=2FK8DCGSsG57kXW1cRx/fuEt9ctcbi4ZReBptye70GjUFSNf7RTLONpQTUL9cAhsfz
         aIyAyUs1jLz1kbAwc6Yr94urILKFI4QxFg+OP8u6myn4FqhElvsoKCulThSGEFLrgQl9
         ZLayfJ0yQHK3o97JguCc8y3+Kz6G7yBgfNUQK5zbOWOP7odhzZp4w+2UEQ527VpEbG6Z
         jCwHOUTGRKveAfQT2G2gNDtUGKr0XmyuwKIZbqZS+aCrQLXL9KnNg3bDO/z6a0lky2bB
         2yWCWH0hM5vE/hiGlTdimSyMi164GA300bJ9qhxVBrWuVnWYi9I4wt8XQ9uWN1fQnQ45
         988A==
X-Gm-Message-State: ACgBeo05BIpZqyOKx6ZB0229R8VSDnC0WnOMv1J6i+o68CfAvGrdedwD
        IBmNMjY/baH+MkV+kDvzQMbZ1V1sPb+AJGyA
X-Google-Smtp-Source: AA6agR7PQopi89Lcy3aQIOiMg4duSwjQMqI8yZypKnF+m97EQ0J0XUdPbmHH1FO61E73DdREdje3TA==
X-Received: by 2002:a17:906:8a6c:b0:730:a322:6f69 with SMTP id hy12-20020a1709068a6c00b00730a3226f69mr3182641ejc.585.1659478295893;
        Tue, 02 Aug 2022 15:11:35 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id x25-20020aa7d6d9000000b0043bc4b28464sm8759758edr.34.2022.08.02.15.11.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:35 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso54749wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:11:35 -0700 (PDT)
X-Received: by 2002:a05:600c:21d7:b0:3a3:2088:bbc6 with SMTP id
 x23-20020a05600c21d700b003a32088bbc6mr843858wmj.68.1659478294886; Tue, 02 Aug
 2022 15:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <827a0fe0-03a3-b5ca-db34-daff17095b8f.ref@schaufler-ca.com> <827a0fe0-03a3-b5ca-db34-daff17095b8f@schaufler-ca.com>
In-Reply-To: <827a0fe0-03a3-b5ca-db34-daff17095b8f@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 15:11:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsM9cUHfmGMcco5zCuBqMpM-97hBkBX5_vzoRLm5SvJw@mail.gmail.com>
Message-ID: <CAHk-=wjsM9cUHfmGMcco5zCuBqMpM-97hBkBX5_vzoRLm5SvJw@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v6.0
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 1:13 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> There are two minor code clean-ups. One removes a touch of
> dead code and the other replaces an instance of kzalloc + strncpy
> with kstrndup.

Hmm. That second one looks like it really should have just used
"kmemdup()" (and a zero termination) instead, since it has already
done all the string length calculations.

Oh well. I guess the strndup() works too, but it seems kind of odd to
do a strnlen() there when you have literally limited 'len' to smaller
than the string you are going to duplicate.

                   Linus
