Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B12B586056
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiGaSSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGaSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:18:05 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F671AE64;
        Sun, 31 Jul 2022 11:18:04 -0700 (PDT)
Date:   Mon, 1 Aug 2022 02:17:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659291482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dS/Z4x1hxkzvw2PXjyTCxS8B+KmxuxOGpGlnbjr4bXA=;
        b=wFSUsthZSQ43DaZwYIq/EFmgQrldgTQoPJNCK/WFQ7qGEtYfksg5LeF6/lL/GAFIv1Fid1
        q9RWW+NE4HjE+1mZhflgJ4QcJgs0YIIDpEACC2f5xcNa/ix4GrskDWpW0/ysvJbz4aMYPw
        IOYFFWasLSmnPmPtVte2z612kPovy4Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V9 03/16] rv/include: Add helper functions for
 deterministic automata
Message-ID: <YubHTTjXez6n8KkN@geo.homenetwork>
References: <cover.1659052063.git.bristot@kernel.org>
 <563234f2bfa84b540f60cf9e39c2d9f0eea95a55.1659052063.git.bristot@kernel.org>
 <YuacJsPya8PSE8qt@geo.homenetwork>
 <7b3f7ec1-a479-f3ed-42b3-ddead0f9b427@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b3f7ec1-a479-f3ed-42b3-ddead0f9b427@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 06:02:47PM +0200, Daniel Bristot de Oliveira wrote:
> On 7/31/22 17:13, Tao Zhou wrote:
> > On Fri, Jul 29, 2022 at 11:38:42AM +0200, Daniel Bristot de Oliveira wrote:
> > 
> > [...]
> > 
> >> +static inline type model_get_next_state_##name(enum states_##name curr_state,	\
> >> +					       enum events_##name event)	\
> >> +{										\
> >> +	if ((curr_state < 0) || (curr_state >= state_max_##name))		\
> >> +		return INVALID_STATE;						\
> >> +										\
> >> +	if ((event < 0) || (event >= event_max_##name))				\
> >> +		return INVALID_STATE;						\
> > 
> > Should define the INVALID_EVENT corresponding to event invalid case.
> 
> no.

Absolutly I lost here, this is for *get next state*, must return
a state info.

> 
> -- Daniel
