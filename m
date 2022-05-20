Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2646352E0F8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343860AbiETAIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiETAIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:08:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6DB1A3A6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C4161A22
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BADC385AA;
        Fri, 20 May 2022 00:08:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="C9agVZPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653005297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oz4jyYgcdPnHqeYXhsxnndTsxU1YZpmX/v9xz8spcmE=;
        b=C9agVZPWmSYDBJk/Aiw7BnWiKGhMuCHa/ZZahQF4StRzcxU+6c8V7UF4HvRqMuvr8XhWtg
        Upb4nMG+IKYu+uwG9/unl2prZSVZjseTnxW525+5wb84wrx1xJCiFEGwQ/GK8dBHA+sdSU
        NLCqXUft4DkpQ8PXn5d7y8ZCXKvgiHk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 072d2e63 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 00:08:17 +0000 (UTC)
Date:   Fri, 20 May 2022 02:08:15 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: convert to using fops->write_iter()
Message-ID: <Yobb79PvIqRRNguV@zx2c4.com>
References: <f871a510-d262-bc98-757e-204976e1b82c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f871a510-d262-bc98-757e-204976e1b82c@kernel.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, May 19, 2022 at 05:43:15PM -0600, Jens Axboe wrote:
> -static int write_pool(const char __user *ubuf, size_t len)
> +static size_t write_pool(struct iov_iter *iter)
>  {
>  	size_t block_len;
>  	int ret = 0;

Changing the return value to size_t isn't quite right, as this can
return -EFAULT. So at the very minimum, it should return a ssize_t.

Jason
