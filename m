Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2245E4B59B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354645AbiBNSPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:15:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243567AbiBNSPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:15:49 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB286541B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:15:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p6so10990984plf.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4m0gOAsAr4jyOr9i8hgFnMdzqZ06Ajs9U/QdjAOqRwg=;
        b=qjiQsn2jJvNT+rq0zVO9NuUFqoxHMBk03pxAesmzIDetKA8OI6X3BcPn6BaL4D6OjJ
         acsCBrKalqIIGz/ivIU7use+r3K+ZbLlxxqd96hcZxZCAjTjdtVUX7xWCVCGdPL0vKw2
         uXuVWi9oVtxhUIXOHAm0YLBzqt617gpA8HrYRd64Z8nqQgzrqpVPidzGLyMUlCH1RS4q
         fqlPegGfoi+laz4eugTwT5aVDnGpKXfxAR3pqWxiCTKzY/2nLASxrb4s1isb6uMNvkHs
         DLYmn0EtUe8I/eP/s99raNBz9s4CnSNotGAdg8aQFtiFI5cjkUG3IKD3E6wVKYA+417D
         8PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4m0gOAsAr4jyOr9i8hgFnMdzqZ06Ajs9U/QdjAOqRwg=;
        b=zOcznaRn9m05bnG+94NSvmBgkkPFls2KGHPDbMT9YKVhyWQz2zZcy029xtgqqwjnED
         6IV7wGv3EMP1SmSTlhSyXD9w30L63z1srXmV29Bg5+gg3w6I6wsaprYmXnvmGfJqRxj1
         +AIymXW8ys3JAh6RmrEXkdSgks6NNnuyZIphLNCHnSGKjGctBPeZjhvd/F9lSu4Zt5vv
         al3M+ZQjLZ+2q/YleNxsqNLMSLsNcvmWxXnjaYyS1Ws36ijnE7ZCcmVsqJcAbQlrrwqP
         79cdD86n1j237a29aSMFO12+5wVUZDeRYTvKfuzLs1Dkw3C9mfdY/RIvr6abBT5wcPL/
         a5Rw==
X-Gm-Message-State: AOAM532OzNTHH/mJhQ0CtbAxCdS4zs9SxyNyX5EKoIK2v6IDLW//5j55
        zjhVC5X6V9BbBMPwJw0wtoI=
X-Google-Smtp-Source: ABdhPJxOl/XAALjZCLQlN/kNUGO/2fbZAZ2oDtdz6SY05jbTypIyCRKx+A1nKoalW+vA+02+lr5qqg==
X-Received: by 2002:a17:902:ce81:: with SMTP id f1mr241490plg.164.1644862541508;
        Mon, 14 Feb 2022 10:15:41 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id nn1sm10600254pjb.47.2022.02.14.10.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:15:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 08:15:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] kernfs: Introduce hashed mutexes to replace
 global kernfs_open_file_mutex.
Message-ID: <YgqcSwrhToLXX5Cm@slm.duckdns.org>
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214120322.2402628-1-imran.f.khan@oracle.com>
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

Hello,

The patchset generally looks good to me but I think it can be split a bit
better and the locking helper code can be more compacted. Also, it'd be
great o include the benchmark method and result in the commit log so that it
can be looked up easily later. It just has to be in one of the patch
descriptions whether the first or last of the series and the rest can refer
to it.

Thanks.

-- 
tejun
