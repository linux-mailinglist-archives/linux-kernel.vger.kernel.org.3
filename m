Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0FA55EB54
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiF1RtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiF1Rsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561ECAE4F;
        Tue, 28 Jun 2022 10:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B86F619B3;
        Tue, 28 Jun 2022 17:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45E3C341C8;
        Tue, 28 Jun 2022 17:48:34 +0000 (UTC)
Date:   Tue, 28 Jun 2022 13:48:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 03/20] rv/include: Add helper functions for
 deterministic automata
Message-ID: <20220628134833.60b69f9f@gandalf.local.home>
In-Reply-To: <2b5b14c821ee4b069f68571e7f78fbc2ee4e9626.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
        <2b5b14c821ee4b069f68571e7f78fbc2ee4e9626.1655368610.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 10:44:45 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

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
> source code representation that to be used for monitoring.
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

Copyright before the description.

> + */
> +

There should be comments here describing how the helper functions are used.

-- Steve

> +#define DECLARE_AUTOMATA_HELPERS(name, type)					\
> +										\
> +static inline void *model_get_model_##name(void)				\
> +{										\
> +	return (void *) &automaton_##name;					\
> +}										\
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
> +										\
> +	if ((event < 0) || (event > event_max_##name))				\
> +		return -1;							\
> +										\
> +	return automaton_##name.function[curr_state][event];			\
> +}										\
> +										\
> +static inline bool model_is_final_state_##name(enum states_##name state)	\
> +{										\
> +	if ((state < 0) || (state > state_max_##name))				\
> +		return 0;							\
> +										\
> +	return !!automaton_##name.final_states[state];				\
> +}

