Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC85658EF81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiHJPih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiHJPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:38:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206B3F30E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E441B81D04
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFF9C43470
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660145910;
        bh=qqqmFcLlUbU+LZpMH9dd3OhpfYNlFzxOGRdFjq4rYYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=piBrGR6byFvmu77NPFWbBqe2Z9thNdT+ETsXYN5UkNJiJg8RaQIf4uTP7PmZdKnrw
         P3tXJTkQqeb03+iulTWskGzJvsZjrjhnAGEKOnxWSTRDlUI8bS16LY/nnvkb1m/ros
         KX/t1DQJegahzN3NOtPzuBrTAP8kjCvt8Rppn9HWrgcGrBRgKWAxQo2URKsV8RtW2l
         V+76GedhpUddJxyLxPnUSDbR0X2CeTtitBrQz8E6KBQLGhgAYlKOOR+PxYgq4LEKOr
         CEVLLH1sKEaxpKsuFB2W27ZR5+e4I7NUQiQiB5EX9xDDJ8JH4jr8jK6DrQu9udauLR
         cQiwnTiFPXjbw==
Received: by mail-vs1-f54.google.com with SMTP id q190so15520610vsb.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:38:29 -0700 (PDT)
X-Gm-Message-State: ACgBeo1633yTpu0iWY5LgVlRGCx+wPNLRRLjQkHs6ZI4YXbXOIRKglPh
        caoMb14EJr9X89JZsLoYutTPM+gEHxl4g/EtmEY=
X-Google-Smtp-Source: AA6agR4+TocvVEVMrd087/tbt7MQyh5j8fhKxCRzfxHM/DQSd+kr3p8OddAx4jllFhPw6pUGVPXTWCjR1g9WU6HxExs=
X-Received: by 2002:a67:e288:0:b0:388:b41d:1654 with SMTP id
 g8-20020a67e288000000b00388b41d1654mr6240428vsf.70.1660145908864; Wed, 10 Aug
 2022 08:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220810103156.1214996-1-chenhuacai@loongson.cn> <f92fc4f34784217206b53a3709538d5c@kernel.org>
In-Reply-To: <f92fc4f34784217206b53a3709538d5c@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 10 Aug 2022 23:38:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7DbvjEcms9Y81t_=WyDnKu5vuB4x7g7vU3f9CUhZykHQ@mail.gmail.com>
Message-ID: <CAAhV-H7DbvjEcms9Y81t_=WyDnKu5vuB4x7g7vU3f9CUhZykHQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix the !CONFIG_SMP build for irqchip drivers
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Wed, Aug 10, 2022 at 7:01 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-08-10 11:31, Huacai Chen wrote:
> > 1, Guard get_ipi_irq() in CONFIG_SMP;
> > 2, Define cpu_logical_map() for the EIOINTC driver;
> > 3, Make eiointc_set_irq_affinity() return early for !CONFIG_SMP.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Frankly, the real question is why do you even bother? As far as
> I can tell, LoongArch has no UP system.
>
> arm64 crossed that bridge a long time ago, and we never looked
> back, because these systems hardly exist.
>
> I'd rather you simply have a CONFIG_SMP always set to 'y', and
> be done with it forever.
LoongArch also has low-end processors (even LoongArch64). Though we
haven't translate all documents at
https://loongson.github.io/LoongArch-Documentation/ in time, there are
currently 4 LoongArch64 processors: Loongson-2K500 (single-core),
Loongon-2K1000 (dual-core), Loongson-3A5000 (quad-core) and
Loongson-3C5000 (16-core). So we indeed need a UP configuration.
Thanks.

Huacai
>
>          M.
> --
> Jazz is not dead. It just smells funny...
