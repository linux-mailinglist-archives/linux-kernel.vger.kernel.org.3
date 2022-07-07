Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F956A2E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiGGMxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiGGMxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D71FB2F384
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657198401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qw238l4/II5ZS2Jgu7adObRZNkiqO5QpfrDEC+afXgc=;
        b=fFOB5FpGYrx3JdZB+NZteMFDyH5pqeqVbktL5Vq3ojCR8rVMpzV6flgz4SD28QFl1RTDsn
        BcmeeW4lmnODI4FOlda2JDjoxB18EoE0U/fpcGkSlCjZxoULx5NVJ3bU7wxBPJdG1ZrVoM
        jSqhVIV+g40LvhcQeiQ86oKv9f+kOf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-MpSypgCmMdKepNO5kg5jzw-1; Thu, 07 Jul 2022 08:53:18 -0400
X-MC-Unique: MpSypgCmMdKepNO5kg5jzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1490A80A0C5;
        Thu,  7 Jul 2022 12:53:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CE17404C321;
        Thu,  7 Jul 2022 12:53:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220707045112.10177-2-xiubli@redhat.com>
References: <20220707045112.10177-2-xiubli@redhat.com> <20220707045112.10177-1-xiubli@redhat.com>
To:     xiubli@redhat.com
Cc:     dhowells@redhat.com, idryomov@gmail.com, jlayton@kernel.org,
        marc.dionne@auristor.com, willy@infradead.org,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        william.kucharski@oracle.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, vshankar@redhat.com
Subject: Re: [PATCH v3 1/2] netfs: do not unlock and put the folio twice
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2435747.1657198395.1@warthog.procyon.org.uk>
Date:   Thu, 07 Jul 2022 13:53:15 +0100
Message-ID: <2435748.1657198395@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xiubli@redhat.com wrote:

> -error:
> +error_locked:
>  	folio_unlock(folio);
>  	folio_put(folio);
> +error_unlocked:

I would do:

	error:
		if (folio) {
			folio_unlock(folio);
			folio_put(folio);
		}

David

