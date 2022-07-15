Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A80576926
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiGOVo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiGOVo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4842A273
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5991619D2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 21:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988D8C34115;
        Fri, 15 Jul 2022 21:44:23 +0000 (UTC)
Date:   Fri, 15 Jul 2022 17:44:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [PATCH 01/13 v2] tracing/events: Add __vstring() and
 __assign_vstr() helper macros
Message-ID: <20220715174422.6bf21fc2@gandalf.local.home>
In-Reply-To: <20220715174214.22314a87@gandalf.local.home>
References: <20220705224453.120955146@goodmis.org>
        <20220705224749.053570613@goodmis.org>
        <20220715174214.22314a87@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 17:42:14 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

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

I forgot to mention what is different in v2. I fixed what happened to be in
the change log, as there was an off by one error. I just updated the change
log in my git repo to have the above be:

It uses the helper:

 #define __trace_event_vstr_len(fmt, va)                \
 ({                                                     \
        va_list __ap;                                   \
        int __ret;                                      \
                                                        \
        va_copy(__ap, *(va));                           \
        __ret = vsnprintf(NULL, 0, fmt, __ap) + 1;      \
        va_end(__ap);                                   \
                                                        \
        min(__ret, TRACE_EVENT_STR_MAX);                \
 })


-- Steve
