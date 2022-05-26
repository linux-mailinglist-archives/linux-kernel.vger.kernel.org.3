Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AADA53524A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344956AbiEZQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiEZQme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:42:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB3A2B184
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:42:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v15so49253edl.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CS+0C9116uvsXBY7Qgz+7y8K9WB8FdT9j6xZ5iT4ego=;
        b=La+B/5HOPMqeQ2jcp0ah8wbzOcZKyNemQaHwQ4VCK7IBBU57xfK48vqU0oScXSzYwP
         5FnoG3FzyCWct1+Ebttkf5m6Z2FAUua2Tu7YIIk+bRLhRZQRZZpI0mB4N9bHIjQHTMOA
         Fnw2mLEgcWV/Qt2LRpttaqkCrTmAhUxy6QssE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CS+0C9116uvsXBY7Qgz+7y8K9WB8FdT9j6xZ5iT4ego=;
        b=Q+Y8c35Swbs0wBnf8HG6kmRdCct447Y6RBvcpkKy+ogQIlDe9PxaaoOm8ecx3Ur2uG
         EH33wHQvO0NYvsCzslMNIx2OCrMk4g0AHtyWGzbo2iU6rx0iskNHdHTclWVKykCXbupa
         ICVah9sAKrrTV+Hui2GLaCULnPmqYu4LhmMGLoBuZc7PrwzyKW3E/+jTO+OK0yy6A1Rh
         HgkO0/04ZLPCWWK8IHpogilFVnuQHF6s+h3alUed3e+vOuJs4Sc0juHcmhlyRh9K2kh9
         wAgIxgaeCx8fkwyjCCm1c2U5Kn+4iDa2PdhUE7XDBQ14cN5x9W/DN0b4T8B3BH2/0iPM
         56ww==
X-Gm-Message-State: AOAM530QFQFx0nFaP9toJh8L26deeFxaCtTijCq9yySKC1F+I97jzd6K
        t2WZVDfE4nS4OIjGSdHIXs9YSLx1TfrqtZBF9WA=
X-Google-Smtp-Source: ABdhPJxibSZS8D35z1TZm2bsBtJX+a/2xKwGmLwz5tfCKUe37VIX1VwyCPXPB8GLboIBMWApZpLbTw==
X-Received: by 2002:a05:6402:2392:b0:42b:de42:c4b with SMTP id j18-20020a056402239200b0042bde420c4bmr3329730eda.368.1653583352085;
        Thu, 26 May 2022 09:42:32 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id m22-20020a17090679d600b006f3ef214da9sm685250ejo.15.2022.05.26.09.42.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 09:42:30 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id j25so2823203wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:42:30 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr25553633wrs.274.1653583349904; Thu, 26
 May 2022 09:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220526151706.331557-1-helgaas@kernel.org>
In-Reply-To: <20220526151706.331557-1-helgaas@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 May 2022 09:42:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whP4fH1_ZyWFAvzBjG_Qa1U0+iAnT-iJsmM9DwvNEtWdw@mail.gmail.com>
Message-ID: <CAHk-=whP4fH1_ZyWFAvzBjG_Qa1U0+iAnT-iJsmM9DwvNEtWdw@mail.gmail.com>
Subject: Re: [PATCH v2] linux/types.h: Restore __bitwise__ definition
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>, llvm@lists.linux.dev,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
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

On Thu, May 26, 2022 at 8:17 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Restore the __bitwise__ definition.

Thanks, but I already ended up applying this yesterday,

                   Linus
