Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD850A8C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391771AbiDUTJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380740AbiDUTJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8264E4C7B0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650568021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J83rTwmfAjYlO7wUTZvmzVTeTlogsXahqrayjJ+BC7w=;
        b=fd583CzT5wYEiF66hdqWDTnHutp1cwhWriuoOTEazqNa9HLG4M+icSTrMEyPZSRnSBSSO+
        DS1Cvf9DrllCrTmKrK4NQZAd4e1ztWz7dw3jL08jQEoB8vpYDaMDj4e3Yx7rZrbuMSqZte
        5NabeT43jpR6T+1bNO4DGhxtdzPjc2o=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-Pjbe8XNrONeZx8tCg-RtTg-1; Thu, 21 Apr 2022 15:06:59 -0400
X-MC-Unique: Pjbe8XNrONeZx8tCg-RtTg-1
Received: by mail-io1-f71.google.com with SMTP id y20-20020a5e8714000000b0065494b96af2so3909589ioj.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J83rTwmfAjYlO7wUTZvmzVTeTlogsXahqrayjJ+BC7w=;
        b=QZ1FplU80k4+dhiOv6Raz73FhgAuMvN9p77cbJ8f2S3/s53zpj0pr4RTenJb1O+YBb
         uBCN4RwkQxgtLIuyY176PUNSeGbs4HZmGKMMHa++Gu9dfuXPKqLJ9vH2f8W278hrjNmI
         /B6nIIXxig1i0ngdGYiJ1GujfYOs+19cuhhvweg7uGbozslp82uN3kRPSgko37Us+KhO
         r97VryGZiLBlD7l4I+u5AnB8Hd+xWaTGPdxDLAVR7DSCWiPs1hOyAq+m9+ARZhY2iCWS
         89dKJMohTV53apKuMgNGwBC4Y/4UnPSMofkP5FPYSfGob8aRrVpAr5KApfC0SkhVEmnw
         TQaQ==
X-Gm-Message-State: AOAM530EcIUSn2wQH8aqAPjGHcuaVFE+96WgigHAc9hrNFSaPUz+SG1q
        EimnU2DHZcxUW8xQ69nsgmrBTEDDawc+R3iz8ztCnZ1dP09lgAJ2DV5oXIv2vFi0RoID9SYLPju
        U869ZrZS9rGDAO61AGEwUPDnd
X-Received: by 2002:a05:6e02:1a0f:b0:2c9:a83b:b69e with SMTP id s15-20020a056e021a0f00b002c9a83bb69emr531677ild.4.1650568018620;
        Thu, 21 Apr 2022 12:06:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx63YiYj7I8DXD/H5H3iF/QzWB0gDKjqesUTLmJLmy9zG3eUSh7SdyFF0W6OI+0M5nRllha2Q==
X-Received: by 2002:a05:6e02:1a0f:b0:2c9:a83b:b69e with SMTP id s15-20020a056e021a0f00b002c9a83bb69emr531668ild.4.1650568018408;
        Thu, 21 Apr 2022 12:06:58 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id m6-20020a923f06000000b002ca74f4fab2sm12692154ila.14.2022.04.21.12.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:06:58 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:06:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v6 08/10] KVM: x86/MMU: Allow NX huge pages to be
 disabled on a per-vm basis
Message-ID: <YmGrUE0QgzRpCJxU@xz-m1.local>
References: <20220420173513.1217360-1-bgardon@google.com>
 <20220420173513.1217360-9-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420173513.1217360-9-bgardon@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:35:11AM -0700, Ben Gardon wrote:
> +8.36 KVM_CAP_VM_DISABLE_NX_HUGE_PAGES
> +---------------------------
> +
> +:Capability KVM_CAP_PMU_CAPABILITY

s/PMU_CAPABILITY/VM_DISABLE_NX_HUGE_PAGES/?

With that fixed:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

