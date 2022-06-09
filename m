Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8241545707
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiFIWQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiFIWQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:16:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437CB1203EB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 15:16:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c2-20020a25a2c2000000b0066288641421so15477792ybn.14
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a7HKcIF+i0T4+qY1S/nBDjlBN8LZbn3HajfMjAd6pgE=;
        b=myr+KdqGBf+8fU62rrrc6vdWLC4zQ+EyY6QFdgZ42GfmTyENhLo1IAw3h2RNkQhUwn
         0XIlmFI5we6dPTmcL5OoVRYkNlg1LkiEp4m7TTvZUlR6ue+fe982BLupBD9KlWv7xdeq
         tEyC52lTuBzUzYKgufcIPK7Ci1BaDygPGjKQT8u6/zm5afnc2zO7GbJDlDaelSa5C9I6
         m1gTG8o78bI6STaoseXyxF12CneUqy+nHYwCQMj9r7YNbTeNrJ/xKj0EQk+nA9+z1UEj
         WUT+SwL4WoBwN+LsZ0RrnI0mPP8hfuMvwOWrNlfSbRwkDqmNF92nH57ZSUm5tqv4Qcz4
         Lc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a7HKcIF+i0T4+qY1S/nBDjlBN8LZbn3HajfMjAd6pgE=;
        b=CvDLjylZgUzt3ryIQVpATFsKvvB7Wjqc9zY1lI2EiHnvntDHh9xCvKBrKAfB5gJHvV
         T5dqn+UZhNzDWotc0+mTbM2I/QiUIMZtmgLJmV81JIaxjSgk22eWt+cHWTOtPUpcHOEU
         mqELH8WkVFe2N3zbXzeYKmVrQbWl3qRxtWR4a2V3eRDDTE9XQxaDt5xHzK5YjIVWjKmb
         qZivViC5+W7066FhwFY4lm3pSXBaRgTVe4Fg6+bseowNFRN0E73ILj0vvqQReoLv81m/
         AN/EGAJ4aVJ7kwQEVowWtJ4joc9wpAqE9OjOoHACsa/xTaaGTlpCQUYgv/LxfWuyQnqB
         AmzA==
X-Gm-Message-State: AOAM531jkRPIjgYF+WCH3tgpsNP4RE7itRudIeUgn5zZCHaMM/nhZQFE
        KzrkiYUdEi4j7FhPnTO+LdHcTpNJkIQTtw==
X-Google-Smtp-Source: ABdhPJxssTaeezzS7wEt6X3VKCQoaymqGu0EUoWOB6KOG9bWlT0i99Upi+R4v9esUZodWYU8smo6tDC44wMwrQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:2003:0:b0:663:e799:4ab5 with SMTP id
 g3-20020a252003000000b00663e7994ab5mr13476183ybg.403.1654813011398; Thu, 09
 Jun 2022 15:16:51 -0700 (PDT)
Date:   Thu, 9 Jun 2022 22:16:47 +0000
In-Reply-To: <YqJulJzLKVQ6xn88@carbon>
Message-Id: <20220609221647.lqxljj4wlb6mcuvr@google.com>
Mime-Version: 1.0
References: <CA+G9fYv7fESqpGoeKmHoJsst6wfRNMi2wQLGm+PsjbLDuDjdMQ@mail.gmail.com>
 <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com>
 <YqItYKEIvsw4Yzjx@carbon> <CALvZod6ojDd8Bc0VcyFEk-ZrdkFezvQPUvbGg3wyzae+NOp_4A@mail.gmail.com>
 <YqI0OYwNzxGo4XRo@carbon> <20220609191221.rv3lqbhipnvvzt67@google.com> <YqJulJzLKVQ6xn88@carbon>
Subject: Re: [next] arm64: boot failed - next-20220606
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Vasily Averin <vvs@openvz.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 03:05:08PM -0700, Roman Gushchin wrote:
> On Thu, Jun 09, 2022 at 07:12:21PM +0000, Shakeel Butt wrote:
> > On Thu, Jun 09, 2022 at 10:56:09AM -0700, Roman Gushchin wrote:
> > > On Thu, Jun 09, 2022 at 10:47:35AM -0700, Shakeel Butt wrote:
> > > > On Thu, Jun 9, 2022 at 10:27 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > >
> > > > [...]
> > > > > +struct mem_cgroup *mem_cgroup_from_obj(void *p)
> > > > > +{
> > > > > +       struct folio *folio;
> > > > > +
> > > > > +       if (mem_cgroup_disabled())
> > > > > +               return NULL;
> > > > > +
> > > > > +       if (unlikely(is_vmalloc_addr(p)))
> > > > > +               folio = page_folio(vmalloc_to_page(p));
> > > > 
> > > > Do we need to check for NULL from vmalloc_to_page(p)?
> > > 
> > > Idk, can it realistically return NULL after is_vmalloc_addr() returned true?
> > > I would be surprised, but maybe I'm missing something.
> > 
> > is_vmalloc_addr() is simply checking the range and some buggy caller can
> > provide an unmapped address within the range. Maybe VM_BUG_ON() should
> > be good enough (though no strong opinion either way).
> 
> No strong opinion here as well, but I think we don't have to be too defensive
> here. Actually we'll know anyway, unlikely a null pointer dereference will be
> unnoticed. And it's not different to calling mem_cgroup_from_obj() with some
> random invalid address now.
> 

Sounds good. You can add my ack when you send the official version of
the patch.
