Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB66B52635C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiEMN6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiEMN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:58:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0677A80F;
        Fri, 13 May 2022 06:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 964D9B82EA3;
        Fri, 13 May 2022 13:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50582C3411C;
        Fri, 13 May 2022 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652450305;
        bh=Q9uWqroQBrMhNpZ56AYK8kAafrfYjv57IuXu6ljniEI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kP2duuHmNgNTr23wQ3jJV4ACqVDoXiHvJmOEfYJk9MtvU/pYg6PV8inmVYuf8+isB
         OWLyTHjbPFfaEjxgSziDDit9HdhUJhWWhqRm5d2BsSBvMqiC2R4TR7y+3zJ8IjEiVG
         WabOU9VbStlIep5W1f5eZh/z3GxAg+zdPHTSMXcFiNzrXBt07iC7jTjCXO/cCBD7Tr
         g5R8OCcieFgvfgNaw51Kue7VWHPY/Pe4dB6Y+VHDOsIT1B/hzKlmblJJQzwBpfQCxE
         omgpjYXMk/DBrwTM8vOrcZbjODXWEn7uaBq22v744sg/OpLNPSfRbQREn5rP1vkkil
         WY3HkUDaQCkLg==
Received: by mail-pj1-f49.google.com with SMTP id x88so8174301pjj.1;
        Fri, 13 May 2022 06:58:25 -0700 (PDT)
X-Gm-Message-State: AOAM532qMBz0C3/3yCC9Eejuwc0gZc0NULASTSCFbveL0OENFOX0+gbP
        PyJrwqk/O1aKsOI44u7gcrbh24YKck375Ui3Iw==
X-Google-Smtp-Source: ABdhPJzeUi/T2UXmS90oIyfTH4jE3xb7KHEsioE2ug9DOGlHySktMSjKYgLM3J6rQcaXmuC2h+ylwtxmks7pbqNurVU=
X-Received: by 2002:a17:902:9345:b0:15f:186b:e478 with SMTP id
 g5-20020a170902934500b0015f186be478mr4834270plp.117.1652450304740; Fri, 13
 May 2022 06:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com>
In-Reply-To: <20220429220933.1350374-1-saravanak@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 May 2022 08:58:11 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+2A7mRVV24XW0YcP8GkFCK_Ri4KDcqvW4e0p3TkQMWVg@mail.gmail.com>
Message-ID: <CAL_Jsq+2A7mRVV24XW0YcP8GkFCK_Ri4KDcqvW4e0p3TkQMWVg@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver registration
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 5:09 PM Saravana Kannan <saravanak@google.com> wrote:
>
> The deferred probe timer that's used for this currently starts at
> late_initcall and runs for driver_deferred_probe_timeout seconds. The
> assumption being that all available drivers would be loaded and
> registered before the timer expires. This means, the
> driver_deferred_probe_timeout has to be pretty large for it to cover the
> worst case. But if we set the default value for it to cover the worst
> case, it would significantly slow down the average case. For this
> reason, the default value is set to 0.
>
> Also, with CONFIG_MODULES=y and the current default values of
> driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> drivers will cause their consumer devices to always defer their probes.
> This is because device links created by fw_devlink defer the probe even
> before the consumer driver's probe() is called.
>
> Instead of a fixed timeout, if we extend an unexpired deferred probe
> timer on every successful driver registration, with the expectation more
> modules would be loaded in the near future, then the default value of
> driver_deferred_probe_timeout only needs to be as long as the worst case
> time difference between two consecutive module loads.
>
> So let's implement that and set the default value to 10 seconds when
> CONFIG_MODULES=y.

We had to revert a non-zero timeout before (issue with NFS root IIRC).
Does fw_devlink=on somehow fix that?

Rob
