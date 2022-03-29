Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED39A4EA513
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiC2CVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiC2CVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:21:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C992717D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:19:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49AF521985;
        Tue, 29 Mar 2022 02:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648520392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZPkIZ/XPkzUw3GjYvyN+kAbsucuIGnV2jh6uGeU7IYw=;
        b=Nqd4JoQK6yUWhkcVCPx/L2AnKtO3DnEXQc+fbSPNlZADjl1RQ/AnZKioJKNOMqj7uCYtte
        mlyfhrqR5G7T5aodZkGOTeXBCdZNP/AwPQmbqi5WUXVgRfnzaAuIRFfKGk65mptVqC2znn
        JkIyadYj/SBG+Zs/5tJVyDYX0u1jq4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648520392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZPkIZ/XPkzUw3GjYvyN+kAbsucuIGnV2jh6uGeU7IYw=;
        b=DzeLs96G9pLdG7R6oZoAvgLb8XvdopgoKAISiuJ/595Gh3Qw9DQ58FbSPP1yZSrbGym2qc
        edOnjsVfueSeb7Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0BED13A7E;
        Tue, 29 Mar 2022 02:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2eezE8dsQmLhNQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 29 Mar 2022 02:19:51 +0000
Date:   Mon, 28 Mar 2022 23:19:41 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     CGEL <cgel.zte@gmail.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        paul@paul-moore.com, kbuild-all@lists.01.org,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        eparis@redhat.com, Yang Yang <yang.yang29@zte.com.cn>,
        linux-audit@redhat.com
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
Message-ID: <20220329021941.ai3d6fgrkyd5ylto@cyberdelia>
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <202203270449.WBYQF9X3-lkp@intel.com>
 <62426553.1c69fb81.bb808.345c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <62426553.1c69fb81.bb808.345c@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29, CGEL wrote:
>>    In file included from include/linux/init.h:5,
>>                     from kernel/auditsc.c:34:
>>    kernel/auditsc.c: In function '__audit_syscall_exit':
>> >> kernel/auditsc.c:2081:61: error: 'NR_syscalls' undeclared (first use in this function); did you mean 'si_syscall'?
>>     2081 |             unlikely(context->major < 0 || context->major > NR_syscalls))
>>          |                                                             ^~~~~~~~~~~
>
>Sorry could anybody give a hand to solve this? It works well on x86_64 and arm64.
>I have no alpha environment and not familiar to this arch, much thanks!

Sorry, no experience either, but from a quick look at arch/alpha/include/asm/unistd.h
shows that it's called NR_SYSCALLS for alpha arch, for whatever reason.


HTH

Enzo
