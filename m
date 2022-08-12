Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF6E591546
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbiHLSJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbiHLSJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA1B287D;
        Fri, 12 Aug 2022 11:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD03E6175D;
        Fri, 12 Aug 2022 18:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373CCC433D6;
        Fri, 12 Aug 2022 18:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660327775;
        bh=1eSXvEZnukSKTGZe7faWqcL1475O0ngKFVeI9su/VAw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hn4q3fEUQCsyyZm+CYqMeKikc96Jq4GliVXAfnoz6Ngc5A4ivDXPz8RX4xTigNaLy
         cfDLuqLz3Oh45DkhjDAYCjCSUZ2A8TaPGJu7IHt8nSBrP1iucbaz4z4FqOqbAU8vvc
         UustajZhWF4WcQtQrpxSyjFOz9YPHXioH6B/PLKly2+kR8i3OhGg8i480TQJ0bM/3y
         J5Dd87Va0YkfIM0DDWZC9PkfmEuImBIPfabqvSuAgCEAOnvYd8FQhwz7JzRqxcRlQP
         ixfdIIQ6hqAI+Hh++guZX3sQpQyasqrn3R4ZEFHFTCdGDqrXUS921ILWc1pXOVq1kI
         UWTLa7HNQeG9Q==
Received: by mail-vs1-f42.google.com with SMTP id v128so1550224vsb.10;
        Fri, 12 Aug 2022 11:09:35 -0700 (PDT)
X-Gm-Message-State: ACgBeo2gjFhq9jFjkdWVd/X9GkkfQlG6j3w4Hntff7aE55A+ETlMeOGo
        E539ZCxrcbsHy0jquQYsNi3wlx9dryV9xnz+Bw==
X-Google-Smtp-Source: AA6agR6gAxDp5EROI0oYJQFMogqYJdz05fwV9p3hLUFxkUsgWcC2eUmq8Ku3c8UFTfaktZD96oZzFoCpWskHhruVGz8=
X-Received: by 2002:a67:c08f:0:b0:38a:8c1c:45aa with SMTP id
 x15-20020a67c08f000000b0038a8c1c45aamr2280715vsi.85.1660327774173; Fri, 12
 Aug 2022 11:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220812174420.2706827-1-khilman@baylibre.com>
In-Reply-To: <20220812174420.2706827-1-khilman@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Aug 2022 12:09:22 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+DDPTYodAk-TKs61AUpdYhocWq+EoRGgVwgc1hz5gk0A@mail.gmail.com>
Message-ID: <CAL_Jsq+DDPTYodAk-TKs61AUpdYhocWq+EoRGgVwgc1hz5gk0A@mail.gmail.com>
Subject: Re: [PATCH] of: irq: Export of_msi_get_domain
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-omap@vger.kernel.org
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

On Fri, Aug 12, 2022 at 11:44 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> Export of_mis_get_domain to enable it for users from outside.

typo

>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Link: https://lore.kernel.org/r/20200122104723.16955-1-peter.ujfalusi@ti.com
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
> Peter tried to resurrect this in 2020 (c.f. Link tag in log) but it
> didn't work.  Here's one more attempt.  I need this enable building
> some TI DMA drivers as modules.

Then apply this with that enabling. I've already acked it (which keeps
it out of my queue, so drop that if you want to ensure I see it).

Rob
