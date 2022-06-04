Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFCF53D8C6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 01:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiFDXDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 19:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbiFDXDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 19:03:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF9C4EF60
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 16:03:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso14881044pjl.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 16:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a1QBaiLvwdizlFMNMiai4RgoXYY98cn9ShXZ4Fw55nA=;
        b=JA8GXprdVwg+KAaWrYuCmlUkX76lHJaZvdzELwYvv8791y6YplnkoZrnxPY6L1ToF1
         0ZhgE1EvDIe+5x6xDPkpeaONVbBrOfjcSCv6WTcG2h8IOVd28sS6YYHT/ZkpT5fUYhco
         tlUjOtEDS3Qw1gFxHzJx1qmsC7xCvvQay9hU3e8wrCE25CUb56jvAdhG+vOCNWNtGxGb
         VLp6/KCOMhioN52vwSrgSYjOhRzes0pnz10ysDJuyPnQJGti8hvcB0+xuqDYVVzxS4V6
         DwEoxglNZrpSc+yvJgOsHVnzsTmWU9WZ09iYwY7eNuwzrPf55TliLVKq1YpkW77f00Y7
         vPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1QBaiLvwdizlFMNMiai4RgoXYY98cn9ShXZ4Fw55nA=;
        b=JLc/+EaMS4yrdFxuk5TGIUx23RTiKwC8puW6+iHDoVX7cw417Mk3qV9AfKUWyf+qiV
         ZdQZhfiA57fxfTqn+8Nq9hRAFnepl7sF4vmR+57qp3yDRJTY/gquNe07tTnOi+A+LWvz
         aObKjbkR/3TU/A1K3qyP7FEC3Q5QxHlAkVfc5uLyXNBMcu8bAHcj2t5KoTdHmCDDZdIW
         KM6nobtInJluo/ddarGPrJcrfHsN5YQT0zZHpfw6EP6KJzh5xZi1nwbcEUAsznvAhx1M
         52H1ArQscfAl4QFVbkbxLnGIzgR1WyC+17hxCQN7arKowux756mFOYQgiLO3Xlx0kbUB
         L1vQ==
X-Gm-Message-State: AOAM5319s21o/invz4FFeUN6SztDQCNIMyc8ktfE5goQedPa5xjGjjsK
        1pMk0S1ZjROy/JOD/cdrQc20pg==
X-Google-Smtp-Source: ABdhPJxhBgsUp9dcWbf8tXXTv0cMuO0aFZR7e8ghmm51BXB18HkQ4z/loyRLNW2zsQdeyK7z/hdWLw==
X-Received: by 2002:a17:90b:3ecd:b0:1dc:94f2:1bc0 with SMTP id rm13-20020a17090b3ecd00b001dc94f21bc0mr18366358pjb.32.1654383798232;
        Sat, 04 Jun 2022 16:03:18 -0700 (PDT)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b001641b2d61d4sm7663688plk.30.2022.06.04.16.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 16:03:17 -0700 (PDT)
Date:   Sun, 5 Jun 2022 11:03:13 +1200
From:   Daniel Beer <daniel.beer@igorinstitute.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: IRQ sharing mechanism.
Message-ID: <20220604230313.GA2042@nyquist.nev>
References: <61dd3e0c.1c69fb81.cea15.8d98@mx.google.com>
 <20220122191034.74cb89c4@jic23-huawei>
 <20220604160851.6722a301@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604160851.6722a301@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2022 at 04:08:51PM +0100, Jonathan Cameron wrote:
> I'm just sanity checking what I have as not yet handled in patchwork
> and noticed we never moved forward with this.
> 
> Daniel, is this still of interest to you?
> 
> If so perhaps others have time now to take a look at the (brief) discussion
> below.

Hi Jonathan,

Yes, I'm still interested in this. Unfortunately I no longer have access
to the hardware to test on, but I'm happy to update and/or fix the patch
if that's the preferred way to go.

Cheers,
Daniel

-- 
Daniel Beer
Firmware Engineer at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
