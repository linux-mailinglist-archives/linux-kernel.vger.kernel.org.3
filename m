Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15CE4FEE72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiDMFUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiDMFT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:19:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A80D65E7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:17:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b15so1019662pfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qKdnsHbCO7pP3uEagIAEVEW5aLCkOugF8FrrZybf0t4=;
        b=Y4SbTLcFvJTIwS1+Ez/SWHb1/JMXuzjPG+yjUp+RBTwjzogohF+Rw/KDrRMf0Uhpl9
         nkLeG3868Zo+ZT48Yx6WlyiSvcNo1IZ33Ini3NzSn8Milk+pBrRFCT4b8R6xSR61ffmZ
         1fBUHIy5a6PuZEsqKh1lYBWNDxT7zvRZQQfb1J6nOo6q9OgLqIBjvHYBH9ujqSeITKSW
         m+8u6QsjTLoZAghpbnFxjRv1h4S3OVH3nVhatr/e8VX0goLycQM6GxoKcp8FYvsTr+xr
         OfM+t+grXOUfutjmlJJBDGAKG+65P1XWV5Vyc0KkjuDsO/Zy5DKPNBrQ4+Az8SeOu6ut
         exBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qKdnsHbCO7pP3uEagIAEVEW5aLCkOugF8FrrZybf0t4=;
        b=Z/2bP9zhQDXCmneQeGwXzXfmM0RhA17I0ZQgE8vY6oQWhcWVnXnnW8Z005xWvCAnbs
         tMX+pWdid22X0oQjiWrkMjPuX6qfdBFhgAZtAu96nwbb0EG2JlEp1viNapZxdfcRMKIv
         yGS0bEQISEHypWPV3y84ZKagcHStPSCjktLw2ab5sEKT8w079PAs2EuryRI/JvHXPcFw
         L+uRKk6psbT/hnZW7mcsJBaKETkdVOgggK2B2aT2LjiVr96BMZO5A/z63UireOUYuKco
         GVRFSGbw9DkcERPr7NHWmmPW2Yq6ls81ggjk0ntswgvyo3eB5XUOIDIE3L/gJj6e2ilx
         xxTw==
X-Gm-Message-State: AOAM532T7ufeVn0IPrR27/b2hncofPm+tCcJJ7db+aoWnVBTPw9BF5W0
        Tiy6+VH6faPEtBtlKX+LT0I=
X-Google-Smtp-Source: ABdhPJwlNCjgnq3rWTz0ZvV+7x7rjSzlzuZX/W+ct/kDNdSIY9PRxDWO4sBMxMwMB22OC2O3yEaMRA==
X-Received: by 2002:a05:6a00:181f:b0:505:a395:3ad5 with SMTP id y31-20020a056a00181f00b00505a3953ad5mr7957568pfa.43.1649827059037;
        Tue, 12 Apr 2022 22:17:39 -0700 (PDT)
Received: from localhost.localdomain ([119.3.119.18])
        by smtp.gmail.com with ESMTPSA id g1-20020a633741000000b0039958c06c53sm4396441pgn.61.2022.04.12.22.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:17:38 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, xiam0nd.tong@gmail.com
Subject: Re: [PATCH v2] drm/gma500: fix a potential repeat execution in psb_driver_load
Date:   Wed, 13 Apr 2022 13:17:34 +0800
Message-Id: <20220413051734.5975-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAMeQTsaXM-ddGLukxuEJvm+0UtuJEZGL_5KEY8h9ZPH-ZxmBsQ@mail.gmail.com>
References: <CAMeQTsaXM-ddGLukxuEJvm+0UtuJEZGL_5KEY8h9ZPH-ZxmBsQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 16:58:24 +0200, Patrik Jakobsson wrote:
> Hi,
> This would work but using gotos like this easily turns the code into
> spaghetti. See "7. Centralized exiting of functions" in
> Documentation/process/coding-style.rst for when to use gotos.
> 
> In this particular case I think we are better off using an
> if-statement. What about something like this:
> 
> if (gma_encoder->type == INTEL_OUTPUT_LVDS ||
>     gma_encoder->type == INTEL_OUTPUT_MIPI) {
>         ret = gma_backlight_init();
>         break;
> }

Yes, it looks better.
I have sent a PATCH v3 with changes as you suggested, please check it.
Thank you very much.

--
Xiaomeng Tong
