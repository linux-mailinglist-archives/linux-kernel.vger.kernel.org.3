Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDAE58CE8E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiHHT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244392AbiHHT2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FE411A38E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659986888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FKLyUQGyxiB0I8xVy9lbNQivmteb6Wpnt1Hf2TvWtBo=;
        b=KVKZcDqnpQ9LU9FmoDfir0YSwek/z8/7zGtkhOiTytDYvEOJxjRGHJunl1m+6Kta4UJnRa
        pnQxajaGNxoG7VfqGSs0Iwwi++yyMabalI8Hz3k6KhVio6OCxBN0kTr/wV3HPJlOrTVTl2
        2CSFj4BEBb5GxZeQ9WldUB3Q78EXkGw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-HIVYDGTSMpGtAydPIZd-NA-1; Mon, 08 Aug 2022 15:28:06 -0400
X-MC-Unique: HIVYDGTSMpGtAydPIZd-NA-1
Received: by mail-io1-f72.google.com with SMTP id g22-20020a056602249600b0067caba4f24bso5129855ioe.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 12:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FKLyUQGyxiB0I8xVy9lbNQivmteb6Wpnt1Hf2TvWtBo=;
        b=qLsinc+sbs0uZj90OlPhGI7vbSzHvyD8f/7uwWnnvsItOavFsKLYQGs3H0Khwa03Yw
         hjkmLuIsJ/It+7a4fe/ldaxqDmr93z3zTuDggzdAX8k/+RP2Ka+icpQkGCsEG7CHp6NC
         wdLktpEEWcPVvCWaPP2Yym/YHQxTs/TpYTNMnQRqwtfFqK8hmy3fvb/HFxvx+jIC0mLf
         KEfGOhi7qXvaNN2doTWMAfAhFx5EWCsIrP6kFPqg2Myb2zBJnmy+F3Sz1Tl9868ZprhN
         kRzdlEoHY8iQhaOirjpsanep2wSIyV7c33BOg6ZtKOlgLQCIVuwQd1EtDFSK8G8BqFyp
         v9FA==
X-Gm-Message-State: ACgBeo09KLfT+oaojvpj+Dh4N9tX5J72Ql6UelieycHPAsDUEC5xH1AN
        0LRrPCNLvmuBEQAejIPBGqofc5FaPzhX3mSj9/9xhhVD6n0YFYoh/vCaGh/2Ln2lovGc4Lflf+0
        +XmZ2zBaPJzEAY+51n9lfK8Bw
X-Received: by 2002:a05:6602:1493:b0:67c:498f:6297 with SMTP id a19-20020a056602149300b0067c498f6297mr8018122iow.19.1659986886048;
        Mon, 08 Aug 2022 12:28:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6cjNWPmiHP9dSCLeVdoD8+pkHqAUBj7IxWRFHwftxGib/s/HCg7uOu95cJaOUnPFCTBHJyZA==
X-Received: by 2002:a05:6602:1493:b0:67c:498f:6297 with SMTP id a19-20020a056602149300b0067c498f6297mr8018116iow.19.1659986885839;
        Mon, 08 Aug 2022 12:28:05 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id q21-20020a02a315000000b0034272baf43esm5445764jai.168.2022.08.08.12.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:28:05 -0700 (PDT)
Date:   Mon, 8 Aug 2022 15:28:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/hugetlb: fix hugetlb not supporting
 write-notify
Message-ID: <YvFjww9AX/BuHdSn@xz-m1.local>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-2-david@redhat.com>
 <Yu1eCsMqa641zj5C@xz-m1.local>
 <Yu1gHnpKRZBhSTZB@monkey>
 <c2a3b903-099c-4b79-6923-8b288d404c51@redhat.com>
 <Yu1ie559zt8VvDc1@monkey>
 <73050e64-e40f-0c94-be96-316d1e8d5f3b@redhat.com>
 <Yu2CI4wGLHCjMSWm@monkey>
 <Yu2kK6s8m8NLDjuV@xz-m1.local>
 <36bcc1f5-40e9-2d2b-3e94-18994bf62ca4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36bcc1f5-40e9-2d2b-3e94-18994bf62ca4@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 06:36:58PM +0200, David Hildenbrand wrote:
> Well, because the write-fault handler as is cannot deal with
> write-faults in shared mappings. It cannot possibly work or ever have
> worked.

Trivially - maybe drop the word "require" in "Hugetlb does not
require/support writenotify"?

-- 
Peter Xu

