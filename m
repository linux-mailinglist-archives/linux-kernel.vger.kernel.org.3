Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58B849EDB5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiA0Vrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiA0Vrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:47:31 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A11C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:47:31 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y17so3932789plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QCStN9BrIDnNCSI/BUYziPM0hObHG9E426b+siOf0g=;
        b=ZTIl7goTHUeMWeEnI2m4Vcr3O4vp3RAf4rjgqKppDmYWr2MqfR0RHLmBogxr7xnk12
         8QpgjNdFQD3EJmAU6U/ak7M4QJHAGkyUAQ4xRDlFDc7KrbexWiEEudek5XR8OWs6wXoX
         1mjRKVINqxJJirs3xb2/6vh9sPBCkmF89qdrWwPJAnuQAgdRt6i4Rtp/T6EvzNfAMjT0
         XPf05o/LEx7qQ167A8RrzGiPJdAHkvBcTA4kXwlCNBwrErNIVZ5UJmn4vtoKedU9uMg3
         gOFelQ77qb+skIIpe6WMnlzAyvHwURtKG434i3y+SwBB2R5QRdTQU+6+5xh/9tBBr9Ap
         KrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QCStN9BrIDnNCSI/BUYziPM0hObHG9E426b+siOf0g=;
        b=W/XSbiEVKx9cqx2xI1uaNuvjdBnzNxJCNzJuTZYazyihvwR6ujjWKhLUQlmEeXMBEZ
         T7XGnt1At1DoAJDGS0+AWnqVlNh2UiHFg3UCaFRIo8LMtYrJpDXKi0VNVdGHdsDSWLEh
         HLf6JMtM0RsExROzVOHfq7IpsY69YiuFOWncBl+DKr/ZDOConEeooEfgQStXH6SvkJ7r
         cTUiwzozQu5ZMBJQAguMlwT0NPWSFuWgBBdLlkNGm2yCDDZm2uy3UrSbSOZUuGk573JS
         VCUiSa6sHvduYpic0wpGhWTTD2Rswclvewq2Xs9bwEb+7IfLRWMPP2fIIBXo+pIOXVmc
         e59g==
X-Gm-Message-State: AOAM533o880YNcbfn/3VmJiFJtgqOxEOa446NxBpKgmhOHlO3Jy/T107
        icUapxQ7FbiCWbhAKbtuaKO/Lr3/cYY5X2eBix11ui5QogcRLg==
X-Google-Smtp-Source: ABdhPJxaVoaIShV6Pzw1zRchbe939xLN5ZNTCwP2aP1jyzs5ZSoVNrUrWKRZ4bSUpgdhLg/zaczZY/A/iwgW0GRZz5Y=
X-Received: by 2002:a17:902:ecc2:: with SMTP id a2mr5041997plh.12.1643320050701;
 Thu, 27 Jan 2022 13:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com> <20220125210011.3817742-4-dlatypov@google.com>
 <CABVgOSm4EWFK5-KWto1HF3AEY9c77s5MufufXRDek3PAcWCccA@mail.gmail.com>
