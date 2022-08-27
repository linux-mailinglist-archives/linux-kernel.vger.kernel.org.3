Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB22C5A3A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 23:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiH0VoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 17:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH0VoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 17:44:03 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A954A83B;
        Sat, 27 Aug 2022 14:44:02 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id j4so2228263vki.0;
        Sat, 27 Aug 2022 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=4NM+stoN5Dc3SGPld/SqpCYaP0qnQoboXzTlMHom+QM=;
        b=FCgBK45gNST9ZGGp7Ocmb8PKbqlT6GBuAZkSCHCIOkyr1wJye+fejeY+k4rl/NUrbQ
         LTcYRMD6R0PUSP1VAwdrvHL4DYEX9VmohR6+XX5SrG+2jWNn5R4Vl+Zhxkj17CZ75h0E
         PXIx2R8/A2cU6Qh+kAtWPDUq0St3pi+YvWyxGhgAvt2St2ayh4WdMLORYALhTGGei0UL
         Qp2vKSvtXmL4aihQLfdJf8SJk8XCKxNc995zpX+ow1Jrz+nSIhkVpyJgIWH0oZ2F2jBb
         TMv2FnZ84FUdIu67A5Yt/s7JoBvsenLSeGkO3UOjoHxo8Fx8yU1sjvGDjV3xmvy8AB+6
         qhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=4NM+stoN5Dc3SGPld/SqpCYaP0qnQoboXzTlMHom+QM=;
        b=uyG0RqQT/4q5h2i3Pv1f+3ABQ01Iqx2VJVUMifYu3jVDPnc/l480JprBQuh2FDbU4c
         YrIC9obwtAfrsmxb8kGI2vSbVTqwACtD3xEALTXWqJvlZg5CnyV1+RIjgYVhi2IocZTi
         Wd6r4B5EpVENWEhJ7DlEdxt7bs32EI4zs6M+mPdMS5Rxqz8GJgdpJ8QxBeNQbV0d9/K7
         NdqgewWW7Odu1qydZY8/922dlKv2rpZnqb52yDNNKqepcGUOsNptAal7WnuEjHDALDXq
         G20zW+v6UFH0iZ+Mi03nJKptUVg5tHQbZkBh3A6YNkhHFc4iUjqZOgeeyOuO63fPoI7I
         I1gA==
X-Gm-Message-State: ACgBeo3LepMNjX3EokiFBcGSx+zT0qxZRjRqGKkYqz36ODZ02PaRAJGe
        X4382YQLmEMy9jH70W7210Z1wNW8V37UW5Y5T0cNny0J/KhbSw==
X-Google-Smtp-Source: AA6agR5qugbEIuI0XrX9PanbeqDgXSoCLyzD4gxuK6cG+apOb1srdpEaHEr3+tQGqNw40DpArlPydzI7axxBaJie8GE=
X-Received: by 2002:a05:6122:635:b0:389:9ad6:f974 with SMTP id
 g21-20020a056122063500b003899ad6f974mr1681356vkp.4.1661636641675; Sat, 27 Aug
 2022 14:44:01 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 27 Aug 2022 16:43:51 -0500
Message-ID: <CAH2r5muNM-NJOc0pehkN8gh3=UZtq4P1N_baW4sdZHB7FyPHCQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Please pull the following changes since commit
1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.0-rc2-smb3-client-fixes

for you to fetch changes up to d291e703f420d5f8f999fe54f360d54d213bddb4:

  cifs: Add helper function to check smb1+ server (2022-08-24 22:30:09 -0500)

----------------------------------------------------------------
6 cifs/smb3 fixes, three for stable:
- two locking fixes (zero range, punch hole)
- DFS 9 fix (padding),  affecting some servers
- three minor cleanup changes

There are a few additional important fixes (collapse range, insert range) that
are not included since still being tested.
----------------------------------------------------------------
David Howells (2):
      smb3: missing inode locks in zero range
      smb3: missing inode locks in punch hole

Paulo Alcantara (1):
      cifs: skip extra NULL byte in filenames

Zhang Xiaoxu (3):
      cifs: Use help macro to get the header preamble size
      cifs: Use help macro to get the mid header size
      cifs: Add helper function to check smb1+ server

 fs/cifs/cifsencrypt.c |  3 +--
 fs/cifs/cifsglob.h    |  7 ++++++
 fs/cifs/connect.c     | 23 ++++++++----------
 fs/cifs/smb2ops.c     | 67 +++++++++++++++++++++++++++------------------------
 fs/cifs/smb2pdu.c     | 16 +++++-------
 fs/cifs/transport.c   | 21 ++++++++--------
 6 files changed, 70 insertions(+), 67 deletions(-)

-- 
Thanks,

Steve
