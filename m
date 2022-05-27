Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0656536275
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiE0MTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353661AbiE0MGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC53166887;
        Fri, 27 May 2022 04:55:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F37BF61E07;
        Fri, 27 May 2022 11:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2485C385A9;
        Fri, 27 May 2022 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653652512;
        bh=WpanfLAOGrD7hytn+v8GPcDOtNTViLE3XXQJ7O55lwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btxJrZ+6li3ZjV5RvC7RFXUxYkiojd7rpXq8tr+Q502eeAZuhEqcElveXUoIPawJ7
         FUAlX9Sf216lnv0VsYwgIB97iPY9XQ9vYyjp28QHONbfwntdAb9e5Fr/wIgead/0df
         FmqZPGLQ87sLKLoLaJKq0e2I/gJ5yN8m8pU0eHvI=
Date:   Fri, 27 May 2022 10:52:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     keliu <liuke94@huawei.com>
Cc:     peter.chen@kernel.org, balbi@kernel.org,
        heikki.krogerus@linux.intel.com, mdevaev@gmail.com,
        maze@google.com, ruslan.bilovol@gmail.com, phil@raspberrypi.com,
        libaokun1@huawei.com, dan.carpenter@oracle.com,
        akpm@linux-foundation.org, brauner@kernel.org,
        songmuchun@bytedance.com, dh10.jung@samsung.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: usb: Directly use ida_alloc()/free()
Message-ID: <YpCRSojxnKwFbs8Q@kroah.com>
References: <20220527090800.2881397-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527090800.2881397-1-liuke94@huawei.com>
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 09:08:00AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

I need a real name here, one that you use to sign legal documents.

> ---
>  drivers/usb/chipidea/core.c             | 6 +++---
>  drivers/usb/gadget/function/f_hid.c     | 6 +++---
>  drivers/usb/gadget/function/f_printer.c | 6 +++---
>  drivers/usb/gadget/function/rndis.c     | 4 ++--
>  drivers/usb/typec/class.c               | 8 ++++----

Please break this up into one-per-driver.

thanks,

greg k-h
