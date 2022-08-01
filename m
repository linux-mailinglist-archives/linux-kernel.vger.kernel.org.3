Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5FD586B80
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiHANAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiHANAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:00:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465E719C0D;
        Mon,  1 Aug 2022 06:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CD206123E;
        Mon,  1 Aug 2022 13:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6F7C433C1;
        Mon,  1 Aug 2022 13:00:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mZB+HL+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659358843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pc8d0vKmnesQrMS1PDGiNaiO0Vd8rHRKdrPbKhxoGE8=;
        b=mZB+HL+8KhRml8ox8I04DVHYRnealvFlP8qGouzrBPp0/w91947ePR69+hFLQRJN3qVjdX
        mgbp4T0SZVCAbbwF/12YXOjbowvmbtfkOPNEURYLYUVyJBg93bnrA5XF2WB0Xwa0Redbf1
        WR/gzJn0btQP6IgBExnCuDE2Kda9zUE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bc8b5403 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 13:00:42 +0000 (UTC)
Date:   Mon, 1 Aug 2022 15:00:38 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v2] random: implement getrandom() in vDSO
Message-ID: <YufOdlXNA5cuUIiL@zx2c4.com>
References: <YuXLlUZ8EzvZB43U@zx2c4.com>
 <20220731013125.2103601-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220731013125.2103601-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 03:31:25AM +0200, Jason A. Donenfeld wrote:
> +	batch_len = min_t(size_t, sizeof(state->batch) - state->pos, len);
> +	if (batch_len) {
> +		memcpy_and_zero(buffer, state->batch, batch_len);

Should be state->batch + state->pos, of course.

> +		state->pos += batch_len;
> +		buffer += batch_len;
> +		len -= batch_len;
> +	}

