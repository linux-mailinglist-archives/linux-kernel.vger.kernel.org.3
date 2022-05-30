Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EEE537F29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 16:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbiE3Nui convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 May 2022 09:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiE3NpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:45:04 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9379CC87;
        Mon, 30 May 2022 06:32:35 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id p13so7501710ybm.1;
        Mon, 30 May 2022 06:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xd9RfFaDmCbItaIwECcKaBW1fHZpvHujUtdgLexOD2M=;
        b=aENUwU5lZOi/HRcPmqNAhHx0RUmIByAC2WxIXMsSv0ZY3b8wNy6b2bcRPsHf6BEoEa
         OLUpDOVwYjKL+Qp9CKJGZB27725k8wkMVxWUsr4WNmViq0mWNf7mAhXLQaDnjz/PJZkP
         D4KqKyaZTvhPBLTRDZ7YU8l8zgCH9tQDznKO2FoDZ5m0BXpq7K27ax+ufkddeZNqMsnO
         BCJcXH26UFj/K5AH8JqYlDBljhZBvl7JjLU21ZX0D8b+Hywz/Eq6mOOF7h6SkLkieego
         Wq77pE4jkyNdnKAUJl+EW+FBrST5ApmNah/jubfKxOCqZ6uu66OmxLNxXhA+JT0bV0vw
         x6zg==
X-Gm-Message-State: AOAM533OMGnX3QhdPJ/KhVLcekATFli0/uu3SWe4e8ScTFWT7Nv+5lqH
        Hq0SRJC9dRIJ6Fq6aURQWbePK4Ch8OkeGwyjJ6BffYBZ
X-Google-Smtp-Source: ABdhPJx+l6RuB/zgnTz+ogMUVFC8muKJGZlL9YIMB8Dpm8D9C7d5z53FJn9pU1rqGsyPwAm/dMIqNdjYIlHo07PJse8=
X-Received: by 2002:a25:8803:0:b0:64e:4a6a:afb9 with SMTP id
 c3-20020a258803000000b0064e4a6aafb9mr52927750ybl.482.1653917554456; Mon, 30
 May 2022 06:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220521032438.2504155-1-zhengbin13@huawei.com> <20220523065850.lhnpsc2u3dxzzwx7@vireshk-i7>
In-Reply-To: <20220523065850.lhnpsc2u3dxzzwx7@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 May 2022 15:32:23 +0200
Message-ID: <CAJZ5v0j_jzc1zN+qU6sZEASV_e-4Zuqzbq2k=WrJAuYM1XXhjg@mail.gmail.com>
Subject: Re: [PATCH -next] cpufreq: CPPC: Fix build error without CONFIG_ACPI_CPPC_CPUFREQ_FIE
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Zheng Bin <zhengbin13@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gaochao49@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 8:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 21-05-22, 11:24, Zheng Bin wrote:
> > If CONFIG_ACPI_CPPC_CPUFREQ_FIE is not set, building fails:
> >
> > drivers/cpufreq/cppc_cpufreq.c: In function ‘populate_efficiency_class’:
> > drivers/cpufreq/cppc_cpufreq.c:584:2: error: ‘cppc_cpufreq_driver’ undeclared (first use in this function); did you mean ‘cpufreq_driver’?
> >   cppc_cpufreq_driver.register_em = cppc_cpufreq_register_em;
> >   ^~~~~~~~~~~~~~~~~~~
> >   cpufreq_driver
> >
> > Make declare of cppc_cpufreq_driver out of CONFIG_ACPI_CPPC_CPUFREQ_FIE
> > to fix this.
> >
> > Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
> > Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!
