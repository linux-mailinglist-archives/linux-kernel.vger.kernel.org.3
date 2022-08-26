Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC85A2BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbiHZPyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344606AbiHZPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:54:32 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA441D076E;
        Fri, 26 Aug 2022 08:54:31 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f4so1419481qkl.7;
        Fri, 26 Aug 2022 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=VoZZLFDbWcdv8jm5ypqJnq3zDL5dbLMry5IM4+TKOHU=;
        b=RZWfljlS2yVC7jjEUkW2mCrFIs87PdpSGPxhOzMEUQ/nOdUtXO7EVRhu6PlQbgfoyQ
         o0ynanbHMIkqYmxYfn24DyXGzAoZ+Gfoa/3piKJOFOx5e/e6YxRhhZhpxAzdGyB9VXp/
         cIb/iUcPrBiUl66uQR5c8rD6HLvlQcbuvhAEsXSRx0MDD8Az7IAV7vy3j+jdaeoPbZ4j
         rodnmGgwyg+zsobw0x0mkMPwzSXz8CMg9noZhgq3Jw1hWEQ8kDgD0AMsCQ9UCbh8+x2K
         eMaM/FLtU730nYNwKgxNe4Ei27zg3ZtYnvm8nzPacW9Zo2ZvC1NxhI6YhthBGuuXk332
         6zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=VoZZLFDbWcdv8jm5ypqJnq3zDL5dbLMry5IM4+TKOHU=;
        b=nqcy6qv/sfciNtL2xxJet2bfYPyAIn48E+RP4hYFPAyioVAS8gRJxix6iE8YU0PIvI
         bRxzdZkaFIuAjYrPmTsPm7qEPbrV1mJStZopcq5ocDuIGhgjGIeqWIjnenVasZuV9toO
         RU63pM0lxdRQbFBIFOs3EHz3PseanEF5an+6pgfaSODUL4Dta1YtktTb4U8UlwGt6dYK
         06+jmWhElsqFlzPbC0Yv/5T+WhPNR8tfG+hWBuNnaiXSNVlNqe/0xLLN7ejyq+7IDo5e
         oBrSc4JV38RqVaoyIF6/h3o5/nPxDuOGjGV/lASBVjxng3hoorFQNchx2c4TDbHJ/Okt
         fMvA==
X-Gm-Message-State: ACgBeo2Qi8qhr5HBig13rPVHizm6PmKODxAp+eFHhxlno+e/cbZG3o7/
        SAYIwhfpMUAdh9PX8lTew9LhmkkhRr3nhbYgZ8qwYki+Foo=
X-Google-Smtp-Source: AA6agR5pcvtrmJk0mlfYcddOwvV0H3YXuIYkXI5Yhm6gnI6usWDdSLbolwyPHS713FQzXN+lqi8w/8Qd9uHygvW4SiY=
X-Received: by 2002:a05:620a:2987:b0:6ba:dc04:11ae with SMTP id
 r7-20020a05620a298700b006badc0411aemr252697qkp.748.1661529270876; Fri, 26 Aug
 2022 08:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220825085810.7290-1-ilpo.jarvinen@linux.intel.com> <20220825085810.7290-3-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220825085810.7290-3-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Aug 2022 18:53:55 +0300
Message-ID: <CAHp75Vf+ksuv6Y_xY=qPdGT7XTZGKpDwPT5UDqwBMUwkW47gRA@mail.gmail.com>
Subject: Re: [PATCH 2/5] serial: cpm_uart: Remove custom frame size calculation
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 11:58 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> The number of bits can be calculated using helpers in core, no need for
> the driver to do it on its own.
>
> The mode register is programmed with frame bits minus 1, rearrange the
> comments related to that "feature" closer to the actual write.

...

> +               out_be16(&smcp->smc_smcmr, smcr_mk_clen(tty_get_frame_siz=
e(termios->c_cflag) - 1) |
> +                                          cval | SMCMR_SM_UART | prev_mo=
de);
>         } else {
>                 out_be16(&pinfo->sccup->scc_genscc.scc_mrblr, pinfo->rx_f=
ifosize);
>                 out_be16(&pinfo->sccup->scc_maxidl, maxidl);
> -               out_be16(&sccp->scc_psmr, (sbits << 12) | scval);
> +               out_be16(&sccp->scc_psmr, (UART_LCR_WLEN(tty_get_char_siz=
e(termios->c_cflag))
> +                                          << 12) | scval);

Seems it's better to calc it beforehand in the temporary variable for
both branches of the conditional and fix a bit strange indentation
here.

>         }


--=20
With Best Regards,
Andy Shevchenko
