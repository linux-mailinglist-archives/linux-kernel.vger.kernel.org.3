Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29358525BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355510AbiEMGbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243588AbiEMGbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:31:33 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DD72927AA;
        Thu, 12 May 2022 23:31:32 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2fb965b34easo80427547b3.1;
        Thu, 12 May 2022 23:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGvrUyHu8ge1QuqqAmL63DRBp3yl5wUwac/5FO1sKeY=;
        b=oQmz+qjmHskm+Y8UlEZiyXLMJ4W4szxyvCIySAtwgyv6QhEuAAtZL4Shb17etrlx1n
         7jDEmA0an/VeE4V6iukJuOY16FaQJyVgzHONtaJaLpvDTT5udn9YqPkKHSdyMiT01CmF
         n54VKqJCKcxvEKrUM8gFgt59mXaQYfaUOLgmQO5+eIA0+lS5yPh5fv8b/uktUxnQj9iq
         nfDEUlan1k5xXS6sxy9qGDd4/JvOW6k1FLoI9OSgkUkSlmXEiWKjOU37jJY2vUfeUa6o
         g//obQv64jyhFyRcJ0wafMfrsJQV11SIXLPIxoCnWtmwGdNeaQ8eR+azyglrVaHdOyHE
         4ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGvrUyHu8ge1QuqqAmL63DRBp3yl5wUwac/5FO1sKeY=;
        b=RGXZoWrvh6iEH/NYY8uGL9QqVHVxtUi04Ki6jcBfcSaVEXjZ3Os26G0VqjfQQoZA6t
         wpyFP5F4zVYvRz2jE8+vWJ+FhLwQnyZ0BiiWIiHBd/yoacUddafjMbOfUntRVkwNHVi8
         mLBAYRs/Zo2rXblw0KYhBeCoz9qltAl7q/fNzXvRU0z+z9lCquLnJuS9Uy2+O6n3NMHA
         oOkFScIqA883WTWWNgNu0ACBNXblAnoZEX9BF/lPPsGk/xFhgcJnyRXhMrG7Kda/WOd7
         1ntbDXsF/OXAU/ObRVqO250ChrogQmybD2Tzu9mlbtCFz9nYIZqYzBRBX14I9Zed2zEf
         Ye3g==
X-Gm-Message-State: AOAM531O6RkwbgKWvTI0C44LEFES5Nfu1NYZctW4jMxmqK0dhnpEI57Y
        g4ZKAuq1ipgEADbK63tZuPbvfBSKGy2qJy8zpMo=
X-Google-Smtp-Source: ABdhPJxeY9TxsdNx4g7O7h5s1kSvZZKBX7OupyEVU3U74eGdyXIIWJzCNXaaZ03mpWQo2IQSZTP2P0RfIX+dBO4doGA=
X-Received: by 2002:a81:ff12:0:b0:2db:2d8a:9769 with SMTP id
 k18-20020a81ff12000000b002db2d8a9769mr4082875ywn.172.1652423491370; Thu, 12
 May 2022 23:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220512182921.193462-1-max@enpas.org> <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 13 May 2022 15:31:20 +0900
Message-ID: <CAMZ6RqKjGJyOPCQvS95ZUc6UrgaFzjunRhU=10biAAWYT_V_ZQ@mail.gmail.com>
Subject: Re: [PATCH v6] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
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

On Fri. 13 May 2022 at 11:38, Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
[...]
> > +       case ELM327_STATE_RECEIVING:
> > +               /* Find <CR> delimiting feedback lines. */
> > +               for (len = 0;
> > +                    (len < elm->rxfill) && (elm->rxbuf[len] != '\r');
> > +                    len++) {
> > +                       /* empty loop */
>
> Question of taste but would prefer a while look with the len++ in the
> body (if you prefer to do as above, no need to argue, just keep it
> like it is).

Actually, what about this?

len = strnchr(elm->rxbuf, elm->rxfill, '\r');
