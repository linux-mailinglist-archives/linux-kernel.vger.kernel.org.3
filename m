Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8BB567922
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiGEVDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiGEVDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:03:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CAABFB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:03:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so18224572pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T7jfukz90Ob2JfdVQehLAL1rB3Phy+zQ5zWoyzZ+bgo=;
        b=o1f7n1RmCZmCNSlG0/vbZHJdePzHTDBV+8mZZVlMk+HCHTa+pkQ9r2oM2kFWpIpf+l
         2GgNane8uY5cmNJ4vhKPDuftIRcx9DWgwD32BTIKQe3RhxVVgHg09/rM+sIVv2YaUzBh
         /7gy4vTiL1KT9XDsTWTJ1JzM056rfpWk/Ncv4N4nHGcu2N4UQ3X21gbVgaOUytppPOWw
         c4KvI9kfEwZ89NMqdunGBD52gDos+4mEg1/FPnXiNH1ARFWQIiLjssaJ1le6OFCfG1dn
         UI/fGTsJvhYsLHAoRSSa9a0I6o77LdFPcpOx3KW687AqJ/8cywSncm/ayU3zFEayG61S
         1LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7jfukz90Ob2JfdVQehLAL1rB3Phy+zQ5zWoyzZ+bgo=;
        b=UYJdLuqLbpXoxArjHfg3CxttRQYlRLf8i4SShQB9GnCxLPH1HC3jGrEHqJvC4cROzD
         rY6SRpBGcsn+4RxxRGAA7B7mh5RKAEt59YflrcfdDcHuo22CA/FUGlE38pmNJo7lENEq
         Pn45HyDnLrtCkq/EFkXMvqizR86aaoAJM0I10y5me3CGwGwYEjw+CJnezACsMAZn+//6
         VjuP3X5rLP7cGp3lQ9jfidbRQfWoLNNDVRC+2KdRu8/y8/F7g2jkeQDAIyJQ3r86BOQ6
         oxMJuz14ggqGP2IxOJZMF1ukjrhntcEcHJLGnkEsNCpRGuDJJ+JVAjvPPWBQMFwkWB1a
         2ZHQ==
X-Gm-Message-State: AJIora9hG8DQQ5DzSRqd0DYpGOZhTdJ7mrdjkSRojhHdbGMKQCcydcH4
        ytVtp8Zgoh/WWk8d+ZJ9vwXzfePpOPI9jx7RqfQETtYrjl1ek/VJ
X-Google-Smtp-Source: AGRyM1vNwtUgaI6PQwYqr9dYDCI11Ymb0dBL4dk8ktVRiYsGIERWQ319Gx3XCjjD3MaD+AsqhUrqI8SAjDWw9Bpgwy0=
X-Received: by 2002:a17:903:11c9:b0:16b:8293:c5a1 with SMTP id
 q9-20020a17090311c900b0016b8293c5a1mr42502139plh.72.1657054981629; Tue, 05
 Jul 2022 14:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220705150002.2016207-1-varadgautam@google.com> <YsRkPUcrMj+JU0Om@kroah.com>
In-Reply-To: <YsRkPUcrMj+JU0Om@kroah.com>
From:   Varad Gautam <varadgautam@google.com>
Date:   Tue, 5 Jul 2022 23:02:50 +0200
Message-ID: <CAOLDJOJ_v75WqGt2mZa0h-GgF+NThFBY5DvasH+9LLVgLrrvog@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Perform bounds check when storing thermal states
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 6:18 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 05, 2022 at 03:00:02PM +0000, Varad Gautam wrote:
> > Check that a user-provided thermal state is within the maximum
> > thermal states supported by a given driver before attempting to
> > apply it. This prevents a subsequent OOB access in
> > thermal_cooling_device_stats_update() while performing
> > state-transition accounting on drivers that do not have this check
> > in their set_cur_state() handle.
> >
> > Signed-off-by: Varad Gautam <varadgautam@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/thermal/thermal_sysfs.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > index 1c4aac8464a7..0c6b0223b133 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -607,7 +607,7 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
> >               const char *buf, size_t count)
> >  {
> >       struct thermal_cooling_device *cdev = to_cooling_device(dev);
> > -     unsigned long state;
> > +     unsigned long state, max_state;
> >       int result;
> >
> >       if (sscanf(buf, "%ld\n", &state) != 1)
> > @@ -618,10 +618,20 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
> >
> >       mutex_lock(&cdev->lock);
> >
> > +     result = cdev->ops->get_max_state(cdev, &max_state);
> > +     if (result)
> > +             goto unlock;
> > +
> > +     if (state > max_state) {
> > +             result = -EINVAL;
> > +             goto unlock;
> > +     }
> > +
> >       result = cdev->ops->set_cur_state(cdev, state);
>
> Why doesn't set_cur_state() check the max state before setting it?  Why
> are the callers forced to always check it before?  That feels wrong...
>

The problem lies in thermal_cooling_device_stats_update(), not set_cur_state().

If ->set_cur_state() doesn't error out on invalid state,
thermal_cooling_device_stats_update() does a:

stats->trans_table[stats->state * stats->max_states + new_state]++;

stats->trans_table reserves space depending on max_states, but we'd end up
reading/writing outside it. cur_state_store() can prevent this regardless of
the driver's ->set_cur_state() implementation.

Regards,
Varad

> thanks,
>
> greg k-h
