Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DCF59AF1F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbiHTRWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTRWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 13:22:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF12140E3C;
        Sat, 20 Aug 2022 10:22:40 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-324ec5a9e97so195033467b3.7;
        Sat, 20 Aug 2022 10:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CsaY3CDWeiwKSPR4Rcjp0cpeUs3s2HX5HO3h9taF0tw=;
        b=MT0HlFwnjDPFvzp+hOYa42GnudTLD7ok2Mu4xn+bz2+Iy2xrK/Pek1o4nXuIS1KLbb
         CrGAucSQM679EdGBhUuj/To6l/jCjH/VEpW32ZKUp4WqxFOdMRE1oGn4Qv3q4TTrr0I6
         UQX+JND5SbbdHooAx7wtYaNUXOgIlnM6OfoBB92ttrHfOx98D11UJMYx4cFy8cBYSCrS
         q5cGSvd05A9MLa1VRh+gzg+P2zBwF3kzYJjZwEe0H7SPTWblv9Xve6rk4TnUWRzp3s9/
         hXgGfB7Vs/HQ29L2VC74VkP+1DtSjFLM/j2NJqg0BJqfu4THC7KM6Tp6VKKi2LoqJ6ZK
         SRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CsaY3CDWeiwKSPR4Rcjp0cpeUs3s2HX5HO3h9taF0tw=;
        b=RfUDpUz2nJsSihx9UZlvIiLuNehxZMI7lu3D1gL0zCRawdXe4En7yoCiIm0AmkPCxU
         lmz2V7z+XJRQqeEM8i8vzk2i6odLEbv8aabFriJpNHh5E2yjhQuTrcKi1C+fnoW8Ktk4
         GWeGoxpjb02JeVkCTL+zF0Cw96XA91NgZGYrOFh7wvGwHpwW+Zd4Q7Gtz3hcmcr5xVxY
         JQ4NKaNeByLovu77kE5XSPbJjBZApIYvhoPxY56ssZP51spvnuu068WZRVAD0cVqCtaD
         77UNaLIXEx7xma6HNzVlmxoeBIZ0JwwaeumZIlrQKaP/a3pM5Nwocmja0SU1TtVsBi+b
         HFdw==
X-Gm-Message-State: ACgBeo3ATb+Y7xFVLMLu+HW9Jal/H6oSQFpsLxOCkTTEMwOGNdhpPUhw
        sczTVAsLhrzheQeBbljAQZJVIB3gs3cU1E+yFKk=
X-Google-Smtp-Source: AA6agR4LAyg80MpHiV53F5gZNZAmkdSJKWpf5d1cYiA8RAMxAt9xg6AW8EmhIEC+20A7rHMWdL/U2pJ22jTFg3leE3g=
X-Received: by 2002:a81:a1d6:0:b0:339:c126:e6cf with SMTP id
 y205-20020a81a1d6000000b00339c126e6cfmr2460710ywg.15.1661016159969; Sat, 20
 Aug 2022 10:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <be4b863bacf323521ba3a02efdc4fca9cdedd1a6.1659855351.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <be4b863bacf323521ba3a02efdc4fca9cdedd1a6.1659855351.git.christophe.jaillet@wanadoo.fr>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 20 Aug 2022 19:22:29 +0200
Message-ID: <CAFBinCB=JR1MtF3VX7qnf_puwB5dQ1u1ppMTpvSd4oAxLkV91w@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: Fix an error handling path in meson_mmc_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 7, 2022 at 8:56 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The commit in Fixes has introduced a new error handling which should goto
> the existing error handling path.
> Otherwise some resources leak.
>
> Fixes: 19c6beaa064c ("mmc: meson-gx: add device reset")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
