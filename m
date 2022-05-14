Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2551526F65
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiENFQa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 14 May 2022 01:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiENFQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 01:16:23 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC2C27A;
        Fri, 13 May 2022 22:16:21 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2fb9a85a124so105231177b3.13;
        Fri, 13 May 2022 22:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tgxGrfbnOUDbxRi/HopYzJN2PHchIMqDSJY9CbCOcv4=;
        b=Q88tpX1YsdLzak5i4dP3hibTDT31N3zIBNglDNwf0DReN08EiQDtojLfPmKvGkMas9
         /b0fJRtD5+XqpSLahoGsXuLQoIvUTF0qZ3XABddBENhfKx2uu0Zl9blEAi1/V+ukdhJZ
         0zzsqRQyuNd28uKM2TMqJlWGlIR8Uh+ogKjoMYdWFcuKPaBIUE7yw0DYDBpxgdJQWDHg
         a6i7bS3uHjFdz8tOwi4EkTuPxLT80XMNeUMwgL/K/+oPEml3YY8U2t+pRHW5JjXA3zae
         ta37t0XYkzui4rDXqCZTheipYqx47ItralHWCZ2YiSgBUm/u2X8FsNd+1tG4g9ue8LUq
         GlFg==
X-Gm-Message-State: AOAM533SndEP44Isy42+Xai9N8xtmT/CBaqzEsLEBHoe0YhG/4MHHmKI
        yilj1zkAQrMP201/2UXFGGUShEz34LQ/5q8mOgg=
X-Google-Smtp-Source: ABdhPJxV4Ky10ErjrvOMl+cu+71QRgJi6kpzasVTB89gixOVLz2IVUGv3/pCwaUcArF+fHVxXAmfjsnU4QLxSCquLi8=
X-Received: by 2002:a81:8cf:0:b0:2f4:da59:9eef with SMTP id
 198-20020a8108cf000000b002f4da599eefmr9502079ywi.78.1652505380856; Fri, 13
 May 2022 22:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220513153606.302464-2-mailhol.vincent@wanadoo.fr> <202205141221.H0aZXRak-lkp@intel.com>
In-Reply-To: <202205141221.H0aZXRak-lkp@intel.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 14 May 2022 14:16:09 +0900
Message-ID: <CAMZ6RqLU-Wg0Cau3cM=QsU-t-7Lyzmo1nJ_VAA4Mbw3u0jnNtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] can: skb:: move can_dropped_invalid_skb and
 can_skb_headroom_valid to skb.c
To:     kernel test robot <lkp@intel.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat. 14 May 2022 à 13:20, kernel test robot <lkp@intel.com> wrote:
> Hi Vincent,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on mkl-can-next/testing]
> [also build test ERROR on v5.18-rc6 next-20220513]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/can-skb-move-can_dropped_invalid_skb-and-can_skb_headroom_valid-to-skb-c/20220514-003707
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
> config: arm-randconfig-r021-20220512 (https://download.01.org/0day-ci/archive/20220514/202205141221.H0aZXRak-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/intel-lab-lkp/linux/commit/8f56e6b1b9945ea47c9f410d1254451df9d6fe22
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Vincent-Mailhol/can-skb-move-can_dropped_invalid_skb-and-can_skb_headroom_valid-to-skb-c/20220514-003707
>         git checkout 8f56e6b1b9945ea47c9f410d1254451df9d6fe22
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
>    ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
> >> ld.lld: error: undefined symbol: can_dropped_invalid_skb
>    >>> referenced by vxcan.c:45 (drivers/net/can/vxcan.c:45)
>    >>>               net/can/vxcan.o:(vxcan_xmit) in archive drivers/built-in.a

OK, so the issue is that VCAN and VXCAN are users of
can_dropped_invalid_skb() but do not depend on CAN_DEV. Above error
will appear if CONFIG_CAN_DEV is not set (or if CONFIG_V{,X}CAN is set
to "yes" and CAN_DEV is set to "module").
I see three choices here:
  1. move can_dropped_invalid_skb() outside of drivers/net/can (i.e.
move it somewhere in net/can).
  2. split CAN_DEV into one additional sub module: CAN_SKB and add a
dependency to it in VCAN and VXCAN.
  3. Add a dependency to CAN_DEV in VCAN and VXCAN

1. is I think the worse, 2. the best, 3. is the laziest option and is
kind of acceptable.
@Marc (and anyone else), what are your thoughts?

Yours sincerely,
Vincent Mailhol
