Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F6654AF5B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbiFNLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiFNLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:33:54 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E4F4090B;
        Tue, 14 Jun 2022 04:33:50 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-30ec2aa3b6cso25952487b3.11;
        Tue, 14 Jun 2022 04:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aQCHD8TYAVlZR0413zgla4M7zGjkgHK1BYJdrHmcBtg=;
        b=W3YOp8+Llm1RjUKQKSdz5ypS3lVt61deoFSQSZkdR9ZIYo/QytA4B60dkRtQVyq81Q
         oia1aOtw8LjO8EWMJWkt7NiYWjfYwcEG6IudtpTtEh/A7+YZTnrcIpUjuK+gjKWA1Hf+
         DOaV6TzA5xfR/42u8jTiUtIB1hFpAUCcTLOn0tjXsrdTirROREmyTzQbODt5BAd+TveK
         sH/fquNVLUa4Lt6hrWs2YRJrc2ucH7CMN2MBUivphcHzx7E+hHdW5lkFgl1NMBVDnzwO
         iDeZSwhEmKUpHmFHWJL0N+HD7rVDZcPH4mBvzYeY4/sTwuxdbJusewMQgp+0fMOyWl+b
         Gyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aQCHD8TYAVlZR0413zgla4M7zGjkgHK1BYJdrHmcBtg=;
        b=sZATi97vyjob1DYpGhsko1ePJqmiQ+OjJQBvQpb+7z4mmk0XIPPwagfAJX6d9Nsbn+
         u/6o6XOtn8I7/eS8jmFrwUdn5mauqoGf59+qZDX/dK0sxQlt7o4S+q+F+bg3lPA5qd3P
         d5Yg5WuIU+Dq4rQ/Xee0Qm6anOW3QQeWBrogFEYn8KCZMhIstmnwlsSyB1PY0V72943m
         n1/ShXLyCYYumJGqEVUrx/A1hXTkOIkCioi0vxEvALukJEd0KrKywboZHxg5g3oP1nOZ
         XNkG2ynaE71jiEeyDaxlhS7qTpdoyh70Whq3VBQe5gkf5UBj4szzSGY4KiW0td/V5QPW
         egEw==
X-Gm-Message-State: AJIora8zFrYIvJTb04+OsM1gZmXwPYlEG2nWGh9/pVTOz9jwDjC97WWF
        Mnn/pbIfNyaF1JHEVpA2gNy3Rbrk8Phem5aJIYI=
X-Google-Smtp-Source: AGRyM1ut27JCQ8mv5IUs9u8PZmcphZfw636b8ePw820EY2mvjW/j2kyPN9Or6Oebof6zY/BKZgXS1s3UMQ+shhOTcNQ=
X-Received: by 2002:a0d:e691:0:b0:314:34e7:c562 with SMTP id
 p139-20020a0de691000000b0031434e7c562mr5090486ywe.237.1655206429176; Tue, 14
 Jun 2022 04:33:49 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 14 Jun 2022 13:33:38 +0200
Message-ID: <CAKXUXMxs3waRA8pveFQ2LRMF5imoHxjQ0zfLS_4vpfr2YSLYPw@mail.gmail.com>
Subject: Issue in count_mm_mlocked_page_nr() with commit afcf76df48f9
 ("mm/mlock: use vma iterator and maple state instead of vma linked list")
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Matthew, dear Liam,

The commit afcf76df48f9 ("mm/mlock: use vma iterator and maple state instead
of vma linked list") refactors the function count_mm_mlocked_page_nr() in
mm/mlock.c, such that the special case:

        if (mm == NULL)
                mm = current->mm;

is now dead code. Before the refactoring, after this if statement, the variable
mm was used further in vma = find_vma(mm, start) in the following line, but now,
with the introduction of VMA_ITERATOR(vmi, mm, start) before the if statement,
the assignment within the if statement is simply ignored.

I assume that:
- If the semantics of this function shall be preserved, the VMA_ITERATOR macro
needs to move after the if statement.

- or, if the consideration of the special case on mm == NULL is actually
obsolete with this refactoring, it could be simply deleted.

I will keep it up to you how this issue is correctly resolved.

This was discovered due to tracking all dead stores that clang-analyzer reports
on an x86 defconfig. The underlying issue here is more severe than "just a dead
store in the kernel code base", but it is probably easy for you to resolve.

Best regards,

Lukas

P.S.: Sorry, if you get this mail twice, the first time my email
client tricked me into unintentionally sending a HTML email rather
than a text email.
