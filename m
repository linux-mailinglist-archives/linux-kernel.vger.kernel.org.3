Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C9A5B0FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiIGWZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIGWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:25:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D305D118
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:25:44 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v4so14880717pgi.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QyjJV/dv4syjEBjDQwkjVgR2N/oSfEod1xoF0knwswc=;
        b=L6mRl8n3ct1fXOW6uKCmPxsWTPsnOB0qpk+ajn9S06Jx894QMKZXGRrWV5hWgwqNqd
         5ofQNxt0rAFDUbFoRvJOFaeOcnm0Vd+v55ZpMMG/Y8+UiO9gZR3FfmhmANsMjaq06DSp
         rVGhHOujJLC4oxElUK9qdObr8b8fCPaRoIAX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QyjJV/dv4syjEBjDQwkjVgR2N/oSfEod1xoF0knwswc=;
        b=T9oQJkIu7HJoU/a0AMpL9XCtDecXu+I1yI+igtZJV8Dj22XCM5/zGlMqI/ueqUqamm
         43ffMGLhqUX5CJ1qXmG5m7fQu5iQmsiQ3tOz9gxhF6C5UVsrG7gH8wr9g4FqCrc8/ex/
         bft+l59U8XwlnjsgXMu8RQTvgJ/8r8R/3Rfd2d+2UjT+RGOp2crixVr3ZRvQ0QhfM9rq
         5X6JPJhgZWlGi/RqUZXK/PGJuhnDfzGdR+J7HrcGN7mvz7M0DobfYw5wDNB6Bv0/J6/M
         /7hIicJIjSp4sS7al+e7HbvLXqF2u9gIfmaeklVx6ghpNTkEdk6AuV7dqvO/UU7hiZo3
         +Z9A==
X-Gm-Message-State: ACgBeo0zpL2mRomeEhGFlqrzbDf+p+yW28LcefswJCsoii2zAcs1kFaL
        G4c7Wwz9H0fjnllKvx2HSyO/Yw==
X-Google-Smtp-Source: AA6agR5iHcWDhRr4BDgvhUJzrnupCnLRp/N6JDkJrQZ+IYydlT/KMT7IWLMAtD22CDm1v+X3gIof8w==
X-Received: by 2002:a63:4e44:0:b0:42b:1fff:72d1 with SMTP id o4-20020a634e44000000b0042b1fff72d1mr5323048pgl.432.1662589543549;
        Wed, 07 Sep 2022 15:25:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090a49c700b001efa9e83927sm141953pjm.51.2022.09.07.15.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 15:25:42 -0700 (PDT)
Date:   Wed, 7 Sep 2022 15:25:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: usb: pwc-uncompress: Use flex array
 destination for memcpy()
Message-ID: <202209071525.AFFA11872@keescook>
References: <YxjpMMUb3WP5Rbu7@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxjpMMUb3WP5Rbu7@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 07:55:44PM +0100, Gustavo A. R. Silva wrote:
> In preparation for FORTIFY_SOURCE performing run-time destination buffer
> bounds checking for memcpy(), specify the destination output buffer
> explicitly, instead of asking memcpy() to write past the end of what looked
> like a fixed-size object.
> 
> Notice that raw_frame is a pointer to a structure that contains
> flexible-array member rawframe[]:
> 
> drivers/media/usb/pwc/pwc.h:
> 190 struct pwc_raw_frame {
> 191         __le16 type;            /* type of the webcam */
> 192         __le16 vbandlength;     /* Size of 4 lines compressed (used by the
> 193                                    decompressor) */
> 194         __u8   cmd[4];          /* the four byte of the command (in case of
> 195                                    nala, only the first 3 bytes is filled) */
> 196         __u8   rawframe[];      /* frame_size = H / 4 * vbandlength */
> 197 } __packed;
> 
> Link: https://github.com/KSPP/linux/issues/200
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks! Yeah, this looks very similar to other transformations like
this. And this one even had the flex array already! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
