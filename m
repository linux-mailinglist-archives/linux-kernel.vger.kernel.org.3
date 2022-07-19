Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D4E57925F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiGSFTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiGSFTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:19:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172722A94D;
        Mon, 18 Jul 2022 22:19:00 -0700 (PDT)
X-UUID: bc7dcddde27c4a789f177a7ab6d8c8c4-20220719
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:726b56d5-7a44-4d2c-ba0e-2f4cb85f22b5,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.8,REQID:726b56d5-7a44-4d2c-ba0e-2f4cb85f22b5,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:0f94e32,CLOUDID:cf11dbd7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:4b4ee40e8d85,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: bc7dcddde27c4a789f177a7ab6d8c8c4-20220719
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1106322678; Tue, 19 Jul 2022 13:18:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 19 Jul 2022 13:18:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 19 Jul 2022 13:18:54 +0800
Message-ID: <27fb716259fc88cba955691c246a6bdaf31b38d8.camel@mediatek.com>
Subject: Re: [for-next][PATCH 13/23] USB: mtu3: tracing: Use the new
 __vstring() helper
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue, 19 Jul 2022 13:18:54 +0800
In-Reply-To: <20220715172423.6b57b9eb@gandalf.local.home>
References: <20220714164256.403842845@goodmis.org>
         <20220714164330.311734558@goodmis.org>
         <962e59c25e981676014157cd111db9e16e237339.camel@mediatek.com>
         <20220715172423.6b57b9eb@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-15 at 17:24 -0400, Steven Rostedt wrote:
> On Fri, 15 Jul 2022 18:01:44 +0800
> Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> 
> >  irq/254-1120100-137     [000] d..1.   266.629662: mtu3_log:
> > 11201000.usb: ep0_state SETUPr-speed
> > 
> > "r-speed" seems the remain of last log;
> 
> I found an off-by-one bug in the vstring patch. I'll rebase, test and
> try
> again.
> 
> In the mean time, care to add this on top to make sure it's fixed?
> 
> Thanks!
> 
> -- Steve
> 
> diff --git a/include/linux/trace_events.h
> b/include/linux/trace_events.h
> index e6f8ba52a958..b18759a673c6 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -922,16 +922,16 @@ perf_trace_buf_submit(void *raw_data, int size,
> int rctx, u16 type,
>   * gcc warns that you can not use a va_list in an inlined
>   * function. But lets me make it into a macro :-/
>   */
> -#define __trace_event_vstr_len(fmt, va)		\
> -({						\
> -	va_list __ap;				\
> -	int __ret;				\
> -						\
> -	va_copy(__ap, *(va));			\
> -	__ret = vsnprintf(NULL, 0, fmt, __ap);	\
> -	va_end(__ap);				\
> -						\
> -	min(__ret, TRACE_EVENT_STR_MAX);	\
> +#define __trace_event_vstr_len(fmt, va)			\
> +({							\
> +	va_list __ap;					\
> +	int __ret;					\
> +							\
> +	va_copy(__ap, *(va));				\
> +	__ret = vsnprintf(NULL, 0, fmt, __ap) + 1;	\

It works fine now, thanks a lot

> +	va_end(__ap);					\
> +							\
> +	min(__ret, TRACE_EVENT_STR_MAX);		\
>  })
>  
>  #endif /* _LINUX_TRACE_EVENT_H */

