Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC1C573F06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiGMVcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbiGMVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:32:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E596237E5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:32:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id z23so5565043eju.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eiO9zeEKuffwwO1qFa2qtw+jOEgErpUu7Im0rIo+TAI=;
        b=HSdqrPacMhIs7Xx4ZvJuUh0uqgC/8AgZmNQWYOOs0tQjPr2+ACT1nhPCLzwsATVSE8
         EXmBrgxKI05sSa8T7/qexXyv5guVcihHfiCO7XsvDyyOLF/pOdbggNoSUChkPDiWHbHT
         MyhV2onY3BoW4S1IzBpt84ZnGOF1d5CHKpBeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eiO9zeEKuffwwO1qFa2qtw+jOEgErpUu7Im0rIo+TAI=;
        b=gp8GpZJ1idEZorLznNouYIYuZZ8/vu54QgllHHb7hGuXNz9VqdqAqkvL3qHQc23cxw
         XYKGYa/GtgIFQxoFjA5X0nRSfVsqNGXah0cP5AfkpFGHGyr8QeGAyVPHWdtLfnr2ABO+
         pdbUl2lJlTHjB+iF9SMr3TkZ7OhTohcpq0Ousz5xk53z0vLHxkLu6mm9iibdpds7SIjr
         8OB/+TJrsUPoB7o3f3rflI6ZD+4WPXx92bqcW9Bbr+Ey/1zSjzVi8ou5c4g5PH+Ck4Yb
         3k24vwr1kLXVjb2RbrjD/JjWg8/u9kNhd1RpaeoAvWAf9dSZIDV8LHTYyy1IHoO5+T6x
         Pl0g==
X-Gm-Message-State: AJIora93kgmNGIUM1P66Svyn75tN1R2eHd0lKEMLmHfl+OvCzrOG8FQS
        Nl2kAU+/WKhZJyaQtQtVBW+2lVJ/cTFpnrPtC0Y=
X-Google-Smtp-Source: AGRyM1vaH4W3v+/cn57a8eeilUL+1sI/k/mqDxFOmx9Yq3QFRauXsYGRSJtGbmgp7XBLUAAbISbt0A==
X-Received: by 2002:a17:907:2bc5:b0:72b:2e3f:3581 with SMTP id gv5-20020a1709072bc500b0072b2e3f3581mr5403482ejc.211.1657747949698;
        Wed, 13 Jul 2022 14:32:29 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906a20b00b0072b2378027csm5333780ejy.26.2022.07.13.14.32.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 14:32:27 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id z12so17288208wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:32:26 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr4964406wrb.442.1657747945994; Wed, 13
 Jul 2022 14:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net> <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
In-Reply-To: <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jul 2022 14:32:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
Message-ID: <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> If you want to apply Guenter's patch original patch:
> https://patchwork.freedesktop.org/patch/490184/
> That's fine with me.

Honestly, by this time I feel that it's too little, too late.

The ppc people apparently didn't care at all about the fact that this
driver didn't compile.

At least Michael Ellerman and Daniel Axtens were cc'd on that thread
with the proposed fix originally.

I don't see any replies from ppc people as to why it happened, even
though apparently a bog-standard "make allmodconfig" just doesn't
build.

I'd try it myself, since I do have a cross-build environment for some
earlier cross-build verification I did.

But since my upgrade to F36 it now uses gcc-12, and possibly due to
that I get hundreds of errors long before I get to any drm drivers:

  Cannot find symbol for section 19: .text.create_section_mapping.
  arch/powerpc/mm/mem.o: failed
  ...
  Cannot find symbol for section 19: .text.cpu_show_meltdown.
  drivers/base/cpu.o: failed
  Error: External symbol 'memset' referenced from prom_init.c

this cross environment used to work for me, but something changed (I
mention gcc-12, but honestly, that's based on nothing at all, except
for the few problems it caused on x86-64. It could be something
entirely unrelated, but it does look like some bad interaction with
-ffunction-sections).

So considering that the ppc people ignored this whole issue since the
merge window, I think it's entirely unreasonable to then apply a
ppc-specific patch for this at this time, when people literally asked
"why is this needed", and there was no reply from the powerpc side.

Does any of that sound like "we should support this driver on powerpc" to you?

                 Linus
