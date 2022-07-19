Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C63757A41B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiGSQUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbiGSQTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:19:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840914F6B9;
        Tue, 19 Jul 2022 09:19:47 -0700 (PDT)
X-UUID: 9293cba5641a4cc38f72583de904db07-20220720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:f9d2eda1-1208-4a91-91c9-625effff585d,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:cbcde9d7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 9293cba5641a4cc38f72583de904db07-20220720
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 975616273; Wed, 20 Jul 2022 00:19:43 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 20 Jul 2022 00:19:42 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 20 Jul 2022 00:19:42 +0800
Message-ID: <9686bb9f16cf2a5f236b98b2467345465097cede.camel@mediatek.com>
Subject: Re: [PATCH v2] USB: mtu3: tracing: Use the new __vstring() helper
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 20 Jul 2022 00:19:42 +0800
In-Reply-To: <20220719112719.17e796c6@gandalf.local.home>
References: <20220719112719.17e796c6@gandalf.local.home>
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

On Tue, 2022-07-19 at 11:27 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Instead of open coding a __dynamic_array() with a fixed length (which
> defeats the purpose of the dynamic array in the first place). Use the
> new
> __vstring() helper that will use a va_list and only write enough of
> the
> string into the ring buffer that is needed.
> 
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: 
> https://urldefense.com/v3/__https://lkml.kernel.org/r/20220705224750.354926535@goodmis.org__;!!CTRNKA9wMg0ARbw!w4K66JYkRKSGW-em5q2L6FJ6YI_Z81PAnnTJrBJayW6pf_-JVd5-B5daGto_frdtBJcz$
>  
> 
>  - Removed MTU3_MSG_MAX define. (Chunfeng Yun)
> 
>  drivers/usb/mtu3/mtu3_trace.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_trace.h
> b/drivers/usb/mtu3/mtu3_trace.h
> index 1b897636daf2..a98fa012b729 100644
> --- a/drivers/usb/mtu3/mtu3_trace.h
> +++ b/drivers/usb/mtu3/mtu3_trace.h
> @@ -18,18 +18,16 @@
>  
>  #include "mtu3.h"
>  
> -#define MTU3_MSG_MAX	256
> -
>  TRACE_EVENT(mtu3_log,
>  	TP_PROTO(struct device *dev, struct va_format *vaf),
>  	TP_ARGS(dev, vaf),
>  	TP_STRUCT__entry(
>  		__string(name, dev_name(dev))
> -		__dynamic_array(char, msg, MTU3_MSG_MAX)
> +		__vstring(msg, vaf->fmt, vaf->va)
>  	),
>  	TP_fast_assign(
>  		__assign_str(name, dev_name(dev));
> -		vsnprintf(__get_str(msg), MTU3_MSG_MAX, vaf->fmt, *vaf-
> >va);
> +		__assign_vstr(msg, vaf->fmt, vaf->va);
>  	),
>  	TP_printk("%s: %s", __get_str(name), __get_str(msg))
>  );
Tested-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks a lot

