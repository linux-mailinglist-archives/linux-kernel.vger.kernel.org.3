Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A964C8DED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiCAOiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiCAOiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:38:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CAA1C103
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:37:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 08BC51F37E;
        Tue,  1 Mar 2022 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646145446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uac5kDRZGDpU/Kxeg+CZWjBJUAHk7M4ZHaBjBg25V7E=;
        b=yrZyjWBmRggo/kHm8w/I/nGUH/LLLbLfPl5WKSHercrYdb0/pqFzNLK8VPT8L/8DqkmQZK
        zNdBqYOUT98icfWTOGS5/Sj36Fskp47ncSC7s0ucztT2hOiA9tz2Y9uTdLvupLC/xbKVXO
        9wjYQWCCMpnti2sPQGKrDaXNGPg+/hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646145446;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uac5kDRZGDpU/Kxeg+CZWjBJUAHk7M4ZHaBjBg25V7E=;
        b=II2ng3TfiBBAjclgG3X3te70BDrOWi/+XSLIYbf/Jnp+/wliRLWke8cvAKcBuDbGDwmBqr
        tFoNhrlt75EP+UBQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 85DB9A3B8B;
        Tue,  1 Mar 2022 14:37:25 +0000 (UTC)
Date:   Tue, 1 Mar 2022 15:37:25 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 03/39] x86/module: Fix the paravirt vs alternative
 order
In-Reply-To: <20220224151322.190822141@infradead.org>
Message-ID: <alpine.LSU.2.21.2203011537080.8402@pobox.suse.cz>
References: <20220224145138.952963315@infradead.org> <20220224151322.190822141@infradead.org>
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

On Thu, 24 Feb 2022, Peter Zijlstra wrote:

> Ever since commit 4e6292114c741 ("x86/paravirt: Add new features for
> paravirt patching") there is an ordering dependency between patching
> paravirt ops and patching alternatives, the module loader still
> violates this.
> 
> Fixes: 4e6292114c741 ("x86/paravirt: Add new features for paravirt patching")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
