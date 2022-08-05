Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7458B114
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiHEVXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiHEVXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:23:32 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A2B193EC
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:23:31 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s2so2957828qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eXC8Nl47H1Pob3HuDjR/rB9es16u/aDWPHEAq/WoF2Q=;
        b=Hp+VngHOsVpHmMOhD8xv3NQdkt/5s01o59w5qQJq2gk4GQ8cOOKmDR1jVYX/hDaDOj
         6LB1FzWE5GbCgJJrmc5IR0xSVJjXcWI2nfT2xRxlVPlJrnH3ZAFtYSXwefUhSvg/YS3c
         yoO44zW20LGh+bibAU6FVGLiRHCllaDuDBDGmz25DFUrO/6NbnkRI45J9Yis8yJxBByo
         5F/3tlzrO80aYfqkm2un20LUEjsT8lYxwAwFdCfQzcYsMtX+RyQFXj7sydQf0B4HWYdt
         e0RQIVAG+lKcigOHDQ7+deULt7xKzhu+OERgKox97aAy0E4am2Yno6pEN5xzM204LF0X
         ykIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eXC8Nl47H1Pob3HuDjR/rB9es16u/aDWPHEAq/WoF2Q=;
        b=pBsQlL5XWeHzHOx/5K74sSm+2P8KSQvqGuOywoHtXpsDvf+xTVV+v/ZDzSWr4Xo0Dr
         4qLsWwpF9SYhfghrknfReqjnI4OGkuGa7kWPUEosmJTBawkoazKktGLRBy6/7SltnFAg
         ANpJDY6BpdCo0hdF6g5n+nrs/ad8AGI080sDMa0v7zWL5qXlzMuOi9X5Bv3HS8YQU+PE
         6ocm+7O/D7isYcMdz3PL0YXw5HjEQYBDArpINa7Q8n0FPlJo/yMe9daiBL1STH88L0oa
         Bxano653PDPpIKpbyXgNO6XaZ3LttOnpefDff+Ztb1EjYivr9Hots0LiUP3lAw/TyaI7
         355Q==
X-Gm-Message-State: ACgBeo32ddfRAcVdk5ITUmcHf4BK+K8M8PCw6bPQNqJ++REWw9Qp30pN
        1O9sZGsh6n0DOku8LScJnK2+e48gXXtJaA0o/z55iMBdPCY=
X-Google-Smtp-Source: AA6agR47Jy/3Hy3zRWqCO7zh/sIM49ZUUq3Nzg4OFBZmgmqe8XkLnDp0R5g5hQtzrTHrqodMNNBwG/XFAVg9/nebnHI=
X-Received: by 2002:ac8:7f88:0:b0:342:e9dc:ee77 with SMTP id
 z8-20020ac87f88000000b00342e9dcee77mr1570347qtj.384.1659734610166; Fri, 05
 Aug 2022 14:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com> <20220805205321.19452-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220805205321.19452-5-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Aug 2022 23:22:53 +0200
Message-ID: <CAHp75VdAhm2vvof_WMTgqaV6SARYOtgPfhVA=MntEs7qBFXnjA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] regmap: mmio: Introduce IO accessors that can talk
 to IO port
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
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

On Fri, Aug 5, 2022 at 11:14 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Currently regmap MMIO is inconsistent with IO accessors. I.e.
> the Big Endian counterparts are using ioreadXXbe() / iowriteXXbe()
> which are not clean implementations of readXXbe(). Besides that
> some users may use regmap MMIO for IO ports, and this can be done
> by assigning ioreadXX()/iowriteXX() and their Big Endian counterparts
> to the regmap context.
>
> That said, reimplement current Big Endian MMIO accessors by replacing
> ioread()/iowrite() with respective read()/write() and swab() calls.
> While at it, add IO port support with a corresponding flag added.

William, I believe this series allows you to switch PC104 drivers to use regmap.

-- 
With Best Regards,
Andy Shevchenko
