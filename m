Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153D655293F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245676AbiFUCKp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Jun 2022 22:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbiFUCKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:10:43 -0400
Received: from relay4.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF2E1EC62
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:10:42 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id C4A4C61081;
        Tue, 21 Jun 2022 02:10:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id F267A32;
        Tue, 21 Jun 2022 02:10:38 +0000 (UTC)
Message-ID: <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
From:   Joe Perches <joe@perches.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "willy@infradead.org" <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>
Date:   Mon, 20 Jun 2022 19:10:38 -0700
In-Reply-To: <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
         <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
         <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
         <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
         <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
         <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Queue-Id: F267A32
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: ddwoawxpcobobp4d4tcbgu83yqtpn9bi
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Xz7rjAxOO7jXBkzbfuwKRIweIFY8sohA=
X-HE-Tag: 1655777438-450937
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-20 at 18:26 -0700, Joe Perches wrote:
> On Mon, 2022-06-20 at 20:57 -0400, Kent Overstreet wrote:
> > On Mon, Jun 20, 2022 at 05:38:51PM -0700, Joe Perches wrote:
> > > On Mon, 2022-06-20 at 11:07 -0400, Kent Overstreet wrote:
> > > > On Mon, Jun 20, 2022 at 04:19:31AM +0000, David Laight wrote:
> > > > > I really think that is a bad idea.
> > > > > printk() already uses a lot of stack, anything doing a recursive
> > > > > call is just making that worse.
> > > > > Especially since these calls can often be in error paths
> > > > > which are not often tested and can already be on deep stacks.
> > > > 
> > > > We went over this before - this patch series drastically reduces stack usage of
> > > > sprintf by eliminating a bunch of stack allocated buffers. Do try to keep up...
> > > 
> > > I generally agree with David.
> > > 
> > > I think Kent has not provided data that this actually _reduces_
> > > stack usage.
> > 
> > I think the people who are comfortable with reading C can discern that when
> > large stack allocated character arrays are deleted, frame size and stack usage
> > go down.
> 
> I am very comfortable reading C.
> 
> You have not provided any data.

In a brief looking around at stack uses in vsprintf, I believe
this is the largest stack declaration there.

Especially since KSYM_NAME_LEN was increased to 512 by 
commit 394dffa6680c ("kallsyms: increase maximum kernel symbol length to 512")

Perhaps this stack declaration should instead be an alloc/free
as it can be quite large.

I suppose one could quibble about the kzalloc vs kmalloc or the nominally
unnecessary initialization of sym.

I think this makes sense though and it reduces the #ifdef uses too.
---
 lib/vsprintf.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c414a8d9f1ea9..30113a30fd88a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -980,30 +980,37 @@ char *symbol_string(char *buf, char *end, void *ptr,
 		    struct printf_spec spec, const char *fmt)
 {
 	unsigned long value;
-#ifdef CONFIG_KALLSYMS
-	char sym[KSYM_SYMBOL_LEN];
-#endif
+	char *sym = NULL;
 
 	if (fmt[1] == 'R')
 		ptr = __builtin_extract_return_addr(ptr);
 	value = (unsigned long)ptr;
 
-#ifdef CONFIG_KALLSYMS
-	if (*fmt == 'B' && fmt[1] == 'b')
-		sprint_backtrace_build_id(sym, value);
-	else if (*fmt == 'B')
-		sprint_backtrace(sym, value);
-	else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
-		sprint_symbol_build_id(sym, value);
-	else if (*fmt != 's')
-		sprint_symbol(sym, value);
-	else
-		sprint_symbol_no_offset(sym, value);
+	if (IS_ENABLED(CONFIG_KALLSYMS) &&
+	    (sym = kzalloc(KSYM_SYMBOL_LEN, GFP_NOWAIT | __GFP_NOWARN))) {
+		char *rtn;
+
+		if (*fmt == 'B' && fmt[1] == 'b')
+			sprint_backtrace_build_id(sym, value);
+		else if (*fmt == 'B')
+			sprint_backtrace(sym, value);
+		else if (*fmt == 'S' &&
+			 (fmt[1] == 'b' ||
+			  (fmt[1] == 'R' && fmt[2] == 'b')))
+			sprint_symbol_build_id(sym, value);
+		else if (*fmt != 's')
+			sprint_symbol(sym, value);
+		else
+			sprint_symbol_no_offset(sym, value);
+
+		rtn = string_nocheck(buf, end, sym, spec);
+
+		kfree(sym);
+
+		return rtn;
+	}
 
-	return string_nocheck(buf, end, sym, spec);
-#else
 	return special_hex_number(buf, end, value, sizeof(void *));
-#endif
 }
 
 static const struct printf_spec default_str_spec = {

