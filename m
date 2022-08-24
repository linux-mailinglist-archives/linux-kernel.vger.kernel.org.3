Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5115459FAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbiHXM7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbiHXM7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:59:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCFC97B05;
        Wed, 24 Aug 2022 05:59:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2409207D7;
        Wed, 24 Aug 2022 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661345972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Sc8yPIrn2lPmz4U/qGCYgSl43TnthOC7R6vNmH5QSs=;
        b=1RZtKWvRxQ6nAOERd7yoidX0z3KFExoGW9rmskgRWxSXd/4HmZAe1s0ijBEjFa2F7j9pUU
        /qN212si0kmDkfT5VeuUFl6wvBxF9MBUmZjekT2dZ+u9FnLnrFHV8Olw+eDIVGM4VwOZzw
        wDnkXBdo03SqRkaIV/WCvKTDM4uX3Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661345972;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Sc8yPIrn2lPmz4U/qGCYgSl43TnthOC7R6vNmH5QSs=;
        b=fMn0z1UvcAsxKzSctW1SUJflag/1GTvE7d5KKAQXy4ksC1Nwn04tLE4/ItzVvpLJw8SITK
        lx5jHns4N1LXkhDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A12D213780;
        Wed, 24 Aug 2022 12:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6YhOJrQgBmM/XwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 24 Aug 2022 12:59:32 +0000
Message-ID: <cc07df7a-d13f-faa2-d0b8-48e15951de66@suse.cz>
Date:   Wed, 24 Aug 2022 14:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: linux-next: build warnings after merge of the slab tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220824134530.1b10e768@canb.auug.org.au>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220824134530.1b10e768@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 05:45, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the slab tree, today's linux-next build (htmldocs) produced
> these warnings:
> 
> mm/slab_common.c:964: warning: Function parameter or member 'object' not described in 'kfree'
> mm/slab_common.c:964: warning: Excess function parameter 'objp' description in 'kfree'
> 
> Introduced by commit
> 
>    79c7527b9805 ("mm/sl[au]b: generalize kmalloc subsystem")
> 

Thanks, should be fixed in the new for-next I just pushed.
