Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42C34E8D62
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 06:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiC1Erz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 00:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbiC1Erv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 00:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4CE732069
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 21:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648442769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Qwd4fEDrN/ygaJDceNIaQ4+d0af14IcvLg/VsDrFZk=;
        b=ZhUw5ycFzRnaiAuEuQwZbYPN0M1jScDGw5XVM8NVzJ5xVqhpOYn1n/rr7wsdtJQjexQaWi
        J4hMUuaEqttWLB8kDRhj3oCkjfp86gT/h/j8qe/jUjS2PFrYAobnvXt1muwju9SX5SKnig
        mhNTv5Ew3ziR8qOGRu01QmpI2FecDb0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-DOePw2xVMJic5HtNWfH1xw-1; Mon, 28 Mar 2022 00:46:06 -0400
X-MC-Unique: DOePw2xVMJic5HtNWfH1xw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6C881C05AFB;
        Mon, 28 Mar 2022 04:46:05 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AF67C3598C;
        Mon, 28 Mar 2022 04:46:01 +0000 (UTC)
Date:   Mon, 28 Mar 2022 12:45:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: LTP zram tests triggers might_sleep splat - bisects to
 0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt")
Message-ID: <YkE9g9rhTID9ePxh@T590>
References: <00f2171be8b25fdeb5c64c1f880dea32763a2722.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f2171be8b25fdeb5c64c1f880dea32763a2722.camel@gmx.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 06:21:51AM +0200, Mike Galbraith wrote:
> Splat bisected cleanly, verified with a revert afterward.
> 
> (note: "Preemption disabled at:" address tracking looked to be pretty
> broken during bisection, so...)

It can be fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.18/block&id=d578c770c85233af592e54537f93f3831bde7e9a


Thanks,
Ming

