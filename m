Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222EF57E83B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiGVUUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiGVUUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1B4E6375
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658521214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0jFzOu3noKQ3ekIyZuGMBqCNF/GGgqTiHfncc0d2IE=;
        b=cHeL00HP/G0tZekpbgJL4ZkkLcwEuAJNTWUClqkLr7OHvTR5DKus1Ocows8WiszlzOdVYJ
        6USIhbDrjd2dVS0NE4dUuWqAhlO7frNVrxh3K/2xCzoj/j37VxGCyhHRmSBClm1gf/M/u9
        kesKiJuBkZdMjI4KwrtuHivQ/e0svG4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-1P1OA9R8O-qYSWSVB3t1Lg-1; Fri, 22 Jul 2022 16:20:13 -0400
X-MC-Unique: 1P1OA9R8O-qYSWSVB3t1Lg-1
Received: by mail-io1-f69.google.com with SMTP id t3-20020a5d81c3000000b0067bcd25f108so2221429iol.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H0jFzOu3noKQ3ekIyZuGMBqCNF/GGgqTiHfncc0d2IE=;
        b=JFIYt3Gb91Ci0IscO4CuZAcgqK4/xyklHWLxfJn/YsxgDQb5SOqpemHsYPVS1gN9Gf
         uf9sEDSegvATcQbG1c3HcN9wsF1GCZUiGn/p9nD9J4nbYkwyixijO0Wy+BUGkpP7kwq6
         vA9gmH0EQ3ZUain5VyEHrKIhP+GVx6VWfoQMFKxurSmId2ZF/Kcv6GbJ0qojiIOjW+8I
         DwphSYhLJHzRYNyzvUXWlzBpm89sETTciWeKeaAV824zZkDP5ycSn8tnncZDa1KPHMx2
         KIbuQcUBwf6Apolt58z8rEbWgTvw+ZgIZwM7LI5KHdcoR4nvFsx1ImeyT09UO8CWDc45
         aVaQ==
X-Gm-Message-State: AJIora87Fnd0rgPRtmL+FGgfUGNpbwxgLG1mqtKYBh2xFPw+Oob2zP0+
        UkhiHGbBukgvYkkD1QvXEPRgDCyPssYZ5h5sJZFLBxyBfyDt3vrCTEXcwcGNmbCUoAgb60SgZMx
        gxfshIEfFFj0ktca0DSs3I2H1
X-Received: by 2002:a05:6638:1643:b0:33f:7f6b:5e39 with SMTP id a3-20020a056638164300b0033f7f6b5e39mr763332jat.54.1658521212652;
        Fri, 22 Jul 2022 13:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1upOkUiAnvgRlyhd1ht9n2iE5lbMbPRpFTw/3s38eIjWF/HtEbLvCLsuMB1t/sncdC1jDJbYQ==
X-Received: by 2002:a05:6638:1643:b0:33f:7f6b:5e39 with SMTP id a3-20020a056638164300b0033f7f6b5e39mr763325jat.54.1658521212382;
        Fri, 22 Jul 2022 13:20:12 -0700 (PDT)
Received: from [10.0.0.146] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id k13-20020a02c76d000000b0033f21999e6csm2377807jao.90.2022.07.22.13.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 13:20:11 -0700 (PDT)
Message-ID: <d8dfa68b-00d8-9853-e2ba-57c2bb54c05a@redhat.com>
Date:   Fri, 22 Jul 2022 15:20:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] xfs: Fix comment typo
Content-Language: en-US
To:     Xin Gao <gaoxin@cdjrlc.com>, djwong@kernel.org
Cc:     dchinner@redhat.com, chandan.babu@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220722193624.18002-1-gaoxin@cdjrlc.com>
From:   Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20220722193624.18002-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 2:36 PM, Xin Gao wrote:
> The double `for' is duplicated in line 3788, remove one.
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 6833110d1bd4..6f6d87ba29a3 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3785,7 +3785,7 @@ xfs_bmapi_trim_map(
>  		mval->br_startblock = got->br_startblock +
>  					(*bno - got->br_startoff);
>  	/*
> -	 * Return the minimum of what we got and what we asked for for
> +	 * Return the minimum of what we got and what we asked for
>  	 * the length.  We can use the len variable here because it is
>  	 * modified below and we could have been there before coming
>  	 * here if the first part of the allocation didn't overlap what

NAK.

The comment is correct.

