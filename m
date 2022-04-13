Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1D34FF325
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiDMJRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiDMJRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:17:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0695245B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:14:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i20so1629010wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3wssubFNSH7PhBBCoCTd/2JMEvbfGH2Qx2/SYbOnME=;
        b=nz8vYJU3FhQmjoV7Y8KclGI8GnSjXDec3FDL3g1rX5pofcO/KvkzzyTHQDXGDHYnph
         Ua0QxEZmhNmjNprfDUWQwcy6537deH/arJYaGceRm6jBXL92DcMmVflhOdGCuDDTSBT4
         M2SxpThCS3VmQFUbGJFOvqawKqsT4GBPVDeEQUmX1JZUypCcDKCMCNcB4Ho+3d5fViD1
         s6tbqC8oGDFAROfHZsDTZc+bvH4CFVJuyMm0MDz6X1zq7cG05qExNJtkZn/sHiS9JBjh
         cDZIrYdDzoxJP+8Dj6TxBKIMznMRrYAs1ValFnfuuRJo+BT+bMU38p2DZSQj+4RlJKyh
         IUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3wssubFNSH7PhBBCoCTd/2JMEvbfGH2Qx2/SYbOnME=;
        b=xbR3nFdZWeFJmj9OaoDVX4Bg9b2kC9WKFNQD5Q4qmZ07uOrhyrzP56NgnPlXpooAB4
         Sz/ysTpMV91GMGHv+dmWoeeASCO1IISKpg5cfpxeR0XRmwAVC9gpYOBx6s3aH+mQ3lLK
         cL377Olg4yVKTEgr/5bON6UF1uQRo9Wj49QGo+toJdI2BeRW4d6780TxEyD2CRQ3/Mgc
         FcoadiejcxWulJwOkY50Z3im8rjAFMiqevLO76k8SA6mFRQdrZgpi0qN44IrKeQnNMu3
         N+NWWioTBNhAyCRVasJOXH5/ARU5xtvEBoIwDtEU78DdtXuWPNojUOXeDSCFVKqT6F1W
         0qcQ==
X-Gm-Message-State: AOAM530+eRhR3/JfS6QkgenFkCjDUirmu/whlhkD68qJzhAyfF70LVYh
        znzLngHYsweqDs/U5z+c8fDgk9UbQ70meGcgqHYl4A==
X-Google-Smtp-Source: ABdhPJwa1Z41m1QvtVzrKDmKI/ngC+L9la6nwqhud5QEuhIRlRUZ8acL6wKbDnw3aTqQ55EF4dZSO1sKMY26X6t52tc=
X-Received: by 2002:adf:e84a:0:b0:207:a697:462c with SMTP id
 d10-20020adfe84a000000b00207a697462cmr11108107wrn.312.1649841286170; Wed, 13
 Apr 2022 02:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-11-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-11-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:14:34 +0200
Message-ID: <CAAeLtUDtv+Xh_A1G_cyWEGayrAhY3vQ6WaE09NjJL+vmJc6GLw@mail.gmail.com>
Subject: Re: [PATCH v9 10/12] riscv: remove FIXMAP_PAGE_IO and fall back to
 its default value
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
> If not defined in the arch, FIXMAP_PAGE_IO defaults to PAGE_KERNEL_IO,
> which we defined when adding the svpbmt implementation.
>
> So drop the FIXMAP_PAGE_IO riscv define.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
