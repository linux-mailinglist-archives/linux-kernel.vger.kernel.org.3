Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3453C4B0C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbiBJLPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:15:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbiBJLO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:14:59 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F68CCA;
        Thu, 10 Feb 2022 03:15:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cz16so10231302edb.8;
        Thu, 10 Feb 2022 03:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86WvMXZHLjkGbiJZp5ccobLzsZbB0pdZcrhUodCwW5E=;
        b=jbBWNeFpcaENFcXzIP+FtT16BHbVbBhNZ8K2JjRHALDwTKGfZd94WmyMuhUTeSVcyt
         t4TfJ4Ql6XAQ86Wy9jqNgMthktqHp8XwXmcrCUp2OMVrjjs7y9coNUd/tursxZzXQ1Cv
         t81NxiWRlVc1q6CIxQzv0DWYtfjlT9ATbIfXX57rjYiGEAx2NHTYoB5Kkqs+QEjwAC6N
         Cs/VMcgAcGHZnIToTNwxG/3ro+MnwBd5aw+55RhGytRlEmGamtSnTtGMi9lQPb89EI4U
         NrBj3LwMyti1KEPBaBLta2RaUHPUkcYy6CBLKyrTQgN6WRTx0ewpxkuqGxFlh/5vpGVe
         5TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86WvMXZHLjkGbiJZp5ccobLzsZbB0pdZcrhUodCwW5E=;
        b=LFxt/krCB59yni4XRTq3yE20uRoeXmS0MLevpH740S7C+WtJecynZdIEZt5tvb/gn6
         nEqN9tvQ7gHVu5JrPc8/nk58dpuqrNu7VWKt2Ncj7RMI14sv44q/lFawhEvBiH3ERUJS
         wUWcXs984sBhzURYUvuxdUPag/fblGA7ZUMd9UP+NOEFIzoQplha803bVq41N0zJPMuw
         lh1uCR4v5QKwo7SGSFTDgJuVKoF0t9VdrHaCnZ22b9dO1Rga6jQaLFQeqVzCOw7gtbEK
         b9O7fK/lJhDWws5+L9Uh5z+a/i/aMfjAdBxrIaXyU6DWI6reT70Zza/4480N6Xzn/Puw
         TYyw==
X-Gm-Message-State: AOAM533zvqVQ2t2cC0XW6N1j0rUXiOzoGYUTwu6Vw4dsOlFPZZNaZV11
        MAZKzukCkuNS4bfM/Nv0OaDVtRY1d7hlHpIQR8c=
X-Google-Smtp-Source: ABdhPJwt4DzuSAvUl6+QCoPSNRZVDryR+G7Pk+UnooBQRefAASpZeECFwgpI2N0KRWI9tN4IO2kRQIA5cNfNs1sDIhs=
X-Received: by 2002:aa7:c413:: with SMTP id j19mr7838615edq.200.1644491699638;
 Thu, 10 Feb 2022 03:14:59 -0800 (PST)
MIME-Version: 1.0
References: <a0f3e5d6d438710413d1909365f99ae4d2a4bacc.1644399683.git.yang.guang5@zte.com.cn>
In-Reply-To: <a0f3e5d6d438710413d1909365f99ae4d2a4bacc.1644399683.git.yang.guang5@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Feb 2022 13:13:28 +0200
Message-ID: <CAHp75Vd-Zszg1j6aVrX_oEJdiq4m=69JqE4RvyPMqEu30RFaTA@mail.gmail.com>
Subject: Re: [PATCH v2] serial: 8259_aspeed_vuart: replace snprintf with sysfs_emit
To:     davidcomponentone@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Johan Hovold <johan@kernel.org>,
        Yang Guang <yang.guang5@zte.com.cn>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
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

On Thu, Feb 10, 2022 at 12:54 PM <davidcomponentone@gmail.com> wrote:
>
> From: Yang Guang <yang.guang5@zte.com.cn>
>
> coccinelle report:
> ./drivers/tty/serial/8250/8250_aspeed_vuart.c:85:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/tty/serial/8250/8250_aspeed_vuart.c:174:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/tty/serial/8250/8250_aspeed_vuart.c:127:8-16:
> WARNING: use scnprintf or sprintf
>
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.

sysfs_emit()
scnprintf()
sprintf()

...

> CC: David Yang <davidcomponentone@gmail.com>

> - Use the CC for patch sender

This is incorrect. The submitter must have (the last) SoB tag.
Question was about authorship just to be clear.

-- 
With Best Regards,
Andy Shevchenko
