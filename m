Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF056BD4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiGHQDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbiGHQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:03:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45FF1171;
        Fri,  8 Jul 2022 09:03:28 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p129so8773528yba.7;
        Fri, 08 Jul 2022 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jC9bt20ORRlGeFu2nX1nb50U0xaaq8Zx5a1ATBqxDXc=;
        b=m7g34KswNMNK+JzrpiOl2eVrf2NkrwDYewCexb/DRwTdwQzrQS/LxtTRERGBB5f6dF
         sod11nuhuUNyU3vKNahTRSfBh6FPN8j5FXobLKn1glzxNg9UbhHQW7oq+cXdyPeDbJsc
         fVUNNG6A+7rIOFIh4iX3U0xQgK8x5lsrtp+9fB2v9BTzfSfcsf7FJD5mgsAUyC3MiwG+
         WQXEqh6zBc9gZq5tcN2NORS+4sh93YqR79IW+5brJpQacU7G49aAm79L7DRyftj9Sb2x
         jYWz1Ic/d2LLzIdiOEfq2DYdNxE2WrVwgXXqIwkWrQmrotXBxNciw8WQz5s/4A4Vmgpc
         9BqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jC9bt20ORRlGeFu2nX1nb50U0xaaq8Zx5a1ATBqxDXc=;
        b=mcvwOMUBw4fOEtXu9UQFZV8ahsZyXhDOpjMEGSy0U8y/K3yAmwlHfFHwlfxHybKw4j
         /ZKHRMrG8TU5nV7xsQqThZ60RTd8NqhPzzntnjXLazBzbFiSt5jq4u5iXditLVVMQ96m
         Ys1aAFFl6PAWuO3bfkYtWI4ZNDaMb0RcpdlM3wtpVwDD29K/ODiZacUBzVvChGEH7uhy
         epYRr0x6JrtA1btuZaEacgZkwhhJEzjzcrWmdx8kX8pIMM8yDXVxkvgHbpelJzE/apb3
         3cneklTxXhowEjMxVAYWW5ncNfe6GidJV/uS3GJ7HWp0nAwcJ5D0hbjg8RWDaY6yExPw
         eyew==
X-Gm-Message-State: AJIora9lPLWbYdIl5ledvJxrIQDf06D70LVhJFtFdCikPWOtMRBgvmFu
        F7JrVFKRu/UHjLWa9ZNAoQ+yAPj+DvYQmEnsgs8=
X-Google-Smtp-Source: AGRyM1trwccebaK2LpZ94bVBfS1ySQhGM68O7j7fP8z78jBh83olSDAoI6ao6IQOU9x6j9JMgYbih3qYt4w3gsS4eMg=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr4408148ybu.128.1657296207593; Fri, 08
 Jul 2022 09:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220705201026.2487665-1-imran.f.khan@oracle.com>
In-Reply-To: <20220705201026.2487665-1-imran.f.khan@oracle.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 18:02:51 +0200
Message-ID: <CAHp75Vc6Oc+cjt8dWBiUFSVnJB8CbkA52Y_OTOT32AwZQcEdMw@mail.gmail.com>
Subject: Re: [PATCH] Revert "kernfs: Change kernfs_notify_list to llist."
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Petr Mladek <pmladek@suse.com>
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

On Tue, Jul 5, 2022 at 10:24 PM Imran Khan <imran.f.khan@oracle.com> wrote:

...

> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Michael Walle <michael@walle.cc>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

A tag block mustn't include blank lines.


-- 
With Best Regards,
Andy Shevchenko
