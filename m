Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B198151191A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiD0Ntp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiD0Nsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:48:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D339A3E0138;
        Wed, 27 Apr 2022 06:45:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g23so1979748edy.13;
        Wed, 27 Apr 2022 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ib87TMnHdHSaWtcmbF0OjtdiDrTYghbPJrfftr1/beA=;
        b=SaItUT9u06Eh7/ttp0tmVSQJhdgqGm0RaG2WwKokmUyZR5EslExzxThOhwuR5+YK1f
         onyYH9SF4kFelpU+G/xj0BKJTJfO/PDIdYSY/c2rrXvk53UIcJd4z1fgrqU47qhxqzcR
         Mtl0wDuzRXIP6J0WIH1fkgIkc6uf0JTmZfIkzdCS/5TiyX/msHNDJvu5+v86DF5sM8u8
         BKAVki37XkZKCkwEXrSCLpi3EpjBpsuA27up8+zhFa3RI06cH6BHRUD9sOxBfBSPhZQ7
         V643WRmHggAmKN68jedC0Acsy1iBpcaiO2i1Aroi1p6IH9XRogYe3Et3lVPc7YOTBGQo
         ztLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ib87TMnHdHSaWtcmbF0OjtdiDrTYghbPJrfftr1/beA=;
        b=53YWnY1kxtRvoyrFcXbOWPtAyZY1H2AXaEJ6I7cF82dvMsccYL0e6S6zxNQRNZoVHL
         cZGxnzfKoAIuonpXQH5rzNFC0eimrPnnN8GhPEmKpbKzN778Dy3kcEZOMMVZK3qI6CKy
         UcClY2Q75hkihtnlybwskU1inNDv8UMGB3qor6HINpe3SKLhbhfoV1JlJ1DWUFAi7LI/
         TU5I+VTuHrkOd6fQvsQByew1xUGdcPfJ/SYdhL6pSE85pCh4hRQLQDYsXdTCvFVio+NF
         Lo5HN7O718f5E/48WGvYMMX/xHS51QP8Ib+RI1ddRU1Bsd/gD1qNxaJH61UC280K7T0c
         Q7Mw==
X-Gm-Message-State: AOAM5323NtzXJ77WnQpRwCTHKarRoMQnL0A0UgDqquNwmwCc0SHlZvo7
        Q/GZK4JEsbnnuBnVj/FHYs8BhfXuJdr4+bkXxKs=
X-Google-Smtp-Source: ABdhPJx1WY5M470N8OIdfRPQPI2v2H2iGF0+KhybAR8gwh/GX+t8lhQC4ORxmgh9NYM7nb/cUWL0BvikHNUxtWokfcE=
X-Received: by 2002:a05:6402:d51:b0:425:d5e1:e9f0 with SMTP id
 ec17-20020a0564020d5100b00425d5e1e9f0mr21870786edb.125.1651067142414; Wed, 27
 Apr 2022 06:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220420211105.14654-10-jagathjog1996@gmail.com>
 <202204211211.febbJ6fy-lkp@intel.com> <20220424172002.7dd48dfa@jic23-huawei> <20220427030119.GA31584@jagath-PC>
In-Reply-To: <20220427030119.GA31584@jagath-PC>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 15:45:06 +0200
Message-ID: <CAHp75VdtK6n_SAGr4bUUXEg28gGGxbazznG=HQf2RBtcOpr-bg@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] iio: accel: bma400: Add support for activity and
 inactivity events
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Robertson <dan@dlrobertson.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 5:01 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> On Sun, Apr 24, 2022 at 05:20:02PM +0100, Jonathan Cameron wrote:
> > On Thu, 21 Apr 2022 14:45:05 +0800
> > kernel test robot <lkp@intel.com> wrote:
> > > Thank you for the patch! Perhaps something to improve:

...

> To avoid warning can I do like this
> field_value = FIELD_PREP(BMA400_INT_GEN1_MSK, state);


Can the same be used as below ?

> > >   1089              set_mask_bits(&data->generic_event_en, msk, field_value);

In other words, look for function macros in the bitfield.h.

-- 
With Best Regards,
Andy Shevchenko
