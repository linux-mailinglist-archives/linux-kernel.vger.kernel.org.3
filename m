Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D3C47D773
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbhLVTKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhLVTKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:10:39 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99012C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 11:10:38 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id j6so12302841edw.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YtOIVLoHshb9zLgW0R68gpfla6ASw8NyT7FKH8bioNs=;
        b=JRd6FVluPE6ItgncVXI/D9fn81ogjZbQeqfD7O2ci6SCgKlpfuzTnbiBFb/hfbLWdQ
         kG6w29YDi/6hLaNH+5h2pwS5NmPZgzgKsjNCSQ6rpQYbEsMg3bdyZlvVxkhzU50Ut+cM
         YqkJZ1/sHIpt098kb3w7p+kOGJ5CNVNZOsUFudWr/ry6ZVxbEuafrvTjWkvFBpzm946w
         KN5U+i7ayXG51BNBKuDZUSxxeqQc6j6BiA4/ncHsrPsN4N9g5PhOQ1t8LPKBJ75rf3CE
         eOZt9ZYOJ1SreomNK8npnxC89OVVSsUI7kQ2IZfF+fF5lHF8NCrSv8aQHVhsx676l8IL
         UHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YtOIVLoHshb9zLgW0R68gpfla6ASw8NyT7FKH8bioNs=;
        b=7QTRTv7b8OsTPteRJnM6QLqdRXCl1FtFBIBYB5pni1/CJFFQRazF8aakvDWuvuoGm1
         f3t2gr3Ing35ITnQGt4RWLucLU+y6yAKRFr6XNRA6VpxtG6wQejpv509RLwsWFVGuirS
         sL56z1yrP2eohwVvHW7CMKZeDrpFWsZv31iQkBOs2sG0p9YGXDsu/UeIYEFd1XiRG0qY
         LXwbTzrB6m4o5OcJs0MZS6K0W0sOJCdefpAUNmM3n/0QuA8Ani78jIKb8xlAV/pKY3VK
         ZVK8cL1S7k8j09dHiu2XHr2AJhwyB9ll0TxjeRNy+fxhe/yD9j9TdjX2CTpBrkPTyZur
         aX1w==
X-Gm-Message-State: AOAM531y1bHXzutWPSrhV4khzdZ4rOyh9FCzK1GR6iUucjO8GEhPt05E
        FXPiWugeVhXIGaGdtfVnr5jW5DlcpDtyYdjUiwAAGuEZQ9Rr7w==
X-Google-Smtp-Source: ABdhPJy9U6gOJYgSaOoRCldpqp1LukWiZkvBHwNRKmA6u1HUG2zWfECszqTWI1kPlefwEPE9SG4wS41hO3zhskS1dXQ=
X-Received: by 2002:a17:906:a3c6:: with SMTP id ca6mr3496688ejb.639.1640200237025;
 Wed, 22 Dec 2021 11:10:37 -0800 (PST)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 21:08:39 +0200
Message-ID: <CAHp75Vdjp9_67xe0PeZ9LzcJ=eNxB0qVqPJqtFEvh3SDgcdODw@mail.gmail.com>
Subject: header circular dependencies
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`make headerdep` is full of printk.h circular dependencies, like

include/kvm/arm_vgic.h:18: warning: recursive header inclusion
In file included from linux/printk.h,
                from linux/dynamic_debug.h:188
                from linux/printk.h:555 <-- here

I'm wondering if it's a false positive?
In either case, can we teach the headerdep not to complain by fixing
the culprit?

-- 
With Best Regards,
Andy Shevchenko
