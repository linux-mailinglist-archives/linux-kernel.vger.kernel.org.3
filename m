Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EB755CD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242254AbiF1H3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbiF1H3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:29:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378BE008
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA6A4B81D17
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883E4C341CE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656401376;
        bh=gajtv8igkxsalepIVsDrLsd6ac/KAzU/0AKP3t/oWm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NWIhdzsLkx/fuKi2CbKB7Gp774a+W5f5NwfOLFGwf3z90rhbsxTMinAkxh8jcakiU
         nFrPTKtgbDMuLxRd0Xdx9bpR4/QBGWpd0POhws/XpGi/1wmu5e9nUW4kKHPnhwWig+
         UpCnnLlJfykJj/VcFNhWGS/FtmJs2xj1Ddrm8eyloOPYBdU4uGQotjTtPKa/4Oma91
         tdCSm41+p768sEEUMv99WiRf6/XE0MVqmyprGMYjISm2T7Kh/9UemWgRYdSs6YkrsO
         Pup2m93l3AuJc/2Dy1Av+NVS1WtGQb0E3uSL+iHvLYbPguARV2hzBVt14ZdapXvH74
         mGf2sF2D/D3vg==
Received: by mail-vs1-f51.google.com with SMTP id o13so11178179vsn.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:29:36 -0700 (PDT)
X-Gm-Message-State: AJIora+G/cm5ZJciFfwj5E10EWhf36V1tb1uXOp9gILWV6FPxOiuK3gj
        4KsAxZtdcIu86K5gfm+W8z2T7eA/2zjiOQuT3Ow=
X-Google-Smtp-Source: AGRyM1v78quckxzZ1EVy8zY1GzwUlah3HJmvB0SJzL+HccAA+AcvunAA4R7teXMtlllIWtG3ET26bvghE23c1jGqAhM=
X-Received: by 2002:a67:f588:0:b0:354:35de:4329 with SMTP id
 i8-20020a67f588000000b0035435de4329mr690432vso.84.1656401375514; Tue, 28 Jun
 2022 00:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <1656313055-547-1-git-send-email-yangtiezhu@loongson.cn> <4a4bce7b-cc75-6035-9ce2-1727d97a458d@loongson.cn>
In-Reply-To: <4a4bce7b-cc75-6035-9ce2-1727d97a458d@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 28 Jun 2022 15:29:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5W2TL9Vg7Zk+JV+9hQgnH9FPJJGFz+W0Y7fx2_FsphKw@mail.gmail.com>
Message-ID: <CAAhV-H5W2TL9Vg7Zk+JV+9hQgnH9FPJJGFz+W0Y7fx2_FsphKw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix section mismatch warning
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        WANG Xuerui <kernel@xen0n.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>, loongarch@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>
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

Applied to loongarch-fixes, thanks.

Huacai

On Tue, Jun 28, 2022 at 8:18 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Cc Masahiro Yamada <masahiroy@kernel.org>
>
> Hi Masahiro,
>
> Please review this patch.
>
> https://lore.kernel.org/lkml/1656313055-547-1-git-send-email-yangtiezhu@loongson.cn/
>
> I think it is related with the following issue, thank you.
>
> https://lore.kernel.org/lkml/CAHk-=wgcsUU-TNoLS7Q6YF3RCSVAKwNM7gFOwqnPQTiU_oGEWA@mail.gmail.com/
>
> Thanks,
> Tiezhu
>
