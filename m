Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232D24AC7D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353792AbiBGRqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbiBGRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:39:31 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D2C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:39:31 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-54-ed;
 t=1644255571; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=uMxP1uR1GMWjz5rQCuyF02GDhukH9s01AnuJsjrwSno=;
 b=YlBq92pzvV6ya+NxhmqpzQOrb15Dwe/fCJvDg1qVIuo/P+nsf2ovRUDnQLI1I/Rey+1lg
 kvVPsbEDOvV8ypFAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-54-rsa; t=1644255571; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=uMxP1uR1GMWjz5rQCuyF02GDhukH9s01AnuJsjrwSno=;
 b=dxYnoH/bYBJyklvC9tRz+aeodgNpOM0VcG+peohHQaS5dJtQCyBQpOAbQZZXjSC5on2YN
 A+i+MqkpSvABdWH2JY8xGcGLEOOVTcTkYdww8IYIrPvmTAHxH3j5nZDLOsiSdu2NdW0kHxp
 1EzEDHfmW1GnML4Q6VwZKEAALEdRifabCWm14KLcDyigEbD9RpHWscW7vNmnkE+yOlTj59a
 qzULzgraGjWEd/qIr089ANyTZkdCzhxVzR/eKUXDRLMxrq55/TCDHzZFfBwg0ZPd6l2BIEq
 VOgGdoa6W+uPcGFd1b56YE9tCCZpiUQ7qJiL910tQNX+bwumvprkT0Hzsj4w==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 4C0E5160B2E; Mon,  7 Feb 2022 09:39:31 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:39:31 -0800
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
Subject: Re: [PATCH v2 13/35] x86/mm: attempt speculative mm faults first
Message-ID: <20220207173931.GC12302@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-14-michel@lespinasse.org>
 <20220201171617.z5zgafitgolyv5np@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201171617.z5zgafitgolyv5np@revolver>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:16:43PM +0000, Liam Howlett wrote:
> > +	vma = __find_vma(mm, address);
> > +	if (!vma || vma->vm_start > address) {
> 
> This fits the vma_lookup() pattern - although you will have to work
> around the locking issue still.  This is the same for the other
> platforms too; they fit the pattern also.

In this case, I think it's just as well to follow the lines of the
non-speculative path, which itself can't use vma_lookup() because it
needs to handle the stack expansion case...

--
Michel "walken" Lespinasse
