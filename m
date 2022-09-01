Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8935A9D83
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiIAQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiIAQwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:52:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9478C98A68
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:52:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy31so35567161ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8gpXKd/rcgdoy4YCxJm6j2dyIOOgr77cRPkJmoI6lKk=;
        b=z4NRuNJ+v1eoMoPIr5/iSOQDh/P+oZt6qu1ks9yWm6E3+hBVQqx5UHkIBVu6wNKuek
         6fLQR7JWEhw0kIkMKd/PMB41NW875rLDJUMs2XD3vkxPEHxFI+5OzY9Ppkfma4UfJbH6
         oUA1kG9c0AtV4cBS10sumKQJyB/2MQpbC0kHCh8ulo34jzIXKJ2GBhR5NbW4ZqkThChp
         pimSpi2vdasOPf7PSkhSuhR7RFNbdWFRSvM8m3/10v8cfxtWkFL3Mk9DHk39GVUHCkhH
         3wrE+PEC6Gwpj/4DwZz6DGskxwHH2o39PVfejubJyJJBZnqDQd1VjaZV0d6/uM9K+mki
         xcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8gpXKd/rcgdoy4YCxJm6j2dyIOOgr77cRPkJmoI6lKk=;
        b=f+fECZXRuiBzsrFfuSO9NhGTPek1uzhEnAiPGXwIQ5TEvc9erdiNivFWbyixzhVKM6
         iwy189bISJwNNt0hKDfkLKupcatD129ovm8O4hS3wwMbmB4Gj/axd68V3WJM3B4n8jmw
         WOORFToFuYYycyleOjPVNj8Kxg/2gDuxoweew1ymjXwx+jEAtZQRLzSHyAnvkUPk+vno
         2kWKf4m6wCgplQnsFnufnqiLoGed/zc7dNmDsD12VpuC1W5H6AILrzdkFeBHg5sKTg4I
         1rZzxGzTq8p77mt7E0Dh1Lb03bfXkGw87ovAyvgDCqrTjSzhcCXpTDukxJqJ9Fd6H5iF
         Tb7Q==
X-Gm-Message-State: ACgBeo302F34N4uGTJn+ufKm0+r4KlU0dvvLcqNS/TxXuNjQJisq6HY0
        l60ziI6+AOmY2vowSrto1yGcebCP1aXaf0BMsg4Zgg==
X-Google-Smtp-Source: AA6agR7BaAKxuDmGMYFoHkUOkW7cfwd7OH3CSzZWQSt0QnzsL8LHIoezQdLYgtxLWazJMZxRf8869xBolCRGGdZifj8=
X-Received: by 2002:a17:907:760b:b0:73d:b5bc:feb6 with SMTP id
 jx11-20020a170907760b00b0073db5bcfeb6mr24486780ejc.407.1662051141088; Thu, 01
 Sep 2022 09:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220818132231.28240-1-hejunhao3@huawei.com> <ab129d55-9b4f-1685-d102-fd963ed447bc@huawei.com>
In-Reply-To: <ab129d55-9b4f-1685-d102-fd963ed447bc@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 1 Sep 2022 10:52:08 -0600
Message-ID: <CANLsYkzWnEY2t-7Di5LXX6oYKzTUAwfBHT0dkPm0puGt6YhL3w@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Add support for UltraSoc System Memory Buffer
To:     hejunhao <hejunhao3@huawei.com>
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        rdunlap@infradead.org, liuqi115@huawei.com, f.fangjian@huawei.com,
        prime.zeng@hisilicon.com
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

On Thu, 1 Sept 2022 at 07:12, hejunhao <hejunhao3@huawei.com> wrote:
>
> Gentle ping. Any comment or suggestion is appreciated.
>

There are a few patchset that are both substantial and complex to
review on the log.  As such reviewing will take longer than usual.

> thanks.
>
> On 2022/8/18 21:22, Junhao He wrote:
> > Add support for UltraSoc System Memory Buffer.
> >
> > Change since v8:
> > - Insert a blank line at the end of the config tag in Kconfig.
> > - Fix the "llseek" initialization.
> > - Link: https://lore.kernel.org/linux-arm-kernel/20220816131634.38195-1-hejunhao3@huawei.com/
> >
> > Change since v7:
> > - Use the macros for register bit flags and numbers of resource.
> > - Fix punctuation.
> > - Update the Date tag and the KernelVersion tag in the document.
> > - Link: https://lore.kernel.org/lkml/20220712091353.34540-1-hejunhao3@huawei.com/
> >
> > Change since v6:
> > - Modify the code style and driver description according to Suzuki's comment.
> > - Modify configuration of "drvdata->reading", to void problems in open/read
> >    concurrency scenario.
> > - Rename the macro of "SMB_FLOW_MASK".
> > - Use the "handle->head" to determine the page number and offset.
> > - Link: https://lore.kernel.org/linux-arm-kernel/20220606130223.57354-1-liuqi115@huawei.com/
> >
> > Change since v5:
> > - Address the comments from Suzuki, add some comments in SMB document, and modify
> >    configuration of "drvdata->reading", to void problems in multi-core concurrency scenario
> > - Link: https://lore.kernel.org/linux-arm-kernel/20220416083953.52610-1-liuqi115@huawei.com/
> >
> > Change since v4:
> > - Add a simple document of SMB driver according to Suzuki's comment.
> > - Address the comments from Suzuki.
> > - Link: https://lore.kernel.org/linux-arm-kernel/20220128061755.31909-1-liuqi115@huawei.com/
> >
> > Change since v3:
> > - Modify the file header according to community specifications.
> > - Address the comments from Mathieu.
> > - Link: https://lore.kernel.org/linux-arm-kernel/20211118110016.40398-1-liuqi115@huawei.com/
> >
> > Change since v2:
> > - Move ultrasoc driver to drivers/hwtracing/coresight.
> > - Link: https://lists.linaro.org/pipermail/coresight/2021-November/007310.html
> >
> > Change since v1:
> > - Drop the document of UltraSoc according to Mathieu's comment.
> > - Add comments to explain some private hardware settings.
> > - Address the comments from Mathieu.
> > - Link: https://lists.linaro.org/pipermail/coresight/2021-August/006842.html
> >
> > Change since RFC:
> > - Move driver to drivers/hwtracing/coresight/ultrasoc.
> > - Remove ultrasoc-axi-com.c, as AXI-COM doesn't need to be configured in
> >    basic tracing function.
> > - Remove ultrasoc.c as SMB does not need to register with the ultrasoc core.
> > - Address the comments from Mathieu and Suzuki.
> > - Link: https://lists.linaro.org/pipermail/coresight/2021-June/006535.html
> >
> > Qi Liu (2):
> >    drivers/coresight: Add UltraSoc System Memory Buffer driver
> >    Documentation: Add document for UltraSoc SMB drivers
> >
> >   .../sysfs-bus-coresight-devices-ultra_smb     |  31 +
> >   .../trace/coresight/ultrasoc-smb.rst          |  80 +++
> >   drivers/hwtracing/coresight/Kconfig           |  11 +
> >   drivers/hwtracing/coresight/Makefile          |   1 +
> >   drivers/hwtracing/coresight/ultrasoc-smb.c    | 636 ++++++++++++++++++
> >   drivers/hwtracing/coresight/ultrasoc-smb.h    | 115 ++++
> >   6 files changed, 874 insertions(+)
> >   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
> >   create mode 100644 Documentation/trace/coresight/ultrasoc-smb.rst
> >   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
> >   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h
> >
>
