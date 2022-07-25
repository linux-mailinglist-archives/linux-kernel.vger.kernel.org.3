Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E8580004
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiGYNfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiGYNfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:35:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6CDE96;
        Mon, 25 Jul 2022 06:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB6AAB80EBD;
        Mon, 25 Jul 2022 13:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD7BC341C6;
        Mon, 25 Jul 2022 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658756100;
        bh=iXTZl82xPnL3ZeeWoL4R6ZJJPzGA7rJ5dFSLoDqRxaA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m/BXU7/ah1mbdoD00sd98wt4MogVXpkWjBxjPram94CyhbmReezVEuoezT5+b3GPw
         S8RLQNeq06/sZAiSEHO7397zearvu5SqUpzNYj/KiUfUWIwX3Z69vXNSCCFTL1baga
         6Myvcq0uoqM440cJqcc+Fd5TwF2OaLrbXe7srqoyEIizIrPQwhKzIvH1h1VuIq9hGE
         PSnc98wIsf03Ciw2/t1EN5wP71ZH/QT8pQcE54wAiFqvDiFC+fvNeSk3LNZiFmq4KR
         VL4AVC61BT9TWNlh6gYjYEDGGnSY4Y9QNohz0odYc5OHgr4lMkPpTDJ2hCMdWbpcE5
         MRFhbqK935F6A==
Message-ID: <fd0888a4-099c-95fe-7e20-82be1489061f@kernel.org>
Date:   Mon, 25 Jul 2022 15:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] rtla: fix double free
Content-Language: en-US
To:     Andreas Schwab <schwab@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mvmzggxl4n1.fsf@suse.de>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <mvmzggxl4n1.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas

On 7/25/22 15:10, Andreas Schwab wrote:
> Don't call trace_instance_destroy in trace_instance_init when it fails,
> this is done by the caller.

Regarding the Subject, are you seeing a double-free error, or it is just an
optimization?

AFAICS, trace_instance_destroy() checks the pointers before calling free().

Why am I asking? because if it is a double-free bug, we need to add the "Fixes:"
tag, otherwise, we can think about a Subject that better describes the patch,  like:

"rtla: Do not call trace_instance_destroy() twice on error"

Also, after the "subsystem:," i.e., "rlta:" we need to use capital: e.g.,

"rtla: Fix double free"

Anyways, I see that the code makes sense. I am just trying to improve the
description.

Thanks!
-- Daniel
