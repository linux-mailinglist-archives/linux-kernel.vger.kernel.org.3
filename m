Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6345055EF16
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiF1UQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiF1UPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:15:35 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354FA22520;
        Tue, 28 Jun 2022 13:11:51 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v38so13412452ybi.3;
        Tue, 28 Jun 2022 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lpdyBe2AV59ZpXf73CSyj4dmFGX8uoEP2C5WAaf/8vo=;
        b=PSHeg5fB6kmLDuaz96YwsKHZ0V0X60xBNOcDhIZaJzEQnRg90NbGYFRHwFq0B05WQr
         TVEeQqVefdEsKoV85CejteUyi9gG1iICcFNQrY6TBytTx2gDHyhpZk+lBol9tjiNfHid
         hXjLKKc8hER+4FBNTb9SppO6Zh6X8Jj08fFV0o/g6WMHBoVGosTaOHs7mUZBkW8ASVLf
         aI1yJkWOi819LATJX3Kc9uRky7G5aeQRz3MOSO5pdmQR3K9yfliNQ6yt4PvH8zRkAz4u
         J08lrbkUJlMTVjbkA2sTbf/gTWF8kSwMghkn2yGh8vEPpxMb/13P0Ypy8BRnXy9dI6vn
         CvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lpdyBe2AV59ZpXf73CSyj4dmFGX8uoEP2C5WAaf/8vo=;
        b=zJO2Dy7PB+tL9q9FSKFMAvw8U8a/uB+xkrqqOKeLXBwVz+uhQxEct6yCicuo5ta9zS
         +fliGQ8UIgf18kDGHVFxm4Xpre0YaD+WNQ3AY6b8yOMEHOV+32KZMiI23d/ysbbE6gSM
         YdhRFR/d9NzEv7GYCT1MpdjJi/jZE1QC531CavWHa9burFmS5c1dJB7l7Lm3hotNKUOi
         LPrXrYPE62mbEgeFZaciHa/cBlLlYD/P1BBBfSdkvxtWpjOlH1mL562Uuc6tvvhknPiY
         GzlQJfiCIPeP7e7WkltjWM0MMKGqkEuMW2Ot5Vpjcf1oTPAgP3Nrn+73awuVAq1s3utf
         ofLg==
X-Gm-Message-State: AJIora8DBWmOwlkkc7fuC1cTE/Zc8QE3JNLCM0PJ6b0NYJFN3T2qtYKU
        9Fe802tuF5Qgn+vlYyNep7n4IK3dhaAG6wZZteE=
X-Google-Smtp-Source: AGRyM1tqr5HUS2I4UaTCpYLTZ0+CvyEQJK5fpn/naEI5vXuIxruATVpG7wX01RiNVRdImpwTumzpGVWEE1njr+JRU5o=
X-Received: by 2002:a05:6902:1142:b0:669:651:1bd4 with SMTP id
 p2-20020a056902114200b0066906511bd4mr21566989ybu.385.1656447110422; Tue, 28
 Jun 2022 13:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com> <20220628134234.53771-5-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220628134234.53771-5-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 22:11:14 +0200
Message-ID: <CAHp75Vf36sFqX1SL4Sjz6ZgNXP41Nom0Q1s6Psgv9WMFkKtGtg@mail.gmail.com>
Subject: Re: [PATCH 4/4] serial: 8250_dw: Rework ->serial_out() LCR write
 retry logic
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
> Currently dw8250_verify_write() (was dw8250_check_lcr()) nullifies the
> benefit from differentiated ->serial_out() by having big if tree to
> select correct write type.
>
> Rework the logic such that the LCR write can be retried within the
> relevant ->serial_out() handler:
>   1. Move retries counter on the caller level and pass as pointer to
>      dw8250_verify_write()
>   2. Make dw8250_verify_write() return bool
>   3. Retry the write on caller level (if needed)

I'm wondering if it's possible to utilize one of iopoll.h macro here
instead of copying retries and that not-so-obvious IO poll write.

--=20
With Best Regards,
Andy Shevchenko
