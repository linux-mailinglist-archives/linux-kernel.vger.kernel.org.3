Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C636C528B69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbiEPQ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344132AbiEPQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:58:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D502A73E;
        Mon, 16 May 2022 09:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BAD1B81544;
        Mon, 16 May 2022 16:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A043EC34113;
        Mon, 16 May 2022 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652720212;
        bh=OX8Lhwf0tAzODnumDj4GdfrqfSfR+PGuBYa4nSOfujk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2wNhp/RjUnWOHv62mY/PaMLBzWj2C91Iws2xBmyR/QnC/4Dnqo4IiH7pY5ICvXx27
         jzYDW6HcN+aQvXp04to7Pau4DELeHeH/IC60a6ObWA6X/0oF6YNz1HBlubMoHV34Qr
         o/Uwi0bTqbWlBxAbCU2XFieWFJRLcPM1uMFB8jBw=
Date:   Mon, 16 May 2022 18:56:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     rust-for-linux@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Li Li <dualli@google.com>, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v1] binder: convert `BINDER_*` ioctl `#define`s into an
 `enum`
Message-ID: <YoKCUfSw2SPJXS04@kroah.com>
References: <20220516100401.7639-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516100401.7639-1-ojeda@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 12:04:01PM +0200, Miguel Ojeda wrote:
> bindgen (a tool which generates the "raw" C bindings for Rust) only
> works (so far) with "simple" C `#define`s. In order to avoid having
> to manually maintain these constants in the (potential) Rust side,
> this patch converts them into an `enum`.
> 
> There may be support in the future for expanding macros that end up in
> a "numeric" one: https://github.com/rust-lang/rust-bindgen/issues/753.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Two notes:
>   - Let me know if you prefer that I base this on top of a binder branch.

Yes, this does not apply to my char-misc.git tree in the char-misc-next
branch on git.kernel.org as I think we have added some new binder ioctls
recently.

Or you can make it against linux-next with the rust stuff removed, that
also would work as well.  But as-is, this patch does not work.

thanks,

greg k-h
