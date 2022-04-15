Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E135027C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbiDOKAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiDOKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:00:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6093BA312
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:57:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md4so7263332pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vlikIKO1333lX4AaZjgRA1Bg7ja7XLdznCnk4eQrE/k=;
        b=mIf9inq8z2WTIztP1CLWeY+QoHPGbssx1rEGaCCx07CXZSOHwnLE5XlMN59SISjIPn
         pGFJ4eeRoxGQNXpvCHFqOQ1lA0lVuadJArdxjjGNRhvP+ql/lvMMfllTyqkLqn9vPBa5
         weFgHlGEVzACcFIEqFb4MPXNvjIYNUHo+xsyhD3TuIu4LRy26bEifE3QSVnLBFErCUZz
         AWEORTZTEUQLoHTXAEJqBr+XfmoewROp0dFvIcmMItDJHpcyEZEHFvRsVydO/Cz4ZGiA
         NRvpLVrgX4tNXQjTlqIHrByFZ9/ScO91tRjZibnD2W+IeA19Pgre/e60S/pGE/2DZYmc
         om4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vlikIKO1333lX4AaZjgRA1Bg7ja7XLdznCnk4eQrE/k=;
        b=wnvJx0Wb7P+KyG//RFr03+Zk2rNFGPxgNrLl1jRrGnuHJnw+xDvmMOfw7EqioosU9V
         kTxAjTi2sTrSwqliTcggjThK6b9JrEKm/JJbOEAnihxwyQ1M4Fuz7Mi+Yd0Owv2/CgoE
         WR9fOMixhnn1DWvbKN9+IkQMKIitwRBgxXMJ3EBE5ZgPfq+/4ewZ9ZBQfKW5VZ2mT6R3
         ElSMOurGa3iimOTIS4cN3zxDF8/pCya+5WmCbvJAvWDSK0DtkuZc5mWiP4ZN6tQBDmK4
         LCFLhcPfBhVDLsRsSBTRJdw5y+GMAbg8kyol1lzApayYO8YSMRZzCWAj2qAo6Po/FxiI
         r8lA==
X-Gm-Message-State: AOAM5319VQ0r9XkA7GPPYHu0UiK67sTmLvDH68H9dloaLiw8RjEynRU2
        LOn8xCCgrlcVGwUFrPyebxE=
X-Google-Smtp-Source: ABdhPJziYAtFIOUcFZRB6U96Epf/tqOVNQNnP4DsB3SGkpbIqoqzS3GsYtZM9pXtP8KDuP3cPrzyKQ==
X-Received: by 2002:a17:902:b597:b0:158:1aee:1b59 with SMTP id a23-20020a170902b59700b001581aee1b59mr35202651pls.33.1650016665532;
        Fri, 15 Apr 2022 02:57:45 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090b050600b001d08a7d568bsm1614485pjz.7.2022.04.15.02.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 02:57:45 -0700 (PDT)
Date:   Fri, 15 Apr 2022 17:57:41 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix uninit-value "data" and "mac"
Message-ID: <20220415095741.3zfuztivtgidvpqc@ppc.localdomain>
References: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
 <68484555-f763-bc42-eb4c-9cea2ee8dadb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68484555-f763-bc42-eb4c-9cea2ee8dadb@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/14 11:12PM, Pavel Skripkin wrote:
> Hi Wang,
> 
> On 4/14/22 17:12, Wang Cheng wrote:
> > Due to the case that "requesttype == 0x01 && status <= 0"
> > isn't handled in r8712_usbctrl_vendorreq(),
> > "data" (drivers/staging/rtl8712/usb_ops.c:32)
> > will be returned without initialization.
> > 
> > When "tmpU1b" (drivers/staging/rtl8712/usb_intf.c:395)
> > is 0, mac[6] (usb_intf.c:394) won't be initialized,
> > which leads to accessing uninit-value on usb_intf.c:541.
> > 
> > Reported-and-tested-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com
> > Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
> 
> This patch will just hide the problematic API in that driver. Correct fix is
> changing usb_control_msg to usb_control_msg_{recv,send}.
> 
> IIRC this driver does not want read various length requests, so it should be
> fine

Hi Pavel, thx for your review.

Sorry, this patch is just confined to fixing uninit-values with
modifying the original code as less as possible. It sounds good to
refactor r8712_usbctrl_vendorreq() with better API.

thanks,
-- w

> 
> 
> 
> 
> With regards,
> Pavel Skripkin
