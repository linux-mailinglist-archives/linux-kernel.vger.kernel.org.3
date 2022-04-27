Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F999510E89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357020AbiD0CBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353190AbiD0CBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:01:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ABE175DE7;
        Tue, 26 Apr 2022 18:58:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i19so513703eja.11;
        Tue, 26 Apr 2022 18:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xxf5D8eeIna3OhUc9F0dj7drwUpwVrWbB0N80SGN4Y8=;
        b=FXl+N66bl6uTSt6UGO2K7ARlZJMr27L2x75d75O/UMBPfn4j7qZ0Mgb7MCtmgEcAXx
         c9JONGMopH5A+1HOX9R5gj8TvwbsPJ0f9VkiSi9p5GvjQj4CrIVXxafAmKIPwE9WR5ro
         jO1HiXvKF1qrMAczXbXGkYswDdmnXCXvhAXGJKe6Zb9oRUlzXdenUPcTIP0nB+4+Fw4T
         ZPKU6/aoIkm2ZmCpC5JHU/SfjwnPwbsLhTY0uTk0LN8PVTljXRH9lUpHrreLVSV83OVn
         LTKLBAylOwU2929THNOZhQH/7f4mwUooTmyZCKlAG8otPs92QDisQcufOx+sylOBRZJ/
         M3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xxf5D8eeIna3OhUc9F0dj7drwUpwVrWbB0N80SGN4Y8=;
        b=qETPvyvXnCZYa2ZIeBNEfFZuZ5m0Gh/xDj3HFZiklMCkktRh1qVrDObuS2CixXcXZ7
         KRGfQIcp05lfoNnQ4jSnc8DeCfzE9DIb1IV/81AJrqrlDpfNYKyV+eGgIbiz/Awo2Y5U
         E1M08xsgSEZhCw6BMjue9crg7bZEmaq41szyDsxCsdZPpruoadZCLLRaP1WF+2xnhPKl
         S30p1nfkddOxCPIfNxQzNreoJLCAJvKpSsFzbw/iuprKF1Lxn3gIeeCdSpbd1JwtXGI2
         QmyCBPBsacx/KsYteMiq2DonXGlijmYju8gUfOPX1fn9Xk1A+furzQE0w36fiFXnbCAo
         ZUcA==
X-Gm-Message-State: AOAM533ZgfVbp4HRzdq0JHzDLlPPLCzm49tuj8ctSkfRPEE+LmiIzcRU
        9m1njEYRC07Z35OHyHfS4TkpeJad2UxkOXrndEY=
X-Google-Smtp-Source: ABdhPJzzyOr8NV4OJIuKM2dzrEJKiHBjbv/jwxaGu7EBV4LdAVswmTQjfwRSC1ZkRIs0MhkElptoYNEPk6xWe/9b+TY=
X-Received: by 2002:a17:906:5d08:b0:6da:b4ea:937 with SMTP id
 g8-20020a1709065d0800b006dab4ea0937mr24593777ejt.446.1651024690259; Tue, 26
 Apr 2022 18:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220426083259.526685-1-starzhangzsd@gmail.com> <alpine.DEB.2.21.2204270130210.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204270130210.9383@angie.orcam.me.uk>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Wed, 27 Apr 2022 09:57:33 +0800
Message-ID: <CANubcdWwHXqC4gUztNseoConYHp+G4nUSYFaO-Te3jFVqT=1sw@mail.gmail.com>
Subject: Re: [PATCH] arch/mips/kernel/traps: add CONFIG_MIPS_FP_SUPPORT when
 using handle_fpe
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        liam.howlett@oracle.com, ebiederm@xmission.com, dbueso@suse.de,
        alobakin@pm.me, f.fainelli@gmail.com,
        zhangshida <zhangshida@kylinos.cn>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki <macro@orcam.me.uk> =E4=BA=8E2022=E5=B9=B44=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=B8=89 08:40=E5=86=99=E9=81=93=EF=BC=9A
>
>  No need to conditionalise this either, because `cpu_has_fpu' is forced 0
> (in arch/mips/include/asm/cpu-features.h) if !CONFIG_MIPS_FP_SUPPORT.  So
> this code translates to:
>
>  if (0 && !0)
>   set_except_vector(15, handle_fpe);
>
> in the preprocessor if CONFIG_MIPS_FP_SUPPORT is unset and is optimised
> away.  Otherwise it should be written as:
>
>         if (IS_ENABLED(CONFIG_MIPS_FP_SUPPORT) && ...
>
> so as not to clutter C code with #ifdef, as per our coding style.
>
>   Maciej

Thanks for your comment. Do you mean  the following code:

 if (0 && !0)
    set_except_vector(15, handle_fpe);

will be optimised away if !CONFIG_MIPS_FP_SUPPORT?
But we did get =E2=80=9Cundefined reference to `handle_fpe=E2=80=9D  error =
when compiled with
!CONFIG_MIPS_FP_SUPPORT.
