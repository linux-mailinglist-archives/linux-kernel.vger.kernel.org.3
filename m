Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB451005A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351595AbiDZO0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351588AbiDZO00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:26:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B847AED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:23:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A265B82047
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0EEC385AA;
        Tue, 26 Apr 2022 14:23:14 +0000 (UTC)
Date:   Tue, 26 Apr 2022 10:23:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH v2 2/4] tracing: Remove usage of list iterator variable
 after the loop
Message-ID: <20220426102312.70319297@gandalf.local.home>
In-Reply-To: <20220402103341.1763932-3-jakobkoschel@gmail.com>
References: <20220402103341.1763932-1-jakobkoschel@gmail.com>
        <20220402103341.1763932-3-jakobkoschel@gmail.com>
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

On Sat,  2 Apr 2022 12:33:39 +0200
Jakob Koschel <jakobkoschel@gmail.com> wrote:

This patch crashed in my testing.

> @@ -1734,14 +1734,16 @@ static int subsystem_open(struct inode *inode, struct file *filp)
>  	/* Make sure the system still exists */
>  	mutex_lock(&event_mutex);
>  	mutex_lock(&trace_types_lock);
> -	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> -		list_for_each_entry(dir, &tr->systems, list) {
> -			if (dir == inode->i_private) {
> +	list_for_each_entry(iter_tr, &ftrace_trace_arrays, list) {
> +		list_for_each_entry(iter_dir, &iter_tr->systems, list) {
> +			if (iter_dir == inode->i_private) {
>  				/* Don't open systems with no events */
> -				if (dir->nr_events) {
> +				if (iter_dir->nr_events) {
>  					__get_system_dir(dir);
>  					system = dir->subsystem;

					system = NULL->subsystem


>  				}
> +				tr = iter_tr;
> +				dir = iter_dir;

But do not change that dir, move the setting above it. That is:

				tr = iter_tr;
				dir = iter_dir;
				if (iter_dir->nr_events) {
 					__get_system_dir(dir);
 					system = dir->subsystem;
				}

-- Steve

				
>  				goto exit_loop;
>  			}
>  		}
