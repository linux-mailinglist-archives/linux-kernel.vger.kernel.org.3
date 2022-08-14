Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EEB5926AE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiHNVkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHNVko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:40:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA73165A3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:40:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dc19so10696847ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0N4kyysm9/43RV8zlNyJuXGP2DDx8PgtF4Hpfd6IqQI=;
        b=O35nkYmaMrrX07dYjyoaxKR8A0rqhR+2NpVv+mUgfy/3Kp3hftiXLD/V7Tw+//q2a6
         NCjR8a6YiqPQTM83P87L9hkGavh4s5YhasJUqiLKocBTjM2fnmQBWTDr8Qkf0hVshov0
         8tZ1gHk6uEU6qM/IiOUkiQ29GKCdD/P8wC1Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0N4kyysm9/43RV8zlNyJuXGP2DDx8PgtF4Hpfd6IqQI=;
        b=JRKy8U7vjfiBzbx+jTIspbIPlHrpM2xDWZ7u8exakipfyp8h27C1l/0p79yT1dHiLk
         2c3OXCUf8Ou9rp2iQoBoyq+2PzU6Wr/8+ybrGUbZsQWyEM28LXoefgjfJ5zPyP97TKLq
         5GNv2w7oc1chSuL0jGDSIwXUOL5jN9aZZu9BhwkuF030WIOzU4fnWLZT/toLqc4DvwyO
         /jbEVYXIxxLXuEp8jOHHC+xaUvDq2EDgRQt5tEvwM7dmyzmiBR3QEoBwaJW84p1MidLz
         LLWF1WytLa7NyA7olVA3KmEcPOHPSPl5+ccfCbn2p5cenklUXwHGPBAEQngHnmnP3gLu
         zNog==
X-Gm-Message-State: ACgBeo0Ik35t97l7iqro1cyFcs5Hg/CnGgi41IunV6Mln/SoXYI7fEbd
        7O0ahwNCtFlUo0ZPqAqPUqdx9DWVF/w95H7R
X-Google-Smtp-Source: AA6agR4K0aAN/9YhY53zkR4qts4lYDTyUPygpxA8RLGV7dk+yIXdfjZmL0TkYc2uLrE+N9R8W4B9vg==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr8410472ejc.243.1660513242234;
        Sun, 14 Aug 2022 14:40:42 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0073100dfa7b0sm3336853eja.8.2022.08.14.14.40.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 14:40:41 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id j26so872700wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:40:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr14599046wmq.154.1660513241376; Sun, 14
 Aug 2022 14:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220814212610.GA3690074@roeck-us.net>
In-Reply-To: <20220814212610.GA3690074@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Aug 2022 14:40:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
Message-ID: <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
Subject: Re: upstream kernel crashes
To:     Guenter Roeck <linux@roeck-us.net>,
        Andres Freund <andres@anarazel.de>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
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

On Sun, Aug 14, 2022 at 2:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi all,
>
> syscaller reports lots of crashes with the mainline kernel. The latest
> I have seen, based on the current ToT, is attached. Backtraces are not
> always the same, but this one is typical.
>
> I have not tried to analyze this further.

This smells like the same issue that Andres Freund reported:

   https://lore.kernel.org/all/20220814043906.xkmhmnp23bqjzz4s@awork3.anarazel.de/

he blamed the virtio changes, mainly based on the upstream merges
between his bad tree and last good tree, ie

    git log --merges --author=torvalds --oneline 7ebfc85e2cd7..69dac8e431af

and assuming those end-points are accurate, that does seem to be the
most likely area.

Andres was going to try to bisect it, but if you have some idea where
this all started, that would help.

                Linus
