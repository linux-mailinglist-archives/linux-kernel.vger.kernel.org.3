Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7004A2D42
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 09:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiA2Ix7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 03:53:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231802AbiA2Ix4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 03:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643446436;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=cr+ebJaUo9nx6h/WUxTauaoEwHuILetaAEgQRvXMOro=;
        b=dRA62j4zXS43T6AoV1ygKJIp7AFF+cMudtWBB8RnBn4ed4aKhphwolp3JpoQc+UagOFzuV
        oBpwaQUlFnMSDyMNdRmNrGjeOd0jghBYoLVoB7GjPS637m9Sz5qwQIhOZQ/BQTYaVugtlo
        bJ/tZl8BO4BYrxE+0zqhEVGUzO83U14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-fp6E1wwFPOyIn1D5-JEt7Q-1; Sat, 29 Jan 2022 03:53:54 -0500
X-MC-Unique: fp6E1wwFPOyIn1D5-JEt7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A2A28144E1;
        Sat, 29 Jan 2022 08:53:53 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.192.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1EEA1086481;
        Sat, 29 Jan 2022 08:53:52 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 20T8rnxD3397221
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 29 Jan 2022 09:53:50 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 20T8rm013397220;
        Sat, 29 Jan 2022 09:53:48 +0100
Date:   Sat, 29 Jan 2022 09:53:48 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     linux-kernel@vger.kernel.org, jmforbes@linuxtx.org
Subject: Re: [PATCH] Fix for gcc12 compile issues in ubcmd-util.h
Message-ID: <20220129085348.GT2646553@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20220129010215.781601-1-jforbes@fedoraproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129010215.781601-1-jforbes@fedoraproject.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 07:02:14PM -0600, Justin M. Forbes wrote:
> While the current code builds fine with gcc 11, it does not with gcc 12,
> resulting in:
> 
> In file included from help.c:12:
> In function 'xrealloc',
>     inlined from 'add_cmdname' at help.c:24:2:
> subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
>    56 |                 ret = realloc(ptr, size);
>       |                       ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret = realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
>    58 |                         ret = realloc(ptr, 1);
>       |                               ^~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret = realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> 
> The was mentioned in upstream gcc bug
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104069 where it was
> determined that gcc was correct and the kernel needed to change.

This is due to the different behaviors of realloc when size is 0 as
described in http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2396.htm#dr_400
and as the code explicitly tries to cope with !size, there is at least
theoretical chance that it is called with size 0.
In glibc/AIX, for non-NULL ptr realloc(ptr, 0) will free(ptr) and return
NULL, so the code as written in that case will in
	void *ret = realloc(ptr, 0);
	if (!ret && !0)
		ret = realloc(ptr, 1);
effectively
	free(ptr);
	ret = realloc(ptr, 1);
and so try to reallocate freed memory.  On BSD libcs it will work properly
though.

	Jakub

