Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294BB5AB872
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiIBSmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiIBSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:42:38 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745F211089E;
        Fri,  2 Sep 2022 11:42:37 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a22so2138944qtw.10;
        Fri, 02 Sep 2022 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wYLRyL/SNNg94Z8T2JQ26m0zpILN4OZadqlcAOj3GBo=;
        b=fBTokpob7MflAOrnNuVxYTQPvj1PUlrf1+LVUlfpmjjnM+Q87UuGsf8nPxsPNZ9uKm
         vDrEjdPas31JZ5ir7MdAFwSpHq2PyF8H7lzDvWL9Q0HwmwLU5HfZ29nSdhN23i39An2g
         tFc4pQg9fm/mx/rVkK+5FdpuODwaqSA7rgf/lsAz2kYgy7RF+IDMFenQyyUPDs1bmv4d
         1Mk/mmypZFtBQ2g5D5m/8sMSvqh2MygJS2oa5Ema6IBSwlKdcj3yZH1+UtGbWgRSH9/n
         rAjuHNKiczQntM1dDVhUtal00YZg0xqmAs1TVgR+0h8mOou9xMZqBBBAeOWwtIAPF8wu
         zqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wYLRyL/SNNg94Z8T2JQ26m0zpILN4OZadqlcAOj3GBo=;
        b=y3W2ZTmCwCvjTjQiF4x/Ns0xvugBR1LcObtj7HP7hfJCvVyG54KgnierUfhIk/Nuq/
         fLoYz/t8gXdAOoZRvjOHVKbWgdsTMEsawm6+X6uMtixxoDCxgibaT3qPVx17C57Kpb55
         bF/cNHf8/87MbVcjPnyoNVym0ePl/E0X049ZSiX4FS1JdEOVuAoJbEQ+VWUqcAL5CPg6
         j8ELw+lHAs7iGpx47cs1mG3fxJ30Yaym2EAYTYEPht79L+fA1YosANxv71mu99cAyXTk
         HjggLPRBw1vwHaTpEkhx1iHZKGY8kLDXs9FUVKoIGlwXeYmRjtYOu+C+mENqs6+OzynS
         5SGw==
X-Gm-Message-State: ACgBeo3Qv4hYdWxGspvo+zKXc2J3JSm2CTOHaKqBvrZwKA2BWiVsAXOp
        BWY+pRlWAmZk2anUzSHwCK6DmrVr8JFAKbof5I4=
X-Google-Smtp-Source: AA6agR7qAPjRX76TELv2RiJGd3RC77aUYgZlYAKEqS9SyED7pHj/A1+wsN0yTaVG/jOP2RKEaIInlg498k4SaTBL9FU=
X-Received: by 2002:ac8:7dd0:0:b0:344:afc1:b11d with SMTP id
 c16-20020ac87dd0000000b00344afc1b11dmr28794432qte.195.1662144156546; Fri, 02
 Sep 2022 11:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com> <20220902182650.83098-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220902182650.83098-3-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 21:42:00 +0300
Message-ID: <CAHp75VcNGEVRnkWeVThaq4zNYoiZGSY-+KfbV5_9zG_5XoriMg@mail.gmail.com>
Subject: Re: [PATCH v1 03/17] pinctrl: cy8c95x0: Allow most of the registers
 to be cached
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Sep 2, 2022 at 9:36 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It's unclear why many of static registers were marked as volatile.

the static (yeah, forgot it)

> They are pretty much bidirectional and static in a sense that
> written value is kept there until a new write or chip reset.
> Drop those registers from the list to allow them to be cached.

This patch is not correct due to indexing access. It's sneaked since I
forgot I added it into my main repo. The proper approach should be to
create virtual registers and decode them before use. This allows to
cache all ports and as a benefit to debug print all port actual
statuses.

-- 
With Best Regards,
Andy Shevchenko
