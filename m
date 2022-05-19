Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E34F52D2AD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiESMkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiESMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:40:16 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB6A4C40F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:40:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c22so4967016pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=Sdw0udIPioOfji8kMmxA4oMI1yBA0JfzsJKPjAhtAWA=;
        b=fo4nENJUvlgEzzuFBgAYKe8jGJnZGcjGdi+d7PZh/1eUhoJMLK+dct0fpOKT98ON7c
         ckJNtifZ9aIJAlsflqor63eM5daltNp6Lvr23K3p8icKJtNY9QFmrQAoWgfZ8Ea8XMq6
         ayDcCZJQzi/LqjlvX2q8NjZbmTzdQIGHEEaPYs1BXCkm9B5RwSYB66FYpQ3zroB8NmLq
         qVzHM6IJf12L78OWxAo/urjASdeOi2LBA56jnUcNdwA0OTcUTFWxqLhRYmLSquUagk/r
         jLvg/O3lamwOyHE+zI8z+ueGkO5WFKw9Q8dHgBpNuWYlmpfWtPsQptwy+MV4Km1KmAis
         yp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=Sdw0udIPioOfji8kMmxA4oMI1yBA0JfzsJKPjAhtAWA=;
        b=CMHlCd3v2MPngQhAz4MJtqeMDyT1CbMVPnA8nYLeLGJ6XQ1TF0oUoGq9+p69iy2SDU
         muTyfODyw/cXkteD65Qc5ywqSvzfXnOJRunlW00GAjtpWDiYJY2RLf/X8KM6W+s/HnQ9
         eGyw5dq2v8siIySlva5TdgXPup+jTdeiYAawRYYw10+RT1QcAtK7w22ub6B/EjVZDqfj
         MlIn1xYmCzB849v8bQkSJA7t2bgpej2EWXHhgJxthYZmxSrdwpS1daO9IuSfZ0hIiiKJ
         9MXhmsnLYK30oCOVDvUEbNDh+7RlGPG7NptmCrmtjh+EyWmGKMDAG3pOXfa9wPt0FS58
         WMGw==
X-Gm-Message-State: AOAM530F+Dc8XsoyLDYMlAkgF5+C0CkAKmKhdwH3ntl5c/2LVLr7cJnB
        qL/LduxQkymFm3CSqMkkmhx2DQ==
X-Google-Smtp-Source: ABdhPJxF82SRcAX2sgp+bKYASxaVBjIcM33UYVx0MJO9PwXKFxlJAjZ7huGY4gQ6/1VV3G74cD9VmA==
X-Received: by 2002:a63:5d22:0:b0:3f6:55cf:45aa with SMTP id r34-20020a635d22000000b003f655cf45aamr818358pgb.96.1652964013814;
        Thu, 19 May 2022 05:40:13 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902c7d300b0015e8d4eb2e1sm3572512pla.299.2022.05.19.05.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:40:12 -0700 (PDT)
Message-ID: <900f57bc-9978-9ba6-22fb-48f03fcf5011@kernel.dk>
Date:   Thu, 19 May 2022 06:40:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
To:     Hannes Reinecke <hare@suse.de>
Cc:     Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        sachinp@linux.vnet.com, mputtash@linux.vnet.com,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
 <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
 <fc5f8b96-3c93-5400-b917-a1d991cbe7c9@suse.de>
Content-Language: en-US
In-Reply-To: <fc5f8b96-3c93-5400-b917-a1d991cbe7c9@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 6:38 AM Hannes Reinecke <hare@suse.de> wrote:
>
> On 5/19/22 14:14, Jens Axboe wrote:
> > On 5/19/22 1:49 AM, Tasmiya Nalatwad wrote:
> >> Greetings,
> >>
> >> linux-next build fails modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
> >>
> >> Console Logs :
> >>
> >> [console-expect]#make -j 17 -s && make modules && make modules_install && make install
> >> make -j 17 -s && make modules && make modules_install && make install
> >> ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
> >> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
> >> make: *** [Makefile:1914: modules] Error 2
> >> make: *** Waiting for unfinished jobs....
> >
> > Christoph, can you fix this up?
> >
> Cannot reproduce with commit 21498d01d045c5b95b93e0a0625ae965b4330ebe.
> Please share details.

The kerneltest bot also reported this a few days ago, you might be able
to find the details there as that includes config etc.

-- 
Jens Axboe

