Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BEF46A0D2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385581AbhLFQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356113AbhLFQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:14:32 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BB0C21A26B;
        Mon,  6 Dec 2021 07:56:43 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z18so13475036iof.5;
        Mon, 06 Dec 2021 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/B+O/WLoYXrsrc0/uuALBJe9vwwa1HcCwSBxBiKBwRQ=;
        b=XDjn7zFyOLX4YKe0pRtXSzcpVmHH8BCKubpnnYYNmRsD2NBxdkT89tHFqHwO213/zT
         Eo8fj6G3xNtjlKq08VOWXbeT33MmvoUTnE0Q+jBPQO4fXsQRUePR4//SWzR1siZ4UyX9
         Pc/+bj+BFy6DbKjLBu+d8tYKnGkcCZ6qibYFZ0pTVocuvyS0vdLFSkgUOabTTskqg2Lf
         WX7rga7nY7pUFXUeWizyayVNgLjvYheZy1Wx+LYC0eQhtRz2cAFZpcUuaBKIjBaNoGHR
         TaIOiJf7RJ86Wipd61Co+rPsMaMTjLk+Kt31Irq4l6dXcW8XJGnhPZDl4WhWQqxYYrp9
         4JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/B+O/WLoYXrsrc0/uuALBJe9vwwa1HcCwSBxBiKBwRQ=;
        b=KeJ0ZwsJAPDZQEMmzopZikdd4Y4yc3Ts72eNthr86uUCzuV2I9MYWaosHgFWWYgiDU
         9kcRwjo/3WBOPXCuiIWtTEthG3Eh4U/gvw0Q8/tiFdZvEpEYXkYYv1HUqm1UvEqKW120
         CCvXePHdA5oRAkMd95nyf4b4CFwt0ql0wviQ2/84CR376yxLAiOXVM5Ps3/ZOUQU23DE
         6Gmn+jujR79vqZBDY8wkXvlpx2kNHYVVHny8GVlTJ0x19GzViyyU67ky9CG80YWkaxw5
         Rg+lLPJyIORDbnWVZQG/QR5ttlMMPKnhKcD8XGqvJUcELhjckytplureQ6fEVUjoi2NX
         /R5w==
X-Gm-Message-State: AOAM533T3Of5CAkGaGup6s6iA2gd9kyCEUcYy1O9VBObZqlTmA1YJCYy
        MGWB+OMTdk7NH3rq7BJXxmbMns+5eSdFxdUR5nrlGrm6bng=
X-Google-Smtp-Source: ABdhPJy5lnIolLJAuQyxllhbDHoEy96j9+0RJW+gR/oW2NKf7JcXvGjjMR8nTAB744p+sbWn5ftRhugnfmCByL5y9tE=
X-Received: by 2002:a05:6602:1581:: with SMTP id e1mr34067837iow.64.1638806202927;
 Mon, 06 Dec 2021 07:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-12-ojeda@kernel.org>
 <Ya4mAqoOa8zIeZGZ@kroah.com>
In-Reply-To: <Ya4mAqoOa8zIeZGZ@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 6 Dec 2021 16:56:32 +0100
Message-ID: <CANiq72kCmLgrv++mFygR6dt0xOhfv04o9j6jYLQ1N+zLNvqohQ@mail.gmail.com>
Subject: Re: [PATCH 11/19] vsprintf: add new `%pA` format specifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 4:46 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> That should be in a .h file somewhere.  Remember, don't put #ifdef in .c
> files please.

Will do, thanks for reviewing!

> Same here, this should not be needed if you put it in a .h file
> correctly.

This one is mimicking the `CONFIG_BLOCK` one (`case 'g'` a bit above)
-- but we can change it, of course.

Cheers,
Miguel
