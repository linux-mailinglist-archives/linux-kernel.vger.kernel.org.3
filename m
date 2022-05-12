Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4205247ED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351484AbiELIf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345724AbiELIfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:35:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6585222408
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:35:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s11so1557099edy.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asbradbury-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6JtWs7RSdHsbfSTu16o6pg57zg9dX7Xy00LanH4+FX4=;
        b=Ma1lHg5+GZH75MgULlpr4+OUxpjkeEIbQuI3J2nDp8o/kS4DMTBXnkty/iTzwWo9Dl
         GlZ85NV/w7ozfW4aohFlD9z6uc4mgWgXcSP1i5YeedWbYzQKXWl6DHpWVkbKG4ytwzxP
         lGp3PQ7oN8HXQExyjfv93EzwiNIzuK5Wlto/QLPe1skezqrvGEVXlRBHvwAXeWnmLEvl
         fvhPdEtPNF8zOT/PhTzOTb7lqWV/Lkt1BHNIvTJQOPrbU6OXv9vJjXH65LRIE99nt8Ed
         FAzlnA8qgE22csLMKNwdZ/WaYwGX28fly83iX9VXN3D6q0Bh+rThToR2zNd52Y01yoe5
         Kjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6JtWs7RSdHsbfSTu16o6pg57zg9dX7Xy00LanH4+FX4=;
        b=Sga4gfV6R32ZjhKpk8tH/ZihQhRUkd15y3qFz/LNEXoVjQF72aAnbMcA32SBVdV9wl
         wuj4RA8W1lbFCZEZCef7n5IsDsNQZgoNDZp3PvJsWJcLuZCjSrnr+aSud7cqLJX6U+YV
         gzf5AB3zTWtMRGamV3SrIQAtxX3MlPuX5LkUhE3XtiBKzXpQNJPAYrNUZ5fVoZ7aUbTg
         tuaROH0KDyh1uKJ7OQooDxq7fdf0vOyKVlsvEFO7yHW567hjJzSRrSRXs6qaDRpJ1AOw
         NrbQRgPLIGey1zcAIynlmaFl2VxjfzTa/PcBWfMSKz5lHk2uH3lcI4SEoyToop2w7Rls
         PNCg==
X-Gm-Message-State: AOAM533Sqg9uRsTBhWz0tku6Z/YoS8kfbpumM6Eguh26cxrKaCUL4ycr
        dqmXUs7gGVEAn01qPJTFPoEZruGeQSejAlS5ipQ=
X-Google-Smtp-Source: ABdhPJzUl2GY/kpLHLdJh0c6tkuaYvsrzOW0ghgy+sOTLzqb9svlezpZUh21sG2A6M4OKeZOJTIDSQ==
X-Received: by 2002:a05:6402:1d4a:b0:427:b250:ee56 with SMTP id dz10-20020a0564021d4a00b00427b250ee56mr33996171edb.31.1652344521387;
        Thu, 12 May 2022 01:35:21 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id bg25-20020a170906a05900b006f3ef214e5asm1854244ejb.192.2022.05.12.01.35.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 01:35:20 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id c12so5333435edv.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:35:20 -0700 (PDT)
X-Received: by 2002:a05:6402:2932:b0:425:d7b3:e0d1 with SMTP id
 ee50-20020a056402293200b00425d7b3e0d1mr33664329edb.141.1652344520348; Thu, 12
 May 2022 01:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220510065336.hlfjrc25ajed5zj4@M910t> <CAKwvOd=OnJ=ZhsbX+epzbhg3sWg9yOaR=zQ4jF_Deo=B8Nx9Og@mail.gmail.com>
 <10BD31AB-C9F3-45FD-9A4A-EF7DC07C94D5@sifive.com> <20220512083007.gdvlaq7ar2tyarza@M910t>
In-Reply-To: <20220512083007.gdvlaq7ar2tyarza@M910t>
From:   Alex Bradbury <asb@asbradbury.org>
Date:   Thu, 12 May 2022 09:35:03 +0100
X-Gmail-Original-Message-ID: <CA+wH296d8p06E6LU4HUxcGZEf6ZkcUS_oEUY4k_zcC-Y6+-1+Q@mail.gmail.com>
Message-ID: <CA+wH296d8p06E6LU4HUxcGZEf6ZkcUS_oEUY4k_zcC-Y6+-1+Q@mail.gmail.com>
Subject: Re: riscv: llvm-compiler: calling convention violation: temporary
 register $t2 is used to pass the ninth function parameter
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Craig Topper <craig.topper@sifive.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steven Rostedt <rostedt@goodmis.org>, hw.huiwang@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, codegen-riscv@discourse.llvm.org,
        llvmproject@discourse.llvm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 at 09:30, Changbin Du <changbin.du@huawei.com> wrote:
>
> On Wed, May 11, 2022 at 01:07:14PM -0700, Craig Topper wrote:
> > I=E2=80=99m guessing that because the function is static, the calling c=
onvention was changed to fastcall which allows us to ignore the ABI.
> >
> I think so. But the mcount function assumes the ABI is not changed.

It feels like this is a problem that would be encountered on other
architectures with clangbuiltlinux as well, due to dropping the ABI
requirements for local functions. Have you seen something similar
elsewhere Nick?

Best,

Alex
