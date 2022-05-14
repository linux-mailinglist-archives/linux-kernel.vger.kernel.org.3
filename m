Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C15270FF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 14:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiENMKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 08:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiENMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 08:10:41 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B09CE27;
        Sat, 14 May 2022 05:10:39 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id j84so8734465ybc.3;
        Sat, 14 May 2022 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdCmWq9zxuWmGFMg5JjBmDBXnZoUlT/mh06bYjG+Y50=;
        b=qJE0Q13glfPO2JTth07fMdpWqHX+R1f6UtXVPCyhumcTIp30bR4lojuvNABXXyhOCw
         t3yk1jpMK1zCxkMpi4NesdY2sgLgKxE3kvcYdyaiW4qF+YyvPw2F9u+rf/h8IFumJPBr
         btUKe8L9yv95+MDtnC3TtFoZUc9AoBfDEviK6tfxRVh3e6I7xsVuUG4Y4rVP+3EfZgLn
         wwmMcZgd7Fe1YWkWM0KrANKrhmlslOoSvOZyKEtZVljyVsB9KIMqHfezygk0HhMXE1Fn
         QdEE0W/8lVBYlUBYN6HbgQVlQC7OauqF3upZReHQv6Qdmu0L7Dp9pRmxM/K99oZKzmNX
         AVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdCmWq9zxuWmGFMg5JjBmDBXnZoUlT/mh06bYjG+Y50=;
        b=v70bd7GXgMdKPlaKQ8haqJUF23az6GnXfCUmMB/BNPV2btgxTzRoRJtZv4Lrkc05S0
         CAnRoIAYOu23WmcO4R4c8D/AiPPvCYmXJKuC6eoUVKlxkyF5B1bZ/xnjzyOhsOt73pbj
         x41Za8e2H3UePdK5/5+QqdoSkX2wH7K36LmchRjhKtu0UXWSvhg8zDI1itKeZygFETvt
         aKdSXpKxPjfbyPKK17onjJ+CFt/pucPEbx6TIen3UdyhCUedoD6wFiW/IK/XGcFd0tbl
         fgDskbJBOR2V42S1JKKfNQnBKQUEdcAxabYFfwO+b7Nd5nRbdSgRFv4yi2b3MOnMQ8iQ
         vujg==
X-Gm-Message-State: AOAM531u7k7p/AMxfyBwZJ2UrxXRldx8ejx5DeFgeSGl/+RsuGOExVM5
        Ba/SxVRMqVLRF3YBtqH60QgefYQXXB8yQmZuNoo=
X-Google-Smtp-Source: ABdhPJxwGPuHgwrJnT/LHqzW8LbabgFyrMndW4aMjD7nI3604/Xn7c8VeiTMJMefjKqAkcuB6S8vp8XmLpK96lyx020=
X-Received: by 2002:a25:df0a:0:b0:648:6364:a150 with SMTP id
 w10-20020a25df0a000000b006486364a150mr9128926ybg.381.1652530238541; Sat, 14
 May 2022 05:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220512182921.193462-1-max@enpas.org> <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
 <20220514130430.44a2aa21.max@enpas.org>
In-Reply-To: <20220514130430.44a2aa21.max@enpas.org>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sat, 14 May 2022 21:10:27 +0900
Message-ID: <CAMZ6RqKX+10GEEpm12QJ0JbKbACdicr+rRJbbmK8PP8HUCc8=w@mail.gmail.com>
Subject: Re: [PATCH v6] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri. 14 May 2022 at 20:04, Max Staudt <max@enpas.org> wrote:
> On Fri, 13 May 2022 11:38:31 +0900
> Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
> > > +/* Compare buffer to string length, then compare buffer to fixed
> > > string.
> > > + * This ensures two things:
> > > + *  - It flags cases where the fixed string is only the start of
> > > the
> > > + *    buffer, rather than exactly all of it.
> > > + *  - It avoids byte comparisons in case the length doesn't match.
> > > + *
> > > + * strncmp() cannot be used here because it accepts the following
> > > wrong case:
> > > + *   strncmp("CAN ER", "CAN ERROR", 6);
> >
> > What about:
> > strncmp("CAN ER", "CAN ERROR", 7);
> > ?
>
> NAK, because this may overread the buffer by one byte (the NUL byte).
> I am comparing naked bytes, not NUL-terminated strings.

Right, I missed the fact that the first argument was not Null terminated.
Your example is misleading: "CAN ER" is a string literal which is NULL
terminated, it doesn't reflect the use case.

My suggestion: first rename the function to reflect the feature it
brings. For example: elm327_rxbuff_cmp(). Naming it as if it was a
library is also misleading.

Also make it return bool.

For example, I would write it like in this fashion:

/*
 * elm327_rxfuff_cmp - compare received buffer against expected error message
 * @rxbuff: received buffer. Not NUL-terminated.
 * @rxbuff_len: size of @rxbuff.
 * @err_msg: error message against which we compare. Must be NUL-terminated.
 *
 * This function flags cases where the @rxbuff is only the start of @err_msg
 *  rather than exactly all of it.
 */
static inline bool elm327_rxbuff_cmp(const u8 *rxbuff, size_t
rxbuff_len, const char *err_msg)
{
       size_t err_len = strlen(err_msg);

       return (rxbuff_len == err_len) && !memcmp(rxbuff, err_msg, rxbuff_len);
}

Naming the arguments instead of using generic terms such as buffer and
string make it easier to follow what you are doing. The important
message is that @rxbuff is not terminated. With this information, it
becomes clear that the string functions can not be used in
replacement, no need to explicitly tell it.

[...]

Other answers are OK.
