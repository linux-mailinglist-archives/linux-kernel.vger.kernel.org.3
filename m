Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4C34B1F83
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347758AbiBKHo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:44:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiBKHo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:44:26 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE7D2A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:44:25 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o24so11042235wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2zIZDV0bKIX2QsFrkmLscCD6kTgXyjPR9dmVtO2M2fE=;
        b=XcoWqxMy/x9ja5hrGMU3f1pHYvIIcFRqX+ZUUDE+uD4CGKEbfrLfcQB+TSW0AAn48g
         SyYPA+a2hKlzSojd9STXvCm1wmJvme+GgoDHUf5aNhNDSmbbcePPhg7ow7Il3LWrBlxD
         J1PfEpqR2Ax3wP9bbEFxr8kNkajwd9RVy2p87+GFls//jBGjQCcIo/9z3TIQmUOL2zbF
         RixcpOLJEw3aup8hkj24P1J9UiBuhv3la+GbGm2FEwud/CO6ApttrTVhbZlH6erCLFdG
         Egr0/RbI/yrd27Q6V+dqFWDaMVXqWylLUEb4oUZcfiAaM5Vc5V25ATxKTJkdJGPIMWHE
         dJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2zIZDV0bKIX2QsFrkmLscCD6kTgXyjPR9dmVtO2M2fE=;
        b=IW3kE8pZzT6WZKZYCTyWM8LKkjLP1UprnCBwNUghxEhgQRQM3EkoBKDv7tzkM063rz
         Z4Rw5QuNe/Y0XBhksoX97v1g/VG/qEuojbw+KCMZlSlZ1M/gPlt/QuRgoPzfmVOPUoIB
         8ALJUvex1EjAJQe7+OV/NqfsbR7iH1XrZd88vdul6kHU2sUWGk5XaHAg6ZkSqktaS4Vc
         hJFlNsjkZB2i1Ww/3d+qKUHCn7RMae0eEASx1tQJoaKSq7zKqtBzEZsTjkxdSIKFTSYj
         cuCkweTwQwHmy88WG3K2qFo4FQWq07OkbwTcRpyaC5Q/Sa+ia7FAh8QTphcSACRvwRJj
         j8KQ==
X-Gm-Message-State: AOAM533VnxfBLYMzrg8wHUFBFFtYKVwUsw/RvdRtrh+UtKUt8IG0XC2t
        3b9ChKyK7/mVNjCNk2b19jgZbg==
X-Google-Smtp-Source: ABdhPJxHxXAEXIqCeoPqDRtAW18R2Px4F7QEqZoWsMkAMXpokVOinqvobizbHID1OX0gAQ5Is98Nlw==
X-Received: by 2002:adf:f4d1:: with SMTP id h17mr299563wrp.111.1644565464063;
        Thu, 10 Feb 2022 23:44:24 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t11sm8107696wrs.66.2022.02.10.23.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 23:44:23 -0800 (PST)
Date:   Fri, 11 Feb 2022 07:44:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     =?utf-8?B?6LW15pmT?= <zhaoxiao@uniontech.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding" <thierry.reding@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: vt8500: Rename variable pointing to driver private
 data
Message-ID: <YgYT1YQyE9xRvW7I@google.com>
References: <20220209064755.7287-1-zhaoxiao@uniontech.com>
 <20220210074046.vxskduecvgiehvnl@pengutronix.de>
 <tencent_5115CB3B0563B582409DF902@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_5115CB3B0563B582409DF902@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022, 赵晓 wrote:

> Thanks for you suggestion. I modified the patch following your instructions and commit the v2 version.&nbsp;
> &nbsp;

Would you be kind enough to turn HTML off in your browser please.

Also, please refrain from top-posting.

Replies should be inline (like this).

> ------------------&nbsp;Original&nbsp;------------------
> From: &nbsp;"Uwe&nbsp;Kleine-König"<u.kleine-koenig@pengutronix.de&gt;;
> Date: &nbsp;Thu, Feb 10, 2022 03:40 PM
> To: &nbsp;"zhaoxiao"<zhaoxiao@uniontech.com&gt;; 
> Cc: &nbsp;"thierry.reding"<thierry.reding@gmail.com&gt;; "lee.jones"<lee.jones@linaro.org&gt;; "linux-arm-kernel"<linux-arm-kernel@lists.infradead.org&gt;; "linux-pwm"<linux-pwm@vger.kernel.org&gt;; "linux-kernel"<linux-kernel@vger.kernel.org&gt;; 
> Subject: &nbsp;Re: [PATCH] pwm: vt8500: Rename variable pointing to driver private data

Please configure your mailer to strip mail headers from the body.

> &nbsp;
> 
> On Wed, Feb 09, 2022 at 02:47:55PM +0800, zhaoxiao wrote:
> &gt; Status quo is that variables of type struct vt8500_chip * are named
> &gt; "pwm", "chip" or "pc". The two formers are all not optimal because
> 
> There are no variables named "pwm" or "pc".
> 
> &gt; usually only struct pwm_device * variables are named "pwm" and "chip" is
> &gt; usually used for variabled of type struct pwm_chip *.
> &gt; 
> &gt; So consistently use the same and non-conflicting name "pc".
> 
> The intention is fine, but you missed a few instances that are named
> "vt8500". The statistic in mainline looks as follows:
> 
> 	$ git grep -o -h -E 'struct vt8500_chip \*[a-zA-Z0-9_]*' linus/master drivers/pwm/pwm-vt8500.c | sort | uniq -c
> 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 struct vt8500_chip *chip
> 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5 struct vt8500_chip *vt8500
> 
> (So there 2 variabled named "chip" (that you renamed to "pc") and 5 that
> are named "vt8500". I prefer to rename the "chip"s to "vt8500".
> 
> Best regards
> Uwe
> 

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
