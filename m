Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC7D490197
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiAQFiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiAQFip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:38:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB00BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:38:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a18so60790293edj.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1O8U+wUF4iGrPSEsUvPr9Y9g9nT7ZxuOwHXUzTfTnig=;
        b=gUKhHF9sP7IwLcbDjWCXAhGnqD9tXJYiiBYhhYRsxV841C7QMjWhy6zf3Wx5BW31pw
         gvKGdUglcUAsD+GVsno6Rl+On2LQkVodPB+4EGTYl/M/y+Az2c4g+HlS0OjOLwjGYJ0d
         mena0IQyOaJesacPl8wfwWPX4muMIJkMIRTTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1O8U+wUF4iGrPSEsUvPr9Y9g9nT7ZxuOwHXUzTfTnig=;
        b=fQdMPnVaaEkVI4PcFxDCkGNgXWVFCO4D15mvzXcpjAj2kxbb37OnWvcnv4S1JG8+Aa
         bSV+9BE33VXlj1ANo5oO+siga37ke7fuNMy/9GlMr1ZC7R4ycZTCQNhNvZbZnXrw96ko
         KpCX/Cz8rBtT1x+Avfgoq6jDwTczzixUQhZEKSXe4igHIhgOMGwp30pzXTnGtNi+dT0x
         9fztqgSH573ps3kJcSfH0L0xLhWpw1uFTfKRadBE+mBWg+sEJuyBMBIKpqXmacIa9LEC
         VyJlkAK9QnTULOMVktTTRQh5v95iml3hMcfmwGsydvXgLzGS4kaWjIZmsV/hLM8wCeIF
         xCQw==
X-Gm-Message-State: AOAM533/LOvcVnL7iw/Vfo05rmL0Pwiinb8FzHyBduWfrU/EeFYQnMox
        02l4WZ5Kuex+iSJZDD5z1P1UEfVt8Ulmhz+q
X-Google-Smtp-Source: ABdhPJzc8+7KFZPat30qKEL8G7RGSjn0+NwwWnKR38g6vKV9oxC7wz0DfcnEuWWKRv19lInuJInUvw==
X-Received: by 2002:a17:906:478a:: with SMTP id cw10mr15159926ejc.39.1642397923141;
        Sun, 16 Jan 2022 21:38:43 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id eg30sm2953715edb.85.2022.01.16.21.38.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 21:38:42 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id c66so17884337wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:38:41 -0800 (PST)
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr3962110wrg.281.1642397921591;
 Sun, 16 Jan 2022 21:38:41 -0800 (PST)
MIME-Version: 1.0
References: <YeITMG7bKozB2xVQ@bombadil.infradead.org>
In-Reply-To: <YeITMG7bKozB2xVQ@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jan 2022 07:38:25 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjCajUWAZBNrQv3zrrjZBH7e7x2UrQ2n18+yk3TpGD9ag@mail.gmail.com>
Message-ID: <CAHk-=wjCajUWAZBNrQv3zrrjZBH7e7x2UrQ2n18+yk3TpGD9ag@mail.gmail.com>
Subject: Re: Modules updates for v5.17-rc1
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Yu Chen <chen.yu@easystack.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 2:20 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Although this change was only merged on January 11th, the patches have
> been being reviewed since early december. There was at least one fix
> already found for it and merged.

Grr..

And that's exactly why it matters not about "being reviewed", but when
they were in linux-next etc.

I've pulled this, but consider this a complaint. Things should not be
"reviewed" before the merge window. They should be ready and merged
and have actually seen some testing.

Review is good. But nothing beats actually being out there and
actually seeing real-life testing (of course, linux-next probably
mostly gets build-testing, but what testing it gets is still better
than not being there).

               Linus
