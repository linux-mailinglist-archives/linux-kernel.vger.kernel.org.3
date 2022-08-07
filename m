Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B7858BB02
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiHGN1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiHGN1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C273DA1AA
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659878830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWN2+XtBy7D+eIoeR0CwA7v9KmusYi195gp46RwIqnc=;
        b=gQgXaS/7yJ2D1IWEwJNyNpQH9K5d42xv5JQv+9PeCqZhYLovQMYBcvJxR6DkS4IU8ULpU5
        63RYA+G/9J/dh4YkvPD6yizaXJd9XToFqfP9DB4oP8HoyDl0AkaTcPFhuLwDI/DJ5L3AJx
        QyiTclOMGs7Qiz1mp3aRfN9QSfWiDRM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-4cJXRiB5PYGJyQ-l7JkbmQ-1; Sun, 07 Aug 2022 09:27:09 -0400
X-MC-Unique: 4cJXRiB5PYGJyQ-l7JkbmQ-1
Received: by mail-wm1-f72.google.com with SMTP id r10-20020a05600c284a00b003a2ff6c9d6aso6942317wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 06:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=kWN2+XtBy7D+eIoeR0CwA7v9KmusYi195gp46RwIqnc=;
        b=zxGsRkIUq3dvo3SnLZoN/Yo/smtt7+Fjec2tmhVMUJkIBCClE+mMIwl9qoYKZ526lf
         Fm/94p+kyiYVY1KalOLZ5AfCSaCJblWuZJipRvM5rg6hazPI2MayDRWoNuRAilxjYAdI
         GwomcCXRZCUr2UjaG7Dc618/JSCUaO8FaYldcpBryR3PHmhpy22bWU2u6xkGvDkgJY6i
         +JwxdwYW5UeYPfhXe6emkNXBqkdLmaPpNKjLQq82qZWZwm/KdqCRaAIxexUlk+eRMedU
         htbRLFGOSMKlhPd0u2FqJFimhDRpHxe0S5EY/JmRaAAdZUDfNwH3r3itTJxhz5g6KJyV
         RD7w==
X-Gm-Message-State: ACgBeo0o9zopBO+Rk7PxgjBGvdBnuW3Oxq4LdcWxZhYgZMpax4rYt9mu
        UcEy9BcPPPO7q7JpnCqDf7HZZjVDiusu80N5/JErBBJdbi2DR5YmkBHyekw/EVNYzHEHpA46EKb
        FjXHgcqvZUwWMZIncK4H92MT+
X-Received: by 2002:a5d:4e52:0:b0:21f:15aa:1174 with SMTP id r18-20020a5d4e52000000b0021f15aa1174mr8959076wrt.106.1659878828292;
        Sun, 07 Aug 2022 06:27:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4PyGIbZ+3Zk1aEnQjWqF7U3soahzcZWTwqegYNF9JB2kgqFNme3tS807SILWNR3wTzZIMDGg==
X-Received: by 2002:a5d:4e52:0:b0:21f:15aa:1174 with SMTP id r18-20020a5d4e52000000b0021f15aa1174mr8959067wrt.106.1659878828086;
        Sun, 07 Aug 2022 06:27:08 -0700 (PDT)
Received: from redhat.com ([2.52.21.123])
        by smtp.gmail.com with ESMTPSA id d14-20020adfe84e000000b0021badf3cb26sm10887722wrn.63.2022.08.07.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 06:27:07 -0700 (PDT)
Date:   Sun, 7 Aug 2022 09:27:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, stefanha@redhat.com,
        jasowang@redhat.com, ascull@google.com, maz@kernel.org,
        keirf@google.com, jiyong@google.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220807091455-mutt-send-email-mst@kernel.org>
References: <20220805181105.GA29848@willie-the-truck>
 <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 03:57:08PM -0700, Linus Torvalds wrote:
> And hey, it's possible that the bit encoding is *so* incestuous that
> it's really hard to split it into two. But it really sounds to me like
> somebody mindlessly re-used a feature bit for a *completely* different
> thing. Why?
> 
> Why have feature bits at all, when you then re-use the same bit for
> two different features? It kind of seems to defeat the whole purpose.

What can I say? Hindsight is 20/20. The two things are
*related* in that IOTLB in vhost is a way for userspace
(the platform) to limit device access to guest memory.
So we reused the feature bits (it's not the only one,
just the one we changed most recently).
It bothered me a bit but everyone seemed happy and
was able to refer to virtio spec for documentation so there
was less documentation to write for Linux.

It's not that it's hard to split it generally, it's just that
it's been there like this for a while so it's hard to change
now - we need to find a way that does not break existing userspace.

-- 
MST

