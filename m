Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35EF493AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354472AbiASM61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiASM6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:58:25 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA3AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:58:25 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id j85so2579824qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ljitelCOfpQzYv6XgO/xaPCtLhXUjN10ZeP+Ct1mtqA=;
        b=xZtoJmjKy9SyupAtRNIaKGXvdy8jemeJQpgTgSqnAqRSB5Q3ft8ObX/e9Ef81vuv5+
         sBbGS6/JBe2HO5rI5zcvxjM1bLuMz7yV2XOcaVB0IeHG0f0wm23WAULB3GuTmsTKlsb8
         1EtcQMemJojQeYaUKE8L/b7s13r/IWLK//vGT6MsPwz0c9YtpuLIMNcZHDSbWBRljy5w
         nL1LnXNqsR48P+3pDWO6egNKZeFMyLuLCv2s3P+CrLwGpgv2udMdYz0LafYXSgzYu5z1
         VottXP+dKRKbKLWVSZKrOh72L/dL3+RzHTrJiNwgalbKVduRkfjLQ0Aj/KvDSOdc1x9s
         qOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ljitelCOfpQzYv6XgO/xaPCtLhXUjN10ZeP+Ct1mtqA=;
        b=2doD09HqgKP/o4TNoyL0Rxi1nW8z0cwImApPb62SZU/LlTX51b7kDsjJi8powKkLKV
         GrZhAhdYVFJ0qB28IP6gjvp5eLEkljEiBoWGsCkj1+ou5fEMJpToc2wUE+Ye2G9OrWHd
         b0cLXhG9Je966WOQXfziWaFy4oA5uW0MPqj9BVrSLRqzkyBPv2ArUSf/lc5lsrfelCSB
         Ee/BFERLTlAvZoTjp5i65aDfxXF2cVTrm2dOTYCtlynz6BdOWYfVJlUYwIeHLb6W/YTW
         nZVLZZwh/px6p/psz+K70e5PMNnCNAWxYVtNlmlxVVGurapmkxU83gqXrO7j0lBSTyFq
         MjtA==
X-Gm-Message-State: AOAM5335jl0cFZQpAPDcmrTM6xTfWJcNNMZjOGG4W7W7092PGFzV/642
        +mbQ/CPIDSJwGBD7/Vjw1h0zifXD3WvDUg==
X-Google-Smtp-Source: ABdhPJwLORN/+MTxXfYIlaSR+5XM0UNw5NvRYkEsDblBY2pxwe2Qf1bjKa6295J4JQoX9goffwee+w==
X-Received: by 2002:a05:620a:2901:: with SMTP id m1mr7524712qkp.598.1642597104488;
        Wed, 19 Jan 2022 04:58:24 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id br11sm732167qkb.115.2022.01.19.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 04:58:23 -0800 (PST)
Date:   Wed, 19 Jan 2022 07:58:23 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     CGEL <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] psi: Treat ksm swapping in copy as memstall
Message-ID: <YegK7+oKFG8EPRp9@cmpxchg.org>
References: <20220116152150.859520-1-yang.yang29@zte.com.cn>
 <YeVdvVVBvrXH5U0L@cmpxchg.org>
 <61e7ac25.1c69fb81.e8938.bc67@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e7ac25.1c69fb81.e8938.bc67@mx.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:13:54AM +0000, CGEL wrote:
> I did a test, when we use zram, it takes longer time for ksm copying than
> swap_readpage(). Ksm copying average takes 147263ns, swap_readpage()
> average takes 55639ns. So I think this patch is reasonable.

Ok, that sounds reasonable to me as well. Please add the
PageWorkingset() check and resubmit the patch. Thanks!
