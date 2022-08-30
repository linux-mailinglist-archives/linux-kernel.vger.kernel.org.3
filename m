Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768E75A5E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiH3Isw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiH3Ist (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:48:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9BBBBA43
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:48:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t5so13229236edc.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7iCvOssdkyuxbhoQt5lAWcL9dGnbKNvL6gaRHI/rUIE=;
        b=e1waB5CIdo3f9+WqVOb5fZZ2HpfISqnyynQUiahYiWLbFsihpG9YE7QGYopiztHtXQ
         YXEVdbX5AT4GycNvKMv93DvvepUVg+cxuEJlA0UotKWcwF/kSBe2qXUNXMGy9guT6bV5
         AWSQtUErN9c0DciG1ox0ijf+yrYasDH4uJBLnx8hbOrv6gv7x85Jec8rXbrE0LjZj9sk
         93q8Ykimr38kngAzUz8DKwDpkYE3jYvNo7+WdsjBp53wMiCrqp/oeTJzQjx6/W2HSGhW
         u4Y5/h24B6BB5dnDQ/Ib5Lz38xBIe+zaPEQSgnFMnVmjsBqoTuzLc4NulAl2wPP3JkyF
         Ynjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7iCvOssdkyuxbhoQt5lAWcL9dGnbKNvL6gaRHI/rUIE=;
        b=rz+vuZw9o0N9mbuyPFoi1EcVK2vlWh9gE/xSs23PXV9P0YnEmCmkpeTkLYz4OKg6Dm
         Wc5Eqqno9bEkn4P6Kbprd4+oAOYhVSyXWNGZpRnomdulzdjEGuXwePFgZcbgeGOWMzLa
         OWZ2OQdSf7WYdfZWjkt8cmubJB0A+ZSP53apvBEectlub0K5TxCVj+riP4eftwDnKeaL
         gQW0jEfAEUAmjJsVg5cwQ040rlMMGqAMdU57qY7N9R6MECJ8Q09mxw/pu5yt3MChCN9A
         X0jXdtQCo4sjE/ZTRV2fz+NWJcA+2rRmC971O2MkNjpa7cAlUweGN7TuQbA1Fydz1KOZ
         epJw==
X-Gm-Message-State: ACgBeo0zLRifF+on5o0sF1xj0xmnBf5k/hTsQipPUyhu/NqzZ23Rzexf
        6xckaDoGQmA55Wt/ocoiHkFjFVZY+EanO3Yj3ALCxn5wUis5Lw==
X-Google-Smtp-Source: AA6agR6mBK9z4mx3yoZ8UY/yL9aH81E4FjsmEQwAZZK0RoH7oRkvILaIaW6x0TDSxBaGMRQvceJsm6oUWvUFEePGLIk=
X-Received: by 2002:a05:6402:4446:b0:43b:e1f4:8525 with SMTP id
 o6-20020a056402444600b0043be1f48525mr19520149edb.236.1661849326660; Tue, 30
 Aug 2022 01:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com> <20220826180327.yazfoydjiyygd7qf@mobilestation>
In-Reply-To: <20220826180327.yazfoydjiyygd7qf@mobilestation>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Tue, 30 Aug 2022 09:48:35 +0100
Message-ID: <CAHyZL-cmyRprNmr_DtUQaZFXJtcV-6r-UOksFJeMz=XgDhnMNw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Add support for enhanced SPI for Designware SPI controllers
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>
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

On Fri, Aug 26, 2022 at 7:03 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hello Sudip
>
> On Tue, Aug 02, 2022 at 06:57:44PM +0100, Sudip Mukherjee wrote:
> > Some Synopsys SSI controllers support enhanced SPI which includes
> > Dual mode, Quad mode and Octal mode. DWC_ssi includes clock stretching
> > feature in enhanced SPI modes which can be used to prevent FIFO underflow
> > and overflow conditions while transmitting or receiving the data respectively.
> > This is only tested on controller version 1.03a.
>

<snip>

>
> I've deliberately collected all the generic comments here so you'd be
> aware of the required changes in total, because I very much doubt all
> of them could be fixed at once via a single patchset iteration. But as
> soon as all of them are fixed we'll get a very nice and neat solution
> for the eSPI feature.
>

Thanks a lot for the summary here Sergey. I am sure I will have a few
questions for you after I start with the changes.

-- 
Regards
Sudip
