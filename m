Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655984FB21C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244464AbiDKDDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiDKDDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:03:45 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB14A615B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:01:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id be5so6734437plb.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bh1s9uxexwTw1ELDK3yJyYhpuulAoc9fKiuOEPmNgmk=;
        b=Qp89A0lArNGWfGInm/+ZtR5F/BeXJGZYtTEShodbwkPxzFGm+OxKgjW0mRLNzh0QAS
         A6mJ20EnwS/OB8/ONbs02zT9QjnGhHDFq/9hC2nt3DC5fDlGcyst7kZLw++u7SqxQD+Z
         ZI1OnsI9qds3pWd11R3Q3uyHkuopQ70uNk/jMwSDrGQxlJy+pfFyj/VJ6FobEs95REsA
         M6wtASkwj8gtSm5XbRKDhUlry/uc/j/802nE95AmDYjQvSCIet2FESG0P7ARjy9MTifE
         tQYu9CrZA0yf5pWxeWwgfu+WLSwKt6nDyjVM8cplHasYZBHcCasHewRTRVIkPBdtyTFx
         FOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bh1s9uxexwTw1ELDK3yJyYhpuulAoc9fKiuOEPmNgmk=;
        b=HGhumUY+q28rCCGEJZUzs+RhPeL84QxwmUc2S8jB0idbsRgPOPX2AZbHvCPeM2SR7c
         oRsataGU2bu/h+ho0x+dIwO7l8DUzOjBfnqBfYi49ALrIb3PhGfUfNu0vpmkfNNSplpr
         H922x3MCYFf5xf5oVh7wB0R/SaxWyqZFKIGb3NjvZ9NJFJeQFw2kNNBP8uY+dWwl2MTL
         XNkjcjyfBl/CRQFg1JoYYii1tcqqqVQsss2i5D8D6eBZB/NcT7J2YsDnltlPGSof3bax
         R89cwdC0fCU8UiUy7UFHRt6w1h2Lng91fDlkotsC+cqEIy/EvUf4emRTLDt0PqrfshMC
         pwxw==
X-Gm-Message-State: AOAM531TEgk3ecye9sjU9ol8iEilnalr9h4qo27J/03S/PkOnjxfnA+j
        mRXyjxsOwqTZJO38xj6ckKWjvQSS7tIOqQ==
X-Google-Smtp-Source: ABdhPJzHJHUK2MZTnOitY76+0r2LRH2b4+OGdurRvqtMUvXulPu1TmCCKfbn9zMtoEplojrnUVceow==
X-Received: by 2002:a17:90b:38d1:b0:1c9:ba10:353b with SMTP id nn17-20020a17090b38d100b001c9ba10353bmr34159522pjb.9.1649646090350;
        Sun, 10 Apr 2022 20:01:30 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm18265124pjv.57.2022.04.10.20.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:01:29 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:31:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] opp: replace usage of found with dedicated list iterator
 variable
Message-ID: <20220411030128.4n4bsxhdzxdasmn6@vireshk-i7>
References: <20220324071815.61405-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324071815.61405-1-jakobkoschel@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-03-22, 08:18, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/opp/core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Applied. Thanks.

-- 
viresh
