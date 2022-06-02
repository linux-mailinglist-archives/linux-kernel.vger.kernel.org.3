Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5853C0EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbiFBWjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiFBWi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:38:57 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFBA37A2C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 15:38:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s12so5447399ejx.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 15:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbEMe/VqX4BtSXdufcZaue+MMZI7HwKcEvhZX2CcJd0=;
        b=PuoMbW99wR4ZUnrC6Hqp2QjyC7ln0P+6g7hWih7VEokSWZq5mHe4pcF4WVVJI3k+VP
         c+xuxCEGdlS0n3jYuNdmwEBKEKKtL33A24JVzWZfeyAuNys0EfDX8d5O6nzmICZuAUsf
         2JF4JGecY/LDwd+SB6dFlTVTQ9UvxOga80cqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbEMe/VqX4BtSXdufcZaue+MMZI7HwKcEvhZX2CcJd0=;
        b=cGvgDkdgkmpeKtauXmGjmy8UPodOX9uFjf7puRhoYwR1lAbqY/NsI8qr53OnpebQO3
         u3UAeNJVWgYH4q+Kb2Ie4dNv1aBLF0zY4ejNibV33yNSw4fboSpuCMS3qejtK5tqW386
         eeNC6p7Jo9+Ai30Hl0X3oK1Ji3E2LOlt6lH6gaAE6kirzYOgClxf9loQNBU6Bl8ijPcn
         MyLHI1vfVNxCivwbdu7pLqZI+UOaVnaUJaPceu1O0HdpBxzSCc3UqEuqvooJxZG1+gZr
         2xBiOqzD0H1SQbQ7RZNJx4yh4K2MKPdX3PK+5xH6nm/Kvm2RvurghTh1tD1yQAFYcdhG
         mJ+A==
X-Gm-Message-State: AOAM530+cLLnkWfvh7HMDb/J+IBwnuceZPfTOfD9tNJO+U01Lcze9NBN
        rNtrzGtfjVa/SkzHT29yez148HbtL/W3j6ZUW18=
X-Google-Smtp-Source: ABdhPJyTxOqwadEJLteWp9eqzJ0K0PQCIkpwNDUnOFACZDBy75Bnsbh+Cht68PF1sf9CLolXgAY6bw==
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id e8-20020a17090658c800b006fe91d518d2mr6008155ejs.190.1654209534479;
        Thu, 02 Jun 2022 15:38:54 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id s23-20020a170906501700b006fefd1d5c2bsm2203994ejj.148.2022.06.02.15.38.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 15:38:53 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id p10so8179550wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 15:38:53 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr5429578wrf.193.1654209533417; Thu, 02
 Jun 2022 15:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <875yliycfi.fsf@meer.lwn.net>
In-Reply-To: <875yliycfi.fsf@meer.lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jun 2022 15:38:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvfqS+mVYzSKWqdt1D=-WmyEQZi18Ym4tDy=9d-sn0EA@mail.gmail.com>
Message-ID: <CAHk-=wgvfqS+mVYzSKWqdt1D=-WmyEQZi18Ym4tDy=9d-sn0EA@mail.gmail.com>
Subject: Re: [GIT PULL] Documentation fixes for 5.19
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
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

On Thu, Jun 2, 2022 at 2:37 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> A handful of late-arriving documentation fixes and the addition of an SVG
> tux logo which, I'm assured, we're going to want.

Heh. I guess it is long overdue, whether we are "going to want" it or not.

                 Linus
