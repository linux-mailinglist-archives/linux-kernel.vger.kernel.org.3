Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E1B50196A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbiDNRD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244732AbiDNRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:02:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C439225
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HWXZ58+8O5O/ylVY7YzomUsMCZdShld5WOXMeuFvBMY=; b=JsF+Z5H2Ap4dxkmRnE+gG3ospE
        4Jv3VCbCOeEHoCJIKVula935XbldnDG7QH2idSuV+8wr9oJoPFre6m19PdajrRcXrLrDDQmc3WD7k
        WpRkOAuYygBkACYqCzE25tu5aZT+M9es3WejLp0um6LCKKfSPnCfRR7gsXq/wHpgw8xY7WeSVD+RN
        2z6qSMpMGE+QEDat4v3TobGl/WGi98uNuE9azuMeOLVt5wdG94OcT1ku9Inbf1jqvynww6R7nzDla
        lFUgfFlRPI4MuwtJ0iQcdD7qc6OnnpZ7ZTmLoCXweNxtvUNlq1CMx+C7eMQscEg1VSv4xWoga/U3H
        EQJuW1Jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf2U4-00547R-PK; Thu, 14 Apr 2022 16:38:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B01B30031E;
        Thu, 14 Apr 2022 18:38:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57D713232154A; Thu, 14 Apr 2022 18:38:16 +0200 (CEST)
Date:   Thu, 14 Apr 2022 18:38:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 10/18] objtool: Extricate ibt from stack validation
Message-ID: <YlhN+GFZlycwydSv@hirez.programming.kicks-ass.net>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <44a73f724b51c4a994edc43536b7a7ee5e972b40.1649891421.git.jpoimboe@redhat.com>
 <YlfS7twQVCHGgtCV@hirez.programming.kicks-ass.net>
 <20220414154449.5moa7xsczwybbqhd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414154449.5moa7xsczwybbqhd@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 08:44:49AM -0700, Josh Poimboeuf wrote:

> Ok.  That was subtle, it needs a comment or two.  I had the distinct
> feeling I was introducing a bug, then I got distracted ;-)

Right, lemme try and not forget to write one ;-)

> Doesn't the compiler give those special cases ENDBR anyway?  Just
> wondering why we avoid the warning for those.

Sure, but this is about not scribbling that ENDBR with a NOP.
