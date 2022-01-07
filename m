Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FC3487DE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 21:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiAGU7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 15:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAGU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 15:59:18 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE89DC061574;
        Fri,  7 Jan 2022 12:59:17 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u25so26738949edf.1;
        Fri, 07 Jan 2022 12:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rj4r6CMIhOurl71mbmpns9s+/GLT2l4z4KhNgTh1A9E=;
        b=PUGVVPHPIJeKZjCox9JgFlyMlUZiJi45DVm2R2L0eLOHL+uL7VD9Z67lLbRFYPE9iM
         RNa64jlUO9FCgJGSm7xDge0I4oa5qcG9qnrypAq/m8f39mjG8BF2x1glDwQhBMQROV1I
         TDUpEJRhCJlMiDYv6Dz98IXPJltSUy9ogmf8Y9TTOxTkNwRPzdwH0UGqe1llkOmmUm1s
         uFOTA88A3ZkQhFgQbfNptGuyCllzKjcvuWYOZPLC+yqtlYrqPddawMaIsqn5XY7t+GWt
         KGtV16sFbxGf2u8rbe/6Iv2J7OKk6mRzd3cq+VxYcIqLNON6bENzfulUQ1dpoShdCwkS
         sk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rj4r6CMIhOurl71mbmpns9s+/GLT2l4z4KhNgTh1A9E=;
        b=MTX5rpBFLFsz+7wAEIzat2e4UzBZKuEOXdnKGNdUB0zBO1zYtQutD9i/0AnOMLn09W
         u6XhOZrkhXeesasUX9d9C/hbeOZvMzigIyhFwcAt1ITfSrHDB9wU3F8Kx8cOn1xmAKRn
         8dR1rbiUrKzaPVzd+U+oT4CoOPcKxMeW0gvNfgDTiw2fMj9u2h+pteqfXpmuZR1HU0Ij
         f0HVrGM5hOT/pu2O6qrMi4k8W6Zsz+rme6C97yag2zZ+ibk/eGCveT4MySRdRhP6BEKv
         ChA2gjjHm6PtrJvJnIQwIKse2Oa7ZU4cwZu9VC0Z1Q+324+tRm2sIL0x+rCE8b+lnI8y
         v4SQ==
X-Gm-Message-State: AOAM5321L1dw7FIYTJfokgp0RcammrwyXo3be9yBNVx58lzZcr+KIsmS
        mwA2e4bCLto03n/Ze1rBPn+1H+gNor3CEEgMW/OjhtexaUA=
X-Google-Smtp-Source: ABdhPJxoXuckBMfWUW0vbbBRZK4m2UTve8Y25D7Nk3+Fv7D5ieD47ro52n2ASDPU0+AQhDurEFM9P0EOOWyd/GMVDTA=
X-Received: by 2002:a17:907:968c:: with SMTP id hd12mr3431352ejc.639.1641589156444;
 Fri, 07 Jan 2022 12:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20220107170616.2041589-1-gsomlo@gmail.com> <20220107170616.2041589-4-gsomlo@gmail.com>
 <YdhzmE8eBsvkRCBn@errol.ini.cmu.edu> <CAHp75Ve5T-yNV-BJww_kN+6y8P9FyHodKfZ4nfi2POynp6BPVg@mail.gmail.com>
In-Reply-To: <CAHp75Ve5T-yNV-BJww_kN+6y8P9FyHodKfZ4nfi2POynp6BPVg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Jan 2022 22:58:40 +0200
Message-ID: <CAHp75VdnvdurRbL+aqTDhmQkHJU-mhNWFKRdVqPCh9mMV2h+6g@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 10:50 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jan 7, 2022 at 7:08 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > On Fri, Jan 07, 2022 at 12:06:16PM -0500, Gabriel Somlo wrote:

...

> > Any more ordering or devm vs. non-devm mixing violations here? If so,
> > can you please link me to an example or some docs where I ould figure
> > out what it is I'm still doing wrong?
>
> Device managed resources are attached to the instance of the device
> object and removed in the order they have been attached to, but with
> the caveat that they have no clue about non-managed calls in between.
> Now you may figure out what happens. Ex.:
>
> probe()
>   A
>   devm_B
>   C
>   devm_D
>
> remove()
>   un_C
>   un_A
>
> WRONG!

For the sake of comprehensivity of the examples the right one(s) depicted below:

->probe()

1)
  devm_A
  devm_B
  C
  D

2)
  A
  B
  C
  D

3)
  devm_A
  devm_B
  devm_C
  devm_D

Hint:
`git log --no-merges --grep devm_add_action_or_reset`


-- 
With Best Regards,
Andy Shevchenko
