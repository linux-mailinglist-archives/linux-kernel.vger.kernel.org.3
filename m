Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB36550CC73
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiDWQ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiDWQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:56:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A22B193
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:53:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m23so322615ljb.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcoqhVyV1NN0NpAcACB15/wat3ksyRKY5771SK2WiKE=;
        b=En3C0Elc/rQ7p8X3AS8OLj2h+xYQ9zXpzi2KwrD5qQfgREcyozMXitSnMFHnsEga+y
         HWbfnfDxuZ1VMFYzBVNNFCUi1BHPHtMIS74CGkKICMJl4LyVHt0ASqF5GFlcvhP1/aHP
         t+HarFrBbBsRRNgWJKJH7hvTkYsMrWPHTAecU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcoqhVyV1NN0NpAcACB15/wat3ksyRKY5771SK2WiKE=;
        b=wymm1pZarNc8Ev8y92KTeU/abfGHnoS31ccHwIoYWskK/PWNii0fbrmFczDHUFGeAw
         gvgOWkQVb5DUT4i3bxUpCccvAoAw867HYVS38/iP9r90v+tnp+cDCTUy1QZATsXIwHuw
         fhNMSx9LRX9dn7l2gZ0Xt0IQmXziao/NRazusaIxT+dT0MNzlgqxCvbbVVhMDwhcEq6m
         9OBORlTKVKFmJg/x4q7pbFXb3he+1SG/CPbroo0cbySzdNMCJyMXscZ+u69B4uimsI1P
         T/vpPoyG+FDCVsDEOy0yX1hQJZeK+pTdhN91pWrMci5wQoJZXJK5RRRMHdFT8Dz1mHGG
         mqtw==
X-Gm-Message-State: AOAM531NRljlX8qK3rv5V843h7kXe5y5vO3CWwVtw/k2vRdq5UFJJWGF
        ug4+Id7kC+JUImE5NMExHtLsOttyK+VaOTcT
X-Google-Smtp-Source: ABdhPJwF4m/ld72c6V5HvGeK96kN/10pHNadRTiasKteFuojIy6etM8ZSJ+WJzCpoaAU0gP9MMAVxQ==
X-Received: by 2002:a05:651c:488:b0:24e:fbf0:539b with SMTP id s8-20020a05651c048800b0024efbf0539bmr3529554ljc.259.1650732837162;
        Sat, 23 Apr 2022 09:53:57 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q20-20020a05651232b400b00470010b25c3sm678725lfe.206.2022.04.23.09.53.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 09:53:56 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id h11so13084796ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:53:56 -0700 (PDT)
X-Received: by 2002:a2e:9d46:0:b0:24c:7f1d:73cc with SMTP id
 y6-20020a2e9d46000000b0024c7f1d73ccmr6017511ljj.358.1650732836015; Sat, 23
 Apr 2022 09:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <YmOEuZ11On7T7Gbe@google.com>
In-Reply-To: <YmOEuZ11On7T7Gbe@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Apr 2022 09:53:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYKNrM3tvg-D+2EL-=9Tsq5-dr4Sw75NWcONAdt+tZMg@mail.gmail.com>
Message-ID: <CAHk-=wgYKNrM3tvg-D+2EL-=9Tsq5-dr4Sw75NWcONAdt+tZMg@mail.gmail.com>
Subject: Re: [git pull] Input updates for v5.18-rc3
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:46 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> This is the first time I am trying to use a signed tag for my pull
> request so please let me know if something does not look right.

Looks fine to me. Thanks,

                  Linus
