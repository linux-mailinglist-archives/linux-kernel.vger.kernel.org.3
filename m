Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31202536DD5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiE1RBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiE1RBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 13:01:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A3215826;
        Sat, 28 May 2022 10:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 946A7CE0AD4;
        Sat, 28 May 2022 17:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DB0C34100;
        Sat, 28 May 2022 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653757271;
        bh=oC6vgq4nGfLuTy6kjDyr8VfSddTB81F1fW/kUUzh1vY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QU26R+3iOGigiZ/xysvUEWkmaMWOFbMcQd5jgZmXagq7lhzODFD/9pjK1MiB2qXXO
         eOHMV/e3kNo7pt6fIy2FU1hSxuj+Ly0pVrtKvZsZ55nJH3vhPkLqe011LTbelBLwEV
         eUw234dERYiPOJNm2IFOBDu37mw6OdwbQcpZjHuKW5DMARqhSBEMjypL92YKI556f7
         GwdUqR8U2RRCxWP6wrdmK/9ehY6AlnnXok+6yMLeNUYQQ0mFkGkdUesLwk+p7EbUnT
         MYUxTmDI9NW0SyjGaiP1dsHv/3ozDTppiUKpFvebV/xkpUupjpvm/vo+C3lFJOGxlX
         ei8qux+6bvW9A==
Date:   Sat, 28 May 2022 18:10:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "teodora.baluta@intel.com" <teodora.baluta@intel.com>,
        "narcisaanamaria12@gmail.com" <narcisaanamaria12@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] iio: treewide: rearrange iio trig get/register
Message-ID: <20220528181004.286e696d@jic23-huawei>
In-Reply-To: <20220524181150.9240-1-ddrokosov@sberdevices.ru>
References: <20220524181150.9240-1-ddrokosov@sberdevices.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022 18:14:37 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> The following patchset resolves problems with iio_trigger_get() and
> iio_trigger_register() call order in the different IIO drivers.
> 
> IIO trigger interface function iio_trigger_get() should be called after
> iio_trigger_register() (or its devm analogue) strictly, because of
> iio_trigger_get() acquires module refcnt based on the trigger->owner
> pointer, which is initialized inside iio_trigger_register() to
> THIS_MODULE.
> If this call order is wrong, the next iio_trigger_put() (from sysfs
> callback or "delete module" path) will dereference "default" module
> refcnt, which is incorrect behaviour.

Hi Dmitry,

Series applied to the fixes-togreg branch of iio.git and marked for stable.

Do you think it's also worth adding a runtime warning in iio_trigger_get()
on !trig->owner so that we catch any cases of this introduced in the future?

Thanks,

Jonathan

> 
> Changes v1->v2:
>     - provide tag Fixes: for all patches
> 
> Dmitry Rokosov (5):
>   iio:accel:bma180: rearrange iio trigger get and register
>   iio:accel:kxcjk-1013: rearrange iio trigger get and register
>   iio:accel:mxc4005: rearrange iio trigger get and register
>   iio:chemical:ccs811: rearrange iio trigger get and register
>   iio:humidity:hts221: rearrange iio trigger get and register
> 
>  drivers/iio/accel/bma180.c           | 3 ++-
>  drivers/iio/accel/kxcjk-1013.c       | 4 ++--
>  drivers/iio/accel/mxc4005.c          | 4 ++--
>  drivers/iio/chemical/ccs811.c        | 4 ++--
>  drivers/iio/humidity/hts221_buffer.c | 5 ++++-
>  5 files changed, 12 insertions(+), 8 deletions(-)
> 

