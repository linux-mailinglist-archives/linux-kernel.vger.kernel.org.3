Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7334FF30C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiDMJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiDMJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752EB186C2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so767774wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwwGHu/kUMtzWbNVENzqf/cbed0N54Cas9skXOt024o=;
        b=XPnqVjG6h0UqhmNIPxikuceAuDekilIJ8T7vPpT4es4yah+70QMaFq1ZJgjKjC0ysb
         /OOCXveVq7AxK8PP3+X9/cJWZSEhjvknXaHwbtZWvECzXTwhiz8RvRR9n9gJ8JKJq0ij
         Ec4lCA0rRcVHxI2+LlU9084ORpwvoSfBzhz+dC/h5+ytDlWeihmcpiEA8WjcO63Uc7LX
         MQULtqO6+f51msdsVyPA9QpbR8k+PVyG5EPW48DOs6jbZTNSM060mNbJNLi8pJ9f4z5q
         8KuSwphoN8QK5WZFEYW3bK62hb9rf7Mdg/7gJPj6I5/4xN7hrNKKNgl7C5cyUuj4hTPS
         B3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwwGHu/kUMtzWbNVENzqf/cbed0N54Cas9skXOt024o=;
        b=HkqRHSDgSX/SZebAKRwzMn1b/9wv3vGwSHab1lAj1HJ+Xg/91hdlVcFy2mRCW/ARFC
         34iATlqnXQ6cjtBjO48pM3VfwLCNoEksAf5aynhyCYBognf37J3XUSXOwsuRT+4/7E4W
         6gdGjlu7I+4kiseA5FRuUv8jDT+c6MAs5SnwULOgH0Mcs6AeHxNAY+CrLlkr9olVA6hF
         I4F9WzNYDTpeD0+XK2sJQbBW9Uz+WasDE4voXGrn/W0qG/vOYhOLXEp9hDkBMBTH4NFp
         deaBtpQtn+EfnhrEWyyWvFJlQxsR52vOWs0QQPpE6h4+hsOUig9HCyHOkG8Fn2wvjgIx
         mmGQ==
X-Gm-Message-State: AOAM533xclljCi0JWPEu1xUwNYMqMDBA1BnQ7zDgET5qFCbgKEUETpL5
        It630Bn9vWqhggYp1XCVjRAvvbCmzD1O1MRk00cgMA==
X-Google-Smtp-Source: ABdhPJxxa6HPTIn07pYdJ/EeVtDrpC/qaoIRKLB3HdORWATBXFu5XeDq8MFROb7IVg/gNg3daadJJezwX0cOlwNnhsM=
X-Received: by 2002:a05:600c:35d4:b0:38f:6799:a386 with SMTP id
 r20-20020a05600c35d400b0038f6799a386mr664904wmq.196.1649840982912; Wed, 13
 Apr 2022 02:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-9-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-9-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:09:31 +0200
Message-ID: <CAAeLtUDdRTuehHFi576tpzEo0QV9=qQtU8BOarAb4OF-Bizdow@mail.gmail.com>
Subject: Re: [PATCH v9 08/12] riscv: Fix accessing pfn bits in PTEs for
 non-32bit variants
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

On Wed, 13 Apr 2022 at 05:04, Heiko Stuebner <heiko@sntech.de> wrote:
>
> On rv32 the PFN part of PTEs is defined to use bits [xlen-1:10]
> while on rv64 it is defined to use bits [53:10], leaving [63:54]
> as reserved.
>
> With upcoming optional extensions like svpbmt these previously
> reserved bits will get used so simply right-shifting the PTE
> to get the PFN won't be enough.
>
> So introduce a _PAGE_PFN_MASK constant to mask the correct bits
> for both rv32 and rv64 before shifting.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
