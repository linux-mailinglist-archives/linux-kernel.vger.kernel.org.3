Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56564F228E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiDEFXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiDEFXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E8202DDB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649136049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXNd3S63I+/DnvIHKzVjn0CsQfzi1GKX7Atsgl6DyUY=;
        b=Aj8viwLBQejEOhZ4x+8nLx/BkAe0HyKtHO8v1WZ6hPVfiGO728bj6zCLDd7rTgjnEL+LQ1
        9sZqfcLgTBmClRPjoxGsIHjH5cTIUKis1GwX7yHp3cCPpzh+zKSYelCUW4q6bYMXIxviso
        GUDg2k8vi8e1A4j0g1KYoVWtcuQhT2I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-IMR1Vew1OeGpXiREZs5WGA-1; Tue, 05 Apr 2022 01:20:48 -0400
X-MC-Unique: IMR1Vew1OeGpXiREZs5WGA-1
Received: by mail-wm1-f71.google.com with SMTP id v62-20020a1cac41000000b0038cfe6edf3fso759825wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 22:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hXNd3S63I+/DnvIHKzVjn0CsQfzi1GKX7Atsgl6DyUY=;
        b=tHpxr542+0U6hYPpExRt2lZFjufkX279xhhKQUTZmZler7/BB0KtS6zG6trkvGbIpk
         2W8+AGx4frjPyohPfzaxNV3Kbefup+RIiCVZjVggF6yvTMy7aMSYEpm81J/zb6OKZuGo
         rMBzamAEzfxkw2W2cnrg678P2yVfqfNvtdFYhx9Q2cEo1w2jnidW8WW0gpdOqwThTGZJ
         PBksNU6fhgoXIEq9Wlk6I992GOEwXAybJAabSQ7NSqB2j/c6WCgsZJ30DvmRsHtAmXbD
         i5dB48GtzGnVU9gsSHN0VhDlzTAwm8cmgzV3Qz6zlyh76bfSMuw9WywQQHS7wGNwJNzx
         ktuQ==
X-Gm-Message-State: AOAM532oAsA220hUiuPcrC1mdliJ4huW2xElyG6VRVzrHnJ3+qhEr2mB
        T5E2ZAsXKg83I4LXDDkZozZa2HAFqczRsddLFKJA3rHIueCt0uZuOt2jD7UFttYeOppfFzVpDDC
        q7ot2n/3L6e4CEqmD1VAdg6lx
X-Received: by 2002:a7b:cb87:0:b0:38e:7464:f796 with SMTP id m7-20020a7bcb87000000b0038e7464f796mr1343552wmi.133.1649136046819;
        Mon, 04 Apr 2022 22:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5pSIpqXDbMjBhGhF2Ym8NkkUzOiS8ugQkJZJSUEkD8mJRZ/i+6rvspLskok00+YPdm3I8bA==
X-Received: by 2002:a7b:cb87:0:b0:38e:7464:f796 with SMTP id m7-20020a7bcb87000000b0038e7464f796mr1343528wmi.133.1649136046521;
        Mon, 04 Apr 2022 22:20:46 -0700 (PDT)
Received: from redhat.com ([2.52.17.211])
        by smtp.gmail.com with ESMTPSA id d14-20020a056000186e00b0020405198faasm12295878wri.52.2022.04.04.22.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:45 -0700 (PDT)
Date:   Tue, 5 Apr 2022 01:20:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>, arei.gonglei@huawei.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, helei.sig11@bytedance.com
Subject: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
Message-ID: <20220405012015-mutt-send-email-mst@kernel.org>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
 <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
 <20220307040431-mutt-send-email-mst@kernel.org>
 <87h778g8nn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h778g8nn.fsf@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 05:39:24PM +0200, Cornelia Huck wrote:
> On Mon, Mar 07 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Mar 07, 2022 at 10:42:30AM +0800, zhenwei pi wrote:
> >> Hi, Michael & Lei
> >> 
> >> The full patchset has been reviewed by Gonglei, thanks to Gonglei.
> >> Should I modify the virtio crypto specification(use "__le32 akcipher_algo;"
> >> instead of "__le32 reserve;" only, see v1->v2 change), and start a new issue
> >> for a revoting procedure?
> >
> > You can but not it probably will be deferred to 1.3. OK with you?
> >
> >> Also cc Cornelia Huck.
> 
> [Apologies, I'm horribly behind on my email backlog, and on virtio
> things in general :(]
> 
> The akcipher update had been deferred for 1.2, so I think it will be 1.3
> material. However, I just noticed while browsing the fine lwn.net merge
> window summary that this seems to have been merged already. That
> situation is less than ideal, although I don't expect any really bad
> problems, given that there had not been any negative feedback for the
> spec proposal that I remember.

Let's open a 1.3 branch? What do you think?

-- 
MST

