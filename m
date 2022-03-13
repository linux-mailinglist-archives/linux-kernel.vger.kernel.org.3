Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146FD4D71BF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 01:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiCMAPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 19:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiCMAPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:15:45 -0500
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262B036167
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 16:14:37 -0800 (PST)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id A96AF20452;
        Sun, 13 Mar 2022 00:14:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id DFC4F6000C;
        Sun, 13 Mar 2022 00:14:34 +0000 (UTC)
Message-ID: <ef83282cdaaf3717cd64442ea14ce4c5b58b26b1.camel@perches.com>
Subject: Re: [PATCH 1/5] x86/alternative: simplify DUMP_BYTES macro
From:   Joe Perches <joe@perches.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 12 Mar 2022 16:14:34 -0800
In-Reply-To: <e9c77d12092a4f048992f67d3fa0cf363b8614d4.camel@perches.com>
References: <20220311144312.88466-1-adobriyan@gmail.com>
         <e9c77d12092a4f048992f67d3fa0cf363b8614d4.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: s6p8qtricqpmirccbm8yjiq5fhyd9dho
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: DFC4F6000C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/KvNf4V32GdJ6G9fIYnHBb22DHcUWmwvc=
X-HE-Tag: 1647130474-731585
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-03-12 at 08:36 -0800, Joe Perches wrote:
> On Fri, 2022-03-11 at 17:43 +0300, Alexey Dobriyan wrote:
> > Avoid zero length check with clever whitespace placement in the format
> > string.
> []
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> []
> > @@ -66,13 +66,10 @@ do {									\
> >  	if (unlikely(debug_alternative)) {				\
> >  		int j;							\
> >  									\
> > -		if (!(len))						\
> > -			break;						\
> > -									\
> >  		printk(KERN_DEBUG pr_fmt(fmt), ##args);			\
> > -		for (j = 0; j < (len) - 1; j++)				\
> > -			printk(KERN_CONT "%02hhx ", buf[j]);		\
> > -		printk(KERN_CONT "%02hhx\n", buf[j]);			\
> > +		for (j = 0; j < (len); j++)				\
> > +			printk(KERN_CONT " %02hhx", buf[j]);		\
> > +		printk(KERN_CONT "\n");					\
> >  	}								\
> 
> This could also use %02x and not %02hhx
> 
> And MAX_PATCH_LEN is 255 but is that really possible?
> 
> Maybe if the actual patch length is always <= 64 this could use
> 	printk(KERN_CONT "%*ph\n", (int)len, buf);
> instead and avoid all possible interleaving?

Another possibility would be to raise the arbitrary 64 byte
limit on %*ph to 256.
---
 Documentation/core-api/printk-formats.rst | 6 +++---
 lib/vsprintf.c                            | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 5e89497ba314e..39f787e9b26e1 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -289,9 +289,9 @@ Raw buffer as a hex string
 	%*phD	00-01-02- ... -3f
 	%*phN	000102 ... 3f
 
-For printing small buffers (up to 64 bytes long) as a hex string with a
-certain separator. For larger buffers consider using
-:c:func:`print_hex_dump`.
+For printing small buffers (up to 256 bytes long) as a hex string with a
+certain separator. For buffers larger than 64 bytes consider using
+:c:func:`print_hex_dump` as its output can be more easily counted.
 
 MAC/FDDI addresses
 ------------------
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2a6c767cc2709..be6fa9fab1be8 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1194,7 +1194,7 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	}
 
 	if (spec.field_width > 0)
-		len = min_t(int, spec.field_width, 64);
+		len = min_t(int, spec.field_width, 256);
 
 	for (i = 0; i < len; ++i) {
 		if (buf < end)


