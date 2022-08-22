Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2508F59C095
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiHVNbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiHVNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:31:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F92275F7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:31:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gk3so21210927ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8r7BIjoasIUEZdXg2N4q2u4F3zO3DOtklhLZqt6JWWg=;
        b=D60msXWmUqbwg/uV8lvURpYnUYQo0L2zrsdfg4Yez2C2yk+mKZq4gDOfBq6lTm/xsb
         1luO+bvGH0blaw7aqMaXBlZAOHiobEbk9vP9HOIBhBGoWdXmfj6Bk3Xr+NSr7+9Q5Jzw
         uMN7FJUAN57h5sp0tOMxjBWsJvgVmc0TD8cmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8r7BIjoasIUEZdXg2N4q2u4F3zO3DOtklhLZqt6JWWg=;
        b=v4JwF/yyxAsUAvdIlMDUpOTfa4p92q7cgeZAgtINSj6lTi/pjsYJaQZl9au8nYPsN/
         3q8r650MAFhnLLUSUPjw55tAOWv1zyMs5TMhRU09ILU4ivl9cjXPSzlwkrUhXU1FdUAp
         WhsUXumNZrfFfWd6m98ZCUQtULRrT8evtvpYVR5ViYXEI7FP9DYuF5W8yDvy3BHaVgGf
         9ZPsun6S87DtbKmBnqdz/DsZpIj3x4xKA+McKeGnPYruB0Tz1V7OmopEhmAVuN2sMFcX
         Y5oZlSLn3KLPxfRCvLold8jVN61V4JH3MCGrggVtgaz1dgj+LzSNjp4BJ2eU2aBs7Fnp
         ZPSg==
X-Gm-Message-State: ACgBeo0MvAQaSC54pzVW5TSAazHjSf9e7szWW4WCYSucLQmP9lcTX2XM
        Ke5ob/7jyvsXNtspzECz14nVAhUJnNzrgbKf
X-Google-Smtp-Source: AA6agR4cMJi4QZDEmrIl8aiE53u1XkQN8brkopflOn/DuwVyLGs9E7OXUpAY5c+CVrvWinhvw6pGew==
X-Received: by 2002:a17:907:9605:b0:6f5:c66:7c13 with SMTP id gb5-20020a170907960500b006f50c667c13mr13640253ejc.66.1661175072692;
        Mon, 22 Aug 2022 06:31:12 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906309100b0073ce4abf093sm4966682ejv.214.2022.08.22.06.31.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 06:31:12 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id vw19so7556727ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:31:11 -0700 (PDT)
X-Received: by 2002:a17:906:9f2a:b0:730:bc30:da30 with SMTP id
 fy42-20020a1709069f2a00b00730bc30da30mr13133746ejc.763.1661175071574; Mon, 22
 Aug 2022 06:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220808134106.70100-1-ribalda@chromium.org> <YwN+fU5ez0L5pi1j@pendragon.ideasonboard.com>
 <YwN/jeElxyXpyyfU@pendragon.ideasonboard.com>
In-Reply-To: <YwN/jeElxyXpyyfU@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 22 Aug 2022 15:31:00 +0200
X-Gmail-Original-Message-ID: <CANiDSCvyhUORSp7831DJsQGFF8Bw3uzEoTTV9FG8qunu-KrMyw@mail.gmail.com>
Message-ID: <CANiDSCvyhUORSp7831DJsQGFF8Bw3uzEoTTV9FG8qunu-KrMyw@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix InterfaceProtocol for Quanta camera
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 at 15:07, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

>
> As this is a v6.0 fix, would you mind submitting a v2 with these changes
> ? Mauro could then pick it up directly.

Done. https://lore.kernel.org/linux-media/20220822131754.102393-1-ribalda@chromium.org/T/#u

Thanks :)


-- 
Ricardo Ribalda
