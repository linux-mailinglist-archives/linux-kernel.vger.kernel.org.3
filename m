Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0546C142
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbhLGRF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:05:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235162AbhLGRF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638896545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VOo08Za0h0B1Awl2dIxSWFReANWHcgpHkuzyXdSQC/M=;
        b=H7FZHLpaSrJSrXlu3aW3cEYRJK7cxrhWicED7/CjCMQBuesuVnDtCRQU4tvVZFtx3IDdvd
        dbHXlbQ/2VE1d3weJHsdRFMQXcG+Rt5+k3cUXy4xnanRgTuQ3DzPQBTJq2fEuWpm+zFO58
        Zq8097966z4joJfFprGZ288tV62/oo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-rTYf_iefOqGKpwKITIZ5Tw-1; Tue, 07 Dec 2021 12:02:24 -0500
X-MC-Unique: rTYf_iefOqGKpwKITIZ5Tw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D2AD2F25;
        Tue,  7 Dec 2021 17:02:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54470177C0;
        Tue,  7 Dec 2021 17:02:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211204220350.633811-1-arnd@kernel.org>
References: <20211204220350.633811-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     dhowells@redhat.com, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] cachefiles: fix __cachefiles_prepare_write() error handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1878024.1638896540.1@warthog.procyon.org.uk>
Date:   Tue, 07 Dec 2021 17:02:20 +0000
Message-ID: <1878025.1638896540@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> wrote:

>  	pos = cachefiles_inject_remove_error();
> -	if (pos == 0)
> -		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -				    *_start, *_len);
> +	if (pos != 0)
> +		return 0;
> +
> +	ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +			    *_start, *_len);
>  	if (ret < 0) {

The right fix is to use "ret" rather than "pos".  I've fixed this already on
my fscache-rewrite branch.  Hopefully I'll be able to push that over to my
next branch shortly.

David

