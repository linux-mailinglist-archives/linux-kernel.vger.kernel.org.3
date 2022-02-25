Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447C94C4F26
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiBYT6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiBYT6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:58:35 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E576E541
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:58:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b9so11179572lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAcXT0JlYVeeRaWrb0GIE0XjHyI4xXDoEv72/weIX30=;
        b=LH+IMXBEpsz75K8Oz0kWwz6C9NxUKaqDAg6XsphPoRmwkOmiX9Qr8n+GvOZiLNLdW1
         C5swddkKcacUYlgaDanpKOHq4x47GxVhn1kFmjnf1AnBRQutXga06dDFQm6BskN9lI14
         5SMxe+bN4ppyQbNcjAidPMIfNm0ooCFU0Pvs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAcXT0JlYVeeRaWrb0GIE0XjHyI4xXDoEv72/weIX30=;
        b=gts1ySPXHWgs3cu7adDpoclv71FjTdoqj0QIGhBgK13LTAOIHEACudXsLuB8r0aop6
         xZO+GTw69rSjDhl+3GWOl5MOJj4F8gUnk4iQFjKp8GnDPSSNb//EoiSZJ8R+E4xuOoFk
         yqcKPKLUUWYTzuP9LMkRZwX9lAO7fekP618tTOVBpwOdm5mk/PKJf1UaADzMvwp64zTc
         GfaDPP+b1qSBlGnaAyNsYD10U13vit49lbQlaiOsBpZImed3gFpcIKomnSTAzZV+PdaM
         SpoS2b32smqDe2QLMRhtFIN8hXDCkONHc5Qimvlcvak0kaUd4lD3tZ0CA8BbwaWdtcU9
         8aLA==
X-Gm-Message-State: AOAM530ERl7AJsFcDBIr9A9XOUt65l4GXW8uNlAzq/fiJA5lkgNV9dax
        34n0MECQFrCrCGBmqKaFVcPB2eXKM9Hqd3mq
X-Google-Smtp-Source: ABdhPJw4hTwoOi5oFPbX+R29yqr+CjhsgDE2Q2+TEnDrOSdNyL4zgxuo4KZjqmoFqDBxb/ljq7Iunw==
X-Received: by 2002:ac2:46c9:0:b0:43b:b45d:56de with SMTP id p9-20020ac246c9000000b0043bb45d56demr5848016lfo.338.1645819080779;
        Fri, 25 Feb 2022 11:58:00 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651203c900b0044399c17e58sm281764lfp.224.2022.02.25.11.57.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 11:58:00 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id u7so8804617ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:57:59 -0800 (PST)
X-Received: by 2002:a2e:aa1f:0:b0:244:c2ea:7f20 with SMTP id
 bf31-20020a2eaa1f000000b00244c2ea7f20mr6253961ljb.164.1645819079606; Fri, 25
 Feb 2022 11:57:59 -0800 (PST)
MIME-Version: 1.0
References: <YhjYPIRvDnV7XAzV@kroah.com>
In-Reply-To: <YhjYPIRvDnV7XAzV@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Feb 2022 11:57:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLvye-_qj-J=dVWhFf7S8noL6d-szRtFYq_hoOk6J1Eg@mail.gmail.com>
Message-ID: <CAHk-=wjLvye-_qj-J=dVWhFf7S8noL6d-szRtFYq_hoOk6J1Eg@mail.gmail.com>
Subject: Re: [GIT PULL] Staging driver fix for 5.17-rc6
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 5:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> It resolves a reported problem in the fbtft fb_st7789v.c driver that
> could cause the display to be flipped in cold weather.

LOL. WTF?

I just had to read the commit message for that odd thing.

             Linus
