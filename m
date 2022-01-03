Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77410483199
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiACNxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiACNxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:53:44 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AB6C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 05:53:44 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id q8so40158385ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 05:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6MTSM0tUGvNPWHNroYDrMPHJ8+MECxnNO9mRPQwxLmc=;
        b=00uAyDZtYRScRscyI8ZuMA/kYZ63Szx7eQk1dv4Y6C3AZcdesqT277Cw/mRscCh2ed
         l5oQlQLYFEWMPCA8EWiSix08hxah9GOyqn9TwMcbnu6vrs5RIbXWmrWcijs3/LEK/7ZA
         u5a0k2oe5MjqwGQaFLQpT4HN6KDmjx6Yn6/8FzAnhn0IZkTJQxB21TdPADYn3ZEDFRFp
         QnlmoMSEdv+G6jEQTurSWUMJNfrfJYf8R/IO8rSkzIAwLUI2e2aMiK4NE/PryBOfhPYE
         bjU2+fYXyiXdTiRxexQatobAjtLo+JpbPkg3bnM22i+H/MBRUx4N3/Pp/OG2VIyPmVCj
         kYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6MTSM0tUGvNPWHNroYDrMPHJ8+MECxnNO9mRPQwxLmc=;
        b=SJxiwywFJWVo4zvDvkPQBV8gN/fcperOqRKLcUP30esyQYI3I26aNPQx2yn93w/hUY
         Wky2J8VcVG/td50wvueC7MEKzn6xAZ08vHERkWgmOJGcXx7jMMo+TYfyNcWoyLS32PbA
         1Q3BKQBkJsScftJ2u0+BWuL23RogLiik/OG+MFsa1Kxru58ZMPrThJCJgkUx289/WnwI
         cJnh5UYao2URhRYpCXi0fHvvXVD1ApO36bwSWkpxGXZvwPZTtlDdUf/HtiL7Zgs6F9Wf
         ZnUX656s3XkTicMqIYRk7oiPJsQdp+lu4Dxf0wUiF1aiLkh3NYHMZjVurGFHNd6UyEIU
         eaJQ==
X-Gm-Message-State: AOAM533QUKUUYs6ZJluhwMUnO2OmnBmYHnwhJmD2T/rsUrhwbsYOaw1l
        RvpEnpBibo/qRj4NciEQ4u7Ixg==
X-Google-Smtp-Source: ABdhPJxqygORPBLOI6WnWvHPQloq/mJxVbJDAReb+F0fiB99BHp6nev1baIgrPJcX3YbI5wPds9lUA==
X-Received: by 2002:a05:651c:204b:: with SMTP id t11mr35902695ljo.94.1641218022559;
        Mon, 03 Jan 2022 05:53:42 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c4sm3635249lfm.160.2022.01.03.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 05:53:42 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1488110443C; Mon,  3 Jan 2022 16:54:00 +0300 (+03)
Date:   Mon, 3 Jan 2022 16:54:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <20220103135400.4p5ezn3ntgpefuan@box.shutemov.name>
References: <YdIfz+LMewetSaEB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdIfz+LMewetSaEB@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 10:57:35PM +0100, Ingo Molnar wrote:
>  - As to testing & runtime behavior: while all of these patches are 
>    intended to be bug-free, I did find a couple of semi-bugs in the kernel 
>    where a specific order of headers guaranteed a particular code 
>    generation outcome - and if that header order was disturbed, the kernel 
>    would silently break and fail to boot ...

Looks like you are doing a lot of uninlining. Do you see any runtime
performance degradation with the patchset?

-- 
 Kirill A. Shutemov
