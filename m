Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F35750070B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiDNHjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240423AbiDNHjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:39:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602C45620A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nxYEe9XeVrAwDah0gCKIKd945cGVuCaFVlj7BxNU+nI=; b=mac+XMium0zIEnQ6WvRhTBMvlo
        HcYz2RiataKKUHqlPh3zw2G6E6ekFtfXT2cz3/0YZhxLGNunixCi71Vov4li2UyX5o0UbbhFhFn8G
        /zY+l5HfRJ/B+vyeZf5p8VJPbg0nnkrti9NVUwucQVhkLN2nJTK87tj/zeeXBvjdGUI0A6JFJsTEy
        i48ucOHi4IWdyWYSVLRrrjbjQ93DxLGzhiAbM3HfktxJfnBRQREIMpN28UIZXBY9VLgqVASN9ZNOI
        HiK9CM+XumTaW8U5hG6GQT6pVo3E8uivnoeJtmtbcXVkNzxG7Sz7Rk8dzQuwY1enjx85aE9elVPPJ
        otsee9yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neu1x-004wgu-Nr; Thu, 14 Apr 2022 07:36:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DDFE3001AE;
        Thu, 14 Apr 2022 09:36:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12F452B3A873D; Thu, 14 Apr 2022 09:36:40 +0200 (CEST)
Date:   Thu, 14 Apr 2022 09:36:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 04/18] objtool: Print data address for "!ENDBR" data
 warnings
Message-ID: <YlfPBzwKpEA09qyQ@hirez.programming.kicks-ass.net>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <8208fa7edf2dc576e8f9bcf24396b128f59bdfe9.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8208fa7edf2dc576e8f9bcf24396b128f59bdfe9.1649891421.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:19:39PM -0700, Josh Poimboeuf wrote:
> When a "!ENDBR" warning is reported for a data section, objtool just
> prints the text address of the relocation target twice, without giving
> any clues about the location of the original data reference:
> 
>   vmlinux.o: warning: objtool: dcbnl_netdevice_event()+0x0: .text+0xb64680: data relocation to !ENDBR: dcbnl_netdevice_event+0x0
> 
> Instead, print the address of the data reference, in addition to the
> address of the relocation target.
> 
>   vmlinux.o: warning: objtool: dcbnl_nb+0x0: .data..read_mostly+0xe260: data relocation to !ENDBR: dcbnl_netdevice_event+0x0

Duh yes!
