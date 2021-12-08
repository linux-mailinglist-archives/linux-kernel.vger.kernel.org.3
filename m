Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585B646D2AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhLHLqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLHLqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:46:44 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AF5C061746;
        Wed,  8 Dec 2021 03:43:12 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id j2so5234940ybg.9;
        Wed, 08 Dec 2021 03:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yxEFrVGam1sH5uNwQrNFOpjDTgkpMFeb4dI2bKRqm0Y=;
        b=A0s3eARuEODnrLhT3UvzFmjX8sqVBkKGSat580Iq/1mX4g4mssIb7gs5XGVNUGannP
         haXL1kmg/3AMygEQh08dIdhTKYlNEerhD7jhHUrTprdG8PewPgjmFj6N+MzJy2fRozaj
         FO1kNoepHiivA/C0Fhtc17bDHONQ1muaURSlPREJ1FI1QkX84scNKp0R3sCOKwcwikv0
         kmQjHcnP9zx3WuhHkI4lEcm3zOS6WSGGXglkly1fXhNg48PDAWcOJ028F12vGv4GHiV4
         yzNOvNVAuvG9u3Q4y77WRUV1p0mk7phKMRSfS+9yQ3WxWKZZFipIY+ldREczkF3jfNou
         sR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yxEFrVGam1sH5uNwQrNFOpjDTgkpMFeb4dI2bKRqm0Y=;
        b=f5rq7mJtxYIjkG18yxk0K4TLIF4T3wn1MsuB6r2g5fZq2VpeyggPqf1sez8OkIYS6/
         lW3mEcGWrrpAIxDpJWhjLmXigYnPkOuv4128qVE3SAsesN/cK0hT5e8dyn/ypfw795Em
         J8qKcJHCXdiel7DtbvHTKZVSw3tQ30APgVeMFzSOnwYT9KM570WXWPqkikXSLLDqfCUo
         8w+rC1eKxCtps0OJYtDrqz2yxtioLGNhRNqESfRNgzFB1m1evWKrH1b+nB7HOS6yjb4Y
         qgyCdwjI2W564qYscH/IhS1Bnh7IPNfGK0JYNBs4ysEGFNpfXV3RYqpfrJNVuCap7pyL
         C2ng==
X-Gm-Message-State: AOAM5339T/erO/SHtjF4zzk07U4MqBk24i75n1UUqFSGC4OEMIWTM9ar
        qSTQPdZh8L/uFe5aBTTZHANsz0lv9QWjshuCIdA=
X-Google-Smtp-Source: ABdhPJwb1vD2AoI706KIsAuB2qTkjFZlaI1PpyFx73w2I0GqMxaxKPdy36W2Z1Sz/zNVdof5oihAhrKkfeKpdpPeqlE=
X-Received: by 2002:a25:3b04:: with SMTP id i4mr54456082yba.767.1638963791908;
 Wed, 08 Dec 2021 03:43:11 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 8 Dec 2021 12:43:00 +0100
Message-ID: <CAKXUXMyip-Ojt-uOsjU-LnajM+cV4EcAf6ABNoAus+t2fAizDg@mail.gmail.com>
Subject: config CPU_SUPPORTS_HUGEPAGES refers to the non-existing symbol ARCH_PHYS_ADDR_T_64BIT
To:     Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Daniel, dear Paul, dear Thomas,

In commit d4a451d5fc84 ("arch: remove the ARCH_PHYS_ADDR_T_64BIT
config symbol") from April 2018, the config ARCH_PHYS_ADDR_T_64BIT was
removed and all instances of that config were refactored
appropriately. Since then, it is recommended to use the config
PHYS_ADDR_T_64BIT instead.

Then in June 2019, commit 171543e75272 ("MIPS: Disallow
CPU_SUPPORTS_HUGEPAGES for XPA,EVA") introduces the expression
"!(32BIT && (ARCH_PHYS_ADDR_T_64BIT || EVA))" for config
CPU_SUPPORTS_HUGEPAGES, which refers to the non-existing symbol
ARCH_PHYS_ADDR_T_64BIT.

In this expression, the symbol ARCH_PHYS_ADDR_T_64BIT always evaluates
to false. So, the expression is effectively "!(32BIT && EVA)" right
now.

Now, it is a bit unclear what is intended here, especially since it
was not noticed to be wrong for the last two years:

- The commit is buggy, but nobody noticed it so far. It was intended
to refer to PHYS_ADDR_T_64BIT. We need to provide a fix that changes
the semantics by referring to the intended Kconfig symbol.

- The commit is just a bit unclean and that is why nobody noticed. The
reference to ARCH_PHYS_ADDR_T_64BIT can be dropped. We can provide a
clean-up patch that preserves the current semantics.

Once the situation for that commit and its intention is clear, I am
happy to provide the suitable patch.

Best regards,

Lukas
