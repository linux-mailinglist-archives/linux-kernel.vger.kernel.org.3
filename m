Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0BF4CD895
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiCDQGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiCDQGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:06:06 -0500
Received: from smtp2.math.uni-bielefeld.de (smtp2.math.uni-bielefeld.de [129.70.45.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8947387;
        Fri,  4 Mar 2022 08:05:18 -0800 (PST)
Received: from math.uni-bielefeld.de (kvm01.math.uni-bielefeld.de [129.70.45.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtp2.math.uni-bielefeld.de (Postfix) with ESMTPSA id 48F3D60179;
        Fri,  4 Mar 2022 17:05:15 +0100 (CET)
Date:   Fri, 4 Mar 2022 17:05:14 +0100
From:   Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Huijin Park <huijin.park@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: Restore (almost) the busy polling for
 MMC_SEND_OP_COND
Message-ID: <20220304160513.GA1361@math.uni-bielefeld.de>
References: <20220304105656.149281-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304105656.149281-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf Hansson wrote on Fri  4/03/22 11:56:
> Commit 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1"),
> significantly decreased the polling period from ~10-12ms into just a couple
> of us. The purpose was to decrease the total time spent in the busy polling
> loop, but unfortunate it has lead to problems, that causes eMMC cards to
> never gets out busy and thus fails to be initialized.
> 
> To fix the problem, but also to try to keep some of the new improved
> behaviour, let's start by using a polling period of 1-2ms, which then
> increases for each loop, according to common polling loop in
> __mmc_poll_for_busy().
> 
> Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Huijin Park <huijin.park@samsung.com>
> Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Jean Rene and H. Nikolaus, if this doesn't work, please try extending the
> the MMC_OP_COND_PERIOD_US a bit, to so see if we can find a value that always
> works.
> 
> Kind regards
> Uffe
> 
> ---
>  drivers/mmc/core/block.c   |  2 +-
>  drivers/mmc/core/mmc.c     |  2 +-
>  drivers/mmc/core/mmc_ops.c | 13 +++++++++----
>  drivers/mmc/core/mmc_ops.h |  3 ++-
>  drivers/mmc/core/sd.c      |  2 +-
>  5 files changed, 14 insertions(+), 8 deletions(-)

Hi,

thanks, this works fine.

Regads,
Jean Rene Dawin
