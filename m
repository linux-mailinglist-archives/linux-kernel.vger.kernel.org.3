Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E215801A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbiGYPV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbiGYPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:21:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5976159;
        Mon, 25 Jul 2022 08:18:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 28CD33447C;
        Mon, 25 Jul 2022 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658762313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yMSuGIGKLpHAzMbpgLiAFszp/HqZve7TTrNtIxOn6TY=;
        b=ivTJWNrJiBymPEB/Qa+jyPhEXDIlra0zBkWR3N3l43YJd3uPzwZ8TGq+0S2PFQO6nCLbEy
        P6VEqskZFSaOg60MBtz7av+C/aI4xiPvffmLz5F/ZtnsisxVsoXikHjyEP6w0eGDoQXOD7
        Ah6UUh5Wvsey9xKzpEXeHa6yHX41C3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658762313;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yMSuGIGKLpHAzMbpgLiAFszp/HqZve7TTrNtIxOn6TY=;
        b=1uH8/AQVCYHhY4LAHMSnZ9e6Uki809Yd24q6eVVPUUXVXH0AbbG0qnaO7Mx2YW+LyuFN3E
        TuM9WQZF9vaeO/AQ==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 1F0FF2C171;
        Mon, 25 Jul 2022 15:18:33 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 08D89444B2F; Mon, 25 Jul 2022 17:18:32 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtla: Fix double free
References: <mvmzggxl4n1.fsf@suse.de>
        <fd0888a4-099c-95fe-7e20-82be1489061f@kernel.org>
        <mvmv8rll2yn.fsf@suse.de> <20220725105639.295a7d7d@gandalf.local.home>
        <mvmilnlkyzx.fsf_-_@suse.de>
X-Yow:  Yow!  Is my fallout shelter termite proof?
Date:   Mon, 25 Jul 2022 17:18:32 +0200
In-Reply-To: <mvmilnlkyzx.fsf_-_@suse.de> (Andreas Schwab's message of "Mon,
        25 Jul 2022 17:12:18 +0200")
Message-ID: <mvmedy9kypj.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25 2022, Andreas Schwab wrote:

> Avoid double free by making trace_instance_destroy indempotent.  When

s/indempotent/idempotent/

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
