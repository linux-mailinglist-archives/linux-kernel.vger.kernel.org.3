Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712BB49BAF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348723AbiAYSF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:05:56 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:36745 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379751AbiAYSED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:04:03 -0500
Received: by mail-qv1-f52.google.com with SMTP id g11so20012067qvu.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=X5xSUtxbeAyvevWZK2Q3SF/O/W53Q2kYKgU9lvVdnVw=;
        b=ZCsoCj879E40RA6oRgMW0IgUOr/D/cYb0GAFhzgKOzVtEVmM90UZIDWvHoBa6XAEMl
         aJ3CPQqvnmd8gMsKVd1yLFfsnWAWmVALYJJnnxPskQ3ivHxjNym12A0q1stxU5SDIgZS
         rwLrYCH9VLXFdiOoPC6at9EHPTNCsgT4GT5NTAfcccdrcXaen3/JftIYvbB8J3I/DUVl
         mRISfy2Bf+zHrOJ+/KLQW/y+D3U+KiUuZ2W6tgwqgdDCoAlrynzEcdzD5M8DKQlIrBGq
         Bxgz2XMoFwMrZLezWRGICpmKiw3q2cZOzf1wnEMAIe0Z/F5uGO8Z5Yfqn/jeWuh45+uY
         fKxg==
X-Gm-Message-State: AOAM530klkJt3oW1UCFgb+EB+bys1jwhT0F5RyQJXCBxGGwVdlArE8cl
        PEf27OodzQWsv3QQKwWK6ZSrDki6Bz+ig2tYPmpN+KhHgaSldILA
X-Google-Smtp-Source: ABdhPJx5vps6qWlHIMdeB0kIJjfk262CwxPlat/2wfRnKvBQWUWMZKhrnbFB+rIhUhbtD9NcZC5K0JzW1Icr1Se3Dpw=
X-Received: by 2002:ad4:4eef:: with SMTP id dv15mr20898852qvb.52.1643133841803;
 Tue, 25 Jan 2022 10:04:01 -0800 (PST)
MIME-Version: 1.0
From:   Aleksey Senin <aleksey-linux-kernel@senin.name>
Date:   Tue, 25 Jan 2022 12:03:51 -0600
Message-ID: <CAM=k+5qEfxHOFkiXfobJERr=gMQ9jgcxgpydnkJx3ed3uPPsQg@mail.gmail.com>
Subject: Using memcpy instead of copy_to_user. xprtrdma code.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This specific patch -  - implements using memcpy instead of
copy_to_user. Why is it considered to be safe in this specific case?
All readings about how to copy data are mentioning to use
copy_to_user/copy_from_user. Why use direct copy here? What prevents
the kernel from failure if the page is not present or doesn't have
required access rights?

@@ -103,8 +102,8 @@ static int read_reset_stat(struct ctl_table
*table, int write,
                len -= *ppos;
                if (len > *lenp)
                        len = *lenp;
-               if (len && copy_to_user(buffer, str_buf, len))
-                       return -EFAULT;
+               if (len)
+                       memcpy(buffer, str_buf, len);

Reference to the specific patch in the services of commits:
https://lkml.org/lkml/2020/4/17/60

Commit itself:
32927393dc1ccd60fb2bdc05b9e8e88753761469
