Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45171591B03
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 16:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbiHMOdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 10:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiHMOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 10:33:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9F92F010
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 07:33:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a89so4447413edf.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=za38B/WdiKJtfUmwIszIpVR/GOOwQNFkxMaiPO2BEsE=;
        b=SRS5VX4DgFVtp+A0rN1JhpRO941soVLdg90ecmG+XQ0O0Pk71FW0Pnz8yHfIzncjfm
         w9vBr4X/fCJunIlmhImV1SN4JHWF76kgYCXcIiI1d3N9VGZpSUARDumzbJr1NyXQ/y2c
         xl4sdAP3i5O12b6Ip2R/jya5p6xu5xMddi8Pxlw7eq/IEQ6HD+3yv8y+lu+TMSGolZmy
         T1my/uu5mISAvK1SJnfKyo4UErW6OWGA38vCibiC0oR7zQJqP/8REV5No7LCotDsP6w/
         5aNp4dTcnSdt2zTERyY/We+lAkR6JSCN2UFnjtWSoP/0ZZaPfZmJJe4TyS7j9xKwOFfG
         vjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=za38B/WdiKJtfUmwIszIpVR/GOOwQNFkxMaiPO2BEsE=;
        b=uf/Su2dz7J54TMtXXslJRYVZkYWDez7Hy0zKwc45smK8KPEXtDthaO5+WVOZ3YFCEN
         zL0rMU7TAPedVX8Thmx28IkLUntlpHUCq+USICfNl2LCaZKPCicwwDeOhQZBj37fcwkO
         aSez8LVT9SgFAGUpugQDSVI+5PFiQxYkyB4ZSeyUIawPXBf3gLbk1627m18HmDdc72Uw
         cRcLjJepLvThkoyG6PTMwkPVgkkKI3uvxgYRKqFXUsGZw5R/FfpFu3bXflZzHJCVBr89
         r+4DiT9ccnBtdMCRrQ3x9B7+RePLPN+A2vvEGFTcI1rChur8IpuQTzqmF42MczZ/l3H7
         nA4w==
X-Gm-Message-State: ACgBeo3TmM76jxCRtjjjqzxbEYNHEOkNVb2xGJsd0JhLIZBlfPMjOnnx
        oFNyNgUPJ0tVw+ziphVwoWkxO5afxEkhXjaOAA==
X-Google-Smtp-Source: AA6agR7/0O5iWzCnwrOz4bhtktALLvhmcNbjjxALsSbZe0aAZ1sGeKW6/lTWKsM2lcpAxJVv05nSRWz+4CDpDtjIXfY=
X-Received: by 2002:a05:6402:240a:b0:437:d2b6:3dde with SMTP id
 t10-20020a056402240a00b00437d2b63ddemr7723134eda.62.1660401209608; Sat, 13
 Aug 2022 07:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <1660290073-26347-1-git-send-email-kaixuxia@tencent.com> <20220812154841.116570-1-sj@kernel.org>
In-Reply-To: <20220812154841.116570-1-sj@kernel.org>
From:   Kaixu Xia <xiakaixu1987@gmail.com>
Date:   Sat, 13 Aug 2022 22:33:18 +0800
Message-ID: <CAGjdHukHNavhfTB+uff_9F3+VPhzXzP9bPnUV1Mcz4dX7rF87w@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: simplify the parameter passing for region
 split operation
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 11:48 PM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Kaixu,
>
> On Fri, 12 Aug 2022 15:41:13 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > The parameter 'struct damon_target *t' is unnecessary in damon region
> > split operation, so we can remove it.
>
> Good finding.  But, 't' is used while 'ctx' is unused in
> 'damon_split_region_at()' and 'damon_split_regions_of'.  Below code change is
> also removing 'ctx', not 't'.  Could you please update the commit message for
> that?
>
> Also, please fix the kernel test robot reported issues together:
> https://lore.kernel.org/damon/202208121823.8YTRPB1J-lkp@intel.com/
>
>
Thanks. Will fix them in the next version.

> Thanks,
> SJ
>
> [...]
