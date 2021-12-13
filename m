Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BF847236D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhLMJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhLMJEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:04:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A29C06173F;
        Mon, 13 Dec 2021 01:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E1tfJAJEo2ii3UUfFc4sMr4HPboIoKFc3I0QAP/7CAY=; b=aIrkrI+KqL28ZA6400YDIn5IRt
        l/K5scmwRddqvQ4sE0ypmZYXJJlYitkGODVJZb+y0TgOVv54m15f3u+j3oQp6CC7XNdvtxL6zewm5
        wVLwzhTVZ0guWNcDSliGheB19UtdIGNOf8Edd9tenuethftMe2lSvWjMDGO5BIVsYw60DVxcIJXg9
        8D9jlXCJajiE7uuBy01ct8hzHIr96VtnyABQb2KZDfCcEK6qALNDGh6d7/eoKvaptsKAfe4c1Pf0O
        DZ5/9P6Hm20Gs2DvIGP1uc4PJK+LjSecS4BbZPZ+UQm524ZMKszJ/5wNQbln7cKISDMGA1UQglJ/u
        ZRpyi5wQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwhFf-008UXb-Be; Mon, 13 Dec 2021 09:04:07 +0000
Date:   Mon, 13 Dec 2021 01:04:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/7] drm/i915: Replace kmap() with kmap_local_page()
Message-ID: <YbcMhzfm31aL5fzx@infradead.org>
References: <20211210232404.4098157-1-ira.weiny@intel.com>
 <20211210232404.4098157-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210232404.4098157-2-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:23:58PM -0800, ira.weiny@intel.com wrote:
> -		vaddr = kmap(page);
> +		vaddr = kmap_local_page(page);
>  		memcpy(vaddr, data, len);
> -		kunmap(page);
> +		kunmap_local(vaddr);

memcpy_to_page?
