Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF753054D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 20:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350158AbiEVSxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 14:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiEVSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 14:53:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C1C289B7;
        Sun, 22 May 2022 11:53:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gi33so16108408ejc.3;
        Sun, 22 May 2022 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AXF5cjgLABmGiDD3jbseFHxdx24aXW4ewbn3+cYg/Bs=;
        b=YEkQ15WgaS8kX2AYmYZ1sb1eK1vG3/cGLKdonSEOdkCLMSMTEjfTtUAiZIDE2aRepV
         FnnAkvYPTzEdFXoBLnhd4eARXFfna798yKUl4H4UXuu5N11eKjO6Hxpcf1bDRhSAB99O
         TGaHu/J+hfNlxHkUc0f2N95lIyiyUGrsN0J4eKnQF6sFE13P2yLW6Fzesi36o5Zt1W1G
         21TAx2f2ihMhVsna2OFgjGcGX63kYB5/WVBBa35kLsuWOH0b/XKLG+eLNy1F6hoyUfGM
         /OvfoSXw77+aYeQn9tka3wtT1pFa8qs94JIy/qOffZ0WpoXHooeb/Z54tYEGfb4kJvdX
         lxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXF5cjgLABmGiDD3jbseFHxdx24aXW4ewbn3+cYg/Bs=;
        b=cXkVHAz+hWYL5mJVCt1TilEpPM0t6i0e2ndBuBbk93/PNa1eumQXSkuf4vbUAX9nOn
         CL63gBM6iEPy749EhBrfSCZO3V+My1t2J+IFZyRHnnlgG0Jy3msFikvfyoXP0Sz7Q3Xc
         VPD8Xz6aYQTBeHs+zd8za4Kr5kIt0GoQKqTbRh1m0pzc067+rfEHFVdIR3SSlvPQDYGH
         nz6FT2GZxkQwnzhxykPHlSrQwWjrnm5sYI5El+F9Jk4VnkdadhiAttiQHCnIFW9Y0Odk
         xXeh2wlFRgB7UbrWH06TjCMbn7S7VP+Myjy/hI2Ml6yiYrJ94QlPlysEL0Igf5XNjLKx
         NtcQ==
X-Gm-Message-State: AOAM5319aj7A9eXpj06oVuZGguKDtdrYQITxFJkWyvSGf56jhk3N9bpD
        2RZi0+o84cteeIqpb2gloxA=
X-Google-Smtp-Source: ABdhPJz7KfUzOw11j4aYWCASH49EDChI8fGECAhn4Mm+/sq8xGo0/4cxkmCNLVWVm+yxtEshipeCXQ==
X-Received: by 2002:a17:907:3e04:b0:6f5:1132:59de with SMTP id hp4-20020a1709073e0400b006f5113259demr17563112ejc.755.1653245591527;
        Sun, 22 May 2022 11:53:11 -0700 (PDT)
Received: from DESKTOP-A98GP49 (cable-178-148-254-8.dynamic.sbb.rs. [178.148.254.8])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709067ad000b006fed8dfcf78sm695815ejo.225.2022.05.22.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 11:53:11 -0700 (PDT)
Date:   Sun, 22 May 2022 20:53:08 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dan.carpenter@oracle.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Fix an error handling path
 in aqc_probe()
Message-ID: <YoqGlLIORBqsrAqW@DESKTOP-A98GP49>
References: <be6b955d50de140fcc96bd116150b435021bf567.1653225250.git.christophe.jaillet@wanadoo.fr>
 <YoqCKdfYQKyrFtxN@DESKTOP-A98GP49>
 <e2a64cca-add2-7fcd-0327-5d217f1d3762@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a64cca-add2-7fcd-0327-5d217f1d3762@roeck-us.net>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 11:37:52AM -0700, Guenter Roeck wrote:
> On 5/22/22 11:34, Aleksa Savic wrote:
> > Thank you Christophe!
> > 
> > Aleksa
> 
> A Reviewed-by: tag would be useful.
>
> Thanks,
> Guenter

Right - that slipped my mind, sorry. For the patch:

Reviewed-by: Aleksa Savic <savicaleksa83@gmail.com>

Thanks,
Aleksa
