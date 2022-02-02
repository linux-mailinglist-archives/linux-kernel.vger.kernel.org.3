Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229EA4A698D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbiBBBOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiBBBOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:14:10 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74888C061714;
        Tue,  1 Feb 2022 17:14:10 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id s18so23479300ioa.12;
        Tue, 01 Feb 2022 17:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SuoLk/eB2LyIrK2WAJXGapA14pYbHY6NEIo8Ima2GSM=;
        b=X+Pob0+LvdGmN/GRaPCbi9J6/KBqHLvgbrEnAP4POO6efQUxRgvyfxDVeUjDSJk00/
         U5WNDqbIgqcWUkeNcKYDn6CKYfCS1NOTnPqEdz+socs5sKHZTSao2LydOwYfqXpdVe5q
         7w8Jz2XFzyYKnuHdmwZnIKkiLL094dHrqYklGpjiWnZxoQNlqRtHHIwTqeUt8dYkNkW5
         +8MzGjKVqvkeaABefP6V1ViIzowswND3fJJy3iq8ebvVePyiuUWfqqvZPtAfE70Q4sdI
         NBztqSgHqcGkd6tBihMOLqOgAyDi9HTxMz3AO7CD//0bC5rd09iFRUjzVOxAJnZHvGP1
         Gkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SuoLk/eB2LyIrK2WAJXGapA14pYbHY6NEIo8Ima2GSM=;
        b=R1S7AQ87gbzmho6mRL2Y3q7zkLb/dQRR9EnvK4BR73B48opMZ5X9RKRLPGqgLQyEiu
         EDtp9Gd3csQbq7afZ9Yb+QaRoDYzsZ8JVO8caeaNv2IAx7R3CwlZiYcFSvl7vC2ut9+m
         AC6lyrpuZy+vOElh77TpFJ2qhrRkebgUFtu0Gd3VcMZ7RfnzY3B4dl5SKfbfz9h+hb4Z
         ohCvvRGQv3y8b6tqVPuy7pSkCnIGty0ThCjsG6pZ/El8liFl26s+gI308U6bwwtiNCoj
         IrxDQqvN+kWOnCt835YL0lBgtSJv4Yv3XBJS9TEVm/7mqc8XCPOfSL0s13ieAkKI9Lhv
         VL9g==
X-Gm-Message-State: AOAM531MuyZYI9zdrUTAetfi8xMQWazn8IvEy9e2MkcufM9MJmawROl5
        3VN5W2GDfBgkJJoW3fL1BFHS3NNP1Aa3qOoXam4=
X-Google-Smtp-Source: ABdhPJzQOP2XQDSSMDsr4TM971ls6AQSgLTjolNI1RoC42eUw8X2ye05F4aKMvVYkQUavql4xy01L/RDlcI4bzaTAHQ=
X-Received: by 2002:a05:6638:382a:: with SMTP id i42mr13265444jav.256.1643764449909;
 Tue, 01 Feb 2022 17:14:09 -0800 (PST)
MIME-Version: 1.0
References: <20220202003033.704951-1-keescook@chromium.org>
 <20220202003033.704951-2-keescook@chromium.org> <CANiq72n1d7ouKNi+pbsy7chsg0DfCXxez27qqtS9XE1n3m5=8Q@mail.gmail.com>
In-Reply-To: <CANiq72n1d7ouKNi+pbsy7chsg0DfCXxez27qqtS9XE1n3m5=8Q@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Feb 2022 02:13:58 +0100
Message-ID: <CANiq72=aDRzxV0DZ6PNFXL-Z=NBAmyaMwL=MNxaOEWVSo8PZ1Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] Compiler Attributes: Add Clang's __pass_object_size
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 2:11 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> For `__diagnose_as_builtin__`, I only see it on Clang trunk, so I
> assume >= 14, thus could you please add:
>
>     * Optional: only supported since clang >= 14.

...and the other two too:

>     * Optional: not supported by gcc.
>     * Optional: not supported by icc.

Cheers,
Miguel
