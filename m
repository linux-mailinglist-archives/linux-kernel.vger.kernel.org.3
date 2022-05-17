Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7240F529B06
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbiEQHhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241814AbiEQHft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:35:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540CE48889;
        Tue, 17 May 2022 00:34:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F0A4220E4;
        Tue, 17 May 2022 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652772895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J1KjVE0wHNwP3/mTNkJ0TblpbUqdNrFgJOI9ondDKTg=;
        b=YUevUczAacH+9aLfJ9cL8rkSgdKZsoDdA5JzHX7uxPFz1UEnANG0qTEqGhdX1VQsWUZZYL
        4FAWNpczOkRRX4jjyjpw4iF84Vzb0LAd2ilYeOiIJiIZ0cj5gN5Uroc20IXNrx1JEa6Fw5
        DCobOFu3k/3n9hQi+4aoQBbGDFDL2+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652772895;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J1KjVE0wHNwP3/mTNkJ0TblpbUqdNrFgJOI9ondDKTg=;
        b=f8ddPe5eIGU5Z3eU1wOrwxLWrE+9w35kzWYcySynKAyDzb0Ri6XNByG7zSiinsOLCBzw4/
        SznTLHqPjf7/TvCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 383B613305;
        Tue, 17 May 2022 07:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A6IECx5Qg2IGeQAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 17 May 2022 07:34:54 +0000
Date:   Tue, 17 May 2022 09:34:52 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v12 1/7] mm: hugetlb_vmemmap: disable
 hugetlb_optimize_vmemmap when struct page crosses page boundaries
Message-ID: <YoNQHOKEzqFKQV6+@localhost.localdomain>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
 <20220516102211.41557-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516102211.41557-2-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 06:22:05PM +0800, Muchun Song wrote:
> If the size of "struct page" is not the power of two but with the feature
> of minimizing overhead of struct page associated with each HugeTLB is
> enabled, then the vmemmap pages of HugeTLB will be corrupted after
> remapping (panic is about to happen in theory).  But this only exists when
> !CONFIG_MEMCG && !CONFIG_SLUB on x86_64.  However, it is not a conventional
> configuration nowadays.  So it is not a real word issue, just the result
> of a code review.
> 
> But we cannot prevent anyone from configuring that combined configure.
> This hugetlb_optimize_vmemmap should be disable in this case to fix this
> issue.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs
