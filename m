Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED9153D1B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347185AbiFCSot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345377AbiFCSor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:44:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5369D1CB29
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:44:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x62so11267923ede.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PU+lgH2jqct+WW6K1XpKf6qWJO0+UHEXDRk2yDooong=;
        b=RgqJYS7pw41Wcdw7p179aSzbVX+SlPpeSbWoigFcVS5solgszp65k0oflifqWMqoi1
         dSGtgfW+EuPrCmzegqnWS1TqWaipEGuqA+uFVTR+3dorF1WvYsJb2zkrjk4SOjWqsCxz
         qw8i0ZkHTtSYxXj9DU3Y+WgsQf3UekMKeBVJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PU+lgH2jqct+WW6K1XpKf6qWJO0+UHEXDRk2yDooong=;
        b=xQYn87o66yfm+Z0BbQAzMutN1vxm+ueEtT86w7kYFYoujlmIcHu1h/YkBMbOSDqhJW
         ZNDxaK+9bL5nQa8VUq7ynemdj7KJcw1pZO5+RFgcx66mkGlqa1pI7CPAxos3wMKYVstH
         NL+KCkgTUa6tBy+gXs8Z2OUwUjI/dRKh28leEuf2P7z1NX1hc8K6qiqC+i/I8UjLUbm4
         MKpP9aRk03WVPThc2p1fKssK9wdO+5Ys3IhYDVHipXil2zGGP/BH4YmUivS0W29vT4E+
         PUgJ7F+AMx8aSTtLZR3jw7hEjyndo4/Q+RipRAsNHRaS9jy5NPtBj8XCZoKEG3eeXE9A
         RKfg==
X-Gm-Message-State: AOAM532sxufiCYOrX0BLO1aZ1a/4LjTXc6xc5m+MTvfLGy54YJ7+B3OM
        Y2eDmyDChxpdDO7S6QV7AbCjR1O0IsghTnVwGXo=
X-Google-Smtp-Source: ABdhPJx9iNLSVNLf2lUgf5pDoNe7v5oWA7uHoy0COtp+S9a5eNM+RHxQAOvo1NuNkR8c4LJRL43rjw==
X-Received: by 2002:a05:6402:1d51:b0:41f:cf6c:35a5 with SMTP id dz17-20020a0564021d5100b0041fcf6c35a5mr12488861edb.25.1654281884696;
        Fri, 03 Jun 2022 11:44:44 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090691c500b006feaa22e367sm3073812ejx.165.2022.06.03.11.44.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 11:44:43 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id x17so11474381wrg.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 11:44:43 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr9448087wrf.193.1654281883176; Fri, 03
 Jun 2022 11:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <YpnmYB8SN5dPweLV@kroah.com>
In-Reply-To: <YpnmYB8SN5dPweLV@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jun 2022 11:44:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJjkvt5rfFA=19auwz5Ahc-9Y7qL4_t9rLCcyD+BZoDA@mail.gmail.com>
Message-ID: <CAHk-=wjJjkvt5rfFA=19auwz5Ahc-9Y7qL4_t9rLCcyD+BZoDA@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc driver updates 5.19-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Jun 3, 2022 at 3:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Note, there are 3 merge conflicts when merging this with your tree:
>         - MAINTAINERS, should be easy to resolve
>         - drivers/slimbus/qcom-ctrl.c, should be straightforward
>           resolution
>         - drivers/misc/lkdtm/stackleak.c, not an easy resolution.

Heh.  They were all very straightforward, and in fact the MAINTAINERS
one was the most annoying by far, just because there are so many
unrelated commits there (including a re-ordering of a couple of lines
close-by in a previous merge) and I want to make sure they had nothing
relevant.

The stackleak one may have looked a bit nasty, but actually had a lot
less unrelated noise around it, so I find those ones easier to verify.

Famous last words.

                  Linus
