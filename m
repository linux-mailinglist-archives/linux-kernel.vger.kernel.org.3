Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8290054D061
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358002AbiFORvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344040AbiFORvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77447541B6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655315478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HtMhpUCqpIkD63jrk6cA07RN6K+czflVLeAIk1/ZIZQ=;
        b=inm//HXgH90REqIX8BEAwl+j5JqRkYNG0O1vuNtkq7OahbFWcjLjr0SbKCiBtGsur0t7KK
        tz7AenzzdGpqDZ3GjkodeIG5uqTq08R5TKwwvFLwlATddjx57WlKyvLMwFkbCCSPhcdiXm
        mn51h30UXsFKD+s4Syp1n9ohkTFP3rI=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-Onor62rDPwOclqzomfN0fw-1; Wed, 15 Jun 2022 13:51:17 -0400
X-MC-Unique: Onor62rDPwOclqzomfN0fw-1
Received: by mail-io1-f71.google.com with SMTP id z19-20020a05660200d300b0066583f8cf2eso6454464ioe.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HtMhpUCqpIkD63jrk6cA07RN6K+czflVLeAIk1/ZIZQ=;
        b=mO0ro0YzgjMGoaN/ySHNh2HzSZX5rd1/abwGKfFKgGofHCvHZyp8a7Ciyj1dWrU46x
         qgNDmJdN7eeGTPe2uTi8HL27ds9ZmCQ1QRY/x7mtfRqwEyo4jFkacG4Vtf8tavPU0120
         ncbqKIalRuYZK2GMKkZ9sEPPWm4VzURDUG8boC9Q3A3Gcio2mMsWdKhs8ll8o7DqHl6i
         xnvQ3QjGN9mF/2PrCQM6sW2UuwEFeiWfE/fP4c0bjPSAigS8h8DocNxureNv969Xxebx
         VOJqAFcvUM+/aw9Dz/nIX1FvWuTLG/eSlBuKA3knEG+PvR6xRsYsE7e+Fnm1ZAqKW7hB
         L8EA==
X-Gm-Message-State: AJIora/FUmVkpDOBdvLt2E2hzRDJyiw1Kl9Qfw5G9ZE859x1e388rWj7
        9CxcgLVaMKK2szEQO7fsEwbNLQwt8gClnGagiNb3Qm4zZVgjtHqvBI01rqnGrhxMEoyVnwN+HuT
        m6qGw2bQ8Dr2+aAgCyOZ/8JSl
X-Received: by 2002:a05:6638:1301:b0:331:f2f0:a17e with SMTP id r1-20020a056638130100b00331f2f0a17emr459501jad.141.1655315476413;
        Wed, 15 Jun 2022 10:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vCFMxWhltw6eueHtpdeFczNKpggzjX1cqAIUE7MLPanSRiSr5V8MiQQmIzOwGvzB2WzRDkEA==
X-Received: by 2002:a05:6638:1301:b0:331:f2f0:a17e with SMTP id r1-20020a056638130100b00331f2f0a17emr459493jad.141.1655315476235;
        Wed, 15 Jun 2022 10:51:16 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id y24-20020a5d9158000000b00665770bcec5sm7139527ioq.49.2022.06.15.10.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:51:15 -0700 (PDT)
Date:   Wed, 15 Jun 2022 13:51:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] hugetlb: skip to end of PT page mapping when pte
 not present
Message-ID: <YqocEWUWkr09RLuk@xz-m1.local>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-2-mike.kravetz@oracle.com>
 <YpUhe6BSfflOVz7b@xz-m1.local>
 <e9456223-c26a-4d49-2920-9a597a817190@oracle.com>
 <YqoWfcZXJ7NfJaYJ@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqoWfcZXJ7NfJaYJ@monkey>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:27:25AM -0700, Mike Kravetz wrote:
> In many cases, the hugetlb specific page table routines are the same as
> the generic routines.  But, there are a few exceptions.  IMO, it would
> be better to first try to cleanup and unify those routines.  That would
> make changes to the walker routines less invasive and easier to
> maintain.  I believe is other code that would benefit from such a
> cleanup.  Unless there are strong objections, I suggest we move forward
> with the optimization here and move the cleanup and possible walker
> changes to a later series.

No objection on my side, thanks Mike for trying to look into it.

-- 
Peter Xu

