Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4095A2D98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbiHZRfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiHZRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:35:08 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5F63F306;
        Fri, 26 Aug 2022 10:35:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 12so1984713pga.1;
        Fri, 26 Aug 2022 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=Gx0JBq+l4jotXAwLDzMOShME7SK/rLYxvD99gEQvolE=;
        b=J+wIDMIfypIgTIwK9sZ84ysTX6gYuVJtwrwYEhMZDfiFA8OhCNrDqcOdHPRuauiK7n
         uHIdVewB1BXyEg+IVw70DHP/08aNHZVKiyj+E5tsY4ZisVTOVhYPbgt0ABzwPCyULlV2
         SbMmtPv7Wu8vpqDnunVR04WM7hH1AKvD5cE7FzY/3cBK+SBiKg3T9Qw/zDcfjAYQ7BDP
         P8bDEca0F1ARBQtqmGi5KDJt/V+iiz83woWDpOFZqc21eidLkp2P3vw3q5S1KtdJtPKA
         1TTbvu7EHY5W6n/HWMlvRJhV0CYVc5iPtm8jSAvIvlsHd48fDKVkWtUfr98bHIft/qs0
         q36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Gx0JBq+l4jotXAwLDzMOShME7SK/rLYxvD99gEQvolE=;
        b=z7Q42QL5hdqvKZWjEPecJhKPkeYUshxAgHc1Q5y3ghZQkOL+kobIKF1AeYNp+cc8T6
         DehVV1z6ALnZM1IMpP45NWSnN151j4xX22FntJkzLBx5Amf4gpA8L7fh8mVqNUkMUfP3
         3LSQktNrYapOFCxaYUNv7Vmktcaf67RTQ/GDkjdecwmFgW73VlOWlHBmpBvYMot/jwdd
         fMsQ9qsDAP1BcUTfpudn2YMlhLQ46UkOBJIvxCqGKVWBIUduUM4ebawaWGm2MVO6RvEL
         IKH4Q4lnYQqEzGLUjX7lvWynECPeXarcTCQ1aP4wHBDqCUfnowsVk5IdJ9np0kAOUoHs
         Y0iQ==
X-Gm-Message-State: ACgBeo3wypdF4melD+gWVvsfAGj0ghw2Xyu555YTBNQ4auNiecGqPUMR
        OsVUcNoSHL1dQc5kK1yrnlQ=
X-Google-Smtp-Source: AA6agR6pzbuZGDq4XpBovCuRLPVl6sKBi94+36RYoLCW71G5pvEYUPDBZxPBwPjhLlHGzm6VwvFt2Q==
X-Received: by 2002:a05:6a00:14c5:b0:536:7d2f:883e with SMTP id w5-20020a056a0014c500b005367d2f883emr4793299pfu.36.1661535305833;
        Fri, 26 Aug 2022 10:35:05 -0700 (PDT)
Received: from Mahakal ([2401:4900:1b28:9ee6:f819:7c30:9d1b:586b])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b0016c9e5f291bsm1890070plk.111.2022.08.26.10.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2022 10:35:05 -0700 (PDT)
Date:   Fri, 26 Aug 2022 23:04:59 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
        vimal.kumar32@gmail.com, Mintu Patel <mintupatel89@gmail.com>
Subject: Re: [PATCH v3] Common clock: To list active consumers of clocks
Message-ID: <20220826173457.GA3785@Mahakal>
References: <20220624010550.582BBC341C7@smtp.kernel.org>
 <1659463787-25976-1-git-send-email-badolevishal1116@gmail.com>
 <20220822235014.86203C433D6@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822235014.86203C433D6@smtp.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 04:50:12PM -0700, Stephen Boyd wrote:
