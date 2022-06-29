Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7855FE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiF2L3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiF2L3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DFBA326DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656502140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZiMXL+ilFja5jXawjmm60mxTjlG0pAnot2u6S8oxJQ0=;
        b=gbWAhxExLebE1nuCqpN8mU9Xt5l8lSk6bb6Di2OxRXUf6kEnJgSlpuxX1yw7AN9/0on+pZ
        RxpJyNasTcCUmbtGRxyR7b3S8c+no4ZDz4pROUteMtAWFGFCcx9/Mg6jZEVzQGAB5L5h0M
        IWIJqEFxZX6ADqEN5Lgrsw7DkjaSbIc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-QLYFLUEPPzCcpvOvcQwmIg-1; Wed, 29 Jun 2022 07:28:59 -0400
X-MC-Unique: QLYFLUEPPzCcpvOvcQwmIg-1
Received: by mail-wm1-f69.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so6191212wmp.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZiMXL+ilFja5jXawjmm60mxTjlG0pAnot2u6S8oxJQ0=;
        b=UghRCTb4OCY4cMe0gz8vhoGZryvF4PoHS4SW9zSKmS2mE5tTcyq0yJKDlPaW42LaAH
         ZXGtCx+vzoJ8c7pwZoFcig/hLvPwI69GBUp6ocw0CHmuklWPspoNzRWKxh7WwEChpOKB
         64h1MzhwkhWO8AwERsjbpkbVHlaKCjqGZWPWls/cyjJIUkwA0ud8Xw7ieftaqbji9xvZ
         +Wv53E3jSh0CfvfJSBW9vHHF/Wq7c5EWlL19J1lc1gxZh8YDpMnXMHSzJdRmP8aQgzPx
         H5o/FsqtoSKo1KPL74O7yKcTpB3HJo3UOE33in7HwtIUck56Yfud+nBfutA4UG7A5+E1
         JwWg==
X-Gm-Message-State: AJIora8ykMZ8DZqoKJfk8n9cbw0DchC3537uWUPLaffGZwUtSxAzvMJv
        VZJnW4IdAdomNuErAG0jCtd/sD5j8i8leBK2fdNXQm75D8GCFjft6jibaOKGhy0kCFCnIpJDUid
        kVo4UO9r49iOSaAcRaE8gkfRz
X-Received: by 2002:adf:d841:0:b0:21d:2d0d:e704 with SMTP id k1-20020adfd841000000b0021d2d0de704mr1882261wrl.77.1656502137607;
        Wed, 29 Jun 2022 04:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tZP/KbIe69IZVjJQlbxE5EU9PxxeyQN8aoggsXmiyfSbUGRB0Oc3AxcelAzcQjUt6MTEdKFA==
X-Received: by 2002:adf:d841:0:b0:21d:2d0d:e704 with SMTP id k1-20020adfd841000000b0021d2d0de704mr1882246wrl.77.1656502137405;
        Wed, 29 Jun 2022 04:28:57 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id q11-20020adfea0b000000b0020fff0ea0a3sm16108515wrm.116.2022.06.29.04.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 04:28:56 -0700 (PDT)
Date:   Wed, 29 Jun 2022 07:28:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        songmuchun@bytedance.com
Subject: Re: [PATCH 5/6] vduse: Support registering userspace memory for IOTLB
Message-ID: <20220629072825-mutt-send-email-mst@kernel.org>
References: <20220629082541.118-1-xieyongji@bytedance.com>
 <20220629082541.118-6-xieyongji@bytedance.com>
 <20220629043539-mutt-send-email-mst@kernel.org>
 <CACycT3sAcH-b40hORjSOQb67jZ0Fd-fxdzmZNwt=4iZdX6gLeA@mail.gmail.com>
 <20220629055241-mutt-send-email-mst@kernel.org>
 <CACycT3vaNLYRid5SsT11LuVCaGXbBfV=q7c7SUp1+r9BcRpwkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3vaNLYRid5SsT11LuVCaGXbBfV=q7c7SUp1+r9BcRpwkw@mail.gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 06:19:31PM +0800, Yongji Xie wrote:
> > No i mean you decrement the lock twice. Question is can two bounce
> > buffers share a page?
> >
> 
> I think we can't. I will find a way to prevent it.
> 
> Thanks,
> Yongji

I guess it doesn't matter much then.

-- 
MST

