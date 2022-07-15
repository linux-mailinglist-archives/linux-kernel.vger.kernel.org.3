Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F903575B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiGOGLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGOGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:10:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5967973912
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:10:45 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657865443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qQR4jQKCvnLBO+TkSA8EJU9n4EeQ3EBifBoxgctNi3I=;
        b=OfH8rMUHH71hYG7VPTpy8eIshBel/I2kG+LjqqZhFVKNOq09BgdwZLvKCbClciymFPazD8
        HzrFAVLUtIbKu4cLSuwIVn2E0pM/cS0JyOFRmNXeD8PFFsGN+uBZWBhd8y0M/DFqEwYFqR
        xrlZG9RG4oaSyu0zK6B9ZUXaMtsyOvpanFUdvfR99Kp7PKN6je/MWuIrbn8HdafLNMbHEA
        I3hUDfO6SQEbGrW/vm5dvn2utBpE5Hj/ifznQo95I4Vjuq9sEmuZaXPWmX+CzmdLayECkd
        Sdp7nOG6qnno8AsHVzIWSIV4st8VJ0zS5wTNAwjJp8eieEtR1FD9dD0q4FNCHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657865443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qQR4jQKCvnLBO+TkSA8EJU9n4EeQ3EBifBoxgctNi3I=;
        b=xQvYuccgpRqsCk0LDPuDweJgRgbS7k9Pddpnt87IK2QvBq0iKGxqevit0xH9shFZ8NGuXh
        ZWJy49BCC/yTehDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] printk: fix extra suspend/resume delays
Date:   Fri, 15 Jul 2022 08:16:41 +0206
Message-Id: <20220715061042.373640-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported here [0], an unnecessary delay exists in the
suspend/resume paths for certain scenarios. Here is the
fix for it. Since the extra delays were introduced in
5.19-rc1, this fix should go into 5.19-rc7.

The changelog is in the patch stats.

John Ogness

[0] https://bugzilla.kernel.org/show_bug.cgi?id=216216

John Ogness (1):
  printk: do not wait for consoles when suspended

 kernel/printk/printk.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)


base-commit: 32346491ddf24599decca06190ebca03ff9de7f8
-- 
2.30.2

