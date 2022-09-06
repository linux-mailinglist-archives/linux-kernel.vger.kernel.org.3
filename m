Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF17E5AF69E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiIFVIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIFVIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:08:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238B3AED92;
        Tue,  6 Sep 2022 14:08:30 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 202so14022898ybe.13;
        Tue, 06 Sep 2022 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cu3bbUPtP+jBi/cFz3i2WPazSy2LXGAfisSIYw2jC8c=;
        b=mFb9NxsTnWbsNwhgwiyfL7sHR8iVAJ6uDpo8W6AgzT6kFow0ZBsOLppnubKSNRreyB
         bjT9LhDIRDd0WmVKhGEMt+Oa/JOyLELd1UOxcvBWUp6d3DYyfAGvhpRmp3c4XEF0FyT1
         Xw25mUyNkFTGFJ8RQypdvf99t87MfU9hM2JT9fDdXavVwO1cfKqorVnov6vzKPAlqW3d
         yzH0/TTjfuXMmti3q5f6/Yvyt2npm5mIV6VFl5cZdgrGEX0GU5KvgmdS4aPOu7oSh+i8
         hwwRCnsoWF9MImgxUYOPI51k23oX/r9fp6cZ3QlUqEhmkqgDxoUHsqsgChWwIf0RZp48
         /lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cu3bbUPtP+jBi/cFz3i2WPazSy2LXGAfisSIYw2jC8c=;
        b=k1Pba4QohjRNOSGCCfDyIgMLa1nryDXHBNm1+VHV6wtQKIBKRnGz1vd1c54qKQEqLy
         6hyLs6QPcht7hOIRZrdOnufe4R3Rp3GCRLlppqW44gSe16wtmJ94BYpuH1qvgNXt45RQ
         kEq/WWXpPINcJ3upmi2aFAjUcr1KG8suLOfjHRGXPOb5YeMumfjbwq47TFl5yiATg4r3
         yIXnnS00K4d5dxJUyVHvZdmtrDLewFDGY8zUkoQubYR0E98ZYT+yszVfGSfASIxKF4iL
         fWy7jdf8daBziIyAtRJVwcc3UufuUkZ7J+zcHaeSM3R7c1ifepne45/MJf4uqEkMDsnw
         4mew==
X-Gm-Message-State: ACgBeo0KAf/MAn5k9+8NFlwzEpGJCCkq0jjIm0teWDWhcrG71qRHA7YK
        zLo1wnCkfFV/eLlbF9HrkRT8CPJjCv9k2U2REu8=
X-Google-Smtp-Source: AA6agR7mZaY1q5EDdX6KV7aSfI3VU5ox6ayZ2YEGO043m8/HfxeoJ6phjyUBRgdQu2FzO+VAoCNpJ4zxXmSvEFPWLAM=
X-Received: by 2002:a25:3b46:0:b0:69c:a60e:2e57 with SMTP id
 i67-20020a253b46000000b0069ca60e2e57mr429668yba.364.1662498509364; Tue, 06
 Sep 2022 14:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <YxdX2l88PSFGe1r4@debian> <YxeAOgEoUffHudv/@kroah.com>
In-Reply-To: <YxeAOgEoUffHudv/@kroah.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 6 Sep 2022 22:07:53 +0100
Message-ID: <CADVatmNSGSZZNXF7k7YmMqfcoOAiM6JhEfksjoVqoBOLUXfbPQ@mail.gmail.com>
Subject: Re: build failure of next-20220906 due to 4ec7ac90ff39 ("misc:
 microchip: pci1xxxx: Add power management functions - suspend & resume handlers.")
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
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

Hi Greg,

On Tue, Sep 6, 2022 at 6:15 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 06, 2022 at 03:23:22PM +0100, Sudip Mukherjee (Codethink) wrote:
> > Hi All,
> >
> > The builds of riscv, s390, csky, alpha and loongarch allmodconfig have
> > failed to build next-20220906 with the error:
> >
> >
> > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error: 'pci1xxxx_gpio_resume' defined but not used [-Werror=unused-function]
> >   311 | static int pci1xxxx_gpio_resume(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~
> > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error: 'pci1xxxx_gpio_suspend' defined but not used [-Werror=unused-function]
> >   295 | static int pci1xxxx_gpio_suspend(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~
> >
> >
> > git bisect pointed to 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.").
> >
> > I will be happy to test any patch or provide any extra log if needed.
>
> Hopefully this commit will fix this:
>         https://lore.kernel.org/r/20220906124951.696776-1-kumaravel.thiagarajan@microchip.com

No, it didn't.  :(

Looking at other drivers which uses SIMPLE_DEV_PM_OPS, I think
pci1xxxx_gpio_suspend() and pci1xxxx_gpio_resume() needs to be under
"#ifdef CONFIG_PM_SLEEP".


-- 
Regards
Sudip
