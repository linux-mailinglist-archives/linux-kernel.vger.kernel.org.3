Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B0C4B1A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbiBKAmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:42:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346442AbiBKAmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:42:14 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D05F87
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:42:14 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id bt13so20470119ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvA/9wughT6Lyon0GBTYvA8nAc9rTAjUMYk82Ep+CkY=;
        b=BwIb6t0+jLIf2FTYizV5fDdIjwQl4Doa6z03s3OOjT/K2kwBOQ94CD0xDdQuRH3R0s
         PFa44cKNHcluUhfRD9EtywNKDgHwpQnrIGX6o1H49Cj/D9zpyON+1jJuzCct3teWYPY5
         YbNG7HLrDPGUciVE7b26cUREiLt0hGzYvkWQugAABdnzcqPRox3nY6awT3FZGi9VEZ1D
         jAAFQIDEWeeV1Zs3IknKKGLp3ClSynLBTw9GEARUPCMfxTTwW6Cr/2qNrzLt+4Tj4Uym
         g+U6mhs0GsqOkVVCSY3hE1DgEC9pdecTqCqcgBPmpG9CxS4YX4Tc4cuNYgBq9M8IMa5y
         DD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvA/9wughT6Lyon0GBTYvA8nAc9rTAjUMYk82Ep+CkY=;
        b=adh3wZn5s692/gMPHlgr7o0ES6tT06MjUGop6q2XkqbePek7ZZLAUau7cus0nFFMl2
         X6DMWL8Gyx7UteasnFVUj9igIQVWQqZFOJ2TAdzGb7u6WUY6Uk+LbqlimNkeX1JdLyfa
         mxzAt0+XcuItnA/fv3CLDIGKgod7vY61IHF240G4jWcXkQsRZQoX/po5DUITjxx/Fill
         wPWM7gca5pJseSP5ZSMNbf+qBOxpVZDWfuX+MgXJsh9WNB95KBWwfz641XvbYCwJP1Jm
         UHwuHf3LoPWhjXiOaDxrhMp+KoDC+n0H0Di1NgdxIPV+VuW9tvosuhKBFfaQQ6fRQjdw
         u7vQ==
X-Gm-Message-State: AOAM531Hjyj6iD5PO9kd2FQ4CxVb9dBN3YNa/wa/hCgwGCFPBHrYo9dm
        qF+4EkrY3GynzB9Z/Xd/HKg13Hqo7ZCXFa2rV3+mgg==
X-Google-Smtp-Source: ABdhPJyQtHuSZe9d+F1eReCcOh9vckw2Q0NUeA7YAnISwTitUUUgxK5gjCkhZseemwLjXSu4L5ZVtPKxp0C4vkuQL+I=
X-Received: by 2002:a81:4402:: with SMTP id r2mr10176647ywa.126.1644540133572;
 Thu, 10 Feb 2022 16:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20220201120310.878267-1-maz@kernel.org> <20220201120310.878267-11-maz@kernel.org>
In-Reply-To: <20220201120310.878267-11-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 01:42:02 +0100
Message-ID: <CACRpkdacLL-hv-upsfzq+fJNv1nvLagY78igXo6XnU7rJkYYBA@mail.gmail.com>
Subject: Re: [PATCH 10/12] pinctrl: npcm: Fix broken references to chip->parent_device
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 1:21 PM Marc Zyngier <maz@kernel.org> wrote:

> The npcm driver has a bunch of references to the irq_chip parent_device
> field, but never sets it.
>
> Fix it by fishing that reference from somewhere else, but it is
> obvious that these debug statements were never used. Also remove
> an unused field in a local data structure.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
