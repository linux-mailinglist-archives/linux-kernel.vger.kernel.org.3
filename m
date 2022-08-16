Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D955962F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiHPTSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiHPTSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:18:00 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B033B6A48C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:17:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a22so9572655pfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=oNbwpYSBAVXngDHJ9WU6jqksTI5pKTDQGRptAeuQIq8=;
        b=No14jYa3wQejzTCeZ95bQjdyIdQiUGIyhtZHsVgirj8sDKJnuHBc4flHzXPSytMNI4
         895fdy54xx9LUnZkU+TT2thwkQB4yUDmAsAXAT+5FSCrY1cjfK7qoJ4p7D9PiCamj2Cx
         XWrSuMiDbBbVDoXEtCeKXv1i8BzmWnoxidHsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=oNbwpYSBAVXngDHJ9WU6jqksTI5pKTDQGRptAeuQIq8=;
        b=pDgYVHX8KZ6K/dqTSs7hFfKW39zr5tRWWP6x1hZWbsnpA9b6KMz6ZR8MzpmHT+9LAX
         KPQlMdUWThua+WatZyqdgj4vilwpZtlTmCm01CR2uQE1hZRGIOHJ8GNNX+BTCTCmhEMX
         79YWlweDPwPq83LmRPt9UWS7I7sCsl3OXpI/f5mMbXe0uyV+Bkz2rznuKCOtGTbUM9Wq
         MTCZ8iWY3rOHzSODsIeBZ5X5A+fgzvg01QSc4zeE1fO1uaCRauWEdVQCa6LLMHKO3Jk7
         GBuE7bcZCoHi3RxJmVYudKWFVJ9DvOcE3BYkQspfF62qRV8WO9P3lgYKl9NiqJk26r/q
         DiSg==
X-Gm-Message-State: ACgBeo283vbL0yt9Xkd9nb0VkO6hUrXLxg2e57bMM48TnSS2Z/puVrPv
        Pf7EN47XzFRyu4nVmG8u+VlGvA==
X-Google-Smtp-Source: AA6agR7HHHOs3dOu0s1p8JpIoe6a0Zac/B2wBZr2vEaZV2WUU07yc/W5DOtCxxnONtSnoQ0m0Pfc3g==
X-Received: by 2002:a05:6a00:2485:b0:52e:ca57:5018 with SMTP id c5-20020a056a00248500b0052eca575018mr22356534pfv.43.1660677479171;
        Tue, 16 Aug 2022 12:17:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15-20020a170902ce0f00b0016d95380e8esm9431192plg.140.2022.08.16.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 12:17:58 -0700 (PDT)
Date:   Tue, 16 Aug 2022 12:17:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Matthias Kaehlcke <mka@chromium.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: security/loadpin/loadpin.c:365 dm_verity_ioctl() warn: maybe
 return -EFAULT instead of the bytes remaining?
Message-ID: <202208161217.2DFCE2D532@keescook>
References: <202208141119.RKGSGoZ7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208141119.RKGSGoZ7-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 11:07:12AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
> commit: 3f805f8cc23ba35679dd01446929292911c2b469 LoadPin: Enable loading from trusted dm-verity devices
> config: s390-randconfig-m031-20220810 (https://download.01.org/0day-ci/archive/20220814/202208141119.RKGSGoZ7-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> security/loadpin/loadpin.c:365 dm_verity_ioctl() warn: maybe return -EFAULT instead of the bytes remaining?
> 
> vim +365 security/loadpin/loadpin.c
> 
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  355  static long dm_verity_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  356  {
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  357  	void __user *uarg = (void __user *)arg;
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  358  	unsigned int fd;
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  359  	int rc;
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  360  
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  361  	switch (cmd) {
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  362  	case LOADPIN_IOC_SET_TRUSTED_VERITY_DIGESTS:
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  363  		rc = copy_from_user(&fd, uarg, sizeof(fd));
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  364  		if (rc)
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27 @365  			return rc;
> 
> The copy_from_user() function returns the number of bytes remaining to
> be copied.  It should be:
> 
> 	if (copy_from_user(&fd, uarg, sizeof(fd)))
> 		return -EFAULT;

Oops, yes. I'll get this fixed.

-Kees

> 
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  366  
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  367  		return read_trusted_verity_root_digests(fd);
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  368  
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  369  	default:
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  370  		return -EINVAL;
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  371  	}
> 3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  372  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 

-- 
Kees Cook
