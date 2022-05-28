Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934D6536B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 08:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiE1GNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 02:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiE1GNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 02:13:14 -0400
X-Greylist: delayed 568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 23:13:12 PDT
Received: from mellona.thatsmathematics.com (mellona.thatsmathematics.com [IPv6:2001:4801:7825:103:be76:4eff:fe10:2a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ECA2DD5F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 23:13:12 -0700 (PDT)
Received: from moneta.lan (unknown [76.130.20.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mellona.thatsmathematics.com (Postfix) with ESMTPSA id C1586FC282
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 06:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thatsmathematics.com;
        s=condor; t=1653717821;
        bh=9tm6ZEmqHdu2c38ZNE0Pzxj5I6pVrb0PO0DnQuFukaE=;
        h=Date:From:To:Subject:From;
        b=CoK5wVphOcLI6MPH0Re/mMKw8yYiGTbCK0GW2qoDalXyqQec8g4Y+9y7ioQzKTSxX
         0AGKyFXxsCJsR9R4mZAhleG/4kqUz2ECP0BCvjGciv8m6PhVGVmOjLKeZLPuCe3XxY
         MNao+Rr2TN9wCDth4tv2eMrcQ7cjz5f5QFRdY+PQeRmXrGP3YZk+kyxnutQ7EGHAMb
         56g3av6kGq1wne6fTBrh4jEO614spLEDZIxRbqjYhg045yZXT5415wYJyATZDUn4QA
         XdZH8O32exMEmWnV8yYbhmKV4ZRQC/EnoUo9m75V6xpQOCDxcM0Y1xzoTxtfIQuAit
         2A8vxYdQ2npvg==
Date:   Sat, 28 May 2022 00:03:39 -0600 (MDT)
From:   Nate Eldredge <nate@thatsmathematics.com>
To:     linux-kernel@vger.kernel.org
Subject: PTRACE_GET_SYSCALL_INFO requires PTRACE_O_TRACESYSGOOD but not
 documented
Message-ID: <ddca4058-b356-abfb-12d8-b2357ed7b3e0@thatsmathematics.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the PTRACE_GET_SYSCALL_INFO function of ptrace(2) only works 
properly if the tracer has set the PTRACE_O_TRACESYSGOOD option.  The man 
page doesn't mention this requirement.  Is it intentional?

The issue is that ptrace_get_syscall_info() in kernel/ptrace.c only calls 
the ptrace_get_syscall_info_{entry,exit} functions to fully populate the 
ptrace_syscall_info struct if child->last_siginfo->si_code == SIGTRAP | 
0x80.  And the 0x80 bit is only set when PTRACE_O_TRACESYSGOOD is in 
effect.  Otherwise, the struct always comes back to userspace with op == 
PTRACE_SYSCALL_INFO_NONE and the entry (or exit) member is not filled in 
with the system call arguments (or return value).

-- 
Nate Eldredge
nate@thatsmathematics.com

