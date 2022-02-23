Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26EB4C1E23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbiBWWBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbiBWWA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:00:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A8150444
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:00:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w3so252435edu.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOdtQsD1VsQRojjC27x081SoEhZfQtYMFcPxugWRn94=;
        b=36vJxHpt8n+pnNjNnZkCtrfZT/CZanJZXF9/Jq8zXIxvPFQyTpfdIHIJH8KTVpg7GL
         QWM6UIz/3bP4hCA9w7mcaE/SHD1x8hQSlc2eXWV7O2JKNfJN75ZSz1h8pnFN8NL4Z5hw
         KC1r0pBjdXQ6ARO9BSaa7FhxtjstcBQRCeihR5VHRZbZLlTa4xTYBvj9X6de0dFKZRu1
         s0aIYry/ZocYJpUEz4OhlY+HsbbyKjgI6x2RgaUAfRo20UZIFCiSAEspNEJeS8mP0SCN
         BkfPx2aw1oGLa3WWS+OTvfppB8n8ok3OSRbK51LTAlPDIVPS512lGenbPJP1jbC7JTkY
         j31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOdtQsD1VsQRojjC27x081SoEhZfQtYMFcPxugWRn94=;
        b=wJxC0FpawC63bGZZ61qwaa2Oc2Qj/e6NLB5M0F2vusjU6E/8waKiZwksDjIjnNNslH
         XcGzF0K8U48b7olvD8+1zQlRrjWiFIhwZLi+Pz8RCFmZcX/cwV98PlunotAAopBuZod9
         CtbE5NrkR3Xdy6aTEz/c5D/UvvjPFAU+bDHCnMZVAhxZc3UEC98Yla6xLHvPj2WM03SU
         tjLis1n7sxyBduUndVOOB4v4nGYDo8HlmOUiOYHOSGFEKKgQQsXAF681XIMqxRYzhQGj
         AKlQenLTJNnNel4w4G4IoudTuQWSToKc8j4X0fjQHYdvZPejtcHJmHd6xKL9USPKGq+R
         gKCg==
X-Gm-Message-State: AOAM530BuJt2CWDhUflosIHhTRCTI9n0PaxrnS6pNPkqEeunih7HCEff
        Te09rbBqCMS2nWxR2A8IxCDi1h7oSd6c46W8ZtGF
X-Google-Smtp-Source: ABdhPJwfmB6Igz1Z9f82vs7ZVbG8wjYDxVt4LbgmfSfHq1nXgYaOflqB3eguwEyY19K4vR5EIJTm2pGbkn8jyFuxXPk=
X-Received: by 2002:a50:e004:0:b0:410:a39b:e30c with SMTP id
 e4-20020a50e004000000b00410a39be30cmr1340620edl.198.1645653626873; Wed, 23
 Feb 2022 14:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20220223094109.192510-1-cuigaosheng1@huawei.com>
In-Reply-To: <20220223094109.192510-1-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Feb 2022 17:00:15 -0500
Message-ID: <CAHC9VhQhMG0YFYUQvn=2tYab-UwVjOWxAK9h-DA9=GCvzhRAHg@mail.gmail.com>
Subject: Re: [PATCH -next] audit: only print records that will be dropped via printk()
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
        xiujianfeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 4:41 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> When an admin enables audit at early boot via the "audit=1" kernel
> command line, netlink send errors seen will cause the audit subsystem
> to drop some records or return records to the queue. And all records
> will be printed via printk() in the kauditd_hold_skb(), but actually
> only the records that will be dropped need to be printed via printk().
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/audit.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

When records are moved to the hold queue the system is in a bad state
so printing the record via printk() regardless of if the record is
able to be successfully queued or dropped is important.  If this is
happening frequently on your system, this is likely a sign your system
is misconfigured.

-- 
paul-moore.com
