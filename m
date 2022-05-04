Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1225451AF90
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378309AbiEDUp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378304AbiEDUpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:45:24 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E69551323
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:41:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id F357B407625A;
        Wed,  4 May 2022 20:41:45 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] x86: Parse CONFIG_CMDLINE in compressed kernel
Date:   Wed,  4 May 2022 23:41:21 +0300
Message-Id: <20220504204123.22967-1-baskov@ispras.ru>
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

Baskov Evgeniy (2):
         x86: add strlcat() to compressed kernel
         x86: Parse CONFIG_CMDLINE in compressed kernel

 arch/x86/boot/compressed/cmdline.c | 28 ++++++++++++++++++++++++++--
 arch/x86/boot/compressed/string.c  | 15 +++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)
