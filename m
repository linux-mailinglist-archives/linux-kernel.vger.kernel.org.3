Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2A7571B26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiGLN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGLN0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:26:36 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354388F34;
        Tue, 12 Jul 2022 06:26:35 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id l11so13855410ybu.13;
        Tue, 12 Jul 2022 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPT19Kfs8LeMRuQNUNS/QgGrqQ3NwvwMCFw4PNMdSIs=;
        b=X8Px23L+V3za0BnD3cakHrQ4J6Ya3vYywEENBbezm987pke851PTKV3avyjDFjRkw7
         ZsMydqcBLJv1w8HwUidrwp60ZfwEAubhw+4j8iw97cXOtLbJKICSf6edAkIhIVxrVO8o
         8djHIoBs1X07CJJYqcfCtAaUFJOpJSP5MRkA6zs3DqGDRHrldH/RErwdGp23qryQlRIC
         YFIuOdj4zngBXTJUgkZUvsODCNIVAFLxd1LCmFfFpbQHujNoDKsY9Ic5Oa/8tqjIhNmQ
         r5zdPSWjKg0hnVDxffWc1k8rwNa6q5NtVYRXJ9mF76y0MxTeb43IL3FXKFltVity347i
         QukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPT19Kfs8LeMRuQNUNS/QgGrqQ3NwvwMCFw4PNMdSIs=;
        b=fi/WLCIfkY86Q5dZdxjf4GtoX0+JU8Qi1TCrVkVoWQJM+SB+jz4MAVvDlw+SPrl6UE
         JyGH3D2stV6Xfy51ADkyoK1Mt3uB63ZqxLJ7cDuriixnFpAkEe8Au+YPpuMnH14uyfwC
         LBXXGAQ2VZB2cBf2yfaShHTBhIpwikWBHwFaBoht4fIx4v7TRqf1grrnm0thOXGuqoS9
         o2NPN0KlVAY57RKnMQK5fqW1zwdZmDu0zZStwIg8enLPMfDEPtvBlKL+mfMizrz2+aHy
         kKdR5/GfcEyhwaNWdc2BtcxabZULZwK8FkpgNkAjFl40sT9l7LY2tch78FYLAP8163jU
         btVQ==
X-Gm-Message-State: AJIora+MYg3cHC8d1tws4msHb4Z97Y0JnXAFlNkkUS8o2MIBUMCkAZt3
        +sCivBVls0gJIh5c+wLN6m8gNDWzZAG1uHNYcnA=
X-Google-Smtp-Source: AGRyM1tydpkTIh2IgBmDJrpBmhXorykjG2XeC1Otp/8Wl7SPN46xnfSPreo3g9mX+Tw/YQ1D+Phgw5v+6rJXfVUMlhk=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr23004457ybg.460.1657632394963; Tue, 12
 Jul 2022 06:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220712131523.1874428-1-vamshigajjela@google.com>
In-Reply-To: <20220712131523.1874428-1-vamshigajjela@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jul 2022 15:25:57 +0200
Message-ID: <CAHp75VecnJSv9P4ZXf5g4Yi7rYySRN=73KwZ_OBFUyFtaSq00w@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Avoid pslverr on reading empty receiver fifo
To:     Vamshi Gajjela <vamshigajjela@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jul 12, 2022 at 3:16 PM Vamshi Gajjela <vamshigajjela@google.com> wrote:
>
> From: VAMSHI GAJJELA <vamshigajjela@google.com>
>
> With PSLVERR_RESP_EN parameter set to 1, device generates an error

the device

> response when an attempt to read empty RBR with FIFO enabled.

an empty

> This happens when LCR writes are ignored when UART is busy.
> dw8250_check_lcr() in retries to updateLCR, invokes dw8250_force_idle()
> to clear and reset fifo and eventually reads UART_RX causing pslverr.

fifo --> FIFO
pslverr --> the error

> Avoid this by not reading RBR/UART_RX when no data is available.

...

> +       unsigned int lsr;
>         struct uart_8250_port *up = up_to_u8250p(p);

Can we keep it ordered according to the reversed xmas tree?

...

> +       /*
> +        * With PSLVERR_RESP_EN parameter set to 1, device generates pslverr

the device
pslverr --> an

> +        * error response when an attempt to read empty RBR with FIFO enabled

Missed period.

> +        */
> +       lsr = p->serial_in(p, UART_LSR);

The only caller of this function already has the lsr value, why you
can't (re)use it?

> +       if ((up->fcr & UART_FCR_ENABLE_FIFO) && !(lsr & UART_LSR_DR))
> +               return;

-- 
With Best Regards,
Andy Shevchenko
