Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C574C70E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbiB1PmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbiB1PmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:42:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FEA7EB22
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:41:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44513B81200
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C7EC340F7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646062897;
        bh=kUHj0dIOXGHqtRWBFs95OAMPTNPiain1rxD1sCE0X+o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RPL8O27wy227IH6hDihlMeTKAdbi9LQDnLtlsiiouWp4R1IzvBA8ofH2xN7GASBr9
         IttqVHeMJMNAncDEmvWOiWGLhYi0Lb3g77NPL1xxvEdmfT/kwBSMayvVYzRnlTF7Qr
         +V8WFqryXaLG797SYz0zkSm+ND1hQgo2Goswh5KNVLr9d325z8wCUmMxvkxnF1CmIk
         JMjCdqwAudTgRYBh02xfXRa+8wcG3TgLLsNdmjkzm/P8TMa8TXU6hneRUiL5ux/TwR
         VVvvRysT4HBDbCaCyUHh3cFjjFr8D3bVprN275xSp8FTVT352BkWuKTSQZmH1MQ/fu
         qvHfr8aeyJbiw==
Received: by mail-wm1-f46.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so6337952wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:41:37 -0800 (PST)
X-Gm-Message-State: AOAM531tvnM8jru1euQnfmuWVrBz/yfCi2MBABXaIyHFS2CR4Yd5drfs
        AD2AqIFxF89qb4h4jfwXsCAJD9YrFl4jSlZngKI=
X-Google-Smtp-Source: ABdhPJxISiZ41KAtSIiPPfznP2BMAZANGGomoQBB+i3Aqrew6fpEKZrCd96CMlxa7yjxEx4ZivbdLNGkQjrtoXzO9Ak=
X-Received: by 2002:a05:600c:4f8e:b0:381:6de4:fccc with SMTP id
 n14-20020a05600c4f8e00b003816de4fcccmr3161768wmq.82.1646062895799; Mon, 28
 Feb 2022 07:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20220228152658.3367506-1-arnd@kernel.org> <b8eb2e55-b5a8-4a39-86cb-93cadbd67922@conchuod.ie>
In-Reply-To: <b8eb2e55-b5a8-4a39-86cb-93cadbd67922@conchuod.ie>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 28 Feb 2022 16:41:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1NWuoHVWXVZUGJxSg=D0d3umrMzWqZ75devfOwO-JhuQ@mail.gmail.com>
Message-ID: <CAK8P3a1NWuoHVWXVZUGJxSg=D0d3umrMzWqZ75devfOwO-JhuQ@mail.gmail.com>
Subject: Re: [PATCH] SoC: polarfire: fix build warning
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Lewis Hanly <lewis.hanly@microchip.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 4:35 PM Conor Dooley <mail@conchuod.ie> wrote:
>
> I had sent a fix for the build warning on saturday morning - but I guess
> you missed it.
>
> Thanks for fixing it anyway :)

Thank you for your quick reply. I had indeed missed that fix. You did the
right thing here by sending it to Nicolas, but he hasn't had a chance to forward
it to soc@kernel.org yet, so it was not visible in patchwork.

As it turns out, your patch is correct and mine was wrong anyway, so I
have now replaced my patch with yours.

Nicolas, I hope that doesn't cause you extra work. If you have picked it
up into your tree, you can drop it again from there.

          Arnd
