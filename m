Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4406F4EEDD2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346174AbiDANJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiDANI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:08:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121E7268C26;
        Fri,  1 Apr 2022 06:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3E33B824D3;
        Fri,  1 Apr 2022 13:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B93C3410F;
        Fri,  1 Apr 2022 13:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648818427;
        bh=NxIz7F5Ix7ujuYeTmjItcADAGgHavHcVWcqI1LZ7iuI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pHoul7yeo4S4WCdbiySBxEeao4t68t55oiq+0nBbRWnetlNqSCqMU4NxltjowIueN
         bEsRsmnLsKoEcWCnsymRsYtudgJ7Pva9ogQhN18jwJzW35e1W3F52eurA2ae1Py+Nl
         bWCWRy2XXIZXhmXPvGRf3kZpLkM5/UKl1UYI2+nrzfmBw0tH+klQJmW8tqKDSicNar
         ZTd4O9cEu6iL9/dd80DAqOaDU1iTHc/dIMAOF6k8Hdz7ym4MEd6aT4JLziOoV5UFkk
         L0zvAOEIDU156W2BXGjpMYWYfxq2W5t4bEc8HSYieJYpll8a1Bfj+Kll0UtOOmAR5y
         FKm7vKSc2+E2g==
Received: by mail-io1-f50.google.com with SMTP id z7so3108728iom.1;
        Fri, 01 Apr 2022 06:07:07 -0700 (PDT)
X-Gm-Message-State: AOAM530wmEjJCUuCSj3Mtm6Q9uvLalVseS6VUGQyzeVIgdzNaZVjdJLg
        pnuoCkjUgZjlhlezHZSvnrrK0AYNTihydQVWjg==
X-Google-Smtp-Source: ABdhPJxGvqOqt7HA/fYx1QugaDiqtYmr9VZyOQdG68K+8h5LGz2aCIQ064fcbTMpqrNVR/4RerP6xeeUIi8vABzQHzQ=
X-Received: by 2002:a02:1107:0:b0:321:78dc:890d with SMTP id
 7-20020a021107000000b0032178dc890dmr5872819jaf.236.1648818426623; Fri, 01 Apr
 2022 06:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YkYWzf7J17AfXgLl@robh.at.kernel.org> <CA+V-a8sia2YgWmry+SxJu3asD47PSD6UnND33599ygTBymPy_g@mail.gmail.com>
In-Reply-To: <CA+V-a8sia2YgWmry+SxJu3asD47PSD6UnND33599ygTBymPy_g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 1 Apr 2022 08:06:55 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+P6GTXcwqf8EL+vBdJWSDM+Bxxm5MPEyJPF8A3ZWaQ3A@mail.gmail.com>
Message-ID: <CAL_Jsq+P6GTXcwqf8EL+vBdJWSDM+Bxxm5MPEyJPF8A3ZWaQ3A@mail.gmail.com>
Subject: Re: [RFC PATCH] of/platform: Drop static setup of IRQ resource from
 DT core
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 2:42 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Rob,
>
> On Thu, Mar 31, 2022 at 10:02 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Mar 16, 2022 at 08:06:33PM +0000, Lad Prabhakar wrote:
> > > Now that all the DT drivers have switched to platform_get_irq() we can now
> > > safely drop the static setup of IRQ resource from DT core code.
> > >
> > > With the above change hierarchical setup of irq domains is no longer
> > > bypassed and thus allowing hierarchical interrupt domains to describe
> > > interrupts using "interrupts" DT property.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > Hi All,
> > >
> > > Sending this as RFC as couple of more drivers need to hit -rc yet with
> > > the platform_get_irq() change while that is in progress I wanted to get
> > > some feedback on this patch.
> >
> > I just applied this on top of current master and pushed to my
> > for-kernelci branch. It should show up in kernelCI in a bit. I did this
> > before all the fixes too and there were definitely a couple of test
> > regressions.
> >
> Any chance you can share the regressions or maybe the CI script so
> that I can reproduce it locally.

It will show up here[1] as 'robh', but it still hasn't built yet which
is strange.

Rob

[1] https://linux.kernelci.org/job/
