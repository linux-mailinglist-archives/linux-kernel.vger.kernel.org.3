Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578634D87B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiCNPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbiCNPGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:06:20 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302643EBBD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:05:09 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d62so18501897iog.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qv0ctZNGjuMHErRKtH6tt/mtgdEahUlvx8zamL6m8vU=;
        b=N9hg3BIE5p7LvVmg4KVrNn4kNF4vduTCaejUoJR5THfPLowx1GbE2zcgd8B1oR2XF+
         q16YhGN0YKjzlefONIgGLPQVIozelW4E1WTk7mtl2tGcyo3SgP8Lm21067k29RWYrQYd
         y6LIZ7xYrVc18j0ZtH4vq/OuAD1EbusnSkvv2XXjTpHAKGR3313nkVhtTOBAKqUMPz2I
         lOwAYit5E5TMDRcMGcYXarFbBG3W/3Uh3O/f+neDZFNrQQIIVZVk9r/ymBbFHMbfH7ix
         knIMP0wC8OvC7MSFewaX56XfovM0xy86wtIFRNxvsGCP+le4PxmD0xoYkGd7LMI04BVC
         G0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qv0ctZNGjuMHErRKtH6tt/mtgdEahUlvx8zamL6m8vU=;
        b=3MUad59ZchBRvYsDx3YFOnh5KAEqpSlm01YOy2dZml764qQi4LbB5//tGb0Vway0FB
         wzqqAIiihwRrOGUnvuT0aDHOra3/xo4EJ1pP4hcIRF6yQkJHs0IVARaG4BvDXqQb+8dw
         ndxE8yTCiv0S8KMeevdueGJrrERd8WPyAWMgYFnjA5nm6rp1hH8xsUp+uGY9g4WIps1Z
         lM6pHLV7+FjhUOe+jqKsIfS5fen4yvSuEZCC6zahEKkLUrMBPJSr5kmRy/YOMlYFPjrI
         EQB8ssfSSZB9jTLwRMz4hVikomshzlHv7IRVzvox5AN9Hs7btr9YzS6hZLYhBWRsxJ/v
         KF0Q==
X-Gm-Message-State: AOAM530svDVXGsjavc0HyE8iJcmrwzbT+F0xmfEVoAv6fDf9DfZxFjyl
        VV3h0BgJI2LNyp8uYt9J06+YtQ==
X-Google-Smtp-Source: ABdhPJy5i3gwDYd7vSs1vykIh+CiaOKmshYveHelWbXlHgFMTOzOBV14bFOfIjB2517O3ai/dZGfQQ==
X-Received: by 2002:a05:6638:2388:b0:311:d1bb:ed46 with SMTP id q8-20020a056638238800b00311d1bbed46mr21122474jat.212.1647270308486;
        Mon, 14 Mar 2022 08:05:08 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x14-20020a056e021bce00b002c7ada1bec5sm512482ilv.88.2022.03.14.08.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 08:05:08 -0700 (PDT)
Message-ID: <0d79b44c-d51e-282c-99a0-78ae6c9f6f01@kernel.dk>
Date:   Mon, 14 Mar 2022 09:05:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] sr: simplify the local variable initialization in
 sr_block_open()
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, kernel-janitors@vger.kernel.org
References: <20220314150321.17720-1-lukas.bulwahn@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220314150321.17720-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/22 9:03 AM, Lukas Bulwahn wrote:
> Commit 01d0c698536f ("sr: implement ->free_disk to simplify refcounting")
> refactored sr_block_open(), initialized one variable with a duplicate
> assignment (probably an unintended copy & paste duplication) and turned one
> error case into an early return, which makes the initialization of the
> return variable needless.
> 
> So, simplify the local variable initialization in sr_block_open() to make
> the code a bit more clear.
> 
> No functional change. No change in resulting object code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Christoph, please ack.
> 
> Jens, please pick this minor clean-up on your -next branch on top of the
> commit above.

Should it have a Fixes line?

-- 
Jens Axboe

