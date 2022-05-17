Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28752A857
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351091AbiEQQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351081AbiEQQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:42:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35136403C3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:42:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d15so32312753lfk.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X+ZIsvVjUuwlh/wMsd673AwYnSIKugcP1RnbxXgeB7M=;
        b=V8osDecpKG1CjUJgHbXhszmxjy2U6L5nGE72cpZ9wzdBseZt01yt+Z4mmHiEAt594M
         BNqhFNGWjAm8E9llNlZJhF++9DHOQfxrAZVLSUa3Axy8oqQ+ReQqs74mJBVZgyQZa4lT
         qOpPZirzW3loPIh1wPdjoJshtTrfYXMGx/KgiEQMCw5CVv0fVVqc0R5kTe6xea1aoeRo
         UCxDV8YnZi0hgkTAF5f38w3ARVMhSRvJbZt0TIhplhn9V70cOcfuemjsVkA+vfLl5GYQ
         fnELcWbYh9v4jj6y6/n6LCNH9i8RWUqtgra/HnsQkQlsOI8pNTwR4uTbKE3aFuawAaZl
         6jVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X+ZIsvVjUuwlh/wMsd673AwYnSIKugcP1RnbxXgeB7M=;
        b=6i6kPYZ9xaNRX6NNTBzl2SJO+6CJzpvBRjDAH6wQogAVG7Zbg1+0DIGtVNz8SX/BVM
         J7HhexbuiRvFsRjjQLWIl0+5ZDFkhvKFZvzOKwfeLYdzL6XzeF9iRPgWBJ45MGodtmIY
         aHzjDKGxNQ2I6iBzdHdgY2TDth7VH8/KhZnauqZwPG5/ccvFTwfSHpod0MQchUFg/qy5
         a2Wd2G/S2tTiFqvojl4++o9qVYgLYdpTHaz06dfAX+vMXWluv6hYl3EZGBUz5VnAfNrQ
         eBkNRrh/R8unHHLyQ1Qy5c66dY1+20VmUL+2idrEb6g1KeBkx61yuAOXI2jFRqIVBpGB
         WNAg==
X-Gm-Message-State: AOAM53118vfqW0BLOrzhImYSi7jfx4cYMKnEBFRHD0gjh64UnQVPHkFH
        zfDkv67Vh2jhsTdYIamYeaX/aA==
X-Google-Smtp-Source: ABdhPJxmKZP+YUmR4TA93TjSj+0oUrnGYJTJhLZ9zVqZmhZg9tbge+VD7odfkhYj4w2QPj6YTGDhpQ==
X-Received: by 2002:a05:6512:4008:b0:450:bd56:50b3 with SMTP id br8-20020a056512400800b00450bd5650b3mr17936796lfb.552.1652805732538;
        Tue, 17 May 2022 09:42:12 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a2-20020a056512390200b00477b38eabd1sm6624lfu.94.2022.05.17.09.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 09:42:11 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 74B9F10453E; Tue, 17 May 2022 19:44:03 +0300 (+03)
Date:   Tue, 17 May 2022 19:44:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jakub =?utf-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, riel@surriel.com,
        rostedt@goodmis.org, peterz@infradead.org, david@redhat.com
Subject: Re: [RFC PATCH v3 0/6] Removing limitations of merging anonymous VMAs
Message-ID: <20220517164403.nabrtbkezex7uof4@box.shutemov.name>
References: <20220516125405.1675-1-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220516125405.1675-1-matenajakub@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 02:53:59PM +0200, Jakub Matěna wrote:
> This is a series of patches that try to improve merge success rate when
> VMAs are being moved, resized or otherwise modified.
> 
> Motivation
> In the current kernel it is impossible to merge two anonymous VMAs
> if one of them was moved. That is because VMA's page offset is
> set according to the virtual address where it was created and in
> order to merge two VMAs page offsets need to follow up.
> Another problem when merging two faulted VMA's is their anon_vma. In
> current kernel these anon_vmas have to be the one and the same.
> Otherwise merge is again not allowed.
> There are several places from which vma_merge() is called and therefore
> several use cases that might profit from this upgrade. These include
> mmap (that fills a hole between two VMAs), mremap (that moves VMA next
> to another one or again perfectly fills a hole), mprotect (that modifies
> protection and allows merging with a neighbor) and brk (that expands VMA
> so that it is adjacent to a neighbor).
> Missed merge opportunities increase the number of VMAs of a process
> and in some cases can cause problems when a max count is reached.

Hm. You are talking about missed opportunities, but do you know any
workload that would measurably benefit from the change?

The changes are not trivial. And rmap code is complex enough as it is.

I expect common cases to get slower due to additional checks that do not
result in more merges. I donno, the effort looks dubious to me as of now.

-- 
 Kirill A. Shutemov
