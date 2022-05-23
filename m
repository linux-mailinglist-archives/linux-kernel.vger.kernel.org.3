Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1653194C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiEWT5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiEWT5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:57:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783CB7628C;
        Mon, 23 May 2022 12:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D179B8126A;
        Mon, 23 May 2022 19:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790D7C385A9;
        Mon, 23 May 2022 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653335830;
        bh=A4gS5DooQHW8mU6WB8eeAhPzch3QOAZAAKjJZpPtATU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uyphQ3jQalnYg8Po0U8N7AVhNUPmbVwvWw1NaBFB0lQFIPmRdPvOdj6/JWrdFrfvk
         7uODr420H4u5a+NY1RteUWX4UmFSB1C5DdUp1aojDN/dmBUahD9N0YvnizKaWHOujY
         PHaZsxhR+6Cv7UruuR2HB8rPu1ntDsGbdqslbzVQ6KzGCDqImYc9WMcIn+MlbTLs0Z
         fcNV5VhvHoNMmvYUnEX/mXX6vBTu8kILf8R2lCCpNfy6SzfwjCyBBShnqILkjHw+Ut
         YpVfgOo8+mbeaSuIzjyS7AHuPHlKpMSu1rW3DFiUZSdUQxYCEgT5Hyyk19nz0H08nr
         P24gu3/aRAwVQ==
Date:   Mon, 23 May 2022 22:55:28 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v7 01/25] kallsyms: avoid hardcoding the buffer size
Message-ID: <YovmsLwb1c6uzdSx@kernel.org>
References: <20220523020209.11810-1-ojeda@kernel.org>
 <20220523020209.11810-2-ojeda@kernel.org>
 <YovkR56ZYsPhDW4q@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YovkR56ZYsPhDW4q@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 10:45:11PM +0300, Jarkko Sakkinen wrote:
> On Mon, May 23, 2022 at 04:01:14AM +0200, Miguel Ojeda wrote:
> > From: Boqun Feng <boqun.feng@gmail.com>
> > 
> > This makes it easier to update the size later on.
> > 
> 
> This does not really conform to [1].
> 
> E.g.
> 
> "Declare KSY_NAME_LEN, which describes the maximum length for a kernel
> symbol read by kallsyms from the input.  In read_symbol(), define the 
> buffer to be of length "KSY_NAME_LEN + 1", which includes the terminator
> character."
> 
> would be better.
> 
> > Furthermore, a static assert is added to ensure both are updated
> > when that happens. The relationship used is one that keeps the new
> > size (512+1) close to the original buffer size (500).
> 
> You must split this then into two patches:
> 
> 1. A patch that re-defines the length with KSYM_NAME_LEN, i.e.
>    #define KSYM_NAME_LEN 499
> 2. A patch which increases the size and reasoning for that.
> 
> Right now bundles two separate changes, which does not conform to [2].
> 
> BR, Jarkko

The URL's:

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-changes
[2] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes

BR, Jarkko
