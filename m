Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D2590F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbiHLKdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiHLKdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:33:44 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4318AA721D;
        Fri, 12 Aug 2022 03:33:43 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31e7ca45091so6010907b3.3;
        Fri, 12 Aug 2022 03:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UxBtbERKRh6ik9gzCjPNzlllpU4KxVBTC6cNbI4+dXA=;
        b=LawWhrTfx1q4KHMfhSlSvd/0gmio1DmqKNElQy5yd08bWUdj0hFLVyGRfX8kvjc1Xb
         5cDn89Ue5RGBAaSoe6f76D5zoQZxFjIGyUQZLqgB/wdtc8zMPNwIE2AS79QWiC4CK+CP
         O15bUcPZfzo7q1Dv80ZyxUxl4zbX/iuJUTtAUnYxT67foaDGQ43k1pMjuYp0Y/C7L5QG
         Bu1fPvdcKkyv6hTb9ti9OM1p0iU1a7hrvJ8YuuJspN+jqwz55rc7UjZmt6YXazYqmCQ+
         bGAYjAQmmHc/5IiEd6M0TyrUv54rSiZRkyzdrF9Zwc2O59wpjIyebHvvhAMlZXQBCQeq
         SQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UxBtbERKRh6ik9gzCjPNzlllpU4KxVBTC6cNbI4+dXA=;
        b=roR15rgo2o/chAYh1Ox+krWzxRdhiJR4sgNHDi4k5iv4j+3G9wF/DI9ewjh/YltAYc
         5SnKZArsEwG31OYW2i+tFA+Yw2u6jxDPrsLHmyK0w5XxuztD5HZfkyIXd6ZTpbm2/VuJ
         S+I2gSzhSpwZ9L5UHNUHyvrttGWVzipsGYUV70yQ9rQWhoU5yj72T3N38WhC5/szwTtl
         Dr497P8hm+lTjGH074dx+0VXMrrb4t9HMXk/syIW4ziM/y8lXjMcJSwRO8gjNBMNDd67
         cQeyb8GvcOI/MzuBa93JR3G8XMUaQgCJkcztiaLjAXuOfoNyCNs8bc9h4W+Ct7l3v8my
         XQ3Q==
X-Gm-Message-State: ACgBeo09+fNbo48WckWt0e4HryjGX3Vr5lEffVlfYyK7EZDFO4Cw3O5r
        bdBixN09QHA2o9LbzJjsYo9W/EhpcY42H2Vt5hk=
X-Google-Smtp-Source: AA6agR4An6m0htG1a8vO9yYMul4FjxPrN1j/kQAfemDJpmPKdlnnzZZTUnBZqPfRukXwqEgd170A+PfuFMtIU8hkkAk=
X-Received: by 2002:a81:bc8:0:b0:32a:17d3:d189 with SMTP id
 191-20020a810bc8000000b0032a17d3d189mr3228899ywl.401.1660300422392; Fri, 12
 Aug 2022 03:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220812094438.18291-1-lukas.bulwahn@gmail.com> <20220812100238.GM3438@kadam>
In-Reply-To: <20220812100238.GM3438@kadam>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 12 Aug 2022 12:33:31 +0200
Message-ID: <CAKXUXMxLuViULgrgP89uBNvbUYcWFiohgWD=LXkifCGTT1WYFQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: clean up a needless assignment in ieee80211_sta_activate_link()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
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

On Fri, Aug 12, 2022 at 12:02 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Aug 12, 2022 at 11:44:38AM +0200, Lukas Bulwahn wrote:
> > Commit 177577dbd223 ("wifi: mac80211: sta_info: fix link_sta insertion")
> > makes ieee80211_sta_activate_link() return 0 in the 'hash' label case.
> > Hence, setting ret in the !test_sta_flag(...) branch to zero is not needed
> > anymore and can be dropped.
> >
> > Remove a needless assignment.
> >
> > No functional change. No change in object code.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  net/mac80211/sta_info.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> > index cb23da9aff1e..492c7a29d797 100644
> > --- a/net/mac80211/sta_info.c
> > +++ b/net/mac80211/sta_info.c
> > @@ -2778,7 +2778,6 @@ int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id)
> >       sta->sta.valid_links = new_links;
> >
> >       if (!test_sta_flag(sta, WLAN_STA_INSERTED)) {
> > -             ret = 0;
> >               goto hash;
> >       }
>
> Please, remove the {} as well.
>

Thanks for the pointer, Dan! I need to remember that for the future; I
did expect checkpatch to warn me of such a stylistic pattern, but it
seems that it does not. So I just need to have an eye on that.

Patch v2 sent out:
https://lore.kernel.org/lkml/20220812103126.25308-1-lukas.bulwahn@gmail.com/

Lukas
