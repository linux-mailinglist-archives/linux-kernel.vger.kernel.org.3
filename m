Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5CA4EE92D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbiDAHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiDAHnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:43:52 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DEB25E32B;
        Fri,  1 Apr 2022 00:42:00 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2e592e700acso23421367b3.5;
        Fri, 01 Apr 2022 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D57KhCyXWppjWMlxegqq8QrdaCvKLyGDT+/mDhkcfao=;
        b=oEwgIAvR84Cr82p6tkGSq/QGT+3Am17w4Qxl+9/7YvSlHkGmnBuKnkeahOHeWvuDjd
         C6bkPcTnsNEidPruyaKA4HtVqTCWDNu1LyyDfy2Uf3A8boKJojoFDFSnEA3qngUkis8L
         uPYnrka0B3CYolh/bQ2FaRFg4jpg9XfM3tGeAB+KYCltvKOZv/WNII/p3tHEbngIix1o
         3oVuZT3ORu4DKG6S43zeOfj3yh/RGL+GevIeCd60tUaKV+a8nH39EPW7dVRuaBCGnYWq
         V0Fz/vSqL0gStvTBnwR5Tca8RSzmpvRXLt8J5Ce0M9lZoTiyq/81GA4y8s8Em6lbw6gr
         rFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D57KhCyXWppjWMlxegqq8QrdaCvKLyGDT+/mDhkcfao=;
        b=NnF3wrqwfBzfQDqt9PFPnUjaD793+ZJhmo2d/4icp11AUlpXOB00p6v8/ozGJVvFfE
         A81xapKr8wp7l8U4RA2XF0JJvQIYszFp3ggqFw7vMVjf7DKpMraE7bwg2lPKm0JorYGR
         YY4JGC4D3lISAN45nVXneMLsM8eKB4d6WOn0GkN1MHb8A62TBTDG8liNAL8JqqKMkXrI
         A7uAmjIhfaigdQ88E/UUndbNFXrkHHC/BOyhmo8uGtZGtyEwcKo7o+HqmWXDxYCFbAKu
         D3hY0N2ZFsom/YF+yxfSj7ARscqI1vr4YTAPkfMF+bGbC4N0ukZHQdZ7HuIGAZToe3xH
         2pwg==
X-Gm-Message-State: AOAM530WNP69hWUVQ7O+mso2eJ8S2PX0dVp6g4GDk3vN+rKwymi/tQth
        hmUB6DXCq24UD+h90/4DjIQ/hWGwyPd/5d+6/FuyQUPOpHUvNw==
X-Google-Smtp-Source: ABdhPJwc9fh3Rv/jfT3zBI2wuBLJmieHUjQD1s8VKau3ct3ymn1EXNYUXDqKWn9oH8HbQHtRaQQlfEwBQEfLJq8Oxbk=
X-Received: by 2002:a81:d0d:0:b0:2ea:61b1:181d with SMTP id
 13-20020a810d0d000000b002ea61b1181dmr8729677ywn.16.1648798919207; Fri, 01 Apr
 2022 00:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <YkYWzf7J17AfXgLl@robh.at.kernel.org>
In-Reply-To: <YkYWzf7J17AfXgLl@robh.at.kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 Apr 2022 08:41:33 +0100
Message-ID: <CA+V-a8sia2YgWmry+SxJu3asD47PSD6UnND33599ygTBymPy_g@mail.gmail.com>
Subject: Re: [RFC PATCH] of/platform: Drop static setup of IRQ resource from
 DT core
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Rob,

On Thu, Mar 31, 2022 at 10:02 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Mar 16, 2022 at 08:06:33PM +0000, Lad Prabhakar wrote:
> > Now that all the DT drivers have switched to platform_get_irq() we can now
> > safely drop the static setup of IRQ resource from DT core code.
> >
> > With the above change hierarchical setup of irq domains is no longer
> > bypassed and thus allowing hierarchical interrupt domains to describe
> > interrupts using "interrupts" DT property.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi All,
> >
> > Sending this as RFC as couple of more drivers need to hit -rc yet with
> > the platform_get_irq() change while that is in progress I wanted to get
> > some feedback on this patch.
>
> I just applied this on top of current master and pushed to my
> for-kernelci branch. It should show up in kernelCI in a bit. I did this
> before all the fixes too and there were definitely a couple of test
> regressions.
>
Any chance you can share the regressions or maybe the CI script so
that I can reproduce it locally.

Cheers,
Prabhakar
