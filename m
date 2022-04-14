Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0472750089E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbiDNIqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbiDNIpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:45:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1FB657A8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/HRtMQ3dw3W4AEXwOIIlBJhmt/aYSbzI1lzRClxR+6I=; b=N7OuvHI8LIFE07QlIOsfuEK5Rm
        tNkvlnKNJc+i5MnPdreiFqUjAnosGMEJPmg9IFW6vVeQd5sQaLFi/NXTTF4EJpUgW2ykQyiSiqFOO
        qXaVknO24GTUnEGiqWWWwyNYFoc/2HNPlBU5LDu1oeJvFa7C4VPULmR5i2CMknqqXJd1RuKgL0pgT
        zV15DAXrZuYWlVqkA1vsIK26AkcGn3Km/DEa3/3FWW6cRJ77uqD/m9/Cb0JFJHICff/UavWs/oJtR
        PXsCGcPO60JVUB1vu8NfpIMBzMny4u2Q1XuDLAtthiAgMqDghO+qI6AttpLwSsbwxUkAIiIxMFiz5
        6kwJ0sUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nev4X-00EyER-QO; Thu, 14 Apr 2022 08:43:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C3AB30080F;
        Thu, 14 Apr 2022 10:43:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55F1E2B3A873C; Thu, 14 Apr 2022 10:43:25 +0200 (CEST)
Date:   Thu, 14 Apr 2022 10:43:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 09/18] objtool: Add stack validation cmdline option
Message-ID: <YlferZa7SP6hVgcA@hirez.programming.kicks-ass.net>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <a13c502a91ae0bef8dfeb502d7dee88e73039355.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a13c502a91ae0bef8dfeb502d7dee88e73039355.1649891421.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:19:44PM -0700, Josh Poimboeuf wrote:
> +	if (opts.stackval || opts.orc || opts.uaccess) {
> +		ret = validate_functions(file);
> +		if (ret < 0)
> +			goto out;
> +		warnings += ret;
>  
> +		ret = validate_unwind_hints(file, NULL);
>  		if (ret < 0)
>  			goto out;
>  		warnings += ret;
> +
> +		if (!warnings) {
> +			ret = validate_reachable_instructions(file);
> +			if (ret < 0)
> +				goto out;
> +			warnings += ret;
> +		}
>  	}

Doesn't SLS also depend on validate_functions() ?
