Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8C4FF2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiDMJKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbiDMJKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:10:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA574D26A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:07:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id x3so635351wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+w+TtMxvv3nKTGIfsbKoASKEHBzjXiu+DU3lDjZKyw=;
        b=aNCHq15QDaD89o7nVZeY9MurmjKfqtiGJEXZfbfO63x8D5id0i92mVcvuTCuWdSC5S
         Rho/gfQfwWj0HPpNTNVTQJNCH3CZyFT+h/Z+UyhZ4vF3guqVdCWzF3xChxrz/X6ysA7m
         585fn/NMR3FLP/+FD8Jrn8XMBByJiMRP5mnUlgf6dxzOjzrnNSWAA9am/GGJYhpmJ//x
         l6RlZ+QBfpOp4jn28dvkxHg2LHKF/zm+V8ooymEe80uSvuWKmW4X/qm1z1nlu5jYySUU
         Zju2s6X+IZMVLX069dSJQbsHIAvRWR2Hx60YSjz9p66zma4iLXiBUPEHm6M/vXykn867
         bUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+w+TtMxvv3nKTGIfsbKoASKEHBzjXiu+DU3lDjZKyw=;
        b=R2vZvnZXygvF0oH2KY/yzDsy/W91D4F14smUT6ifehG6SBel2B4Pmw1HpExYkDkgAz
         NJzMnZQbw9zMXawVBPaAyLr0zsBmmaxmlsoDFf/G4cPgNN3VWt7Nj8XFqQb0mLT7QxfV
         fzBxfT5ryUcNOo5BH0DPOZkNb/NMBcQgTdCwit272CrlGoCU/u+sfGgigHdo5yqNRLw4
         o8Fl1dnn4q17CpFemIZ+IDZ9nGqtYElrj3hoG0xQ3W9ZreK3aMjrHTQ/mETVf9c66PXa
         QO2idi4jIX+Z2qVqW4GVePe7SZMFwEuzK7ORJpmGeNq1daT1I12voq86ciaMSJI1R69Q
         1nCQ==
X-Gm-Message-State: AOAM533+2W5+ZQW8sNnE36yzdMs6/22/bUdstzUR3FhXoh3PoEkUqsLW
        40eXuVoNXVxOMSq/sCKgnqKwcaeu40wssd7jBR3ZnA==
X-Google-Smtp-Source: ABdhPJw8ko1FICi2ay6XTVS5LEnfXs5l3CxjK3vAdnQU4/nd5dvTqqqiOB2+3p7m2t3t14PYG58aOewTQWcU4+goHHY=
X-Received: by 2002:a05:600c:1c9c:b0:38e:3270:373d with SMTP id
 k28-20020a05600c1c9c00b0038e3270373dmr7623569wms.199.1649840874909; Wed, 13
 Apr 2022 02:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-4-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-4-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:07:43 +0200
Message-ID: <CAAeLtUC-RCtaT5fUOhT55uF8TeEV+RzYyqv2_JXBfgPYG_Z9Gw@mail.gmail.com>
Subject: Re: [PATCH v9 03/12] riscv: implement module alternatives
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com
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

On Wed, 13 Apr 2022 at 05:03, Heiko Stuebner <heiko@sntech.de> wrote:
>
> This allows alternatives to also be applied when loading modules
> and follows the implementation of other architectures (e.g. arm64).
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
