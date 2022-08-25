Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435E85A0D77
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbiHYKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239879AbiHYKCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:02:39 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6E8A572B;
        Thu, 25 Aug 2022 03:02:38 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r6so5723446qtx.6;
        Thu, 25 Aug 2022 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lKG2VD/CmwRDDUko2A1+Os+gTODnKnEL/4GwwXIlyuE=;
        b=O8Zv7uk/gaGlZoDO5+hS7iDMqlzmVgpEL5Mmf9ux9sxm9kjLKw31ZZs2ayjrGMVaSh
         SfF6aUV7ivAaO07zZs2qq7mGT382S95gIk3AgdPTxwZybpDUW+bAtMr6DYgFk4018ApS
         WB1tnotpDMbA31Oa43PGLT1MAEJt1Om55sZk3PB78HH1hQvgB1CxJACe9rxmPUVPFqKD
         /1oa/0aVcOKfdWJ7/W9K7zzAxWd/YPXqOSaWTH8ctyz1z9WNwBWXr57iwDI61dp07AQD
         2UE8Yg5qqG85Utxb9byWu/7FiJhNUYd/3X0y9MJpSn1MwU20C6tv02uftPsxN3Nh01I+
         oZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lKG2VD/CmwRDDUko2A1+Os+gTODnKnEL/4GwwXIlyuE=;
        b=lyJD/dPG3e2ovnDY5rwBW6lpG4DIzA/7cR7b1AkpDtQCJJ0luf50n7Ad1+tp+CqoHv
         10ekaHdp6/gfPqBq4m0olndupUW+QlHGQLSF/PNI215LpIQA9sAg2ymbQldUh01iOyYg
         ZpXCTatn44EPqN2qbMRQ2kzdRkaJUOJ30Mg/JtxPyyWkQEizVakjGXosFpJeJ6p8rAIA
         ZjUVQlkCNkB0uz28+vuWkWUocCIb5Xt/LwlsJm4rVLNHtgb+xcC0drAcKnp/h2Gnt/Kw
         pb+fHVfQzre93K0p7Ew6m+grljTDT7n7vggUp5Iz1Mf7owfW5MZpjskG/6Ut2HT0Fz8P
         3TrA==
X-Gm-Message-State: ACgBeo20H2sVql9ZQ83DfQpD3huv8C3aufGst1ApqP6qmJSOHCixctSJ
        Rn+EO13DxvNa1q6e+WqUIwp78W43HiNU6Tz3ZgkAo/BLC1M=
X-Google-Smtp-Source: AA6agR7QzZ1tQlk8lKFxEFJeIuJJ2TEwubLA2ON3ey1ujxxyR58HJk5zf41k2ui0W4d0rPvles79OmjzkemHW02+NAI=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr2761103qta.429.1661421757998; Thu, 25
 Aug 2022 03:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220816054917.7893-1-patrick.rudolph@9elements.com> <20220816054917.7893-3-patrick.rudolph@9elements.com>
In-Reply-To: <20220816054917.7893-3-patrick.rudolph@9elements.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 13:02:02 +0300
Message-ID: <CAHp75Vde8BFZAtEUYxPE0GeU++9q=CcBEjB_m=-5RgVit9wdLw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: Add Cypress cy8c95x0 support
To:     Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:32 AM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add support for cypress I2C GPIO expanders cy8c9520, cy8c9540 and
> cy8c9560. The GPIO expanders feature a PWM mode, thus add it as
> pinctrl driver.
>
> The chip features multiple drive modes for each pin when configured
> as output and multiple bias settings when configured as input.
>
> Tested all three components and verified that all functionality
> is fully working.

Thanks, I appreciated it!

Since Linus applied this, I will work on it instead of reviewing.
Because it will be faster and more productive (and we do not have many
weeks left in this cycle).

-- 
With Best Regards,
Andy Shevchenko
