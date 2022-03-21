Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1F4E2CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348408AbiCUPyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348370AbiCUPyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:54:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F8B3D1CC;
        Mon, 21 Mar 2022 08:53:20 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id t33so21241472ybt.12;
        Mon, 21 Mar 2022 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTotdTusIeK32o/JzomDhnbhzpNSp4di8YaC3w/q0B8=;
        b=J8hEpEQ0iO1EMe+hQsp/lSlwSPJPF9TEUePxBNLZ8YrYvF34xcl7jpvmYq0vgbxffa
         6eeK2Hc+yXmCCG0CCc+AW03vhLmLfwjxI0Tpk05ANqUtkwgWDR5saRzxExTroweRDdLd
         qAHdiOldrVZzi2PnzvWSZtIieR8Jc05tBaZMW9KNwtN4JMg+622Suj4Sskr0dAjcZcKd
         enuucFhOkjOzZ6xcyMD0oXGTtp2J8u89zU2ypbAAm8oK+fsWd0OKxEspjPnjyWPNvXE/
         vOIiZ7w7JWQCqWN7t0lntpxkPMJQq9ObKAlAssJybhreBLN45zZvmydMfJ31wpG0qqHL
         6vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTotdTusIeK32o/JzomDhnbhzpNSp4di8YaC3w/q0B8=;
        b=wPhZFNCiVNVWWpnPFWMnHxoxWDmjkxzEw12MbplludyGuhaiLEaOoJSl4/Kl1KaZn5
         HGRWvSW3Q63LY+sJHEYBb9EakdMLBg5D0I7vurl5NgNs+yvHmvxsHarKIsObVCuanBXe
         j9OGN6UBn2NRtNbaJCgkdpzQTIQtsgswZ3A42sHp4qp2kjS75W63kZaBgDoGlkV/DFCB
         2E1iYptTSIo1p5wZ9a7CYsfeNqI/e68jui3Wx/zeHD3ABGEhQf8Joj5eC0oJ7EnQnNp8
         YN/x1JaHgNeJfd4AAmNGb91mSae9sRbyOTR7ItiiOhcg0xnWGLx5pGfHlJ7a84q3g2Q2
         NRGw==
X-Gm-Message-State: AOAM533imOpNk3ih3ywgD5YxPtSIuBt/3OndsodM7WFOb/hDeHnaqLNt
        +9yBLCV5beIDxXV2m9UONFw+l4FWhJCQOpMy9A8=
X-Google-Smtp-Source: ABdhPJx+Njv3z8UirguWrc2qa1JLVuf9bn3+0GyVzpaP/JwN9vI5ad2kyb1fbIR6I/iiO9AnFrthYoDCTlM/ZGe0+ks=
X-Received: by 2002:a25:d2c1:0:b0:633:c33e:8df2 with SMTP id
 j184-20020a25d2c1000000b00633c33e8df2mr13826276ybg.597.1647877999660; Mon, 21
 Mar 2022 08:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220319162006.13c60c1f@jic23-huawei> <20220319193459.2628876-1-ztong0001@gmail.com>
 <CAHp75Vfk+CQZoz+s5PuSTBb0Nb4KLB+yoNiTCJQ4NktxV1nycQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfk+CQZoz+s5PuSTBb0Nb4KLB+yoNiTCJQ4NktxV1nycQ@mail.gmail.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 21 Mar 2022 08:53:09 -0700
Message-ID: <CAA5qM4DE7Qehn2G3bOJfJ7wNfOBA01tzAFOuGZa_O4=6Ocb61g@mail.gmail.com>
Subject: Re: [PATCH v2] iio:imu:bmi160: disable regulator in error path
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 1:28 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Mar 20, 2022 at 8:44 AM Tong Zhang <ztong0001@gmail.com> wrote:
> >
> > Regulator should be disabled in error path as mentioned in _regulator_put().
> > Also disable accel if gyro cannot be enabled.
> >
> > [   16.233604] WARNING: CPU: 0 PID: 2177 at drivers/regulator/core.c:2257 _regulator_put
> > [   16.240453] Call Trace:
> > [   16.240572]  <TASK>
> > [   16.240676]  regulator_put+0x26/0x40
> > [   16.240853]  regulator_bulk_free+0x26/0x50
> > [   16.241050]  release_nodes+0x3f/0x70
> > [   16.241225]  devres_release_group+0x147/0x1c0
> > [   16.241441]  ? bmi160_core_probe+0x175/0x3a0 [bmi160_core]
>
> Haven't I given you a tag?
>
> --
> With Best Regards,
> Andy Shevchenko
Hi Any, Thank you for reviewing the patch. I appreciate it.
I thought I would need another tag since this patch is a v2.
Sorry for this back and forth. Have a great one.
Thanks,
- Tong
