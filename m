Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23118523BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbiEKRip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiEKRig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:38:36 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1DF2317F6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:38:36 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r1so3558043oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RlzFsByCwYO+godJCtKhbcKblXXdp9qodl5pJjjGvC0=;
        b=Y4XXMhSrkkqjeeNQzH5/EiAhaqEB1BNz4HySD+ED33eEHyo9F4B9oXsZMTg3p64U/t
         0F+xS1HB/JGaIvkhETiE1oi1CPSVc4KbCMWXo7Z8u8GN9wK/rdCRHaPpe1gk/B3Hr83j
         1252CL9hljxD0xv68XFW7aIlgtoVMQ9FfgpLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RlzFsByCwYO+godJCtKhbcKblXXdp9qodl5pJjjGvC0=;
        b=kDmW8+wj+uqYB0vjPgKdHSjtWRseTPI0KOPjnscVd+t/ttOsWVRfYRYBOacJOf8MTT
         P0bZhystYJPV7Kkqw33yAHOBkdahldX4GPYmhtbZDXGhvWO5sgmmqsUpa9roKv2f5Rgv
         RRwAMX//Yg0iXkS2bqD+ki5gpRX5Iv/kR8n5tV7QzY10PGqayrs9f7c97BnFBzTbxkcW
         dslhuxLUeVaSKu+Jqsnj/QCAV8aM+49cfwdZg6uHmiD+WAusGW5Qf4KxHPYZOop2sM47
         L8cKfnh5CZTWCPXaggVop0zSEmhd/eO/RHSHybFfAlRzvpP3x9auCaMVe70gtT37AhSl
         AQyA==
X-Gm-Message-State: AOAM532gTcL+cRldAUWTpyd2/B6CWp/N5sw23aaWrKK0sq0yLJeVv5Vq
        4HKhEItk5DqvULGbWY/5fHB5645YcCtvLA==
X-Google-Smtp-Source: ABdhPJzw+n40XJT8Yfm4uKq/isemiJ+bPmz9L1hLVv3N2b0ESWqk01I4pIDN6SuYVHUiiOn3bneYBQ==
X-Received: by 2002:a05:6808:1455:b0:326:70d0:b194 with SMTP id x21-20020a056808145500b0032670d0b194mr3103294oiv.275.1652290714872;
        Wed, 11 May 2022 10:38:34 -0700 (PDT)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com. [209.85.160.51])
        by smtp.gmail.com with ESMTPSA id z18-20020a056808065200b00325cda1ffacsm935689oih.43.2022.05.11.10.38.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:38:33 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so3645851fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:38:33 -0700 (PDT)
X-Received: by 2002:a05:6870:d297:b0:e6:589e:2217 with SMTP id
 d23-20020a056870d29700b000e6589e2217mr3307305oae.291.1652290712525; Wed, 11
 May 2022 10:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220506160106.522341-1-mic@digikod.net> <152da06a-330d-3125-6f41-262e0751f41b@digikod.net>
 <CANiq72mST6rfJDVGGT2+=_FUCXwms6N8mo2eoLzQ6KW64M9BtQ@mail.gmail.com>
In-Reply-To: <CANiq72mST6rfJDVGGT2+=_FUCXwms6N8mo2eoLzQ6KW64M9BtQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 11 May 2022 10:38:20 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNdzV9nX3hSi7UsuDm0duqd+f-0=3ef5q=dOxu5wGodyA@mail.gmail.com>
Message-ID: <CA+ASDXNdzV9nX3hSi7UsuDm0duqd+f-0=3ef5q=dOxu5wGodyA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Fix clang-format configuration according to checkpatch.pl
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 8:29 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> I am thinking
> of putting Brian as author and you as Co-developed-by for the last one
> to be fair (Brian: is this OK with you too?). Thanks!

I don't care at all either way; it's a pretty trivial thing, and I
only posted mine to kick the wheels a bit. I'm just happy Micka=C3=ABl is
doing this :)

Regards,
Brian
