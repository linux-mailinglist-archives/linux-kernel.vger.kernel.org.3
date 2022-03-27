Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855DE4E887C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 17:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiC0Ppl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 11:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiC0Ppj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 11:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01133587E;
        Sun, 27 Mar 2022 08:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6473061045;
        Sun, 27 Mar 2022 15:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C9BC340EC;
        Sun, 27 Mar 2022 15:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648395839;
        bh=1b5ZrLzlxq7Xxei9lvUlEtImFI2R3O8POV3NpenbAjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MFIeqPi2aso8KXW9KzZq/pmgRCdIFJXZ5nNRlvFmpw93noaNHyceqMiv4AJUdYt2j
         RpJuPEmwDc0J0u6yZakyh/8QU+mMjzRtphF21D2gmPDjjEBTWa91nmhLrQe7UF+LJW
         vydt4m2EVU+uTpx9ZopQHhMCMspUqlhgxHRiMkJCKJwrp3KNrMQ4510+7B+ddP1I48
         buOYD8cYGJiC55a2F0RuTv6+KOXnkLzu+nDuC7wgD/ac+8Ch25HLGWxZjOgkDHhunf
         g2yv9HdaMx+9VjlVKrlG6f5V2XxGlSRUS9UxJBva7P2X7hkphNdt27CaXoIyqadXif
         9sBwDhfo0MUlw==
Date:   Sun, 27 Mar 2022 16:51:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tong Zhang <ztong0001@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio:imu:bmi160: disable regulator in error path
Message-ID: <20220327165130.51e3c9d2@jic23-huawei>
In-Reply-To: <CAHp75VfzWpabLsCDDuifpEDgN+pCnU-agi47iO0exYV29k6nSA@mail.gmail.com>
References: <20220319162006.13c60c1f@jic23-huawei>
        <20220319193459.2628876-1-ztong0001@gmail.com>
        <CAHp75Vfk+CQZoz+s5PuSTBb0Nb4KLB+yoNiTCJQ4NktxV1nycQ@mail.gmail.com>
        <CAA5qM4DE7Qehn2G3bOJfJ7wNfOBA01tzAFOuGZa_O4=6Ocb61g@mail.gmail.com>
        <CAHp75VfzWpabLsCDDuifpEDgN+pCnU-agi47iO0exYV29k6nSA@mail.gmail.com>
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

On Mon, 21 Mar 2022 18:22:10 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Mar 21, 2022 at 5:53 PM Tong Zhang <ztong0001@gmail.com> wrote:
> > On Mon, Mar 21, 2022 at 1:28 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:  
> > > On Sun, Mar 20, 2022 at 8:44 AM Tong Zhang <ztong0001@gmail.com> wrote:  
> 
> ...
> 
> > > Haven't I given you a tag?  
> 
> > Hi Any, Thank you for reviewing the patch. I appreciate it.
> > I thought I would need another tag since this patch is a v2.  
> 
> It depends on the nature of the changes you made. As far as I read the
> code the changes you made are in addition to what I have tagged and I
> see nothing that prevents you from keeping the tag.
> 
> > Sorry for this back and forth. Have a great one.  
> 
> NP.
> 

Applied to the fixes-togreg branch of iio.git but I won't push
it out until I've rebased that on rc1 once available.

Thanks,

Jonathan

