Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF6E4E7D14
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiCYWGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 18:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiCYWGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 18:06:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605413E142
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:05:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h11so11981512ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSuHxcWKDft0wEiSByRN3yAcLQsM1bheLGndcSgmOqw=;
        b=FKSMHhqizDs33EW3ErY303/fz+7K2TKqwcs+lhK0yRoiucDb2viQAjpvZhR4ZNGmAn
         BZ0/xX06mv6AWTFECzIy38wMtRDqrwPC1zzthhbLsTxaWi7L3/ucSC2V7NRdPIK25cIj
         zVNrah701AB0dl3w9zzN1KtclCYKI6xb+uAwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSuHxcWKDft0wEiSByRN3yAcLQsM1bheLGndcSgmOqw=;
        b=rP+PTc7SxZSSSfpEYWa8uSo/eefCKINgOqRVQObDhmlJ+xhh9fG+dwe6sbl6pEfULW
         +EgdQJoAZRdMSf3FEi/pMCNjMZR5S7YnHUUkriPWekZLuZxz0T+9eQgfYxq/Uz8w9W3H
         Ge8PFXn6o2BuOc8Pnhw+x8jyP7pGnhQ6Rxh7EqwBG0Fulje36xt2a/AJlsjdSEM+6epr
         6wGhj14ypINRK538vF5pQltCBlKhPJhmhmoCcK2PTC7tp1u5s5P5zKirArpx8F0WuJMb
         BQpYlzS1LJ7hq+aJxl2W7kHzI5kO+1Jqfr8KP099ZoofrW/pUF1ObuvkQ3P0jLdaX/Gn
         7gtA==
X-Gm-Message-State: AOAM5309Igyz/8Do/0yVKDcNL8nvUj84YOKGAnuO9HrTJIjK3l1T2nml
        FL6CH2yXlKOKflxigYbPgMUTHAFuISwdgoU2ATQ=
X-Google-Smtp-Source: ABdhPJyKPWt3bAn5DqNi8hlUlPznC4J7LQ1dgmw/P+OnhIjenQg6Wb560bJQzJcfOHbBqV2fbdSPkw==
X-Received: by 2002:a05:651c:50d:b0:249:8a0e:cecc with SMTP id o13-20020a05651c050d00b002498a0ececcmr9839042ljp.402.1648245904922;
        Fri, 25 Mar 2022 15:05:04 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e5349000000b00247e931bd67sm819801ljd.9.2022.03.25.15.05.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 15:05:04 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id w27so15538181lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:05:04 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr9471453lfv.52.1648245903684; Fri, 25
 Mar 2022 15:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty8CYpuQ05BjgB9_CBRUjiL5PMTF-irHRXKOWtOrgxxZA@mail.gmail.com>
In-Reply-To: <CAPM=9ty8CYpuQ05BjgB9_CBRUjiL5PMTF-irHRXKOWtOrgxxZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 15:04:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3LoxC8izR6fQ=RsD0ndtZjY_o0-Pg82XtHYQNS5RPoQ@mail.gmail.com>
Message-ID: <CAHk-=wh3LoxC8izR6fQ=RsD0ndtZjY_o0-Pg82XtHYQNS5RPoQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.18-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Mar 24, 2022 at 7:13 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Some fixes were queued up in and in light of the fbdev regressions,
> I've pulled those in as well,

Thanks, pulled.

It sounds (from the other thread) that the mediatek DT issue is also
about to be fixed, even if it's not yet here.

But that hopefully (probably?) affects fewer people and testing robots.

             Linus
