Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B93D49B67C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579490AbiAYOg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388297AbiAYOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:33:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259A1C06175F;
        Tue, 25 Jan 2022 06:32:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB0C0B8180A;
        Tue, 25 Jan 2022 14:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D2DC340E0;
        Tue, 25 Jan 2022 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643121118;
        bh=TjiX/pJ3jr1qZrQo1Hb5I+RhGqJRpdiNcaSW38hFvnM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e1hvj+wKBMDc9NHJ/xRYFOPWv5n/MtaAM3F4UlC2BsUaiRgMLLxmsB902n4OgqXu3
         zp1HhY5+TwltC9oFSD/J3iIMa6+Q2mdF0eVNvr+tW+6Lcktjr+m2H+4zoGY/PkIfoz
         Ab4TV2TWjYDvWJyhlL0frwnaJKQ+ENBZGnEYcqlW+O2tQU3H/b7rRjSdYPIrAKJCf1
         LSNIEQ229hJjpl/I1dbUNGpg+uTvbbz3QNdvlwmwBdbKWPNfScWnRr/AUCmagRbRJU
         edsg8f3i5R1Sk/nCutJrdIEgJe0Z4b5YAwVsCP65mtpuR2IPmumAsPMxSnTPAxyKC6
         6UH8vt6C+SJzg==
Date:   Tue, 25 Jan 2022 23:31:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-Id: <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
In-Reply-To: <20220125222732.98ce2e445726e773f40e122e@kernel.org>
References: <20220125145006.677e3709@canb.auug.org.au>
        <202201242230.C54A6BCDFE@keescook>
        <20220125222732.98ce2e445726e773f40e122e@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 22:27:32 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > /*
> >  * struct trace_event_data_offsets_<call> {
> >  *      u32                             <item1>;
> >  *      u32                             <item2>;
> >  *      [...]
> >  * };
> >  *
> >  * The __dynamic_array() macro will create each u32 <item>, this is
> >  * to keep the offset of each array from the beginning of the event.
> >  * The size of an array is also encoded, in the higher 16 bits of
> >  * <item>.
> >  */
> > 
> > So, I think -Warray-bounds is refusing to see the destination as
> > anything except a u32, but being accessed at 4 (sizeof(u32)) + 8
> > (address && 0xffff) (?)
> 
> Ah, I got it. Yes, that's right. __data_loc() will access the data
> from the __entry, but the __rel_loc() points the same address from
> the encoded field ("__rel_loc_foo" in this case) itself.
> This is introduced for the user application event, which doesn't
> know the actual __entry size because the __entry includes some
> kernel internal defined fields.
> 
> > But if this is true, I would imagine there would be plenty of other
> > warnings? I'm currently stumped.
> 
> That is because __rel_loc is used only in the sample code in the kernel
> for testing. Other use-cases comes from user-space.
> Hmm, can we skip this boundary check for this example?

If the -Warray-bounds determines the destination array size from
the type of given pointer, we can just change the macro as below;

#define __get_rel_dynamic_array(field) 
			((void *)__entry +                                 \
			 offsetof(typeof(*__entry), __rel_loc_##field) +   \
			 sizeof(__entry->__rel_loc_##field) +              \
			 (__entry->__rel_loc_##field & 0xffff))

This must works same as __get_dynamic_array() macro.

Could you try this patch?

From 2982ba01367ec1f746a4f128512436e5325a7f9d Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Tue, 25 Jan 2022 23:19:30 +0900
Subject: [PATCH] tracing: Avoid -Warray-bounds warning for __rel_loc macro

Since -Warray-bounds checks the destination size from the
type of given pointer, __assign_rel_str() macro gets warned
because it passes the pointer to the 'u32' field instead of
'trace_event_raw_*' data structure.
Pass the data address calculated from the 'trace_event_raw_*'
instead of 'u32' __rel_loc field.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kees Cook <keescook@chromium.org>
---
 include/trace/trace_events.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 8c6f7c433518..65d927e059d3 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -318,9 +318,10 @@ TRACE_MAKE_SYSTEM_STR();
 #define __get_str(field) ((char *)__get_dynamic_array(field))
 
 #undef __get_rel_dynamic_array
-#define __get_rel_dynamic_array(field)	\
-		((void *)(&__entry->__rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +		\
+#define __get_rel_dynamic_array(field)					\
+		((void *)__entry + 					\
+		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +			\
 		 (__entry->__rel_loc_##field & 0xffff))
 
 #undef __get_rel_dynamic_array_len
-- 
2.25.1


-- 
Masami Hiramatsu <mhiramat@kernel.org>
