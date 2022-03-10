Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377324D4335
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbiCJJMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbiCJJMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:12:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AD21390DC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:11:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E822A1F381;
        Thu, 10 Mar 2022 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646903503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BHyNXP7RfUQ4vsIzTehYlwtDxxPzwbsZKE+cm9QR4Ro=;
        b=IfQJizgP0bqx0wU3sWvyw6V65NGApoo0iN20D+LT8Z/bU8wRDCysEvI7r3AVNSQZ7FvCLJ
        qiQzudQv/3qNGiWjNm4hAgu/GtOaEPgoxssr/EKlOJWzCZLbnZX8XZ1L7drikZTibspGOk
        QJgr1U1JRclw7QmtInnNUvjKxaSSQqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646903503;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BHyNXP7RfUQ4vsIzTehYlwtDxxPzwbsZKE+cm9QR4Ro=;
        b=sxoOUCcGnYosa5/8skEKnpXoIaeEi1vGRztwPFnQmmhvAVk2iss3FHGdC/bAMjQT80IB33
        iUEZbnpoMGLVXbDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAC8313FA3;
        Thu, 10 Mar 2022 09:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gyWUMM/AKWKtSgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Mar 2022 09:11:43 +0000
Message-ID: <6dd8965e-3dd5-895b-641c-a04fa2b1115e@suse.cz>
Date:   Thu, 10 Mar 2022 10:11:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/1] mm/page_alloc: add scheduling point to
 free_unref_page_list
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        wangjianxing <wangjianxing@loongson.cn>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220302013825.2290315-1-wangjianxing@loongson.cn>
 <YieCFVMJOgT7es6E@casper.infradead.org>
 <20220309170517.05facf4a2d183cc9aac9196d@linux-foundation.org>
 <3713cb82-9596-9916-9830-c2827d6a6fe4@loongson.cn>
 <20220309192947.0b4c8c875c492de09c1ab632@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220309192947.0b4c8c875c492de09c1ab632@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 04:29, Andrew Morton wrote:
> On Thu, 10 Mar 2022 10:48:41 +0800 wangjianxing <wangjianxing@loongson.cn> wrote:
> 
>> spin_lock will preempt_disable(), interrupt context will 
>> __irq_enter/local_bh_disable and also add preempt count with offset.
>> 
>> cond_resched check whether if preempt_count == 0 in first and won't 
>> schedule in previous context.
>> 
>> Is this right?
>> 
>> 
>> With another way, could we add some condition to avoid call cond_resched 
>> in interrupt context or spin_lock()?
>> 
>> + if (preemptible())
>> +       cond_resched();
>> 
> 
> None of this works with CONFIG_PREEMPTION=n.

Yeah I think we have at least two options.

1) check all callers, maybe realize all have enabled interrupts anyway,
rewrite the locking to only assume those

2) find out how long the tlb batches actually are and make them smaller
