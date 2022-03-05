Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4BC4CE737
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiCEVfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiCEVfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:35:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2AD29805
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 13:34:16 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id dr20so24322245ejc.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 13:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFY4TtTjXdWPbTMt2IvpCEWRTxBseEWRBtu+kYXkcuk=;
        b=Yyel5NfrEkG77OKFkltSillJS5j9Vf1YU5SiNYEAXt6ScDLMX23VdX69Ho6+UNipYM
         Lk9KFXcs0fGsaU8KnVHvrlW+07FWwnjMI7DtLkD+lEsing4NkqqGBYOukpRPYGBAw50t
         BvBPK/AS4U0LOM9sbpyfyEhVKtcexORgqxVkO6QCZJPr29lnvpa/dKD6Wr16sOAehwBH
         pYzlyz9VRx8ZVn9hEPqd2zJXelVxIdC/dfn8y2FVrcyZ/yI0Z7iVHGpTAc6YEabNH8Ov
         ScNaroS3MKNLFjHWGcjRvhve+hdygRfbcKziHFn3pqsi7E0i8znZURGdjS9b45OVcnuo
         PRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFY4TtTjXdWPbTMt2IvpCEWRTxBseEWRBtu+kYXkcuk=;
        b=e+XtBMlZ5yOyj6TpXs3B8XS4BhJH7Jie5W1+/+0tRqzW0OvPtAD72UiRk1jjCV2AyD
         38mQRlUoV09k1kuzwq3oYr8Pcrlk99HcLplXPaNltgrCGIg5bmqTl8NEj/iYXDdTUgeV
         Py7qtEgnpqinghU9aFZJbmp51Eg2+R2W8SntCnjfr/1poldf+Xx/OXgzjKs/uOVZliYr
         /MgOivPoZHc/cvHZJH/+WaTwb5yL3P/ViK+2I/W9tJAQoClhQcoWhYcrwQNLWSZSmXB3
         diGrGdv9YjVnLP7jxh59E7EyLIU30ZPymnsFwRgkAfYtmDl2c4g5daq4s2+YF2nXMnH2
         JgmA==
X-Gm-Message-State: AOAM530JZqqTP2vvLP6jYlsWganBdN6ZbFKHyIu7tcIbscscXLMeAD7r
        G16Ct8+oXaTlzQ2iSpTpEda6uesVw4hVdWt2V1E=
X-Google-Smtp-Source: ABdhPJz4vmxxvwU59IvMLBk19rc8XncC8y8R1qUZrxuAe3CC7r7csI30J5hQTplD1Wk0ubq9ZID1os65qAxNIPCIaFs=
X-Received: by 2002:a17:906:4cc7:b0:6d0:7efb:49f with SMTP id
 q7-20020a1709064cc700b006d07efb049fmr3860758ejt.639.1646516054814; Sat, 05
 Mar 2022 13:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com> <CAMZ6RqJL2G=i-x3wwBD92devAxdNcnmwfDqz30+GFGobp21s+Q@mail.gmail.com>
In-Reply-To: <CAMZ6RqJL2G=i-x3wwBD92devAxdNcnmwfDqz30+GFGobp21s+Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 5 Mar 2022 23:33:38 +0200
Message-ID: <CAHp75VdTzjW_YONcFy0qQGvT-xMDQOXTYsAun40106Spzgx_2Q@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
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

On Sat, Mar 5, 2022 at 2:43 PM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Tue. 5 Mar 2022 at 03:46, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Mar 4, 2022 at 7:36 PM Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:

...

> > NAK.
>
> Are you willing to change your decision following my comments?

Have you read this discussion (read the thread in full)
https://lore.kernel.org/lkml/cover.1590017578.git.syednwaris@gmail.com/

-- 
With Best Regards,
Andy Shevchenko
