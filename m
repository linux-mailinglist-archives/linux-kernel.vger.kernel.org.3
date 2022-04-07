Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F124F8A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiDGWLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 18:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiDGWKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:10:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FD1FD02
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:08:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a6so13770920ejk.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=STQ9sdu7fcjWHfFUdOtymgRVheoNmkf792JQ6ogqgQc=;
        b=VPYvHsDyI4ltaYQ7gEJm6N87rAkuNORBkK+KUXazodPOUi0+MPk3BDKylYtRD333kq
         3JELxOBUeEDCAP62xPCqomIUgkqWBd/xKWFvF+3ZRlU6r/zFo1CvHtmrlp5xQCP7RZOA
         34B2fkawD5vMVVWzegnKEIxQC2i8TpC2WUdRZMjJ0U5SZPtVxHm1Ids7CeubKKWJkr65
         D9XUPkplVlT1EDjyS9CoFKDihVPck1Bdd+TeZCRmQKZXfKOCat0GKVrVf819EwPXa7IZ
         MtQ74t74r7L5CGvaygu8IzVfVfiOLhn4Bna9cldfu4hKdDeC7Zon2kuK6yIXlHvIKC9+
         W6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=STQ9sdu7fcjWHfFUdOtymgRVheoNmkf792JQ6ogqgQc=;
        b=ieo+7yIqf2OMRezkmZ83hQ1QCSHUHcEXR4wP9+Jmd0b0NLTaOKeetWThlH18yWVlDd
         +yY+kOHP/feWFtQLpwdKsSziw2lFLnkMxGgxXebhYfn4Vy5x3dk8iiKrQg1I6bqWm+0O
         95Et7Q9o49rlJ4J9uWZWIeJLJMG3vrFUT/1pd60jvkk/0nBn6vMlyGi4rEKThxUyd3LX
         Zjp06nyRGMv/3bhP/vH7JSZiPOX3Rx01S5QSwGA4GSBk9HThKYcgiGlqDLcnXIJlrLbJ
         cNZzMvJYS9o7dHA5qNIYHsKeA3uq6UQiFMBztoX39ZHl1DJqggSqaK/bEvMIwMlqZ49u
         WcxA==
X-Gm-Message-State: AOAM532BatCNOtpNQJxKlivyXs7Xa+hxKGzfMRNz9mUgmWmSkF44ZeSK
        clEdur/TVni4nees33A6sse2GalbajnVvsKnFe4=
X-Google-Smtp-Source: ABdhPJztQu5iz7A/k7lIkibFVDDWGxJhSMYYuhcwi7vb3CyHXnlQvnpHugYlDSBaHVYW4AN0FXy13E3c7IteSQ5FQ1g=
X-Received: by 2002:a17:907:8a26:b0:6e1:2646:ef23 with SMTP id
 sc38-20020a1709078a2600b006e12646ef23mr15982957ejc.109.1649369303851; Thu, 07
 Apr 2022 15:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220407154430.22387-1-duoming@zju.edu.cn>
In-Reply-To: <20220407154430.22387-1-duoming@zju.edu.cn>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 7 Apr 2022 15:08:12 -0700
Message-ID: <CAMo8BfKneeVQrQOLG_v1AGupfSiXx=C34pHjP-nFV38eUGUwDQ@mail.gmail.com>
Subject: Re: [PATCH V2 11/11] arch: xtensa: platforms: Fix deadlock in rs_close()
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Jiri Slaby <jirislaby@kernel.org>,
        alexander.deucher@amd.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>, s.shtylyov@omp.ru
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 8:44 AM Duoming Zhou <duoming@zju.edu.cn> wrote:
>
> There is a deadlock in rs_close(), which is shown
> below:
>
>    (Thread 1)              |      (Thread 2)
>                            | rs_open()
> rs_close()                 |  mod_timer()
>  spin_lock_bh() //(1)      |  (wait a time)
>  ...                       | rs_poll()
>  del_timer_sync()          |  spin_lock() //(2)
>  (wait timer to stop)      |  ...
>
> We hold timer_lock in position (1) of thread 1 and
> use del_timer_sync() to wait timer to stop, but timer handler
> also need timer_lock in position (2) of thread 2.
> As a result, rs_close() will block forever.
>
> This patch deletes the redundant timer_lock in order to
> prevent the deadlock. Because there is no race condition
> between rs_close, rs_open and rs_poll.
>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in V2:
>   - Remove the timer_lock.
>
>  arch/xtensa/platforms/iss/console.c | 8 --------
>  1 file changed, 8 deletions(-)

Thanks. Applied to my xtensa tree.

-- Max
