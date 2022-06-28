Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AD555EF04
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiF1UOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiF1UNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:13:47 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D56E05;
        Tue, 28 Jun 2022 13:07:30 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31bf3656517so37739377b3.12;
        Tue, 28 Jun 2022 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c/GQKZklxrXc730nl15odaZvAaabHINb7nSrrPIVO+k=;
        b=AI2hQEQM8pBIbh1DBPtlWS456KJnPdsTnxh2BT06H8P+y8cRZTDiW9Oj9Qrdw5ffdm
         KZZY0sd2SnmAhf/rql19DBCfzIugecKy+bLE85GpXDHyDbL8Zi6CYnSKof8VIRw6lWWr
         aQLo9uSz88FKbf94Wa1kWFk0DfhBa7q0KwWhCwVLypSIwb0e3yjqUhoGAJgMt2ontDcQ
         FKyXhe3dro+NS/zQ3CMX72hDQqeqs7gSvyJpzRaVMk/M+PpMo8atbBAVk6wklgSi9CvZ
         V14EiHwArHWq3nXZ66BzHbPVh7JLzJSQaSP7Zq8o1VnVoP3b/sb36sTTIUfRnUdKgm1a
         Dn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c/GQKZklxrXc730nl15odaZvAaabHINb7nSrrPIVO+k=;
        b=MPeZ6LoNcpS4TjhYMjPtvohPGB7gdjQcyaT3nB4VNFlryqDIh63/Hmb5ZnW5oETs6T
         2t1Oj1VArfTCQ6Y96NGyxb2q1zjjwQbQC6t/+I7ay0Ggi/6VD759IITCoiAVmWtzeSww
         lT8EY98jEUsdSBmlm4l/+8F7niLKKo5Hef7l4dy1DwEAwA8j9em9UbELBli3aCsrk4YL
         15T3sphumey6SHQ+OggI8MExw2/VpQoZpsZiPPn/hDylj36B8J5j3wQs6SGF1WwEm2kp
         CZu/Z9didzkzXAiFDtie+VqczMfEq8r+Xv0yCXPSpeVC4oJ46pQmOcbJ1u7TuXb9lhWU
         AifA==
X-Gm-Message-State: AJIora83orRJJh2V2VYJ2XBppLpJ1PjVkv0IsEPnbY/U54EnHVOSIsFO
        LkbNC4uKmRUsNy2osX7ZNODCq3WIUpJHBXRHi/9lzxOIAhcr6w==
X-Google-Smtp-Source: AGRyM1tzA+2TWuABI4p6MQVqros66rG+v5Kn9AEUCQ8B1eukViAKPfD+ubCCxkikqLSDAvsulAIZfUXBAXC1zhbNcVw=
X-Received: by 2002:a81:6f02:0:b0:31b:dd95:1ccf with SMTP id
 k2-20020a816f02000000b0031bdd951ccfmr10498299ywc.520.1656446850149; Tue, 28
 Jun 2022 13:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com> <20220628134234.53771-4-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220628134234.53771-4-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 22:06:51 +0200
Message-ID: <CAHp75VdfEwvhm_KR5Nq+XMqY8k5q5orBoMggNR=f=WAi6Lfqsw@mail.gmail.com>
Subject: Re: [PATCH 3/4] serial: 8250_dw: Move 16550 compatible & LCR checks
 to dw8250_verify_write()
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Tue, Jun 28, 2022 at 3:43 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Rename dw8250_check_lcr() -> dw8250_verify_write() and add comment.
> Move LCR and 16550_compatible checks there. As offset is now passed and
> dw8250_verify_write() ensures it's UART_LCR, offset can use used
> instead of explicit UART_LCR.

...

> +/*
> + * DW UART can be configured to indicate BUSY in USR (with
> + * UART_16550_COMPATIBLE=3DNO or version prior to introducing that optio=
n).
> + * If BUSY is set while writing to LCR register, the write is ignored an=
d
> + * needs to be retries.

retried

> + */


--=20
With Best Regards,
Andy Shevchenko
