Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AEB58CC12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243996AbiHHQYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbiHHQYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:24:42 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B009614D21;
        Mon,  8 Aug 2022 09:24:41 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b24so432439qka.5;
        Mon, 08 Aug 2022 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9LlB2T5/Ktkdp4+h2dNUH3viE5cqaKUYMhF8qyI39kk=;
        b=Ggwp5Xq79yAkjkfaqjg+4yl90dhY/9jp6ksgwver9RCzSiIn5x22eQW7CSsOH62jxv
         rEhvnz0bkrC9+L3kvl+F3oePv1TWDsn6+kuxuwl8MSgNykRNuKF0Vovcv3lfcg/mONOC
         glnXB85M18l4LgVqHZP/kuBniEx9WfW4qv+X5NiJE+ElmXLZxSb8QZTkfQMlcQ8K2xhS
         K4VaNkJ996lObBp8LssutEToDCPPjgbG8u/lKAszByYjtnI8FrEd4Hnje3F/0xipluo2
         gtz/iwLJPvH/bXnmb2Ou+vJKNQd/Sf/tHaCmLq11BV3kSrtIVADnMHN+HvedsbgQ6jpu
         pUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9LlB2T5/Ktkdp4+h2dNUH3viE5cqaKUYMhF8qyI39kk=;
        b=rP+ZRiOLWcfAH5fu+FxmiZjz0hPaPHBF+H0oyBSkg66jNrprZSWzaYYSYClx1E/L0W
         dxrojVUClWumOh9Tt5MClYIWzBv1NlxqtZ2AQHwW23yAKTz0t2eRv3xkP4qFYY8TIVcG
         kQou3rm64hZJ7TMZSI21+MsuI528LQg57jVxxvva4Lc5RTR188AfQmyRa023gKvSva9H
         KzAMtSJ6gwpU1o9zL9Y6jD+LqsZQKUehoqxjZoqkC/N8ReP9JGQAqmd5x/DTNpa33XAF
         QJ0wnNn7ReiL4sC0qQv7M0wJgAz5CVd77v0n3+fgxVy7BpST+W1w5K78Z0ggg84dsQuu
         GhCQ==
X-Gm-Message-State: ACgBeo1E0HwMwTNEHNocvHdvxynrj8bwdS86P4DJGJcARJp1q5R9yv5h
        G9Vax1xKmebgQH2kVvXldvCUajQcKY/aUn1NtsA=
X-Google-Smtp-Source: AA6agR58jXZx7W1R3kDfPgYf/ysCjCZyolGANT1QGQh3vQSmzjT9VWfqgw9EOALbFuoikpd6yShSrtKvtV6W/BRrALM=
X-Received: by 2002:a05:620a:8018:b0:6b6:5df:977 with SMTP id
 ee24-20020a05620a801800b006b605df0977mr14267090qkb.320.1659975880731; Mon, 08
 Aug 2022 09:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220808031132.10075-1-luke@ljones.dev> <20220808031132.10075-2-luke@ljones.dev>
 <CAHp75Vds+DmQdeuSM7ixtZiX60jg83CWveFZNcQoQ=QyiqcvUw@mail.gmail.com> <23e2630c-2328-40cd-836b-f3b619ff6a4b@redhat.com>
In-Reply-To: <23e2630c-2328-40cd-836b-f3b619ff6a4b@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 18:24:04 +0200
Message-ID: <CAHp75VcW+aSCSAE-FRqJxwwGWwDz+38GY4FrceWVso6BT8=sWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] asus-wmi: Adjust tablet/lidflip handling to use enum
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Luke D. Jones" <luke@ljones.dev>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Aug 8, 2022 at 6:13 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 8/8/22 17:48, Andy Shevchenko wrote:
> > On Mon, Aug 8, 2022 at 5:12 AM Luke D. Jones <luke@ljones.dev> wrote:

...

> > To the switch-cases, please add a "default" case to each of them.
>
> The switch-cases are on an enum type, so adding a default is
> not necessary and adding one will actually loose the useful
> compiler warning about unhandled enum values.

It's good if you can cover all enum values, which usually you can't.
enum according to the standard should be located in the type that is
enough to keep it and be compatible to a char. This means that the
code somewhere else may assign anything to enum (actually enum values
are type of int) and without default you can't see the difference here
and the compiler probably will be happy. That said, I doubt the
usefulness of such a warning. But it's up to you.

-- 
With Best Regards,
Andy Shevchenko
