Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD5A589FD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiHDRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbiHDRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:25:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E596610BF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:25:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a7so551387ejp.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SSuMHfi3kcMSgnyvItLcQACEgUeRMPEBufWTkyyNck4=;
        b=QVKp1nRXrljkSMaNE8czkVxdfvvVkB6enkHU8DpRs4rDPd/IV28vYtSJ2DcN6VZ5x5
         lWrhBmOP+alvOf1/u9pSH+k/Yawyo9kwUoC4cbA4lM9Om2EGUojfr+k1wJNPyhp8hlyd
         wEPOZsiacLpiQpfseuIX8HIbQmJhiObDpdlIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SSuMHfi3kcMSgnyvItLcQACEgUeRMPEBufWTkyyNck4=;
        b=X7YZnkeDQ1ZTLpZCGXqml50yVB0x/aL6PiowykapKt3UEEP5MoA93K6pG6qjLoJqKp
         +cVWded8jlgjyvb31DCvneREe1U+whscF+XP5ofBxOYITV/JZOSIO6EgNuMrG6e43yEN
         YAKb3SDn6OxVa87SQox0CSaXxMxyc8JoDN26ygbj2NpzDZMS7xcKd2S4JPyhc+9MT2bC
         nunHv8YnNjWFSqxQZZBiEHApem8kf+ekW15xXmhJyY03U3xRYf2ja7bbRbVdCpMUu/6H
         Zqwl+uM12DUgAXXq1/nteY6RHECf4q1VXT7Z/HTN/+aDeaUUeZPN9fqKRMgQwrWKuQg+
         hZfQ==
X-Gm-Message-State: ACgBeo28Rs7kEJ55ruOHAH0kzSXIBGflkOLObg7sIJBbJeDS5Em/ytzo
        tbrxb/6FZKuUD3cO7LlNFOnQVP91hCbjofZa
X-Google-Smtp-Source: AA6agR5Xi+ZVaKe0a+r2vWOrV5x2eHSYsUMeOcgMm1uU1KhYVdHoKw6a39nNhm3v4fENrEZw4g1lzQ==
X-Received: by 2002:a17:906:4fd3:b0:730:e16e:b75d with SMTP id i19-20020a1709064fd300b00730e16eb75dmr724992ejw.454.1659633938136;
        Thu, 04 Aug 2022 10:25:38 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id a17-20020a170906275100b0072af2460cd6sm564617ejd.30.2022.08.04.10.25.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 10:25:37 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso2841502wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 10:25:37 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr2128779wms.8.1659633937248; Thu, 04 Aug
 2022 10:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220804055036.691670-1-airlied@redhat.com>
In-Reply-To: <20220804055036.691670-1-airlied@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Aug 2022 10:25:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDQceAojsjRTtd=Rq4h3pkU8C1uFj97EuWkYWGQk_6Lg@mail.gmail.com>
Message-ID: <CAHk-=wiDQceAojsjRTtd=Rq4h3pkU8C1uFj97EuWkYWGQk_6Lg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: restore plane with no modifiers code.
To:     Dave Airlie <airlied@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo.Siqueira@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 10:50 PM Dave Airlie <airlied@redhat.com> wrote:
>
> With this applied, I get gdm back.

I can confirm that it makes thing work again for me too. Applied.

             Linus
