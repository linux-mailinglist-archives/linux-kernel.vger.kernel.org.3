Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0285F5815DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiGZPCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbiGZPCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:02:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0005A24BDE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:02:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t22so16665716lfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3eaKEqKki8qki5Qb9UhtHWwntPVhLRvYCUBCxNj9YQ=;
        b=AiM8g9yWAbkS9+J/TBFSAt7ymESNu9mLo+7HhBQMUsThEYK5XHpx+Li+LJM3yz1HKc
         JEWiCI6JYY8P1UzuKwqy6FhoeRBbYMV5IBV57aBJ6s1S/pxW+IuhcnRQ0ewsmwvLmigi
         wq/HR0UD9L4fZMIIJbl/tKUG91ZvQlJPeawXaeB9D/wTxRFnqBKyZ08jDYofYXTNH9Gr
         YBtRGSZtHDEDDMO0i9e7w0VmZhW+J1aKcfiPTdnpQ4sjdpfmTVbGdHvRglcLnXGeGQZQ
         wwacrfyXpYa4iunxNiOx25bH/6uG9psehXkQU9nWZfqQQ0zB3N1fN7XPoeVt+yJw4QO3
         xepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3eaKEqKki8qki5Qb9UhtHWwntPVhLRvYCUBCxNj9YQ=;
        b=KOewEe3Fme86GdYXBMQ/ShCWND9VDMBNHh6jAuT48YrXGnwO3cLLvPh42FzGQgOz7O
         k8Z53ew6ff2f4FjpiD4G5PUzaTBw0P3CVVpxb3xHAIzvWCN3CtSl3IwXZWNXAYisefCd
         MvCUYnpu3Kb19Mkr3A4IGTkUuX2Ng/nXLmhlGLAOMOg0Cj0MfQz4D1CP5YAvUacplLl2
         Gr8w4HVp9nJN5j1RLIjzbpFvhPB9CsPo6r1zXOqFpGD/iWWAl+kvid7/LzZTl0oAKzUb
         Mk5ZMUOnOTToE9G8o1ZFkf74VeZ4BkEmVCC+CmGk8zNV5LUbidCWFkk2l/p/jVumBQz/
         Dx9w==
X-Gm-Message-State: AJIora9u1U2k8kcIJcdneboToHWCqS9WvvXleCZ3S/fgVZbso5IdnQP7
        2vDyEGnFNL8IMUsbLR0cO5cyLzEWM/XqdFQanNfz4A==
X-Google-Smtp-Source: AGRyM1uvj3g/wzQqWfb045Pdx41ie7mPz5l6Yuz5unfLdcYSECshn91W4YKovkSvKEvnNaqiqHxlbfPutsUrJA3Wc+8=
X-Received: by 2002:a05:6512:32c5:b0:48a:af79:601e with SMTP id
 f5-20020a05651232c500b0048aaf79601emr501700lfg.373.1658847721311; Tue, 26 Jul
 2022 08:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220726062842.18846-1-axe.yang@mediatek.com>
In-Reply-To: <20220726062842.18846-1-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jul 2022 17:01:25 +0200
Message-ID: <CAPDyKFpX32bprQMVXo-CYkfB__UL99JVZQ9EKfOWFqA7yh3Mbg@mail.gmail.com>
Subject: Re: [PATCH v14 0/3] mmc: mediatek: add support for SDIO async IRQ
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 08:28, Axe Yang <axe.yang@mediatek.com> wrote:
>
> Changes in v14:
> - add sdio_irq_claimed() judgement condition around msdc irq and pinctrl
>   control in suspend|resume callback

Version 14, applied for next, thanks!

FYI; Since we are relying on an updated behaviour in the
pm_runtime_force_suspend|resume() helpers, which are queued as a patch
via Rafael's tree, I am going to withhold my pull-request for a few
days longer than usual, until Linus has picked up Rafael's
pull-request, for v5.20-rc1.

Kind regards
Uffe


