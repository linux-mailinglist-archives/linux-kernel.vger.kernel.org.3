Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4844D2B16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiCII7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiCII7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:59:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4533CFC1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:58:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF83A210FF;
        Wed,  9 Mar 2022 08:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646816324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4AJu/wysJHmIswvQXSaX+yqN3X7O/Pe+3NXzpiDTA8=;
        b=Y0Fzdvy7p16kKlow8GqWKUk8k/nyRyZ4G2StnJyAv0PV0SYyA5cAV+wuyOxewuQWZu/eij
        p8li1z/HvoPnTA8SzB9OxKeViJH+3SgKCl3GBzTtC52A4mWT4WNZ+BNYNeIFNw2RqwMEZ0
        5uBFcBsJ8oaqfx7eP/kzghnysfrji30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646816324;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4AJu/wysJHmIswvQXSaX+yqN3X7O/Pe+3NXzpiDTA8=;
        b=mypzG7T8IMXnyC0Gytkq2D053hqMmCQGhUOWuF19SI2gnqtnE61vtEDcSYEtD6VxYmf5NQ
        N3ro8Qpfoqp+gSBg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 409EAA3B84;
        Wed,  9 Mar 2022 08:58:44 +0000 (UTC)
Date:   Wed, 9 Mar 2022 09:58:44 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 19/45] x86/livepatch: Validate __fentry__ location
In-Reply-To: <20220308154318.285971256@infradead.org>
Message-ID: <alpine.LSU.2.21.2203090958270.672@pobox.suse.cz>
References: <20220308153011.021123062@infradead.org> <20220308154318.285971256@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022, Peter Zijlstra wrote:

> Currently livepatch assumes __fentry__ lives at func+0, which is most
> likely untrue with IBT on. Instead make it use ftrace_location() by
> default which both validates and finds the actual ip if there is any
> in the same symbol.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
