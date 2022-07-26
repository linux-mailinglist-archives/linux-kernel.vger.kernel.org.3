Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E73581C04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 00:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiGZWOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 18:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGZWOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 18:14:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E889837194
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:14:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so3860wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2BNZBH6aH2hmzAVjxAXe2B3bFnNk07e2E6obsWNMFAI=;
        b=TFg3XsIb+76QDPMcxkQaZbSOshh14xRB0PsP+U6uwS02Un4pRDjObe1NZ5EjbSqf7a
         yqbG+jinsvjszdmmC98/OiapkFrlqWijAQUhDncs8klUfKHQkvWHNVVnk6yWJ2BpbvO7
         GjBb+3awzXJkjq3YCvioXjVZQorcyEEvMdEqNwWvhnl0oJw9qcjj0fIACbVrlZAd/WY4
         xt68CeiA1J6MTqSrHRJGG9qNguHRSyjqzH7ZZaq0H9pvLowZfoYxJbotWGkhkB3gJ4eG
         0hlFKE7LqR/ecf2DYhk6XXewqp13deZiQJz0KpD4B8ISMN3yyfNn0R8mdhENONJbBxTu
         Pnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2BNZBH6aH2hmzAVjxAXe2B3bFnNk07e2E6obsWNMFAI=;
        b=jhScs9byQHSzsPUxrxzjMMBs7J15P9gQQRkVqa+u+94CE/+V62b2EiJqBUGO/FiY6Y
         72wDsNcYZlbmRN2hvjqcabdbpErV1/IvkMVtedAksQk90IF40HsO2DyjrJLAskhuXR2n
         Bd8CtqT49LI3P1FLOrKdsRiLv++9xRfFmN/vgHEbWOneMr/2W+/193lQWN2eoTnid3OO
         9bxlqFN0dsWWgXXK8PkIvRwCEbMwy5o+R0RauU9fxcm10QKALCdbVXvs8Q3LK14V+SJC
         KPaOQTQF0chRfO/idXFcnzXVHplKFFYp4Jg4RxKDSMeDAYMOD9FdfD9TgESTzCRuF/+F
         OSUA==
X-Gm-Message-State: AJIora+agDbKodAJlLd+uCietkkFeYbUxM1emva+bM0qFYkLi/sOlZ+h
        KhFfT0LJE85djJl/CANUETdgyA==
X-Google-Smtp-Source: AGRyM1tFAIfVPA/3YdmL72kFmetRbzi4kUI5W0bJ8B6RxY+iVQo1D3tZcCHE02lTtOeCeS2n5hc4Yg==
X-Received: by 2002:adf:facb:0:b0:21e:4f54:9651 with SMTP id a11-20020adffacb000000b0021e4f549651mr12679618wrs.378.1658873670376;
        Tue, 26 Jul 2022 15:14:30 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id h17-20020adfe991000000b0021dd3e2fb60sm18615549wrm.0.2022.07.26.15.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 15:14:29 -0700 (PDT)
Date:   Tue, 26 Jul 2022 23:14:27 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: convert rtw_pwr_wakeup to correct
 error code semantics
Message-ID: <YuBnQzsF3g1bL82T@equinox>
References: <20220725220745.12739-1-phil@philpotter.co.uk>
 <20220726133559.GP2338@kadam>
 <20220726154602.GQ2316@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726154602.GQ2316@kadam>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 06:46:02PM +0300, Dan Carpenter wrote:
> On Tue, Jul 26, 2022 at 04:35:59PM +0300, Dan Carpenter wrote:
> > On Mon, Jul 25, 2022 at 11:07:45PM +0100, Phillip Potter wrote:
> > > Convert the rtw_pwr_wakeup function to use 0 on success and an appropriate
> > > error code on error. For the first failure block where ips_leave is
> > > invoked, use -ENOMEM as this is the main cause of failure here anyway.
> > > For the second failure block, use -EBUSY, as it seems the most
> > > appropriate.
> > > 
> > > Finally, within the functions rtw_wx_set_mode, rtw_wx_set_wap,
> > > rtw_wx_set_scan and rtw_wx_set_essid, pass the error code on from
> > > rtw_pwr_wakeup as appropriate now that it is converted.
> > > 
> > > This gets the driver closer to removal of the non-standard _SUCCESS and
> > > _FAIL definitions, which are inverted compared to the standard in-kernel
> > > error code mechanism.
> > > 
> > > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > > ---
> > > 
> > > Changes from V1: Act on feedback from Dan Carpenter:
> > > * Try to use more appropriate error codes than -EPERM.
> > > * Revert the places where existing -1 was converted as they are out of
> > >   scope.
> > > * Preserve error codes in places where calling function already uses
> > >   proper negative semantics, so that they can be passed through to the
> > >   caller.
> > > 
> > 
> > This is a much better patch, right?  Everything hangs together better.
> > 
> > There are seven callers which need to be updated and all of them are
> > updated.
> > 
> > Reviewed-by: Dan Carpenter
> 
> Oops.  I messed up my R-b tag.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter

Agreed, much cleaner this way. Thanks very much for the Reviewed-by tag
:-)

I'll attempt to structure the others in a similar fashion, as far as is
possible anyway.

All the best,
Phil
