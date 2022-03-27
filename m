Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC24F4E88FC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbiC0Qu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiC0Quz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:50:55 -0400
X-Greylist: delayed 81 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Mar 2022 09:49:15 PDT
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD422B1D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648399752;
        bh=vw4W9bVJMiNkljXZ10sTQBSfdwZmVEGDdSStOzPsh80=;
        h=From:To:Cc:Subject:Date;
        b=fuNBja7+BhlMO6YuZRp7O+4YX7nymMqAlNz8NfL2mp0pYZE4cgUjUS6ktDKeMvhfw
         cSYtNPNdbvqS9ETHJgGzQLFm/eHA3aaWV2nmNYg0PtZocumX5n9fDFfnoF006K23RV
         T/HMFbiE+ipszSOIDbyu6Q1zabr1ffns+k9dZrmI=
Received: from localhost.localdomain ([120.245.132.52])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id BEF2A844; Mon, 28 Mar 2022 00:47:47 +0800
X-QQ-mid: xmsmtpt1648399667tlb3y4xea
Message-ID: <tencent_BD6D4CB98B6D7FAA04F63D28F6457F10F40A@qq.com>
X-QQ-XMAILINFO: N9ac962MYdaQI8JmvpMXs1D0cKUe/X5p8kMNGhsvS/GIyjZWryGFu2A++pL2Wm
         51+aYaC1CLp0PFmlpf30msASKlPkEYHeYX+30k1iRh7BXABFsfY+BfnK0X+P2m7pMIfGBJTQdbVn
         R8q1fC6NLabS9pa1qRq8yeljY8LMGfFi+XEjRzBorGh4yVkJJhuH0rKG4KzKrLPeTZ1pJuakLFn3
         nMyhQGdw2yMgaWnZ/eDTk5t4O89U9a5ZiturHaIfyILxsjXJAOtOMHVjZgX1k4jw0PsKy/KxpsIA
         uNJPhFiwWgtiiP2qS4svAeCJrgUXTRR/cWCKS+QB7Q0Q0YOiMh6l0HuCl8b6VYi+n1lEdjFZhc3d
         Zie5acf57Qbw8ZDoLkK2QaS32S0RgNgC4PzCdQ9ew/T/hZr5gnMDax5mZDSYoqGR2dI/ovKeKZR4
         iKrwzxvaTsVwS5ArMjzIkP2mmZoMMloqnmo1WK47KHDdf4hpk9XmOZerEptLBOJ2IT1GSHQbXjlY
         2+IX2+vObBgbzwwlmV2T5yb/2Ug8aDTXLJ/AOFgO3H//ZVgdLn9/fNPcyMcKLANVw8857QDA29uX
         4mQVatneGiswe+X3jJYe95/+YTozbaMED2llRJLHermw8924tRDt7A8tfyJo2BulvPyjNaQ7n7Aa
         ogVdklNT2KQmeDoTN8eQlpUpxyJ+aA8qbIyKT7rlv8s7wNSaKsGZgDqaJicWc0JR1OrZ1sNQ7UYs
         yOKK1XQciQb/vjkobi1Xx2aNw/JDt1YGrUJcQNJuk6RVMUxm6NuqlTKUj0+9eizRzJkQGpVaGqQC
         Da9lE3UIZTo12TvgAmnrGbnkRCgX89Pq5MYLevyPbQydqZg0geAvUkjp0Von6+j/gTtA6oHNyaI6
         3LVyx9DWuje7fbxp0A6LDWU9GsmC5qSpa52w63ECVwU39gBa0bLaKAv5i6iTalQlVu+P+mmOpTHB
         GgZO5zdk4hbNqR/ei69hk9TGTEK5hV3leHY2cNklc=
From:   Chen Guanqiao <chen.chenchacha@foxmail.com>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH 0/3] ipmi: msghandler: check the users and msgs causing the system to block
Date:   Mon, 28 Mar 2022 00:47:41 +0800
X-OQ-MSGID: <cover.1648397283.git.chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, a scenario has been found that there are too many ipmi messages in a
short period of time, and a large number of users and messages are blocked in
the ipmi modules, resulting in a large amount of system memory being occupied by
ipmi, and ipmi communication always fails.

Frequent calls ipmi and failure of hardware communication will cause this
exception. And ipmi has no way to detect and perceive this problem, therefore
it is impossible to located and perceived online.

This patch provides a method to view the current number of users and messages in
ipmi, and introduce a simple interface to clear the message queue.

Chen Guanqiao (3):
  ipmi: Get the number of user through sysfs
  ipmi: Get the number of message through sysfs
  ipmi: add a interface to clean message queue in sysfs

 drivers/char/ipmi/ipmi_msghandler.c | 159 ++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

-- 
2.25.1

