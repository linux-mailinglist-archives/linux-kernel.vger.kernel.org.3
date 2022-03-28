Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C624E97CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiC1NSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243074AbiC1NSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:18:01 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4306275D3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:16:20 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2e5757b57caso148310297b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5uuyZBXJwp7PyyisU+EIbTNtbVnmDYNzWqCp6rEsws=;
        b=zDVfDycjVsjtc8Wz/2yNBWq9/BgmdioNxQmtuqk12esMombnp3NIeZKjatpgrkguio
         9cwxgAbZvqI+rA/O0+PBotzJSY95vCE4+mTmJfv9RuebTcvU5bxKtk+jrQHABDaQpF7k
         IdHa4kcTNvMfyfR6vp5qMR2JNAALo/pryZ9SEenDdbTBWuCMGHpNpbvDUGnoPd5TTx4u
         RuDgiaWl6XpQTQiGFb+rjRUxr6QtXWsPbiIoo6YMjD3zPkaoeRD1KL+mX2wqzVI02ClX
         y3DSzpOW+tS+zb1kSSUOCvV5hTUR1p/rPmRfcdyrE2DhDsZDmyeepD+/Q18fYsg1XWBF
         eaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5uuyZBXJwp7PyyisU+EIbTNtbVnmDYNzWqCp6rEsws=;
        b=BtatS0D+ppoFmHx4KlkcaGOfYQcXn5Swg4/yM7z2QsLS0t6YNRcxH8PB/B351kWNBb
         5oIWlLONL1zjOkMB1BJQ1OBwzosJBn8AGKlBHqdFVzGj7VOzAS+hz16Ltfrfq161G8Y6
         mue4w542ARlfbtRBQ8KeZjOAYrnmnLf5A6unWGgfRu0jMU/xNrCV4xuGaFQIFN0zp8ls
         +LvlhLjEwZqylMfIF2LBtctwsXu2ohXeh64dMN7tIIFicFamYs0rKrSylAbLyeBVpI0H
         EVU1FEjDAps94xNCdhoUhVEVpZH9PGdC9ZOUHfNpxClJIoiYw/fInmf44P9Cl7CIJNVj
         8X4g==
X-Gm-Message-State: AOAM532WiFszE17Lo3bwqy18Qml/XvZjW8XiJaEnVRe5/hWBQNU3EBXC
        48dHWUfyEkOhXFzc9xDK0zaNnfgR+TGj24lnCY36k/W0Flw=
X-Google-Smtp-Source: ABdhPJxvrqtRZdCJx8IMb57QwLhs/eGoSivn6ijKcrdp4HASIgvKYZqWzG0jXBPQP0WpR0KIcwolNqKj4N73PTfigmM=
X-Received: by 2002:a81:b50d:0:b0:2e5:b653:7e97 with SMTP id
 t13-20020a81b50d000000b002e5b6537e97mr25986896ywh.140.1648473379829; Mon, 28
 Mar 2022 06:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Mar 2022 15:16:08 +0200
Message-ID: <CACRpkdbUWE8knM=9uUVLTX792Y8_J1aPj4KtFh=yJxaKi+ZqRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] powerpc/83xx/mpc8349emitx: Get rid of of_node assignment
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 6:43 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Let GPIO library to assign of_node from the parent device.
> This allows to move GPIO library and drivers to use fwnode
> APIs instead of being stuck with OF-only interfaces.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

That's a nice patch.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
