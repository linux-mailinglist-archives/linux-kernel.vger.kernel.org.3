Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF1154B262
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbiFNNhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbiFNNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:37:33 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A4621AC;
        Tue, 14 Jun 2022 06:37:32 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id t32so15131691ybt.12;
        Tue, 14 Jun 2022 06:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atVUmn8uXOx3ZXsVFS5tdc+EVO/H/mhk/Sw0YtUkpe8=;
        b=2IbS59IKwK6qND+1CuJYx/PC5YQAvjtQWq8RJ7XZX5glyJZWEKx5tgCi0YTuDkHAWg
         Epg6CQU3qk04nraDWvb0ineLa2RVnCgEcJkvMfBFtVYGN5VzF8yUiyGpyPdX6NS3wflO
         RLiyXJIbhBCvonKue7Sml7EvEB4g8IRIgry0Qk7EEldkTUVeY7cSiRBdCzWuf5G50mbR
         m/HwwSSSSy+BbXWctpevVT6foxWN07bjNWbgipuM5wma8YDnga7WR400zk/BMymAGijx
         WXk/7/JXdLiRMXoviS0ItHt/5oFHs+K53JlsxHOYXY+wTnFbeuDoDS+SyF2KfkdLmK1G
         atRw==
X-Gm-Message-State: AJIora9BMG6ih3kVsmQKCphlbT9idUJUHbWaq2XZxJiGK7mYXNxjJLI9
        ge3KavJn3alFPjJsTSsVvNO+uSN1ZldrBK9BKk+v5GlQ
X-Google-Smtp-Source: AGRyM1scEPpgYPOR80Q2IkzxlYtMoCM12zi1+VTuH/wUSwvgxwomSrFAd5/t1JF9fbf7IZDXFPZ0aa1rHLFJB4BHMFk=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr5217608ybm.153.1655213851134; Tue, 14
 Jun 2022 06:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220521063534.138930-1-yiyang13@huawei.com> <20220524071041.4aw3cfo3x5wphziy@vireshk-i7>
In-Reply-To: <20220524071041.4aw3cfo3x5wphziy@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jun 2022 15:37:20 +0200
Message-ID: <CAJZ5v0jCx0v-Q2=aW4nSSAHHajUnLdVtQMe3w1cX1w-o=mSesg@mail.gmail.com>
Subject: Re: [PATCH -next] cpufreq: Fix reserved space in cpufreq_show_cpus()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Yi Yang <yiyang13@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 9:10 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 21-05-22, 14:35, Yi Yang wrote:
> > Function scnprintf() would reserve space for the trailing '\0' and return
> > value is the number of characters written into buf not including the
> > trailing '\0'. internally meaning the next scnprintf() would write begin
> > the trailing '\0'. The code specifying "PAGE_SIZE - i - 2" here is trying
> > to reserve space for "\n\0" which would cause scnprintf() to reserve an
> > additional byte making the tail of the buf looks like this: "\n\0\0".
> > Thus. we should reserve only the space for one '\0'. passing in
> > "PAGE_SIZE - i - 1".
> >
> > Additionally, each iteration would replace the trailing '\0' from the last
> > iteration with a space, and append 4 additional bytes to the string making
> > it a total of 5 additional bytes. That means we should stop printing into
> > the buffer if the remaining size is less than 7 bytes(1 for the ' ', 4 for
> > the %u and 2 for the tailing "\n\0")
> >
> > Signed-off-by: Yi Yang <yiyang13@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 1f6667ce43bd..60c005c9961e 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -844,9 +844,9 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
> >
> >       for_each_cpu(cpu, mask) {
> >               if (i)
> > -                     i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), " ");
> > -             i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u", cpu);
> > -             if (i >= (PAGE_SIZE - 5))
> > +                     i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), " ");
> > +             i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), "%u", cpu);
> > +             if (i >= (PAGE_SIZE - 6))
> >                       break;
> >       }
> >       i += sprintf(&buf[i], "\n");
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.20 material, thanks!
