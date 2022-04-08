Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3694FA001
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 01:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiDHXRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 19:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiDHXRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 19:17:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2883633F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=387NM5ZeDMcsK5G5wFhbgPoD4mYSR3PEZAVSuZg05ME=; b=cWBX4Q9FwStDB6kIaP2JxkSQWy
        aHAo0pbs5r/cSRC1+SF6m73peRCdOwyi/Ma/FZy/KNfJUNMLEKKEHs7GFYulEl3iHB8sjTBlJDXEm
        CCuku2AocWuYog1G5RUKB/HR97Ui11OzzX7atsK3CZeIjQWHZD/X09jWWzqetqZa/crn+1wy9JCW7
        CFtLk9h7F0Th9fVf5Gm0jWVGHmFZdY/vnPONFS8l1/BRayyvCdQvFcQ73j6uzd4EbqN02tbpdbxvH
        k0bA4TwNvD9HefUGu4+QBK9BL8EZ/IRom9OL2P4KiKbwmcMRe+frh1hfnZ9VzCTTKb6/5IPzC9qnK
        7sfjffsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncxoX-0036yn-VV; Fri, 08 Apr 2022 23:14:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC6699861C5; Sat,  9 Apr 2022 01:14:47 +0200 (CEST)
Date:   Sat, 9 Apr 2022 01:14:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86: PUSH_AND_CLEAR_REGS_COMPAT
Message-ID: <20220408231447.GS2731@worktop.programming.kicks-ass.net>
References: <20220408223827.GR2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408223827.GR2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 12:38:27AM +0200, Peter Zijlstra wrote:
> 
> How insane?

Anyway, the questino is; since int80 doesn't wipe the high regs, can we
get away with the SYS*_compat things not doing that either and then all
using the normal PUSH_AND_CLEAR_REGS without having to invent _COMPAT
for that?
