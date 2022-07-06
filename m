Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA985691DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiGFSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiGFSee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:34:34 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84582186F1;
        Wed,  6 Jul 2022 11:34:32 -0700 (PDT)
Date:   Thu, 7 Jul 2022 02:35:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657132470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IO11bj6nk+Np3PVqv865QhkFdKjlAqHlVwGCt6I3fOc=;
        b=OQWWsrwJIl6r1fSKhY4Z9Xt+JTyjL0JxygDTc4oUaCD/ViMTFy2fU7z6QUYPEnSWFCW50e
        3cE4yeNrZGYHM7EohbouH+Z2sCBeqaLyoWq6MdO/GbNrwWTbagLsxKr84zS8caHrcCY4dL
        DtAMxtsptEKG96+UhhixtKCfqLbWY4Y=
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V4 03/20] rv/include: Add helper functions for
 deterministic automata
Message-ID: <YsXV+KTbOU0E5dU+@geo.homenetwork>
References: <cover.1655368610.git.bristot@kernel.org>
 <2b5b14c821ee4b069f68571e7f78fbc2ee4e9626.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b5b14c821ee4b069f68571e7f78fbc2ee4e9626.1655368610.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 10:44:45AM +0200, Daniel Bristot de Oliveira wrote:

> Formally, a deterministic automaton, denoted by G, is defined as a
> quintuple:
> 
>   G = { X, E, f, x_0, X_m }
> 
> where:
> 	- X is the set of states;
> 	- E is the finite set of events;
> 	- x_0 is the initial state;
> 	- X_m (subset of X) is the set of marked states.
> 	- f : X x E -> X $ is the transition function. It defines the
> 	  state transition in the occurrence of a event from E in
> 	  the state X. In the special case of deterministic automata,
> 	  the occurrence of the event in E in a state in X has a
> 	  deterministic next state from X.
> 
> An automaton can also be represented using a graphical format of
> vertices (nodes) and edges. The open-source tool Graphviz can produce
> this graphic format using the (textual) DOT language as the source code.
> 
> The dot2c tool presented in this paper:
> 
> DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo
> Silva. Efficient formal verification for the Linux kernel. In:
> International Conference on Software Engineering and Formal Methods.
> Springer, Cham, 2019. p. 315-332.
> 
> Translates a deterministic automaton in the DOT format into a C
> surce code representation that to be used for monitoring.
> 
> This header file implements helper functions to facilitate the usage
> of the C output from dot2c for monitoring.
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Gabriele Paoloni <gpaoloni@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  include/rv/automata.h | 49 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 include/rv/automata.h
> 
> diff --git a/include/rv/automata.h b/include/rv/automata.h
> new file mode 100644
> index 000000000000..0c0aa54bd820
> --- /dev/null
> +++ b/include/rv/automata.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Deterministic automata helper functions, to be used with the automata
> + * models in C generated by the dot2k tool.
> + *
> + * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
> + */
> +
> +#define DECLARE_AUTOMATA_HELPERS(name, type)					\
> +										\
> +static inline void *model_get_model_##name(void)				\
> +{										\
> +	return (void *) &automaton_##name;					\
> +}									\
> +										\
> +static char *model_get_state_name_##name(enum states_##name state)		\
> +{										\
> +	return automaton_##name.state_names[state];				\
> +}										\
> +										\
> +static char *model_get_event_name_##name(enum events_##name event)		\
> +{										\
> +	return automaton_##name.event_names[event];				\
> +}										\
> +										\
> +static inline type model_get_init_state_##name(void)				\
> +{										\
> +	return automaton_##name.initial_state;					\
> +}										\
> +										\
> +static inline type model_get_next_state_##name(enum states_##name curr_state,	\
> +					       enum events_##name event)	\
> +{										\
> +	if ((curr_state < 0) || (curr_state > state_max_##name))		\
> +		return -1;							\

curr_state can not be state_max_xxx. curr_state must be not bigger
than state_max_xxx. Or am I miss something?

> +	if ((event < 0) || (event > event_max_##name))				\
> +		return -1;							\
> +										\

Same here for the event boundary check.

> +	return automaton_##name.function[curr_state][event];			\
> +}										\
> +										\
> +static inline bool model_is_final_state_##name(enum states_##name state)	\
> +{										\
> +	if ((state < 0) || (state > state_max_##name))				\
> +		return 0;							\
> +										\

Same here.

> +	return !!automaton_##name.final_states[state];				\

If the value of .final_states[state] is 0 or 1, can the type of
.final_states[state] be befined to bool. Or not need to use !! to
explicitly transfer the type to bool. I remember that you define
this as char array and the matrix model value of this array is 0 or 1
see from the next patche. 1 delegate the state it is the initial state.
0 for others.

> +}
> -- 
> 2.35.1
> 
