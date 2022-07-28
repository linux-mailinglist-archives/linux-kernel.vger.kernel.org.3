Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E42A583FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbiG1NPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiG1NPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DB071FCC5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659014131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HUKi8MrGrEGip8RjX9SW44lSQ53nVGkUaTRQzQgM+mc=;
        b=gLzMiK6EOJCsSWOB0QuecMtYp6D0ACaCpvZzzQklddlD2Nk2uu7/9v7njNmcnR2Hs0LA+a
        xF3EDf+WUmo7mQAXkU5EGgawVaqsrCwruNH/iKL7yz7VfjHv/m2DA7PWMLeVvH4H4oYhrr
        OMzMQTBlUiyGBvAZ1zYZmdRAwbo9vdE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-YODipXbcMAutpxEFrV0FlA-1; Thu, 28 Jul 2022 09:15:29 -0400
X-MC-Unique: YODipXbcMAutpxEFrV0FlA-1
Received: by mail-qv1-f71.google.com with SMTP id ei6-20020ad45a06000000b004746f72008dso1279092qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HUKi8MrGrEGip8RjX9SW44lSQ53nVGkUaTRQzQgM+mc=;
        b=VK14tbLY5A2c2Sa2YVR6zF7zhpT81jSPDFbz31q+Q/ZV8Kz+6XOPs3QPzaQoturdkq
         4JLlNhchwIsQGPOSdVNgmzTk/xKI69jzVOXNPA3dNi0OL/aVZ8E8z5F5+0Lk0G960AA7
         i4fAGFwtgPoitnjaMEpSQj0Knj08c0xxl6e9Xs6Uc5DOyyUc6im66nnW+uSo1Dh7h7wA
         cvsK2WqMH3jiNkeIuvgnpZXA0ei4NTmFrLF96RhazeGpepFQUzc/TvijnKEMUPjve3qH
         sjhjERHxIf3vTZpFOlPQwIqbLeYw1T+3u8byr/0E9p68GjvyTq3maUNd9oa+4eyGc2rq
         JOAQ==
X-Gm-Message-State: AJIora/+r0pSEE1VoSLQZnRXDfBMYhxVL9Gi/zCmmllI7emgNG9/PhZD
        xJPlzEolb8yIYXyyUpUvDC3zAxMjSZRHI6VjnpZPUYHi75JHSwEF8ZCaN6t/M6b/w20MoMySZt7
        6RTOMUktOjPE+efAStwEFIghz
X-Received: by 2002:a05:6214:cc8:b0:474:6de0:f8a5 with SMTP id 8-20020a0562140cc800b004746de0f8a5mr10225709qvx.105.1659014128592;
        Thu, 28 Jul 2022 06:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vnztfGuboYDJJTLbZyvBfyH4pWFGcQG4mFGGhLbhGjmrdN/43PJLdxBRtlxurmakQ1oR06+w==
X-Received: by 2002:a05:6214:cc8:b0:474:6de0:f8a5 with SMTP id 8-20020a0562140cc800b004746de0f8a5mr10225677qvx.105.1659014128310;
        Thu, 28 Jul 2022 06:15:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-164.dyn.eolo.it. [146.241.104.164])
        by smtp.gmail.com with ESMTPSA id bt8-20020ac86908000000b0031f16e7f899sm437997qtb.45.2022.07.28.06.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 06:15:27 -0700 (PDT)
Message-ID: <8275d40f7154c3a4e4acc4d3779af38abb061df5.camel@redhat.com>
Subject: Re: [PATCH] net: dsa: microchip: remove of_match_ptr() from
 ksz9477_dt_ids
From:   Paolo Abeni <pabeni@redhat.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>, woojung.huh@microchip.com,
        UNGLinuxDriver@microchip.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Date:   Thu, 28 Jul 2022 15:15:23 +0200
In-Reply-To: <20220727025255.61232-1-jrdr.linux@gmail.com>
References: <20220727025255.61232-1-jrdr.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-27 at 08:22 +0530, Souptick Joarder wrote:
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> 
> > > drivers/net/dsa/microchip/ksz9477_i2c.c:89:34:
> warning: 'ksz9477_dt_ids' defined but not used [-Wunused-const-variable=]
>       89 | static const struct of_device_id ksz9477_dt_ids[] = {
>          |                                  ^~~~~~~~~~~~~~
> 
> Removed of_match_ptr() from ksz9477_dt_ids.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>

As this looks like a fix, could you please post a new revision of the
patch including into the commit message a proper 'Fixes' tag?

Thanks!

Paolo

