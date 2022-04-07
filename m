Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5F4F8142
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbiDGOGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245594AbiDGOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48614E1252
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649340240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8dmlhw2gM3dighZKD1hw4c9m67LEmQRFc8UEGhxCeHA=;
        b=ABtSafK/E3WPndrRSRq5TIMQk5v7k+s81fUZfv8hukdPIA5bH+HX/677ZZUvyQv+Ee8hAr
        AQY2M4gyqhEVw6hvKU9bW2pQkUtz/ETU16+h8LNCX/CKfTzVfGpzQN5GsmtZFagaqv+7DH
        s3H/Ar+nSIrZTX30qQpxr8Eq5MHQ6V0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-5ytghaBRN9yYNsoxVIk9QA-1; Thu, 07 Apr 2022 10:03:59 -0400
X-MC-Unique: 5ytghaBRN9yYNsoxVIk9QA-1
Received: by mail-qt1-f200.google.com with SMTP id k1-20020ac85fc1000000b002e1c5930386so5583093qta.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8dmlhw2gM3dighZKD1hw4c9m67LEmQRFc8UEGhxCeHA=;
        b=FohPMhfmHji8lwKpUI1nfrDOa6s/eK2dMhnlH8zWR2F+luQA8kOVNWJSHDa+pTGLbn
         Yrqy3FM8ZUBzuEWLfvmwAs3UHNetweIXDQxK52Q5LSi1K0tb7/o/hUleuVXWpHBqtOz+
         hyQOwmn6o2Ph1q9WGV2m9lupQnh6W2npjl7xeNYPtm/T/foYVPP4/zMiQq6xbJWNQpQQ
         EF1hV+k5x1uICByBu9Qa0p9wCSBBkhKEwyZAEZhATMCmpkfNOZ8v+XYUV5Cp6HHGXCLu
         ETK7zAIJs1j9UTia7eH5YvWCTjMG9gfMcPvBziD6MyUyWqzTqTPRxnypQB2HKvbVCV8+
         5HOw==
X-Gm-Message-State: AOAM532CxEyrgVF/M96rtXcvh4utNdlGKVtQOaQYST8gAl/YQlWXFCB6
        EUri/wxxW6B0QhKA89CKWYrmcHxrcNwIExxHUBM2AMoTMyiHURxdd4lc12J56xpCg1Y4IGB9yVt
        2Q95sKcGJ8IPQWCqbXC/sQzlF
X-Received: by 2002:a05:620a:424e:b0:67e:4c1b:c214 with SMTP id w14-20020a05620a424e00b0067e4c1bc214mr9398815qko.651.1649340238616;
        Thu, 07 Apr 2022 07:03:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeuhfUl7E5olUFie0FR1INlu5Q2ZTtT17yGQlnofo6l7qsijU3A/ijXWkDpwqeMJySvpGrYQ==
X-Received: by 2002:a05:620a:424e:b0:67e:4c1b:c214 with SMTP id w14-20020a05620a424e00b0067e4c1bc214mr9398784qko.651.1649340238357;
        Thu, 07 Apr 2022 07:03:58 -0700 (PDT)
Received: from fedora (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85e06000000b002e1e8a98abbsm16006501qtx.41.2022.04.07.07.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:03:57 -0700 (PDT)
Date:   Thu, 7 Apr 2022 10:03:55 -0400
From:   Adrien Thierry <athierry@redhat.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        linux-staging@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 0/2] Add support for bcm2711 in vchiq_arm
Message-ID: <Yk7vSzk2XD+55EK4@fedora>
References: <20220324172647.167617-1-athierry@redhat.com>
 <d20fd8f2-c47a-2f3e-4efa-be705f1517b9@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d20fd8f2-c47a-2f3e-4efa-be705f1517b9@i2se.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thanks for your feedback.

> Could you please explain your approach, especially leaving out 36 bit
> DMA support?

I realize I overlooked this 36 bit DMA support issue, I need to think it
through a little bit more.

> This is a really bad idea and caused a lot of trouble in the past. A lot
> of the issues in the Fedora or Arch Linux forums or mailing lists
> results from this idea. It wastes the time of the kernel developer since
> these DT files has never been reviewed by the devicetree maintainers.

I understand, thanks! I find the downstream dtbs convenient because of the
overlay system that allows you to easily enable certain drivers, but I get
your point.

Best regards,

Adrien

