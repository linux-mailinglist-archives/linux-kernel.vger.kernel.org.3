Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94BC53E201
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiFFHAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiFFG7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 429B21163
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 23:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654498792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gOtzSuAWugs2jYxku/paVOt/7+PibxrDQ20HWjPBIW0=;
        b=WnV4AnJaCPf3NSm66W44mYCiJTp7qOqkS6qmKj5prxl0okt2sBzglihBxlhCnn3gN1nN0Z
        mP2E0bqsFZBfXotbEUTJ/uPEXqLmtpOCj29I6XmJnPrmxIEZy51QWmdPSGWZqnb6hNbEpl
        9Age7RGUzP0tvSs3206NbFze4aqlPgQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-tOiRYh6UPtWBJEPaIbYfFA-1; Mon, 06 Jun 2022 02:59:50 -0400
X-MC-Unique: tOiRYh6UPtWBJEPaIbYfFA-1
Received: by mail-wr1-f69.google.com with SMTP id y2-20020adff142000000b0021581245fa1so1329914wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 23:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gOtzSuAWugs2jYxku/paVOt/7+PibxrDQ20HWjPBIW0=;
        b=VeJrtdBeOc7HoAXJLWRfcOO5GQYHmGTAuLRONY34U24BYggSOvZIBhYf0rUOmnBtiI
         bFa7Pwfgp5vrDGK/8C4SabNzGrEna7mi+eLUZOjUH4RNsCSwsxK3xkSoMOf08/blgovt
         thLbsVZOUesdJfKvvaeQz2c4vRZFMuCXEj2a0RE59Rm7vzbHZhwI9/L6DILGo7DW27y/
         dpTTZy66+eUN81CTAQpz+BetA7Bxe7azpTxftGD06POOyf9Ge3r+HeE4sCS2qFMJvFqr
         WWpHsvO0JCUwfw5pZmK9nEfx4/MtCx2GE4ORX2KOxZdktCfUbZisjuDrUQe68KgKEncf
         PZgQ==
X-Gm-Message-State: AOAM530ioFrDtROEshSN4KuJsq12Nkj5a8wkFgnvU2y8XCYarSkBxJ/6
        MAWTZ4MvXCI4EJP7Jhu08/U3BmHz0VvEIYWXUNcgMUodGBZuLyxU1/1J0P3VIkcTte4M1sGP3d0
        Td8F2v1+oObFWkuu1EZ401hFM
X-Received: by 2002:a05:6000:1250:b0:210:3385:1c8b with SMTP id j16-20020a056000125000b0021033851c8bmr20109073wrx.623.1654498789650;
        Sun, 05 Jun 2022 23:59:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHeKxOBS3tR5Dn9HZuuYl4ChO3EJmHj+F54erbEVQCK6MD/uO0HjL4EbwLRBh3LwM4erMheQ==
X-Received: by 2002:a05:6000:1250:b0:210:3385:1c8b with SMTP id j16-20020a056000125000b0021033851c8bmr20109059wrx.623.1654498789452;
        Sun, 05 Jun 2022 23:59:49 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfea43000000b0020d02262664sm14195815wrn.25.2022.06.05.23.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 23:59:48 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] clocksource: hyper-v: unexport __init-annotated
 hv_init_clocksource()
In-Reply-To: <20220606050238.4162200-1-masahiroy@kernel.org>
References: <20220606050238.4162200-1-masahiroy@kernel.org>
Date:   Mon, 06 Jun 2022 08:59:48 +0200
Message-ID: <87bkv6nuor.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> EXPORT_SYMBOL and __init is a bad combination because the .init.text
> section is freed up after the initialization. Hence, modules cannot
> use symbols annotated __init. The access to a freed symbol may end up
> with kernel panic.
>
> modpost used to detect it, but it has been broken for a decade.
>
> Recently, I fixed modpost so it started to warn it again, then this
> showed up in linux-next builds.
>
> There are two ways to fix it:
>
>   - Remove __init
>   - Remove EXPORT_SYMBOL
>
> I chose the latter for this case because the only in-tree call-site,
> arch/x86/kernel/cpu/mshyperv.c is never compiled as modular.
> (CONFIG_HYPERVISOR_GUEST is boolean)
>
> Fixes: dd2cb348613b ("clocksource/drivers: Continue making Hyper-V clocksource ISA agnostic")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  drivers/clocksource/hyperv_timer.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ff188ab68496..bb47610bbd1c 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -565,4 +565,3 @@ void __init hv_init_clocksource(void)
>  	hv_sched_clock_offset = hv_read_reference_counter();
>  	hv_setup_sched_clock(read_hv_sched_clock_msr);
>  }
> -EXPORT_SYMBOL_GPL(hv_init_clocksource);

hv_init_clocksource() is not called from modules indeed, 

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

