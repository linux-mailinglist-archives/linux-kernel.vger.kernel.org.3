Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F293655CB20
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiF0Mzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbiF0Mzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:55:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE0DBC1D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:55:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9AECE21DA6;
        Mon, 27 Jun 2022 12:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656334535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24tiTIsuqbEPo6pQsuXY/t4rRA8ruHn3WPiNQyQBOYw=;
        b=dYiO+Yif6lu++q3hHtJRcX4ezVTLXFl+M3bSmJEMkVXAkjEPIhwnX1/V+6xAwGtYcTsp12
        e7B+djDsh/nguiOvb8AoF18UYcksNtCiAKyhXzqppRdLL5/pAggDP6kYm69cn+bE/CH58R
        UUyAZPEg98+ijIGPozOABtXEgIfX/To=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656334535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24tiTIsuqbEPo6pQsuXY/t4rRA8ruHn3WPiNQyQBOYw=;
        b=jIOne0XGX3hBiSQ7dR9EuM4bNtWcBOtQhM6eIBkp8nCG94WMtIPeOaeEdQbUUEHjM001pJ
        R/pjdXtI+MMQJ2Cg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 51E9B2C141;
        Mon, 27 Jun 2022 12:55:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A800DA062F; Mon, 27 Jun 2022 14:55:33 +0200 (CEST)
Date:   Mon, 27 Jun 2022 14:55:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy6545@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, Matthew Wilcox <matthew@wil.cx>,
        Mel Gorman <mgorman@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: Oddities in do_read_cache_page()
Message-ID: <20220627125533.v3o547uuvfo7r3pz@quack3.lan>
References: <f69f7f28-cf24-ebca-41f2-f6cf76435839@suse.de>
 <CAFhKne_hYFU0g5_68R=FA_QRWQc8ZRM8eCTNFwhP+4p4YHhZ8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhKne_hYFU0g5_68R=FA_QRWQc8ZRM8eCTNFwhP+4p4YHhZ8Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew!

On Mon 27-06-22 07:17:35, Matthew Wilcox wrote:
> &folio->page does not dereference the pointer, it simply performs
> arithmetic on it. In this case, adding zero. It also changes the type from
> folio to page. There's no bug here.

I agree there's no functional bug there (at least yet). But arguably this
would be much more readable and definitely more future-proof as:

	return (struct page *)ERR_CAST(folio);

Because even doing arithmetics on error pointer is fishy...

								Honza

> 
> On Mon., Jun. 27, 2022, 04:12 Hannes Reinecke, <hare@suse.de> wrote:
> 
> > Hey Matt,
> >
> > I've stumbled across this code in do_read_cache_page():
> >
> >          struct folio *folio;
> >
> >          folio = do_read_cache_folio(mapping, index, filler, file, gfp);
> >          if (IS_ERR(folio))
> >                  return &folio->page;
> >          return folio_file_page(folio, index);
> >
> > Following 'do_read_cache_folio()' I see that it does things like
> >
> >                  folio = filemap_alloc_folio(gfp, 0);
> >                  if (!folio)
> >                          return ERR_PTR(-ENOMEM);
> >
> > Now I freely admit that my knowledge of folios is hazy at best, but
> > dereferencing an error pointer is something I would seriously frown upon
> >   if I were to review the code.
> > Care to explain?
> > Or is it, indeed, simply a bug?
> >
> > Cheers,
> >
> > Hannes
> > --
> > Dr. Hannes Reinecke                        Kernel Storage Architect
> > hare@suse.de                                      +49 911 74053 688
> > SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
> > HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
