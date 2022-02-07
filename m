Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9058B4AC41D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384565AbiBGPnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352774AbiBGPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:38:27 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDFDC0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:38:25 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y84so17310914iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 07:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=uN1CSm5Xp0zfBe9o48GNau7bniWjnN8OKEvpexouZmA=;
        b=e7TGsDDQnw7DcjI6Brhjc6vCkM0BGnGHOPePjmWKGBU33M8F3SkG5FC9LetY1qxkST
         uS9Qu7uylVk9F7PIEVKRHenzEBnN8svGYCbBCD/f3btZzar8CHQF71cidCwAJWIniv8E
         0lac2EA1iUAVm6024Xlwi3l+/5Ud/MWR2AAd1fOG5Chd1JUbumKrjpzV35Ciq+RSeTGD
         JvoWrKZqUWs+Mblu+src5E3wJraRRSqr3zQuI2QSYoIy03+wUB8QMHcSXMAmfBLGEkcp
         xGYWaxbmMw9mlsEcO7NHonfZwk369I36O5lJiHETzzkvNCtGBe2eduQCDw9DZpK9Gv7n
         ikqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=uN1CSm5Xp0zfBe9o48GNau7bniWjnN8OKEvpexouZmA=;
        b=UKnQkWhuLeoy4MI8yeAL93oJb/4JUu/L4AJ4PPs+ImofprINa7MWMq2r3hWlxuQhPY
         lCUINu5Xa9lFN+iQV6WSTslDyjIi+dtqDjv4tvGvFsa/JuhADs2/uLIbvXYWaSClJOWS
         iWkTDs2F9WjAi90yW8gaLgGE/koNuJN4X6ZPaQ7G5dcImW6IfTNHBYYFCYqMeTFVpImy
         yRBoLV1Lz974MHgi7j3GbLDHzR+8PCNH+Guhx4D8mWTF4SX7ANOQx/WosfSIDsyowDZJ
         Xzu/onTxp7/vhXBczA9ibtVLE1p8X05OjYmPiGbanuKgsFJrC+o1RFwA4NlVs/jQ5SYo
         8Tpw==
X-Gm-Message-State: AOAM531wQSdqybKQ0GaTn4kj1sL35uW/nltJQgQch7fNIo1zhjCRZaCU
        wflDLj9vhpURMi8ltkDOa/bakA==
X-Google-Smtp-Source: ABdhPJyLp8yQXnthAsAiXf5Lyt8EZbSsYGzPNbpW4fdUvzh6XOdUKIJi5wEmEzcBbdv+ClLxErVLhw==
X-Received: by 2002:a05:6602:2c83:: with SMTP id i3mr49969iow.105.1644248305006;
        Mon, 07 Feb 2022 07:38:25 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z23sm6052912iol.11.2022.02.07.07.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 07:38:24 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gmail.com>,
        io-uring Mailing list <io-uring@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Tea Inside Mailing List <timl@vger.teainside.org>,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20220207140533.565411-1-ammarfaizi2@gnuweeb.org>
References: <d33bb5a9-8173-f65b-f653-51fc0681c6d6@intel.com> <20220207114315.555413-1-ammarfaizi2@gnuweeb.org> <91e8ca64-0670-d998-73d8-f75ec5264cb0@kernel.dk> <20220207140533.565411-1-ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH io_uring-5.17 v2] io_uring: Clean up a false-positive warning from GCC 9.3.0
Message-Id: <164424830208.19639.16912208440698766253.b4-ty@kernel.dk>
Date:   Mon, 07 Feb 2022 08:38:22 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 21:05:33 +0700, Ammar Faizi wrote:
> From: Alviro Iskandar Setiawan <alviro.iskandar@gmail.com>
> 
> In io_recv(), if import_single_range() fails, the @flags variable is
> uninitialized, then it will goto out_free.
> 
> After the goto, the compiler doesn't know that (ret < min_ret) is
> always true, so it thinks the "if ((flags & MSG_WAITALL) ..."  path
> could be taken.
> 
> [...]

Applied, thanks!

[1/1] io_uring: Clean up a false-positive warning from GCC 9.3.0
      commit: 0d7c1153d9291197c1dc473cfaade77acb874b4b

Best regards,
-- 
Jens Axboe


