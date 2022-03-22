Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE294E428B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbiCVPMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbiCVPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:12:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498A5245BD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:10:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8CEB1F387;
        Tue, 22 Mar 2022 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647961846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrK610/hsvwwJB9dGPvgOWZ0Ncfc9HGrOcQXY/62VNE=;
        b=FoeJffCYkfOs9GZORCCTR9/VbjoFH/MNUWVN25oRg60P0I1m5GQtIAgE0NDUE9iIzdt3wa
        uoDCeXQADznpo97tUssC2CChCfEsVjMhkboVzCqHZQUYUDX98OlKAjNzlW27aJEFXl12FZ
        Rs1jhE6IwsWMWgLVkv0yJi2MPKJNZSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647961846;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrK610/hsvwwJB9dGPvgOWZ0Ncfc9HGrOcQXY/62VNE=;
        b=pRUTZLwzDQYqzBfbzU86ul0y/0k7SUypabmg/leJVPr+Ewu8r95b4+BE4UTvoNxwfgGPr0
        ZYiYoOIZVZp+OQAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3982133B6;
        Tue, 22 Mar 2022 15:10:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yPonL/bmOWIwQwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 22 Mar 2022 15:10:46 +0000
Message-ID: <11814119-0e5c-3e4f-29c4-d2e9b8dfb622@suse.cz>
Date:   Tue, 22 Mar 2022 16:10:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] mm/page_owner.c: introduce vmalloc allocator for
 page_owner
Content-Language: en-US
To:     Yinan Zhang <zhangyinan2019@email.szu.edu.cn>,
        Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yejiajian2018@email.szu.edu.cn, hanshenghong2019@email.szu.edu.cn,
        caoyixuan2019@email.szu.edu.cn, zhaochongxi2019@email.szu.edu.cn,
        yuhongf@szu.edu.cn
References: <20220322032225.1402992-1-zhangyinan2019@email.szu.edu.cn>
 <YjlCTOrCUHnVxIqj@casper.infradead.org>
 <299aef9a-dd57-2197-f3cf-6b08c441f755@email.szu.edu.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <299aef9a-dd57-2197-f3cf-6b08c441f755@email.szu.edu.cn>
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

On 3/22/22 15:48, Yinan Zhang wrote:
> on 2022/3/22 11:28, Matthew Wilcox wrote:
> 
>> On Tue, Mar 22, 2022 at 11:22:24AM +0800, Yinan Zhang wrote:
>>> An application's memory consumption is high and keeps increasing,
>>> then it is suspected of having memory leak. There are several
>>> commonly used memory allocators: slab, cma, vmalloc, etc. The memory
>>> leak identification can be speed up if page information allocated
>>> by an individual allocator are analyzed individually. This patch
>>> introduce vmalloc allocator for page_owner.
>> Why is /proc/vmallocinfo not enough?
> 
> There is only one owner information in /proc/vmallocinfo: caller.
> While there are plenty of owner information in page owner,
> besides caller, it includes task id (pid), process id (tgid),
> and other useful information, which enables us for more comprehensive
> page allocation/release relevant statistics and analysis.
> 
> Adding allocator infomation can augment page owner for tracking about
> who allocates each page. And this patch adds vmalloc allocator infomation.

Hm but page_owner has the whole stack trace of allocation so it should be
easy to determine vmalloc from slab etc? How exactly would this extra field
help?


