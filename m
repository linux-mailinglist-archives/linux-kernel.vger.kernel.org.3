Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E09E586B93
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiHANI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiHANIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:08:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6556B1C3
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:08:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 181DA207D7;
        Mon,  1 Aug 2022 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659359302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Beg13MRW0kvMPBqsKXzcnAP8k+2gavzK1o56D6LA6j8=;
        b=YVyFRO/kg+BZCfK5rvegllNMv4ruh/nICAcojra3Bv63KZeN8hMk6UpHHQr6eCmx3wqjH4
        IIE1tYYwlM5w4cHYu4rveapfm5/5pUCMFv6OGi0HJ+h7KHlkxS8J17cdZFwTkig6K64r9j
        mYILGeTJuwWaQm8TUh6ewYntbe0wsrs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 556E113A72;
        Mon,  1 Aug 2022 13:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zEvwB0XQ52I/MwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 01 Aug 2022 13:08:21 +0000
Date:   Mon, 1 Aug 2022 15:08:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        quic_pkondeti@quicinc.com, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YufQQQyUmn4y+CYX@dhcp22.suse.cz>
References: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
 <YuKfQoOHG1celfBK@dhcp22.suse.cz>
 <6b646ff2-b6f6-052e-f3f4-3bf05243f049@quicinc.com>
 <YueObAiml8c74DLV@dhcp22.suse.cz>
 <54e4ce7d-7cbd-480c-28ba-cba684341b37@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e4ce7d-7cbd-480c-28ba-cba684341b37@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-08-22 18:31:45, Charan Teja Kalla wrote:
[...]
> >> The roll back operation in the online_page_ext(), where we free the
> >> allocated page_ext's, will not have the PAGE_EXT_INVALID flag thus
> >> WARN() may not work here. no?
> > Wouldn't ms->page_ext be NULL in that case?
> I don't think that ms->page_ext would be NULL here.
> online_page_ext():
>   (a) for (pfn = start; !fail && pfn < end; pfn += PAGES_PER_SECTION)
>      fail = init_section_page_ext():
> 	   ms->page_ext = (void *)base - page_ext_size * pfn;
> 
>   //If fail = -ERROR in the middle, roll back operation.
>   (b) for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
>        __free_page_ext();
> 
>    Here (b) can be called on the sections without PAGE_EXT_INVALID with
> ms->page_ext != NULL.
> 
You are right. My sloppy code reading. A tiny comment would be nice.
Because this shouldn't really happen for normal calls.

-- 
Michal Hocko
SUSE Labs
