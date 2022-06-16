Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD03954E991
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377995AbiFPSjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378000AbiFPSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:39:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9352541B1;
        Thu, 16 Jun 2022 11:39:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m20so4346767ejj.10;
        Thu, 16 Jun 2022 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGYFIH9aSkriLdFfiKulB4E6eyOYQPrarXGAwb17SDA=;
        b=eQVuGG1rUjiWvp+r8nAzdDDY7VksQYDYjLVelqq+oyBm5mlEOPtz2QUVbJjKsliM3S
         OZKN0bSAG4ovLj2DuCOcL3DjW8Gh/4BVNBu/bTBXSNIz5+39kzi6FNfzaOZLo1l52ES6
         iZb2fiKyVeQqd63/J66fQ/ONrwQ4bjuA5lSvtUFgxIZx1RBW3wqXJ6AuDugGi5ohNZx9
         hfY0AUr3pbciYQrwNbwZGUGoPftkEv3vBEYTx7htdHsuFpK5xru9FJuK09WxTJyodms2
         PF8PNEIq3NigPKJe+9Vfkt0X5cN1TmhYTO+eN88DHrIWu812u0BWiEiLZWjmVsiqYddy
         UmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGYFIH9aSkriLdFfiKulB4E6eyOYQPrarXGAwb17SDA=;
        b=S3Z9H2I8yEbbru9I+pA0w/j9fsQJKIXw7VLoBZHoBVoOD/4M1A7xkiqrn6vaxZBICi
         a8kcln83a5Djse/K9sXtFP6iGEhSdpyGaRTbaYIY4BeXuAibUcEmFM9o0DXKoT619DA0
         UDWlQ5xgw76+a9Os6XlpXuIsSAh/BRL0DiRMCoPJR6k2hXtVlccbu344v7Q7tBOkuiNL
         +uDjP7TktLxMLMB1tU5SBD8ueWnqqnWicd4dTUGbWSWJESsh5u9Oux+HYh0UkVBH7bt1
         rWOuYrgo6Nde+yGud+k3P40oewoSMYb+tyOxhAg9/mkacdEyCSiv6mYOIoWzYsQjgbYj
         0iJQ==
X-Gm-Message-State: AJIora8XKKpN5L3NRbVOICs8b47ngUUWh3ESPG2punP929gZuUcdLqb0
        LU0iGkUoIK4kLLP0/8jh9otA/HWGdVUfRXMW+tM=
X-Google-Smtp-Source: AGRyM1vO9rGooCHoVbpV/hrK9KzzzVRjUCAqtktqt/IjEA491gU+sNk3TEM+VuufSUnbaTlCKuqlmrdgFRxBRsBnlR0=
X-Received: by 2002:a17:906:a202:b0:711:29a:c96c with SMTP id
 r2-20020a170906a20200b00711029ac96cmr5860508ejy.407.1655404764089; Thu, 16
 Jun 2022 11:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com> <20220612090507.20648-3-stefan.seyfried@googlemail.com>
 <CAHp75Ve+vrfSu6pD+AKe-eCVA2pC5o520y4gVwLNg9Dtk0U5bw@mail.gmail.com>
 <CAHp75VdFPUHTeDBY5ukFgVqJJn7BbTHxrxKUGOLB6P1UX-utAg@mail.gmail.com>
 <d80789bc-a8fc-de5f-164a-75adf7097311@message-id.googlemail.com> <6969ca0e-4a4c-c995-02a2-6645f875338c@redhat.com>
In-Reply-To: <6969ca0e-4a4c-c995-02a2-6645f875338c@redhat.com>
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
Date:   Fri, 17 Jun 2022 02:38:46 +0800
Message-ID: <CAPqSeKugObSvP=CWVp6+7J+O5a0xA9o77+_CzcKZK_hn49iGqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all hotkeys
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>
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

On Thu, 16 Jun 2022 at 03:28, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Kenneth, can you check with e.g. evemu-record or evtest
> where the double events are coming from ?  Obviously one of
> the events is coming from the panasonic-laptop driver, but
> where is the other event coming from. Is it coming from the
> atkbd driver; or ... ?   Maybe from the acpi-video driver
> for the brightness keys ?
>

Certainly. I'm happy to dig deeper and see what it's up to.

-- 
Kenneth
