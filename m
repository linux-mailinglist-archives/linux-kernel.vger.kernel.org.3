Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E8B4CBBA8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiCCKrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiCCKr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:47:29 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804FA16AA71
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:46:44 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x14so3657309ill.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 02:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rkayb6DYosXBlxx84YY60ZOxL97EgZ7YjWOYDKlNMJg=;
        b=KNyX1y8y5ZqGw4fV1Qak5hHh8HFlRAhcvhywWjuE/ffbVeQsnfk5OBaxUBhJFiHTqn
         1j73hXdLR0707ncc4L411CdFffIiOEaHjYdCxVGRQem9MJrc5x23jWS6EUGFX8rMq9l7
         aKuQbKZLgpy7P1xnPNY6VeuRJXxYEuvKI1L6WD9UPBGTPUUhcK/D4hotmOwak5VikLRW
         +Yf4c8MRb5SsRUCsIuT41EWdWjfPmr4FJWviPkcwfwTIXyH1JcPDP1kT/Gu+XRAkVo8i
         M/we/bLcnCslPX8Sli/Pky1OZ9K7tLuVI9RthqL1cXSx6msMwCBm1QzhiAoJkfWJRsN0
         TwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rkayb6DYosXBlxx84YY60ZOxL97EgZ7YjWOYDKlNMJg=;
        b=HiOJ90SX40Mf1RZ7liqvYEPflzho7G3EyiarbtX5YSAVliPry4z51Qm4Jld3ozkEtj
         MEpda8X/ZHVJxn592YyRRAbt5tDDgMSLIzNY4uoHHHWqT+O3hqrGIW/k5VDlLikBMvAM
         eDjh9Vk6uoBl8Pl/SopT1hLUYTt4QxFigF+16EMipxIP3yVCva1bgM3yXCORNpmuWLVx
         iUWCPySyiWtiQ2CqxTphol8bgaIMjHRKyHkLEaZNEGLZ7FepKoj+34BseMU9XxnURtt1
         ZtRUr+AHj7XaONF856hZhwwaAd8BvKCpm5zRpPAKbmMO8fAaYMvtBq4jB9A3DPlTapdX
         bh/Q==
X-Gm-Message-State: AOAM532mD9j/5Ct8yRGRqLBx+t9QzHALW23XccC0Fde2l+gmbU3ThEAL
        wybGT6y9NgZNtO+Qewb1h/CbueMMr+0IP+f4i+D+kjVy
X-Google-Smtp-Source: ABdhPJxt/xYZspsncKTvXbg00241StIeteJ7MPsWLrckTX7LbyQ7P8HbHfFPaYzCZxZHNbKNSTsIZXuwJxdhUb/xjDc=
X-Received: by 2002:a05:6e02:b24:b0:2be:88f8:c4ed with SMTP id
 e4-20020a056e020b2400b002be88f8c4edmr32005049ilu.72.1646304403941; Thu, 03
 Mar 2022 02:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com> <CANiq72kNXwo7hpc0+XX_UsyT_3D9o=o0eVjqN-QtDd46kjdd6g@mail.gmail.com>
In-Reply-To: <CANiq72kNXwo7hpc0+XX_UsyT_3D9o=o0eVjqN-QtDd46kjdd6g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Mar 2022 11:46:32 +0100
Message-ID: <CANiq72mT3cWkhAjbXu+-SSq9823BT0P0zFgLWEr2hB3TrdeTGA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] auxdisplay: lcd2s: Fix lcd2s_redefine_char() feature
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>
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

On Thu, Mar 3, 2022 at 2:18 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Thanks Andy, queued.

By the way, I fixed a typo in the commit message.

Cheers,
Miguel
