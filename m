Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0384DDFFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbiCRRdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbiCRRd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:33:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF666180047;
        Fri, 18 Mar 2022 10:32:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so5009636pjb.5;
        Fri, 18 Mar 2022 10:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EdgICBSx30HyYfo1Vfv7IDSnJiyy8MgsSfGKAttnYVg=;
        b=egGHMuCYPkCj4tcVAbZQAnfcMI1Ux1Oe+2/+8STcZ0Q1T8ndYieave4kV99rYoPYwq
         4x7tlFrdNA5u6w3Wb/BIinfJCYEGZDUi7rrAL3F8qCAoGHNSBCvOzUHvdaoKpCw24w/r
         XZIwyC+rg6Yu283b4pvPBSXTcty37Rtfe9MmoqxwshhUwe0UHjkO0OZz5zzxGS9nELbc
         pPaHWMc/URLe9ApGEWkzDLLiwTDNk46lAqcZht/+tGo9iDeesoKJKZhcVq4X5uPC/7c3
         YVtkzH3rUYuXiyzW6cOAcB9wwM/g8x9eomRGMrYu57joA04yW8lXskH5S7uGlhO7Ki46
         Se6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EdgICBSx30HyYfo1Vfv7IDSnJiyy8MgsSfGKAttnYVg=;
        b=mCZimjobHXqS3BYorYX5jnXkk2QvMXCzow085rNNQ0HIY8Kq5CsCV9KfiqAJhtSkln
         +mwVDgohMlB0gWVBBayiG33FFJaNKq34g+OLWiPkG4QzdkcPUUffXb0Plfiui7eeMHM1
         b6RiDOLfb5uHNZ1Sfepd1MqNDaIJaJjhrxu7b6gDVFj1jaZMNo8GOWTJUoeHYSWkJEMC
         cKUpTj4J42P5ySYPtE5ePDJZPE9eXPi2hdZG9BmVn/aTLnJJboc2eZSC2iuJ9Eu3xv37
         /aO/kFrjV4+7sEq/oeHky2TgxqWrUVu6/5NG2EFvDYK7kx6aP7nSd8pc5T5HdtDJX3+n
         2KuQ==
X-Gm-Message-State: AOAM533hDS1bcntiA1moMKereupjCI3FY6h7YdP1e8Pnpxj7Z4y+CFD/
        jl4jvVtt6cod0AggRV9QZ60=
X-Google-Smtp-Source: ABdhPJw3/ByU76tKO2bD48AXDGH4NMU3ah0PNGXbFs3dAk3waO8l9IVy8+SV/EqMYpksFwtEUgKSSA==
X-Received: by 2002:a17:903:1108:b0:151:9c42:7d1 with SMTP id n8-20020a170903110800b001519c4207d1mr563498plh.54.1647624730241;
        Fri, 18 Mar 2022 10:32:10 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:20b4:90a0:8e2e:6022])
        by smtp.gmail.com with ESMTPSA id q8-20020aa78428000000b004f7281cda23sm9855069pfn.201.2022.03.18.10.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 10:32:09 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Mar 2022 10:32:07 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
Message-ID: <YjTCF37cUNz9FwGi@google.com>
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <CABWYdi1PeNbgnM4qE001+_BzHJxQcaaY9sLOK=Y7gjqfXZO0=g@mail.gmail.com>
 <YjA439FwajtHsahr@google.com>
 <YjEOiZCLBMgbw8oc@google.com>
 <CABWYdi0jd_pG_qqAnnGK6otNNXeNoiAWtmC14Jv+tiSadJPw0w@mail.gmail.com>
 <CABWYdi2gOzAK60gLYKx9gSoSfJRZaAjyAWm+55gLgcSKrDrP9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi2gOzAK60gLYKx9gSoSfJRZaAjyAWm+55gLgcSKrDrP9Q@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 09:30:09AM -0700, Ivan Babrou wrote:
> On Wed, Mar 16, 2022 at 11:26 AM Ivan Babrou <ivan@cloudflare.com> wrote:
> > I'm making an internal build and will push it to some location to see
> > how it behaves, but it might take a few days to get any sort of
> > confidence in the results (unless it breaks immediately).
> >
> > I've also pushed my patch that disables SWP_SYNCHRONOUS_IO to a few
> > locations yesterday to see how it fares.
> 
> I have some updates before the weekend. There are two experimental groups:
> 
> * My patch that removes the SWP_SYNCHRONOUS_IO flag. There are 704
> machines in this group across 5 datacenters with cumulative uptime of
> 916 days.
> * Minchan's patch to remove swap_slot_free_notify. There are 376
> machines in this group across 3 datacenters with cumulative uptime of
> 240 days.
> 
> Our machines take a couple of hours to start swapping anything after
> boot, and I discounted these two hours from the cumulative uptime.
> 
> Neither of these two groups experienced unexpected coredumps or
> rocksdb corruptions.
> 
> I think at this point it's reasonable to proceed with Minchan's patch
> (including a backport).

Let me cook the patch and then will post it.

Thanks for the testing as well as reporting, Ivan!
