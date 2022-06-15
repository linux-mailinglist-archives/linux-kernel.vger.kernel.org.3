Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F07854C75E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbiFOLYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbiFOLYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:24:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C82F35A8A;
        Wed, 15 Jun 2022 04:24:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y19so22569080ejq.6;
        Wed, 15 Jun 2022 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcIsYZgQ3wffpFYTz+tQ8CrN5DLnWI36Wvm6m89SFMM=;
        b=YM/ce9swQN4g8I1u1q6a1V4OKZjzVZmw9/Lzud1xRfdDGqAdVXgVvb8RNZrmUO4noG
         YutZlktsKUDVlu9OIVwIrrYscHWPfUp8e7GxTQ6GoQS+zV0GRkyAYdXDZiQ86h0lC+tG
         MLe5gXSFrOe7QGcLz4MlrPq/jMziLb/hnYxE4IL/T4htOG1NUGgNwgk61FKx/voICzk6
         OlkRnHWtH/lzxWtkJj/37f5oG8xp2fnUxFC3dc4DvUKnNl33tfz3+kCGVhClCTFByh3a
         GUaCO7jjngZR/WU7ij2Bdio0jDCHm6lKO7ctDZMLXo9tXrf6n4bNspNRmarWuw+MguEE
         9+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcIsYZgQ3wffpFYTz+tQ8CrN5DLnWI36Wvm6m89SFMM=;
        b=zGIM39w4uSt6UIsSNq4wJPgGdyVJ2EJuUJjeo7CDKm/ehzRzagGGJMxbNF/TYKwkVh
         36xo3m2JYdjBEjY9/UqYJYsO8ubz3lMrHd5vkrqACcsG/mg4hTndH510PNHHIleZbccG
         BPTZGcKuFSg80arW9wQjgsnL/UTxACI6yuC7QI/x2u8oEfQElbLI8V/2uNqibXEs0KZl
         DRS2NN4xBDOD8RXSj1kyqmlF3nvYl87cHu+dj5CuZ3VoOil61JGRDTaxRm31zKvlExuX
         00SF+EnrOgLxKe6CP9v+Att9VA/SPtBGBhVtFGtyB7kE4FAZ5jPeSThVmJzpK+3LhCTM
         IlHA==
X-Gm-Message-State: AOAM531C0mGGe2Rdt8u7N6ODs3HV403ja+1X0pn4904oem30/kamO2Yy
        wk+OjpcFHWiD4IcKOFoqmfPx34TCWucqKTRPUXxAyqlx9YoxeQ==
X-Google-Smtp-Source: AGRyM1u167zDbthEdeQw+IsWWuX6OC89LCdIsKeXieMsDx1ZnUZgNc/sQmyoQ6YL9HT+xU9hiTBfz3Kxbr5V84JHmhw=
X-Received: by 2002:a17:907:9721:b0:70c:65e7:2aa5 with SMTP id
 jg33-20020a170907972100b0070c65e72aa5mr8385497ejc.132.1655292284501; Wed, 15
 Jun 2022 04:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com> <20220612090507.20648-3-stefan.seyfried@googlemail.com>
 <CAHp75Ve+vrfSu6pD+AKe-eCVA2pC5o520y4gVwLNg9Dtk0U5bw@mail.gmail.com>
In-Reply-To: <CAHp75Ve+vrfSu6pD+AKe-eCVA2pC5o520y4gVwLNg9Dtk0U5bw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 13:24:06 +0200
Message-ID: <CAHp75VdFPUHTeDBY5ukFgVqJJn7BbTHxrxKUGOLB6P1UX-utAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all hotkeys
To:     stefan.seyfried@googlemail.com
Cc:     Kenneth Chan <kenneth.t.chan@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>
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

On Wed, Jun 15, 2022 at 1:21 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Jun 12, 2022 at 3:54 PM <stefan.seyfried@googlemail.com> wrote:

> We usually add module options in very bad cases where it's very useful
> for debugging or when some devices require the opposite settings while
> can't be distinguished automatically. Here I do not see either of such
> cases. Hence, I would prefer to see a DMI based quirk as it's done a
> lot in the PDx86 drivers. Can you do that?

Looking into the code of the culprit patch, have you tried to add a
debug pr_info() and see what value is in the result? Perhaps you may
just sort out by correcting that.

-- 
With Best Regards,
Andy Shevchenko
