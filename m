Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C897E56979E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiGGBgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiGGBgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:36:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F672E9FB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 18:36:10 -0700 (PDT)
X-UUID: 4465504833be49d8ba0e630c2736963d-20220707
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:b565b9fd-64d9-4d41-95c9-38c3bcedf148,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:1769cfd6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 4465504833be49d8ba0e630c2736963d-20220707
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2093498817; Thu, 07 Jul 2022 09:36:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 7 Jul 2022 09:36:05 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 7 Jul 2022 09:35:58 +0800
Message-ID: <76e12594cf81b57c98e536c68b2947f9ed0a4296.camel@mediatek.com>
Subject: Re: [PATCH 01/13] tracing/events: Add __vstring() and
 __assign_vstr() helper macros
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Arend van Spriel" <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        "Hante Meuleman" <hante.meuleman@broadcom.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Peter Chen <peter.chen@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bin Liu <b-liu@ti.com>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jim Cromie <jim.cromie@gmail.com>
Date:   Thu, 7 Jul 2022 09:35:53 +0800
In-Reply-To: <20220705224749.053570613@goodmis.org>
References: <20220705224453.120955146@goodmis.org>
         <20220705224749.053570613@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-05 at 18:44 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> There's several places that open code the following logic:
> 
>   TP_STRUCT__entry(__dynamic_array(char, msg, MSG_MAX)),
>   TP_fast_assign(vsnprintf(__get_str(msg), MSG_MAX, vaf->fmt, *vaf-
> >va);)
> 
> To load a string created by variable array va_list.
> 
> The main issue with this approach is that "MSG_MAX" usage in the
> __dynamic_array() portion. That actually just reserves the MSG_MAX in
> the
> event, and even wastes space because there's dynamic meta data also
> saved
> in the event to denote the offset and size of the dynamic array. It
> would
> have been better to just use a static __array() field.
> 
> Instead, create __vstring() and __assign_vstr() that work like
> __string
> and __assign_str() but instead of taking a destination string to
> copy,
> take a format string and a va_list pointer and fill in the values.
> 
> It uses the helper:
> 
>  #define __trace_event_vstr_len(fmt, va)	\
>  ({						\
> 	va_list __ap;				\
> 	int __ret;				\
> 						\
> 	va_copy(__ap, *(va));			\
> 	__ret = vsnprintf(NULL, 0, fmt, __ap);	\
> 	va_end(__ap);				\
> 						\
> 	min(__ret, TRACE_EVENT_STR_MAX);	\
>  })
> 
> To figure out the length to store the string. It may be slightly
> slower as
> it needs to run the vsnprintf() twice, but it now saves space on the
> ring
> buffer.
> 
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Gregory Greenman <gregory.greenman@intel.com>
> Cc: Peter Chen <peter.chen@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Bin Liu <b-liu@ti.com>
> Cc: Marek Lindner <mareklindner@neomailbox.ch>
> Cc: Simon Wunderlich <sw@simonwunderlich.de>
> Cc: Antonio Quartulli <a@unstable.cc>
> Cc: Sven Eckelmann <sven@narfation.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Seems difficult to get this patch without, such as, '--cc="
linux-kernel@vger.kernel.org"'

