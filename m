Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B44E2691
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347425AbiCUMd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244914AbiCUMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:33:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90FB887BA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:31:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d76so892933pga.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Lux+Oce5954ZCR4SaazZ6s8iSwpkGBWeDb8gTfwBZqM=;
        b=VrY4yTDBoUuWUPRu7aAjBfZBak2f/Vf5gOla5mUSXo8iqCal7uXrULn3rX5d+D2eqK
         MFMAh1iO1clvFctmNChOz7kBBggbO0xgsjYcS59nhB7OG210nPjHe+FZ9BYkN8lfwvuQ
         q4T162hV9jUxUzkjRdxKZ9orkKEC+J/BinC4wuDSjMApJarYj96Vg9omJdBG/2ptTgMk
         mX5YH2Fa3yF5ePKcqiS9uD2wFF+OhdfbXWGoTp04bTy8GUHOqq1QFtfFPYVJOgRDsELa
         utUXMG1apjvDJU7Z9Vlhkp0fsM4L83eAiC3r2/Hg88DU7cXjuRZbOJVhMvCN+8vRONfn
         9qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Lux+Oce5954ZCR4SaazZ6s8iSwpkGBWeDb8gTfwBZqM=;
        b=JYmRkO6G1+MNguAdacVXxOyUvSS4PZ23srHuvTI3rFBlTYM4WGtwocgn0VbZaUQv/9
         AhdiXo4eZCNjQLCQMREn2iYIjZP4WCvueRjjMTrkvm5AwCFbelJs6sTC97woxa1GhQVQ
         pgg7tudluG18jcPMANU5CUA2oZuN86yC27FBLjcCtXfcW4IO9TbqpEE9Vspx2uAHzlfn
         DqKzLyRqZtXBiO+UvcoKMRddNtCJVL+5SafPWYMbLnoUHXbhQvbplPrs95bt7DZA43F6
         8bAuibtQ5lSJwOEWXDovBMNQqgD2WqDcJz/A2iAGXb7lM05cYdLE1PImsE20W5fKf38Q
         s+Vw==
X-Gm-Message-State: AOAM531AEYnZO9/kcpZYiPwtd44tS1xwCbWN9YH+gTbQ1VlbXAPVLmTO
        jC9Df1YCHz+PCGP6Bv+EwweylA==
X-Google-Smtp-Source: ABdhPJyHp8/6kKFBxi4tI0DjZuF7CfbyQs3okZ47Jb114AtRRldFRxb2PaEGX7OOzdRY5sldVEnNuA==
X-Received: by 2002:aa7:8896:0:b0:4f7:b8f7:772e with SMTP id z22-20020aa78896000000b004f7b8f7772emr23053440pfe.62.1647865917359;
        Mon, 21 Mar 2022 05:31:57 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm5277920pfw.144.2022.03.21.05.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 05:31:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org
Cc:     boris.ostrovsky@oracle.com, roger.pau@citrix.com,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org
In-Reply-To: <20220317220930.5698-1-dongli.zhang@oracle.com>
References: <20220317220930.5698-1-dongli.zhang@oracle.com>
Subject: Re: [PATCH 1/1] xen/blkfront: fix comment for need_copy
Message-Id: <164786591631.5804.10829961862244970151.b4-ty@kernel.dk>
Date:   Mon, 21 Mar 2022 06:31:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 15:09:30 -0700, Dongli Zhang wrote:
> The 'need_copy' is set when rq_data_dir(req) returns WRITE, in order to
> copy the written data to persistent page.
> 
> ".need_copy = rq_data_dir(req) && info->feature_persistent,"
> 
> 

Applied, thanks!

[1/1] xen/blkfront: fix comment for need_copy
      commit: 08719dd9176b4c55f547bd11812fd6cc35907d37

Best regards,
-- 
Jens Axboe


