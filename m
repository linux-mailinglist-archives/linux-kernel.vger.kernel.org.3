Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97B654F739
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382341AbiFQMGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381162AbiFQMGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:06:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232BC6BFEB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=W7dioW9GckbO/QAEw6YwwZqu+Fq9mZEtJ5kA67FvXx4=; b=KfYUuFq1DBF5HuBWNMM7NkLgXQ
        3KzIOSpvVPRYtex03vRT5DpF640FP8RTVAgf62cINM4zYQXNBiPjKPtmRs1D2PB36XjfPH+PYvAzI
        G2orTgW6Ix5fvhzU6i577n00Clc2AWaSSZ6uie+fJresZkzX+fVAh4L7CMzZWNpteS00la8CistwS
        kGrt/ELeBx4xQbXOcZwElyD+VVHzEDNxQV5eIWPV7WkaeNgouuYVIYYWSyj/XGQVdMhZktJ8v87Uw
        eKQvRxx3arybpNJDLjZfkPXi7PaNecpTED3jL6shXnpcw3kvd45GtZ85LWu3MTL2EdypYN5o/PpqY
        lx3hnUzA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2AkG-008gAP-HW; Fri, 17 Jun 2022 12:06:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3F299816B5; Fri, 17 Jun 2022 14:06:34 +0200 (CEST)
Date:   Fri, 17 Jun 2022 14:06:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Message-ID: <YqxuSgj3DEACVukJ@worktop.programming.kicks-ass.net>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
 <5c759021-99ce-7633-699d-49b3229df339@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c759021-99ce-7633-699d-49b3229df339@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:44:49AM +0000, Christophe Leroy wrote:
> 
> 
> Le 17/06/2022 à 13:24, Peter Zijlstra a écrit :
> > 
> > Hi,
> > 
> > I recently noticed that __mcount_loc is 64bit wide, containing absolute
> > addresses. Since __mcount_loc is a permanent section (not one we drop
> > after boot), this bloats the kernel memory usage for no real purpose.
> 
> I guess you mean it is 64bit wide on 64 bits architectures ? Because it 
> seems to be defined as 'long' so will be 32bit on 32 bits architectures ?

Right, it's an absolute address in the native size. Clearly I'm somewhat
64bit biassed :-)