In-Reply-To: <CABVgOSm4EWFK5-KWto1HF3AEY9c77s5MufufXRDek3PAcWCccA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 27 Jan 2022 16:47:19 -0500
Message-ID: <CAFd5g46snbBzjTtUJcb=PN=SZrDwVFVCnFhdKnXPaFXre8hn7Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: factor out str constants from binary assertion structs
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:39 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, Jan 26, 2022 at 5:00 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > If the compiler doesn't optimize them away, each kunit assertion (use of
> > KUNIT_EXPECT_EQ, etc.) can use 88 bytes of stack space in the worst and
> > most common case. This has led to compiler warnings and a suggestion
> > from Linus to move data from the structs into static const's where
> > possible [1].
> >
> > This builds upon [2] which did so for the base struct kunit_assert type.
> > That only reduced sizeof(struct kunit_binary_assert) from 88 to 64.
> >
> > Given these are by far the most commonly used asserts, this patch
> > factors out the textual representations of the operands and comparator
> > into another static const, saving 16 more bytes.
> >
> > In detail, KUNIT_EXPECT_EQ(test, 2 + 2, 5) yields the following struct
> >   (struct kunit_binary_assert) {
> >     .assert = <struct kunit_assert>,
> >     .operation = "==",
> >     .left_text = "2 + 2",
> >     .left_value = 4,
> >     .right_text = "5",
> >     .right_value = 5,
> >   }
> > After this change
> >   static const struct kunit_binary_assert_text __text = {
> >     .operation = "==",
> >     .left_text = "2 + 2",
> >     .right_text = "5",
> >   };
> >   (struct kunit_binary_assert) {
> >     .assert = <struct kunit_assert>,
> >     .text = &__text,
> >     .left_value = 4,
> >     .right_value = 5,
> >   }
> >
> > This also DRYs the code a bit more since these str fields were repeated
> > for the string and pointer versions of kunit_binary_assert.
> >
> > Note: we could name the kunit_binary_assert_text fields left/right
> > instead of left_text/right_text. But that would require changing the
> > macros a bit since they have args called "left" and "right" which would
> > be substituted in `.left = #left` as `.2 + 2 = \"2 + 2\"`.
> >
> > [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
> > [2] https://lore.kernel.org/linux-kselftest/20220113165931.451305-6-dlatypov@google.com/
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> This definitely _feels_ like it's adding a bit more complexity than
> would be ideal by splitting this out into a separate function, but I
> do agree that it's worth it.

Agreed.

> I think left_text / right_text are good enough names, too: I wouldn't
> bother trying to make them .left/.right.

Yeah, I don't think it matters too much either.

> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
> >  include/kunit/assert.h | 49 +++++++++++++++++++-----------------------
> >  include/kunit/test.h   | 20 +++++++++++------
> >  lib/kunit/assert.c     | 38 ++++++++++++++++----------------
> >  3 files changed, 54 insertions(+), 53 deletions(-)
> >
> > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > index 649bfac9f406..4b52e12c2ae8 100644
> > --- a/include/kunit/assert.h
> > +++ b/include/kunit/assert.h
> > @@ -150,14 +150,25 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
> >         .value = val                                                           \
> >  }
> >
> > +/**
> > + * struct kunit_binary_assert_text - holds strings for &struct
> > + *     kunit_binary_assert and friends to try and make the structs smaller.
> > + * @operation: A string representation of the comparison operator (e.g. "==").
> > + * @left_text: A string representation of the left expression (e.g. "2+2").
> > + * @right_text: A string representation of the right expression (e.g. "2+2").
> > + */
> > +struct kunit_binary_assert_text {
> > +       const char *operation;
> > +       const char *left_text;
> > +       const char *right_text;
> > +};
> > +
> >  /**
> >   * struct kunit_binary_assert - An expectation/assertion that compares two
> >   *     non-pointer values (for example, KUNIT_EXPECT_EQ(test, 1 + 1, 2)).
> >   * @assert: The parent of this type.
> > - * @operation: A string representation of the comparison operator (e.g. "==").
> > - * @left_text: A string representation of the expression in the left slot.
> > + * @text: Holds the textual representations of the operands and op (e.g.  "==").
> >   * @left_value: The actual evaluated value of the expression in the left slot.
> > - * @right_text: A string representation of the expression in the right slot.
> >   * @right_value: The actual evaluated value of the expression in the right slot.
> >   *
> >   * Represents an expectation/assertion that compares two non-pointer values. For
> > @@ -166,10 +177,8 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
> >   */
> >  struct kunit_binary_assert {
> >         struct kunit_assert assert;
> > -       const char *operation;
> > -       const char *left_text;
> > +       const struct kunit_binary_assert_text *text;
> >         long long left_value;
> > -       const char *right_text;
> >         long long right_value;
> >  };
> >
> > @@ -182,10 +191,8 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> >   *     kunit_binary_assert, kunit_binary_ptr_assert, etc.
> >   *
> >   * @format_func: a function which formats the assert to a string.
> > - * @op_str: A string representation of the comparison operator (e.g. "==").
> > - * @left_str: A string representation of the expression in the left slot.
> > + * @text_: Pointer to a kunit_binary_assert_text.
> >   * @left_val: The actual evaluated value of the expression in the left slot.
> > - * @right_str: A string representation of the expression in the right slot.
> >   * @right_val: The actual evaluated value of the expression in the right slot.
> >   *
> >   * Initializes a binary assert like kunit_binary_assert,
> > @@ -194,16 +201,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> >   * This is ultimately used by binary assertion macros like KUNIT_EXPECT_EQ, etc.
> >   */
> >  #define KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,                          \
> > -                                       op_str,                                \
> > -                                       left_str,                              \
> > +                                       text_,                                 \
> >                                         left_val,                              \
> > -                                       right_str,                             \
> >                                         right_val) {                           \
> >         .assert = { .format = format_func },                                   \
> > -       .operation = op_str,                                                   \
> > -       .left_text = left_str,                                                 \
> > +       .text = text_,                                                         \
> >         .left_value = left_val,                                                \
> > -       .right_text = right_str,                                               \
> >         .right_value = right_val                                               \
> >  }
> >
> > @@ -211,10 +214,8 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> >   * struct kunit_binary_ptr_assert - An expectation/assertion that compares two
> >   *     pointer values (for example, KUNIT_EXPECT_PTR_EQ(test, foo, bar)).
> >   * @assert: The parent of this type.
> > - * @operation: A string representation of the comparison operator (e.g. "==").
> > - * @left_text: A string representation of the expression in the left slot.
> > + * @text: Holds the textual representations of the operands and op (e.g.  "==").
> >   * @left_value: The actual evaluated value of the expression in the left slot.
> > - * @right_text: A string representation of the expression in the right slot.
> >   * @right_value: The actual evaluated value of the expression in the right slot.
> >   *
> >   * Represents an expectation/assertion that compares two pointer values. For
> > @@ -223,10 +224,8 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> >   */
> >  struct kunit_binary_ptr_assert {
> >         struct kunit_assert assert;
> > -       const char *operation;
> > -       const char *left_text;
> > +       const struct kunit_binary_assert_text *text;
> >         const void *left_value;
> > -       const char *right_text;
> >         const void *right_value;
> >  };
> >
> > @@ -238,10 +237,8 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
> >   * struct kunit_binary_str_assert - An expectation/assertion that compares two
> >   *     string values (for example, KUNIT_EXPECT_STREQ(test, foo, "bar")).
> >   * @assert: The parent of this type.
> > - * @operation: A string representation of the comparison operator (e.g. "==").
> > - * @left_text: A string representation of the expression in the left slot.
> > + * @text: Holds the textual representations of the operands and comparator.
> >   * @left_value: The actual evaluated value of the expression in the left slot.
> > - * @right_text: A string representation of the expression in the right slot.
> >   * @right_value: The actual evaluated value of the expression in the right slot.
> >   *
> >   * Represents an expectation/assertion that compares two string values. For
> > @@ -250,10 +247,8 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
> >   */
> >  struct kunit_binary_str_assert {
> >         struct kunit_assert assert;
> > -       const char *operation;
> > -       const char *left_text;
> > +       const struct kunit_binary_assert_text *text;
> >         const char *left_value;
> > -       const char *right_text;
> >         const char *right_value;
> >  };
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index a93dfb8ff393..088ff394ae94 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -874,16 +874,19 @@ void kunit_do_failed_assertion(struct kunit *test,
> >  do {                                                                          \
> >         typeof(left) __left = (left);                                          \
> >         typeof(right) __right = (right);                                       \
> > +       static const struct kunit_binary_assert_text __text = {                \
> > +               .operation = #op,                                              \
> > +               .left_text = #left,                                            \
> > +               .right_text = #right,                                          \
> > +       };                                                                     \
> >                                                                                \
> >         KUNIT_ASSERTION(test,                                                  \
> >                         assert_type,                                           \
> >                         __left op __right,                                     \
> >                         assert_class,                                          \
> >                         KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,           \
> > -                                                       #op,                   \
> > -                                                       #left,                 \
> > +                                                       &__text,               \
> >                                                         __left,                \
> > -                                                       #right,                \
> >                                                         __right),              \
> >                         fmt,                                                   \
> >                         ##__VA_ARGS__);                                        \
> > @@ -928,17 +931,20 @@ do {                                                                             \
> >                                    ...)                                        \
> >  do {                                                                          \
> >         const char *__left = (left);                                           \
> > -       const char *__right = (right);                                 \
> > +       const char *__right = (right);                                         \
> > +       static const struct kunit_binary_assert_text __text = {                \
> > +               .operation = #op,                                              \
> > +               .left_text = #left,                                            \
> > +               .right_text = #right,                                          \
> > +       };                                                                     \
> >                                                                                \
> >         KUNIT_ASSERTION(test,                                                  \
> >                         assert_type,                                           \
> >                         strcmp(__left, __right) op 0,                          \
> >                         kunit_binary_str_assert,                               \
> >                         KUNIT_INIT_BINARY_ASSERT_STRUCT(kunit_binary_str_assert_format,\
> > -                                                       #op,                   \
> > -                                                       #left,                 \
> > +                                                       &__text,               \
> >                                                         __left,                \
> > -                                                       #right,                \
> >                                                         __right),              \
> >                         fmt,                                                   \
> >                         ##__VA_ARGS__);                                        \
> > diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> > index c9c7ee0dfafa..d00d6d181ee8 100644
> > --- a/lib/kunit/assert.c
> > +++ b/lib/kunit/assert.c
> > @@ -122,18 +122,18 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> >
> >         string_stream_add(stream,
> >                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> > -                         binary_assert->left_text,
> > -                         binary_assert->operation,
> > -                         binary_assert->right_text);
> > -       if (!is_literal(stream->test, binary_assert->left_text,
> > +                         binary_assert->text->left_text,
> > +                         binary_assert->text->operation,
> > +                         binary_assert->text->right_text);
> > +       if (!is_literal(stream->test, binary_assert->text->left_text,
> >                         binary_assert->left_value, stream->gfp))
> >                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
> > -                                 binary_assert->left_text,
> > +                                 binary_assert->text->left_text,
> >                                   binary_assert->left_value);
> > -       if (!is_literal(stream->test, binary_assert->right_text,
> > +       if (!is_literal(stream->test, binary_assert->text->right_text,
> >                         binary_assert->right_value, stream->gfp))
> >                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
> > -                                 binary_assert->right_text,
> > +                                 binary_assert->text->right_text,
> >                                   binary_assert->right_value);
> >         kunit_assert_print_msg(message, stream);
> >  }
> > @@ -150,14 +150,14 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
> >
> >         string_stream_add(stream,
> >                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> > -                         binary_assert->left_text,
> > -                         binary_assert->operation,
> > -                         binary_assert->right_text);
> > +                         binary_assert->text->left_text,
> > +                         binary_assert->text->operation,
> > +                         binary_assert->text->right_text);
> >         string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
> > -                         binary_assert->left_text,
> > +                         binary_assert->text->left_text,
> >                           binary_assert->left_value);
> >         string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px",
> > -                         binary_assert->right_text,
> > +                         binary_assert->text->right_text,
> >                           binary_assert->right_value);
> >         kunit_assert_print_msg(message, stream);
> >  }
> > @@ -190,16 +190,16 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
> >
> >         string_stream_add(stream,
> >                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> > -                         binary_assert->left_text,
> > -                         binary_assert->operation,
> > -                         binary_assert->right_text);
> > -       if (!is_str_literal(binary_assert->left_text, binary_assert->left_value))
> > +                         binary_assert->text->left_text,
> > +                         binary_assert->text->operation,
> > +                         binary_assert->text->right_text);
> > +       if (!is_str_literal(binary_assert->text->left_text, binary_assert->left_value))
> >                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"\n",
> > -                                 binary_assert->left_text,
> > +                                 binary_assert->text->left_text,
> >                                   binary_assert->left_value);
> > -       if (!is_str_literal(binary_assert->right_text, binary_assert->right_value))
> > +       if (!is_str_literal(binary_assert->text->right_text, binary_assert->right_value))
> >                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"",
> > -                                 binary_assert->right_text,
> > +                                 binary_assert->text->right_text,
> >                                   binary_assert->right_value);
> >         kunit_assert_print_msg(message, stream);
> >  }
> > --
> > 2.35.0.rc2.247.g8bbb082509-goog
> >
