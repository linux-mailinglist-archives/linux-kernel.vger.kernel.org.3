Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F287551411
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbiFTJS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbiFTJSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:18:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1536452;
        Mon, 20 Jun 2022 02:18:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id um5so4870951ejb.5;
        Mon, 20 Jun 2022 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OBDb8+EHsywC1sWORQkwWBvQ5vhlilwVW0bHJD11CSM=;
        b=GX99+7R2JbJOWlg09LQWo6ERil78LgaO9beLsUg4fzM2vZKXqRI3oCvD8U9NhDaxEO
         mL3MNlFAnxeh5K6Sy97so7+2/s4VoDpBk6CqLaACGxgvEKanXZhAOxx9Z6Q6r+hxnCiK
         BwPTBYeZzOTZ/9L3sxlPRsAw8WXksC5NPEcYM2MhytADZZJapDC6n+MRbScZBVUf82KV
         Y6NoSEXmce0I97uGLu67ER2gAsgqwwbNI1/1gKT+Oj/+HMZ7unTqUcFdl26ENxEpUwru
         PP048S7yfYkdnEggUp7jDIHZ4RSYneaObTd+gcC8iJm00LwNnQdYyQZDQCe463tDNDGj
         2GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OBDb8+EHsywC1sWORQkwWBvQ5vhlilwVW0bHJD11CSM=;
        b=XVtbLCwP4pGcxfsw+q3KbBHCKEqOIYyULmslh7kq/pS2bNYE+8OFvCdG7B4tQGwBJ1
         8Nzd9QQGise4f9z5+/WdbuVG2yJOme9Y5tpETMzQJGRTfpgxvhYLhs22deWgcu0htcWk
         L4tVEtMZcSG2nBRdVlgYug53fKYj3w88fT4CKockAXou8TyktYfT7CnAhDpxTe7UyV+D
         VdJHh82UwLkPV6L4OQVUG+fPQaB7oMAPRcVkhAkIa/5XAxiwYdFkUhZkyNWAKIg7jw8e
         8QVFp7DHvsFO7+EtEP+9j0uP3yv24xveQczAC4QtKRyZbrEuokVPLTLbbD94CP3568Y5
         0lZA==
X-Gm-Message-State: AJIora8PTNpKlsQBXahgR1vbhGD7LWZ/8zF38jkUBVG8koOrjjwe91kG
        VApAZDoHb/LsthV9yL9gConXIjzG0nFQTch1RrNJMQudHz/D6Q==
X-Google-Smtp-Source: AGRyM1vQMS1QkqFB+UUmS4kuMMjw928dXIoulZwgezgIYW9ID81N9dO7dqSOiWTPiv+3g7W50IXDLj1oDqKErEWPewM=
X-Received: by 2002:a17:906:1193:b0:70d:cf39:a4db with SMTP id
 n19-20020a170906119300b0070dcf39a4dbmr20209192eja.44.1655716713463; Mon, 20
 Jun 2022 02:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220619074030.1154429-1-mw@semihalf.com> <CAHp75VdmtFJe5k_6biofS0HtgqC7HQuNzrM=9cMhM1uz1p5Eng@mail.gmail.com>
 <CAPv3WKeR+iVE5KObWHmsSxDZtCqCbcCkoLWksmwhiu9E=ZcOxQ@mail.gmail.com>
In-Reply-To: <CAPv3WKeR+iVE5KObWHmsSxDZtCqCbcCkoLWksmwhiu9E=ZcOxQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 11:17:57 +0200
Message-ID: <CAHp75VfpNkADuzo_-99bm4Lh-wJ3Dro9+oOszc=1oG4FQheHOQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: dw: enable using pdata with ACPI
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com
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

On Mon, Jun 20, 2022 at 11:14 AM Marcin Wojtas <mw@semihalf.com> wrote:
> pon., 20 cze 2022 o 10:01 Andy Shevchenko <andy.shevchenko@gmail.com>
> napisa=C5=82(a):
> > On Sun, Jun 19, 2022 at 9:43 AM Marcin Wojtas <mw@semihalf.com> wrote:

...

> > Since you are touching all of them, please keep the order
> > alphanumerically sorted by the HID.
>
> Sure.

With that addressed,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


--=20
With Best Regards,
Andy Shevchenko
