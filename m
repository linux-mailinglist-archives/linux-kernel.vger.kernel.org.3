Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6951C6C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383008AbiEESO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382998AbiEESOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:14:55 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 450485AEE7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651774274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kLRudaiszTccdqB1Vd77KpaI2iWJChA3O1GYOzzQuoc=;
        b=VFIs+if8/Jo09Ye/qt8En1bHfTLtyA3UW6kcMVDzIY21J9rucG6cBg3m1kpSAT0xg5tL1d
        I9JXF8I1MIK/uuNO/4QGsYtsPkKJLrSfbViFkxGOUHsmtwmVXZ31D6sWsYaO4d2QH5vbgc
        HGLpb/uClCHYmncYDX/eZflD+ZLYrJ4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-2v3KpGYKOBuehafzgq_wcg-1; Thu, 05 May 2022 14:11:13 -0400
X-MC-Unique: 2v3KpGYKOBuehafzgq_wcg-1
Received: by mail-qt1-f197.google.com with SMTP id x5-20020a05622a000500b002f37cb8b803so3960166qtw.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 11:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kLRudaiszTccdqB1Vd77KpaI2iWJChA3O1GYOzzQuoc=;
        b=ZCz96utBmn1aSIoaanRmvuH6xP0/abm5KYQZKNEnR+x/UGog1c49eHvOAZybttGzqu
         Tdpb2+wLDsUXKSdPJvgMP6Gu4cpGD9veHnotcp7EWZNpgRrfQh5qCPZGKol84+suxgKJ
         jYZD9y6dpUQ/aZEpFVNGf5sPW3zutpgAzcIGTNBylB4nNS2EN1Cfu9puQ4jkkHZE4Os7
         nnLQjytmygu5YCbGOAuexXm6JAyyYI0FmqfEQK6bPWqLb/2WrAKr0brtMwsOdYIXYSjJ
         Utma3oZUJEA2ar0VFFP6CTtO/dd5PECvqUstandy4Zd152b5AVa01MbMKYolm/OCpRUp
         xAkg==
X-Gm-Message-State: AOAM530qU4ONmN6KHHX5Mr+/9GqeOIbgeLWfYiuSkMrhzvOrToCk1pdO
        rlmOgXfWBFWyNxw6DKYx2IAyhZa7gdsdSwvrf6SWowNKdEZntMnmUXwdhxTcwxJQxAUUs1R3x1H
        ojqCOgI9qwvc2vqfwLQ+H7hpA
X-Received: by 2002:a05:622a:20f:b0:2f3:4e5c:3271 with SMTP id b15-20020a05622a020f00b002f34e5c3271mr25103849qtx.44.1651774272660;
        Thu, 05 May 2022 11:11:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwODdZVXSmIrr3XKHkaq4AMOb8tfd+YHR41zI+HxWst1xMd12GMM8tAoRhnMZaQTl0FAyFWCg==
X-Received: by 2002:a05:622a:20f:b0:2f3:4e5c:3271 with SMTP id b15-20020a05622a020f00b002f34e5c3271mr25103826qtx.44.1651774272473;
        Thu, 05 May 2022 11:11:12 -0700 (PDT)
Received: from fedora (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id d9-20020ac85349000000b002f39b99f68bsm1167214qto.37.2022.05.05.11.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 11:11:12 -0700 (PDT)
Date:   Thu, 5 May 2022 14:11:10 -0400
From:   Adrien Thierry <athierry@redhat.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: vchiq_arm: get rid of global device
 structure
Message-ID: <YnQTPmNAvpbQl5Ws@fedora>
References: <20220502183045.206519-1-athierry@redhat.com>
 <20220502183045.206519-3-athierry@redhat.com>
 <8483a250-da97-1875-4ea3-598f46ae96ce@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8483a250-da97-1875-4ea3-598f46ae96ce@i2se.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thanks for your feedback.

> i understand the motivation, but could you please explain more in detail
> why you decided to add vchiq_instance instead of device reference? I
> think vchiq_instance is a more internal structure which should be
> avoided in kernel consumers like bcm2835-audio or mmal.

I used the vchiq_instance instead of the device reference because in order
to get rid of the vchiq_states array (patch 3/3 [1]), I needed another way
to access the vchiq_state in the 'handle_to_service' function. So I passed
the vchiq_instance to it (I could also have passed the state directly
instead of the instance), and this propagated in the caller chain all the
way up to 'vchiq_bulk_transmit' and friends which are used in the
bcm2835-audio consumer.  Please let me know if you see a better way of
doing this :)

Thanks,

Adrien

[1] https://lore.kernel.org/all/20220502183045.206519-4-athierry@redhat.com/

