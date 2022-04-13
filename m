Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536094FFC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiDMRGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiDMRGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:06:50 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377D2E9E2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:04:28 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id z15so1790315qtj.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1gkKYNxAVgG9gQQX5FWE9T2WbQK+aJhhHh5HXzZzRl0=;
        b=eD46y7DSuAwpZt2kCawtVnAJ5hjr8uaJ3IOzsJ58DMvgBTOiqOB8Sonf6uUc/0Q57C
         /uHfZKftQHmoCHB0Md9ZQcbFo+Ndoio7UGECJozuvg+Rhu+dY3VBjQPvYnWsMY1FFrDf
         xaCdU9vMQTRVa6q05dHvyhOZipFjnqilCTMeaPjwZOdYt3BZ0rbRxCY8au/KR9bIvb5s
         RZMtS4uGz6BSndUBvPyqbRIUpkBoMAFrYqvuzrdf+NC3Ommxv/XKExEDYMhSVb0vq+fM
         djrOe6Q12ToLJDqZOmfQFACEVYBk1yesVNARFOvDZ0Vvk7roQHbm8Tyb/JUCqLtbI/16
         GxpQ==
X-Gm-Message-State: AOAM531Oq1XaDt/kSNWCvtNXfGjyLDsl/EUj8/K4o9NAteJjHfeS1Fu8
        piQpMY0fhiYeCdWj0qgvOMTC
X-Google-Smtp-Source: ABdhPJzk8Hsy6b4fFdojSz0Z/fwMjicI2vghSEfVW7+AE/QcDDdQw502GSidyJJNTGoVWuUmwvp37w==
X-Received: by 2002:ac8:5e4e:0:b0:2e2:2bad:47b1 with SMTP id i14-20020ac85e4e000000b002e22bad47b1mr7781053qtx.493.1649869467355;
        Wed, 13 Apr 2022 10:04:27 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id a23-20020a05620a103700b00699d49c511dsm16089900qkk.104.2022.04.13.10.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:04:26 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:04:25 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] block: turn bio_kmalloc into a simple kmalloc wrapper
Message-ID: <YlcCmW0CLAFXB8UQ@redhat.com>
References: <20220406061228.410163-1-hch@lst.de>
 <20220406061228.410163-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406061228.410163-5-hch@lst.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06 2022 at  2:12P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Remove the magic autofree semantics and require the callers to explicitly
> call bio_init to initialize the bio.
> 
> This allows bio_free to catch accidental bio_put calls on bio_init()ed
> bios as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@kernel.org>
