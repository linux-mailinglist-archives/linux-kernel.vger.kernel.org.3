Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC41517F28
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiECHwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiECHwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:52:11 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9377F21E16;
        Tue,  3 May 2022 00:48:38 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id w124so15659033vsb.8;
        Tue, 03 May 2022 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=zj49omzHFR01++oBu+0W9AYLTlMy2CPRfANP49GV5zg=;
        b=pxw1snBRjgFufkxdK03dpmnNzO7y/iu3/T/esQhLxg5NUKzD4srhWA4hqOSQ0cYht0
         B6ZB3wmwT8P9z2ykE+ZEomhNfcyawfTbT6qLan5sMsWiRC0Zn8AAQNmTN896ge/BRwTx
         kPr16EycZFGNOGdY5RaJeiYlSV70eOaCYIbGF5c6C2gu8TgHpLGz1tIBQmn3GPJ784qe
         TP/C95h14YPt6cFLoP5vOFR3MWyg7n4Do9JVgXee0zJqGApnaqR1c/Ysyza3fD6NyJ0Y
         x/x3Y80Q+FkrbWbpdI0Qj/DEiJXpZ+cF70LcaB/79GRfDrdNs+dguUl3+5IjbAMimSIV
         hIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=zj49omzHFR01++oBu+0W9AYLTlMy2CPRfANP49GV5zg=;
        b=kSIqclwhr8Z0vkB8JHlWO7wRWo6UlQ3O7voan2FM+5d4sWRF2Q4Iy2a83/cxAKFV/r
         3KzoxsxcqLvOZCsujCjbk+Lgqcy3wQGi8lOqA30G5WlAVNk0R/IhHTPJ9Efrr3b8iQ6p
         47JISwN4x0y+LS8VnzixFaM3Edi7ZQvEfjizhop7ZX44i+jEJ5CfvErlNPBfJdw4wsOo
         ZMaMQHPPYz0DY6g/TUllDsuRMWE0n3lx1LKJyqnuHOO7C9qRrXa/T1sLFfQC+u1dNL7i
         DmRrxaazd9Zj72DozpCeT2ZUpW+uq0ePe3XrReeiZd252dpUR3MMtKIbFN/xgN0P7hyy
         rbrg==
X-Gm-Message-State: AOAM531zt+BOj2v/9Ye1LD6pZr5cpBWudtNRXI9BxL1JvxdyrCRnKNTN
        JQKaqVko2OXFGTo2evPqzqowoXnmHYVRUjS9g1g=
X-Google-Smtp-Source: ABdhPJwr3UknA3gt0qUS2hBiaqn4tEDxZJmM/+jVRy++FwMAYYs9JLFGITYe186JFL+Ky4z5HlaQhs8t9rdBHYHlxvE=
X-Received: by 2002:a67:c107:0:b0:32d:3ac1:1e71 with SMTP id
 d7-20020a67c107000000b0032d3ac11e71mr2609359vsj.41.1651564117572; Tue, 03 May
 2022 00:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-13-andrea.merello@gmail.com>
 <202204271554.EiuIRNPI-lkp@intel.com> <CAHp75Vc34K=5U=kMCqtDm_h3VBmqyCqcWr0em+8fZBiM2n76rA@mail.gmail.com>
In-Reply-To: <CAHp75Vc34K=5U=kMCqtDm_h3VBmqyCqcWr0em+8fZBiM2n76rA@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 3 May 2022 09:48:26 +0200
Message-ID: <CAN8YU5OeYjf5pikMuLXyaYTO1bsArdFOQf3M6tYMNubeZxqe7A@mail.gmail.com>
Subject: Re: [v5 12/14] iio: imu: add BNO055 serdev driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
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

Il giorno mer 27 apr 2022 alle ore 15:41 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:
>
> On Wed, Apr 27, 2022 at 10:11 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Andrea,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on jic23-iio/togreg]
> > [also build test ERROR on linus/master linux/master v5.18-rc4 next-20220426]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220426-212132
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220427/202204271554.EiuIRNPI-lkp@intel.com/config)
> > compiler: arceb-elf-gcc (GCC) 11.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/675ca9cd13af45cc5943dd15caad5e866fd7c971
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220426-212132
> >         git checkout 675ca9cd13af45cc5943dd15caad5e866fd7c971
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> make[5]: *** No rule to make target 'drivers/iio/imu/bno055/bno055_ser_trace.o', needed by 'drivers/iio/imu/bno055/built-in.a'.
> >    make[5]: Target '__build' not remade because of errors.
>
> You need to add a C-file with the only line
>
> #include <..._trace.h>
>
> And drop that include from the _core.c.

Hum, I'm a bit confused here: the bno055_ser_core.c file explicitly
looks for that tracepoints (e.g. it calls trace_send_chunks() and
friends); dropping the include prevents build here because there would
be no definition for those tracepoints.

There is already a C file bno055_ser_trace.c that just contains the
said include and it defines CREATE_TRACE_POINTS; I see other drivers
like dwc3 do the same..

But my problem is that I cannot reproduce the issue found by the bot:
the compiler that is downloaded by the script doesn't run on my build
box because it wants a newer libc (I was hoping that those compilers
were statically linked, but they aren't), while any other attempt I
did with other older compilers resulted in either successful build or
failed with other weird, apparently unrelated, errors about relocation
issues (of course I tried with the arch and config used by the build
bot).

Is there any build farm publicly available or something like that?

> --
> With Best Regards,
> Andy Shevchenko
