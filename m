Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAD054BAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344828AbiFNTnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347396AbiFNTnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D26342A701
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655235820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0kBJ9jVSmrZsPatTagpukwacW+JAMXi3G+ttyb9CVmA=;
        b=MyiNEDZYK9V2SLrKcBGEeXweuETpKR2OYWzdBF244P6uyu9N45ibDrgDGqtk3oAXDqp8IE
        R3SBCVAlcip+SKPCGnuB/04kBQSz3JkINfXwBfeWYpGEYxJ0Lq2lEDDM0XcAPj1Srt4nUG
        dDzOzlQ8HBP54XvLg/in2splZSVCKF8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-6xBLddBuP9uS3YiJkqjbow-1; Tue, 14 Jun 2022 15:43:38 -0400
X-MC-Unique: 6xBLddBuP9uS3YiJkqjbow-1
Received: by mail-io1-f71.google.com with SMTP id z19-20020a05660200d300b0066583f8cf2eso4861409ioe.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0kBJ9jVSmrZsPatTagpukwacW+JAMXi3G+ttyb9CVmA=;
        b=JgAXrj2rt5Cu+sfoXNX0SbpoCyG1Cd8ygani4C8MDi5Rpb9y+0KGYi5QfA9cL34lhS
         0r5YXOtfmmOQkzsO5VoO1VJK6rQC705Rg6eIM5/VguPjyHJ2z32FLUJeJH7hBACZClaz
         oxDNClbO9qB4NtL3dIvsGY5Ov1Usxn43jf3Zyao5mvswIvOPp3h86cy4+30kNo2Zzmow
         D7xUmtNbALHUK4xAHbiQW2JtK5D1hoXPjrUfuosX7MDOM9d90Z6Ak6cT8A+YZonazbEt
         epznLJmbYQuP45iVIznfOqsMUsHPOZ5DmQ50vOkVf7e/55/Rcc1peVDt6xwZIjxBmpUI
         xgBg==
X-Gm-Message-State: AOAM5327dSwHT0J8vSBODDnUrzd/xSOARJ1r0QCLOySXd9NHfqS+MOnU
        +GHcsKQ8UgTF1VXsAfUipT2Mzc+maQUENPOYpmkfwe023wgCa1qyvcbCJ1dIi6Fh2CGRMKDVsyt
        UHEPJaEcu2+TCaPA39sTC904p
X-Received: by 2002:a05:6638:2711:b0:332:1030:d6c2 with SMTP id m17-20020a056638271100b003321030d6c2mr3742580jav.263.1655235818126;
        Tue, 14 Jun 2022 12:43:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyka9HjOgMy6b8pnRt/A/embx73zjB9YhZLRYD1IRFIZfVzSN4bJjcwuFQgiPhot6lgYqIMuA==
X-Received: by 2002:a05:6638:2711:b0:332:1030:d6c2 with SMTP id m17-20020a056638271100b003321030d6c2mr3742560jav.263.1655235817943;
        Tue, 14 Jun 2022 12:43:37 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id y11-20020a02904b000000b0032e6f0d3796sm5225276jaf.145.2022.06.14.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:43:37 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:43:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3 6/6] selftests: vm: add /dev/userfaultfd test cases to
 run_vmtests.sh
Message-ID: <Yqjk5qEvNk9l72P3@xz-m1.local>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-7-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601210951.3916598-7-axelrasmussen@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:09:51PM -0700, Axel Rasmussen wrote:
> This new mode was recently added to the userfaultfd selftest. We want to
> exercise both userfaultfd(2) as well as /dev/userfaultfd, so add both
> test cases to the script.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

