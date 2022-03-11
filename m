Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28CB4D5768
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345356AbiCKBd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345360AbiCKBd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:33:57 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB069972E3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:32:52 -0800 (PST)
Date:   Fri, 11 Mar 2022 01:32:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1646962369;
        bh=QwZDFWa+hj+czammg/GqJUDVTdjcC7UxItWq97HZnpU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=jLuFrzSniJy7x/BjbxJ7amVd2cSnyzFYiZ0IkOG7FaxP+YWmV+7tHkj447i7HVC18
         qCbBIN0+MxBDZWEMDwu/SyyUH6RN4FSFvYCavOE1SExo8vqtyRH6zdSXn4LbtU2sqb
         3v+YKkNUenXdiIldxfHKnLIXMxqYk3VIWEUI5sRu4W9Gfp2/QTxHt+rE7Cb8kb8r5R
         5+3Ot2/H1tGZrhlg314Ymvzi/ZpTkygeUmqeJFwneIS7r4ZXP9rf1WbHQWoEanvq4H
         mgd1jPRwF4Kn0dqaSomAGdtasx2weG6WIp8LNPtTqrrTJwJNCuWI3C2wOawY6Og3lW
         R/z+Maa2+NskQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [RFC PATCH v1 0/2] add type-safer list_head wrapper
Message-ID: <20220311013238.3387227-1-pobrn@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there have been various discussions[1][2] about improving
the current `list_head` facilities, I would like to
propose a type-safe(r), lightweight wrapper: tlist.

The first commit goes into details as to how it works,
lists some of its advantages and disadvantages.

The second commit showcases it in the existing WMI platform driver.

NOTE: these changes are mostly untested! They are purely for showcasing
a possible implementation and API. And they depend on the switch to gnu11.

I would like to get some feedback as to whether/how acceptable this
approach is before going further: writing documentation, tests, and
adding more wrappers around existing `list_head` facilities
(e.g. reverse iteration is not implemented).

If this idea has already been proposed, I apologize,
I must have missed it when I searched for similar patches.

PS. I have tried to select those who may be interested
in this discussion, I may have missed people or added
people who aren't interested. Sorry.

[1]: https://lore.kernel.org/all/20220217184829.1991035-1-jakobkoschel@gmai=
l.com/
[2]: https://lore.kernel.org/all/20220301075839.4156-1-xiam0nd.tong@gmail.c=
om/
And see https://lwn.net/Articles/887097/ for a summary.

Barnab=C3=A1s P=C5=91cze (2):
  list: add type-safer list_head wrapper
  platform/x86: wmi: use tlist for WMI blocks

 drivers/platform/x86/wmi.c | 54 ++++++++++---------------
 include/linux/tlist.h      | 81 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/tlist.h

--
2.35.1


