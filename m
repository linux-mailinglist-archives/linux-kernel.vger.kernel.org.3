Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFDB55B417
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiFZUyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiFZUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:54:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08243883
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:54:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z19so10405687edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6P3zC7r4qnr1luJY9BEvSQvlGGlGr98+TEUY9WUlLM=;
        b=GziGBpi7dQFfIG0Txygu2pnE6fjt94O2OQY6YUkszCaMMnCzFMZfPq2lo472IfIkuQ
         bIIKuBjGkGUctDV/KawGQViKWjhAkTcGa0dFqgWB1WYmRe/mBZsC4/NvC/RfOKPmqP34
         bjs0rruKGrlyoFzy24TAZKfII14+tbtVPmXiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6P3zC7r4qnr1luJY9BEvSQvlGGlGr98+TEUY9WUlLM=;
        b=i5yN5u7o8rpsR7YBrPUzII/9lGmtuj6tmmvRCSW7jAlzAj0HrculklAy99t14UOvw9
         a9t6fZOVvp5qSd85Untq2sE5yGl0VZhnTmlYNnLNwCi8i3DfibWi+CWO5yGUo7TEFtom
         aEF7wqHx6hMZYGwYoy9s7L4uKaWMlp4gS0Xo9jvvSQ/tFCAUOrcZ3dYjMBBQZjrZTHTB
         J+v7t5+Zf2A/b2LkYlW7/YYCtdaRQh7tLcmcymKkjSa1D2YdjW3yQLBm7Oac+Xgll1vq
         mYkB2B5s08UcA2jxWt8skPBwgnqRAAt+fa7ZjUSYKyVawZP93PXw9xtU8ej+7XeFEeqT
         s3NQ==
X-Gm-Message-State: AJIora9tf9rBvrBV7UzM59lY/q2pM8dohaoNTKRpVvRBX5l0aQRexYfY
        MY7NG82VBJUx4CBy8tLM7PujplN6RLjRYPoq
X-Google-Smtp-Source: AGRyM1vnUT8bEyUzqoOez+RCtGYfhLUQlSBQhwQ1u7qgEVLtf98bWyCrjwOPgnN4bHo/AZRvnDKRaA==
X-Received: by 2002:a50:ff0e:0:b0:433:5d15:eada with SMTP id a14-20020a50ff0e000000b004335d15eadamr12739879edu.102.1656276886321;
        Sun, 26 Jun 2022 13:54:46 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id a27-20020a170906275b00b00722e57fa051sm4123837ejd.90.2022.06.26.13.54.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 13:54:45 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id w17so10365535wrg.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:54:44 -0700 (PDT)
X-Received: by 2002:a5d:48c1:0:b0:21a:3574:e70c with SMTP id
 p1-20020a5d48c1000000b0021a3574e70cmr9249733wrs.97.1656276884478; Sun, 26 Jun
 2022 13:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com> <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
 <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
 <20220621005752.ohiq5besmy3r5rjo@moria.home.lan> <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
 <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
 <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
 <CAHk-=whwyxSpzgr+roEr7_V5wVenw9fV3EOAZhAYCAuRdEyChQ@mail.gmail.com> <93ab94ec92497af13c563c52fc7e1f7f81dac333.camel@perches.com>
In-Reply-To: <93ab94ec92497af13c563c52fc7e1f7f81dac333.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jun 2022 13:54:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4snadB1LiV=FAUTpHNumsF=GN=U5vckWaLMbnU5nfQA@mail.gmail.com>
Message-ID: <CAHk-=wi4snadB1LiV=FAUTpHNumsF=GN=U5vckWaLMbnU5nfQA@mail.gmail.com>
Subject: Re: [RFC[ Alloc in vsprintf
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 1:39 PM Joe Perches <joe@perches.com> wrote:
>
> OK, and that's true for all the temp stack buffers in every %p<foo>.

Yup.

A lot of them are simply due to it just being simple, and when the
temp buffer is of a fairly limited size, "simple is good".

But yeah, that KSYM_SYMBOL_LEN thing was questionable before, and as
it grows with KSYM_NAME_LEN growing, it's getting pretty ridiculous.

For example, the buffer in "number()" looks very reasonable to me,
since it's not only pretty small (24 bytes on 64-bit architectures).
it has that special alignment requirement too.

So I don't think those temporary stack buffers are necessarily wrong
in general, but there's a point where they go from "ok, there's being
_simple_ and then there's _overly_simplistic_".

                   Linus
