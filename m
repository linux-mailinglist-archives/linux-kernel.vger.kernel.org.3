Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E21A4684A7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 13:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384883AbhLDMMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 07:12:30 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:57315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244949AbhLDMM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 07:12:29 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MC2wN-1mjKyZ3FT3-00CPO3 for <linux-kernel@vger.kernel.org>; Sat, 04 Dec
 2021 13:09:02 +0100
Received: by mail-wm1-f54.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so4216586wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 04:09:02 -0800 (PST)
X-Gm-Message-State: AOAM531HsRR/jqgWN9FjkcbiTcaPk+Kfey7/hPo93QrA0zc/NCzaXTjT
        EPSH0V5cCNrWDx0oL3/LVfKDUHFw0BkQV++UO18=
X-Google-Smtp-Source: ABdhPJx6+gIsiguCu6Hih267w7mF0d7N6lX+lIw7zZFVGIS8a5z49fVFbEozPQVI9t3aSYfAZ2fGkisJ6dLSfwjvXsk=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr23528076wmn.98.1638619742408;
 Sat, 04 Dec 2021 04:09:02 -0800 (PST)
MIME-Version: 1.0
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
 <163477772593.264901.7405996794526239017.stgit@devnote2> <CAK8P3a3jCGWjauD0+k5C-VpLDQ8WkcCHs5UpoAb-x_yHU0eEkw@mail.gmail.com>
 <CAMj1kXF3ZQ__trDo4PDfBmJsNoiqBkNB2CLK5pTFARTEYzDOzw@mail.gmail.com>
In-Reply-To: <CAMj1kXF3ZQ__trDo4PDfBmJsNoiqBkNB2CLK5pTFARTEYzDOzw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 4 Dec 2021 13:08:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1m01-BZRjtMwV3qPbx0H9SyuL0BgLvTXbHMxdgN1Ky9Q@mail.gmail.com>
Message-ID: <CAK8P3a1m01-BZRjtMwV3qPbx0H9SyuL0BgLvTXbHMxdgN1Ky9Q@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fxExmDUPhLBAtf4+OIwKL1cakIiYQNN3hU2VlqnQxLNJQRjJ+GI
 8X5QTll6w6wq54TS7gQdIXUo04Klha2iBsdgxm1W4tuRAZ/E2Cxp5Q5LJUP4QyMZ70n0UJI
 3mCo3ojkOX3vblpWjU1eNOZNUuDerYyNhPYYYQW2meN5MF9pHrpp2bWTnpluX66kjDtS75f
 BuqiTuVgnWDm/nCvkMVEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kjDpUAS4ua4=:d0/PwsqfoTPacWlijMDA3m
 BZt9BGwZEZX1W23BVjPQMI1Fbn6zVETf0xdUqO4BBypDJTtEMztbeIXUI1ZmlnQJLCVQ0I00T
 Ev2zqUupUHvFQWy6cEqGED7Gfx0JKP0Zjnb8k2vn2DPZkK1uUHFZnHGnumaAfWE2d82fnzGFa
 nahytGtDolIflW6TaRtjUgajxaHel/4YTxRpx0/enPUyIYHYH+ivFmIEhSXOOW1L4PuWx1HBR
 bK1bhUT0/mvweV75nEh7y9wiXe9oSJniYj+f1zH8v5fetDsQnDuDeqrImkqbHsSgI9IEbCcxM
 kSe/pGOaVt/o06hvy+8fPy9dMRA6SRje0W4Ay3T2Ou+3flL/AvyfouABBXJsv8KVaeP/6vbok
 BN91C5vwV7+1ri7zCcUlzwBsNNGA04QRpLq5diqAoJXBkt5l7lYjAG2C6iyW6MW6naGkhNqVo
 viRRc+NIx5yME+gODa9r9ZTdAkAtExQWm8pQrWIt687sscDHYx/np+SilbT+dQEe40E2fUaNf
 rLkRZYdY/Eh/5M0BmszCAEBO6PTTCcjAlo6WyVAOeftp5R6/8mh+7oEc/Vtz6rdUuaKbg5ZRW
 VuqMwHC5IkxZTC0v41jLm+FQeB9XHQaBsg5nf+rE8n8iAx94AUqLu1LPEn84gbXl/Z9YBe4V6
 /2mzDOsYS29i9e/IZdYbSWmxbZ9exIryAax975DZWQMK1W/L2ftWD320V08xxOSiVuHU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 9:45 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Does this help?

Yes, this fixes it, thanks for the quick help!

       Arnd
