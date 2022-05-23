Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD235316D1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiEWTrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiEWTrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:47:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741461FCC0;
        Mon, 23 May 2022 12:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B19E4B810A4;
        Mon, 23 May 2022 19:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4478C385A9;
        Mon, 23 May 2022 19:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653335213;
        bh=Sb3uA2wOx4pR9utz+2sZjgwB3OsaFhd/5X5eTgnRrSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oREPuPOoCN/qZU0L07QtpERLOeQtFjDXYx6bJlENkfcL3wdvM/LoZw5Sq4rpIgOCA
         1dcm/K9FfyWyGg+8yN/JUR0nzZvUlNk+aNb8VjPuje2OfKjz14o8WRREJ5rG2rfKhA
         xp5jqwYH24lJs6jztL49A/fMu2LokMjgTVihSFMebRBMBjPC20CtijJmvx2D+Bdh5Y
         auOURnKCvG9IRHIfpKQ3lhepo9guflEX6A/ELHX8h53S4DY8nCSwcXD6JS9FqR0ZsE
         qArro8RdazFzBwStDnSxTl98QNt1ZEcrfgcdtNSXEmOyHq8HwmwlwReBow2ibFwtpN
         CP2KvMUadMOLw==
Date:   Mon, 23 May 2022 22:45:11 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v7 01/25] kallsyms: avoid hardcoding the buffer size
Message-ID: <YovkR56ZYsPhDW4q@kernel.org>
References: <20220523020209.11810-1-ojeda@kernel.org>
 <20220523020209.11810-2-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523020209.11810-2-ojeda@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 04:01:14AM +0200, Miguel Ojeda wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> This makes it easier to update the size later on.
> 

This does not really conform to [1].

E.g.

"Declare KSY_NAME_LEN, which describes the maximum length for a kernel
symbol read by kallsyms from the input.  In read_symbol(), define the 
buffer to be of length "KSY_NAME_LEN + 1", which includes the terminator
character."

would be better.

> Furthermore, a static assert is added to ensure both are updated
> when that happens. The relationship used is one that keeps the new
> size (512+1) close to the original buffer size (500).

You must split this then into two patches:

1. A patch that re-defines the length with KSYM_NAME_LEN, i.e.
   #define KSYM_NAME_LEN 499
2. A patch which increases the size and reasoning for that.

Right now bundles two separate changes, which does not conform to [2].

BR, Jarkko
