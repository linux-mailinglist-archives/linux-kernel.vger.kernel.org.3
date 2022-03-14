Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E374D88C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbiCNQGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiCNQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:06:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527F93ED1A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:05:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e3so15019606pjm.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+GHSIZWbldDa2FVpwLZB/gCRmp5zpsYyc+3O9qj4Cek=;
        b=mDN9JUG3JrOI7z8hdxpyy3uSnNCeh7tCuHAVbCbiV/3mEO2I4sMVl23T2R0mhxhyEW
         NefYyeGDpdliCSA8dwAHOftOU06Rv2QW6VC+piXKzGJn4hcRSXF39WKnWuPIXht9QiES
         8HZyS5c1YAPRROTRi+Sg0rMEECqIDhxnvyfPRY9Hu3Gk0MxaDYFlK8xfuDEzPh7cNsYI
         GNYVaiMlJGf8nyngf00vYnvbn6Su269EL0CFO3X+/MnQd3trWIKw3llte27hdFGxpshd
         hP93ch71q16bN4C6sBCQO/0tCHCnZqVIvlFKi6XYpgiiMgpg4lyGeyyC0QXumcXUX/HK
         cltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+GHSIZWbldDa2FVpwLZB/gCRmp5zpsYyc+3O9qj4Cek=;
        b=H9dPRGanvJ0+tNRXMksdvpX0SSNjyMYQlDigHhymh49Wg5iZ2dJQhILfME3xx1/ZSY
         DNuOq1AyJ89P2KzNTcOZKBVWYTm0iuPG8SyCAS8ThOJOg6lk5Zmu0nswHn1uH9htqOEp
         9Z2yMpXiMUMGFDJ/nQOAGHMe2Rq7WHFDvNf0YFB0i+h8CUxEAvp/z3xqgYt0ucLYyMWg
         knAeFBHrcNn1hvPf1JbJn76b1NWv7I5SLdNi1HGkYX8eOby+MUKIFi8I5APYpAwxaz9A
         Xe/4Ex0sz2QiblUcCBCasf05k5sFl1QmWmNvTSpzybcG1NH58nh0X5EbiRau5GHVXAbV
         unRw==
X-Gm-Message-State: AOAM533gwKSOxDrYBfI58dYgbptuyMnpOgNFbCKicShkdUzymffpeJML
        Jendbzi49NEsmCR4HwonDPrAVARbXRw6hQ==
X-Google-Smtp-Source: ABdhPJyVrlEszj+yUtL6yQtdWk0g4ai0fwrhtIaPhAJwfqymJGqz8YhJN7V58EOqCU0NalqsvTEkVQ==
X-Received: by 2002:a17:90a:f2c2:b0:1bf:b1ab:15b5 with SMTP id gt2-20020a17090af2c200b001bfb1ab15b5mr25500483pjb.133.1647273934673;
        Mon, 14 Mar 2022 09:05:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ic6-20020a17090b414600b001bf691499e4sm21367073pjb.33.2022.03.14.09.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:05:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Mar 2022 06:05:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     syzbot <syzbot+97a16334dbd58916f7fb@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_get
Message-ID: <Yi9nzLtJRhtNXc8+@slm.duckdns.org>
References: <0000000000006b04e005da2df2f3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006b04e005da2df2f3@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 06:49:19AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    09688c0166e7 Linux 5.17-rc8
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b42729700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6da459dcfde3b8d0
> dashboard link: https://syzkaller.appspot.com/bug?extid=97a16334dbd58916f7fb
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+97a16334dbd58916f7fb@syzkaller.appspotmail.com
> 
> usb 1-1: Direct firmware load for ueagle-atm/adi930.fw failed with error -2
> usb 1-1: Falling back to sysfs fallback for: ueagle-atm/adi930.fw
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> BUG: KASAN: use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
> BUG: KASAN: use-after-free in kernfs_get+0x1c/0x90 fs/kernfs/dir.c:496
> Read of size 4 at addr ffff88801ded39f8 by task kworker/1:2/2510

Looks like firmware loading and usb hub removal racing? I'm not sure there's
whole lot we can do from the kernfs side. Greg?

Thanks.

-- 
tejun
