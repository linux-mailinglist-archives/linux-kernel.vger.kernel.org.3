Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A6C57A3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiGSQL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiGSQL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:11:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8CE4C612
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:11:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n185so9247981wmn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CsovjpFx2Rs2Y0JFrLb+Hq4dc68dG3XV8rFC1Zq84T8=;
        b=doQnWADhaKk6qPTy26R7f5MIzve9vJhXF3Pak5oSaaSNwW90wBu9A6OKr8C/8egNZ1
         dwW9WdCSEOZn71NWqZhPkHIju9obYIpXF3xni+tV7zIE83l4kNSnjtbOeUL5UvT6wyUw
         x73INVpNYZaOvIl02K1HXEwiiG2N0jYrUwcLTmZAXm9L8HqX9gkzmE3e2yt94FkT93+6
         Gx46+FmUwX2x4KZ+MH4Syl4pR+ty+TdHJeIZD8FdUNG3YywrSn5lcVfAnBlVrHn5dVai
         yGt/YUFVpG75EFp9KsJ/x9LJqQoAe4DdJynOASaNBxXXWe04ioeu3Jo5Fz3PGZwQnL2G
         /dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CsovjpFx2Rs2Y0JFrLb+Hq4dc68dG3XV8rFC1Zq84T8=;
        b=JCMGJ1TPQ4X5bw0ATM6mpElA3xWPkGOjTEVLlsHzHdbmluXQ8J1OkxzM/r/Ap5uOqq
         p+dCYbxNQkbh1E/CeB826TJG+pSll8Kozlx6TWa3jbGddt/wFM33XNr9PMhp3O1IKme8
         fy8UCTTyHEVitFVZDuJKKhMV0upOvKk5TmWlznU9/hcV0g6DO7v5FWuWvJBONZzcBwmk
         zGbHgDsKlUBbmxeA+rMjpv1TOHIahqFYBv735s2HkqWJcSpiIr6cHEkvtp1K+O5SVUbJ
         NlAboDdG1AeyxWcSdFWI87oikj6C8losvj9PN7tw0dgz/Auxk3HbBTQ++/0JdEQk2kgI
         DyYw==
X-Gm-Message-State: AJIora9DwOZqfF8r5U3a72A+Gd/kQuNwCiE2gX8uPIPHtbe+4vOV8ZEl
        ppRgcoB/w7nU2+YbpmkDV8e3nA==
X-Google-Smtp-Source: AGRyM1uFHQxYkO0zcfj9f+yh04ixVCkKMoHQ3d7PdKjKY8D9SveozmSB79iehDsK5GeDWJEHS78Rsg==
X-Received: by 2002:a05:600c:511f:b0:3a3:254c:b079 with SMTP id o31-20020a05600c511f00b003a3254cb079mr87507wms.68.1658247114885;
        Tue, 19 Jul 2022 09:11:54 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id n125-20020a1ca483000000b003a02de5de80sm2056042wme.4.2022.07.19.09.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 09:11:54 -0700 (PDT)
Date:   Tue, 19 Jul 2022 16:11:50 +0000
From:   Keir Fraser <keirf@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <YtbXxl8STUtQkacb@google.com>
References: <20220719100256.419780-1-keirf@google.com>
 <YtbMcBw4l0LAFn9+@infradead.org>
 <YtbRwO40CmIRWOUR@google.com>
 <YtbTGjRw65QEKkQA@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtbTGjRw65QEKkQA@infradead.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 08:51:54AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 19, 2022 at 03:46:08PM +0000, Keir Fraser wrote:
> > However, if the general idea at least is acceptable, would the
> > implementation be acceptable if I add an explicit API for this to the
> > DMA subsystem, and hide the detail there?
> 
> I don't think so.  The right thing to key off is
> VIRTIO_F_ACCESS_PLATFORM, which really should be set in any modern
> virtio device after all the problems we had with the lack of it.

Ok. Certainly the flag description in virtio spec fits the bill.

> > Or a completely different approach would be to revert the patch
> > e41b1355508d which clears VIRTIO_F_ACCESS_PLATFORM in the balloon
> > driver. MST: That's back in your court, as it's your patch!
> 
> Which also means this needs to be addresses, but I don't think a
> simple revert is enough.

Well here are two possible approaches:

1. Revert e41b1355508d outright. I'm not even sure what it would mean
for reported pages to go through IOMMU. And VIRTIO_F_ACCESS_PLATFORM
is no longer IOMMU-specific anyway.

2. Continue to clear the flag during virtio_balloon negotiation, but
remember that it was offered, and test for that in vring_use_dma_api()
as well as, or instead of, virtio_has_dma_quirk().

Do either of those appeal?
