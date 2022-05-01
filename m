Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188075161DC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 07:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbiEAFFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 01:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbiEAFFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 01:05:50 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB4611C03
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 22:02:25 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-ed9a75c453so1247080fac.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 22:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0aKCZgVZHwh4Tv70zY74+bpoUv5Mj7mL2pJZ6Uamnh0=;
        b=Ln32ZkW57DHk3aYeYYGzHho7w7JQd5orJTF5/OJ7Q3YlblYmhE67Hvg/CZnF1R54l6
         fKTSg5LO2nFbIE/JhjzNWLZsGUQFiTU5IDe5snREQYmJiU0BRRjbEOtYmXggrLCwMBpn
         cpQTPJPhseMBEFKoZjGFEsdw3sHBvYzmY1q6Vv2VT8aVXbvl9123tIoSXdGuZruI7KbK
         H63Qbk9J3cfS/9s/wxU4Z06WY6FnZXQxx7RxDAVm5UwBib1jl8Yi11aBMfBmYJBqAqnL
         L9zZO6om03JYIK4Rt9Sujy65oQzcn8b2U/O2aoqed94XIOwMusr2Gx/HIJUipGkHeYa4
         xHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0aKCZgVZHwh4Tv70zY74+bpoUv5Mj7mL2pJZ6Uamnh0=;
        b=j+W45T+HGHGkwZo8nnMSmHBxVB0qAkA8kVSf/hNHzApAaO+dQ8tRmr0rf7RwANuQXx
         t9oIit9ji5oI9nlUGhJ5lNUpaFEZ03n0sCYVkYB6Gq0ay0R4l2GsQOn0Sm50WsFzzlb8
         JYBpcxDKrcvfFxfsDf/aJ1exGuDa8fymbSbJX9yljJVVkbqn9pcDIxrylzQdMnuuIarD
         o2NLQceOdDj+TYMjsgzbC1iLUUmqt+Wp6PHhokM4OTe2IWxQB1XYxwksPBPNWg5Cms+4
         IIq3pk31z6KEiEQzj7o3dk1IPa7yeJ8MFu1Q7uUaX5wiPCATA1AAB0Fz4bHaxV9HXNmK
         q+Ig==
X-Gm-Message-State: AOAM532OiKZ1m0jIP637EX3nI/mptkQubj3Y8Off/kkbfUu+/B2m4puI
        GD8kEHg4GnmQ2jZ23SLWnetZrhCVRT3KUcU5auQ=
X-Google-Smtp-Source: ABdhPJxkbSmv7zG4Q6GTSFIGixxeDClKJ/03SoB2VGTC4Uoq/VdDkmPjtpXE3JrrRup2rlDG2eEBsHH5wSkon090EyU=
X-Received: by 2002:a05:6870:c141:b0:e2:9512:de42 with SMTP id
 g1-20020a056870c14100b000e29512de42mr2520243oad.288.1651381345179; Sat, 30
 Apr 2022 22:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220430164021.537668-1-gch981213@gmail.com>
In-Reply-To: <20220430164021.537668-1-gch981213@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sun, 1 May 2022 13:02:13 +0800
Message-ID: <CAJsYDVJ8VFELnWP-OrH9qzQjbrLZKA721+xj_ngjegPE=fAyrA@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: ecc-mtk: add external ecc engine support
To:     linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sun, May 1, 2022 at 12:40 AM Chuanhong Guo <gch981213@gmail.com> wrote:
> [...]
>
> +static const u8 ecc_strength_mt7621[] = { 4 };
> +

Oops. This is a leftover line when I tried to split commits.

-- 
Regards,
Chuanhong Guo
