Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCEA50E742
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbiDYR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244024AbiDYR2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:28:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B2C41314;
        Mon, 25 Apr 2022 10:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD580B81928;
        Mon, 25 Apr 2022 17:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD13AC385A4;
        Mon, 25 Apr 2022 17:25:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZgCdYYjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650907499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zeWdts0X6m9V2/VnLwn5mW/GWlrj70BIE54pn8ZTWWI=;
        b=ZgCdYYjyecfhJXYgil1H4xLnivPbVaYGH2skIwSmg3BK1qPKXaNGF3WAd4LZELKkYdNbDO
        R3x0a3HxyYEl9fMLW6Kjy8dXNrYhtY2VU/UKDNhnNlxTZsw7RB2OwUyZJ77JlL3per9yKR
        Rz6zV78iMisPtC3xR5Ohtx0NJbFyDhA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 506a2217 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 17:24:59 +0000 (UTC)
Date:   Mon, 25 Apr 2022 19:24:55 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de, Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH v6 13/17] x86: use fallback for random_get_entropy()
 instead of zero
Message-ID: <YmbZZwXxaC+S863+@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-14-Jason@zx2c4.com>
 <871qxl2vdw.ffs@tglx>
 <Ymak7LJd6GnFxsOo@zx2c4.com>
 <87ilqx14ed.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ilqx14ed.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,

On Mon, Apr 25, 2022 at 07:03:54PM +0200, Thomas Gleixner wrote:
> Bah. Indeed. Misread the patch, but yes, if you are at it to make that
> cpu_feature_enabled() then change the config thing to IS_ENABLED() too.

Alright, will do for v7. I also just confirmed the !IS_ENABLED() way
produces the same code as the #ifndef.

Jason
