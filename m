Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD144BC277
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 23:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiBRWNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 17:13:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBRWNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 17:13:04 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B8E282E64
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:12:46 -0800 (PST)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id A257DC0003;
        Fri, 18 Feb 2022 22:12:40 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 18 Feb 2022 14:12:40 -0800
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 05/29] x86: Base IBT bits
In-Reply-To: <20220218171408.867389898@infradead.org>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.867389898@infradead.org>
Message-ID: <02a2ff3df3a0093a4f283e09f583d42d@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +config CC_HAS_IBT
> +	# GCC >= 9 and binutils >= 2.29
> +	# Retpoline check to work around
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93654
> +	def_bool $(cc-option, -fcf-protection=branch
> -mindirect-branch-register) && $(as-instr,endbr64)
> +
Is -mindirect-branch-register breaks compiling with clang. Maybe we 
should we do instead?

+       def_bool ($(cc-option, -fcf-protection=branch 
-mindirect-branch-register) || $(cc-option, -mretpoline-external-thunk)) 
&& $(as-instr,endbr64)
