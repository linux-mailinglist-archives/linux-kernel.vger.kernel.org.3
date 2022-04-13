Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A4B4FF305
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiDMJLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiDMJLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:11:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCA7FC3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i20so1609329wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2RfiU2yQ6Q5lZlNdTxAqM838LrNlHbSns2UR/xnZyg=;
        b=Bv9hcFImSBg1Wy9cSJnbpSHCywcPKdXI4iis2Lx7CwApVkjO4RXQVhuhKO8Vm5Yv2D
         0ziSbEulKjoblVYKI4v00wh69NZC4DAkXpL+oizYx61S3MRO6TmfUCfDpg/p4DbJB1Cz
         n3xK6ap0qp/GdBPdhznXce1Lkba/bQOSfLPQeS15qf0aYBgu6zz80qCoYI8St/DhjbM5
         hXZawCoOCGnMyoivcSIGTbHcrQsPAwbslEIZaQj2CTmm/UG2/gQtl2/aYFo8Oti43GVX
         HgkgDF9HtPhMRUvZHFnDSfonwNp4GXhEjUaSMwsEfrxBEnKMB5h3fvzRqnJ9Ks0K6Yrt
         0ypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2RfiU2yQ6Q5lZlNdTxAqM838LrNlHbSns2UR/xnZyg=;
        b=WzyVHFMpmUoJZSYmOerV77uTMzqUG/LJpiLaGyC2HoPft26lu5nPu/ApdHJslmCTI/
         NPl6YAPV1t99Nl1TUXoPZ+3v7Y1Gb7j0GkGd5WW1LUhKTltSSBOTQ58VfNIW9rSwlGHQ
         wP3MFWbjjoNtuSnSHyNhQKeJe6JTqbDez0Xig0A5NykRTLtqoE0nbPmwiB2yujZMtCLS
         mQHZSsqGFCCWTeeTNBzR7b56xL7SynVqq3Lz65vpwTlhW8qMnd7xTZTeHMae3fDNZ/T6
         IfsIoM6LU5XR84OByIga5jYrk2RzcUQiggrTmoEWKn9TjPbldzJo+TyDzv/smgdl1xHO
         nFuQ==
X-Gm-Message-State: AOAM5325UCmIFnpDd2OHeApCOdBaugOomx24OpG8MolivUvS+63QcUAU
        IXnRObadRe3kDSHWgX825RSgpeVorA5Kq6BxXE/IPw==
X-Google-Smtp-Source: ABdhPJzJWfeDgw9z8zOfbk5VeVHE1qpmguwgSezKzsXwCVMGKLhcOhgFUMawAcm9xUFFN0C4OvgnSkf7iyasGSnP80M=
X-Received: by 2002:adf:de81:0:b0:207:a65c:d895 with SMTP id
 w1-20020adfde81000000b00207a65cd895mr11352594wrl.647.1649840959334; Wed, 13
 Apr 2022 02:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-7-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-7-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:09:07 +0200
Message-ID: <CAAeLtUCTpfnVM_e4vgYwpBDjbN24Vj-iZY8Nne6qLNTy9UeAEA@mail.gmail.com>
Subject: Re: [PATCH v9 06/12] riscv: prevent compressed instructions in alternatives
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
> Instructions are opportunistically compressed by the RISC-V assembler
> when possible, but in alternatives-blocks both the old and new content
> need to be the same size, so having the toolchain do somewhat random
> optimizations will cause strange side-effects like
> "attempt to move .org backwards" compile-time errors.
>
> Already a simple "and" used in alternatives assembly will cause these
> mismatched code sizes.
>
> So prevent compressed instructions to be generated in alternatives-
> code and use option-push and -pop to only limit this to the relevant
> code blocks
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
