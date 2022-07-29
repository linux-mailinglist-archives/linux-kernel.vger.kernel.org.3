Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D15585310
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiG2Pre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbiG2PrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:47:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A4D87219
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:47:22 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659109640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O4rhr1rYV4QRyupGwy8qDV2MfT3JnDU8vIVTHPUsjls=;
        b=o9iX21ZXcpZfC+HXL49xoDJLQxGvgfp/6/lG+cepb7a9/QwE0IOjulOq0YUcDpFa42Tk4D
        d274YISWxwTscXc6nK5TVA23y/s5z39w7RXDT8yvdHQi9VjHqzTYtkC8t8t02b3tWHYaN3
        hieFDjaVR5s0lYr5EbEnuEDTZOX8OEE1lq89DmUxWlhgGeGLSVbJblPWKhM4tZYH/Mhz5i
        5dw61/TcAhQsa6uhLvdP5MmwDJWbRlW5A1VIRVPxeeEeZImuZP95AlRkh7QseFGS+jLLf2
        2FV0dF9DQ3sA48CslRZXfHdwJEGWRS+NPAmsar4/byItGIfpsfTFwm0txKtIJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659109640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O4rhr1rYV4QRyupGwy8qDV2MfT3JnDU8vIVTHPUsjls=;
        b=iyvYaivEsVsLGJP9BYRZeH6InJOTgCDC8EAqxUDVdGRQbpS7hEf3uHjYWExqG7E1+gaoDc
        6y1arEfxmjWo4kDA==
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2 v2] Init the hashed pointer from a worker.
Date:   Fri, 29 Jul 2022 17:47:14 +0200
Message-Id: <20220729154716.429964-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this mini series is a follow up to=20
	https://lore.kernel.org/all/YuOf6qu453dOkR+S@linutronix.de/

v1=E2=80=A6v2:
   - Remove the static_branch_likely() as suggested by Petr Mladek.
   - Jason wasn't onboard with fiddling in random core to get the job
     done. Instead a worker is scheduled from an initcall and
     get_random_bytes_wait() is used to get the date once it is
     available.

Sebastian


