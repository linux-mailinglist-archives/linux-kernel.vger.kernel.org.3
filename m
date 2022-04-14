Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35BF500DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiDNMso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiDNMsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:48:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F3F90CDB;
        Thu, 14 Apr 2022 05:46:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r13so9818782ejd.5;
        Thu, 14 Apr 2022 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+M837Urr6A7Vvnw0Y3wnBbKb5YHV7jezFX96gP3j/Q=;
        b=R5QiYWs8uIVHI/bFUGoxldB8ujWq+bxvQmlAkpNEFy3ab3aweXaYN7m27HvHDh00c+
         aXkdQSI4sJvYctZNP3nVNNkG3WXv+rqpG6t/GFfyqNrRWdBWaa2qp4oK1C6bz0YksBtX
         FIB95VRfE7D1EgVe11npDPImqvi/kSd/5Cg8eFJqLCsogWM1DxqgnVF04CSpac9hQQrc
         Sa3BFCfUywXamsFsdiaUaubyxYBrwZOrZt2RGvzlzzp8P6P0wrOx/nDTsXlFYTzpeojA
         nVNjyXPI01vy4OVYEndK1LI8eznm8IKmirbjsOvBazCCw/rLpd0sz99OqXwFkcAt1AaU
         39Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+M837Urr6A7Vvnw0Y3wnBbKb5YHV7jezFX96gP3j/Q=;
        b=E6CEla9pqeIGH1cACgYoxjRXeWBHfimMsPqR/tG601bxkgQnJ7+lDFIUClipAChMsT
         5xsnkm/c1z/MC3Q1QT65JdYhnDPbQGFVehmM9BuIT7Q60hmnKiO8MPqUdffQKHJei4xy
         uySlFcqxSxLr9AIGwnYoORI98sQHvj6u2p5f78hskHvwu9ub+VkcedI4kjq6TYMLSgZy
         qiQuOlWbHxgxdIqyxSx8Q9WIsivt+tlJyAYwCNmWi2AHcUk6TgEKBZ1WXTTISsY8i16Z
         SVyTv7tHK9YKmhVTAxxpdx4RRN547akqUxNK6gHOLYiBSqeSNbxOlHaUG1zr6mYTYLdP
         iMsA==
X-Gm-Message-State: AOAM530BYLK8zw5hH60mvynXZZIU85O4/EFAKfm2OTBuZp0C389sqJrO
        bjsJcuOY+qwPjC5cH0Gl1+Qq3t7bcgdgiiew6iYdfWqgx0sUDA==
X-Google-Smtp-Source: ABdhPJy6iwiaZ/9dozhrX8wFkLGHDxMGpSMAuM7B+LiGPMmwSo9kj0R+FiFZ4RigqLojxYoNqEYw8eS+bdqHcqV0vdk=
X-Received: by 2002:a17:906:1692:b0:6e8:d245:44a9 with SMTP id
 s18-20020a170906169200b006e8d24544a9mr2161338ejd.639.1649940373277; Thu, 14
 Apr 2022 05:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2203310114210.44113@angie.orcam.me.uk> <alpine.DEB.2.21.2204132103190.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204132103190.9383@angie.orcam.me.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Apr 2022 15:45:37 +0300
Message-ID: <CAHp75VdOf3+j8yQh=-f6iCN_gRhisgoQjov2kK1fhgv7xaBJRg@mail.gmail.com>
Subject: Re: [PING][PATCH v3 0/2] serial: 8250: Fixes for Oxford Semiconductor
 950 UARTs
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
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

On Thu, Apr 14, 2022 at 1:53 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> On Thu, 31 Mar 2022, Maciej W. Rozycki wrote:
>
> >  Here's v3 of the outstanding fixes for Oxford Semiconductor 950 UARTs.
> > As the change for the default FIFO rx trigger level has been already
> > merged with commit d7aff291d069 ("serial: 8250: Define RX trigger levels
> > for OxSemi 950 devices") only one patch of the original series remains.
>
>  Ping for:
> <https://lore.kernel.org/lkml/alpine.DEB.2.21.2203310114210.44113@angie.orcam.me.uk/>

I still didn't get the answer why BOTHER can't be used instead of
spreading the old hack. You mentioned fractional baud rates and
something else, and I asked why do you need them and from where you
got the limitation of 16-bit values for dividers when using BOTHER.

-- 
With Best Regards,
Andy Shevchenko
