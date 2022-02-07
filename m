Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532EC4AC7D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353271AbiBGRqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346651AbiBGRjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:39:15 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B28EC0401DF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-54-ed;
 t=1644255550; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=N9DuAothrqG9nC60VlENZY3tmDm8PUH3W5VZewotNvk=;
 b=HuciXOYUEVzuxkHzcPxkWdIaJU+mV9e9A9bKswY6UMA9agbasPfj1deeMZN1cxrjgWVbV
 ++1806jS1RsPKt5BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-54-rsa; t=1644255550; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=N9DuAothrqG9nC60VlENZY3tmDm8PUH3W5VZewotNvk=;
 b=Ld6HgFYAffThRNAh94Shpci4MPicTr6mHeIQAfUyUbjrkI0zRGACCA72Zf2fN/agDIrDk
 P5Yxx6pGMvV25JVPFIvQpW18XiYHjE4QNnqXblaRIWKFdKm3Yv2PSZrKdlVgbV8O7GBQ4GF
 L82GQwFuT/49kxH6BySuJnD9pLncR4nBSM2evayXIVq71rFiYKFlfaBjWH3Ne9yqfWNGM1i
 Jli87AjSGcRpnGVjiSPNbKgpM7i7rd2OLGsv2ahPBna59MVRGXs40qZbKBW7X3nP4afS7yg
 3+rEW0WZ7ij5i01kcz+Czku6wnU76ZyKPldhFqzfDxFSHLp5J5TKkD9T7bZA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id E9436160B2E; Mon,  7 Feb 2022 09:39:10 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:39:10 -0800
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 03/35] mmap locking API: name the return values
Message-ID: <20220207173910.GA12302@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-4-michel@lespinasse.org>
 <20220131161737.cclyx2ntil3opted@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131161737.cclyx2ntil3opted@revolver>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 04:17:43PM +0000, Liam Howlett wrote:
> * Michel Lespinasse <michel@lespinasse.org> [220128 08:10]:
> > In the mmap locking API, the *_killable() functions return an error
> > (or 0 on success), and the *_trylock() functions return a boolean
> > (true on success).
> > 
> > Rename the return values "int error" and "bool ok", respectively,
> > rather than using "ret" for both cases which I find less readable.
> 
> Would it be better to add function documentation in regards to return
> types?  I think changing the variables does help, but putting a block
> with Return: <what's above> would work best.

That would work, I guess. I'm not sure what it says about our general
coding style, that the comment would kinda stick out like a sore thumb
compared to the rest of the file, or of similar include files
(say, other lock definitions). I don't care very strongly either way.

--
Michel "walken" Lespinasse
