Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7C659E865
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbiHWQ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343820AbiHWQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27991084
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661264270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cNul7dRswnU49jAHhKW2/LuUqpnr2B4b53UC3aSpkn8=;
        b=X03sM9sIjitHfFUFyOHTTtiXGxUg2oeXO+3ARqv6n8VHFUymopovHph8juHPH6gkI8dpus
        BFSSCEiahbiJXTGw0X8ycVnFS4OCSY+vZ674ZvbTHX1h9t+K/UJUkqdNR1LYr/4GiVnWhi
        +PyfSloDYXxHYM86wPdnnMFGAspy4ac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-AyojJJ-mM6OE64Wv4v40zg-1; Tue, 23 Aug 2022 10:17:48 -0400
X-MC-Unique: AyojJJ-mM6OE64Wv4v40zg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73327893155;
        Tue, 23 Aug 2022 14:17:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5185EC15BB3;
        Tue, 23 Aug 2022 14:17:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YwTfPRDq04/DGTVT@casper.infradead.org>
References: <YwTfPRDq04/DGTVT@casper.infradead.org> <166126004083.548536.11195647088995116235.stgit@warthog.procyon.org.uk> <166126006184.548536.12909933168251738646.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, sfrench@samba.org, linux-cifs@vger.kernel.org,
        lsahlber@redhat.com, jlayton@kernel.org, dchinner@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: Re: [PATCH 3/5] smb3: fix temporary data corruption in collapse range
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <719242.1661264245.1@warthog.procyon.org.uk>
Date:   Tue, 23 Aug 2022 15:17:25 +0100
Message-ID: <719244.1661264245@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> >  	filemap_write_and_wait(inode->i_mapping);
> > +	truncate_pagecache_range(inode, off, old_eof);
> 
> It's a bit odd to writeback the entire file but then truncate only part
> of it.  XFS does the same part:

Actually, filemap_write_and_wait() should check for error, yes.

Is there something that combines these that we should use?
invalidate_inode_pages2_range() for example.

David

