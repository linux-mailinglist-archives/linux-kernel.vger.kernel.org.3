Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F274C01E6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiBVTQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiBVTQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 294C715E6D4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645557377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+GUkN0EwP3DJ0lx9lCnDa6Z8wiaRvOcLwpTDRLmnnU=;
        b=QDE01n6CkBFxaItVWG1/DbMwfd5kGbcGZR/Tcsxu59AzzdfIElWamAJJeJF8os3OjEc2ES
        JBQZFdwXthhHnLn66Y/nTp5lCkeMmCsmu9Fx6DWAqD5uvLt8rgor9cvwLZV30eMNj9w0kQ
        7n1x06ohFnJ+Ik4mQBmmERPJwGurSKI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-cx6FFd5PO0ObXeseIhVUtw-1; Tue, 22 Feb 2022 14:16:16 -0500
X-MC-Unique: cx6FFd5PO0ObXeseIhVUtw-1
Received: by mail-qv1-f69.google.com with SMTP id if3-20020a0562141c4300b0043147d6bacdso731165qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+GUkN0EwP3DJ0lx9lCnDa6Z8wiaRvOcLwpTDRLmnnU=;
        b=NVNOCl28Ta3zisF+0vl91db500915E5gaFIg5CGFzXBsEHUaXIrmGU6XBrIDlioTwU
         nUeYUIP/AmE5VMa/BbeNRv83QIdLKXy8ZZ1B6KUqKni7BJD0Ns3WCOPdXx10tQ93+Fty
         1i4fv1Yo50SmuINs3Cs2/n+ltGF/Crq1+52JwooN0JyCeJZdrcwi7XpEBHL+r3OEg+XE
         F0TYlg8o706T25ZdpTZaKIICapIq72SGA/g62qOL+ipVLrfqD335wTW50HocxPlZX1JU
         B5+iu9GYJrg3bBd5JCe9p2DZZX4u6BWUWAust+8czCACqu/K964/EFc1DZPA9asb2WD8
         XuRA==
X-Gm-Message-State: AOAM53180zbV9P/BlIWkkukBqnOOuQA1txeFFhKCW5n6pWnBO4yuwNrO
        uvPYsU/hbMYB8TbbBJChL3M7frbB1+03MAusfRvpRRoJMYaEyaEQvi/0NIDr/0sdueOlMiH5QBW
        0PPFlwjt4fS3V2nCAk/NQweM=
X-Received: by 2002:a37:8602:0:b0:62c:de8f:ad74 with SMTP id i2-20020a378602000000b0062cde8fad74mr13357246qkd.142.1645557375261;
        Tue, 22 Feb 2022 11:16:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoqR48S+c52tioZfwhQpWLjHci5jUdhUMN36vrY1CYw/3YuAqGThC/L/gVEu0PVsn1GFntaQ==
X-Received: by 2002:a37:8602:0:b0:62c:de8f:ad74 with SMTP id i2-20020a378602000000b0062cde8fad74mr13357235qkd.142.1645557375068;
        Tue, 22 Feb 2022 11:16:15 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id b14sm426205qtk.44.2022.02.22.11.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 11:16:14 -0800 (PST)
Date:   Tue, 22 Feb 2022 14:16:13 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Brian Geffon <bgeffon@google.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dm: introduce a DM_ENFORCE_OPEN_COUNT flag.
Message-ID: <YhU2faRZJ4NstJ6L@redhat.com>
References: <20220125002025.GA21887@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
 <20220126192234.572058-1-bgeffon@google.com>
 <CADyq12yugY0g2EMYvyrPVn98x3Tp4PR+eVddmmjZpKSYyrrzag@mail.gmail.com>
 <YfqYTuhGqOl4SneK@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfqYTuhGqOl4SneK@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02 2022 at  9:42P -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> Withmy block hat on: nak to this.  No block driver has any business at
> all rejecting "too many openers".  In fact any opener but the first of
> a partition is already not counted as an opener, and I plan to complete
> hide the open count from the device driver.

I agree that this proposal exposes controls to userspace that simply
shouldn't be meaningful given the arbitrary nature of openers.  And
preventing openers can result in a race where systemd or some other
service opens before the intended primary consumer of the device.

Seriously brittle and even if finely tuned to have a suitable value
for some niche usecase like android: an absolute hack.

Sorry, not interested in taking this.

