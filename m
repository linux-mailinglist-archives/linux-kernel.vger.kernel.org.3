Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72B59A445
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350355AbiHSRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354844AbiHSRvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:51:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9F8DEA8;
        Fri, 19 Aug 2022 10:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C8FE615F4;
        Fri, 19 Aug 2022 17:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F3EC433C1;
        Fri, 19 Aug 2022 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660929905;
        bh=pJy89UL2aRemfC7jlH+uSwmGjw0ghtM9kl28iT97o9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nMhMPwSvVk8CRDTKIdfKgz8CS89NYOOBn1cRIyeZMy2CzngagzW4mY53RYpFvQ+5T
         3eMaq83HbMRdn7ONSA82hRNNoQtbmxnWOusqoRpMncYxsJSJZ2NTv4+eckkKmQ6pk/
         9sZRNAeMjzkLKIptLPDuKAS+8E8NCLwYFRC/4qyooWFpIaZQF7BELmMZFKWmhZCkhR
         T9wugX9d6C+hMZMxRhGg7EnzkkXn9fr1i3cKK2h5N0SVj6No3WkUPzjIQMuRNLAt1j
         HOvsj6POtzjy4iNIVyi3zF9s+3UZeZGBKfDCvjAOKJnbN75foqVMgKz+IkJPERQTCE
         /35JYlh//09kg==
Date:   Fri, 19 Aug 2022 18:35:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: add iio_channel_cb_get_iio_buffer helper
Message-ID: <20220819183540.5f043ab4@jic23-huawei>
In-Reply-To: <CAHp75VcrM53+GW8qN4H-8kxuBRStAXjpt5F7YD5R2nHhh-Wiww@mail.gmail.com>
References: <20220817105643.95710-1-contact@artur-rojek.eu>
        <20220817105643.95710-3-contact@artur-rojek.eu>
        <CAHp75VcrM53+GW8qN4H-8kxuBRStAXjpt5F7YD5R2nHhh-Wiww@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 11:14:04 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Aug 17, 2022 at 1:58 PM Artur Rojek <contact@artur-rojek.eu> wrote:
> >
> > Introduce a helper function to retrieve an iio_buffer from
> > iio_cb_buffer.
> >
> > This is useful for consumers that need to extract metadata about
> > the buffer, e.g. get the channel offsets.  
> 
> I'm wondering if we should start using the IIO namespace for new
> exported symbols.
> 

I'd rather not jump ahead with that because I want to come up
with a coherent set of IIO namespaces to separate core / drivers / consumers
and platform type code (there's a bit of that left) plus maybe even trigger
and buffer implementations.  We should probably get on with that though!

Jonathan

