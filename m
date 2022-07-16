Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3B8577079
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiGPRpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGPRpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:45:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF5F1D31D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:45:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sz17so14172547ejc.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9Uf2ntR2S8w+9n+2/JTbBl/aHorYxeMkxTEqnBf5zA=;
        b=KHq5BHgTW6a26TA22avGT40/OX1T0KJ9vHTQYgoSQVl90AvqUS8BuUjeuXpWCfw2EW
         ubTGMe99X22vI1DcAbUUut4EKhJI8cMPudvsj+AL3JGaY/yeXFqfRwY+s8J+4aK48UiO
         RVJbBas2mHgzq0So7/+vObT5GYYbOCHb0xhQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9Uf2ntR2S8w+9n+2/JTbBl/aHorYxeMkxTEqnBf5zA=;
        b=ROHMFzKsGRoHwAMhQrQNhoWP/BV5biTdsa04/4VPNBTVTfuCVHUEGbaSEyzIfwdykr
         IPgOnsjntWla7SHwBgUMP/KrmrEDebXHGDb9HU/rZfvydm3LGm5ld7XiAyOCM670emIQ
         GSXlPnH25h3JrkGnIAYl29OnEa/VI3ZNM8q9Z5/oHcwzjYSiIDzKSUCgCBbw2ZFRLBQ1
         B6MHaCV5+0asf9odY8lKLaeyt8uqclTMqkM+Tg/Hqw1h8GVKTcz3pdXfGDihJOSIW9je
         nrnV5mspeRFPe9p05W59YFXN44Kw/KqN91A6EZSRgwXfY7csubiOpIaYziDV3VKGJoq3
         FsTw==
X-Gm-Message-State: AJIora8YFpDncoaRAJxZlEY/MogNbEj/At81mYFO01S/zG2N0MwSUEEO
        UNdzF7YURUEPRWSul0wn6Z2PCdS9wxIZTViB
X-Google-Smtp-Source: AGRyM1vd3EU3x1sMZJNAbKWXMk2zx6sReDF8QUC2ANlDrqxD9I8kiVAJrqjZcUHGuVbzK6eSf0QzCA==
X-Received: by 2002:a17:906:98c9:b0:72b:40de:9afe with SMTP id zd9-20020a17090698c900b0072b40de9afemr19459845ejb.620.1657993542144;
        Sat, 16 Jul 2022 10:45:42 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id kz9-20020a17090777c900b0072f0dbaf2f7sm1270876ejc.214.2022.07.16.10.45.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 10:45:41 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id h17so11004186wrx.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:45:41 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr17511700wrh.193.1657993540707; Sat, 16
 Jul 2022 10:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rrQVm72P6cLL4dUnSw+9nnXszDbQXRd3epRaQgKTy8BQ@mail.gmail.com>
 <20220713151115.1014188-1-Jason@zx2c4.com> <88d9e600-b687-7d09-53cb-727601612e21@arm.com>
 <Ys7xHMIF6OLkLbvv@zx2c4.com>
In-Reply-To: <Ys7xHMIF6OLkLbvv@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Jul 2022 10:45:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+TYBp8WD_b9OG9iNeh08jsPc=P_Xkr=CFHgVPc0f5sA@mail.gmail.com>
Message-ID: <CAHk-=wg+TYBp8WD_b9OG9iNeh08jsPc=P_Xkr=CFHgVPc0f5sA@mail.gmail.com>
Subject: Re: [PATCH] random: cap jitter samples per bit to factor of HZ
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>
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

On Wed, Jul 13, 2022 at 9:22 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Thanks for testing. I'll push this out to Linus probably tomorrow.
>
> (Though I noticed that Linus is in the CC for this thread already, and
> he's been on a patch picking spree as of late, so in case he happens to
> be following along, fell free to pick away. Otherwise I'll send a pull
> not before long.)

Well, the "probably tomorrow" didn't happen, so yes, I've just picked
it up directly.

                 Linus
