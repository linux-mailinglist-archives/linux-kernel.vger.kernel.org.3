Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1722352485F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351522AbiELIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351759AbiELIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88E9362CE6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652345445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UKp9aLk27aL43H7c2N2+dMv60Nwmc08LYvDNv9z3Fuw=;
        b=K9LVtcTQKqAngzmhybB/2zHUkolJN0GakkzhOLUGkySB5Fjf/FbC7Xa8hkB1uZEDV52EsR
        nbVbY8fg6VdyXEtAWetqpz6WHGxYRFhfXz/mij2tgjnrG3IGDuroXx5YBYlvxPEBrwaqTp
        8gKI5uxS3xFgD9ceGjhPgJKvZXJcezQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-90v4VXJ2NjSd4FChpylBCw-1; Thu, 12 May 2022 04:27:42 -0400
X-MC-Unique: 90v4VXJ2NjSd4FChpylBCw-1
Received: by mail-wm1-f72.google.com with SMTP id e9-20020a05600c4e4900b00394779649b1so4074826wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UKp9aLk27aL43H7c2N2+dMv60Nwmc08LYvDNv9z3Fuw=;
        b=cwz/5BkeY7tuWoL0tl6l8asGS6R/wU0AZ6n9yG+anwKoH5irnMDYoH4qOF58fuT4+6
         rq0uY1QyNjsGrJJjIK71S5JtCKQzFtUnLf40Ko1K57HpdSYwRTBR1J5eNXOFZEFF7yYk
         IFdR/LvU6+DgoMyIH9E7wj3k5WZ/axLes9Q3MSPDdbf38sjZfB6XL6MsPzHzgfQSvZHk
         zuFEUpYM1ryGChPo7ZAdfbiUf6Rm0NuoB/ang6g5HNpeMVAUvmotpBnEykhYCMBDEUku
         czqDnhXo1DUlV5BSFbNwsG6F02tTiG56G+9uIqcglkOLAmMvIXwQPqPspyrv4Xw3QYa2
         cHrw==
X-Gm-Message-State: AOAM532le9zjH+OCbodhHkM9c8HPCuTEWoL+kbfpcHOiMw6DpY7fooYY
        ffRtiNJQ/MW5zoEqw6HxVBCvYeQQXH1nuwACIYl5ixGR9TAdI6NyTpCW/C2b6FIWGndwi4oUWuA
        r4Repq4UYkG+p1LZIK/UeKjHa
X-Received: by 2002:a05:6000:188a:b0:20c:e43e:83f3 with SMTP id a10-20020a056000188a00b0020ce43e83f3mr2638238wri.621.1652344040107;
        Thu, 12 May 2022 01:27:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJKp/EGxLuFwK2435tzLC+FszxD5/D2QoHQy3dbiyqh5SVzzFU/Rf/vZO6yE8G7CspN33WEQ==
X-Received: by 2002:a05:6000:188a:b0:20c:e43e:83f3 with SMTP id a10-20020a056000188a00b0020ce43e83f3mr2638213wri.621.1652344039853;
        Thu, 12 May 2022 01:27:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-89.dyn.eolo.it. [146.241.113.89])
        by smtp.gmail.com with ESMTPSA id l7-20020a056000022700b0020c5253d8ecsm3470186wrz.56.2022.05.12.01.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 01:27:19 -0700 (PDT)
Message-ID: <4f7e80c47826315e498edf45e7c1442cd54e95c7.camel@redhat.com>
Subject: Re: [PATCH net-next] net: wwan: t7xx: Fix return type of
 t7xx_dl_add_timedout()
From:   Paolo Abeni <pabeni@redhat.com>
To:     "Martinez, Ricardo" <ricardo.martinez@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        m.chetan.kumar@linux.intel.com, loic.poulain@linaro.org,
        ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 12 May 2022 10:27:17 +0200
In-Reply-To: <add45b0e-3081-3ca0-d03c-fe306526cc01@linux.intel.com>
References: <20220511071907.29120-1-yuehaibing@huawei.com>
         <add45b0e-3081-3ca0-d03c-fe306526cc01@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 17:35 -0700, Martinez, Ricardo wrote:
> On 5/11/2022 12:19 AM, YueHaibing wrote:
> > t7xx_dl_add_timedout() now return int 'ret', but the return type
> > is bool. Change the return type to int for furthor errcode upstream.
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >   drivers/net/wwan/t7xx/t7xx_dpmaif.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wwan/t7xx/t7xx_dpmaif.c b/drivers/net/wwan/t7xx/t7xx_dpmaif.c
> > index c8bf6929af51..8ee15af1a1ce 100644
> > --- a/drivers/net/wwan/t7xx/t7xx_dpmaif.c
> > +++ b/drivers/net/wwan/t7xx/t7xx_dpmaif.c
> > @@ -1043,7 +1043,7 @@ unsigned int t7xx_dpmaif_dl_dlq_pit_get_wr_idx(struct dpmaif_hw_info *hw_info,
> >   	return value & DPMAIF_DL_RD_WR_IDX_MSK;
> >   }
> >   
> > -static bool t7xx_dl_add_timedout(struct dpmaif_hw_info *hw_info)
> > +static int t7xx_dl_add_timedout(struct dpmaif_hw_info *hw_info)
> yes, int is the right return type, thanks!
> 

Changing the return type without using the different error code in the
caller is quite useless. Additionally t7xx_dl_add_timedout() (via
ioread32_poll_timeout_atomic()) can produce a single error value
(ETIMEOUT). IMHO this change is not needed.

You may want to remove the 'ret' local variable instead (in the same
function)

Cheers,

Paolo

