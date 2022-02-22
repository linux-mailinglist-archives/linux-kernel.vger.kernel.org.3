Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F724C0008
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiBVRTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiBVRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:19:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E540916E7E6;
        Tue, 22 Feb 2022 09:19:06 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 4so7582718pll.6;
        Tue, 22 Feb 2022 09:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o2k6/+KfPNpdk5T6WckK4aM0wg0CQdVevzUCwQjOYec=;
        b=fYU6kji1ZrL/UM8QiviELjj1rz8qgQXsK09+ZW7IyBmIspyeLLKeKUPy34CGAcrNYA
         iCV3ZGrIqnyokl57aLCA+4LeuFJ5Iibvicca6HfzmpYqpT2uruIU/pvNih4dcsx+CPtj
         yVdZgPFxxApVBaRP6jPt6tcspLvCoDpAqLeEAim775wGesrWexQahkD93CEA1J0lY8Pn
         G7gWHSq/kVnYe+07LgdpiX+L/rZlCUrURzwLcv4HAnVLfqkPtcA+JRiAfFI9FPP0sFGD
         ftr1Rugm4zFjC0TkAk6MTPGeLnRYKdEqjl4WDEzjiRSK0WzbnhvZBZ+sBxI+yXA1iBfA
         HnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=o2k6/+KfPNpdk5T6WckK4aM0wg0CQdVevzUCwQjOYec=;
        b=l0NLquS+hYvGFe3sOwLV8ACN/PDk3V0hspCTn8jI20gVVjfcZxlR0i6Twgd+YAcRHA
         6dI+tsPxj+ZQAGeOdYXvQ5SddWYcEzEkynFC3j9mGtbEylhLLjHTrVXoNMiKgsQrRex5
         8O4C2WFgJp4c1jyR79Im5b6FLeVgSUIkrHoaPzRWwaO3rXwyYoquVwgSDc2UrwCUC83H
         PsO/IUPPR59fLlMswwng6XuXdfRtPf5/6LIgCvYm1qhgKHwBEjGzifgneQXEpMmaCMFW
         h1rdcUfUnrLYtjNNmgp0BJZhvNT20o0WjW0rTgjExvnlDZAg/5APGLM0GZAHHz5ZPHuO
         Qrsw==
X-Gm-Message-State: AOAM533i3Szk+yO/Pf3OfMjpFkLiHhMYrkXRLvRNGdU5pbIiS3eZb4nB
        u5VVpOoEwgfxPGrSE5iJTsU=
X-Google-Smtp-Source: ABdhPJz7bD5KcjAQk0S0uVDoPz73lkVV1P9mfHv9AmX3Aw4bd4K85cknXyefY48ye3VnCZ1R+/ObPQ==
X-Received: by 2002:a17:90a:b396:b0:1bc:588a:c130 with SMTP id e22-20020a17090ab39600b001bc588ac130mr5098283pjr.97.1645550346230;
        Tue, 22 Feb 2022 09:19:06 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ob12sm81608pjb.5.2022.02.22.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 09:19:05 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 07:19:04 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 1/6] blk: prepare to make blk-rq-qos pluggable and
 modular
Message-ID: <YhUbCH+dhKkgMirE@slm.duckdns.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-2-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217031349.98561-2-jianchao.wan9@gmail.com>
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

On Thu, Feb 17, 2022 at 11:13:44AM +0800, Wang Jianchao (Kuaishou) wrote:
> (3) Add /sys/block/x/queue/qos
>     We can use '+name' or "-name" to open or close the blk-rq-qos
>     policy.

I don't understand why we're modularizing rq-qos in this non-standard way
instead of modprobing to enable a policy and rmmoding to disable. Why are we
building in qos names into the kernel and adding an extra module handling
interface?

Thanks.

-- 
tejun
