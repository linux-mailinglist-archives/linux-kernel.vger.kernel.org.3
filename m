Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A4256A2AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiGGMxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbiGGMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8DC23136E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657198353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dUmFi8DZaDYcJf12L/Xx0NmEj/l0aTrBYJ3yxA0AGTs=;
        b=TYm9w2Wqa5vNOhdSik7C8xsbtahmiledO/OHKsSiqKuY9XT/iAAzwwY5H0RMy2VCdD0PK4
        3CmXdonO4Bbrl4jN/ypEwZtANHNR7Uta8z6eBdix0NWZffPFbXKOURnQR3VsoJT6PJssEm
        Dn69XgOHv2vP/RlVQQyQ2/LQkLG4+Go=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-o2jcox1COZ-558705x74gw-1; Thu, 07 Jul 2022 08:52:30 -0400
X-MC-Unique: o2jcox1COZ-558705x74gw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E59A5395AFE3;
        Thu,  7 Jul 2022 12:52:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C8E62026D64;
        Thu,  7 Jul 2022 12:52:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <f60dacead3da4ab78edd225749d698f8e621f577.camel@kernel.org>
References: <f60dacead3da4ab78edd225749d698f8e621f577.camel@kernel.org> <20220707045112.10177-1-xiubli@redhat.com> <20220707045112.10177-3-xiubli@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, xiubli@redhat.com, idryomov@gmail.com,
        marc.dionne@auristor.com, willy@infradead.org,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        william.kucharski@oracle.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, vshankar@redhat.com
Subject: Re: [PATCH v3 2/2] afs: unlock the folio when vnode is marked deleted
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2433376.1657198347.1@warthog.procyon.org.uk>
Date:   Thu, 07 Jul 2022 13:52:27 +0100
Message-ID: <2433377.1657198347@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> > +		folio_unlock(*folio);
> > +		folio_put(*folio);
> 
> Don't you also need this?
> 
> 	*folio = NULL;

It shouldn't need any of those three lines.

David

