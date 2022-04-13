Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FAE4FEE67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiDMFKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDMFKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:10:08 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9922C3DDCC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:07:44 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso495259otj.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6wkFRWELvsWb3/zmRGR+hVLRqoZs+C5DWbC/pH40T+c=;
        b=ddebltwDJ4OBZiB316V4l/Sft48li0+vcOSQqUlpq0VN+Spu2CTs8ctEiuijCr7aQT
         FG95zd8jZE/76mVDfeCD9HQYCwgVkSFL/jf9/9SDxVGa23EKxRJKZx15yfQMEwE0Rvmm
         IvqZWI7D7fUj9i1dK1WdDGwzqvPFODOO5sM8sSeASZu4LW5deq+VGJvjjRvkzHyZEv0H
         xb7oIOgn5/Za7RnQ5zu8nH28rLtWE78X0vAsq48JUnGFj6Iw9CB2Fd7XwnNOtTmHhFAu
         CrKFENCBl7JgPiGUvjQy9Wv2yXBCXYrfe+EMaG43hukD71DdfDGAmhdPqvYNu+K0Ax6n
         rxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wkFRWELvsWb3/zmRGR+hVLRqoZs+C5DWbC/pH40T+c=;
        b=ewlLnECNkgoiGVO3oYk5+wfCcXwgXAQBk2oaERAQPWpzA1LZ91E6aelfSrdk1NvQ1Z
         xA+dKceCjKBoZnCHViwrzoAuw+EMNVYlooAzXFJcgw0Pq9bn3X4Hef6GJ9HjePuh/xdT
         VxiEjHrz5PthxuosH50INiw9PFZeVLjHf1baQa82hYD6yTVPW4hVKDPTT/r1WpZs/e21
         s/JaisIardhcW5YI+B39b7oX/oojgdrQ+grHARAbDMvyoAVYDs/2Nv77DM1Y/yWxnAqa
         ugKZpMNcxEC5TAJcRFUyd7OrGE4bWZfO2jwZVEghkricjk1UTc97wtg/y63bGk1cHbOC
         YDYA==
X-Gm-Message-State: AOAM533fr2aDUQeaP9mxd12vEbMfh3QuFMoEFOqIjBcNtlS5ZPEOHHBX
        RRWE87CCCEhqCQVYNgQT2f4xIJymfsywR3UxVss=
X-Google-Smtp-Source: ABdhPJwavmFyzQCJbFIxY6NjHt5CGoqBUtKzP1PX1uyMqOI905uTazSCflgqb1/xaMUdxJkG5dd31pX42gbSnEOrf+Y=
X-Received: by 2002:a05:6830:2b0d:b0:5cd:aca2:f3f2 with SMTP id
 l13-20020a0568302b0d00b005cdaca2f3f2mr14329027otv.212.1649826463891; Tue, 12
 Apr 2022 22:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220413042337.160263-1-gch981213@gmail.com>
In-Reply-To: <20220413042337.160263-1-gch981213@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 13 Apr 2022 13:07:32 +0800
Message-ID: <CAJsYDV++V0HCNqM-GnpBBwDjwBSfgw8ZO56wDwD3iMPJ4joSvg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spinand: add support for ESMT F50x1G41LB
To:     linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Daniel Palmer <daniel@0x0f.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, Apr 13, 2022 at 12:23 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> This patch adds support for ESMT F50L1G41LB and F50D1G41LB.
> It seems that ESMT likes to use random JEDEC ID from other vendors.
> Their 1G chips uses 0xc8 from GigaDevice and 2G/4G chips uses 0x2c from
> Micron. For this reason, the ESMT entry is named esmt_c8 with explicit
> JEDEC ID in variable name.
>
> Datasheets:
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50L1G41LB(2M).pdf
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50D1G41LB(2M).pdf
>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> [...]
> +static const struct spinand_info esmt_c8_spinand_table[] = {
> +       SPINAND_INFO("F50L1G41LB",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
> +                               0x7f, 0x7f),

This patch is broken. SPI NAND core doesn't support 5-byte ID atm.

-- 
Regards,
Chuanhong Guo
