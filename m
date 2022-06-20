Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9A95511CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbiFTHub convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Jun 2022 03:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbiFTHu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:50:28 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00171101E9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:50:27 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id x75so7263668qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EtV5ELewzqfb5WlPCrybWjJM2V9SXL9Txpvpslzl7xY=;
        b=NX6TVgmEQ3QBdVHQXE3swAz86vUWVUBdY4+Ju+Jeyq8d0ppU0uK3Pk1XyIz6Uj/40o
         xMFyC6oo5UzLs1RnrYwx8nN7fkpnMpYYkHR8iDtmq5TCT6LfSPKyWV8jvuJ7zrU9khXS
         EKB9l3f7eN+YkrrLhQn2q+KNQQIl1scWu8XBBytAmsBgWj4R/NZXKNB69gBhVpnzPhkL
         KdgyngSH5i0SM8bKiFp+vxh9qVPPUkvhzCZmIqP/aitWKwl8hqH3xALrHRFZuc2VziZH
         GW9m1zNO+hUL0lxG5K9rGTrSijjMqGrv2KKpK2kv/0v9T0KoEq7f6Wp6prVup3X5mySc
         evHA==
X-Gm-Message-State: AJIora8NFI1JTuEs+vQ2yPOfGsRZJTWZbl06853XjrJyxMVatcHyCaP6
        r1CFcIYj/HMV6/RDh1HXtcpQZwdssqprYA==
X-Google-Smtp-Source: AGRyM1ss5ohNeltEFvMEbJ9ptgQN+9+u2bL3ixKz8sWI7bBiX4rOCu6DHFDq/J9tSbJXL1nr5wuxWQ==
X-Received: by 2002:a37:aa55:0:b0:6a6:b1e2:4af1 with SMTP id t82-20020a37aa55000000b006a6b1e24af1mr15594354qke.324.1655711426698;
        Mon, 20 Jun 2022 00:50:26 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b006a79d8c8198sm11272894qko.135.2022.06.20.00.50.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 00:50:25 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id l66so16077189ybl.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:50:25 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr24122408ybb.202.1655711425255; Mon, 20
 Jun 2022 00:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220619111115.6354-1-nikita.shubin@maquefel.me> <20220619111115.6354-2-nikita.shubin@maquefel.me>
In-Reply-To: <20220619111115.6354-2-nikita.shubin@maquefel.me>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Jun 2022 09:50:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUoa9H3Nw7ctAbueeVOdJEo_D25niS7E07HWwV2H4Z9Qg@mail.gmail.com>
Message-ID: <CAMuHMdUoa9H3Nw7ctAbueeVOdJEo_D25niS7E07HWwV2H4Z9Qg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] RISC-V: Create unique identification for SoC PMU
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        =?UTF-8?B?Sm/Do28gTcOhcmlvIERvbWluZ29z?= 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
        Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Nikita,

On Sun, Jun 19, 2022 at 1:11 PM Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
>
> Provide RISC-V SBI PMU id to distinguish different cores or SoCs via
> "devices/platform/riscv-pmu/id" sysfs entry.
>
> The identification is generated as string of marchid, mimpid, mvendorid
> in hex format separated by coma - "0x70032,0x70032,0x0".
>
> The CSRs are detailed in the RISC-V privileged spec [1].
> [1] https://github.com/riscv/riscv-isa-manual
>
> Inspired-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>

Thanks for your patch!

> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c

> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -693,6 +693,28 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>         return 0;
>  }
>
> +static ssize_t id_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       int len;
> +       struct riscv_pmu *pmu = container_of(dev_get_drvdata(dev), struct riscv_pmu, pmu);
> +
> +       len = sprintf(buf, "%s\n", pmu->pmuid);
> +       if (len <= 0)
> +               dev_err(dev, "invalid sprintf len: %d\n", len);

How can this fail?

Please use sysfs_emit() instead of sprintf(), and drop the error
message.

> +
> +       return len;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
