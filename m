Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55EE547DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbiFMDUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiFMDUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:20:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D7A1EEDE
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:20:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f9so4057921plg.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sD+wEeeDUuWjiEZEpSAVrk/+oUE3ulp7iwoi3vr2qwA=;
        b=I7KySNEwwNkflzRCurJxZSIERXD213KH4yfORFp8cllYzu/zWBgp13YY+rVyoO84IY
         Rl1piQFo+gkhA9a33FkQP9FcpOFLXsfz8abtMZPn+a9q5RytB8yRbW6wyx+c5W02ZNVB
         3sL0wy3Ne2G63rStOPw6WQG2pIY3t4FVEWXfUjiyIlq0LidLVf/UBr2/6GTqA+JKVp8Q
         CEX1sj39aseeU858SRw4AkKMNHRMqK4ULq9skWlSGbqNi55ld/i3f6kSZH1tEnLxrmTl
         CTibdEjSD5AU2ANNGCpIMxam2IyMLgzZRBDfWpmQuIHKX0Em4HIZXiQqGIAm6GvUZ9rG
         gKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sD+wEeeDUuWjiEZEpSAVrk/+oUE3ulp7iwoi3vr2qwA=;
        b=QBD0vJgoWBqKGQyPzU14qdfb3ayC4exZuMMow9QoJlEf7VcKPqTHD/o6WxBjvXF9Z3
         wQoPXixusDqtADnQz2Mzt7/9KK4THAGlV3As7AgY/UQt/dAxU8NeYp2ZWrDiFs1XiL8r
         NQBBPsmcJAEZAcpybNYkn9W6XGirPkAv+CRe6/jTX1HRmXWEGjNitg7TdDcfVAEBOqI2
         UGchKrT1uPwBxQXembOufeXFCpDA8dh0i5aV3Y4TvnVgcxpargBkj77UetNRR5Vss4BV
         DLWx4jIn/svJGEapUTZvAeaQCPfdIuUwJzo0+RfOT5/gjYPb3bvsJ5PcgZ89rj4LvqP1
         ay7A==
X-Gm-Message-State: AOAM533kIbkHmqrwQR6+OGMoQrxk0eyQUoHch0g7NitSx3QP5a4Ebr5/
        alFR97N2doOvtfIbh/l/cb20YA==
X-Google-Smtp-Source: ABdhPJzjwQenaRuYZaCEmTrsp8EZH32fUm9zRAj5ZntcVLdm5bPVTg4jSxQw0TypunSXnB38ck6KpA==
X-Received: by 2002:a17:903:11d2:b0:167:8a0f:8d33 with SMTP id q18-20020a17090311d200b001678a0f8d33mr34288876plh.95.1655090432196;
        Sun, 12 Jun 2022 20:20:32 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902988300b00167838b82e0sm3760411plp.205.2022.06.12.20.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 20:20:31 -0700 (PDT)
Date:   Mon, 13 Jun 2022 11:20:28 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] mm, slab: fix bad alignments
Message-ID: <Yqas/Pwm92CVN30j@FVFYT0MHHV2J.usts.net>
References: <20220609040132.89192-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609040132.89192-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:01:32PM +0800, Jiapeng Chong wrote:
> As reported by coccicheck:
> 
> ./mm/slab.c:3253:2-59: code aligned with following code on line 3255.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
