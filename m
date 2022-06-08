Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4788542E91
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbiFHK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbiFHK70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:59:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B2CCE07;
        Wed,  8 Jun 2022 03:59:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c2so26518911edf.5;
        Wed, 08 Jun 2022 03:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AnvhaBz06tLqpDFkO1LB/SToNqbpQX12JMnOhAi2FvU=;
        b=lgCPy087oTNF+EaAjQOJV5gkK5p/TcltUniSAPU9McjdUoBL4X33kbh3fn+oU+8nSq
         40l348mJH+rDrLTZPJ67957NPpWGzLtgAgCx4MakMH9dhjiFJ9caT9Pc1sZof14L3amM
         Gs1ADAxsN79MKH3RzjG3lz7LU7y5+dlFgrJECQ60wabMd4ey8Bt4+tTyRWT3/0PqLMhd
         SaJJYlblQy7ZTmdJuoZJ3kn+pve9c7I7O+gPHtkcUMXtrpl4rfNhMpN01kVXBpkr98pL
         +G00qDUlQ97Acvjs24Z9gljLCyPDdO2KdzS76bzNmHOuurXz1lW0GhHGbIJW1UviTPVU
         t8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AnvhaBz06tLqpDFkO1LB/SToNqbpQX12JMnOhAi2FvU=;
        b=s3SerdIdv0wLvBSQLWAdaXah4a4EYBFtbb44NKy4nq8nRV/5ztY2bliJF/Zth6mcO7
         IQRe6IIvF4EFxU3eIOLjSo75emk9tj47JmsH03k+X8Qk3h9VWrz4tdT1eCJ6IcB4QkKP
         7mQh2uF/SmIpXyKujBFYzdjyQ5Jjui2eSb3mQP3rAWDsPrWJwk1By41mMhI5beYtppyt
         N1POP73a6R4gi8SDG+HOd8Kv3I8mI6wTEQOIkjHw1pXDERqA7w8gmDCubX9AYjuJCKzW
         BMGrvc2RYxeiBmo03++iqGnQbWas02cCwhS9NRjIut5LJoUsNle05lrg9InvRDZqWUtC
         0F5w==
X-Gm-Message-State: AOAM530dyIeNXu3I9EDHtv55vKSsK2Tu5sTNfys0MRR3NpM/gEYplcs2
        UN4fsbmvqaUD4BJXFuoCgArHmF2N0X5mj7ivrPU=
X-Google-Smtp-Source: ABdhPJx0olBIVchj62n/EaaylXg7BSrMrFBRzJGp609grDkLFRTfpBVB9YKsc6hv0CIkLZiGWNANY8F0vvI8ejiL9gw=
X-Received: by 2002:aa7:c396:0:b0:42d:8b86:a8dc with SMTP id
 k22-20020aa7c396000000b0042d8b86a8dcmr37816609edq.54.1654685963734; Wed, 08
 Jun 2022 03:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220608011712.2371-1-xiaohuizhang@ruc.edu.cn>
In-Reply-To: <20220608011712.2371-1-xiaohuizhang@ruc.edu.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Jun 2022 12:58:47 +0200
Message-ID: <CAHp75VenPBtQJ7SVMaOLqER_5HjUDUT-bdJawb3LK=n9oU+4Yg@mail.gmail.com>
Subject: Re: [PATCH 1/1] platform/x86/intel: Fix uninitialized entry in pmt_crashlog_probe
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
Cc:     "David E . Box" <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Jun 8, 2022 at 9:45 AM Xiaohui Zhang <xiaohuizhang@ruc.edu.cn> wrote:
>
> Similar to the handling of pmt_telem_probe in commit 2cdfa0c20d58
> ("platform/x86/intel: Fix 'rmmod pmt_telemetry' panic"), we thought
> a patch might be needed here as well.
>
> The probe function, pmt_crashlog_probe(), adds an entry for devices even if
> they have not been initialized.  This results in the array of initialized
> devices containing both initialized and uninitialized entries.  This
> causes a panic in the remove function, pmt_crashlog_remove() which expects
> the array to only contain initialized entries.
>
> Only use an entry when a device is initialized.

...

>         auxiliary_set_drvdata(auxdev, priv);
>
>         for (i = 0; i < intel_vsec_dev->num_resources; i++) {
> -               struct intel_pmt_entry *entry = &priv->entry[i].entry;
> +               struct intel_pmt_entry *entry = &priv->entry[priv->num_entries].entry;

This requires more explanation, what do the entry and the i mean in
the below call? Why is using the same entry over all resources fine?
num_entries as an index is pointing out of bounds, is that what was
really expected (first free entry?)?


>                 ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns, intel_vsec_dev, i);
>                 if (ret < 0)


-- 
With Best Regards,
Andy Shevchenko
