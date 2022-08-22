Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A635059C456
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiHVQpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbiHVQpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:45:22 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB9818393
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:45:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gt3so9963697ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hcFkdybpCNy+TrLwiiJNxRWM75St/es/Q6qYC3rPfCE=;
        b=gbP+Fv762ay8jKmLRSPptjSIc7rRdqRUlpV0zkkJmVORzUkMFDQa+RsU1RpPbEGCyq
         qSIQ4z2kdlsk6NLqzqS5cR6LOGKHKUHJJ9gP6RxlZbRpkQqNxnrLbvvTsBWZB7+MdOoY
         govbZ7BTknWj6L2kw+EBz9fvMd64Xnie6B1aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hcFkdybpCNy+TrLwiiJNxRWM75St/es/Q6qYC3rPfCE=;
        b=0gvUdhI7GGqo+rGWX8RGnjnbGATm7rxaxG7B/1mA/ho0BtrvLOJp/6U2muk8jihXjb
         9c7gx+eO6rTyCs/Kv1D11V+LxK7qt4RfcsldpEmlUP7AjMdmn9dhQSM9D19+Q25Xb6ry
         1o+GECXKJCWsSytiR+4gCK0hMqFUtue2xK7v8kMJ0tacLsc5vWgVorPjGDGPv/vwOXUw
         CdW7cCdSqZ7WkfuAEsS1jnUYFZTm7ifBbBQ41VagMipSi4zYDe5Wyml0bsI49TZlFo7T
         5B6pxphrWSvFnQYvrCKtXzpb+OPJPwG0lsb/XfYnW9rQukyId94siugcBLR76cjS3sR6
         2ndQ==
X-Gm-Message-State: ACgBeo2Fr52SK9tN61TvLI+JA3E4C+vL3PqeMkRIi05o3pPPUkWdyBcI
        c3Hp9paFLdW3id2d6QmrhKOdIZ/j/Nvhbdt1
X-Google-Smtp-Source: AA6agR6MV/c6UTLO1pD3/YTR7RfKvejeUHXttPuNiL7s3tAvWl3k628aQ8RPpfxY2o3Jq8XHyaPwyw==
X-Received: by 2002:a17:907:7d90:b0:738:2f9b:9869 with SMTP id oz16-20020a1709077d9000b007382f9b9869mr13993343ejc.186.1661186719237;
        Mon, 22 Aug 2022 09:45:19 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id l13-20020aa7d94d000000b004418c7d633bsm2912eds.18.2022.08.22.09.45.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 09:45:18 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so6333696wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:45:18 -0700 (PDT)
X-Received: by 2002:a05:600c:2195:b0:3a6:b3c:c100 with SMTP id
 e21-20020a05600c219500b003a60b3cc100mr12375309wme.8.1661186718159; Mon, 22
 Aug 2022 09:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220822092557.210209-1-yangjihong1@huawei.com>
 <YwNcgdk/p18Cr+uv@gmail.com> <YwOBKwPmW/FX6hSS@kernel.org>
In-Reply-To: <YwOBKwPmW/FX6hSS@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Aug 2022 09:45:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRLxmiTWiy4f1wa4S3NRK1kdZoAind_AtBGvNx=CdhYg@mail.gmail.com>
Message-ID: <CAHk-=wjRLxmiTWiy4f1wa4S3NRK1kdZoAind_AtBGvNx=CdhYg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix compile error for x86
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Yang Jihong <yangjihong1@huawei.com>, bp@suse.de,
        ndesaulniers@google.com, nathan@kernel.org,
        alexandre.belloni@bootlin.com, namhyung@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Aug 22, 2022 at 6:14 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Linus, I'll prep a pull req later today or you can apply this so that we
> can reduce the window where tools/perf/ isn't building.

Ok, I took that patch directly. Thanks,

              Linus
