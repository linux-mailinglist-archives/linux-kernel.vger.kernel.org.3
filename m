Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606AF4CE745
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiCEVsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiCEVsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:48:14 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1948C5006F;
        Sat,  5 Mar 2022 13:47:24 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so24359232eje.10;
        Sat, 05 Mar 2022 13:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zc9mq6hVzaRjLQEcIpq3l9xbumYlszQ9nEQAPa0hcT8=;
        b=oHhI9CdwIKIw2V5EkezeDZLy6C5w9JYFVa6xwIFz5MSTTcKDxIR/6ndolTmQVuAPYc
         HVRi+EuEcQua0Y86dEOI4Dh87rPQpRzdjAG+O3yoYfdk7loWFPanTTIr0FyLu+FqfShx
         zoKc+NvB8RAhJ2//hEv7+lUTdnMMhAmgGNX6BGW/PTVtBC7XfX8z8xFVrayXoND87nHj
         zq9soUmiBcMvZN8JG6QBLev9nL57pfl5a48kt4LDEolaUoTKL24klZmL3ApEwz+PT7ct
         1kj3TmgHza99hG9ihY/9dxxJhetsF3V504VM8byVhyVsEoewUQ7nDdo9iIrvBZO9rRV8
         q+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zc9mq6hVzaRjLQEcIpq3l9xbumYlszQ9nEQAPa0hcT8=;
        b=8BM8HHClB1vemR18PLfkgJ2VJ+fmLCm6Tr0jDctxPnBJTk6pg/q1wI1LIaBqbpizA3
         YqG788rUw8cKq0HnmCrnm/6uCqrCBHH8xN/EGGToNA9BKsr6jaVE6F2QFEShLSecc8pv
         z2kL3NLWtDsLf/Ipqx7Qjbsy4y70ty/wUh4v5NkHwbvW/guNYLgVzZC95NEqXHICYLr+
         3buD2yZRO0gRtOavjIuyhw3pioefkvPNegrrd9v5dWUdv3bLf+YW3soZa2hWubJ3AS6E
         muI9jqclMt+TjO9pdQqkBjmroCY+UpG3lLVws8InGfIdmao9wqmCEtKk3sEgBWbvwj1T
         xDfQ==
X-Gm-Message-State: AOAM530QvfwUeDF7FYsnX0DtE4tL9R3rpIgHT7iujpYIEwjG76WAhh+F
        iY1DA+2cmzuPys4ipnLrs4oqI6L/x+ogfMqDZWE=
X-Google-Smtp-Source: ABdhPJzV3+Tsi+h2uDFpfyBgn+UG9H0N55yeiyQRatFUr+RgHgMqteJzfFMct9WM0TME+hd8YqoDk+lAovFkbEX5TTg=
X-Received: by 2002:a17:907:728b:b0:6da:97db:b66d with SMTP id
 dt11-20020a170907728b00b006da97dbb66dmr3928537ejc.636.1646516842576; Sat, 05
 Mar 2022 13:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20220304173256.39059-1-andriy.shevchenko@linux.intel.com> <8afcf0b81f78ffdda8bcac5f0fd1d4c40dc4f8d6.camel@gmail.com>
In-Reply-To: <8afcf0b81f78ffdda8bcac5f0fd1d4c40dc4f8d6.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 5 Mar 2022 23:46:46 +0200
Message-ID: <CAHp75Vd7QcujZKEtx2_PT-QxoAh7LAykkV3k_OOO5Q0tRQKrBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 5, 2022 at 10:28 PM Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> On Fri, 2022-03-04 at 19:32 +0200, Andy Shevchenko wrote:
> > Some of the fwnode APIs might return an error pointer instead of NULL
> > or valid fwnode handle. The result of such API call may be considered
> > optional and hence the test for it is usually done in a form of
> >
> >         fwnode =3D fwnode_find_reference(...);
> >         if (IS_ERR_OR_NULL(fwnode))
> >                 ...error handling...
> >
> > Nevertheless the resulting fwnode may have bumped reference count and
> > hence caller of the above API is obliged to call fwnode_handle_put().
> > Since fwnode may be not valid either as NULL or error pointer the
> > check
> > has to be performed there. This approach uglifies the code and adds
> > a point of making a mistake, i.e. forgetting about error point case.
> >
> > To prevent this allow error pointer to be passed to the fwnode APIs.

...

> >         ret =3D fwnode_call_int_op(fwnode, property_read_string_array,
> > propname,
> >                                  val, nval);
> > -       if (ret =3D=3D -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
> > -           !IS_ERR_OR_NULL(fwnode->secondary))
> > +       if (ret =3D=3D -EINVAL && !IS_ERR_OR_NULL(fwnode->secondary))
> >                 ret =3D fwnode_call_int_op(fwnode->secondary,
> >                                          property_read_string_array,
>
> Isn't !IS_ERR_OR_NULL(fwnode->secondary)) redundant? AFAIU,
> fwnode_call_int_op() will already check the fwnode and only call the op
> if the pointer is valid...

It will shadow the error code, but it seems currently it's the same error c=
ode.
So, the question here is if we hide something important with that change.

I dunno what is the best approach here (esp. taking into account that
this is a fix), but ideally we should open code those macros to avoid
double test for fwnode being valid. Because it seems that validation
of fwnode and validation of the operation of the fwnode are orthogonal
and here we mix them. I made this way for the sake of easier
backporting and kicking off a discussion (as you already did). TL;DR:
I think the introduction of the macros was a controversial move, for
which I see pros and cons.


--=20
With Best Regards,
Andy Shevchenko
