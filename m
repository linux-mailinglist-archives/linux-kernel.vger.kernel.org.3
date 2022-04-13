Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF84FF335
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiDMJS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiDMJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:18:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523C6527D8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:16:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q3so1035371wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmMHfNDqmWT+IUeU6nTPulhYOt9dlaLf/6nhn3P9z6c=;
        b=LgMS1ytDnor9k2mSXVtTWfOejXMB+j6RFAIVanxvx0waSAmqKstgr9lVf5HzxOsu9T
         R4sx/1uwCbYAbZJAmApJTSULweWSmsDNKoW22KB79k2QfqE7choXkusPNPBoVil6PKeo
         bsv/pQGuX8i6083seX2d3VLgN1i7HTrNchOVsi8U2QXySCAEosVDIZvfCALg59Grx97j
         XyyUpYkod4ikUIT8tV5HhrwzAKMZ/ea/Krez0uVqFWZMyofYw+h2AaerqTRfn+36Cmy0
         qWdTHvOW7fzZZP2/C3dAjsZphdnLj729lYmJSJ6+mBJa/A/rxUPzIY/Y3KhyT9Fkerru
         lNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmMHfNDqmWT+IUeU6nTPulhYOt9dlaLf/6nhn3P9z6c=;
        b=aoz+gBbIHcR5LIZOqxQWPw6rUnGIlvSubNNSSpXhWKJRy9/M0V6yoUGfxJl6RowQGq
         EvgTjw/JkVL6wqJjnx0YmVyIavz50faK9bSkijrgOa7x9dZY+lEyzIrbq3nCaP07ptgq
         eaN5gB7CXJ9/ikgm+4mdRUvs9dLlDtaUBvVv30phrLGABu0L1Lx8r/qCqaTVTFjRZyHM
         L9Kdc/MpRm4r8SHPB0DmNmHAKGekYDSzAGmg4IVFvIIStQPeDn/I1SwKi+hqBt8OxZS8
         D1PshOOfJjGeu+Rdr2xCO5myNrJbhijf+1Vm3q1TbzDMB3dpmdnCwQQZd962NPCrId7r
         UaXw==
X-Gm-Message-State: AOAM533tjfTnXCqHq9xzL4NPlD9Cb/Vf2ZU7MmiuA2ecE3vXSxYnJl44
        kc8q1YrEDDVIgC9ULe2mWPTOGUd1KZ9UDyk47aRnSw==
X-Google-Smtp-Source: ABdhPJzC3sTpBpTVMWT+mrZgW9ofHkoe/zoI1cA0bUmokNa8xravvdpAg7mnBB+ymNOU41wbh1ge+VLELh6KDSmZIuI=
X-Received: by 2002:a05:6000:18e:b0:207:a221:302c with SMTP id
 p14-20020a056000018e00b00207a221302cmr14352522wrx.120.1649841393835; Wed, 13
 Apr 2022 02:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-12-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-12-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:16:22 +0200
Message-ID: <CAAeLtUDytpsYOcV1B1co6ufM_y7JdwrAZcN1HS9=ATyUiCmyZQ@mail.gmail.com>
Subject: Re: [PATCH v9 11/12] riscv: don't use global static vars to store
 alternative data
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

On Wed, 13 Apr 2022 at 05:05, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Right now the code uses a global struct to store vendor-ids
> and another global variable to store the vendor-patch-function.
>
> There exist specific cases where we'll need to patch the kernel
> at an even earlier stage, where trying to write to a static
> variable might actually result in hangs.
>
> Also collecting the vendor-information consists of 3 sbi-ecalls
> (or csr-reads) which is pretty negligible in the context of
> booting a kernel.
>
> So rework the code to not rely on static variables and instead
> collect the vendor-information when a round of alternatives is
> to be applied.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
