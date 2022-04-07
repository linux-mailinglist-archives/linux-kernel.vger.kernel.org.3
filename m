Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776824F8B76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiDGWqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 18:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiDGWqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:46:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825B0158BAE;
        Thu,  7 Apr 2022 15:44:12 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d40so4560204lfv.11;
        Thu, 07 Apr 2022 15:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HJlepzhu6kFGZpNUHD7UiyAi5m7cYQlLKseVVvUSnro=;
        b=YiKpP19xF/xjxsB3QDngc/pUeSy7Uept25JrcxpKlB7+HQMQ1Q3xtyvfx5uTDdpSjk
         Oo3IbUoZw12BBW8OSr8lvDZWdOq+xrlE1Mkvwbxq8gxvasUNVuE9b7sFMLuzZ1OgqrCF
         en2M1UrDMmNnF8EZAECtv0bkfjNumsJRZOGsgfvWHKaEGgUQmTrMNrRKezTgI/V8yrRt
         ZqG4lxreBLjRhEf5zdAoGD4VvwSt6bWY5WUG9j9BoWchFuZQ6r8ivcKEx8QYWHBNk5wb
         8EqmRBvLmCnS9lET7gE1UBOY6bhJTd4z9IWXtm/LEFB3wIsBikZBt7J2BXGMrVgnlzf8
         qgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HJlepzhu6kFGZpNUHD7UiyAi5m7cYQlLKseVVvUSnro=;
        b=aORBu8O9zqWr8Y+ZEOVTtbt8lqh9qVRlZw4bcUKShGuZfJpVS7QKdYIoMvGfh2C1fz
         blZFteCXGxOieImI9Oqv6gFMG53aBzpURk8ItJscoMVgEsZBEjpZYWxaE/oKkMJ/3Cf/
         xVwn6isF6Kbg2rNMMYrFxYOhNsIWgwDQhvvhZJbIe/IQ+g/TR28ib+7b+7kt+ioL0cvA
         VnQKJzEoE0Ozaq70vXdOuIP1fnIRxkdiwXQMIJP6RRNubgQJaleKEWEqsUcIKjN3XBZs
         XjBRuPD7tFXY8mKgU4pZrxXjHCDvQX/jcWjw9CdUYsSsCJ0aJk2kPoYobij5L9foGYFn
         Cf5g==
X-Gm-Message-State: AOAM532E/13layVUxBtayjNClUQFeIm58+PHwBTlY5dDIbJoQ5c5hXsY
        WIfRuFaCEgFUzWryyB5UBwFlVjbqCweSMI5XR/dm0tqkmLk=
X-Google-Smtp-Source: ABdhPJygsDfgRZwIwSLLoUDCDuI+ITQaOst6G50fUoYW1pUGkUlqwb4oIu2z6TJRTUlc8JNrFLKUyIQ3hLrl4hSXtm4=
X-Received: by 2002:ac2:5444:0:b0:44a:846e:ad2b with SMTP id
 d4-20020ac25444000000b0044a846ead2bmr11086962lfn.545.1649371450768; Thu, 07
 Apr 2022 15:44:10 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 7 Apr 2022 17:43:59 -0500
Message-ID: <CAH2r5mtTvgsopF33=mxKxMW5WJDs_ErLGG4p-PPofDEM-cwwkQ@mail.gmail.com>
Subject: [GIT PULL] cifs client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-rc1-smb3-fixes

for you to fetch changes up to 7cd1cc415dd8d0dca7244c9eafb9a0adc8036805:

  cifs: update internal module number (2022-04-04 22:40:14 -0500)

----------------------------------------------------------------
4 small fixes to cifs client, 1 for stable
- 2 reconnect fixes, one for DFS and one to avoid a reconnect race
- Small change to deal with upcoming behavior change of list iterators

----------------------------------------------------------------
Jakob Koschel (1):
      cifs: remove check of list iterator against head past the loop body

Paulo Alcantara (2):
      cifs: fix potential race with cifsd thread
      cifs: force new session setup and tcon for dfs

Steve French (1):
      cifs: update internal module number

 fs/cifs/cifsfs.h   |  2 +-
 fs/cifs/connect.c  | 15 +++++++++------
 fs/cifs/netmisc.c  |  2 +-
 fs/cifs/smb2misc.c | 10 ++++++----
 4 files changed, 17 insertions(+), 12 deletions(-)

-- 
Thanks,

Steve
