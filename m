Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402D353C000
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbiFBUmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiFBUm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86372C07;
        Thu,  2 Jun 2022 13:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20F81617DC;
        Thu,  2 Jun 2022 20:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D98DC385A5;
        Thu,  2 Jun 2022 20:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654202547;
        bh=/lvv3NycmYiHzFYyjK8HRNBzGIkaFOylSY60LE19OHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mFpUng26AXUoMF75cfNBHzFS7uTHWJ2nVD54VJyVniuIJGYy6nxBkU1jMAmPOC59s
         rBFUT6AyFyy/IcByb4O2EZUdJ+PzETptBqNLx6gV927xRv0lPVbmMIZ6J1TmuBxc32
         ln320ZSs0DkjrmZNKP1tcNM42Q1VV9CgP4QV22Akck5UYRVutyenoJhwYA7O5zMvFx
         +/o1JeZ8YdboJPfl22YIu5kSsvKeduO0x0MM7VMqM8jf27Hdyi8N/GmQ/QmnDe1kNZ
         AyTiglT1FN5gIoUor8N7dJ5gd8QsLOJv0iElkaG69Ghm9TmajM9DFnTWu59C0viBKr
         eNevA1k2pKoMw==
Received: by mail-yb1-f169.google.com with SMTP id l204so10345903ybf.10;
        Thu, 02 Jun 2022 13:42:27 -0700 (PDT)
X-Gm-Message-State: AOAM530bR0h+UxOxurRE/pT0e9ienGfC6HlWwWiINZpOW3IayR3vwMV+
        XRZfjcadKUaJFyjmGQli1m1Sd2A62idEaFaGXlk=
X-Google-Smtp-Source: ABdhPJz+55oyDMoer2A6nJ9U4zrEhMjGLCwNSL9mFFubVEl3KNODU5hHYDiy/zAZNyg+rDoNjx1NNaft96do/NV7268=
X-Received: by 2002:a25:bd8b:0:b0:657:8392:55c3 with SMTP id
 f11-20020a25bd8b000000b00657839255c3mr7406405ybh.452.1654202546535; Thu, 02
 Jun 2022 13:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1mkHEjRJgJPsRy+kuN=48=JEDJAeR2z9n+O71qbJ8hSA@mail.gmail.com>
 <6caf53e059758234ee12a236f967412f1df1f8a0.camel@linux.intel.com>
 <CAK8P3a1mHe3TkZa443fzsPnGUP1XT3w-DN3U5KAL6NBhc2nEsw@mail.gmail.com>
 <079945077b128fcc3cb470e9d52267f7ac763b7a.camel@linux.intel.com>
 <CAK8P3a3aUtQ6C6kVmEZKzHv2tGL3=3WXK=_agc-Mg5Pq47vbdA@mail.gmail.com> <21b7d5a3de39e9eee4ccda48ad0c66d31b1fe7d1.camel@linux.intel.com>
In-Reply-To: <21b7d5a3de39e9eee4ccda48ad0c66d31b1fe7d1.camel@linux.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 2 Jun 2022 22:42:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ZhHoA3mKC7fFNubC3i+bADdem1W_o-NVR0KBYg2Z8eg@mail.gmail.com>
Message-ID: <CAK8P3a2ZhHoA3mKC7fFNubC3i+bADdem1W_o-NVR0KBYg2Z8eg@mail.gmail.com>
Subject: Re: x86/mce/therm_throt incorrect THERM_STATUS_CLEAR_CORE_MASK?
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Len Brown <len.brown@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 10:10 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Thu, 2022-06-02 at 20:53 +0200, Arnd Bergmann wrote:
> >
> > I wonder how common this problem it is. Would it help to add a driver
> > workaround
> > like this?
> This issue affects only certain skews. The others already working as
> expected. These are important log bits for debug, we don't want to
> clear in this path. Printing warning for CLX stepping is fine without
> clearing unrelated bits 13 and 15.
> Read-modify-update should always work where we only update the bits of
> interest. Writing 1s to this register should be NOP.

The patch I suggested doesn't change the behavior unless the initial
write causes an exception. As long as only buggy microcode rejects the
write, the second write just serves to clear the state that causes the
repeated stack dumps.

       Arnd

> > @@ -214,7 +214,13 @@ static void clear_therm_status_log(int level)
> >
> >         rdmsrl(msr, msr_val);
> >         msr_val &= mask;
> > -       wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
> > +       if (wrmsrl_safe(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG)) {
> > +               /* work around Cascade Lake SKZ57 erratum */
> > +               printk_once(KERN_WARNING "Failed to update IA32_THERM_STATUS, "
> > +                                       "please upgrade microcode\n");
> > +               wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG &
> > +                       ~BIT(13) & ~BIT(15));
> > +       }
> >  }
> >
