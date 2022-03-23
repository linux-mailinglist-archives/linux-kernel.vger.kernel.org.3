Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A6F4E5735
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245720AbiCWRNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245710AbiCWRNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:13:46 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C557892B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:12:16 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bn33so2781182ljb.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dM4pcJiBV/awg1oo073JqIl31YIDpGaE/EgJFPs8wAs=;
        b=ItfWo5NdAT0PuC7laIcMECceoq0vJUY3m9ub8l6qo0aAI375KLdo5miTd4vOl/wPiq
         k7RU8heaGNRHky+eTCK0QkGkMr6Ln6AUWHbBqJhtP16bOJi1hQ0NiNsylKlGFDYyiWMJ
         lOxhbZx/ePVCZTiHAzjyKVPDFnHUKq9yYABJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dM4pcJiBV/awg1oo073JqIl31YIDpGaE/EgJFPs8wAs=;
        b=4xgs+RwfsKIJvF3FffZLhPXBUfFGXhr9Shj3Cf5KTB9pVZYa9Jby4HeeNV4YW/pib3
         xEQGgzt6c7fFxFyh+BCRh4pf5eb8ArbejA3+zbcOSdNnixlPFDpxYWUAOiud78i72Iy3
         IXu7BX7AFHpFZT2kduunMfO5MJlYaXVqIlBJBZTmzXTkwSkii2syrUDmzJtaMDM4ZanV
         hrfmZd86nbz66ay5VkNBlqO3EvHLs4tbMaQOgYlQGvXljiatXv8SmBQTqvEIbjFddVPv
         PZFuWdDuaE1RLGjxaEmWUslAJxeZ0glHltAUJviidU7sMr1rYbSuP97oUyPwWqMgxvsK
         HYnA==
X-Gm-Message-State: AOAM532LuHxLEWhHey6tLwyPk4BccRyvHOf5BYsdAWSlpei1enLZOQJ0
        uSHv0ZXDASJ5wYLsw9LU7/FimTnTfPN2sZq32Gg=
X-Google-Smtp-Source: ABdhPJzDP/C7I8C6urCvqZSpx2UhuAFcEMVMABT4t/i7KirIB9Zcr2hnn6qzbgz7kzPUNNoPDqNkOQ==
X-Received: by 2002:a2e:9203:0:b0:247:ebe3:7d0c with SMTP id k3-20020a2e9203000000b00247ebe37d0cmr818193ljg.278.1648055534293;
        Wed, 23 Mar 2022 10:12:14 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id b1-20020a196441000000b0044a39b5368bsm42533lfj.163.2022.03.23.10.12.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:12:13 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id p15so3787987lfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:12:13 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr643064lfj.449.1648055533141; Wed, 23 Mar
 2022 10:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <Yigc4cQlTJRRZsQg@gondor.apana.org.au> <20220322131327.GA747088@roeck-us.net>
 <YjqVblTmjNYl3Zjc@gondor.apana.org.au>
In-Reply-To: <YjqVblTmjNYl3Zjc@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 10:11:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKzJGO3bMv1hANBtnSAgt0A5X9rM2Lpd6YritqSsH0Yw@mail.gmail.com>
Message-ID: <CAHk-=wjKzJGO3bMv1hANBtnSAgt0A5X9rM2Lpd6YritqSsH0Yw@mail.gmail.com>
Subject: Re: [PATCH] cacheflush.h: Add forward declaration for struct folio
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Harsha <harsha.harsha@xilinx.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Tue, Mar 22, 2022 at 8:35 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> This should be fixed in cacheflush.h:

Applied. Thanks,

              Linus
