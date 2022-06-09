Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB19545128
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343929AbiFIPpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344623AbiFIPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:45:13 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB0A11468
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:45:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id 7AE6E1B7B0E1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 17:39:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
        s=sec-sig-email; t=1654789159;
        bh=X6ruSqJwnNrwt5d35q7LEkTsbhy3C5LG5jeTsasEzuo=;
        h=From:To:Cc:Subject:Date;
        b=N2edGHFvm2138KTX0EQOsCeQlrifR+8CRiGa373KjW0kSIFty3KrqFt9Q4PLWgJzL
         zYvp0jNwkNH/5mzhXQK3PNAFtstXVVanhpYM7NnFudaoTOAHGm9W9k8yFtRHf8AqOL
         K/2nEiFq7PuqHKIr+yiVDWuT3oAfwwEOYDwnkA08=
Received: from fx408 (localhost [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id 2B6F91B7B145;
        Thu,  9 Jun 2022 17:39:19 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <68c4.62a21426.98d24.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx408.security-mail.net (Postfix) with ESMTPS id 999331B7B028;
        Thu,  9 Jun 2022 17:39:18 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 7F70E27E04B4;
        Thu,  9 Jun 2022 17:39:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 6862C27E04B9;
        Thu,  9 Jun 2022 17:39:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 6862C27E04B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
        s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1654789158;
        bh=g9NxFl92sOJLf8iLRo2C0MG8dT03cdb0ZXo+kZqA6yE=;
        h=From:To:Date:Message-Id;
        b=NwnvCQuhH/26j4i7jRZhnmCgL/GgD4a2uDUFYYlrM0gHGhX0n34xtc5zAJjhe4nl6
         V4u6We58K3snXOpnjYObuobzr243JKSWXIQ9oXdxhUok8+F9Jio+Cz3EMbeL0ClNaB
         Tvr39r7KYmjvbpPqrXpCrJY/x6cYeXGLqiCk6hIknA9mbFZBtDeNNxr2Qu9WX3+Zr4
         XnriH3B/5D9H0EePDn/15idSnc/EccI/6NCpD/mmZQBVIYbb61bCBXeG8K60iYOWD9
         u145miRnfDfODLf3e4TxT6JeY6tylmdD7gvjYSci/cjh54wsffaUb2UBGDJ8RfUqEU
         FdYM+VwloTgJQ==
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id za3UJMgpvp2u; Thu,  9 Jun 2022 17:39:18 +0200 (CEST)
Received: from ws2104.lin.mbt.kalray.eu (unknown [192.168.37.162])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 4ACE227E04B4;
        Thu,  9 Jun 2022 17:39:18 +0200 (CEST)
From:   Julian Vetter <jvetter@kalrayinc.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ysionneau@kalrayinc.com
Cc:     Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH 0/2] Check for MSI allocation
Date:   Thu,  9 Jun 2022 17:38:41 +0200
Message-Id: <20220609153843.1991-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our HW has a mailbox periph that supports up to 8192 MSIs, so the currently
supported 2048 is not enough. I believe there is no real reason to
contstrain the max platform MSIs to 2048, because the value is stored in
an irq_hw_number_t which is big enough to hold more MSIs. The value is
OR'ed with the device ID of which there is also a limited number.
The second patch contains a WARN() to warn the user if a device tries to
obtain more that MAX_DEV_MSIS, because this could lead to potentially
conflicting virtual interrupt numbers (as was the case for us) without
the Linux kernel telling us.

Julian Vetter (2):
  msi: The MSI framework only supports 2048 platform MSIs
  msi: Add sanity check if more than MAX_DEV_MSIS MSIs are requested

 drivers/base/platform-msi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1

