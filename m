Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C89E4FBFE7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347649AbiDKPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347598AbiDKPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:12:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4342DD71;
        Mon, 11 Apr 2022 08:09:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bh17so31513927ejb.8;
        Mon, 11 Apr 2022 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jk6M0DbfHBN0zLnudjgrB69c9HcXkYUuA3+BM6Jtrw4=;
        b=A9SlVEDpcfZWlKCkgW4Ii0W+8+t2na/CW7KYHuT3p8rKlo8pXuQjWY1ZB4TlwTOttb
         YhfsZv0Rv9AKamOEw5VZi8vGk+K1V5OADFVzP8bm6N5PlC9ckXnUnq1ZstXu0KOYPujp
         iFl0c0DeLRHY+VHguqXnK9wwQbTtGTLbZVD2iHG/lH+yX1x/CxvBhe1F130seUI6TsRY
         MbslGLrWiyFZdx+VTcwsuixiWtu7+hQwV2XH0AsAVnMHCdprNIFRQN/+cMSx9OhcwHBy
         uf7QYc1oSUzePBewqV+lPl4wwSLqBjA0UYuYARHMwdHdXNGcbR7HTJItgEYYi798FGro
         ZlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jk6M0DbfHBN0zLnudjgrB69c9HcXkYUuA3+BM6Jtrw4=;
        b=DdG3ci9BD+bhHZMRMADM0YfT+1u919lQNHyZe0rGGT5DYM6MSsQricCiejCUpn7Jk/
         n8sbVyJ5cypBgKIBZ+9a9I71+0MWqRWc5QrZY4QSC4FnoztP0m9El78XbsSMRg6CFj1u
         JIXe34jpgKRcNEfIue03ojjOZvdV3qqKHSIDvX1MV+voOeDN5uezSVR8WXMPrmDCAzLS
         nFHYgZDDIx2zDP3YZsY+Ah8q8xwAYQSf3z0xIBoZYCz5FsQsgQhfPBgCnQY7/h8wBSrp
         7Ms4vQg07kiahzMfehM9pRupiD5PyH4l+xyNBS1ytaQ8+MgKKaSNU6PMBQe8GGiBh/h5
         PEAQ==
X-Gm-Message-State: AOAM530KtLIaXr3wQS3OJqF6n9lyxbaDfJviA+gh9Vfnr8nnMLM2QvKu
        5ZlXp2c+6cAidXS0Ee4V5YF0zpSTzOpqmqWrFzf15RLLiD3z9A==
X-Google-Smtp-Source: ABdhPJzTliG/iioOIcrQyniSG2pOQ+CpW+KIB1/ppsWIrMr0hnnOshu4TzUdgVPi8gVXv+q1QUKI11gbfTJ3e7M3wqU=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr30659865ejc.636.1649689790278; Mon, 11
 Apr 2022 08:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <1836398.tdWV9SEqCh@kreacher>
In-Reply-To: <1836398.tdWV9SEqCh@kreacher>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Apr 2022 18:05:37 +0300
Message-ID: <CAHp75Vc2Lci4ewdosqX4Thm6ME7pKjKw+C+wtUsq2esRM-eXjg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Avoid device usage count underflows
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>
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

On Wed, Apr 6, 2022 at 11:49 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> A PM-runtime device usage count underflow is potentially critical,
> because it may cause a device to be suspended when it is expected to
> be operational.
>
> For this reason, (1) make rpm_check_suspend_allowed() return an error
> when the device usage count is negative to prevent devices from being
> suspended in that case, (2) introduce rpm_drop_usage_count() that will
> detect device usage count underflows, warn about them and fix them up,
> and (3) use it to drop the usage count in a few places instead of
> atomic_dec_and_test().

...

> +               retval = rpm_drop_usage_count(dev);
> +               if (retval > 0) {
>                         trace_rpm_usage_rcuidle(dev, rpmflags);
>                         return 0;
> +               } else if (retval < 0) {
> +                       return retval;
>                 }

Can be written in a form

               if (retval < 0)
                       return retval;
               if (retval > 0) {
                       trace_rpm_usage_rcuidle(dev, rpmflags);
                       return 0;
               }

...

> +               if (retval > 0) {
>                         trace_rpm_usage_rcuidle(dev, rpmflags);
>                         return 0;
> +               } else if (retval < 0) {
> +                       return retval;
>                 }

Ditto.

-- 
With Best Regards,
Andy Shevchenko
