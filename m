Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6915134AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbiD1NTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242393AbiD1NTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 622483B57C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651151779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NRPdSokHoes2nKz8ut6Ka8cDht5BCp3IPjnMMamZWzY=;
        b=ZeIoNxncXcVbOmfcWsM6JIL4gei4KljBDGh30Kjw+IlOZF5zuqOhUQ805fSLp0St/lxWM5
        Kmn/NhixlGajHsCH3JSZX29I+9lJgm3khG6Loa2oN8Qz2ntSHWLCgIWLtmvdFv8K2kUIJT
        vd0Mv8G0w61VpdLC7y7MgjJPNWo4O58=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-rH_Y5Wa7OlWTwf10LeOmLg-1; Thu, 28 Apr 2022 09:16:18 -0400
X-MC-Unique: rH_Y5Wa7OlWTwf10LeOmLg-1
Received: by mail-qk1-f197.google.com with SMTP id bs18-20020a05620a471200b0069f8c1c8b27so3138964qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NRPdSokHoes2nKz8ut6Ka8cDht5BCp3IPjnMMamZWzY=;
        b=dboGXrWZDncdPUNM48mgsUS8SL4YzKZ5REfcyBmsVJ/Z+9sqgLUYy5PLCOjsQ7FjW3
         qCshxB1b9uSSXkPHTeWv4FwcuysfoRGtJFK4xr2zScdfsakX8YbQOBZFvlVcAJZJwkz0
         AlJPhdGd7cYwrRSDIzNGf2hUnoXZ0Td+T917YXUNCr+3xw1Wx+vusNaNeRlBCMPSUrAm
         6oxNezz+ncN2Pj93TanPn3oZPgKsoHeKd1nvpp/YNsxIg9VwBOlkqp+lwsNT5Y3NHUNZ
         GcAdiZk6tsMEvodXKAug6bU/qfEwkmXQ3rnMqTJiqHV1kW4ehTijLln0vULTH76X/aei
         NxlQ==
X-Gm-Message-State: AOAM531dArPDb3FjAdOLTQfANMgDDZky3L89WCgq+YLNJgMQdR2bZYQR
        5Q59rBLIjOLghktjjL2oNtFXem6/FrEUxudgFx7E8cFmAGZoF2agPnIm5OpCzgaebrC6M4S9Byq
        wKKzbiyosTZUBuDrc3fX1i7ob
X-Received: by 2002:ac8:7e89:0:b0:2f3:6ae3:338a with SMTP id w9-20020ac87e89000000b002f36ae3338amr12897230qtj.559.1651151777537;
        Thu, 28 Apr 2022 06:16:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9/6WIEvG9trtpR5c38666xWxMtS3pgU8Uku5RvhPr66YCsL7aqqkeRkNWBbvsJo2hSozEZw==
X-Received: by 2002:ac8:7e89:0:b0:2f3:6ae3:338a with SMTP id w9-20020ac87e89000000b002f36ae3338amr12897211qtj.559.1651151777358;
        Thu, 28 Apr 2022 06:16:17 -0700 (PDT)
Received: from fedora (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h18-20020ac85e12000000b002f341c6d20esm11748102qtx.80.2022.04.28.06.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:16:17 -0700 (PDT)
Date:   Thu, 28 Apr 2022 09:16:15 -0400
From:   Adrien Thierry <athierry@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: use standard print helpers
Message-ID: <YmqTnzoNVmU7PC88@fedora>
References: <20220427182439.424963-1-athierry@redhat.com>
 <Ymon2OgJhbwaH2H8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymon2OgJhbwaH2H8@kroah.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> As dev_dbg() provides the output of the function name, there's no need
> to keep it in here when you convert to using it.  Can you fix this up
> and resend?

Sure, I'll do that today

Thanks,

Adrien

