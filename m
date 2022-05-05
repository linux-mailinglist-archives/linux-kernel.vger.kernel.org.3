Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7C851BD4A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355934AbiEEKgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355881AbiEEKg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:36:28 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C754BFF2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:32:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8015C40755D3;
        Thu,  5 May 2022 10:32:43 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] x86: Parse CONFIG_CMDLINE in compressed kernel
Date:   Thu,  5 May 2022 13:32:22 +0300
Message-Id: <20220505103224.21667-1-baskov@ispras.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <YnJAYOHBjipBfdm3@zn.tnic>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE was ignored during
options lookup in compressed kernel, including earlyprintk option,
so it was impossible to get earlyprintk messages from that stage
of boot process via command line provided at compile time.
Being able to enable earlyprintk via compile-time option might
be desirable for booting on systems with broken UEFI command line
arguments via EFISTUB.

v2 changes:

As Borislav Petkov stated, we can do the work just once and then
return correct command line pointer. Doing it this way require
us to perform string manipulations, so the first patch adds missing
strlcat() to compressed kernel, since this function simplifies
the code a lot.

If we need to concatenate strings, static buffer of fixed length
is used. The maximum command line length is set to the same value
as the one in the kernel setup code.

v3 changes:

v2 had a bug: cmd_line_ptr was set to a pointer to a buffer inside
a kernel before kernel relocation, that makes this pointer invalid.
It was fixed by replacing the pointer by a boolean variable.

Baskov Evgeniy (2):
         x86: Add strlcat() to compressed kernel
         x86: Parse CONFIG_CMDLINE in compressed kernel

 arch/x86/boot/compressed/cmdline.c | 24 +++++++++++++++++++++++-
 arch/x86/boot/compressed/string.c  | 15 +++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)
