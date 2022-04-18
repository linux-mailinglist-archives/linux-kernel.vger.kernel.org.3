Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847CC505F24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347941AbiDRVOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiDRVOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:14:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1A72CC9D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:11:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w1so2721249lfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yW/Xtlm2DEmdlcKAJWnGvn+AxAEQ2Q/PaAl/FxXatQg=;
        b=JV/CeTBTDxZdIEZG5+RJY0irjC2pJax7Y3KJMpq7gZl5CU7YUloKLzx+QCW4CfmW55
         9Oz7lZ8Att8s3JZ/bA7bXUMRScOMu4tvhUofd85ED8UuFme5d2Huk3M4Ah8wra0pkiYb
         16GPSmTusg86p1fixswzzHNZPLMqwo08ove0Lv+FLpDgZc09NP4g8kUEY/v1Cv0sUbgP
         GbN3CPFN2x5EMoWTwAVB2JnFwE5zE/Y4rwXiyryhryWK+7QjFxp5/q39lHvHthnFgixm
         QyaGaHj2QubGxAf94ssvYNyqQyPb149btYKXQEACTGS+E+0MmmGLki1p1HnSSv3Q3mX8
         HdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yW/Xtlm2DEmdlcKAJWnGvn+AxAEQ2Q/PaAl/FxXatQg=;
        b=jkEmrSx5cn20RZfWG0cXm47ab+pzHclb+WficYPow6Q+N8qJVdwGaYUBIDVFz6CzvK
         ckbPJrCVzK2LFNncVd4O1Fp9Q/yWLiiZkMQvWcnFXTVdz3iPPnbSBQk2JWcK42c0sOO3
         RYuvA0Qlj7hpgmM0mbV1hc8RLniwI+fvgAooCh/+WTuHJdvqKRFZ6YvSV7w5PmxdGfk1
         XW6BxobztmqAF2xqrVzNFnt4BVJ0TQ4qvOij6YWzrQg50Lv56wYocbC1rp5lpE59fYGa
         GJJH2FMf30Ktl9iRFYiOAbV1sZQomEXpeuOfDtB6bXUXmrnifLQfp/fr09ampLaavxto
         S38Q==
X-Gm-Message-State: AOAM530tCpfVZZ827cv1oROXF8tD1Hc/BPGsQ5DXj/n3a77vHCPh3p1i
        hVGIHP8lmSy+ZSQJSE97fOE=
X-Google-Smtp-Source: ABdhPJwXuBbIcTDn0lCJ9h2jEXjyTyL7oT/gpzXMi3e722ZMsWgeAQypOZ2MzjKRMM+qs/5hId6dGQ==
X-Received: by 2002:ac2:491d:0:b0:46d:ce9:69b2 with SMTP id n29-20020ac2491d000000b0046d0ce969b2mr9001484lfi.40.1650316291694;
        Mon, 18 Apr 2022 14:11:31 -0700 (PDT)
Received: from localhost ([46.188.51.232])
        by smtp.gmail.com with ESMTPSA id x40-20020a056512132800b004489691436esm1319222lfu.146.2022.04.18.14.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 14:11:31 -0700 (PDT)
Date:   Tue, 19 Apr 2022 00:11:13 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     ntb@lists.linux.dev, linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb_perf: extend with burst/poll/doorbell latency
 measurement
Message-ID: <20220418211113.oxidrif4jtjlqr2r@yadro.com>
References: <20220417235517.26865-1-a.fomichev@yadro.com>
 <9ad57247-36df-cb3d-d50f-feb3c80f17e6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad57247-36df-cb3d-d50f-feb3c80f17e6@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 07:52:50AM -0700, Dave Jiang wrote:
> 
> I don't see any major issues with the code. However, is it possible to break
> the introduction of these 3 metrics into 3 different patches for easier
> review?
> 
Sure. I'll re-post the separate patches soon.

-- 
Regards,
  Alexander
