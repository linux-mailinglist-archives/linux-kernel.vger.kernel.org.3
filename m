Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE99577071
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiGPRjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGPRjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83DD10FC0;
        Sat, 16 Jul 2022 10:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D466611A6;
        Sat, 16 Jul 2022 17:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B92C34114;
        Sat, 16 Jul 2022 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657993144;
        bh=k8F15ykDf5m+r4/I7RU3R8rqaaAe0MvqtE3T6MXh/to=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kHN2y5iBaPDyznSfGD+B0FZebCnxFNJTZUfhljzHRaZFdjArTKoYH3dhOzgQhbaFj
         qU+pf5QqG6IX/BHcd6NeQdcNRa7InJrk1FNCpZoupQO177qxVHg6f1uWBKJWdngpKO
         kreFeKArz+UMOteMWfRLHt8nBDudvIlD9IKW067UzkPqHY9esrLs897JH8UNeJ0fnk
         sxb5mCt22PE9q6gBsDHiURYvQz3t5wNky1WYyGkVYC6C6d5sM+gP3x/2BFWY/fK6Pe
         +HwkYPttHxZQ7XLC2AYNiL3uMkNQ9LsnoON+Tsx7o9sI/XDX2uuhnUuYhMcbl6i2zB
         1a/x1gMw282Cg==
Date:   Sat, 16 Jul 2022 18:48:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fred Eckert <Frede@cmslaser.com>
Subject: Re: [PATCH v2 0/2] iio: Implement and utilize register structures
 for ISA drivers
Message-ID: <20220716184857.7ad17421@jic23-huawei>
In-Reply-To: <cover.1657213745.git.william.gray@linaro.org>
References: <cover.1657213745.git.william.gray@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Jul 2022 13:21:23 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

> Changes in v2:
>  - Rename 'ad' member to 'ssr_ad' to indicate access to Software Strobe
>    Register as well; relevant comments updated
>  - Dereference DAC channel address via array subscripts in the
>    stx104_write_raw() function in order to match rest of code
>  - Replace struct cio_dac_reg with direct u16 pointer to the DAC
>    address; this greatly simplifies the cio-dac patch
> 
> The STX104 and CIO-DAC drivers were updated to use I/O memory accessor
> calls such as ioread8()/iowrite8() in previous patch series [1]. This
> patch series is a continuation of the effort to improve the code
> readability and reduce magic numbers by implementing and utilizing named
> register data structures.
Series applied to the togreg branch of iio.git.  Given timing in cycle, I'll
only push that out as testing (for 0-day etc) and then rebase it after rc1.

Thanks,

Jonathan

> 
> [1] https://lore.kernel.org/all/cover.1652201921.git.william.gray@linaro.org/
> 
> William Breathitt Gray (2):
>   iio: adc: stx104: Implement and utilize register structures
>   iio: dac: cio-dac: Cleanup indexing for DAC writes
> 
>  drivers/iio/adc/stx104.c  | 74 ++++++++++++++++++++++++++-------------
>  drivers/iio/dac/cio-dac.c | 10 +++---
>  2 files changed, 55 insertions(+), 29 deletions(-)
> 
> 
> base-commit: 338222d8e1121bcb78a86fb39982eddcc367a5bc

