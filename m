Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6AD4E5E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348123AbiCXGXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiCXGXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:23:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129C388B;
        Wed, 23 Mar 2022 23:21:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u16so5134675wru.4;
        Wed, 23 Mar 2022 23:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tt1gnFUVOjy7DM7AnSze+o3evcZBkMeKBPG5L60Xxg8=;
        b=g9gvM76leF5tz5qwyFh8+zHaO2VLpRU4dWEjiFsGMzAYc/DnvTp6jzM+BP1TAz4xas
         j5sWi5dfcD3VKC3wSxye7REJMDd18WL1eCy3jR1QeM31IHC2TkbkE0nNH+I1dlumOQWd
         coLbtsbhO+q5LGKOdyorIRL51D9kOkSRM7MbcU+YoZdm5CXcjIS/xHxkGRilS4F/aZal
         MBdJZeghfrs+vTKgT3LhDhJvtAhImGdsFCtqRkbDt21nsB/YtdBL9v80QL/VspbUXwrV
         /YJtucD4W72Dt/EeRyGqwEKliuVYvWmY9R0JM71My8j30XqX7KUUOe8E3n2JMIIleqrg
         sgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tt1gnFUVOjy7DM7AnSze+o3evcZBkMeKBPG5L60Xxg8=;
        b=u7zasoo9WdPrsy6kkPdyvTVHSbGHbUAZmTDz4qNWl/rlK5y1H/AkujNt0vMcrCmJkR
         IV8c52iwVbE5BRhD0/F4I2vaZIE/MZEbAEAP37gndk3pssu6LqdqHsLhpU68/10Vo+Pm
         NoP7kTE1hX12RbiHsljKpf3oGm0JuZWGSN5oyNOEQ7ahp/Tl5kSJW7thN8iYTXLuXZaw
         0gQ2/MsCc8f/X5XLwvwyFweLQxOYpG2UOLHZYBa5hGaIICNs0LQm+xc/NPIuBombPQka
         AGQ5NcQLkZM0qegG08Qvv2ttadifsY63aLIfFnqeJnVdBAtaVaOwjWMP0COxExHaX3Vp
         yIxA==
X-Gm-Message-State: AOAM533fXDjYNO0s4nrxe1fI4cT8uYLNFi1oDa5V0V/0BWMmlkyZ0qeM
        VD3ZV59L0QEfkhzqCI3+PxWV3c0VLPKBnAQ9BsEfegl4
X-Google-Smtp-Source: ABdhPJwUp0RMRwkYNb/dF6G6eKGRwaCCa+u0zySlNtyDMETmqFg8/JAhHfd/E4NA3QPA60XaBNJMW/vEuPdmGfue9nM=
X-Received: by 2002:a05:6000:2ca:b0:204:1e6a:d2a9 with SMTP id
 o10-20020a05600002ca00b002041e6ad2a9mr3236043wry.182.1648102901176; Wed, 23
 Mar 2022 23:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220323054001.17344-1-diego.viola@gmail.com> <ac99cc8e-11c2-d96b-9ce1-ce5618b7b378@opensource.wdc.com>
 <CA+ToGPH+FQ-6QM6MWt6Zoe_pTyL6LTn9-=-694f7xLkSVCCr1Q@mail.gmail.com>
 <641a417b-acac-6b0f-c330-b94b6ed97b99@opensource.wdc.com> <CA+ToGPEAhWDwFLNHqXvtuumvdLQb=kzme7fdrgBfb4zojVvDNQ@mail.gmail.com>
 <a030b9b2-d94f-ed62-60bf-cc629da3e944@opensource.wdc.com> <CA+ToGPGVdwXgWTZFa24PDMkpXrVrpM48WAxR4U6d4D9t-k=nJQ@mail.gmail.com>
 <aa410785-b9db-cb97-2fea-f24336472f98@opensource.wdc.com>
In-Reply-To: <aa410785-b9db-cb97-2fea-f24336472f98@opensource.wdc.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Thu, 24 Mar 2022 03:21:30 -0300
Message-ID: <CA+ToGPGM-mcDzODYGPx_=AT608YJaPGq7KdW+rLLxjQUwUN_pA@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-core: fix "it's" typos
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
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

On Thu, Mar 24, 2022 at 1:14 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 3/23/22 17:44, Diego Viola wrote:
> > On Wed, Mar 23, 2022 at 5:17 AM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> On 3/23/22 16:24, Diego Viola wrote:
> >>> On Wed, Mar 23, 2022 at 2:53 AM Damien Le Moal
> >>> <damien.lemoal@opensource.wdc.com> wrote:
> >>>>
> >>>> On 3/23/22 14:52, Diego Viola wrote:
> >>>>> On Wed, Mar 23, 2022 at 2:45 AM Damien Le Moal
> >>>>> <damien.lemoal@opensource.wdc.com> wrote:
> >>>>>>
> >>>>>> On 3/23/22 14:40, Diego Viola wrote:
> >>>>>>> Use the contraction "it's" instead of the possessive form "its".
> >>>>>>
> >>>>>> Well, while at it, let's use proper formal written English, so:
> >>>>>> s/it's/it is
> >>>>>> s/isn't/is not
> >>>>>
> >>>>> Fine with me, do you want me to send you another patch with those changes?
> >>>>
> >>>> Yes please.
> >>>
> >>> I sent a v2 patch changing those things you pointed out, however, the
> >>> whole comment[0] looks informal "But wait.. there's more" and I don't
> >>> think replacing "it's" with "it is" achieves a lot in this case.
> >>
> >> :)
> >>
> >> Indeed. Do you want it in or can I drop it ?
> >
> > Given that the language is mostly informal, I'd rather see the first
> > patch applied (if that is OK with you). However, I agree with you that
> > it would be nice to see formal language used, I just don't think I'm
> > the right person to change all the comments in that file. :(
>
> OK. I will look at it.

OK, thank you.

>
> >
> > Thanks,
> > Diego
>
>
> --
> Damien Le Moal
> Western Digital Research

Diego
