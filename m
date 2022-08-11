Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105C958FD18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiHKNKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiHKNKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:10:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA35470E65
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:10:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so22892208edd.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ucfBP/53P+UnzU4Fa8i2eVWM9uv5/ktiToZlI9Ntdqk=;
        b=NSbbNPqjvWfdwSYpAG4Xy3FS3qBHPq+OAXBz/qlrnN8kLAJqu707xfUJchvfsw4I4N
         DXFkEof+pN0oul6LkwxLyXNgWKIsen0Er2mPPHp5Faw5BIv7jLe124nvftk1Louy2xdX
         95BjKuN4xgMNugJ2DqadtrsaKsubR91EAeFuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ucfBP/53P+UnzU4Fa8i2eVWM9uv5/ktiToZlI9Ntdqk=;
        b=zhqgCY7ULpnVPcqsNNfVhDoySOwN0/3T2uxy9+NGvaHlDadg0eG6T68bGc+EszBzZX
         OKrXv5PijxdAU8u+rgoZFj2/PGQ0m2i998mrgxBh2hG3u4tEzARzoEzdU/lhfiqu3btV
         NSSlLXq5YS6id48VvjYBOEEoQLEksk1ThXPITDWC8D4TLXPXgIw/tAKKGd3Mk+nC361g
         tnjPFBQhsx0+Uub4kOKv92UEB459XXXpQgZCIAgFI5qsJAhPtWp1nhCN5Sc2Hq0wowfp
         y9D/826UXfaw36Ek3TyuTkT8tXvrMkgS+tesMuNb0ySqCcLOeOvTQ7zrdokGPw3w1O6G
         suuQ==
X-Gm-Message-State: ACgBeo1pkdQyuRiuz/Si6VChM53h1yVvsxWOpb65ntJLHf+ibTn5XP3y
        vbEb2Q9iYf7M4McVUWwXzi9M7YKaVeOktpyR
X-Google-Smtp-Source: AA6agR7A8tIB8pNogOf6xfmDTTlkPGtO7j//Y+ROi6Xs8Dw1+2tvMD6Dc6rxZlqSltCTTifyWk+UCw==
X-Received: by 2002:a05:6402:268d:b0:43d:b9d0:9efc with SMTP id w13-20020a056402268d00b0043db9d09efcmr31340329edd.92.1660223402074;
        Thu, 11 Aug 2022 06:10:02 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906328300b00722e31fcf42sm3466661ejw.184.2022.08.11.06.10.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 06:10:01 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id z16so21237771wrh.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:10:00 -0700 (PDT)
X-Received: by 2002:a05:6512:b87:b0:48b:2247:684f with SMTP id
 b7-20020a0565120b8700b0048b2247684fmr11707556lfv.593.1660223389777; Thu, 11
 Aug 2022 06:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220809193921.544546-1-svenva@chromium.org> <YvSNSs84wMRZ8Fa9@kernel.org>
In-Reply-To: <YvSNSs84wMRZ8Fa9@kernel.org>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Thu, 11 Aug 2022 09:09:38 -0400
X-Gmail-Original-Message-ID: <CAM7w-FX4NfeQy9chKgzjAj6gvvoK3OxCK0VYq9DT5qrdB=_tDA@mail.gmail.com>
Message-ID: <CAM7w-FX4NfeQy9chKgzjAj6gvvoK3OxCK0VYq9DT5qrdB=_tDA@mail.gmail.com>
Subject: Re: [PATCH] tpm: fix potential race condition in suspend/resume
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Hao Wu <hao.wu@rubrik.com>, Yi Chou <yich@google.com>,
        Andrey Pronin <apronin@chromium.org>,
        James Morris <james.morris@microsoft.com>,
        stable@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 1:02 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> What about adding TPM_CHIP_FLAG_SUSPENDED instead?

Thank you for the feedback, Jarkko. After thinking this over, I
believe this patch only moves kernel warnings around. Will re-post
soon with a fresh approach, intended to fix the underlying issue
rather than the symptom.

So please disregard this patch.
