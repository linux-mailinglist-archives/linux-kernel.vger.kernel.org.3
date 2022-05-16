Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A374B528243
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbiEPKiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiEPKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:38:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635FF237D3;
        Mon, 16 May 2022 03:38:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EF2E21F6A;
        Mon, 16 May 2022 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652697529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mk2xKWahTV4e228Q8zDevZzG4IKrGzg2PozG1y8nurY=;
        b=zSYEe+Se+AkB0F7e+Wtoo81oE96AKXPz5YbZE1Xmp79CG+nldY0OemHFVYsx/vLlExbhQx
        PydBAyZ4W4diuTjDuZZniALdfRRdv9kl8IuL498b4+/A+UlLpnWZegtAiU5gTDnE8hNybI
        Fh/fDdugYPDRE1lN6lmSbX1rIreyaZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652697529;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mk2xKWahTV4e228Q8zDevZzG4IKrGzg2PozG1y8nurY=;
        b=qaFD9ITYXdPoDEOuP5Z77ambsqWbSJUfcG0qR3OCTLvAq4l+bA/j+t3va0jiCV79u71PDS
        VgZAEs5O6bIGnEAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 579E213ADC;
        Mon, 16 May 2022 10:38:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z/PBErgpgmI2LwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 16 May 2022 10:38:48 +0000
Date:   Mon, 16 May 2022 12:38:46 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v12 4/7] mm: hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YoIptjs65NgT1/ed@localhost.localdomain>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
 <20220516102211.41557-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516102211.41557-5-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 06:22:08PM +0800, Muchun Song wrote:
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -913,6 +913,13 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  	ms = __nr_to_section(section_nr);
>  	set_section_nid(section_nr, nid);
>  	__section_mark_present(ms, section_nr);
> +	/*
> +	 * Mark whole section as non-optimizable once there is a subsection
> +	 * whose vmemmap pages are allocated from alternative allocator. The
> +	 * early section is always optimizable.
> +	 */
> +	if (!early_section(ms) && altmap)
> +		section_mark_cannot_optimize_vmemmap(ms);

Because no one expects those sections to be removed?
IIRC, early_section + altmap only happened in case of sub-section pmem
scenario? I guess my question is: can we really have early_sections coming
from alternative allocator?

I think this should be spelled out more.


-- 
Oscar Salvador
SUSE Labs