> Quoting Vishal Badole (2022-08-02 11:09:47)
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index f00d4c1..c96079f 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -102,6 +102,7 @@ struct clk {
> >         unsigned long min_rate;
> >         unsigned long max_rate;
> >         unsigned int exclusive_count;
> > +       unsigned int enable_count;
> >         struct hlist_node clks_node;
> >  };
> >  
> > @@ -1008,6 +1009,10 @@ void clk_disable(struct clk *clk)
> >                 return;
> >  
> >         clk_core_disable_lock(clk->core);
> > +
> > +       if (clk->enable_count > 0)
> > +               clk->enable_count--;
> > +
> >  }
> >  EXPORT_SYMBOL_GPL(clk_disable);
> >  
> > @@ -1169,10 +1174,16 @@ EXPORT_SYMBOL_GPL(clk_restore_context);
> >   */
> >  int clk_enable(struct clk *clk)
> >  {
> > +       int ret;
> > +
> >         if (!clk)
> >                 return 0;
> >  
> > -       return clk_core_enable_lock(clk->core);
> > +       ret = clk_core_enable_lock(clk->core);
> > +       if (!ret)
> > +               clk->enable_count++;
> > +
> > +       return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(clk_enable);
> 
> We'll want the above three hunks to be a different patch so we can
> discuss the merits of tracking per user enable counts. 
Agreed, we will create a separate patch for the same.

> Do you have a usecase for this or is it "just for fun"? By adding a count we have more
> code, and we waste more memory to track this stat. I really would rather
> not bloat just because, so please elaborate on your use case.
> 
Use case for per user count: If a consumer acquires the clocks without 
calling clk_get() or devm_clk_get() and enables without calling clk_enable() 
or clk_prepare_enable() (by bypassing the common clock framework), then dev_id 
will not be sufficient to tell about how clk is acquired. Here per user enable 
count can be used to tell that how clk is acquired and it is enabled by
that particular device or not in case also where dev_id is NULL.

We referred regualtor framework suggested by you in one of review point
where they are also using enable count.
> >  
> > @@ -2953,28 +2964,41 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
> >                                  int level)
> >  {
> >         int phase;
> > +       struct clk *clk_user;
> > +       int multi_node = 0;
> >  
> > -       seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
> > +       seq_printf(s, "%*s%-*s %-7d %-8d %-8d %-11lu %-10lu ",
> >                    level * 3 + 1, "",
> > -                  30 - level * 3, c->name,
> > +                  35 - level * 3, c->name,
> >                    c->enable_count, c->prepare_count, c->protect_count,
> >                    clk_core_get_rate_recalc(c),
> >                    clk_core_get_accuracy_recalc(c));
> >  
> >         phase = clk_core_get_phase(c);
> >         if (phase >= 0)
> > -               seq_printf(s, "%5d", phase);
> > +               seq_printf(s, "%-5d", phase);
> >         else
> >                 seq_puts(s, "-----");
> >  
> > -       seq_printf(s, " %6d", clk_core_get_scaled_duty_cycle(c, 100000));
> > +       seq_printf(s, " %-6d", clk_core_get_scaled_duty_cycle(c, 100000));
> >  
> >         if (c->ops->is_enabled)
> > -               seq_printf(s, " %9c\n", clk_core_is_enabled(c) ? 'Y' : 'N');
> > +               seq_printf(s, " %5c ", clk_core_is_enabled(c) ? 'Y' : 'N');
> >         else if (!c->ops->enable)
> > -               seq_printf(s, " %9c\n", 'Y');
> > +               seq_printf(s, " %5c ", 'Y');
> >         else
> > -               seq_printf(s, " %9c\n", '?');
> > +               seq_printf(s, " %5c ", '?');
> > +
> > +       hlist_for_each_entry(clk_user, &c->clks, clks_node) {
> > +               seq_printf(s, "%*s%-*s  %-4d\n",
> > +                          level * 3 + 2 + 105 * multi_node, "",
> > +                          30,
> > +                          clk_user->dev_id ? clk_user->dev_id : "deviceless",
> > +                          clk_user->enable_count);
> > +
> > +               multi_node = 1;
> 
> This part that prints the dev_id might be useful and can be the first
> patch in the series. In that same patch, please print the con_id so we
> know which clk it is for the device. We should also improve of_clk_get()
> so that the index is visible to the 'struct clk::con_id' somehow. Maybe
> we can convert the integer index into a string and assign that to con_id
> in that case as well.

Agreed, We will create a fresh patch where we will print dev_id and
consumer id in clock summary.
