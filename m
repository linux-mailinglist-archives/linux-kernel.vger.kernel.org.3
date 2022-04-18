Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A5C505BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345882AbiDRPvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345876AbiDRPux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:50:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912D1C90C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:29:14 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b68so6634471qkc.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bk1eGuqJwndoaxsSvNYecRXq6M9A/bw4S/fhOCK+UVc=;
        b=7F1UZiOfTJRn87TwUEurTc5P9PUWSoCZVGAWHNHavR/bXr65b7KljKF0kk1dwg8xtX
         FV2/yylNEvwEn6tcML003t9HpMDMOOawvHFcZTPEutpToRtbZWi+UaQk8xQzv04nizSZ
         z3nZfVkKDQV81BL2ItSAoeePcPWD9Qg2Z5i1WBFyGsUhAVxc3pB8JbhNF1jOIXOoaiSH
         8HheabbU4cpxESbOeAge9Vh2k/fJ9DIqUXhtwrgrXor14veeWkLZs43ptPfI6ZunZrcv
         K8Veoug7qzQGyJ7hZFDpX7uKERtiGsdL5XFq9Tcp9XHLPVDqm4ABNTRKMLETwb9l3kl4
         VlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bk1eGuqJwndoaxsSvNYecRXq6M9A/bw4S/fhOCK+UVc=;
        b=SCS2mnsE4jaBGF8mhT9BwEnHAgQguCRFLygrYaxbB0TVd5Ndi3uvcbaHSUDCjtMFdo
         8Tm9UsopDmAILCn1BSwC7anoWwbSgaF4oYhJvATuMFRxnTvLRtxCGk6blfAu06BKkjI7
         RrZ4qvYcgwHlqRjppG8f2K/ufuC7Aauln9dB4q5O0m/f3u00vp5phDN/TQd1DvxabU3w
         /tRE1CnQVhuX+E4DyMTuAiVzIa6ztwmRHjeMGriwOrw14AFIjThf4HXVW7LYANBd5KZG
         CVYwr2G3+j5JDsFCFUN5myNvVdSHu0LQhdGVQfwlN9KVdcDnXSxTWre/wOH4rtawBE78
         YWJQ==
X-Gm-Message-State: AOAM531bL4+cGgvq8Vou1GlZDDqOfLlzF84euFNmusTDjmwqaupT+8Lc
        tqs4KXpRLPGQCrwi/NdRoBo2Hg==
X-Google-Smtp-Source: ABdhPJz/YKZah8C+U0YgIVsCTc14vr9OwHpssgyFke0VAkIsnTf4JBHSdxL1MhhT+PHSqXV7HFH79w==
X-Received: by 2002:a37:b502:0:b0:69a:ca1:298 with SMTP id e2-20020a37b502000000b0069a0ca10298mr6942704qkf.133.1650295753354;
        Mon, 18 Apr 2022 08:29:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c17-20020ac85a91000000b002e1dd8ae44bsm7800323qtc.29.2022.04.18.08.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 08:29:12 -0700 (PDT)
Date:   Mon, 18 Apr 2022 11:29:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, Schspa Shi <schspa@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: zstd: remove extraneous asterix at the head of
 zstd_reclaim_timer_fn() comment
Message-ID: <Yl2Dx+jefYs1Un+8@localhost.localdomain>
References: <20220418125934.566647-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418125934.566647-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 07:59:35PM +0700, Bagas Sanjaya wrote:
> kernel test robot reports kernel-doc warning:
> 
> >> fs/btrfs/zstd.c:98: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> The comment is for zstd_reclaim_timer_fn(). Since the function is
> static, the comment isn't meant for kernel-doc consumption.
> 
> Remove the extraneous (second) asterix at the head of function comment.
> 
> Link: https://lore.kernel.org/linux-doc/202204151934.CkKcnvuJ-lkp@intel.com/
> Fixes: b672526e2ee935 ("btrfs: use non-bh spin_lock in zstd timer callback")
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Nick Terrell <terrelln@fb.com>
> Cc: Schspa Shi <schspa@gmail.com>
> Cc: linux-btrfs@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
