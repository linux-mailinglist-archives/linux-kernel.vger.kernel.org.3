Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540EF518963
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiECQOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbiECQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9DB41EAD4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651594278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wp9YHmXDYvM0vTO+lxeqnR+ljJmF4tJFHnGldB3QeSU=;
        b=KV+iCsZrOzhbduvirDB7peZOcv31XrhO1V+6Do33dz88wlWwBi6aUr85NKYDNQ3SumWk2X
        0kYGN7b5RCD5nVeNYsL6YFroe1c8CJQZan8jFafcF2txyMlij4icweqwQdoA5quW62itd7
        9zko9at3W/cf0Ym+HlfcrKOCtOeOFNk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-9cflrM2mP5i4nSbSCi5DcQ-1; Tue, 03 May 2022 12:11:14 -0400
X-MC-Unique: 9cflrM2mP5i4nSbSCi5DcQ-1
Received: by mail-qv1-f69.google.com with SMTP id p3-20020a05621421e300b004562c4a6b08so13614387qvj.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wp9YHmXDYvM0vTO+lxeqnR+ljJmF4tJFHnGldB3QeSU=;
        b=AMDKlFoeyO0ivAu69t4TJxT6+tqxvPdtMuzXUsTHwz6LkwlnDkSARV4rMzjoGKt72Y
         VSMX5aJZdmPbNLZ+jGfQrcxi9erojkyW1n6PFlivUPD7ZeElLN4HSeTxHqeQcYf7f5rF
         WFz2dqhMfsUWWWH+JDVAUe17/XKapZtQs9cDQlEZnnM8Xw7RQyCmpD22sSMc8Z4mjVT0
         WryUddsgNW+drFuQ7DV32EQdAw2LMgcZ92ogR2xHXOU28F9BCACS3vGHb131UdiuX3eW
         KlVW/zRDUvOvXXkW5zi+JEKf9ak2KV0S9TOzv5MVFnu/jua/uEpoOCVpAVss6DgpyydK
         Sv3w==
X-Gm-Message-State: AOAM531yuaAwz/hvOyZtRK0eBQPB0tnnOkjG3/SkCLJECji/CBK3AA83
        /mevhBo1MAIBBf/rIKMvM+iXwceyfJA1OIpxN0zZl7k1w645606flWt8TZnEX//pPbE0MWNu7dG
        i+OG2+aqmiw+mAPjf/owLjM+P
X-Received: by 2002:a05:6214:1c8a:b0:443:bc78:25ef with SMTP id ib10-20020a0562141c8a00b00443bc7825efmr14197041qvb.2.1651594273450;
        Tue, 03 May 2022 09:11:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9Rhyqa7jIDuuJrIMnnrirw3u18xc4X+9oWAePPIds5Soeh/PXfrbwcmifKRoacw+7Ubd3rA==
X-Received: by 2002:a05:6214:1c8a:b0:443:bc78:25ef with SMTP id ib10-20020a0562141c8a00b00443bc7825efmr14197011qvb.2.1651594273166;
        Tue, 03 May 2022 09:11:13 -0700 (PDT)
Received: from x1 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id f22-20020ac84716000000b002f39b99f679sm5846102qtp.19.2022.05.03.09.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 09:11:12 -0700 (PDT)
Date:   Tue, 3 May 2022 12:11:11 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: qcom-rng - fix infinite loop on requests not
 multiple of WORD_SZ
Message-ID: <YnFUH6nyVs8fBgED@x1>
References: <20220503115010.1750296-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503115010.1750296-1-omosnace@redhat.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 01:50:10PM +0200, Ondrej Mosnacek wrote:
> The commit referenced in the Fixes tag removed the 'break' from the else
> branch in qcom_rng_read(), causing an infinite loop whenever 'max' is
> not a multiple of WORD_SZ. This can be reproduced e.g. by running:
> 
>     kcapi-rng -b 67 >/dev/null
> 
> There are many ways to fix this without adding back the 'break', but
> they all seem more awkward than simply adding it back, so do just that.
> 
> Tested on a machine with Qualcomm Amberwing processor.
> 
> Fixes: a680b1832ced ("crypto: qcom-rng - ensure buffer for generate is completely filled")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

We should add '# 5.17+' to the end of the stable line.

