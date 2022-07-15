Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A419575B96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiGOGcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGOGcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:32:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CDB186EE;
        Thu, 14 Jul 2022 23:32:10 -0700 (PDT)
X-UUID: 3d0e87fc9e8c40ab947928917b85845f-20220715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:0e331e9d-0f9b-4888-b02d-931748d1e7d6,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:a8280f33-b9e4-42b8-b28a-6364427c76bb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 3d0e87fc9e8c40ab947928917b85845f-20220715
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2075644891; Fri, 15 Jul 2022 14:32:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 15 Jul 2022 14:32:05 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 15 Jul 2022 14:32:05 +0800
Message-ID: <1267b234b09280b9b475cfe2bb32580e967e2dac.camel@mediatek.com>
Subject: Re: [for-next][PATCH 13/23] USB: mtu3: tracing: Use the new
 __vstring() helper
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri, 15 Jul 2022 14:32:05 +0800
In-Reply-To: <20220714164330.311734558@goodmis.org>
References: <20220714164256.403842845@goodmis.org>
         <20220714164330.311734558@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Thu, 2022-07-14 at 12:43 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Instead of open coding a __dynamic_array() with a fixed length (which
> defeats the purpose of the dynamic array in the first place). Use the
> new
> __vstring() helper that will use a va_list and only write enough of
> the
> string into the ring buffer that is needed.
> 
> Link: 
> https://urldefense.com/v3/__https://lkml.kernel.org/r/20220705224750.354926535@goodmis.org__;!!CTRNKA9wMg0ARbw!w8nx66BKDTtyusp5i2pyzOGNb-QyxIAWjoZwmSQY0zzor_rqvBgUm5__vKK98ApKcDic$
>  
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
>  drivers/usb/mtu3/mtu3_trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_trace.h
> b/drivers/usb/mtu3/mtu3_trace.h
> index 1b897636daf2..ef3c17e2f8a6 100644
> --- a/drivers/usb/mtu3/mtu3_trace.h
> +++ b/drivers/usb/mtu3/mtu3_trace.h
> @@ -25,11 +25,11 @@ TRACE_EVENT(mtu3_log,
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

Can you help to remove macro "MTU3_MSG_MAX" and one blank line after it
in this file, this macro is not used anymore after apply this patch.

Thanks a lot



