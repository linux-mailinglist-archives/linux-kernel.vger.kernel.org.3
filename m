Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC45962DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiHPTK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbiHPTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:10:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D3D65665
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:10:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o22so14710321edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yzrVpPuDYTxXMkdItXzTsS/x0cvNzj9XD0M7B64fKkM=;
        b=hRVUjFvYmNjBenxN26rM1xLF3lI5JQT01UB04cU3e6k+/745Td4UiuUQ7TZ10C3voN
         siR7BMzwAUZsTJpxsypPp+ZGfQt91NHSg6/aSDd4A5Kd6mL7hB/2C5qiNVvp0kFEiqpZ
         Ts68OOg3tm882msV1Ffr4efqdWvIqV5y5DDDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yzrVpPuDYTxXMkdItXzTsS/x0cvNzj9XD0M7B64fKkM=;
        b=wMjtU51Ky4s/oL0RKlJUWS4YN2roaYpB2bsJLi2wJTd+1Lo8Wdpfp6rc6ZUhc8k1Oz
         4wA5Xm/xyMUHFxUepxiRh0XwUUWzDTwdkDIl5EpfjfpWAyNs68fjYVuS4AZxHSVsYY9E
         YqvuiwuJ0jw4b+uKqvE9Ldq4JhJCE8591zu2wPawZ9zX8So14obG/zKczt3wKt1+bXP/
         m0H2Pg7lOfCnoRA/7/JDzVXWvpiVG7AnnX8DK3m0PG8bscfrkPxw6gq/3oTD8uJvbCoL
         IT1XRcwFy4Oy+me9bK+EWn/5DK0UhPFEkzYaUnVwELgUJJUecyWkVZReZJU3lBYv+ibZ
         xjYg==
X-Gm-Message-State: ACgBeo2gZy/A7Wh4nIOClwPuvRWJj+MtpPheIaVhCvgHjkzieuTiAAVE
        ss8YUI0umNUwam+dLa5Skrd76b8VRSWYFMbAM58=
X-Google-Smtp-Source: AA6agR4cHJTr5p7qM+4VBQ3WnkQiuRwev4Qz5stQ8sC8psYbfyHNgAIctobs+KjMjyKIJChgnx3isg==
X-Received: by 2002:a05:6402:350b:b0:43e:f4be:c447 with SMTP id b11-20020a056402350b00b0043ef4bec447mr20457887edd.427.1660677018808;
        Tue, 16 Aug 2022 12:10:18 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id vf18-20020a170907239200b00715a02874acsm5666151ejb.35.2022.08.16.12.10.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 12:10:17 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id e27so9016083wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:10:16 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr11814187wri.442.1660677016516; Tue, 16
 Aug 2022 12:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv2Wof_Z4j8wGYapzngei_NjtnGUomb7y34h4VDjrQDBA@mail.gmail.com>
In-Reply-To: <CA+G9fYv2Wof_Z4j8wGYapzngei_NjtnGUomb7y34h4VDjrQDBA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Aug 2022 12:10:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=u9+0kitx6Z=efRDrGVu_OSUieenyK4ih=TFjZdyMYQ@mail.gmail.com>
Message-ID: <CAHk-=wj=u9+0kitx6Z=efRDrGVu_OSUieenyK4ih=TFjZdyMYQ@mail.gmail.com>
Subject: Re: [next] arm64: kernel BUG at fs/inode.c:622 - Internal error: Oops
 - BUG: 0 - pc : clear_inode
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
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

On Tue, Aug 16, 2022 at 12:00 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Following kernel BUG found while booting arm64 Qcom dragonboard 410c with
> Linux next-20220816 kernel Image.

What kind of environment is this?

Havign that inode list corruption makes it smell a *bit* like the
crazy memory corruption that we saw with the google cloud instances,
but that would only happen wif you actually use VIRTIO for your
environment?

Do you see the same issue with plain v6.0-rc1?

            Linus
