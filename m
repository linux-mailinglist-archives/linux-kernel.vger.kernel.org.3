Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D75AD2BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiIEMjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbiIEMi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:38:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB360696
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:32:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 254AF38867;
        Mon,  5 Sep 2022 12:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662381121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OxQfDCqBUCjwjZQ5n2rijS/hjypOhZZuZ+okmIcJ/2A=;
        b=AlkQM6umPwfsH0PGp4EF4xqR5lVdpV4ECAW4x2XCI8bXLr1pCNgeO4zdD0zPtyuQBnOAlB
        ZvNU0aL5Bdwh02P8JjPLXxxZSATtsCJY1POuvDVD1lTMNvHN7mJaTpQi5ymcGoSoflVRy9
        rdmmUP87fAa/pI85DU1Jvdlyr42kwmM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F231E13A66;
        Mon,  5 Sep 2022 12:32:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fCGsOkDsFWMtBQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Sep 2022 12:32:00 +0000
Date:   Mon, 5 Sep 2022 14:32:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 00/28] per-VMA locks proposal
Message-ID: <YxXsQKoQ0URIRuKi@dhcp22.suse.cz>
References: <20220901173516.702122-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unless I am missing something, this is not based on the Maple tree
rewrite, right? Does the change in the data structure makes any
difference to the approach? I remember discussions at LSFMM where it has
been pointed out that some issues with the vma tree are considerably
simpler to handle with the maple tree.

On Thu 01-09-22 10:34:48, Suren Baghdasaryan wrote:
[...]
> One notable way the implementation deviates from the proposal is the way
> VMAs are marked as locked. Because during some of mm updates multiple
> VMAs need to be locked until the end of the update (e.g. vma_merge,
> split_vma, etc).

I think it would be really helpful to spell out those issues in a greater
detail. Not everybody is aware of those vma related subtleties.

Thanks for working on this Suren!
-- 
Michal Hocko
SUSE Labs
