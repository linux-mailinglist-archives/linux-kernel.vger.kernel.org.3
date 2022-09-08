Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210605B23DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiIHQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiIHQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:48:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6E61223AF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:48:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E67031F6E6;
        Thu,  8 Sep 2022 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662655718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XG9gVuJUiP9bC+wQtyj90e6KoBFEtJjZzo/YXMehS0o=;
        b=aXagEARdc8vzASotybyJrHkfgk5wh+bF5Eh3/dPYs5AvFCuLj5MlvSFYTgkaYGbub+rbqB
        O+PLz6jgEIGv12C7OkrHqnXtCMKrg+qhzum3p7d1BCVjf8QndPm2c7bT4x2IbpSjAkJaLw
        kp48EwYqZXso3+3xSF0jfG5ASgZ/0h0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C858213A6D;
        Thu,  8 Sep 2022 16:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YeCZLuYcGmMKEgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 08 Sep 2022 16:48:38 +0000
Date:   Thu, 8 Sep 2022 18:48:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: use pfn_to_online_page() in
 split_huge_pages_all()
Message-ID: <Yxoc5mrIjrh+I5w5@dhcp22.suse.cz>
References: <20220908041150.3430269-1-naoya.horiguchi@linux.dev>
 <20220908122303.7pofcdcmbuq4ou6u@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908122303.7pofcdcmbuq4ou6u@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-09-22 15:23:03, Kirill A. Shutemov wrote:
[...]
> But it makes me think if there's other similar cases. "page is offline" is
> rather obscure case that rarely covered by routine testing. Otherwise the
> bug would not survive for 6 years.
> 
> After quick look, kvm_pfn_to_refcounted_page() looks suspicious.

this one is hard to judge for me. Is this ever used for something that
could be offlined?

> kdb_getphys() too.

this one looks it needs a fix
 
> Maybe we should make pfn_valid() false for offline pages and introduce
> other check that allows offline pages which can be used in codepaths that
> deal with offline pages explicitly.

Back when pfn_to_online page was introduced altering pfn_valid was
considered but the semantic is not the same. offline pages could be
still pfn_valid. The discussion should be in archives. Sorry do not have
the link handy. We have also considered changing pfn_to_page but that
would add an overhead for unlikely case to everybody. So the conclusion
was that only pfn walkers should care. Most other users just translate
pfn to page when the page cannot be offlined (e.g. because it is
referenced).

I do realize this is fragile but we couldn't come up with something more
clever without introducing overhead all over the place.
-- 
Michal Hocko
SUSE Labs
