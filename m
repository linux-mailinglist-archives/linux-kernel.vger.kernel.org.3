Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83E58EF17
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiHJPOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiHJPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:14:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E176969
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:14:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y13so28216968ejp.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=a7p2Aw6uqyxGssz8N+URjITzJ9u83rNDpdd6+DwVix0=;
        b=c7ogfFCYk7LHsN7fWjkFNGKWDOb3QEPWn3xYbvLXkLsXTvXWay55qJITaojRTU/15Y
         ae3X470ITVyVB5ZmVwbAkMxPzgRxfaL90Ws/zfABUa1fnLJmHHVb6y+XydkHyh3s8LmM
         DXjVOFKEdJxEwd5t54RZRcaG8kSx0OEz47p/S4F+YC2yBG8e+0+jkAbYZpLdX9xsmdWe
         w66cFE/zVP7I/5/jcOPPaBX6eI13hxAXB95WNNwu5sLPuQymu0VZ9KMZpzbSqkF415+1
         B/4mhJq41/eY5QdM26ZNOEtL7DAbBH1O5Z/Y4DE/5bp5TxtC1JdnZnGJ/u1LfnLhjrkr
         5TQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=a7p2Aw6uqyxGssz8N+URjITzJ9u83rNDpdd6+DwVix0=;
        b=s5dJ1Vk5soNKtL6H1+HSpUiOm7lfg/KVeU06uOSELyQdNFlvjrmuAG59nPsRhxLdNY
         BLr0w1KQdIdOwvqMCmnhCzJhMXrPvZQHyYr+xr2WA+dUA7dgoGolcsnXHkUb+fzscXQN
         MMgaKqrahmnZaUl8m3lNQvd+FfK9ZE3GXGuYwHMFUC3wO1efmBSzwY5JIWp9eyIpULv2
         1q70oq36VBCvcoUZPO65VBDQO0SogPVlFStUMcPLkQHm+A9fpJRTaUaAyv1qCodjDKlr
         H1XbGIGkVTg0fSqwjgYwBKUnWb3WlqTXVYmtTPbiBQAvpl05DbpryZhSX481yU6TwnLB
         B9hA==
X-Gm-Message-State: ACgBeo3GPVZi35ZBAAjYvNKTECTy0gRslmNM8c8CFnjxmbOSqNGA+ZCc
        HQr9mu6WVceFgxTLCuWykhwm+IMQgF1RXUlVNOcWLoGRvpsgNw==
X-Google-Smtp-Source: AA6agR7y9hhKnZINQP71Ks1DUUklmiwHLYS0noEA84FATWHb2VED65vVJB3AjkDqkfcSTFrDPU+aNJoQXrUrRKkCLUU=
X-Received: by 2002:a17:906:ae95:b0:730:7c7d:3868 with SMTP id
 md21-20020a170906ae9500b007307c7d3868mr19938951ejb.564.1660144460733; Wed, 10
 Aug 2022 08:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220809201428.118523-1-sudip.mukherjee@sifive.com>
 <20220809201428.118523-3-sudip.mukherjee@sifive.com> <361fa56d-617c-ee92-151e-5d8fe0a29e53@microchip.com>
In-Reply-To: <361fa56d-617c-ee92-151e-5d8fe0a29e53@microchip.com>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Wed, 10 Aug 2022 16:14:09 +0100
Message-ID: <CAHyZL-dgrGu3z4ySy_EdG7KdZwU+DHdo8nH=+Go_nGZUZYFq_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: add SFDP fixups for Quad Page Program
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 10, 2022 at 9:06 AM <Tudor.Ambarus@microchip.com> wrote:
>
> On 8/9/22 23:14, Sudip Mukherjee wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > SFDP table of some flash chips do not advertise support of Quad Input
> > Page Program even though it has support. Use fixup flags and add hardware
> > cap for these chips.
> >

<snip>

> > @@ -520,6 +521,7 @@ struct flash_info {
> >         u8 fixup_flags;
> >  #define SPI_NOR_4B_OPCODES             BIT(0)
> >  #define SPI_NOR_IO_MODE_EN_VOLATILE    BIT(1)
> > +#define SPI_NOR_QUAD_PP                        BIT(2)
>
> No, as I previously said, SPI_NOR_QUAD_PP should be declared as a
> info->flags, not as info->fixup_flags.

Sorry, I was confused as info->fixup_flags says "it indicates support
that can be discovered via SFDP ideally, but can not be discovered
for this particular flash because the SFDP table that indicates this
support is not defined by the flash."

--
Regards
Sudip
