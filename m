Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A2F58B839
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiHFUbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiHFUbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:31:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657B6631A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:31:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kb8so10367019ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=h6TeEL+zwRVR56oMOZRDcH12YoM3CR31tNWgWBUf5pA=;
        b=Z5Tr7NC6JgsKkE9XiNOKBzUM2nRxwEmA5LsMsrsD3MCosdCfDER+TMZteu3pHKDnRA
         b+oSRQwWMeplsoY1nMc/pYY5OoqRolBlVuMg4VWi0RHXg22MpgJ7hKeZoHyu9boeNa5H
         gyecJly17bbyHXvhbk3CXSBAhPTS+R1x2H4fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=h6TeEL+zwRVR56oMOZRDcH12YoM3CR31tNWgWBUf5pA=;
        b=sTA41dpOlROgruxbmpZulyyGH/8nR2AcMkqu3fAxYSzf0RMJhahvqZ3AnQAWg6g1rw
         d7eBdjrggYSBPW0FAkzHFiBXIRNasB0doo3ikYyhePHfQVxCnOHgradtDdlcuLCiZLpP
         nGzEz9ZbJQztsAsNsh3hZNSiUYqpcGoFXW9F2jc+m1gQb8kRzP0hDLVYM5cEhO8q3Af+
         lljn+6wuhgbUt1zxyps9hQ9eCtWDvzBHui8sLzdHVtnJRQh9MWJ1+5vFx46ZRcW282JJ
         /7tyBjl2z6V/ykE9NJUDBssbOZ8hz9csQtvwDwYf045RTzl5tz5JxmIhvs440yubog7O
         GVVw==
X-Gm-Message-State: ACgBeo2B+sNHat4c6CPBvwga7kc8wkTH+7O7TJZeGAs5fegKYJozqwLx
        cyoHsAj4A+PrWasTaKsu6irAzlIBUOaaA6K9
X-Google-Smtp-Source: AA6agR4w/oRUeIqBbOO5NEfy+qlqlCoSpvj+L0sT3EDcPMSILP1Bb6K+7Jpxd3lKjqTIyiYGodHhjQ==
X-Received: by 2002:a17:906:cc0c:b0:730:8bbb:69ac with SMTP id ml12-20020a170906cc0c00b007308bbb69acmr9160414ejb.392.1659817905670;
        Sat, 06 Aug 2022 13:31:45 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id b22-20020a1709064d5600b0073075122af2sm3028943ejv.225.2022.08.06.13.31.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 13:31:45 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id v3so6808681wrp.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 13:31:44 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr7357268wrw.281.1659817904667; Sat, 06
 Aug 2022 13:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <YuzlAT7RW1U36+ap@8bytes.org> <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>
In-Reply-To: <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Aug 2022 13:31:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSxEVW78nTumvz+ZYt2MZcmqe6S0nb_-efKYm636VuGA@mail.gmail.com>
Message-ID: <CAHk-=wiSxEVW78nTumvz+ZYt2MZcmqe6S0nb_-efKYm636VuGA@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v5.20
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 6, 2022 at 12:39 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If it is, it will be reverted as hopelessly optimistic.

Indeed. I should just have verified with the kernel command line, but
I started bisecting when it wasn't entirely obvious what was going on,
so I just finished it.

Commit 4bf7fda4dce2 ("iommu/dma: Add config for PCI SAC address
trick") is reverted in my tree. You can try again in a decade or so,
but at least on x86-64, that config option is basically a "stop modern
machines from working", and I don't want to have that even as an
option.

If somebody wants some debug output to figure out which device it is
that cares, send me a patch, but we're not trying this thing as-is
again.

                 Linus
