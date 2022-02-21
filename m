Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452714BD53D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242873AbiBUFOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:14:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiBUFOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:14:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C4517F0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:13:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCAC4B80E6D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84771C340E9;
        Mon, 21 Feb 2022 05:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645420423;
        bh=+WeLnu5fHua72Z+d4lcg2Aa1sDENF8awmj+7szhLfG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCbVG1ZfJGmsP9PGGFjR+GyDHh+4LRsRm1f77S8yuBAysnxuGsZC7mF7eNzFERizQ
         erCfxPaTvyb6hHivyaCa6SD1NPDjcEXJFc6TiIik034orGik1fWvR5zJrkmdWQyLRw
         B0bSUhXc9SWsgWeyLzTn+VEpwwqbNHl9Pyh6UAfX3W9SLAGHrdru/B+LzAnSVpZUHp
         F0/xfkdAM48Ql8Oplui0AhuAYRwJAfj3ecplyt+WlV8Hf72fxszSs2wLZ1TApyQHRM
         oHbmiLR9CVlgRNfZVtP4abwc7YayvFm4tK6knWXP0wqfElhI3fqnNCbIj8iToVKn3S
         b20APckH338yw==
Date:   Sun, 20 Feb 2022 21:13:42 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 07/10] random: group entropy collection functions
Message-ID: <YhMfhipo95HxVaFO@sol.localdomain>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-8-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-8-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:23:15PM +0100, Jason A. Donenfeld wrote:
> +/**********************************************************************
> + *
> + * Entropy collection routines.
> + *
> + * The following exported functions are used for pushing entropy into
> + * the above entropy accumulation routines:
> + *
> + *	void add_device_randomness(const void *buf, size_t size);
> + *	void add_input_randomness(unsigned int type, unsigned int code,
> + *	                          unsigned int value);
> + *	void add_interrupt_randomness(int irq);
> + *	void add_disk_randomness(struct gendisk *disk);
> + *	void add_hwgenerator_randomness(const void *buffer, size_t count,
> + *					size_t entropy);
> + *	void add_bootloader_randomness(const void *buf, size_t size);
> + *
> + * add_device_randomness() adds data to the input pool that
> + * is likely to differ between two devices (or possibly even per boot).
> + * This would be things like MAC addresses or serial numbers, or the
> + * read-out of the RTC. This does *not* credit any actual entropy to
> + * the pool, but it initializes the pool to different values for devices
> + * that might otherwise be identical and have very little entropy
> + * available to them (particularly common in the embedded world).

Perhaps this comment should match the order in which these functions are defined
in the file?

- Eric
