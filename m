Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5DD4CA223
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbiCBK0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbiCBK0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:26:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECECAD122
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GJ2BhPTfVAxkP4FcHPOJE11vP5WKDPDbfIXXkA1bkvQ=; b=v34sa9cOoRhiCgFv6PAn5chOli
        bf3v6w2iR3antJq4oO9ETRdLX8YnN2RsO/KhSNP+rjoK9HFnHmg42G1QHASBoxKsQRFCJTGycdpcE
        w+sxMImLufEnUFD4zvYdgc6visCeWclv8SWhtPHYT4MklQY8aJr8A6lUXZLTL/BFZDUp8SIUkpA/u
        KIBybGXLlKdgHP32fWOr9XAMGehiG34aufidEGK4XfnpdZXQD1RW/ZTMtW6/QydMAck7PfeQ1X16s
        tcYAZNjCF2zdfKOwzbI/heQ6YAB3PLitLdlwPgR7ToFKuObkp1F2Imc9Z3OaNXYUud7zOJ6bZy+Ne
        o/mKE23g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPMAj-00AUKf-V5; Wed, 02 Mar 2022 10:25:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66E0530018E;
        Wed,  2 Mar 2022 11:25:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2872F321EE6E0; Wed,  2 Mar 2022 11:25:29 +0100 (CET)
Date:   Wed, 2 Mar 2022 11:25:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, alexei.starovoitov@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <Yh9GGY0tT/Wwkg8d@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.892372059@infradead.org>
 <20220228150705.aab2d654b973109bab070ffe@kernel.org>
 <20220228232513.GH11184@worktop.programming.kicks-ass.net>
 <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
 <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
 <20220302091150.21daa1b3f153a98206ee8d9a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302091150.21daa1b3f153a98206ee8d9a@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 09:11:50AM +0900, Masami Hiramatsu wrote:

> > But if you really want/need to retain that, then yes, we need that
> > else branch unconditionally :/
> 
> Thank you,

That's what I ended up doing in the latest version; I realized that
irrespective of symbol size, it is required when symbols overlap, as per
the case mentioned by Naveen.

  https://lkml.kernel.org/r/20220301200547.GK11184@worktop.programming.kicks-ass.net
