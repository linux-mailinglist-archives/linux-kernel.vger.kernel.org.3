Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7958C811
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbiHHMDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiHHMDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:03:42 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2916177
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:03:40 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o3so4910774qkk.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ERavs2OZuaSZotSZxpUy6MvIXcD6G78fPlu5KuS1KfQ=;
        b=qAGmUoMzYkkG51PGZWvUoHKzC2nH4OP0h46jDDHfdKVPj9c4FOhPoXserkrZ6Wkvk+
         o61vsVsS67bNxw0NSRAOgr/8UGNxyBNAVCs5OKDTqIPe1e2GqkSGz6aOD8TONkiPBEoT
         GO08RiMUZkOocK3KmaR4Pu6lMz/EUWBJsyguC6AHgeV/H7W1984eH8XtJFlpSsSvJj9O
         N8DK7UGQGG+BwLAAeub2dcmRuoU6ND+LA7czafWoRKKB2s9SSRUF+q9lm5K4X0YNpJZn
         kOZRYHe7LB9r1HM1tyLA8tS1OV+I28XEK94VU5LQf4oRQrm3GKdc6NYwGByaLXYNN6se
         mp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ERavs2OZuaSZotSZxpUy6MvIXcD6G78fPlu5KuS1KfQ=;
        b=KVefmVI8CVjdNMhADpiZakyzcalCloymu4y371Why4l1F2+PZYZ0xo1BtmRSHdA8xC
         MgnFZgsapon+H+UMIWnGOfyx2vB3vkEjatOUhxk+Rvki7TgN8NeC7wp1fh8lGLiDqCXF
         nw4ELzCxGVS+ytsEje1YNnPm8qNXUzUaSMuLbQV4DmaT54Uhx00av9O08Fm7D6getMA0
         nT19v8WCxoiMUccYTXhPee/4nWjCOjAr4sjNA4LcqmC5spJyx0pIyBir+vmwaojO7MVT
         fDwQ8p7LxOdocfSKWXR93URPLRVfdwHokQ27i5flCd91jid8Z2jBylgmV8HsGbA5RGr0
         JrRw==
X-Gm-Message-State: ACgBeo0QUIzN4ZtnxSAFC/y9kTkidVnENacQflz+A31aAr3zfdBLd4Oo
        k+/BnIosFJ7YwuvQg7Y2/XAGwwZMPxgm5McZ93E=
X-Google-Smtp-Source: AA6agR4eZae+wfOdZpiOVUC2U4vaR2uH0zIZWXcwgiTo9eJyCqYtZqTotC7OsbVLPUZtEVc6WRL+rBMvmc7iXGc7jsg=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr13874753qkp.504.1659960219392; Mon, 08
 Aug 2022 05:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220808024128.3219082-1-willy@infradead.org> <20220808024128.3219082-3-willy@infradead.org>
In-Reply-To: <20220808024128.3219082-3-willy@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 14:03:02 +0200
Message-ID: <CAHp75Vcua1dCZQ-ZvcAxkorfXzr6rmJO6=wVYLoomdMzLXDRtw@mail.gmail.com>
Subject: Re: [PATCH v5 02/32] lib/string_helpers: Convert string_escape_mem()
 to printbuf
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andy@kernel.org>
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

On Mon, Aug 8, 2022 at 4:41 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> From: Kent Overstreet <kent.overstreet@gmail.com>
>
> Like the upcoming vsprintf.c conversion, this converts string_escape_mem
> to prt_escaped_string(), which uses and outputs to a printbuf, and makes
> string_escape_mem() a smaller wrapper to support existing users.
>
> The new printbuf helpers greatly simplify the code.

...

>  struct device;
>  struct file;
>  struct task_struct;
> +struct printbuf;

Keep it ordered?

...

> @@ -71,6 +74,7 @@ static inline int string_escape_mem_any_np(const char *src, size_t isz,
>         return string_escape_mem(src, isz, dst, osz, ESCAPE_ANY_NP, only);
>  }
>
> +
>  static inline int string_escape_str(const char *src, char *dst, size_t sz,
>                 unsigned int flags, const char *only)
>  {

Stray change.

...

>                 if (!(is_append || in_dict) && is_dict &&
> -                                         escape_passthrough(c, &p, end))
> +                   escape_passthrough(out, c))

That (a bit strange) indentation is on purpose. Can we keep it?

>                         continue;

...

Not sure if the below was in the original text, but maybe it makes
sense to amend.

> + * Description:
> + * The process of escaping byte buffer includes several parts. They are applied

a byte in the buffer (?)

> + * in the following sequence.
> + *
> + *     1. The character is not matched to the one from @only string and thus
> + *        must go as-is to the output.
> + *     2. The character is matched to the printable and ASCII classes, if asked,
> + *        and in case of match it passes through to the output.
> + *     3. The character is matched to the printable or ASCII class, if asked,
> + *        and in case of match it passes through to the output.
> + *     4. The character is checked if it falls into the class given by @flags.
> + *        %ESCAPE_OCTAL and %ESCAPE_HEX are going last since they cover any
> + *        character. Note that they actually can't go together, otherwise
> + *        %ESCAPE_HEX will be ignored.
> + *
> + * Caller must provide valid source and destination pointers. Be aware that
> + * destination buffer will not be NULL-terminated, thus caller have to append

the caller has

> + * it if needs. The supported flags are::

if needed.

-- 
With Best Regards,
Andy Shevchenko
