Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A0468F43
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhLFCrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbhLFCrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:47:08 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E13C061354
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 18:43:40 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z5so37231370edd.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 18:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymd6P5lILm8kCnpIAJpyY3MsDDsYTeqTIxl8Yef5YWE=;
        b=2kbZxWStBRfrT81SzE2HO3kF9ABLfHYL5BL3VYUs6WwWLjmIDonJdWwwSJ9a0FvgR7
         hHRmvcq5ouCeg94MAMPJaHwsVNINcmhY2+ZqsiMQpJZo5reyI+DDzmzM9MauDkiiYvtr
         v7M/5wqBN8XVpod5/DwNhhFA6zy8xjJL5b5QSgbzR/FKNyLtCKjRwhm9PAm+6rqUIrK4
         Y8STUO1xfj0nt+F9BpY0n1I6XFzf6itjiN53dg3KSj3chasVh48UWyjDBJ2HyutQ2vCe
         vT4UrdgFcjdr6YP+oL4Dugb3Uo18z5zmJHqTj6aL/LtYKoUL/DALbbHT1XQhpZ/LeNt+
         X6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymd6P5lILm8kCnpIAJpyY3MsDDsYTeqTIxl8Yef5YWE=;
        b=lW+2dTvTw0oIrYWHp2/J5AoA0dflvNn1AsbccAt/uKxj6LoQ2WXr3L42GPbmByH+r4
         LMls9gZc37vXxme8GNiDf3LZu1IGVVvZKD8M0tyOLskq9tTxng9spxL40jw9Wy/7zZ6H
         IZh+HpZcucS3Nh/u6BTcoZCcimDT6ZpJP4pcQx01xKxz7Mh3pU81q4O/bUJmIb6GILx8
         tNdXVDzT0zSnN61lTQfCDe/FNy2hi5aO0Jhol25r6bnKgFoDeLD39t2/jkVBmw8tiKtP
         kLy8FHCoLBV40zRUfXzOmuSEdP1eQ07eFMyvZzMJ0jM5YG9BezygQupvXHzaZVYU+uNC
         yqdQ==
X-Gm-Message-State: AOAM531rhKYJzAPOG1vVTDWyi1pZuhIyEAZmNnf4uyHKRFCY36xRIii+
        DHbtCrVMhYE8KhEBxLekEGtMJfDIaH974dpljpnE
X-Google-Smtp-Source: ABdhPJx69ThSSJXqiAFgrgGcClluUyTxJgmFaPaaQ09XYzcsxYERZ20FcG40EB3q9kgHLNGQC2XObsEZv7oJQWgCako=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr41876657ejc.126.1638758618582;
 Sun, 05 Dec 2021 18:43:38 -0800 (PST)
MIME-Version: 1.0
References: <20211124014332.36128-1-casey@schaufler-ca.com> <20211124014332.36128-2-casey@schaufler-ca.com>
In-Reply-To: <20211124014332.36128-2-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 21:43:27 -0500
Message-ID: <CAHC9VhRSnxf2S=Re8etrDnBqEkRemFwA0F9THK9FNeV3edLXfg@mail.gmail.com>
Subject: Re: [PATCH v30 01/28] integrity: disassociate ima_filter_rule from security_audit_rule
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 8:45 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create real functions for the ima_filter_rule interfaces.
> These replace #defines that obscure the reuse of audit
> interfaces. The new fuctions are put in security.c because
> they use security module registered hooks that we don't
> want exported.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h     | 26 ++++++++++++++++++++++++++
>  security/integrity/ima/ima.h | 26 --------------------------
>  security/security.c          | 21 +++++++++++++++++++++
>  3 files changed, 47 insertions(+), 26 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> # audit


--
paul moore
www.paul-moore.com
