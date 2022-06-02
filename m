Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEE653C146
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 01:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiFBXPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 19:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiFBXPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 19:15:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7468D37A9D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 16:15:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id n10so6122390pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zch35iVZw1YIk5ddcG0/IquuRupfhf/J5JVLRBMigWU=;
        b=ny8JfmsQW/sex64nA3Qi/USizF8XSO82i4/853Te4SA2TmwR9wwswdRx6htNNy3S96
         318+VOLw5CbHbaJ4GTzIYnngzfCcC3aXhowAVnJEioK5cArfXtXTVTFEZXGUPMAdNOvq
         IooWNpuFYZdw6SY9SuwtONvBj6cmw2iCFwlame39eyRWCAupZtZE+0J7S4ox3C5NrMhX
         CfXY7IkFSaEj4TWU3G6yJYjstJaH9JerlFIaRbrOgbQxXOJbBLdHtkjKef5+cVfuNe9m
         cxdneTV5w8jN1N68dVqJhSpuoG/Uqsh9VNe30HBYNGePzJmQGbaoC5SqMzGQOp6ceGyn
         V8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zch35iVZw1YIk5ddcG0/IquuRupfhf/J5JVLRBMigWU=;
        b=C0UWRWHnI1HtiYSlVbh7qXTjbIvlKPBElr1Avi3hb2fRn04cE23h+lGNebWKQsBhjf
         /B1NJ9VYnSAjmG3spRIruvzQZV/gKigkP3e7/eIRtgxlr6LgJngv14jyYxJHmwtWsB63
         Ok438Rd/76/8Cm3IwW0Um5yMEA+vkozMB2FWsEWwCwaxuog4kG6Sp8RnGuK30y4mZA7Z
         Ep37C+bcXy9RZMriZWA8GAulCeW5P9MMhYWeu7xRl4zn7Ds+jwnLtYQdnCEADzj1/MWI
         1HUrK9+sphiiz6b/JF5Vp8bY6cnu2HE4jxxUtUb5MANNaI/IqTq7lAAp5/UucQq8yyw2
         964A==
X-Gm-Message-State: AOAM533Cl+DyxWY5474j7UUWfG2bRoe3l6bX8UcxSgJrfEsLC8kFeDV0
        4H10qArIpt0iynThsl4Jt0rVr7Bsd5POaMES7Iw=
X-Google-Smtp-Source: ABdhPJyNwt/B+Vb9B98mXzVS9C3h/QZw2x7E+2OaQXDDpSBSixA5OQh8byIT1+UXsr4ekt3UuHfD/6Py/EkNuMF9708=
X-Received: by 2002:a17:90a:ce84:b0:1e4:d803:fad with SMTP id
 g4-20020a17090ace8400b001e4d8030fadmr13165728pju.99.1654211732920; Thu, 02
 Jun 2022 16:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220602182159.248387-1-shy828301@gmail.com> <20220602182159.248387-6-shy828301@gmail.com>
 <Ypkk0pRHwBrI9Cj/@casper.infradead.org>
In-Reply-To: <Ypkk0pRHwBrI9Cj/@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 2 Jun 2022 16:15:20 -0700
Message-ID: <CAHbLzkqfdFmiEymUfp=_mWK_6tRKeMe0pQ6fGAPLi=oL326LtQ@mail.gmail.com>
Subject: Re: [v2 PATCH 5/7] mm: thp: kill transparent_hugepage_active()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 2:00 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jun 02, 2022 at 11:21:57AM -0700, Yang Shi wrote:
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 79d5919beb83..f315c70d5256 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -209,7 +209,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
> >              !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
> >  }
> >
> > -bool transparent_hugepage_active(struct vm_area_struct *vma);
> > +extern bool hugepage_vma_check(struct vm_area_struct *vma,
>
> Please remove the 'extern's.  They add no value to function
> declarations.

Yeah, thanks for catching this.

>
