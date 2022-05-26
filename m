Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37096534B27
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiEZIFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiEZIFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:05:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C854703CF
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:05:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j6so1066533pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3psjBSGgC1oExnNsp07wwRuETMxZV3qvegd5xVUvf9c=;
        b=Ap4l4bH+BpN7s557ReRTxoFE/zD2epm8UKZmh/WvO8NnEf8AfPsEerAxKdXW+k/Of2
         T3E5ZZjjzc9XAZ+FQG1C49204zsb0NxQ4cnkYDDf99i7l4MDZ6hu7DweqNB0FP9BZQpJ
         RRBlTGMtvAENKUoAyI8vio4tN2nPemYvWA+I87dAmdHQeEVwWpPQ05yQMt0Q04zt4PhY
         y9tgwCL9L21D2g0oPXCZyKgthrKzjyOtCRGTqGuOFFEujTO+EjHwevSQ9M16xOKnaU2V
         uOcUSK6Dbn6diH6lQvYjesq6iCJt/sb0JfaFhOq0eJ00gtkRY+3mFnCuT4sGz2Ac1HgA
         mvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3psjBSGgC1oExnNsp07wwRuETMxZV3qvegd5xVUvf9c=;
        b=CNIb9HeS3N9letBY/dUpZUFu0WAUMjVxr9qGykaoz7BuMFv6lTRIkyIK1kwjhB5omT
         dwtOchosYOCuIyozNvE+Hne8Vej+K8ij+bJSoU/Y/FqVx689Y+MadDHy3/zgnBHSfG4P
         8Oa+y8ImNQjTuC2kRpJg//f/dgrTc4edBFGGKVqf1Hf+FbeVK1Sc9BN0EB6E3x6lTZ29
         njWXTMixAOcu+7sw/WaE/W28N+LZCJ99tO8wMVZtfdvxml+z7nAUsqtZ36WfxXmZ4BlC
         VJvVBqgcylV6FxQkCRFBsTZCZIWmdRtF2OSbpkXx7gzbFqc1bq6KRhypcdmpnUKcDOeH
         U47w==
X-Gm-Message-State: AOAM53300ojCO7uNbdb7pldTE10m9Xs2zJRL82X1hehJEXlukkn3nfBy
        L9fM5ETR2wiqB4zRbPCArINzIg==
X-Google-Smtp-Source: ABdhPJy5A3/WGs/5H8dWp8K9IS0QnGZVGwzxfs2z9rFqj13cxMW3H2CRGt2MfnTa2JmiFFMhiwQlow==
X-Received: by 2002:a63:254:0:b0:3f6:5fb2:d75d with SMTP id 81-20020a630254000000b003f65fb2d75dmr27617838pgc.132.1653552347173;
        Thu, 26 May 2022 01:05:47 -0700 (PDT)
Received: from localhost ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902f08100b0015eb200cc00sm777236pla.138.2022.05.26.01.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 01:05:46 -0700 (PDT)
Date:   Thu, 26 May 2022 16:05:44 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm/x86: Remove dead code for hugetlbpage.c
Message-ID: <Yo802Ae85Ui0I5WZ@FVFYT0MHHV2J.googleapis.com>
References: <20220525195220.10241-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525195220.10241-1-peterx@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 03:52:20PM -0400, Peter Xu wrote:
> It seems to exist since the old times and never used once.  Remove them.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

