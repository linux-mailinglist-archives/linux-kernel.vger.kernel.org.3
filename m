Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47051CF3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388439AbiEFDLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiEFDLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:11:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A696A63514
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:07:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p6so5633508plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ZByRT3W13dRTMM5enzqx7Ee/WWHJauBDk1QFBEZYWw=;
        b=Mg12Qtv0ZM0LhpjqHsYBTtzhGoAwMa8SQB5W/EjZKXOFHI04Cx3pwdzkWOeu7ekfn1
         BFmxxXu009tb+amypixj4lsdWYm4cdt9mgdehcIk8ClEE+CvKr35yEOs7oDL81vbaNaB
         MbMJwPjY3+6Wz9dp8K1UXVSsf9YWgXF6s/w9T4X8PqArxD5hOS7qC/u5EVE6yyf/GeSK
         oRV76j3+mmrzMKGFHntwJhGIUQnDpJ24rZkcdT38AS7/t5OX/aZDiarD9MhO/TCqVW48
         /Q5TRi5fffE9yttPFL/j5tJwNUxxYfziQLwVMEEAgZ8NwieshH8Z9jo6/b5GmOn5l+n9
         0j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ZByRT3W13dRTMM5enzqx7Ee/WWHJauBDk1QFBEZYWw=;
        b=5dEoZoMHeoCVfR8mhtXLcUaeC404ezv30gfc+aac94WsiLbGKUyu6QRzM7Kgm86T4s
         /N5pdVlW6kTm9XlY5KOJxr8+iNtma1imXd/n7xp9yWozqUKsdK+dW1DYafbxTreN9Izo
         mBZ4EvL9QNwGixMOYECJTbdCwyCXAzHjKK5dqUdTrw/g9Ep9mdntOuWrLMYaeLrJ/Vkq
         JmY1xr0rc99etpwOBuHm94a/P/noAbdQgHgZ8MR2Q6mlTILPdBkljlKxEMFYtWj7QY3z
         K8CD/903Jd2/6cIVWiIMrVMkXMC+0W3qLeoiPQ7DL0YYnUcuRC9orhGJjdInUxGEeNvE
         EDzA==
X-Gm-Message-State: AOAM5314l8Q1yzoWAmVpB1IWGBpekPOKKh56QRJzmarYC8mFqubg/pVD
        22TfFTffqZSwivx5ypEDvX0=
X-Google-Smtp-Source: ABdhPJwh2T2F23dAug4Y8Cyl2dnBafwB5p1U9LWuACgExswv7MHbLuufj2qC1170h/Lj1rGgkdfikQ==
X-Received: by 2002:a17:902:ecc8:b0:15e:9e46:cb7e with SMTP id a8-20020a170902ecc800b0015e9e46cb7emr1398821plh.111.1651806449179;
        Thu, 05 May 2022 20:07:29 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902cacd00b0015e9d4a5d27sm395853pld.23.2022.05.05.20.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:07:28 -0700 (PDT)
Date:   Fri, 6 May 2022 11:07:24 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     dan.carpenter@oracle.com, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix uninit-value "data" and "mac"
Message-ID: <20220506030724.bqa3braybukvnp7f@ppc.localdomain>
References: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
 <20220414154215.GL3293@kadam>
 <20220415094705.aibh3jr4wzhddmud@ppc.localdomain>
 <20220415095721.GR3293@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415095721.GR3293@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/15 12:57PM, Dan Carpenter wrote:
> 
> But in r8712_usbctrl_vendorreq() you really need to make the other
> changes I mentioned as well.  If you want to do it as a separate patch
> that's fine too.
> 
> 	if (status < 0)
> 		return status;
> 	if (status != len)
> 		return -EREMOTEIO;
> 
> 	if (reqtype == 0x1)
> 		memcpy();
> 
> 	return 0;

Hi Dan and Pavel,

Sorry for the late reply. A v2 patch series is prepared, in which the
uninit-value bug is fixed by adding error checking and initialization.
In that case, r8712_usbctrl_vendorreq() is not touched any more. So
WDYT to refactor r8712_usbctrl_vendorreq() in another patch with the
code Dan mentioned above and usb_control_msg_{recv,send} suggested by
Pavel? And for now, the patch series is just confined to fixing
uninit-values. The patches will each focus on one thing that is easy
to understand.

thanks,
- w
