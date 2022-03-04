Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F8A4CDCE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiCDSsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiCDSsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:48:20 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4885345ACE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:47:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j15so15650911lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmAWTgJsRubvE02lc+7m2kh1dS4iAkm0ITp+HgJDXbY=;
        b=MyC8QIFlw3ZBEIS2ZlTWVs8YLjP2UNkCgnw4ekIHpdPCV/mv+cUDtIpW+4CD8oMeOl
         hwP/zmFd8s3X3XmgQhTVC+1C8o+KW3qluWqH3WFBeotiWtg7X+HhBlHtz38Mv91QLA9n
         F2yPFe+vIe+FaGK1jXh/jFWogCaXBsx/O1HabmyLrpNLkAmSWTYw8RFWbWxWDQy3eIxU
         eVUkyuHbekj8gDdau1KlWdG/RoC+PCnQbjFAxJA9xYmmv/kM11tTkmvR/0i/LVUpBhvn
         Jo94rmUx3ZoStAVN6mdfxGcGCZhZBXoZY+LsFtKSzaF+AUuPV7iCFtPYVNnezzn6Pkkt
         JdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmAWTgJsRubvE02lc+7m2kh1dS4iAkm0ITp+HgJDXbY=;
        b=tSvHCuYnQYk17VlDv6ksizidfHuwMA/Q83bTq/jzK4On3gCJv6DSm5J86aMmVW8Dwx
         fLKm7MJjvfwIZrnRnHTm2Odl+JISy8SJ2vwHAopb1Aih3yFkKQq8c9NufJ0oNCd8nS3x
         wIcuWDNCzGO3gegHSyD6qMa2dZxw7bzs76XD5dtza5e8IyX4yGAESO5dludsRJ2cau3l
         Hcqo4tNYDvp3o9TOm+nXLisnuTM/xqk+erGyJ+k23nUikhHBlBsJDclHO/cGoMx/frXT
         dG0ymLL8NeUGObUaSuMV5F15s6cyQcE2FtyBZ7BTBJLtVTu4MBOXJEXe/BZ3KfFZgEwd
         xttA==
X-Gm-Message-State: AOAM5304ogZHuumt0nGGQyB/Q6zcYbkK+Yn2gzxqFk7vjbnzP9ppeFMA
        Q1+/OfB+WYAC5b0vWuCVdlqX2EaUUJMwaXN54WQ=
X-Google-Smtp-Source: ABdhPJw6iQ+MY6fBcU2ACoEcyUSZfHuWFOWfwVVLP2LGQYdbMAA0ZfzrKiDewPFfNcDK+SlV8RXMY7+pWEYrAHvyd1Q=
X-Received: by 2002:a05:6512:511:b0:443:3f9f:5d5c with SMTP id
 o17-20020a056512051100b004433f9f5d5cmr93506lfb.94.1646419647335; Fri, 04 Mar
 2022 10:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Mar 2022 20:46:08 +0200
Message-ID: <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
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

On Fri, Mar 4, 2022 at 7:36 PM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>

> This pattern is harmless but because it occurs in header files
> (example find_first_bit() from linux/find.h [1]) and because of the
> include hell, the macro GENMASK_INPUT_CHECK() is accountable for 31%
> (164714/532484) of all warnings when compiling all modules at W=2
> level.

Have you fixed W=1 warnings?
Without fixing W=1 (which makes much more sense, when used with
WERROR=y && COMPILE_TEST=y) this has no value.

NAK.

-- 
With Best Regards,
Andy Shevchenko
