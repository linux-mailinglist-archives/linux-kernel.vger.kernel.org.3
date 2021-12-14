Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB2474823
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhLNQdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234085AbhLNQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639499598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJXj009MgLWpojuj3FFYB/sn+cNcEnhl527VqMbiz94=;
        b=T8kJXLm/40yohAelt3LX86Cyi7Eml0oId46HahGbWkziq664e1h5KUiehv7hDQKkyTau1r
        /BpvSdcCZhr30nWs0RK7zRXGwTnFiOllj0ivCRqSACMQ6Vlj9GNOXI90IEE+tuydsxGdCj
        nGlNft9IWRKlZGBmqdL7YFDeZ9VFiaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-mBVaY2MpOTOkwpKSGLlKMA-1; Tue, 14 Dec 2021 11:33:17 -0500
X-MC-Unique: mBVaY2MpOTOkwpKSGLlKMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93CE11006AA3;
        Tue, 14 Dec 2021 16:33:16 +0000 (UTC)
Received: from rhtmp (unknown [10.39.192.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F21B62AA9F;
        Tue, 14 Dec 2021 16:32:44 +0000 (UTC)
Date:   Tue, 14 Dec 2021 17:32:42 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     lizhe <sensor1010@163.com>
Cc:     dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/crash_core.c: No judgment required
Message-ID: <20211214173242.192f47e8@rhtmp>
In-Reply-To: <20211210032003.16278-1-sensor1010@163.com>
References: <20211210032003.16278-1-sensor1010@163.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lizhe,

On Thu,  9 Dec 2021 19:20:03 -0800
lizhe <sensor1010@163.com> wrote:

> No judgment required ck_cmdline is NULL
> its caller has alreadly judged, see __parse_crashkernel
> function
> 
> Signed-off-by: lizhe <sensor1010@163.com>
> ---
>  kernel/crash_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index eb53f5ec62c9..9981cf9b9fe4 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -221,9 +221,6 @@ static __init char *get_last_crashkernel(char *cmdline,
>  		p = strstr(p+1, name);
>  	}
>  
> -	if (!ck_cmdline)
> -		return NULL;
> -
>  	return ck_cmdline;
>  }
>  

I agree that the if-block is not needed and can be removed. However, I
cannot follow your reasoning in the commit message. Could you please
explain it in more detail.

The reason why I think that the 'if' can be removed is that the
expression can only be true when ck_cmdline = NULL. But with that the
last three lines are equivalent to

	if (!ck_cmdline)
		return ck_cmdline;

	return ck_cmdline;

Which simply doesn't make any sense.

Thanks
Philipp

