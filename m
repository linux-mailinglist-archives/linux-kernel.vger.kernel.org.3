Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB7B46FCD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbhLJImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbhLJIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:41:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E440C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 00:38:25 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id k64so7822144pfd.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 00:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/skXCn/Kvartrp3IdwTGEm49Q3dI9xZw4j/EZZZx3aw=;
        b=YcXqvZL14qLY94/4OGtuFAzU4f1n5jemvWN5CbOMmTQ7I50/3vvXYTbRvEbiqwXlQt
         FjTP9+CiMSpj1UIzGJSGslYgpCuBkLrBhYEGxKNS7X1AdBbUqdI+iJ5GYgSmE/6EnGcZ
         x6QTaW+tvBJq3vDoX3EQBMAlMsaHDEIpIpvft1L3VFQQ4Zp9iAuYVZicxmhcfEitvMp7
         CH4ngoaIQoJjlYUWWykNMKYm0s+yWPRnPBoJYAwYAaUMj7fu5UR11HfIVT/P8dBr6JMF
         8pGtY3JE7i6gxd7sZp8p4BPRdIcMroPtCstnu10Sh1txXZZ+37Z1RFHANd0O/J0hMLXo
         xWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/skXCn/Kvartrp3IdwTGEm49Q3dI9xZw4j/EZZZx3aw=;
        b=I5x+El1irpMapB+uIV3hRF3agW12zr6lNxxW349qmdn6t2YwwpwjkSrseevZua4TZd
         xXkLyud6g26avMdeXFNP67jzHyCTS+CW7RmgzTm4Bv9WIet755UfolrRQ4tjwsq1m68k
         xsBeJHAu2znwp+sLeHGax1gE82KCTDv+Q2usYZn6knUKjwueztRetfokjHqvYBr6f9DH
         fJt2Mc2uRHBfGSU/x+ztTuuBA+D0Q7sMeSM+BOBAlqM8JtT4eKXn7a6oZ38n/2M2Qsv4
         jcBsOfyZIR49TWZloFf9hBg113FLDwg1uJgjKzupGP1MIc7rFErSFCnlqBxsjJgizOTj
         Gu7Q==
X-Gm-Message-State: AOAM530o3vXZ40Wxie+K/0J1dVUK9V9gv8Obd27KWrJj++ftpYpVFXx6
        pebhswXAFZNux0by/kbzIpbsMYXPbw0=
X-Google-Smtp-Source: ABdhPJzmQkRA2v49BENkaeXZR2CAqmcGBick4Ek7PWxSno3HASEh4ZHEkSbP5pZmJsdWNLXzIqcgJg==
X-Received: by 2002:a63:eb4a:: with SMTP id b10mr38084213pgk.78.1639125504571;
        Fri, 10 Dec 2021 00:38:24 -0800 (PST)
Received: from [183.173.151.43] ([183.173.151.43])
        by smtp.gmail.com with ESMTPSA id m76sm2119455pfd.160.2021.12.10.00.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 00:38:24 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: ocfs2: possible ABBA deadlock in ocfs2_dio_end_io_write()
 and ocfs2_move_extents()
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <8ae1bb9c-3e58-c8b6-8823-3d2ea8b241e2@gmail.com>
Date:   Fri, 10 Dec 2021 16:38:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My static analysis tool reports a possible ABBA deadlock in the ocfs2 
module in Linux 5.10:

ocfs2_dio_end_io_write()
   down_write(&oi->ip_alloc_sem); --> Line 2322 (Lock A)
   ocfs2_del_inode_from_orphan()
     inode_lock(orphan_dir_inode);  --> Line 2701 (Lock B)

ocfs2_move_extents()
   inode_lock(inode); --> Line 916 (Lock B)
   down_write(&OCFS2_I(inode)->ip_alloc_sem); --> Line 936 (Lock A)

When ocfs2_dio_end_io_write() and ocfs2_move_extents() are concurrently 
executed, the deadlocks can occur.

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
