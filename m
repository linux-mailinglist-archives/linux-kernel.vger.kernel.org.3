Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DA158F455
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiHJWYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHJWYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:24:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325488C474;
        Wed, 10 Aug 2022 15:24:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p18so15444095plr.8;
        Wed, 10 Aug 2022 15:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xzeD6voWihwA7O1iWRcbOmK/gaYb2Slx+uQTzhsYet4=;
        b=IR/P9aNTP0d4YNsb3OD7/lV9JipBAlC0ciE9MZDupclvNF6CkgxiAB6HEjC8Ooq4eX
         aW7yx7QfN7or9Lcmi4YvEwJ2lGB68DKTvkPlKiX2I1Ci4UYQcLVj31CW5KFSU7qWMpir
         q8fVE+iABJ2jCY2BA71vjs+Aup5aWllW40DFpyLGx4CPvi6oIJELBGysQwdpVTC2rUEw
         3k7C4+gFHsicSFmCstGLSulLaS9Z/wjyXcWz2+ZXWHNOHYK9z07MEBn8+wdVbOVRB0g3
         nLEP+FpZCghyFNLyDFiN5B35ZHhDs+s3FY/dPc45xKvFHucoxgyq9Dx+ULlDkIH1YS86
         hKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xzeD6voWihwA7O1iWRcbOmK/gaYb2Slx+uQTzhsYet4=;
        b=IswJMsD/zsXyjkW3oVhOFW8snFbKGOShECRURz2i0spCtIADCby2TRLvR+7G4VtI+P
         h9G1FefcLrg7nU2GlAfzaYl8ikUGPlSqFHTS40j9j8uB7iZTfdKFLm2WYOZgTFGZntrO
         dB3UcakIKg29KeNEUBjwBTuAmxZckk73yV1kEe368Gimv1jMU1NJu3u3E2VxoIjToXhl
         nSoJGiGCydOS7VNFqVXGQrncHw+MZGCxaRudzbv9N3tHA0X6v27/72CtnT/ggeW9yj3D
         2MCrkuaCNPbmuPMHraUVGm5tkSuV7NCp5ubyQncc23Ctwk0cBpxOzmKflhI4+UOoJfkP
         0Zzg==
X-Gm-Message-State: ACgBeo3zOEUPs2bL0/By0kjnAvzIMqBR6WUCbcWZC+ekATYuUttBcGEX
        taeVyt74QgdhQaPWy9ozQNs=
X-Google-Smtp-Source: AA6agR7DxhX2KJxczQue5a3R2LZ/uGbYZTbPrC5uUwZNBOoIMb3+NB2PGAUlmQL55M5aWuOOgk4YYA==
X-Received: by 2002:a17:902:e892:b0:170:c2f:cb40 with SMTP id w18-20020a170902e89200b001700c2fcb40mr24330039plg.2.1660170242585;
        Wed, 10 Aug 2022 15:24:02 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a3c8:d6b9:a5c2:1eca])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090a0c8100b001f3244768d4sm2196480pja.13.2022.08.10.15.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 15:24:01 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:23:59 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: elan_i2c - convert to use dev_groups
Message-ID: <YvQv/1PvZq0Gnv8x@google.com>
References: <20220802162854.3015369-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802162854.3015369-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:28:54PM +0200, Greg Kroah-Hartman wrote:
> There is no need for a driver to individually add/create device groups,
> the driver core will do it automatically for you.  Convert the elan_i2c
> driver to use the dev_groups pointer instead of manually calling the
> driver core to create the group and have it be cleaned up later on by
> the devm core.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "jingle.wu" <jingle.wu@emc.com.tw>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thank you.

-- 
Dmitry
