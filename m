Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A0D5931CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiHOPb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiHOPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:31:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D212FDF85
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:31:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 88CC3375E5;
        Mon, 15 Aug 2022 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660577482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qQIOXmfE/L8EhIOJ9ReiZ9YnlR5Vz7KbQm21zp/yjg0=;
        b=clwT/hpMZi+m26eag1S3oGAGpDMumThrxYmxxSDuyqgQgoCTJJTI3Lm4vBxUlPXE8CQ79z
        aONVfEkSt0FinytEeCT1IdToULSYS+MwT7hv0Kyc02DijN4kiB9Dfjy+hHLPqS4Gu9LD84
        1I5XUaBlachjXXF40UzxodSXftB8P7M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66AFB13A93;
        Mon, 15 Aug 2022 15:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bnc+Fspm+mK/ewAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 15 Aug 2022 15:31:22 +0000
Date:   Mon, 15 Aug 2022 17:31:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, david@redhat.com,
        pasha.tatashin@soleen.com, sieberf@amazon.com, shakeelb@google.com,
        sjpark@amazon.de, dhowells@redhat.com, quic_pkondeti@quicinc.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V3] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <Yvpmyf44SN0p5ab/@dhcp22.suse.cz>
References: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
 <Yvpg6odyDsXrjw5i@dhcp22.suse.cz>
 <YvplthTjM8Ez5DIq@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvplthTjM8Ez5DIq@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15-08-22 16:26:46, Matthew Wilcox wrote:
> On Mon, Aug 15, 2022 at 05:06:18PM +0200, Michal Hocko wrote:
> > > + * This function gives proper page_ext of a memory section
> > > + * during race with the offline operation on a memory block
> > > + * this section falls into. Not using this function to get
> > > + * page_ext of a page, in code paths where extra refcount
> > > + * is not taken on that page eg: pfn walking, can lead to
> > > + * use-after-free access of page_ext.
> > 
> > I do not think this is really useful comment, it goes into way too much
> > detail about memory hotplug yet not enough to actually understand the
> > interaction because there are no references to the actual
> > synchronization scheme. I would go with something like:
> > 
> > /*
> >  * Get a page_ext associated with the given page. Returns NULL if
> >  * no such page_ext exists otherwise ensures that the page_ext will
> >  * stay alive until page_ext_put is called.
> >  * This implies a non-sleeping context.
> >  */
> 
> I'd go further and turn this into kernel-doc:
> 
> /**
>  * page_ext_get() - Get the extended information for a page.
>  * @page: The page we're interested in.
>  *
>  * Ensures that the page_ext will remain valid until page_ext_put()
>  * is called.
>  * 
>  * Return: NULL if no page_ext exists for this page.
>  * Context: Any context.  Caller may not sleep until they have called
>  * page_ext_put().
>  */

Yes, thanks!

-- 
Michal Hocko
SUSE Labs
