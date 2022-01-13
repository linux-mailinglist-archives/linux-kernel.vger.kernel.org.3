Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B19C48DC78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiAMRBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbiAMRBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:01:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B44C061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:01:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q25so25515618edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3h3HyI2D2Ehek5Q6ehN/mXysRuKEPGo+5l6M7CZ6gM=;
        b=Qp2ns1EGZ9l5G13tpZNNE+gBdag1U+a0jvrTcl+NU1ARuYSgo487p+YV57wNmX1nNJ
         WiOZ0Yab0WrXGjf6KS51Lw/Rk5g+rmkvQ/LvBimuMNV7/Ut7nlymYNFpptDLWZIdZh9H
         jpAF0VwZauZ1SHVkOXit61Zw7RGiUASTC/mS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3h3HyI2D2Ehek5Q6ehN/mXysRuKEPGo+5l6M7CZ6gM=;
        b=5GW9mGiu+HHLFEI998YJJuWZp1qOQBf3scJM3A8hotqzBIne80g5MFw3x/582i2sId
         WKFRuenxRHp1K+YKUukhaO6RM8hvAANIvikPvmbaLcrU9JMBHv85refwSw+S/Rp5du4V
         pntXYBpHpv3JjwXgL93vLtZeb0Z14ShOvYzX/Y+bGOGI8xS1wiVrulWBOoDJrJu5YeVF
         bijbut+dmJ7PzsHoMmttxjFxbrex7IDYLK9lHvoyh4DRZ0ecM9u6ODNRRxP+vOnGvuI0
         BiJpS2p176fOK6IhMdLTk1xMnh2x3TeetSgp2RD1v2uXO/Vq/F0ov7XP8UdKmNuCMRzn
         ocgg==
X-Gm-Message-State: AOAM531dnGAolbhF785Ut2r3Gqmy5WB3wbkARmuB1gSzgqII0ijMVoy4
        Tk+2XGmCFWMmDDN7vZFka9Iq+aWtCtQePG7m
X-Google-Smtp-Source: ABdhPJyNU4oMa6FWjQB5BipMeGsfe5ls76gwSGf7Mf4uAlQxCxqELeYrklcNOf7OJaYsd25mGDI6SQ==
X-Received: by 2002:a17:907:2ce5:: with SMTP id hz5mr4224678ejc.153.1642093304034;
        Thu, 13 Jan 2022 09:01:44 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id o8sm1417961edc.85.2022.01.13.09.01.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 09:01:42 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id h10so11324470wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:01:42 -0800 (PST)
X-Received: by 2002:a05:6000:1846:: with SMTP id c6mr4658395wri.193.1642093302226;
 Thu, 13 Jan 2022 09:01:42 -0800 (PST)
MIME-Version: 1.0
References: <164206863083.82661.4520085707599437707.tglx@xen13.tec.linutronix.de>
In-Reply-To: <164206863083.82661.4520085707599437707.tglx@xen13.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Jan 2022 09:01:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvPxG2Sje_OBSeDODiD68ke+ta118xeYskNxkv-kAtyA@mail.gmail.com>
Message-ID: <CAHk-=whvPxG2Sje_OBSeDODiD68ke+ta118xeYskNxkv-kAtyA@mail.gmail.com>
Subject: Re: [GIT pull] irq/core for v5.17-rc1
To:     Thomas Gleixner <tglx@linutronix.de>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 2:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-01-13

Hmm.

I got a conflict in the mlx driver. It looked trivial, but just to
make sure I compared against the resolution in linux-next.

My conflict resolution is different, though, and I think mine is the
correct one (although maybe they end up both being fine).

But I'm just about to leave for travel, and maybe I'm wrong, so I just
wanted to people to verify...

It's

   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c

and in particular the 'err_xa' release part of mlx5_irq_alloc() - I
made it use irq_update_affinity_hint() to match the irq_release()
paths.

Maybe irq_set_affinity_hint() is equivalent when the new hint is NULL?

            Linus
