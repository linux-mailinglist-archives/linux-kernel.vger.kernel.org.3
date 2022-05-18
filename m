Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A739A52C3F7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242264AbiERUG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbiERUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42B8623EB45
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652904392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kUEP9mgzsY6Z/VY2AYK1ldrCYllOmEnEcAskiI5ssd0=;
        b=f7DE5iMJ0HxRFCiTxzN1Zv/NYuRpWmWBplhC9CqxszbVAzV+kOQ0pXhLSM6ABvZuwPmAY2
        Lsjfu8QwS70/e8TTKq7IbVcd9Zxo6sFqD41TKlYKt9dFXF27yFY13mMGDyUVaGRvgGjjvm
        7MSMV7Ac1jYHMq/pC1IF0BCZllMdA4U=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-sZ0lk0PTMT-RF1lxZDJiNw-1; Wed, 18 May 2022 16:06:31 -0400
X-MC-Unique: sZ0lk0PTMT-RF1lxZDJiNw-1
Received: by mail-io1-f70.google.com with SMTP id k2-20020a0566022d8200b0065ad142f8c1so886092iow.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kUEP9mgzsY6Z/VY2AYK1ldrCYllOmEnEcAskiI5ssd0=;
        b=F231hjTESDiA9QpwYEyb+YZXwK4Dii0DMKO/3ZaKZ3D4Nr5JR7Q1WO3c27WD+8l7ai
         GmOzpETR/R3sbTEPH/s7QWx4hF8VmuE+DpNaNdMuHQw2aWlvFUr5hdKVCsCAa6kT1AO4
         8Qj6fruxJLPy5LRDsdK4Wy9msC2Wdkmom8LtUDhwH6zhsjIOLTcrGIHvbqhNtGTVcs14
         9htnJWITJwtdGXh2ZVpUR8KGLikuwTTEnlSTF0WwiZTscdkabMTOPX0ebS374E0ybA4+
         IqsqmNQODOhksHWIQtTQxACDNHUDvQUWCMOk5XLp1NrmzDmByFsGCeOis/1GF3WGs0Ct
         a/pg==
X-Gm-Message-State: AOAM531A4PwQfVRpAb+g74ZHB+cdxTkqhSNR1j9aotnufXmYotJPQObo
        W+451qC0wIvyxg59j9mfYUZMyYhuBirFT+YptDU0TrJs1e82enSUcZW/9nR0FlAwofoqiB/sYsZ
        cg6AtlOUn87V/gmkuRzYwyBR0
X-Received: by 2002:a92:c263:0:b0:2d1:173d:962e with SMTP id h3-20020a92c263000000b002d1173d962emr784809ild.156.1652904390942;
        Wed, 18 May 2022 13:06:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmMl6ZbCxagrfmGNsZaZ9j44die4g02KWinO4zidjTob0E4y896zjJZBw25cxYgYQv2WjNJg==
X-Received: by 2002:a92:c263:0:b0:2d1:173d:962e with SMTP id h3-20020a92c263000000b002d1173d962emr784791ild.156.1652904390703;
        Wed, 18 May 2022 13:06:30 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id 134-20020a6b148c000000b0065a47e16f4esm114134iou.32.2022.05.18.13.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:06:30 -0700 (PDT)
Date:   Wed, 18 May 2022 16:06:28 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <YoVRxLEHG392qsjR@xz-m1.local>
References: <20220506135205.46810-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220506135205.46810-1-peterx@redhat.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 09:52:05AM -0400, Peter Xu wrote:
> v2:
> - Fix syzbot report
> - Added unit to the test results in commit message
> 
> Note: I didn't copy any arch maintainers yet because I want to get some
> feedback from the mm people first..  I'll start doing so when there's a new
> version.  Please have a look, thanks.
> ---

Any further comment on this one before I start to copy arch maintainers?

Thanks,

-- 
Peter Xu

