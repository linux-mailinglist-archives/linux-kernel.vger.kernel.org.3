Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08510540268
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344038AbiFGP34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344031AbiFGP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:29:53 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AF6F45DE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:29:52 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x187so4188324ybe.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhg0TrcGyN9sn9DMJKBktBWk6jm5kLlv+Pr2QQJaQCI=;
        b=ws02tqB78tZz/eX77MqIYJhbF7a9mJNOhjFkWejKDLj7s5GY66d+D0XuBT47c8p97Z
         ijPb9sPozjoHtmAROXkDAG0WgJf70MqOEfOlnIUNNaF0x0EHdf6HpJ6t40X4mfD4U5xH
         jSDaYzxImMPKT4mTCpjwlolaF0FSAbpDZIiECCECOhNB4OBWmgFjQs9/TxVweYdP3bvY
         CqbrMa3vpe9CJnrY/kn0Amn8nItCE3fZlnIu4soe9rV8wO9+kpKjyQd1/4U90m1LGnZJ
         +XGZQ8XR/YKVcZ/geFCZcJ5/rzQJ39R52PMLpC95pFq3wRAyyF8Ej4fSmcvkKv/1Z2si
         ScpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhg0TrcGyN9sn9DMJKBktBWk6jm5kLlv+Pr2QQJaQCI=;
        b=l60dmgSmNoN1lsE3lDzdkUkIMJ9yC93AYj+I3hMX6zYQXIRwpd3n9TB3SRAvFrvTAg
         JfG/qo3dlTK+59OAbPEpvaA14Yedli7xzEbisfp0oVbCc6o3p4LDiKURy/U4WQAqF/B7
         KrzvqTvANAjl6JO+mntGrrFN5EHbfWkFi3HSkS6hibcW+bQsmF9eHtlWA8wLmJJZ/fW7
         V2ZZ9xKEhPClWXFfjooJwDTdWbz3gJQQ1R5nZQ2KzYep8m+HRsNYB1teoO5dxWPvnwvj
         WUTpqzOByZ6GiPbJyDwOdL6FIc6/T+6W8B5yUDZ4iE/Xf/O9wv9L2IxS1nc91dMLfrPu
         FKcQ==
X-Gm-Message-State: AOAM531iTJUXxAMzoC0fNhUoJ5Pr2NRaGRXxCs8GSuShirLgJpS3A7FE
        T5vRN+nsNgvAW9tySoFlt4oirkBxPvW+dzH0Adf7tw==
X-Google-Smtp-Source: ABdhPJxh/2d/cRTxwvpTBGwOoLf3zdXsW0LageAD6nWbcZE/XZPH/H+urgez4bG9QPWtd3cBLpSlCKXwdRl0UX1FReA=
X-Received: by 2002:a25:d6d7:0:b0:663:efa3:3fd2 with SMTP id
 n206-20020a25d6d7000000b00663efa33fd2mr1306059ybg.480.1654615791476; Tue, 07
 Jun 2022 08:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv7fESqpGoeKmHoJsst6wfRNMi2wQLGm+PsjbLDuDjdMQ@mail.gmail.com>
 <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com>
 <20220607162504.7fd5a92a@canb.auug.org.au> <CALvZod5XBjw7MZfYSNv-UnE7pHMKTquUNomqyC5T05Qu_ef6Zw@mail.gmail.com>
 <CALvZod4DhM00LXsPty=cnYyv3Ci5YS5otasu_tr9o7ujQekKLw@mail.gmail.com>
 <CA+G9fYve1faH7AmpEa-p_ySb_WCgc4DdjqyS6fSdiJYsaEi=rA@mail.gmail.com> <CALvZod72bp9ejY+KghaUGkoXDrOMMbs_ofsopGib=MY4jzhRkg@mail.gmail.com>
In-Reply-To: <CALvZod72bp9ejY+KghaUGkoXDrOMMbs_ofsopGib=MY4jzhRkg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Jun 2022 20:59:37 +0530
Message-ID: <CA+G9fYu6mayYrrYK+0Rn1K7HOM6WbaOhnJSx-Wv6CaKBDpaT2g@mail.gmail.com>
Subject: Re: [next] arm64: boot failed - next-20220606
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vasily Averin <vvs@openvz.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 at 19:47, Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Jun 7, 2022 at 3:28 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > Hi Shakeel,
> >
> > > > > Can you test v5.19-rc1, please?  If that does not fail, then you could
> > > > > bisect between that and next-20220606 ...
> > > > >
> > > >
> > > > This is already reported at
> > > > https://lore.kernel.org/all/Yp4F6n2Ie32re7Ed@qian/ and I think we know
> > > > the underlying issue (which is calling virt_to_page() on a vmalloc
> > > > address).
> > >
> > > Sorry, I might be wrong. Just checked the stacktrace again and it
> > > seems like the failure is happening in early boot in this report.
> > > Though the error "Unable to handle kernel paging request at virtual
> > > address" is happening in the function mem_cgroup_from_obj().
> > >
> > > Naresh, can you repro the issue if you revert the patch "net: set
> > > proper memcg for net_init hooks allocations"?
> >
> > yes. You are right !
> > 19ee3818b7c6 ("net: set proper memcg for net_init hooks allocations")
> > After reverting this single commit I am able to boot arm64 successfully.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
>
> Can you please run script/faddr2line on "mem_cgroup_from_obj+0x2c/0x120"?

./scripts/faddr2line vmlinux  mem_cgroup_from_obj+0x2c/0x120
mem_cgroup_from_obj+0x2c/0x120:
mem_cgroup_from_obj at ??:?

Please find the following artifacts which are causing kernel crashes.

vmlinux: https://builds.tuxbuild.com/2ABl8X9kHAAU5MlL3E3xExHFrNy/vmlinux.xz
System.map: https://builds.tuxbuild.com/2ABl8X9kHAAU5MlL3E3xExHFrNy/System.map


- Naresh
