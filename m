Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6225389BE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbiEaB5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243460AbiEaB5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:57:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E00836E16;
        Mon, 30 May 2022 18:57:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so976327pjl.4;
        Mon, 30 May 2022 18:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H1ALc2KclO05GRseCzU2tE4hpTR2Pi5sFXcUIZRtWsA=;
        b=nkg6VtSJWfIsQTK9CgwNVULu5G6bwGzzn9A5VzEeP7noKoColCe6jkyWHlX07QFT9a
         dWL8KXCS7wo5UPHNUS6jpGAS4zMJm6FY+SAFjP75kT99T/i7OHdX4NmD3EPWrZhMcm/W
         I0bKq++5lbMB7mLnN72GHIE4vUCigvAonIak84pCla18pl43f0YxdisSOKfaryCtuoLH
         iDlMV2PNN1ndtfc19tkAlOyhHj2ZCVpQAvwJVSi/an3hr9wCkg+kk5femcVzqeNPczTh
         qeHUcUSh4Q9ZCJVTXST4GJhYXl6R6kzTfsWfsBFt5VDYBLGIv99o7TrBusId5sFxvK/o
         y6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H1ALc2KclO05GRseCzU2tE4hpTR2Pi5sFXcUIZRtWsA=;
        b=NCuBTpCpCsd8kKK0v7oagC2iM3MOKKcZgepbQyrIsxOjtwC2+smJh0jkxaKSfKsEI/
         wzYrnoicpsKNtkGcxlmbnJ40Jh1FfsyMfKJG1s9rLsBrn+YiARL82//LSIa55jqJT4e9
         pw/aUpEN2RfJZAhsKWG9KQV+zZEUEP0W9vu9D7I0C/w1Sdj9KO3Z+6wFzrTXNnhyHfUA
         JK9tsNb/DPpmwL5/6TMoSLG7+WbkueGayc9lLDP2u6sGL0qzFlpSY3ocTpoOCVxsYYJR
         bRfhXKCEfwfHR2yLYlVGB0sb55c9mmKgDaY3LRbnsfwBPyjwCZmvs83BwxRVn5akcR9T
         OClw==
X-Gm-Message-State: AOAM532B1K9sX+BGWh5R3eCyiXQ2Z0GVdvd2qfRgwtb4qtiageDNxdKx
        XO+Rd52NjiSh/3NbqDtKkgw=
X-Google-Smtp-Source: ABdhPJwdpGnajHkcJbGWtfM8aj7t5A5jw2tSO0CVE0zmMWS2r9LENG0uH1TBhjzoec6IN5FPItXKLg==
X-Received: by 2002:a17:90b:224e:b0:1e2:754d:aeb with SMTP id hk14-20020a17090b224e00b001e2754d0aebmr22290797pjb.220.1653962267856;
        Mon, 30 May 2022 18:57:47 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:fc02:c347:e06e:9518])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902ea4a00b00163cf7023edsm3738990plg.243.2022.05.30.18.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 18:57:46 -0700 (PDT)
Date:   Mon, 30 May 2022 18:57:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        linux-input@vger.kernel.org, Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH v9 2/6] drivers/input/joystick: sensehat: Raspberry Pi
 Sense HAT joystick driver
Message-ID: <YpV2GNAJQhag9Osu@google.com>
References: <20220419205158.28088-1-cmirabil@redhat.com>
 <20220419205158.28088-3-cmirabil@redhat.com>
 <ecb3f627-3379-1b18-02c0-44782a2623d4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb3f627-3379-1b18-02c0-44782a2623d4@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, May 30, 2022 at 06:26:26PM -0700, Randy Dunlap wrote:
> Hi--
> 
> On 4/19/22 13:51, Charles Mirabile wrote:
> > diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> > index 3b23078bc7b5..505a032e2786 100644
> > --- a/drivers/input/joystick/Kconfig
> > +++ b/drivers/input/joystick/Kconfig
> > @@ -399,4 +399,15 @@ config JOYSTICK_N64
> >  	  Say Y here if you want enable support for the four
> >  	  built-in controller ports on the Nintendo 64 console.
> >  
> > +config JOYSTICK_SENSEHAT
> > +	tristate "Raspberry Pi Sense HAT joystick"
> > +	depends on INPUT && I2C
> > +	select MFD_SIMPLE_MFD_I2C
> 
> Looks like this also needs
> 	depends on HAS_IOMEM
> 
> since everything in drivers/mfd/Kconfig depends on HAS_IOMEM and
> since this 'select' causes a kconfig warning when HAS_IOMEM is not set:
> 
> WARNING: unmet direct dependencies detected for MFD_SIMPLE_MFD_I2C
>   Depends on [n]: HAS_IOMEM [=n] && I2C [=y]
>   Selected by [y]:
>   - JOYSTICK_SENSEHAT [=y] && INPUT_JOYSTICK [=y] && INPUT [=y] && I2C [=y]

Do you mind sending a patch?

Thanks.

-- 
Dmitry