>
> Changes in v13:
> - remove state_dat1 related description in mtk-sd.yaml
> - move device_init_wakeup() to probe stage
> - remove redundancy SDC_CFG_SDIOIDE bit control in msdc_runtime_suspend()
> - replace SDC_CFG_SDIOIDE control with __msdc_enable_sdio_irq() function to
>   disable sdio irq when sdio_irq_claimed() return true in msdc_runtime_resume()
> - restore to use pm_runtime_force_resume|suspend(), to avoid go out directly
>   in force resume, bump up runtime PM usage counter before force suspend.
>
> Changes in v12:
> - assign NULL to pins_eint directly instead of using kfree()
>
> Changes in v11:
> - remove '_irq' suffix in interrupts-names property
> - fix yaml example build error
> - refactor msdc_enable_sdio_irq(), free pins_eint if async irq is not supported
>
> Changes in v10:
> - add sample node for SDIO host which support wakeup interrupt in yaml
> - skip MMC_PM_WAKE_SDIO_IRQ check before enable SDIO async interrupt
> - add MMC_PM_KEEP_POWER check before SDIO eint pinstate parsing
> - use dev_pm_set_dedicated_wake_irq_reverse() to correct irq control sequence
> - set dedicated irq in msdc_enable_sdio_irq() rather than msdc_drv_probe()
> - remove unnecessary wake irq control, rpm/dpm system shall manage that
> - move wake irq/msdc irq control back to system suspend phase, use rpm_suspend
>   and rpm_resume to ensure irq control sequence:
>      disable msdc irq -> enable wake irq -> disable wake irq -> enable msdc irq
> - simplify variables, check pins_eint to know whether wakeup settings are managed
>
> Changes in v9:
> - remove pinctrl "state_dat1"
>
> Changes in v8:
> - remove maxItems property under pinctrl-names property
>
> Changes in v7:
> - add device_init_wakeup() to register SDIO host as wakeup source
>
> Changes in v6:
> - abandon cap-sdio-async-irq flag, use wakeup-source flag instead
> - extend interrupts and pinctrls in mediatek mmc host controller DT documents
> - add mmc_card_enable_async_irq() to access enable_async_irq flag
> - simplify wakeup irq implementation with dedicate wake up irq related interface
>
> Changes in v5:
> - resort variables to reversed xmas tree order
> - restore old copyright year range and add current year back
>
> Changes in v4:
> - add MMC_CAP2_SDIO_ASYNC_IRQ judge before lookup eint pinctrl
> - replace spin_lock_irqsave() variant with spin_lock() in eint irq handler
>
> Changes in v3:
> - correct abbreviations with capital letters in commit message
> - replace copyright year with 2022 in mtk-sd.c
> - remove unnessary pointer casting
> - adjust variable order to reversed xmas tree
> - remove a redundant blank line
> - refine if statement, following standard pattern
>
> Changes in v2:
> - change flag name from 'cap-sdio-async-int' to 'cap-sdio-async-irq'
> - change corresponding macro names from xxx_INT to xxx_IRQ
> - resort new member in msdc_host structure
> - refine function msdc_request_dat1_eint_irq()
> - rename msdc_{suspend,resume} function names, add suffix '_noirq'
> - add MMC_CAP2_NO_SDIO judgement before parse eint related pin setting
>
> Axe Yang (3):
>   dt-bindings: mmc: mtk-sd: extend interrupts and pinctrls properties
>   mmc: core: Add support for SDIO wakeup interrupt
>   mmc: mediatek: add support for SDIO eint wakup IRQ
>
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 50 ++++++++++-
>  drivers/mmc/core/sdio.c                       | 14 +++
>  drivers/mmc/host/mtk-sd.c                     | 86 +++++++++++++++++--
>  include/linux/mmc/card.h                      |  8 +-
>  include/linux/mmc/sdio.h                      |  5 ++
>  5 files changed, 155 insertions(+), 8 deletions(-)
>
> --
> 2.25.1
>
>
