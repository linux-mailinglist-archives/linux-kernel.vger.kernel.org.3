Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7276F537722
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiE3IZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiE3IZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:25:50 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9742170366
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:25:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b135so9953673pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jZI6WVqWeYgtBaY+QfPTn8jMgzc1eYPXPJ030wAMSgY=;
        b=tu7dZq2fa+/+cBLFAnJ9WpUxgjW8BRP2wCO8KDg6zJ1sVpv8ObnsyOCZomVzCE51WC
         /YN0WtyzjKOn0odpnTxPx3Y1g3wSZjCQgjqH1Q7vKyRydmS+yt4x5g+wwUkM0oMnf9be
         Tq/ffy+Girj1TD5MBIFw0jF5vPqCt5Ik7S5lZ3TDrMxbxXWkT8iHUq8yMg3/fNASr7yk
         cJql96YDFQv3N7/rMm1ljSrsArm8BFpK3LJ193qpGoUmqP4I1PgnaQW53/yf+jimyTcg
         Bcrpdd3nbjgbn5KqW/GDNthbWmTNZyxnL13r9IsbId0h+N5qq0gMnqpVP3fdTbiO3q5o
         +uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZI6WVqWeYgtBaY+QfPTn8jMgzc1eYPXPJ030wAMSgY=;
        b=N1Fvs/AMCj+W6bTxpXe/xqToZFUInUkPpurk41JkGVvwC+25KSFiEkcUAA8sOyyP4P
         6Zh1rQP5S8eAECSOBQ2gQxuyb/wq6wsLjgc4Sl41/RgQ6wHjRazJgCjA4+Rbs+qytooo
         1SprQanOhHj2sGfXIQKLDRxF+F84d4sYGspo3+AAclvr5QjNQdJCZg8iB1B124l8vM6K
         n4XdH65y/dCCtqcjFPEZ6y2WrSiVKb77sBICdl7PkiVyhG7d1RI66nMtbcN8jGnJA4O7
         zFVelwbmyEW0a3r4y0IilUt4Lcp/zKJZJrDFO6gxtO51eixkdZ7VoiHNWc2tWA2/hMR5
         Pb5w==
X-Gm-Message-State: AOAM533auDIEIbRgIRykFTfEGCKlpDzV7Uz3neScZBUBrFZRfzBZTXcI
        JF6Vv4pk2AO+2N5c8qAxGsxfgg==
X-Google-Smtp-Source: ABdhPJyRh6+exQcNpjgCh/yNzciF9P0YOK/KwR2+UV9+M85WLLazzyvmZ5Z2lQA7LawDRMZ1tQbW+g==
X-Received: by 2002:a63:7781:0:b0:3f6:2c8f:5c75 with SMTP id s123-20020a637781000000b003f62c8f5c75mr47260605pgc.358.1653899149165;
        Mon, 30 May 2022 01:25:49 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:2071:e13a:8aa:cacf])
        by smtp.gmail.com with ESMTPSA id f66-20020a636a45000000b003c14af50603sm7927993pgc.27.2022.05.30.01.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:25:48 -0700 (PDT)
Date:   Mon, 30 May 2022 16:25:42 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v5] tracing: add 'accounted' entry into output of
 allocation tracepoints
Message-ID: <YpR/hl6/Fk/vOVKa@FVFYT0MHHV2J>
References: <c7f687a8-637c-b119-6e3a-7dacc885b851@suse.cz>
 <80bcb043-3782-1d81-d8a2-4bdcb213cf30@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80bcb043-3782-1d81-d8a2-4bdcb213cf30@openvz.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 10:47:26AM +0300, Vasily Averin wrote:
> Slab caches marked with SLAB_ACCOUNT force accounting for every
> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> Unfortunately, at the moment this flag is not visible in ftrace output,
> and this makes it difficult to analyze the accounted allocations.
> 
> This patch adds boolean "accounted" entry into trace output,
> and set it to 'true' for calls used __GFP_ACCOUNT flag and
> for allocations from caches marked with SLAB_ACCOUNT.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
