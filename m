Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF744F5C04
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiDFLQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiDFLQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:16:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A783A53F7A8;
        Wed,  6 Apr 2022 00:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 444B7B82141;
        Wed,  6 Apr 2022 07:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1117AC385A3;
        Wed,  6 Apr 2022 07:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649230717;
        bh=RPPLRiPKvyfwNpU9DC7rnc/UmIxwMryzTBJ2jG8C1pM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EcRfiyQlp8ztr7mxkgd0oHf3/vWP/rKjV5Rj1nhrJWP2MbKlzWh0Kzr8dzUil2oWX
         Ue7aRICOG+6YnroxtuRDbAYrgoeuFt0EqNrOwcJGAqEnWWTTR+QHOJyOnOxuKYYPEG
         21YO4e9zW+40BiBopG1Rs3+/M5ulkzJvlEYDyiThl5lDLUKeTZC0hPq5Zd3CYvXBFR
         BIiW2xB2lOyZso7BRrLXj1eDHvYuUIi7ieauCUPmef+AiQaFXXM2/ghCailF139EEm
         U27iIQBNEA9e3iig8FLZlEpAQYEPLnxgG2F0vTJV+gCrUIlZYmfHxwjh+OP/71kmeC
         W5AYyt4mMOSvw==
Received: by mail-wm1-f42.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so2285122wms.1;
        Wed, 06 Apr 2022 00:38:36 -0700 (PDT)
X-Gm-Message-State: AOAM530Nm4tVaOR3LvyYi/8Cb4b/UkOKmGeCMtV42+VY/PCxs+/AU9w6
        OjrXdGQ2lCU/8n2cAisz6r3YlwuCnV18j5WfRxY=
X-Google-Smtp-Source: ABdhPJxaeqfciTDXCDjrEADLPNZyoksoREiuI0fsn1OZswRJclWU6hUgOuaBXJGBusVLkwuFnxep7UIMYAqnoluJliY=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr6112432wmc.94.1649230715337; Wed, 06
 Apr 2022 00:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220203083658.559803-1-arnd@kernel.org> <Yk0z9zVaUpVcn30j@infradead.org>
In-Reply-To: <Yk0z9zVaUpVcn30j@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 6 Apr 2022 09:38:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1g3rhEAN7P4hpCNzX+jJY4WDJW0je_miUGmz327tV6cg@mail.gmail.com>
Message-ID: <CAK8P3a1g3rhEAN7P4hpCNzX+jJY4WDJW0je_miUGmz327tV6cg@mail.gmail.com>
Subject: Re: [PATCH] [v2] ARM: sa1100/assabet: move dmabounce hack to ohci driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Apr 6, 2022 at 8:32 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Just curious, where does this stand currently?

I am not aware of any remaining problems, but I am waiting for Russell to review
it again. Russell, can you have a look now, so we can try to get this into 4.19?

Let me know if you need me to resend the patch, or have a look at the archive[1]
link for the current version [1].

        Arnd

[1] https://lore.kernel.org/all/20220203083658.559803-1-arnd@kernel.org/
