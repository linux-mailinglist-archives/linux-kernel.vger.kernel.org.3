Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862D857B688
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbiGTMe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240392AbiGTMeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:34:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2EB4C604
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:34:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m16so23540380edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIYaOKnGTI6IaoJhWifZ4SiRGVTMle5OSaSjE78z0Pg=;
        b=wvdTKSubSEHMIv5MXsfGa0LD1H1qK+hEz5plUx6Hma+J7WYlLzVf3zAgymt+yt/oOV
         SbgmpahLzVtQjxqC2A+GK+L+KrBqoCPvW5HLxLIwBQ0aMKBzl/07sYbwp72mC7jYP9og
         HFGvNobDRVc0cAT3KXcb8yhOsVwbBS/nouHsPTWnM4wR6evw0cTryoNlr3tbrwP93u7R
         iQSnYWDQkFsXhTMBihJbOSXJezhsz1hv4QH/U/xiDJOpv8VJ/fUEkKGui1J4jR4DLC0J
         xHFXhGFnRWapPf4ceBZ1qL3Tb8KJgksIbzJtibds1veIzbDKZPYSUembLDemmtI8duXd
         /uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIYaOKnGTI6IaoJhWifZ4SiRGVTMle5OSaSjE78z0Pg=;
        b=JFgfuHlnGexzqH/WycXva9UbKNl/LJ0qHhTq9vClOe2aHlFpQl87/X4Uo6N3QIB0l+
         vbIHM21vOP+sotEQamHbwVzepnkjEmUjJTXOODJrGdxQoSElaKf6IEPvuG/Udg4dmVJo
         YH+ivDNrCdlug1ND9NcYXbSYo1+WuLU1h8lfNtnMkeVPDg1Cb98sReQW9TOZn0O/AukF
         O606WyNuxrI3PWfWPb8eCB+5gAZWBACy3mMlggQ3Hm20c1ALwQvhEIvKbzndxVV3xfvD
         SF7jlgsA5YAT8p6sO/1JL3Ys9sLtg3M6dbjKJQbbjhhR7NzQ90nTHL5CFeVtMG815P4S
         6BbQ==
X-Gm-Message-State: AJIora9j6hLA2Bd6RmGu27BmP91UnYdlPVSoDuaINxXBE/TBHnvS2j1I
        p64KW8J5K7D/jEXyFhA+wWjFD1M1rC0iWqZPT8gJFQ==
X-Google-Smtp-Source: AGRyM1vYNpocDSDeJHp+beLbFY41ylyc6maLeu5hJB6UoOewK4ZqF0CPMbnmZLDF3MJcw5XgmeWdMSNBB1EKvFcHuRc=
X-Received: by 2002:a05:6402:26d6:b0:43a:daa5:9f12 with SMTP id
 x22-20020a05640226d600b0043adaa59f12mr49599534edd.408.1658320460114; Wed, 20
 Jul 2022 05:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658236876.git.william.gray@linaro.org> <f87e58791ce74917feba8a6b32bc78df51e71ba2.1658236877.git.william.gray@linaro.org>
In-Reply-To: <f87e58791ce74917feba8a6b32bc78df51e71ba2.1658236877.git.william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 20 Jul 2022 14:34:09 +0200
Message-ID: <CAMRc=Mf6OMkhkogwj0ULDDX5=fzUv-2i3i+LonLg9-vL_r2MxA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] gpio: 104-idi-48: Implement and utilize register structures
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 5:14 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> Reduce magic numbers and improve code readability by implementing and
> utilizing named register data structures. The 104-IDI-48 device features
> an Intel 8255 compatible GPIO interface, so the i8255 GPIO module is
> selected and utilized as well.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: John Hentges <jhentges@accesio.com>
> Cc: Jay Dolan <jay.dolan@accesio.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---

William,

This patch doesn't apply to my gpio/for-next branch. Would you mind
rebasing your series on top of it?

Thanks!
Bart
