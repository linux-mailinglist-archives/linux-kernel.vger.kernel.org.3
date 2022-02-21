Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5252A4BD4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbiBUEtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:49:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343942AbiBUEtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:49:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2567243ADB
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:49:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9C99B80DA6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C06EC340E9;
        Mon, 21 Feb 2022 04:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645418955;
        bh=UCreU5iYXL0AczUfyJM7D7d9pfDKyzSCxfDaC3MxKIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2Y1qNAvx0A6Wiiccr0MfiotPS6pe4GrZ/rTP8JzC/SpLKoCTjAQJNmQMaUA0y+NC
         ZlUwlnSQX4RxTr1z6JQwvMjCNO1CYETcOYEajKspwH6AQz/z3JHkM/si1lAQhb25bt
         8Bo1qO8MXkUB8sNnRhN6IQ5r1LW4LcTkNxCrUOWraP5kruRZBb9YzV2OO+0k4zEfL1
         qJa0gtEEo+gpPOLhYphaKUtq0eOHQPTXcscvsGLFPW904ToZ/Q6vNbjIMuAlEnELGU
         nrlm44Hkh0KeT+PXMvUkxtOeywU0WGyFJPwe6tQdagedc/Ekzl/ciLzF/nCnbUFG06
         aRr1gHXzz7N/w==
Date:   Sun, 20 Feb 2022 20:49:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 04/10] random: group initialization wait functions
Message-ID: <YhMZyrF2jkXRwA/D@sol.localdomain>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-5-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-5-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:23:12PM +0100, Jason A. Donenfeld wrote:
> +/*
> + * Static global variables
> + */
> +static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
> +static struct fasync_struct *fasync;
> +
> +static int crng_init_cnt = 0;
> +static void _get_random_bytes(void *buf, size_t nbytes);

A couple oddities here:

  - 'fasync' is being defined twice.  It's already defined earlier in the file.
  - The prototype for _get_random_bytes() is unnecessary.

Other than that this patch looks good.

- Eric
