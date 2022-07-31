Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57A7585E19
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 10:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiGaIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaIVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 04:21:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5457211C3F;
        Sun, 31 Jul 2022 01:20:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bf13so7210927pgb.11;
        Sun, 31 Jul 2022 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=BbeBlEzfKIoYoxJLsvPnu3kkJcCgSyIMRtJaW6dfGQ8=;
        b=DwlQaS0SFmnCA0HfARMIGxP7uBp1xj4BX520kd14TIoa70J6rUWEuN+xSAk0XL9pon
         TY+1nHBz9Pqe5RVg8sAnpUda5pDnLkz/Cs0LNCguKWpOmna7e2aiX2evt8OFtECY6i2K
         ET1nYkqetnI5R8Mw1sOQaSsDAAZQ5W2ZdfFcH+VD2Ez7h9+fhHKUEDFR6JwQXQOid418
         LFN5ZpgMBsfavfte8BtTZeKm4CvbnMrkIC27/jnrbh0712bOxpg6pZ1JplqHwrpU4XgY
         1RP4vkS6K56hCRRATwFgftqcLYeOvaghfl1zDgYzr+8ESe7ftHy1eCBRFlDIVqziEgAd
         y72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=BbeBlEzfKIoYoxJLsvPnu3kkJcCgSyIMRtJaW6dfGQ8=;
        b=X0PLvCWdWiS1igMOVd6sJn4+bU5L28pMN8ZIr47ipnQIT3gH2pjjeY0A/qQFnTRtmb
         LDmHwMxk9T0JyxM/XejiL7XieWghH8gVC0bYgWC0Yg7qfLRcDqpzaiq7QpGIlhlSPQBK
         oRl5qe+4y7mUqiS8+XWXcr3dH7V+CjTH6CJpJjhxdFDz0vWjDUhxwlTRUgNHMxd8EvPd
         RmT/+ZSeesFj4IjI5rMLbrlEtbJagxJ3QdFy1wXVYBb/6M2PGbZGxsFCrgb581UAWlrp
         VlS9bJ1U7hfdf4LQJs/c9SlQ+3fqQBwVsE4O/l9MWCLUEyiguBMlAqjkJI28staq+nDY
         yIzA==
X-Gm-Message-State: ACgBeo19SiuryTv2Uu6Uh46OXU/Zi/a2sRhzTq2HD2IKB/JuvbE+xzx1
        NG/M9rYgzgXXkrurI1f/624=
X-Google-Smtp-Source: AA6agR5DB+ZxAN35aR66Rs8m8W7hvLJd2+fo0NvDDsH4mtoHDdzNZ5SlCgJkwMzzpRzJ7WPwf8hmaA==
X-Received: by 2002:a63:8049:0:b0:41b:e8db:d912 with SMTP id j70-20020a638049000000b0041be8dbd912mr1923025pgd.380.1659255658841;
        Sun, 31 Jul 2022 01:20:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903120d00b0016b8746132esm7127339plh.105.2022.07.31.01.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 01:20:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 31 Jul 2022 01:20:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexey Klimov <klimov.linux@gmail.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        atishp@rivosinc.com, atishp@atishpatra.org,
        Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog
 device
Message-ID: <20220731082055.GA4008925@roeck-us.net>
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
 <Yt5Zn9cXDe9/F9RJ@kroah.com>
 <CALW4P+Kd_XdvzGfA=Cmtu0c=kEHfhp2pph2Wh0Sa8Fm8GxDRTA@mail.gmail.com>
 <7770401d-fe3d-bda4-a2e2-55cd004a2d07@suse.com>
 <CALW4P++5ahRdK6WvghPgpPcTuoJyezU_=s6MG2nn4OBRWZYGXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALW4P++5ahRdK6WvghPgpPcTuoJyezU_=s6MG2nn4OBRWZYGXQ@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 03:34:16AM +0100, Alexey Klimov wrote:
> On Tue, Jul 26, 2022 at 8:48 AM Oliver Neukum <oneukum@suse.com> wrote:
> >
> > On 26.07.22 02:21, Alexey Klimov wrote:
> > > On Mon, Jul 25, 2022 at 9:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >>
> > >> On Mon, Jul 25, 2022 at 04:06:05AM +0100, Alexey Klimov wrote:
> > >
> > > [..]
> > >
> > >> Anyway, driver looks good to me, nice work!
> > >>
> > >> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > Thanks, Greg. If you don't mind I'll use your tag in next version
> > > after making changes suggested by Guenter since there will be no
> > > significant functional changes. If code will change a lot, then the
> > > process (Documentation/process/submitting-patches.rst) will require me
> > > to drop the tag.
> >
> > Hi,
> >
> > while thinking about this a question arose. How does this
> > device react to a USB reset? A watchdog that can be disabled
> > by a simple reset does not like very reliable to me.
> > Do you need to implement pre/post_reset() ?
> 
> You're right. Upon reset the watchdog is disabled even if it was active before.
> Adding empty ->pre_reset() and ->post_reset() helps to avoid that, but
> looking at Documentation and other drivers it seems that I need to do:
> in pre_reset():
> mutex_lock() to block any other I/O to the usb device;
> __usb_streamlabs_wdt_cmd(STOP) to stop the watchdog;
> and do not unlock the mutex;
> 
> in post_reset():
> if (watchdog_active())
>         __usb_streamlabs_wdt_cmd(START);
> mutex_unlock() to allow other's I/O to the usb deivce.
> 
> Seems right?
> 
Not necessarily. Is other code doing something similar ?
Using a mutex like this creates the risk for hung tasks.

Guenter

> Best regards,
> Alexey
