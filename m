Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6825A8FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiIAHR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiIAHRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6B312537A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662016663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MRH/N9umluFecU95mxeumXvzG19EehDFSI9n31sNO3I=;
        b=fNVtu98gAhM/UNoToIZqrxcLY+UtN6UBOncG0TpYjpVERsyoCDLCVEg7ATNUMwDfKNTjoO
        LHdrbVHQsj5+obdbT1qgoHkXHs6SpnhuddkjM34t3rlYgOucn77cbqVxtwqW1mS5VEKdLc
        WgbyeemPUj/4PAWrWieS/7AHr8K5FO4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-tezC0ux-OH65MubcGifSsQ-1; Thu, 01 Sep 2022 03:17:42 -0400
X-MC-Unique: tezC0ux-OH65MubcGifSsQ-1
Received: by mail-qv1-f72.google.com with SMTP id cz3-20020a056214088300b00498f11a6d8aso9871343qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=MRH/N9umluFecU95mxeumXvzG19EehDFSI9n31sNO3I=;
        b=FhGDUz+W8qb0whyq0GXdvoTB1VrAfYbHDDdDCfr7BEiw6wRDtHnGZ3JwZk9TCdtnBO
         T0FlYaAX+nlowcBgUVzSVBlPcuFGi6tl2JpR28/hfa7DTL2ClNXxfAUMqiGD1U38TSeG
         49z9BBWeVSlD1NIjz0XA80cgMcLrEdEbeHt+kG7yCRWlslbJeoKrmETaPcPb7Sc32AIz
         aalVoN0pvvmJLGpfhpKGgzIWVWU02VK9BFf0UJmT6MqqnXRl0Xx97Q0bgjJWiLKktKA3
         lhvP5ULJH4LqRLzzk3cUMklLYaDfI+yVYcphSe8kQbVQ6E2Q29yq0BZgfSLm3+qqqBYT
         HErw==
X-Gm-Message-State: ACgBeo1d1o5sqr2sqiV5raMmlK1KEZc75dMP4qy38qiI4bSP75sxB78R
        uzdXfNovXibiLwMx4VyhublvUiQ6J7Tex/F6dwDqpKVB/A5+HZaBHQr9X20eluIxGizkPyDuERc
        a/BHmQkLwO6ERz/zsfgswpSVE
X-Received: by 2002:a05:620a:1993:b0:6bb:7564:a31f with SMTP id bm19-20020a05620a199300b006bb7564a31fmr17955726qkb.201.1662016661681;
        Thu, 01 Sep 2022 00:17:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6xI0mCkMJoz80W9gKGqFCAXq9xVYzbiD7oUtBs3Wb3F+4WhkA9toTEUqY8coZeGLWiv9/tsQ==
X-Received: by 2002:a05:620a:1993:b0:6bb:7564:a31f with SMTP id bm19-20020a05620a199300b006bb7564a31fmr17955721qkb.201.1662016661424;
        Thu, 01 Sep 2022 00:17:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id h5-20020a05622a170500b0034490214788sm10406775qtk.49.2022.09.01.00.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:17:40 -0700 (PDT)
Message-ID: <703b0c990f4c7b7db8496cb397fdc6dbccdc1c67.camel@redhat.com>
Subject: Re: [PATCH net] net: fec: add pm_qos support on imx6q platform
From:   Paolo Abeni <pabeni@redhat.com>
To:     wei.fang@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 01 Sep 2022 09:17:37 +0200
In-Reply-To: <20220830070148.2021947-1-wei.fang@nxp.com>
References: <20220830070148.2021947-1-wei.fang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-30 at 15:01 +0800, wei.fang@nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> There is a very low probability that tx timeout will occur during
> suspend and resume stress test on imx6q platform. So we add pm_qos
> support to prevent system from entering low level idles which may
> affect the transmission of tx.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Since this IMHO causes a significal behavior change I suggest to target
the net-next tree, does that fit you?

Additionally, it would be great if you could provide in the changelog
the references to the relevant platform documentation and (even rough)
power consumption delta estimates.

Thanks!

Paolo

