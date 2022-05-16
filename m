Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC70528D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345147AbiEPSqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345133AbiEPSqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:46:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073293A5FB;
        Mon, 16 May 2022 11:46:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id bh5so3492775plb.6;
        Mon, 16 May 2022 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2pjX9hOL1SP4Vyyi9JgJUjFRgviNJxEws7hy+EnHvM=;
        b=TPUV128Bqc8Lp2KlNU/4k8JVfaNRh0+SRpFtG0T6X0A9QO5TVp4wksjKTqH7qJ6h/k
         g+YJMm4YRFqQl+LkVWRS72LSVkfj9aXfmOpMfuNw++yDXk1fsjYjj4QGI7mnOrrAElTf
         SnWHqa9VfpEjZnF53BzrLrwftACFyUiS4CTTVbrFSL9ORVpVOGkbmwBv2Fh4LZU9loy9
         K9CJVpKXNCtEWbGynmi+VwSdfZm/khWGaZIiudffG9srFSvqtiEpLO0ttob6kxdFCeRa
         iM5z9sS7tfEGqYjCtgrn3as5LS0V4tVzz6u/rap7DnhXl+P4k8oJRMFg+W/zkuljG2Tv
         c4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Q2pjX9hOL1SP4Vyyi9JgJUjFRgviNJxEws7hy+EnHvM=;
        b=TqhstzoZuzkILe2iod6ismWNNf8Ai06/fDXtW7cpYsKUDC3B1CsWopEKuUBstrN5ym
         N50ggMJVhtwypyBEX6xRVpKXu1yf+VzlctD0u6usLQi4qbe7iiVf/ML5wrNl7U1KGYSl
         6WuVnxqzoqJvvP8Jq/Ww/TLiIrs/jPoLLjg9Tz79wtf/wUYErAuJj0zlUg1Ml+fdMoTt
         bQfzxTQmQ/TtgMYZqOfAw2I1gDK5fOQlZB9wN6PpMg6MrpGKE132PkKdKzlhma3nWS0U
         uYazCQ3/87NlbyvxyYBVxxWd+T22+KG545XVN5ipPmmBDhW+h5prFXqzw8kNnZZHN0O8
         ISag==
X-Gm-Message-State: AOAM5336HbAm2kMAKflKYIRHS4FZ5SX9rCW9YyWlQOtrmncpOrlrhKBc
        UC/uAiTNdWdeqV1aOOhUVZM=
X-Google-Smtp-Source: ABdhPJxPyVOJDYm/TchnhmmiNYcjTqQOqSC+zIoIVkBIs2+L+IkTuhublfxsXjiZe5eLST+BoBB4eA==
X-Received: by 2002:a17:902:ef45:b0:155:cede:5a9d with SMTP id e5-20020a170902ef4500b00155cede5a9dmr18737268plx.93.1652726769388;
        Mon, 16 May 2022 11:46:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id 9-20020a170902c14900b0016168e90f2csm3454145plj.208.2022.05.16.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:46:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 16 May 2022 08:46:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
Subject: Re: [PATCH] blk-iocost: fix very large vtime when iocg activate
Message-ID: <YoKb7wpkz3xoCS6s@slm.duckdns.org>
References: <20220516084045.96004-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516084045.96004-1-zhouchengming@bytedance.com>
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

On Mon, May 16, 2022 at 04:40:45PM +0800, Chengming Zhou wrote:
> When the first iocg activate after blk_iocost_init(), now->vnow
> maybe smaller than ioc->margins.target, cause very large vtarget
> since it's u64.
> 
> 	vtarget = now->vnow - ioc->margins.target;
> 	atomic64_add(vtarget - vtime, &iocg->vtime);
> 
> Then the iocg's vtime will be very large too, larger than now->vnow.

It's a wrapping counter. Please take a look at how time_before64() and
friends work.

Nacked-by: Tejun Heo <tj@kernel.org>

Again, please spend more effort understanding the code before sending these
subtle patches.

Thanks.

-- 
tejun
