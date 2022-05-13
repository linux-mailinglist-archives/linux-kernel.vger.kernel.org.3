Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F529525AED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 07:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377028AbiEMFAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 01:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351159AbiEMFAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 01:00:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425F29BC45
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 22:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7603DB82AE9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E041C34114;
        Fri, 13 May 2022 05:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652418009;
        bh=mwVm2t+7RO1SnZGSHb3T+W/M/kBw9VVG/LIWhQ+0uBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XygUS7NFwLnV9hFtJFB1RbgI0FAutd6Ilc2W/3goPfZSsg8z6Q8OylP/98v/T1GuT
         KtGQcUWilOL2adUThzZ/sa03TuIMHjH6r5tLqmXw+Upxb+Qz6QSmcOGIa/n+xrJh7Z
         hKWR+/nGxnmdKFPrpIWyn8n/5glByKBq9esiAIdNDy5kBIub94ngSzAJ19Z3U1fbdX
         q7GC1QFSixI7tERE6rG2lSEu1f7pbXPUXBjNELGY/3kvHQ7AeI/VQVJe/jbVHf8ZQR
         ZL4nvsZTZcmaqKOiiSA9T6jgGMVQDeMDJng6Xkcwv6wpFKaypa2+bknP6+Ce1ARNu+
         DW7LpvGl5+IiQ==
Date:   Fri, 13 May 2022 13:00:05 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] platform/chrome: cros_ec_spi: drop BUG_ON()
Message-ID: <Yn3l1fJQswi/hOfK@google.com>
References: <20220512083627.885338-1-tzungbi@kernel.org>
 <20220512083627.885338-7-tzungbi@kernel.org>
 <CABXOdTftq_Gbf5UmYCLEfm00xJusm-ZaWnQt9KEhb7U-mY_1Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTftq_Gbf5UmYCLEfm00xJusm-ZaWnQt9KEhb7U-mY_1Pw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:14:10AM -0700, Guenter Roeck wrote:
> On Thu, May 12, 2022 at 1:37 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > It is overkill to crash the kernel if the `din` buffer is going to full
> > or overflow.
> >
> > Drop the BUG_ON() and return -EINVAL instead.
> >
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> 
> Wonder if the return code should be -EPROTO instead, but I don't have
> a strong opinion.

Thanks for the review.  I am going to split the patch into 2 smaller pieces.

For those related to preamble bytes, at the first glance, they could use
-EPROTO.  But, no, they are irrelevant to the protocol.  I would drop them.
See [1].

For those `din` isn't large enough, I would keep using -EINVAL as they look
more like the `ec_dev` didn't configure correctly.  See [2].

[1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220513044143.1045728-7-tzungbi@kernel.org/
[2]: https://patchwork.kernel.org/project/chrome-platform/patch/20220513044143.1045728-8-tzungbi@kernel.org/
