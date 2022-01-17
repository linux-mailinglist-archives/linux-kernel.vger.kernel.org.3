Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CAA490FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbiAQR4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiAQR4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:56:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6582AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:56:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D7060F74
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 17:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C624C36AE3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 17:56:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XAa0Bc5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642442159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CgkU9qshkdyO22bBprRvxmbpL63Dk1aP7mcnyyd6DCQ=;
        b=XAa0Bc5zOqO19GvAOzqjn9i/9+i+8vxqLC3XP9EeVFbNqvAZZ80OBdIasx4Bzph3mDzU0x
        MRMMxKy3k/m8q08sq4mVTPfhxKkUBEjcTbLkbOjLaP8tJxUTl4uRkf7CUPoysBwdNo7WLT
        mK+UFmZ780sgtQFNmkYGoBqbZw33vrI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1c6cae1e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jan 2022 17:55:59 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id g14so48080048ybs.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:55:59 -0800 (PST)
X-Gm-Message-State: AOAM533rcET9+wTFeuOJO2TETnGGN+dX7SxyZckiGDNyq8iAU3khA6CE
        FmqYSa4kRZKyTc4x8DM3xWLCiIOECBijCvu4h+w=
X-Google-Smtp-Source: ABdhPJy7/EFa8iKIjMr2YPJ7SMiwuuhE8yMX+qwhW+C2seFWd9JSO30GJEckgJWjDX+LRz6MiSQfyXMeZij8p+SZNwE=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr29247204ybe.32.1642442158831;
 Mon, 17 Jan 2022 09:55:58 -0800 (PST)
MIME-Version: 1.0
References: <YeWnVHwcBaS7OZak@owl.dominikbrodowski.net> <20220117175237.361518-1-Jason@zx2c4.com>
In-Reply-To: <20220117175237.361518-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Jan 2022 18:55:48 +0100
X-Gmail-Original-Message-ID: <CAHmME9p4z84tScvaUJ+S_RM9h4dSq_chK7mHGRFQK7re-yt78w@mail.gmail.com>
Message-ID: <CAHmME9p4z84tScvaUJ+S_RM9h4dSq_chK7mHGRFQK7re-yt78w@mail.gmail.com>
Subject: Re: [PATCH] random: simplify arithmetic function flow in account()
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 6:52 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> -static size_t account(size_t nbytes, int min)
> +static noinline size_t account(size_t nbytes, int min)

Sorry, that noinline snuck in there from looking at the codegen. Removed.
