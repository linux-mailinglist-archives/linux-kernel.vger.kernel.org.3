Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74D74E8922
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 19:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiC0Rzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiC0Rzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:55:42 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256E5BE0C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:54:03 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c15so16377501ljr.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20fQNXQ8IbsOge8G/055Q2flAhZSXzjgoB+iB3M/J+k=;
        b=Jzl+rhxcvVTNobrsLj2PiaS2xlyciHyVzQ5ZXDA5dtZfTh70OS7LSI5QmWFzIHVkE7
         gr21qqpEM8MIGcQdRuxfxPobOnK4iDRnScuwmMesvMnOhqiDRpI0Q9hEKp47FAvrgpyA
         yd0WX6TWcBJSjYC+z2/+6d/43QOEKIk02lHtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20fQNXQ8IbsOge8G/055Q2flAhZSXzjgoB+iB3M/J+k=;
        b=F+MWAcDUvxfPmIlVBm1yExylbuvLqrOXyo193kfXH+dODWI13aZGPhRV1R4qamlg/s
         G0D5jkkwoKmJGuoxVVuoiFR/Xlvg33oJIC8BgAxXpg+IkQWfq1u4IAyUsMoHkQ1OJ4JS
         PDgw6ZJW49wfgp6n2rOYhWZ+Hd/YKo0oHnqk2nSOqplLQ8Cd6guz5UkbyFZO0dU8JrKh
         jgHt9vzOt/ft53S3qLz3OIQvBfMPgGGODLISpFRZYwVkCyryThy9/HkG5RTTyAE4q57Z
         0zKbesWNRFk22gVLlOMEbqynyVSSHOBdwmMYO87XMMMjBzueJCbCxnLlYR9dzUnAt7vR
         LLIw==
X-Gm-Message-State: AOAM532GMtV1jseNwNShP9a9WNxz/AFYA/r1+7d/ioQyZe9aOhXHw3KW
        CWvr45zdMHttr88CodJXJjb6RRiSGAwgR29RbMA=
X-Google-Smtp-Source: ABdhPJwceu5eMu7wQzCelvvbVL1bKgceF3fYpPA0e43Sypwl4PLy4wa++V3uPiKXk8UuQeWVpsg+ow==
X-Received: by 2002:a2e:bf05:0:b0:247:b233:cfba with SMTP id c5-20020a2ebf05000000b00247b233cfbamr16434283ljr.131.1648403641156;
        Sun, 27 Mar 2022 10:54:01 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id e11-20020a2e984b000000b00249b8b68f61sm999503ljj.74.2022.03.27.10.53.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 10:54:00 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id bt26so21175694lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:53:59 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr16752520lfj.449.1648403639277; Sun, 27
 Mar 2022 10:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220327173316.315-1-kbusch@kernel.org>
In-Reply-To: <20220327173316.315-1-kbusch@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 10:53:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whktuOOGYoNC=pAVX3KOMo4AD8dFsVdD_CAesMqef_9JQ@mail.gmail.com>
Message-ID: <CAHk-=whktuOOGYoNC=pAVX3KOMo4AD8dFsVdD_CAesMqef_9JQ@mail.gmail.com>
Subject: Re: [PATCH] block: move lower_48_bits() to block
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
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

On Sun, Mar 27, 2022 at 10:33 AM <kbusch@kernel.org> wrote:
>
> The function is not generally applicable enough to be included in the core
> kernel header. Move it to block since it's the only subsystem using it.

Thanks.

Btw - replying on the list too, because at least last time you were on
the participants list, I got bounces about "mailbox too large".

WTH? Are you living in some hut in the wilderness in the good old
nineties using AOL for email?

Because admittedly the 21st century has been all that great so far,
but at least we got rid of mailbox limits.

               Linus
