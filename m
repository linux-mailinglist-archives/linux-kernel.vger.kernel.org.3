Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC505377E5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiE3JoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbiE3JoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:44:19 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E64735264
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:44:18 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id v11so11007772qkf.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egbNs3dwXJ1sFgMjQwg5LbBY38e9kie/Y42u89S14kA=;
        b=0aY2loQEFAs4LZ5wGKhJoUZCUGTSwHyWvoVUhTsZAjCGOFCyyM05r3DkJwxUCT/TOH
         tMDa4kjnRFG1BoswYvRYmUtc80sFcbqF5pRHBQO59Zdz1AvcQMcmU03QboqZyGL1aAGm
         0Sp+g49UhnFdpNJDfuoOchvZEpfb/3x+tFqFVuXgdS3ho0h55lnMoOLBMcU7pmi7fZO1
         g//QH4IvXws0Up6g782MERYhCX95OuXUcqCsXKQNBRB68eT6UXcJKQuSlS0BeWZa0llY
         6njB2A+oyfavhz3AwEEH50Sxq68RhktuMCUT7tT1ouQrAGM9kbFpiYUvGkmh5+l2Iavo
         cHwA==
X-Gm-Message-State: AOAM532j6zn5NVVetg5wBXoz1pWuGmz3lV4hJ3mgKd9KQc+CKrH9d91+
        5pdUtReYXbyTo+h8Fm+MnarYnM0QmuC88w==
X-Google-Smtp-Source: ABdhPJzkNAid04NNy4SGPUEWG2aAo/dnB5gz69EFO9m5KL1pkNN58wC++V0nDbY15pq5sZT5K4HPNg==
X-Received: by 2002:a37:a344:0:b0:6a3:3dd3:4168 with SMTP id m65-20020a37a344000000b006a33dd34168mr34317061qke.445.1653903856365;
        Mon, 30 May 2022 02:44:16 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id b76-20020a37674f000000b0069fd35d2abcsm7221010qkc.112.2022.05.30.02.44.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 02:44:16 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-30c1b401711so40283527b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:44:15 -0700 (PDT)
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr654163ywa.47.1653903855496; Mon, 30 May
 2022 02:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220526034609.480766-1-saravanak@google.com>
In-Reply-To: <20220526034609.480766-1-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 May 2022 11:44:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU1jebFPW8FQadRzPL=dOS3xKPOuhpLjDxcdibKeeb=JA@mail.gmail.com>
Message-ID: <CAMuHMdU1jebFPW8FQadRzPL=dOS3xKPOuhpLjDxcdibKeeb=JA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Fix issues with deferred_probe_timeout being non-zero
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
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

Hi Saravana,

On Thu, May 26, 2022 at 10:22 AM Saravana Kannan <saravanak@google.com> wrote:
> Setting deferred_probe_timeout to a non-zero default used to cause
> issues with NFS rootfs. But the fix for that is causing other problem.
> So revert the fix and set the default deferred_probe_timeout back to
> zero.
>
> Most of the Cc list if from commit 35a672363ab3. Please let me know if
> you want to be removed from future patches related to
> deferred_probe_timeout and NFS rootfs issues.

Thanks for your series!

On Salvator-XS, Micrel KSZ9031 Gigabit PHY probe is no longer delayed
by 9s after applying this series.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
