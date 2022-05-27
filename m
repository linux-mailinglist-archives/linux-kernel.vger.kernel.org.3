Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06A3535A95
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347661AbiE0Hjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiE0Hjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:39:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA050F7499
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:39:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A69021A80;
        Fri, 27 May 2022 07:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653637181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdLnFJ4Ca5m70NTfEe0fB3jkyyeyrGYENaDbY2LnlAQ=;
        b=F5332/+CQarJTGYGB9b5Rjf6swUovv7TqCGsImQmrM4HqyetLFpij/t+LkR+TwpM8AGG8a
        1FCo4+U08R33qZHPR140w3VrZRji7h3fbOrzjXyAJCl6sZMeAbbZU3pMQqnHSpJj25Hj9/
        ySh05iKIVOrjHYMCOy0W6GdgG2Jt31I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653637181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdLnFJ4Ca5m70NTfEe0fB3jkyyeyrGYENaDbY2LnlAQ=;
        b=yULVFRxKbGI0ARdRFA5fv3z9TvOGXU7HaG6mbZTRHXFRyb5pYRdRTx52CbO/Pd0jlDmujP
        gVlKfs1852/cExDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E81013A84;
        Fri, 27 May 2022 07:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HNB2Ej2AkGL5JwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 27 May 2022 07:39:41 +0000
Message-ID: <f25c03d7-d9e2-2ae3-4dcc-0d054a15ad2c@suse.cz>
Date:   Fri, 27 May 2022 09:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] mm: hugetlb_vmemmap: cleanup
 CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-4-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220404074652.68024-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 09:46, Muchun Song wrote:
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -188,7 +188,7 @@
>  #define RESERVE_VMEMMAP_NR		1U
>  #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
>  
> -DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> +DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
>  			hugetlb_optimize_vmemmap_key);
>  EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);

Hi,

looks like just below here you forgot to update:

static enum vmemmap_optimize_mode vmemmap_optimize_mode =
        IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);

so it refers to CONFIG name that no longer exists?

Vlastimil

