Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1515A0514
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 02:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiHYAQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 20:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiHYAQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 20:16:20 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBB36D559;
        Wed, 24 Aug 2022 17:16:18 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u6so9581754qvp.5;
        Wed, 24 Aug 2022 17:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Cmz7fm7ebAGzssd3xJv7sbaJQZ+F0fhv8ZeE1c0Oss4=;
        b=BbYn0gFpEl3t63BpXevWKjNWuybXv5dgRXX7NNXPmwPDV9WWbsy2TFL4AwK2WAOF4L
         Dl4uRGvFfS12lFjlJXalRvXeB5i7idDZdGtHs6QvTz2Xte8AaqV204WOLXovQE6EnXgW
         uGT1RLT6seACe4OxhcJBK9A8hwv2kMfHPBMs71iQN6+/obi92jtetOqAPRlh6Po2s3Fx
         mFAVPac+9ZrznBGYP/HjluetrUxYQKcCgU397MVRCTX+3r3gFoGFQcJNePmhXvgEe96q
         9fmyo6AYUA/3FC798Q2kAFuZZno1eELFCfz9xaJlGZPuUlmSKBIVqXOCyoJrI3iYY+5l
         5zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Cmz7fm7ebAGzssd3xJv7sbaJQZ+F0fhv8ZeE1c0Oss4=;
        b=P6726HKJkZ2AErPMY0RBbCmj8gGBX++3Zu7yUztzZkPHpEnl4CmpzhTw7iEi6x1FU8
         sqg3l8XVJpPolzLE72ijzeFwyo6FsPDgqBnS5HZ07KT9V1jSuAQkytf89vZWIxtLUu9Z
         Xy/RsX7+peg6BJy2ugCrmxlkx2wop4V44bb3Pu2Qpx14X6efIgdEBn0tHIgPTHGnf2D2
         3mVffu0t/NcQZt+D13zU4QN4oCpBSXnLsbnypkOI43yxIfgR8Y5p2DMGSaj5ao95SvNK
         c6exRCQskP4M9aDooekM0pzAw1aC2bMuHOD+hStHRKsZTUnacBypcXDMjS9TH8UvDZx2
         k2Uw==
X-Gm-Message-State: ACgBeo1+atvRqZ6Hu+AyW5ELh+BRyP6ZTPoZ8dG5vNIfSjZGsD9BjVc2
        Bzlmn7L7HgDPBFDElnckrVyp7tGQ28sxi3EI
X-Google-Smtp-Source: AA6agR7cudaJBqJrWLroeNxaCLhFvEoy84qSAugT7HJRE0bR27KLPBU9oxZxVKYL3iYhZ2vl888dww==
X-Received: by 2002:a05:6214:262a:b0:496:ccc1:12c6 with SMTP id gv10-20020a056214262a00b00496ccc112c6mr1524662qvb.33.1661386577905;
        Wed, 24 Aug 2022 17:16:17 -0700 (PDT)
Received: from valhalla (2603-7081-5203-61c3-0000-0000-0000-1449.res6.spectrum.com. [2603:7081:5203:61c3::1449])
        by smtp.gmail.com with ESMTPSA id u9-20020a05622a198900b003430cbb0006sm15193239qtc.1.2022.08.24.17.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 17:16:17 -0700 (PDT)
Date:   Wed, 24 Aug 2022 20:16:14 -0400
From:   Chris Carbone <chris.m.carbone@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: split multiple assignments to lines
Message-ID: <Ywa/TiT46IH4vDw0@valhalla>
References: <YwQGaLoBHH9C0aXN@valhalla>
 <YwRzJN5yORAtq8md@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwRzJN5yORAtq8md@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 08:26:44AM +0200, Greg KH wrote:
> On Mon, Aug 22, 2022 at 06:42:48PM -0400, Christopher Carbone wrote:
> > 
> > diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> > index dbd1159a2ef0..6f4c31635cc4 100644
> > --- a/drivers/staging/sm750fb/sm750.c
> > +++ b/drivers/staging/sm750fb/sm750.c
> > @@ -386,7 +386,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
> >  
> >  	ret = lynxfb_set_color_offsets(info);
> >  
> > -	var->height = var->width = -1;
> > +	var->height  = -1;
> 
> Odd spacing on this new line.  Did you run your change through
> checkpatch?

Yes; checkpatch didn't report any problems with it.

Thank you for your time,
Chris Carbone

