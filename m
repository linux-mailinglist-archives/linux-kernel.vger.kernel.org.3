Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356A84FAF28
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbiDJRHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242571AbiDJRHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:07:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AB3101CF;
        Sun, 10 Apr 2022 10:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52F75B80E28;
        Sun, 10 Apr 2022 17:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C674EC385A4;
        Sun, 10 Apr 2022 17:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649610317;
        bh=7quyUdm7Aq4txqWmhfJZl/DrSbjN8BfInAOcqAh00as=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A6Pv/CVY9iPEZ3OxWr/blSZDtVbew9r5Q2ZvtxTeW8KmSL7V9Zp+zCbpecR6pGulj
         3CjtK/b0gMI2uZtDmgyV3e1I9yWVkWHcwLnJtyQGQYqg4PypXWz07uoOO6w15oqUn4
         MBUcwdmX04t1H+nlbaIxSWyzyHZVczKG+Lvn67gPmAzkXU6jALqui1Lz4wfeLAMpDo
         24qSeNvZ2R6O86bFcTS4Q2n+/p7glYlAkxll816NJp8KR+Nrkr/ixnNHG0VVgHjpFe
         JLkvd+5wF0dTKVMIQmY+tSnQEjTb5nGd1rcaHJ2/lRYmcP5KdBj3qWoamvQuh8XJ8R
         SZfAAi2NNmO3A==
Date:   Sun, 10 Apr 2022 18:13:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com,
        kuba@kernel.org, saravanak@google.com,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl355: use fwnode_irq_get_byname()
Message-ID: <20220410181306.23202f25@jic23-huawei>
In-Reply-To: <20220227124134.4d4e4644@jic23-huawei>
References: <20211109200840.135019-1-puranjay12@gmail.com>
        <20211109200840.135019-3-puranjay12@gmail.com>
        <YflfEpKj0ilHnQQm@smile.fi.intel.com>
        <20220227124134.4d4e4644@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Sun, 27 Feb 2022 12:41:34 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 1 Feb 2022 18:25:54 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Wed, Nov 10, 2021 at 01:38:40AM +0530, Puranjay Mohan wrote:  
> > > Use the generic fwnode_irq_get_byname() in place of of_irq_get_byname()
> > > to get the IRQ number from the interrupt pin.    
> > 
> > Heads up, the fwnode_irq_get_byname() is in I2C tree and if Jonathan wants to
> > apply this one, the PR [1] can be used.
> > 
> > [1]: https://lore.kernel.org/linux-i2c/YfRiGR3AT8tzyweG@shikoro/T/#u
> >   
> 
> Thanks Andy. 
> 
> I'm going to let this go the slow way and pick up this patch after the
> merge window when I can avoid pulling in that PR.
> 
> Basically I'm feeling lazy today :)

Now applied to the togreg branch of iio.git and pushed out as testing to
see if 0-day can find any problems.

Thanks,

Jonathan

> 
> Jonathan

