Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D2C5801C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbiGYPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbiGYPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:23:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AE6BEE;
        Mon, 25 Jul 2022 08:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60D186122D;
        Mon, 25 Jul 2022 15:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943AAC341C6;
        Mon, 25 Jul 2022 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658762609;
        bh=3s3HCAIq22KW8xdlHADk+52r1ZJHJUwaz1P2FsyYFfU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oScXdJx5xfbg//Whh9manEFT986v5s9h4ig/+L7Fl1xIsraZpC69KrO3xVHv2ggmA
         idz2nHsBB9F9cxAe/tY5SNmZlc2IVP381AKRbwRgDh9DDDAMD7MP3IOWlaIXQWuNgg
         QB8+BaFbH+RJ54PsTorxmFWCtucEIEwhGP7JOx+YBJtmQ1sICZGqtGL4PBf9MgGeOg
         s9ikuOiNopmUNnYFMOKXb3JEskJqAZXKCZELcy/2NcD+6iksi5d+cBwGZflga/A/Is
         Ptkl432RnAvplE87qAavg5V9sfZR4dbvUzZCyGc0qHqlOWZs6+mV2///k4hiuW5nsx
         7U7F1oXYPhyWQ==
Message-ID: <8112c80c-8e65-aa0e-e335-562d9b8d3343@kernel.org>
Date:   Mon, 25 Jul 2022 17:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] rtla: Fix double free
Content-Language: en-US
To:     Andreas Schwab <schwab@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mvmzggxl4n1.fsf@suse.de>
 <fd0888a4-099c-95fe-7e20-82be1489061f@kernel.org> <mvmv8rll2yn.fsf@suse.de>
 <20220725105639.295a7d7d@gandalf.local.home> <mvmilnlkyzx.fsf_-_@suse.de>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <mvmilnlkyzx.fsf_-_@suse.de>
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

On 7/25/22 17:12, Andreas Schwab wrote:
> Avoid double free by making trace_instance_destroy indempotent.  When
> trace_instance_init fails, it calls trace_instance_destroy, but its only
> caller osnoise_destroy_tool calls it again.
> 
> Fixes: 0605bf009f18 ("rtla: Add osnoise tool")
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
