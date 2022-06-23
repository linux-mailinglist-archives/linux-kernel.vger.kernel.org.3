Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C725589F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiFWUVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiFWUVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59BAD4EA0A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656015703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MGTe6KngeQd+vhwkXpPPd5v7NkorBp+zMw2BEOEYKVU=;
        b=TEmA+2Xewde0IFJ9ljxtXILkpN1JpRXrKw9VuFJMSR+Jm+3GI44dOJZXqdZoxIoYNBIjKX
        vaSQNImn5DSIzhvqirc/bWG48oqFqRNkbQSs+obvnTx5mJZsi4HcW8O5AROss22HFWzAmp
        5FL9EvI+Q21OcoGu5Wi/9/5pNU6j9IU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-eb2IPo07PBCWrsHgYxhtPA-1; Thu, 23 Jun 2022 16:21:42 -0400
X-MC-Unique: eb2IPo07PBCWrsHgYxhtPA-1
Received: by mail-il1-f197.google.com with SMTP id x5-20020a923005000000b002d1a91c4d13so96631ile.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=MGTe6KngeQd+vhwkXpPPd5v7NkorBp+zMw2BEOEYKVU=;
        b=f1QUqvhxuxeN7RDbLt5C+7pbdKjBphQ4vod4Zuq0sA+Syslabkhdivp9oQQcUKBCZg
         kqyjGrcsrnIpbxzKdX1rYad/RMNNwnTGqQp8un0URrwQ3sOCY9JDT8EN5o3lmkAqld/8
         W+68VEHDIep1lFY7iTeLY9m/buDT/VzoDrK3knZV91xSCbrAJaBII0t2zFBBU4R7xXfK
         +scMpnQNUNBvbnZSmD8ycH4Cizb+0ZT9/m7cLartIeP6wbZhXKLFvhmn2May7eN73NpN
         NRCoIf5Omdgo4qkxQI72LcyATo7DI+REfmiaIHvFFpD5ycjaTNn9j6Eih76pXqaqkYZz
         Saew==
X-Gm-Message-State: AJIora+o/N1N36uOpnDHU2UprHV2I5Pu/lFEb0R8v3b65RU3vSbe5VvS
        InsQVNDDrWm3nzQNzRxolNmRifs3jJWboQwdQ5oXooYJCORcl1HsRS0I2KKR37JdmnW/ibVdeES
        NHGjIdnyNjZwf8u9pfKYk8YjL
X-Received: by 2002:a05:6602:4017:b0:671:eae4:9d35 with SMTP id bk23-20020a056602401700b00671eae49d35mr5675162iob.6.1656015701263;
        Thu, 23 Jun 2022 13:21:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sERAz0Cbsp1FFDc97zOssvDAgvgNpRQPBpJO08spAwNaML5gRq5IGwmQEPahTsSQjDefXMdA==
X-Received: by 2002:a05:6602:4017:b0:671:eae4:9d35 with SMTP id bk23-20020a056602401700b00671eae49d35mr5675147iob.6.1656015701023;
        Thu, 23 Jun 2022 13:21:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a11-20020a92d58b000000b002d8f2385d56sm226923iln.63.2022.06.23.13.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 13:21:40 -0700 (PDT)
Date:   Thu, 23 Jun 2022 14:21:39 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, akpm@linux-foundation.org,
        minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        jhubbard@nvidia.com, joaodias@google.com
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
Message-ID: <20220623142139.462a0841.alex.williamson@redhat.com>
In-Reply-To: <cb7efb0f-5537-5ce4-7aec-bb10ea81d5de@redhat.com>
References: <165490039431.944052.12458624139225785964.stgit@omen>
        <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
        <20220615155659.GA7684@nvidia.com>
        <cb7efb0f-5537-5ce4-7aec-bb10ea81d5de@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 20:07:14 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 15.06.22 17:56, Jason Gunthorpe wrote:
> > On Sat, Jun 11, 2022 at 08:29:47PM +0200, David Hildenbrand wrote:  
> >> On 11.06.22 00:35, Alex Williamson wrote:  
> >>> The commit referenced below subtly and inadvertently changed the logic
> >>> to disallow pinning of zero pfns.  This breaks device assignment with
> >>> vfio and potentially various other users of gup.  Exclude the zero page
> >>> test from the negation.  
> >>
> >> I wonder which setups can reliably work with a long-term pin on a shared
> >> zeropage. In a MAP_PRIVATE mapping, any write access via the page tables
> >> will end up replacing the shared zeropage with an anonymous page.
> >> Something similar should apply in MAP_SHARED mappings, when lazily
> >> allocating disk blocks.  
> 
> ^ correction, shared zeropage is never user in MAP_SHARED mappings
> (fortunally).
> 
> >>
> >> In the future, we might trigger unsharing when taking a R/O pin for the
> >> shared zeropage, just like we do as of now upstream for shared anonymous
> >> pages (!PageAnonExclusive). And something similar could then be done
> >> when finding a !anon page in a MAP_SHARED mapping.  
> > 
> > I'm also confused how qemu is hitting this and it isn't already a bug?
> >   
> 
> I assume it's just some random thingy mapped into the guest physical
> address space (by the bios? R/O?), that actually never ends up getting
> used by a device.
> 
> So vfio simply only needs this to keep working ... but weon't actually
> ever user that data.
> 
> But this is just my best guess after thinking about it.

Good guess.

> > It is arising because vfio doesn't use FOLL_FORCE|FOLL_WRITE to move
> > away the zero page in most cases.
> > 
> > And why does Yishai say it causes an infinite loop in the kernel?  
> 
> 
> Good question. Maybe $something keeps retying if pinning fails, either
> in the kernel (which would be bad) or in user space. At least QEMU seems
> to just fail if pinning fails, but maybe it's a different user space?

The loop is in __gup_longterm_locked():

        do {
                rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
                                             NULL, gup_flags);
                if (rc <= 0)
                        break;
                rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
        } while (!rc);

It appears we're pinning a 32 page (128K) range,
__get_user_pages_locked() returns 32, but
check_and_migrate_movable_pages() perpetually returns zero.  I believe
this is because folio_is_pinnable() previously returned true, and now
returns false.  Therefore we drop down to fail at folio_isolate_lru(),
incrementing isolation_error_count.  From there we do nothing more than
unpin the pages, return zero, and hope for better luck next time, which
obviously doesn't happen.

If I generate an errno here, QEMU reports failing on the pc.rom memory
region at 0xc0000.  Thanks,

Alex

