Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DF24F1877
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378587AbiDDPeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357519AbiDDPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:34:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DF3EA8A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:32:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t25so17995302lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KYPOn/fSw1yB51AaAuCahyvJyvaOhbiwETkKXDINQls=;
        b=EYB7AxJDRQc+1PpUxv1XaYzvvMk4PO9AjCJ/RBGAiP7o02cA/onazXLHnPrHvUf0ov
         GgW+T/aht54MkFt51t6GKtXFu9+nMox3TDJseqwZVW5tvD9a5BxRBhsqi2kvmzVHE58P
         vemQFAKIogEPsMHC0VaZYRP0TNCMu2fTh4m8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KYPOn/fSw1yB51AaAuCahyvJyvaOhbiwETkKXDINQls=;
        b=XEWa0bc0+VeqmviUAwUTErAp3xtYSQgB6L6NZgjn/FpXfQtLsj7blm+KbrJz75QlM9
         4CuQNR19/7oDwGKldI1fFj9VidRL5nTGELzMe6F9nDOO+kzBx1e7GKAsgzNUagK4mMGw
         gTo1EjKQTyLoJ21yDWhq+CO+dg8S9gw8NAPlmGVvyJW0X/lDItNJzDzw5C4hVPuDo7df
         exsGJiCjkoob8FPaO6GPFZ1sHmzp+N/X56UzOzFtFGdBx7Gf6ndT8C5FiLc8M/wRXkmX
         JfrQ/KuaHAOnfuqWGmQ5BaDKcoRmDKjcOqB27fbVXKVDroLv8YJB2sBiM48nwhEfh4qY
         Z8jA==
X-Gm-Message-State: AOAM533JhcNcYQ92c5fFB+8/tu6Mlj1x1sDojGvRAAzNmDkeeT3PjYSv
        DMo8jBCEnxZ+P19EmuVnb+gTdJVoF71qyhHO
X-Google-Smtp-Source: ABdhPJyX/xXXxfJwcIBdsMr2c9nfpGjTPH9oNHJmWl1Nbokxu62mVjR1sIk5IRNFVulZo8Y26/frfg==
X-Received: by 2002:a05:6512:3e05:b0:44a:6a2b:52d0 with SMTP id i5-20020a0565123e0500b0044a6a2b52d0mr17780lfv.105.1649086354221;
        Mon, 04 Apr 2022 08:32:34 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id f25-20020a056512323900b0044a39b6e1adsm1166319lfe.171.2022.04.04.08.32.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 08:32:33 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id k21so18041918lfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:32:32 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr49218lfv.52.1649086352718; Mon, 04 Apr
 2022 08:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404022239.GA1186352@roeck-us.net> <CAHk-=wimc7V9mi=P+6p2nnctPYtSM55OSPVERUeJor7fkD_EVg@mail.gmail.com>
 <aba387bd-9799-e0b5-40e3-1bcb552ac74c@roeck-us.net>
In-Reply-To: <aba387bd-9799-e0b5-40e3-1bcb552ac74c@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Apr 2022 08:32:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=witgMUS8To6wijxdbQ+QEH0gcHSYV6Y=yzOdb=Q4h9PJA@mail.gmail.com>
Message-ID: <CAHk-=witgMUS8To6wijxdbQ+QEH0gcHSYV6Y=yzOdb=Q4h9PJA@mail.gmail.com>
Subject: Re: Linux 5.18-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Oded Gabbay <ogabbay@kernel.org>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 3, 2022 at 9:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Oops. Sorry, I thought it was big endian. No idea why. I'll update
> subject and description and resend.

I see your updated patch, but for some reason 'b4' is unhappy about it, wit=
h

  $ b4 am 20220404134338.3276991-1-linux@roeck-us.net

causing

  =E2=9C=97 [PATCH v3] staging: r8188eu: Fix PPPoE tag insertion on little
endian systems
  ---
  =E2=9C=97 BADSIG: DKIM/roeck-us.net

your DKIM looks fine on the messages I see, but now that I look at it
on the mailing list, I notice that your DKIM really is very wrong, and
has a lot of headers that a DKIM signature should *not* have.

Your DKIM signature includes header names that are very much for list
management, so by definition DKIM will fail for any email you send
through a mailing list. Headers like
"Resent-From:Resent-Sender:Resent-To:Resent-Cc
:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe" etc.

The DKIM setup should protect the meaningful headers that matter to
the sender, not things that the mail system will validly add when it
passes through.

So the DKIM header list should be things like
":To:From:Cc:Message-Id:Date:Subject:"

Not things like "Sender" or mailing list things.

Anyway, I was going to just commit it directly, but with the DKIM
verification failing, I was a bit less eager to. And then I noticed
that you used "be16_to_cpu()" - which is technically correct - which
doesn't match the other code in that file.

That driver uses the traditional "htons()" to convert to network byte
order. And yes, our naming with "be16_to_cpu()" etc is much more
legible and does do the reverse, but it looks very odd to mix the two
naming conventions. Either use one or the other, but not a mix.

             Linus
