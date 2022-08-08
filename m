Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDB58C9AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbiHHNoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiHHNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:44:19 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F81121
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:44:18 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id v2so6340321qvs.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Zb//D83w5rUouZtvhpUzjLE3yfU698mDfW845egr+PM=;
        b=CLd8uwlTx4U8OF8Vt3RWjNOH+J92Dx7WzSXMT7EHoCTkfI9AZGQ+w1rN5/HxC08cqJ
         o/qpRDWBd9N/EhRg+tLnoOMavOFqA/fLOK6vYkJB5hBcSt2dqlV5hhbcb4ccRN2hAP1K
         X8tvMKHUFkki68ZBvJJ3aZB5Q6fNH+R+ptqg3y3YCXrhQRS0kbyGCp8sXahVlcUIebHM
         pBGAhcuUjcYCssdFGCoXrN5UCN6c15rbteO46eayhTCiw70Khljlj1Sy8jFTfZIf/W4b
         UfUVzMnndPtnwqRjZZzqLiE71VIA3oFYJaEhq/HcVTVOdv4uXolHI32iy6rFPlS9kOZi
         8XzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Zb//D83w5rUouZtvhpUzjLE3yfU698mDfW845egr+PM=;
        b=1zWwrqD4psCgqSoP5zWW73LsySd2WfAokLqRb1Dc3Z1/cJSGM+DKLZ6eSZk7AmyDAW
         JJAIwX40xmRAtZ40zkwmQrIr+rq4wwPbsWDKYTcu/xjtvsTt735JoPBhreyFzVZ6md/B
         BKUuQObvs7+2B0lC5Hkivy0DviIHEcHpL4aDjxxE36htuB7mM8rdo8kVUK9Fy0ZZHHcP
         lqZZyAsVosPSvnrSjgTkMKglkLyW6RZBQ903c7xYOOeR8Ec7otKGwipaalqNG493P2hK
         jp3uRAE/aPn1ZdoFomnXUk81ILrXRs0IcF7MambPEd4cudpQc/UcBlCuLBOyTz+orDeL
         qTgw==
X-Gm-Message-State: ACgBeo03nKIZc7JvISGTE4HKeTejYQk7FZpQ5fMkifWjvIkwURasHZb+
        Kw+N2AO86AZYxHL2KlBe4TYYkI5CVwy/znI7ruYlWZFEze0=
X-Google-Smtp-Source: AA6agR6zy6uYJGg3N1STaM5YHL46qxAQKivMnLdSg7NzW5Rnjx4oNp2+9Ur4dZ+ixNVxGnO40SBiv/oVDz10hr63xXc=
X-Received: by 2002:a05:6214:e69:b0:476:b991:586f with SMTP id
 jz9-20020a0562140e6900b00476b991586fmr15851832qvb.48.1659966257725; Mon, 08
 Aug 2022 06:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
 <20220805205321.19452-2-andriy.shevchenko@linux.intel.com> <YvEJefFk7bqW9EpZ@sirena.org.uk>
In-Reply-To: <YvEJefFk7bqW9EpZ@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 15:43:41 +0200
Message-ID: <CAHp75Vd=RTpnzD4asgx-FQvaQYeO5=aqnR6mT_-xrPY-djs8FA@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] regmap: mmio: Drop unneeded and duplicative checks
 around CLK calls
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 3:28 PM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Aug 05, 2022 at 11:53:18PM +0300, Andy Shevchenko wrote:
>
> > The commit 6b8e090ecc3d ("regmap: use IS_ERR() to check clk_get()
> > results") assumes that CLK calls return the error pointer when clock
> > is not found. However in the current code the described situation
> > is simply impossible, because the regmap won't be created with
> > missed clock if requested. The only way when it can be the case is
> > what the above mentioned commit introduced by itself, when clock is
> > not provided.
>
> > Taking above into consideration, effectively revert the commit
> > 6b8e090ecc3d and while at it, drop unneeded NULL checks since CLK
> > calls are NULL-aware.
>
> I don't understand the supposed benefit of this.  Yes, the clk API does
> currently accept NULL as a valid clock and returns it as a dummy but
> explicitly taking advantage of that in the way that this does just feels
> more sloppy than the current behaviour.

How? The clock is still checked by NULL by the clock framework. The
above mentioned patch is simply wrong (taking into account modern
behaviour of CCF APIs) and reverting it clears things.

-- 
With Best Regards,
Andy Shevchenko
