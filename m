Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B379A527AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 01:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiEOXfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 19:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiEOXfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 19:35:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286A02AC5B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 16:35:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j24so3083726wrb.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 16:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPiN/r7HiMX+E0gD/NyxlaBSFfT8UOFIF8dQ5IYINeA=;
        b=DOSui03D88ZpB/o1amMdo7Bkew8vnXHYL2X4D4OL/XUpCP8eVTH3zro7V07Rp3Tr9o
         uDZCkusHAGtnreWzbgOZWyoOy7NVCp7pH3k9zKaq5NRy5GiKDrf1Gq6da03wg+vYb+vm
         gg4tBMzexInFqZOm4f+CJuK7+ksj3v960+ao7kV35ZihLf8UOfEMYUzCQF9++hS2fNiB
         xo0OcJhIYFUaVIAxxlvbc6JIkUBl3qUtDUfUrT+1zGzz0zrBBHzAETjfxln0ptXeXzT/
         GeZUaCjdZBzdNR13DGP2hVb88Z1TkttdvB+Z++/rXRMiY6COkux8ZGSNXv2uGCuNGfd4
         BP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPiN/r7HiMX+E0gD/NyxlaBSFfT8UOFIF8dQ5IYINeA=;
        b=Il4Gj3CMiH0DB1SUP1RgMklNlp3jO0z9zbibdtG62hw4Jf6g8x0M3fqDjD6J83dW2b
         FixLfh/07gs4+hITCRWrnBP3eJX81MqY+z1kKlJi7yAsra1PcbrAqS/khvejUZACm5eh
         3XqVnOpqlEhwjBV9lX7sxiCgx48DQH88SiusoYqTah4kGK4aRbe7csHmxu3nbAXJs9zg
         1v7FND3nn34pr/BXVvC8nURvK98yTaN9fNTguyBGKGteyvOw08xuXhzP15f1LXLssxmS
         jvGaJMaUEEv6/oRhpCxy2+vCCpuIXDtZCIEGAKpJd9CPIamhPzoQ4/nIy95xmFklfJvS
         FwBw==
X-Gm-Message-State: AOAM5331sMto1Y5xWyOYE+dcavdNYsxaVcjfSyxofSMLp2yTgCBDFqvH
        +GcJ5PO8cZHFpNPNTRfueMElww/FgoKh7PVvGv1O
X-Google-Smtp-Source: ABdhPJxuYOOfU0Ks/SZbo/L2GWmDeH/U2y3e+Vl13QVKGqg8UoL28NaONP7pLHcz79RXHTJa0UlxQNvVNgpNF01Dod4=
X-Received: by 2002:a5d:52ce:0:b0:20c:e030:b05a with SMTP id
 r14-20020a5d52ce000000b0020ce030b05amr11743818wrv.174.1652657727735; Sun, 15
 May 2022 16:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220515073110.304193-1-sshedi@vmware.com>
In-Reply-To: <20220515073110.304193-1-sshedi@vmware.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 15 May 2022 19:35:16 -0400
Message-ID: <CAHC9VhQge7uUSwbDUkA9=VCY0dL+UDUjBRT7aSMEEVGU6jQqLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: remove redundant data_len check
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     eparis@redhat.com, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Shreenidhi Shedi <sshedi@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 3:31 AM Shreenidhi Shedi <yesshedi@gmail.com> wrote:
>
> data_len is already getting checked if it's less than 2 earlier in this
> function.
>
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, this patch looks okay, but since we are already at v5.18-rc7
this patch will have to wait until after the upcoming merge window as
it isn't a critical bug fix.

-- 
paul-moore.com
