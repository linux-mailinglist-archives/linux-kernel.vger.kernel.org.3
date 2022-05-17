Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1715452AC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352865AbiEQTlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352853AbiEQTlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:41:04 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDDE1D317;
        Tue, 17 May 2022 12:41:03 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ef5380669cso1810917b3.9;
        Tue, 17 May 2022 12:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jA+ZZ535mW9lkveex/k/BNBtXLLURKxBnX7kfn3Gewg=;
        b=oF1guhNrPBsF9TeKexacQWWMM7lgyzQXxgX/Ehysj0hdK0X2jMp88v7PjSKQYsZGAp
         DhTBZpMnGUKp8XpWYeLjiHk8uIfhPQ5Aguu0CbBJlT9svNOl5pSQuHpKAGdyNC9EKkXE
         HbYB2isKJkdyqAwZtJj+YCSnk1OLMOrBqFHF1eJO6g9pOx8s83SL7AfZsRclygCdknL6
         7w8+gFvGD3V7ExlWD4AjLzDsdXttMoa+uAHgGNrhVq2YC7l8/WNSmQBnUhozJ7ttSdYw
         dxAJXVBvpybOtd3eH4+i4vcMsaiKL+9HoMK2A5PbaLPTx4fEnygUiUSWjdpNGYERg5tO
         Zv3Q==
X-Gm-Message-State: AOAM533rmzBem1ghiK6vBvUfFUwUzh5Z8RpbGYrQ2iExHK3PG3xXlEz1
        r4j2VeeA90YC5vxj6e2rfEUWrYH8ZFaqLRp6vKI=
X-Google-Smtp-Source: ABdhPJzXrvE9IpiiD2ZV48IvdHIaUJPb9W/rDCWV4FPmB+OWzA3lnnkB24Bh7kEgg7Y7If3dUf60H1mV3gFva2yD2vE=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr26970283ywb.326.1652816462836; Tue, 17
 May 2022 12:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220516030251.42323-1-schspa@gmail.com> <CAKohpo==gvvyd2HxL3sLTqXS-VbFeprkgAdSAjU3mnbq4Qn-Jg@mail.gmail.com>
In-Reply-To: <CAKohpo==gvvyd2HxL3sLTqXS-VbFeprkgAdSAjU3mnbq4Qn-Jg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 21:40:51 +0200
Message-ID: <CAJZ5v0gzYQJ+j2M64ct68ghOCmffdoeakh=FPwRv2DTe1mwbFQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] cpufreq: Abort show/store for half initialized policy
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Schspa Shi <schspa@gmail.com>
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

On Mon, May 16, 2022 at 12:25 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On Mon, 16 May 2022 at 04:03, Schspa Shi <schspa@gmail.com> wrote:
> >
> > If policy initialization fails after the sysfs files are created,
> > there is a possibility that we may end up running show()/store()
> > callbacks for half initialized policies, which may have unpredictable
> > outcomes.
> >
> > Abort show/store in such a case by making sure the policy is active.
> > Also inactivate the policy on such failures.
> >
> > Signed-off-by: Schspa Shi <schspa@gmail.com>
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied along with the [2/2], with some adjustments in the subject and
changelog, as 5.19 material.

Thanks!
