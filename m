Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06644FB579
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbiDKIB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343516AbiDKIBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:01:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98990E0F0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649663978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AodznpEAcBj+PXndSY80fSw2jJRVYRPcVB2yJinGzrY=;
        b=azPJz1ElT5d9n7JAC5HMepVUbfNTB76qc/3XjDRuWaVFPhYRph6r2OmjVAO6HkzwZpQHnS
        l0Wp5ZIJpxl+wCUucTSsp7ex0YtVdrun3Uk7Ry+MKEJFrZfFlMKZpWIzXwUZpaowBOyuDn
        g//LTwVO64OsAgVNyxQMVlKvx9koppI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-50PXCoiLN1GrNixppGO-Tg-1; Mon, 11 Apr 2022 03:59:35 -0400
X-MC-Unique: 50PXCoiLN1GrNixppGO-Tg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E75C85A5BC;
        Mon, 11 Apr 2022 07:59:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1A4140EC001;
        Mon, 11 Apr 2022 07:59:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YkTP/Talsy3KQBbf@codewreck.org>
References: <YkTP/Talsy3KQBbf@codewreck.org> <CAAZOf26g-L2nSV-Siw6mwWQv1nv6on8c0fWqB4bKmX73QAFzow@mail.gmail.com> <2582025.XdajAv7fHn@silver> <Yj8WkjT+MsdFIfwr@codewreck.org> <3791738.ukkqOL8KQD@silver>
To:     asmadeus@codewreck.org
Cc:     dhowells@redhat.com,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Kahurani <k.kahurani@gmail.com>, davem@davemloft.net,
        ericvh@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        lucho@ionkov.net, netdev@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, Greg Kurz <groug@kaod.org>
Subject: Re: 9p fs-cache tests/benchmark (was: 9p fscache Duplicate cookie detected)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1077049.1649663972.1@warthog.procyon.org.uk>
Date:   Mon, 11 Apr 2022 08:59:32 +0100
Message-ID: <1077050.1649663972@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asmadeus@codewreck.org wrote:

> I see fscache also uses the qid version as 'auxilliary data', but I'm
> not sure what this is used for -- if it's a data version like thing then
> it will also at least invalidate the cache content all the time.

I should really have renamed "auxiliary data" to "coherency data".  It's used
by direct comparison when fscache binds a cookie to a backing cache object to
work out if the content of the backing object is still valid.

David