> ---
>  include/linux/trace_events.h                 | 18 ++++++++++++++++++
>  include/trace/stages/stage1_struct_define.h  |  3 +++
>  include/trace/stages/stage2_data_offsets.h   |  3 +++
>  include/trace/stages/stage4_event_fields.h   |  3 +++
>  include/trace/stages/stage5_get_offsets.h    |  4 ++++
>  include/trace/stages/stage6_event_callback.h |  7 +++++++
>  6 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/trace_events.h
> b/include/linux/trace_events.h
> index e6e95a9f07a5..e6f8ba52a958 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -916,6 +916,24 @@ perf_trace_buf_submit(void *raw_data, int size,
> int rctx, u16 type,
>  
>  #endif
>  
> +#define TRACE_EVENT_STR_MAX	512
> +
> +/*
> + * gcc warns that you can not use a va_list in an inlined
> + * function. But lets me make it into a macro :-/
> + */
> +#define __trace_event_vstr_len(fmt, va)		\
> +({						\
> +	va_list __ap;				\
> +	int __ret;				\
> +						\
> +	va_copy(__ap, *(va));			\
> +	__ret = vsnprintf(NULL, 0, fmt, __ap);	\
> +	va_end(__ap);				\
> +						\
> +	min(__ret, TRACE_EVENT_STR_MAX);	\
> +})
> +
>  #endif /* _LINUX_TRACE_EVENT_H */
>  
>  /*
> diff --git a/include/trace/stages/stage1_struct_define.h
> b/include/trace/stages/stage1_struct_define.h
> index a16783419687..1b7bab60434c 100644
> --- a/include/trace/stages/stage1_struct_define.h
> +++ b/include/trace/stages/stage1_struct_define.h
> @@ -26,6 +26,9 @@
>  #undef __string_len
>  #define __string_len(item, src, len) __dynamic_array(char, item, -1)
>  
> +#undef __vstring
> +#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
> +
>  #undef __bitmask
>  #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
>  
> diff --git a/include/trace/stages/stage2_data_offsets.h
> b/include/trace/stages/stage2_data_offsets.h
> index 42fd1e8813ec..1b7a8f764fdd 100644
> --- a/include/trace/stages/stage2_data_offsets.h
> +++ b/include/trace/stages/stage2_data_offsets.h
> @@ -32,6 +32,9 @@
>  #undef __string_len
>  #define __string_len(item, src, len) __dynamic_array(char, item, -1)
>  
> +#undef __vstring
> +#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
> +
>  #undef __bitmask
>  #define __bitmask(item, nr_bits) __dynamic_array(unsigned long,
> item, -1)
>  
> diff --git a/include/trace/stages/stage4_event_fields.h
> b/include/trace/stages/stage4_event_fields.h
> index e80cdc397a43..c3790ec7a453 100644
> --- a/include/trace/stages/stage4_event_fields.h
> +++ b/include/trace/stages/stage4_event_fields.h
> @@ -38,6 +38,9 @@
>  #undef __string_len
>  #define __string_len(item, src, len) __dynamic_array(char, item, -1)
>  
> +#undef __vstring
> +#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
> +
>  #undef __bitmask
>  #define __bitmask(item, nr_bits) __dynamic_array(unsigned long,
> item, -1)
>  
> diff --git a/include/trace/stages/stage5_get_offsets.h
> b/include/trace/stages/stage5_get_offsets.h
> index 7ee5931300e6..fba4c24ed9e6 100644
> --- a/include/trace/stages/stage5_get_offsets.h
> +++ b/include/trace/stages/stage5_get_offsets.h
> @@ -39,6 +39,10 @@
>  #undef __string_len
>  #define __string_len(item, src, len) __dynamic_array(char, item,
> (len) + 1)
>  
> +#undef __vstring
> +#define __vstring(item, fmt, ap) __dynamic_array(char, item,		
> \
> +		      __trace_event_vstr_len(fmt, ap))
> +
>  #undef __rel_dynamic_array
>  #define __rel_dynamic_array(type, item, len)				
> \
>  	__item_length = (len) * sizeof(type);				
> \
> diff --git a/include/trace/stages/stage6_event_callback.h
> b/include/trace/stages/stage6_event_callback.h
> index e1724f73594b..0f51f6b3ab70 100644
> --- a/include/trace/stages/stage6_event_callback.h
> +++ b/include/trace/stages/stage6_event_callback.h
> @@ -24,6 +24,9 @@
>  #undef __string_len
>  #define __string_len(item, src, len) __dynamic_array(char, item, -1)
>  
> +#undef __vstring
> +#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
> +
>  #undef __assign_str
>  #define __assign_str(dst, src)					
> 	\
>  	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
> @@ -35,6 +38,10 @@
>  		__get_str(dst)[len] = '\0';				
> \
>  	} while(0)
>  
> +#undef __assign_vstr
> +#define __assign_vstr(dst, fmt, va)					
> \
> +	vsnprintf(__get_str(dst), TRACE_EVENT_STR_MAX, fmt, *(va))
> +
>  #undef __bitmask
>  #define __bitmask(item, nr_bits) __dynamic_array(unsigned long,
> item, -1)
>  

