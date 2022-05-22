Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE21C5302AA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbiEVLdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiEVLc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:32:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B25035AAA;
        Sun, 22 May 2022 04:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDDD5B80979;
        Sun, 22 May 2022 11:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0154C385AA;
        Sun, 22 May 2022 11:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653219174;
        bh=HSFPfKV2Tdi2WpwCtZWrdKSbGQHNSDkXTWY/WtdqoBY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c5TTpig5uTnV+OfbrvXXH0vHDM3P/ZVwM1r7WjDtq5jX3rB90BxersMO/oLM36/fq
         9suS1qAe7rzMZrEUsTUOlV28Pr+LLMEWf00BIAAlJMnbi4esjBJ41k/O0gT11nwFGM
         Ww2BwEg80mdQA1+GoYhhNKwopcC63PUa2doirLxWbZoxnhaTkkjkIef0pCQrb2U4+6
         fLF4/26fG46k9Xb4O0fWutSZr2K4YqN9f/F5QDKC5lVwG8wPbEHjGf8ZY1qcOIMLYm
         qKI/R/xNVIvpLHgLpqIqOapH7Hfd1GvURmUWApWkYSeX+6yqIOZdFaxCS1LrcYNFYr
         e0KN1Sq9rgWCw==
Date:   Sun, 22 May 2022 12:41:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, joel@jms.id.au
Subject: Re: [PATCH v2 0/2] iio: pressure: dps310: Reset chip if MEAS_CFG is
 corrupt
Message-ID: <20220522124139.5d3f6ac5@jic23-huawei>
In-Reply-To: <20220518144818.12957-1-eajames@linux.ibm.com>
References: <20220518144818.12957-1-eajames@linux.ibm.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 09:48:16 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> Corruption of the MEAS_CFG register has been observed soon after
> system boot. In order to recover this scenario, check MEAS_CFG if
> measurement isn't ready, and if it's incorrect, reset the DPS310
> and execute the startup procedure. Include a patch to move the
> startup procedure into a function.
> 
> Changes since v1:
>  - Separate into two patches
>  - Rename 'dps310_verify_meas_cfg' to 'dps310_check_reset_meas_cfg'

Looks good to me. I'll leave this a little longer on list to give Joel
and others the opportunity to take a look.

If I seem to have lost it in a few weeks time, feel free to ping me
(it's been known to happen though I think my tracking is much less
error prone now I have moved to patchwork + my local system).

Jonathan

> 
> Eddie James (2):
>   iio: pressure: dps310: Refactor startup procedure
>   iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
> 
>  drivers/iio/pressure/dps310.c | 281 +++++++++++++++++++++-------------
>  1 file changed, 174 insertions(+), 107 deletions(-)
> 

