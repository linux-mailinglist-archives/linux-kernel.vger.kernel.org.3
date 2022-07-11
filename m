Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3125701B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiGKMIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiGKMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:08:35 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CA51AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:08:31 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e69so8364819ybh.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Om2IrQfwCrPo0MA8/pPxysfzEs3CSkoYWwAPxfYhOy0=;
        b=bpngKpW1cpJzuExDn73o9dXJWjMhC065/MNqX7+1rTYeKgmQEsfy3KL+pLh+iQ6hlq
         fX9hyJKwMApG8XGmdcTeKoVWyFYU3XuvMcoGyBkv0HypeJ0jfAsVp8giTyEn4eX/X0zs
         +wCpviCB/3KqunIAxvKR/EUNBmXeTKX7xgn8wotAdtsquR1I66axptZysGtqmmRkI81/
         9lCXU3JgaNxX2V0prGE1BLeycAEMjE1s35Ci3928TKwlWc5WZ/uQgOPolLpcPicqaPKr
         N2Xj/U0iqID17uUz/xS7yPs1clMdyArW50MNFGknEJAsyJ+OB8MgxabX2VO1/o5LpOdF
         UFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Om2IrQfwCrPo0MA8/pPxysfzEs3CSkoYWwAPxfYhOy0=;
        b=H+K10Am/eZlEJ9o+0edCXIn4RQpzyXTvvDXUA9rSMY1guJ87hTEebKDLnHwe+xReop
         0N0n3n03yybVfsiSlqL5tPRjh7WyMj0brlF8eHhZgY5+fk5YMLZiJRzLIJnhFZUX26rC
         agu0uJVMboqrmpd8LOlDuRHyjXCe7v3WsFMg1iSIOADsZl2IdH5wgH1UzvPJpj3SiOHl
         OsVW8G3QYh067ckp+hkJBfN3xUiX3vEyzA8uYh8fJ5JASHt6mOHHbYNs4eHX4Lgsts4l
         DAcLQ2zq4WwebsdiTrFo7ddESDqaBgvjvJnnwjD7si8roR30iR56zPMjJinR2uNSA6fb
         d6OQ==
X-Gm-Message-State: AJIora9iDK4S7q1NXbsYWBPw6K8VqamAuxYcyWtUGbn5JGMmk9YcgAGS
        iS6HBsAnXk9sksaehYqIVilBfcvhq8d7NkIhVdq5YqOQR4A=
X-Google-Smtp-Source: AGRyM1uldZ7mscnM9yjMgQRRAkgMfsy29eTNxFaZYpnUZZVT4BQtbiMleio3HxQvnWhm3kGB0DQPI6GM8LHvL8yVOrs=
X-Received: by 2002:a25:38e:0:b0:66f:5224:2c71 with SMTP id
 136-20020a25038e000000b0066f52242c71mr1844120ybd.295.1657541310547; Mon, 11
 Jul 2022 05:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220629115840.16241-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220629115840.16241-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 14:08:19 +0200
Message-ID: <CACRpkdZ9qAkjgWDf9nm=_csOTWQ90V_Gto4uGjRoshrnSNWNSw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: core: Use device_match_of_node() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 1:58 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Instead of open coding, use device_match_of_node() helper.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij
