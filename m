Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E52523F28
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347936AbiEKVBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiEKVBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:01:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8C4ECC6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:01:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j6so6383197ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1tl7xXEv44Olrg0x8oVrp2Kssd8uEg1zywWFAnvX38=;
        b=pvc4prrKU6XYpVg12K45Z7E2sOJoKAGRX2na2HU3OywNrKnH7faNKDEESDjHs7Hlf/
         PLVlxIB0eZVlZwE63sN+qwm6mJPQKBIjefbBqJsDf45ATJX+0LrqD26TiwiZxME9STRA
         kfVcKOqr5+c0sXl5Xl7sHhIc6hljvb4RCd0LB8FQLkRkLXNWOYMN/sDYyo5zohhg/MzG
         sxyfA9ZEzFEQlqXpNdykAd7UrFXNhlMnWqR+zMQmzzVYzYepY0F4Usx/4OROO6TYgp70
         VulMgiiSLQZUQUXX1/cHfC0NUtSNNAX/ViwOsE5wqYe1Xima8kW4Sg9wll5H0yJvp7Bw
         XQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1tl7xXEv44Olrg0x8oVrp2Kssd8uEg1zywWFAnvX38=;
        b=SJDrkB7xhyWmaZVB9yYWNXKHLJfq0u7c8bUxtihojGxcNuUSVizUgWRHju+GxSknSt
         ySRVA/meslfXW0+XERsFloNYbK+WpfsVUdUgtFPRF86ogMqc7ZwusvsLmuee99O5Yf3z
         +nBd7WWabpORo4fz+PZZAM1oQejerhddaBb8h3zjk0549rXaSqHFI+IYag4+4Z1fcZ19
         xiJgS2p0OjgX0A3cs2a+CR0rfHdTtbo3suJixkpgBaErFv5aaxVZQLHEOlmNJWVqwBsl
         Oe2HrLngnTmmK1yzds+Y/v/SwsHiqeJt13Y6S0w3xbCG2tEwQBfNObCBXjUnV+H6mZ9x
         of4g==
X-Gm-Message-State: AOAM531J8BTLGYObag6v9YVQijefMQm+EoKMi8JpbMLY9GYoM7s9FFHh
        eIbFOtbE/NKA0u05ect/c2SEIV8FVAgQaVP4MS/T4Q==
X-Google-Smtp-Source: ABdhPJwUSKpTjorzdIPUZWjpRBG2eay5ikujKcbGi97kVFsww2FYroBfaYoh59bIWj6/q4C3u2tbKhV/fDB6bfzdRt0=
X-Received: by 2002:a17:907:8a14:b0:6f4:4365:dc07 with SMTP id
 sc20-20020a1709078a1400b006f44365dc07mr25673197ejc.693.1652302876658; Wed, 11
 May 2022 14:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220329214248.1330868-1-dlatypov@google.com>
In-Reply-To: <20220329214248.1330868-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 May 2022 17:01:03 -0400
Message-ID: <CAFd5g46VNn=6t-xuwyBJ0uuzHGY26eoxO-CmKjs3m50yMHwN=g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: print clearer error message when there's no
 TAP output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 5:43 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Before:
> $ ./tools/testing/kunit/kunit.py parse /dev/null
> ...
> [ERROR] Test : invalid KTAP input!
>
> After:
> $ ./tools/testing/kunit/kunit.py parse /dev/null
> ...
> [ERROR] Test <missing>: could not find any KTAP output!
>
> This error message gets printed out when extract_tap_output() yielded no
> lines. So while it could be because of malformed KTAP output from KUnit,
> it could also be due to to not having any KTAP output at all.
>
> Try and make the error message here more clear.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
