Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD74EB19B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbiC2QOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbiC2QOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:14:33 -0400
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72191877F2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648570366;
        bh=plXQD20lQSzZsGQoCpi+P8XSYcFNpRSGduCnfS0GTkU=;
        h=From:To:Cc:Subject:Date;
        b=dCIMk3uy6U/ecJMb/ifOpvekCEc5WAFEjnGeqPVdPezbPfi1qsKXMsN301a0WCco/
         Qab7U69GN5NWSCkAb+K7S9/s5DtfzcCEokDtlle8qpB3rBtdDeWM586e8YUfiPY1IU
         Xpij+RRjwAGj5nu0mB4UxeJLtt9A7D8DIGbrSfyY=
Received: from localhost.localdomain ([120.245.132.52])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 32C96631; Wed, 30 Mar 2022 00:12:44 +0800
X-QQ-mid: xmsmtpt1648570364twlbk78iv
Message-ID: <tencent_9D994CB589E97D7605023F5CF51D7DA4F50A@qq.com>
X-QQ-XMAILINFO: OMWm0AbyvxL+nDZ7vqp4YyGvUM+RaNvkyO5/mPxfy0VDt3hvjjTxH72ZE0svhb
         BND5Vi4zyQj7Ou32QjC7Ug2XhbrLf9uRcKLylz9I7lQHEIdw4+W+Jxdy/MFf8EvfFE9uixVZ30+C
         yje6kmwm0Wwp8LiW6LXFpeM8CfwEmCw1ojABUkI4iPxu+PnjFFkWj053DY+nqcUiYn0nZQw2uNIt
         ddA+KF5moCqMggH/ctgPHygRd9ME8h852CWVpkookTYYH1G7hcMvbE4GoKvUDvtA3CnHUjJKnBoN
         H6Hg+NdIVMF6Dfkf2inHpN60dwBOTl3dLRxIKbQSa4zurXcBcv+4JTTLoqToZaMGab7Zqxqc9LTQ
         0eI7zFE24/2eNg6pkxBlt21slxCjRLnnIpLMXzmOYgHxsWpJ7SPbr56p4Ev037bS19W7+adi8F/y
         Ml3HS54dMbdAjnqTP4UbcH62AJf9jva2emCR0J09csNwRA43YC1DAbElL42n/tfibvNp2GpnG5T0
         XtwLznXTHWVRzh4EfOdzIjyS4WbmBuCrMIo84w5n+4+/T6BW8e4ZsHO35YHRtFliWdOhuuODhd9z
         nEuRkTPWRnxqybL9b8QP11a/9AgePMMHpWKRw5FwiMSwDrztRkFR/zM6yJZDyNvuZXROuzcipDxZ
         CghNvram0cpq89hOGSO9vfeKxIT5IB4AhwIG1wuLwdH9MhYhtZ4XfvYfWpH4rWFTuVvqMth2xFyv
         ZfJRAD0RKDkgoy+7oM9QVeDQuET+jrrHC7/0D+D2wT6S+t0Yd5m3vTQCNq60KFzUkCcexCtn8Gl1
         2uqXIZpyIj4q0ZhpmOJH0s4AMNXJcDAjxHLkNSjl7ZqwloqF919AI8Ni4U4hECWVfMVZlq4qTVYK
         svm9tH7Y5zqS8byK1NaHalrLQsTndlWu/AA99P2eRm6ESBm+/Ya65yDaUZOw8httPbQyRb3HpT
From:   Chen Guanqiao <chen.chenchacha@foxmail.com>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v2 0/4] add limit on the total number of users and oustanding messages
Date:   Wed, 30 Mar 2022 00:12:38 +0800
X-OQ-MSGID: <20220329161242.76457-1-chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some case, ipmi is frequently accessed, and the communication of bmc
device is blocked, ipmi will consume a large amount of memory.

This patch provides some limits for the number of user and messages in
ipmi.

In addition, this patch also provides a method to view the current number
of users and messages in ipmi, Used to diagnose and troubleshoot issues.
and introduce a simple interface to clear the message queue.

Changelog v2:
- Add a limit on the number of users
- Add a less rigid limit on the number of oustanding messages
- The interface for viewing the number of users and messages is retained
- The interface for cleanup messages is retained

Chen Guanqiao (4):
  ipmi: msghandler: Add a limit for the number of users
  ipmi: msghandler: Add a limit for the number of messages
  ipmi: msghandler: Get the number of users and messages through sysfs
  ipmi: msghandler: Add a interface to clean message queue in sysfs

 drivers/char/ipmi/ipmi_msghandler.c | 207 ++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

--
2.25.1

