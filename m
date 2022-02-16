Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A170B4B8E26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiBPQhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:37:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiBPQhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:37:51 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BFC15B98D;
        Wed, 16 Feb 2022 08:37:39 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2d07c4a0d06so5058927b3.13;
        Wed, 16 Feb 2022 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1HSWzwwf+kqM1H3WKl4CKD1fy+/Eg4hPVY/5DkKXtv0=;
        b=NOKQQkhKWRKv7sjhtTE4acYjcic6kpKzEYEVQ75t/U7XOC6PZCMQ2n/VpV9L3U1i2C
         05aQoje04/Rw0SgmAdXwd9aIQEbi5yMVYNzf+TFUcbqM/sjHK64ynKYpyTebGGhR9sEc
         Bg+1uAuzxBdJs2P+hYZe/F8oHZWJLTWKA3r8D15eUr66Tqr+aOCdi4io/TK3D1GGZV59
         j2E+W5AbilfUvkHFxOhLzh5oF63zYlITMqpu2CW6HA74VNZ06/xS6ANxZLuiXkzIKX21
         qdHXC/bx1ov8Y9+8Vihc86u74dKbTN+iC9D4I71IX0FEORzkMBruhf1ECaw8JtORlKxM
         3HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1HSWzwwf+kqM1H3WKl4CKD1fy+/Eg4hPVY/5DkKXtv0=;
        b=Klvcp4zcwkewdfj0dTtZX/KlTVX4TGHr9u444ujRXR9JD/x0rqhxaijiRP0g1YycWd
         +KUPvi8kAKEeuGvH7lX9u0VqK6YSTO+kCFFwM9srkkRqd23OQtIyyt4QeHdiOloQAQ0n
         HQH8FnfekGkdECSIyqAmW3caHbRYWC+oYG7yzEm+e1Q+gErKeMVQCSApGiexxdlqOy1X
         Iimej8FAgUpDK7WFFnzZoSGhElVJYDtGwdnjJI+IWtKlyUOxolyHoii7ZdCJTM64KCA7
         6H7PfUqdyt11PkqsBr7iUyoMURKS9/YDFUGf6nzF/c67MosCjsfigFr9vIadw6jn+iTV
         CgsA==
X-Gm-Message-State: AOAM532OV9x+wxrEMnP5Z/5NcypqqLEpbzoF0L7X5vYLNxdj4c9ytjOV
        Rl0/XZggoTgmNSerQZ82cwM8tRAmzmWLs+CaIDY=
X-Google-Smtp-Source: ABdhPJwVOya4eyywIxLJoCl21jgdhzWq77eTEP24tnx4CFAujXRygQZnVEBTBXHQx/RSpiBEdBuv3+XUnkuRs/mrBHM=
X-Received: by 2002:a81:493:0:b0:2d4:6dfd:beb with SMTP id 141-20020a810493000000b002d46dfd0bebmr3328830ywe.92.1645029458746;
 Wed, 16 Feb 2022 08:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20220216062615.779778-1-ztong0001@gmail.com> <CAJZ5v0hsDVqZM=iP=4CYhGT99ScQ1xQNYHKcdJHHCscEhXOoCA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hsDVqZM=iP=4CYhGT99ScQ1xQNYHKcdJHHCscEhXOoCA@mail.gmail.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 16 Feb 2022 08:37:28 -0800
Message-ID: <CAA5qM4Bzdctm61jMgkRdKkSqqk7LZqsHUqpn1Loo85eiQUzkxQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: proactively check null ptr to avoid API misuse
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 4:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 16, 2022 at 7:26 AM Tong Zhang <ztong0001@gmail.com> wrote:
> >
> > There are some cases that user use acpi_ns_walk_namespace() without
> > checking acpi_disable flag. When acpi=off is provided in boot cmdline,
> > acpi_gbl_root_node is NULL and calling acpi_ns_walk_namespace() will
> > crash kernel. In order to avoid such misuse, we proactively check null ptr
> > and return an error when we know ACPI is disabled.
>
> The issue should be fixed by this commit in the upstream ACPICA code
> base: https://github.com/acpica/acpica/commit/b1c3656ef4950098e530be68d4b589584f06cddc
>
Thank you Rafael. I've just seen that commit upstream.
