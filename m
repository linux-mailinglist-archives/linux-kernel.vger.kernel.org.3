Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C75F491F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 07:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbiARG5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 01:57:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243988AbiARG47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 01:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642489017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I5up6dZy0ZUANufFKUFgvfkxOTraxEVper7GxcI8Tho=;
        b=Bxj1wZSKhFzCRLL0uxIpRGLKoJ9q5JE9lAXDE+tw39x2wYHAqlRNaXiNayUNepevcV6Wmu
        pUtk/u0AUYqXYtPpsOqZV1X2oYJyscRNIs9C4zluXQqc4QbKRTN9KwljKBfzBk4fz/faBK
        oEAbXbbgDU5C+Urg5wWyZOaZNuOmqDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-OcFCS_5ROZqcaHB5-A-z2g-1; Tue, 18 Jan 2022 01:56:54 -0500
X-MC-Unique: OcFCS_5ROZqcaHB5-A-z2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00B6B192AB76;
        Tue, 18 Jan 2022 06:56:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4C5D10550B1;
        Tue, 18 Jan 2022 06:56:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id F19FC18000A6; Tue, 18 Jan 2022 07:56:50 +0100 (CET)
Date:   Tue, 18 Jan 2022 07:56:50 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        syzbot+2c56b725ec547fa9cb29@syzkaller.appspotmail.com
Subject: Re: [PATCH] udmabuf: validate ubuf->pagecount
Message-ID: <20220118065650.fi74ebzqmmz4e5io@sirius.home.kraxel.org>
References: <20211230142649.23022-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230142649.23022-1-paskripkin@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 05:26:49PM +0300, Pavel Skripkin wrote:
> Syzbot has reported GPF in sg_alloc_append_table_from_pages(). The
> problem was in ubuf->pages == ZERO_PTR.
> 
> ubuf->pagecount is calculated from arguments passed from user-space. If
> user creates udmabuf with list.size == 0 then ubuf->pagecount will be
> also equal to zero; it causes kmalloc_array() to return ZERO_PTR.
> 
> Fix it by validating ubuf->pagecount before passing it to
> kmalloc_array().
> 
> Fixes: fbb0de795078 ("Add udmabuf misc device")
> Reported-and-tested-by: syzbot+2c56b725ec547fa9cb29@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---

Pushed to drm-misc-next.

thanks,
  Gerd

