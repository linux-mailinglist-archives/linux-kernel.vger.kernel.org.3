Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39076510A95
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355017AbiDZUgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355010AbiDZUg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A4C11AB8D5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651005193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Av2XJWYSmxJiVQjp5kZR1hfhT+pdVskMA4VQgdFQOaM=;
        b=WK9VxpmjoLLrOX/Z94nx1NOwSqYuPD0Yy/ZDXQDXPjHYre1pneNPBH0Hauo0Y0QWpGvTMb
        +K4zJNZYPIhpKXbzbgtxr2VRbkT9VR/kKBbD8wAeyRO3uTBOSr+R6v9VOtV+ttKZXF/l0E
        10bXil0mPPSh/OJtaTuyPSU4bMqq85c=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-HC9fj3zAOey-BED25hp_Vw-1; Tue, 26 Apr 2022 16:33:12 -0400
X-MC-Unique: HC9fj3zAOey-BED25hp_Vw-1
Received: by mail-io1-f71.google.com with SMTP id i19-20020a5d9353000000b006495ab76af6so81415ioo.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Av2XJWYSmxJiVQjp5kZR1hfhT+pdVskMA4VQgdFQOaM=;
        b=exrxsVQPDf0/xOcm34AkwgQ4WOlOk/TT6z8pweCeojWRFjhdGjgAyp+I+M1/i4QCRU
         c//WRiHzilK+btXkUYOXhZSWORG1QqZUFDNRRLBUBP+SDt5PM54t8Pe4EAuJPmHOYtpW
         YbC+EgaVS0BY7voP6xRSE49tF15vfyVoXxgqNcXsuugX5PSzWxQH4vvKsK3qHO7RVaab
         xGLS0m3f+rgOCFvLgMJUUh2L4xARXX7OGDLk/EsXqBo4WhZ2N7tVXkoiQ2XlQCfr96d0
         pcq+byXSgtmlls8Pv4of80WpZvXm8CS6YyALO0nOtbcsQISuLAF/ldMGgkyaWkQoSptb
         WUDw==
X-Gm-Message-State: AOAM533vHK1W1vvSs06NyU1slPK5BKNSGi/+xMlhGF+Ks1cb/tyVUoJv
        27j12l7OSGQ3tBuSS04E21c+ZRz9k+I2PXPvgKZu294MhgDD5EjxaOMYbuyaRBEW+oCgm/zM3c0
        XPE/56z7BWMrYbEdGKNyUx/SU
X-Received: by 2002:a05:6638:272c:b0:32a:f95b:fc77 with SMTP id m44-20020a056638272c00b0032af95bfc77mr4011882jav.179.1651005191544;
        Tue, 26 Apr 2022 13:33:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd4CFNten6nl0jATzOU1yCBTY6Y58j8Espgob7sbvIFYcRfIXeg+IqFoDNsZPO7cKZaJ3nww==
X-Received: by 2002:a05:6638:272c:b0:32a:f95b:fc77 with SMTP id m44-20020a056638272c00b0032af95bfc77mr4011865jav.179.1651005191365;
        Tue, 26 Apr 2022 13:33:11 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id e18-20020a92d752000000b002cd6dae980fsm8497051ilq.13.2022.04.26.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:33:11 -0700 (PDT)
Date:   Tue, 26 Apr 2022 16:33:08 -0400
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
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/6] selftests: vm: add hugetlb_shared userfaultfd
 test to run_vmtests.sh
Message-ID: <YmhXBHFrXKT/Jqkd@xz-m1.local>
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220422212945.2227722-2-axelrasmussen@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:29:40PM -0700, Axel Rasmussen wrote:
> This not being included was just a simple oversight. There are certain
> features (like minor fault support) which are only enabled on shared
> mappings, so without including hugetlb_shared we actually lose a
> significant amount of test coverage.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

