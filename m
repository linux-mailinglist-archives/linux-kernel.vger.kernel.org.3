Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6414C1DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbiBWVhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiBWVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:37:46 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D58434B5;
        Wed, 23 Feb 2022 13:37:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gb21so177885pjb.5;
        Wed, 23 Feb 2022 13:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0kpY9SMEqbPXEHUK2jT6jnwSqSrDrVawGvhjDr872g4=;
        b=VcPREStkAMxwzsWM/7UVwLd7DCg/RXIxH2Z7YNTEsOcUhs17exdb7X3VZrTcdT7w/8
         xtZF6uFO/++x9chWj4MbBDTSU2+IrYPcQPy62ooaXkQzig6zm8sOnb2MCvCiv3uDJ+dq
         Rz7Toh+bFNIkTP4xp5bABj/SFyv+1NA6HStIvwPAZtQ9gF2RzzAXZZScynFjjSLMuMs2
         Or/qHBq6Gb26sFoftSzzwjk4uj5cJP8O5Rir9dqF6nwRzmCv8fP7ZivqQfSWPWInaLgc
         x0JcB2o5huiZJPd94xOup4qgaG9yeXwQX0ldOYGXjYVbo8T4d373A1OFn+S1r+lalunP
         ayvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0kpY9SMEqbPXEHUK2jT6jnwSqSrDrVawGvhjDr872g4=;
        b=6UnFw+/lWZ7I971ZyFVc3slf3AcU8pGwVdJHOx+slGlnY5t5XNU/P9Xld+HSblmq7v
         fSDhfR/m2+i9/vIIS5BeI2N36uzOBnP8vxIKf5mKGWdsU18BYEMeSezKVrbk/hGn0kBa
         WTPZv6sjvASJCw3tFmjdYLww7tkJrIFYygu+c1wQECZ4tc3HGVLv0chwPVozC/hfTSRU
         ztdspisjl0NuiTVoXs7rIHwSPUN3wHRWV3GuvvNw7N/elYLk9l8V/Hhzu8azPz377FfK
         9XNzyRRS9xmZQwBwFbjo0wBKNlsOAXrKNmiRi43Y2Hkc0OFQvB1n+53L3pi5/GrZItts
         DE0g==
X-Gm-Message-State: AOAM5337BFcwQbvYmdneXBwW8Ry3bXRpPXVnnF74AXFahnsrddbfZznM
        lPBpFuNqjunJoGRhhWYCiQp7V9j/r6Y=
X-Google-Smtp-Source: ABdhPJxpr4eJtrF5icAqIgTSm25qJX6Sa97duVZZuvANpdy7HhJ6QraZHjyAt9JQ/n6LOweKdjkuKA==
X-Received: by 2002:a17:90a:3cce:b0:1bc:9f9b:fb85 with SMTP id k14-20020a17090a3cce00b001bc9f9bfb85mr1351605pjd.19.1645652236770;
        Wed, 23 Feb 2022 13:37:16 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id b13sm530037pfl.75.2022.02.23.13.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 13:37:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Feb 2022 11:37:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 1/6] blk: prepare to make blk-rq-qos pluggable and
 modular
Message-ID: <YhapCurbiI21WYmm@slm.duckdns.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-2-jianchao.wan9@gmail.com>
 <YhUbCH+dhKkgMirE@slm.duckdns.org>
 <2e17c058-8917-4a37-896e-1093446339f6@gmail.com>
 <39db454d-ca30-fb42-3d72-899efa34fb78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39db454d-ca30-fb42-3d72-899efa34fb78@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > We just want to provide the flexibility for the user to open/close a policy
> > per device. If we need to the policy on a device, we needn't to waste cpu
> sorry, it should be "If we don't need the policy on a device" ;)

Yeah, that's what modularization does but why does it need a separate user
interface for loading? Everything else inits on insmod and exits on rmmod
and autoloading has been delegated to udev a very long time ago. The
interface you added for loading module doesn't make sense to me.

Thanks.

-- 
tejun
