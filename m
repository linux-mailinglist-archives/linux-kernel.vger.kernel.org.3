Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFCC507B21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353177AbiDSUo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357711AbiDSUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:42:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D40BEE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ROhogLVDJv2twC0NObQKkeLJe873ECih460hy+INEQs=; b=DhU6f5mkIBFearZIkpsWWbPWEe
        kZ+OHuF03zpFG1xL5YE0QradHDc7cxDHC39wLVJ8iSJC1zLLM0Mwr3tfR4EpnU84MuZMgUZ8CkiuI
        PSjY0OcAMajtmvfyPE6GaHefDFZPN+UOFZNa/sXpP87+tz40Zz2FiTFF4NEMhXwcdShW+U5AVAmSq
        Kpla1oyGeoIP1MjlXQagHiADsfTjjNBvaube733wNq5YIzVtuw/5x3ZYz6z0c5C3LSHLvQqYcoWY5
        puGVeDJF0EHKvtNxV0e1+unPgbN17Wn3mxC4fB7+wVRuJc2HUjwkEtqk73Z6i0clxYzJ6zTUXJU/R
        61AwQMCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngudM-006uqz-Cs; Tue, 19 Apr 2022 20:39:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB23B3003AA;
        Tue, 19 Apr 2022 22:39:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 719F1212B0C79; Tue, 19 Apr 2022 22:39:34 +0200 (CEST)
Message-ID: <20220419203254.034493341@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 19 Apr 2022 22:32:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz
Subject: [PATCH 0/2] objtool: Fix code reloc vs weak symbols
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fun bugs that make can cause other fun fail if you have a fresh enough
toolchain that strips unused section symbols.

The symptoms can vary between a faulty unwind to a kernel splat for trying to
patch the wrong text.

I found it while playing with text patching and Josh confirmed it very much
affects ORC data too.

