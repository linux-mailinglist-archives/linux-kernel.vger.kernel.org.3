Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C150A4C78C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiB1T05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiB1T0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:26:55 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA9F115940
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:26:09 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id o6so18839010ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k5Nq2+gFOwIAZZv1z8A5AiR5tZQQa62jzNlsasSMp48=;
        b=hA07tqoOhzsc3WOqNCaR4tUruW+rdsfqY8YOw2mN7ILGOov8LZJfGyOH0+67N/0EaR
         4t/JTBCib0ytZP3PxoAumfh81bQl7oYkHnLaS7IusFI7m+FXPGCuZ+b2epjKsi5SuwbN
         6G/m+gkEWqvwTgFEdCkiL46LSGGVnwGjPchjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5Nq2+gFOwIAZZv1z8A5AiR5tZQQa62jzNlsasSMp48=;
        b=7pDtiRrhJcM2TnNf6dnvR8pJTccgqpp6cLZFshxVL4IKCBXJhfO86F/Iw22n/eXfdS
         1zIyLxwHsS/YeVOA0KONsrAWfEja9Q/nGypbauA93WHPeiJpUxBU7iYN41F5p1Z2BmnL
         Wse0uBj2N+FYDmPq/Ehz6JQRihJoCJC2GQ+t+l0/9rqmNNe98s4IrrUV0+9tYer/PlkJ
         EUe9WuOcP0XmHwU0Zxxt7HGmHFGBjCofsititxTg7Xk90tsdaIAtV+/MnPxjgLOIcDCk
         UP9oWzAlSrjXQm8Ajb/1R0g049yASamXxrpwKNOSf6JbOtQdVrH+qKMcLCaCsy8DLC2H
         918A==
X-Gm-Message-State: AOAM533DMmYiMoDZYSjhykTVXoIVSPdcWLEWNA/yXpq7bMCRmvyZCtN+
        m7gSDMUBlYu8IPEDIIXwo7JGNNv8bzsQXGJzKmM=
X-Google-Smtp-Source: ABdhPJw+8wnoSRLRNQXJARCHgdKozfvRa09Y0V3bejLHBviFp0lcTGwrkW3tkxs3Aq8jbCY0h9zQXA==
X-Received: by 2002:a05:651c:1062:b0:246:3160:268f with SMTP id y2-20020a05651c106200b002463160268fmr15618958ljm.111.1646076367991;
        Mon, 28 Feb 2022 11:26:07 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id c40-20020a05651223a800b00443d571f25csm1098338lfv.214.2022.02.28.11.26.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 11:26:05 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id t13so11125907lfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:26:05 -0800 (PST)
X-Received: by 2002:a05:6512:3042:b0:437:96f5:e68a with SMTP id
 b2-20020a056512304200b0043796f5e68amr14128474lfb.449.1646076365434; Mon, 28
 Feb 2022 11:26:05 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZ+mt3CfdXV0_yJh7d50tRcGcRZ12j3n6-hoX2cz3+njsg@mail.gmail.com>
 <20220219210354.GF59715@dread.disaster.area> <CACsaVZ+LZUebtsGuiKhNV_No8fNLTv5kJywFKOigieB1cZcKUw@mail.gmail.com>
 <YhN76/ONC9qgIKQc@silpixa00400314> <CACsaVZJFane88cXxG_E1VkcMcJm8YVN+GDqQ2+tRYNpCf+m8zA@mail.gmail.com>
In-Reply-To: <CACsaVZJFane88cXxG_E1VkcMcJm8YVN+GDqQ2+tRYNpCf+m8zA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 11:25:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whVT2GcwiJM8m-XzgJj8CjytTHi_pmgmOnSpzvGWzZM1A@mail.gmail.com>
Message-ID: <CAHk-=whVT2GcwiJM8m-XzgJj8CjytTHi_pmgmOnSpzvGWzZM1A@mail.gmail.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
To:     Kyle Sanderson <kyle.leet@gmail.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
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

On Mon, Feb 28, 2022 at 12:18 AM Kyle Sanderson <kyle.leet@gmail.com> wrote:
>
> Makes sense - this kernel driver has been destroying users for many
> years. I'm disappointed that this critical bricking failure isn't
> searchable for others.

It does sound like we should just disable that driver entirely until
it is fixed.

Or at least the configuration that can cause problems, if there is
some particular sub-case. Although from a cursory glance and the
noises made in this thread, it looks like it's all of the 'qat_aeads'
cases (since that uses qat_alg_aead_enc() which can return -EAGAIN),
which effectively means that all of the QAT stuff.

So presumably CRYPTO_DEV_QAT should just be marked as

        depends on BROKEN || COMPILE_TEST

or similar?

              Linus
