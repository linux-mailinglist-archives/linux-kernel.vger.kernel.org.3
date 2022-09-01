Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305E65A967B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiIAMRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIAMRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:17:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67D4117AE4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:17:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z187so17274587pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xWg9vWseJ0vGCFN4/5PNMcvbHQf9T6lN5XKy27FC6ac=;
        b=IgpsmeVmKubge+xXzYFDFlQF06BsFao8lKDbEayczz0tTLfNRmCcJm3lk/xmNhxp7Z
         nFwkqMD7WaxHSsaHS26w05bgLYWY/BrMWFm0XawJ+4Yc1gWgi7LioAQRQzmf55EiTR5o
         ECQMIcwHdY15ue7kGAYmApQY1H/2Qz/aFyk8bA1TLrAgrXToxVruoFddRL3SjGY/j5th
         kx2HdElyBvUsW0CUFxDllqfNH5+6Mlk9dYq1NiwMEOCjKiyvLT9y9hC/b27BY/0Vg7I+
         ctJu8dUXe7wIZ5JHq4uLYfV3BDECkR4pbVnIBGRsRuPkfYezm89MysKKssqJsGKYzurL
         h/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xWg9vWseJ0vGCFN4/5PNMcvbHQf9T6lN5XKy27FC6ac=;
        b=qighQHy6thXwhJDnUaSStK52ogVOYU/yNv6sCkR+q8QXyt3YQt8EmB31ALxVuhB/+Q
         8gBV9ASKUyXHVRrrB+1BNYKrM1rfUQyVOJK4IEPYPld2KiaI3p3KnVPTcp8zOxU4lqK8
         YFcOHQDHf5Ct/ZKreki7c9rILix91dMXVvwbiOHk0K0kUUe48s+v5nDMyTWrpzCMih/L
         0OXqH+wyX+jG4Z3L97VkJp5/MK4MusQJBVty8WG5vw0vw5oNG4qQY0AsAfq2Oqic8ByU
         h9YhiXYznajuz8JSDRvB0q32sjfWnFk8TGEfwEeg1zu+tplFmrc8gd4Vr2MR9iZ2Xwd+
         DY7A==
X-Gm-Message-State: ACgBeo2OPSizr2C5o9Vp6jA3wMsbhyKeuplgyf9t9b+bQmHZ0Yl92Jzy
        L9MIXlDlxV24YZ4LbrVvBRJdVzto++Zg3eAu18A=
X-Google-Smtp-Source: AA6agR6TEK+tqlcnxtFCFr/6xyVnEZt6VEpgROats0J7Z0KAJHpJJaNEeQpk+RhjXcgdfWleJqb0IZugg4VAplsz5W4=
X-Received: by 2002:a63:4142:0:b0:42b:5b22:f2fc with SMTP id
 o63-20020a634142000000b0042b5b22f2fcmr26808494pga.573.1662034626413; Thu, 01
 Sep 2022 05:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220831052734.3423079-1-song@kernel.org> <20220831160111.a6e7d17785ca21ce7c43981c@linux-foundation.org>
 <CAPhsuW4SGguyoFKpN8S=jFCWfLiDM-f5QwV7UPwkQ=LjQEXaNg@mail.gmail.com>
In-Reply-To: <CAPhsuW4SGguyoFKpN8S=jFCWfLiDM-f5QwV7UPwkQ=LjQEXaNg@mail.gmail.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Thu, 1 Sep 2022 14:16:55 +0200
Message-ID: <CA+KHdyUDGkUBtnAcvu+NB=S7chp_1N3XviTkkMoP-8LrLJQgbg@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
To:     Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Baoquan He <bhe@redhat.com>
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

This is only for debug purpose.

Even without this patch, the debug path would work correctly. The
difference is just only in
whether roots are hardcoded or passed over function paramter.

--
Uladzislau Rezki

On Thu, Sep 1, 2022 at 2:47 AM Song Liu <song@kernel.org> wrote:
>
> On Wed, Aug 31, 2022 at 4:01 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 30 Aug 2022 22:27:34 -0700 Song Liu <song@kernel.org> wrote:
> >
> > > find_vmap_lowest_match() is now able to handle different roots. Make
> > > similar changes to find_vmap_lowest_match_check() and
> > > find_vmap_lowest_linear_match() to handle different trees.
> >
> > What are the runtime effects of this change?
>
> The code is gated by DEBUG_AUGMENT_LOWEST_MATCH_CHECK. It
> is only compiled when the developer enables it explicitly. Therefore,
> there isn't
> any runtime effect.
>
> Thanks,
> Song



-- 
Uladzislau Rezki
