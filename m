Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6905457BE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiGTTPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGTTPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74B7431354
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658344548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rgr6tBel5eS7x9CZwqZNQr12OSq9bS7PlstJEoUtG4Q=;
        b=VPgpuvm+eLRXJLQowbNMm6MlYXUM2sfYaid+xn9Z2sXoPFEQcl9ZEGYziyfXgOp7qeZSUG
        NmWst+Y01Q9HSbTiT8CySCOixkDkt1Q6eQ5oolm63s7gQbi7MA/vy78fzBcVOsDwaSLbQe
        2p5ucUvmWRyCB9IrT04WnwcL/w0wk9I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-TNb-dY20PjiOnKGGRQJ8_Q-1; Wed, 20 Jul 2022 15:15:47 -0400
X-MC-Unique: TNb-dY20PjiOnKGGRQJ8_Q-1
Received: by mail-qv1-f69.google.com with SMTP id q4-20020a0ce9c4000000b00473004919ddso10030730qvo.16
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rgr6tBel5eS7x9CZwqZNQr12OSq9bS7PlstJEoUtG4Q=;
        b=1Ksu4CnD9X9K5cfFnP0RIplF+1TkTrJxNN9ZwKEyWGXFAPopydiPdkeCBuxY61bwms
         6/2ueiQvhTOM0iCFPJliS3NjZ0t/K2eS5EQ7jSXxCCjUKqX928RaHtNdSvRAs+OJ09S3
         38vNhhXg8MHm4dxMV0+Qj4dp7Nui7is+MNEVJXSHMB6ME/oZsZKQRnIqFFXNP+bnkzu/
         pG85pDdRmMcRQ5vr0rd8GTvnJRmp9u8AVaCsDgvU/j1b9pOrIyCSywveBTQN3dMJAdF2
         QOHRl9fB9iJu9s1U4YL0Ex67g8BmORQ45aYgerOTMqQjOLDo6/7osWfeHxawGdeCYHOQ
         tt2Q==
X-Gm-Message-State: AJIora8Od937ZfmWNnyK+22jsEPSyWGQ6izfQ6MuYayJg5deyDsu8vXC
        78GctlG4C958nap6n/7e5icVxUWvyObwVy6wtAqJ7XpwjkGtZf/s/rWC2kRjI1a18BTELZAjFFt
        5EzVoVvtBckLhILuw5vFAaP/R
X-Received: by 2002:a05:622a:143:b0:31e:9c61:c1d7 with SMTP id v3-20020a05622a014300b0031e9c61c1d7mr29315915qtw.128.1658344546839;
        Wed, 20 Jul 2022 12:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tS8bxsQFfmgmIDJi+MSRJhX0yI039P0+Aey5gXr4aFl2IBE6wVL3S96bkcDl4j9uow306Z/Q==
X-Received: by 2002:a05:622a:143:b0:31e:9c61:c1d7 with SMTP id v3-20020a05622a014300b0031e9c61c1d7mr29315883qtw.128.1658344546559;
        Wed, 20 Jul 2022 12:15:46 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b006b59f02224asm8568940qkb.60.2022.07.20.12.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:15:45 -0700 (PDT)
Date:   Wed, 20 Jul 2022 15:15:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Message-ID: <YthUYF3invrjlzUc@xz-m1.local>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com>
 <YtcYVMoSRVxRH70Z@xz-m1.local>
 <017facf0-7ef8-3faf-138d-3013a20b37db@redhat.com>
 <Ytf+zIxVPTVXTZdp@xz-m1.local>
 <2b4393ce-95c9-dd3e-8495-058a139e771e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b4393ce-95c9-dd3e-8495-058a139e771e@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 05:10:37PM +0200, David Hildenbrand wrote:
> For pagecache pages it may as well be *plain wrong* to bypass the write
> fault handler and simply mark pages dirty+map them writable.

Could you elaborate?

-- 
Peter Xu

