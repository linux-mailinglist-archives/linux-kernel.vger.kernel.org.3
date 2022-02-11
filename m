Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860164B1E24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242185AbiBKGHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:07:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiBKGHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDB9F264F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644559657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOs06svCRskfevOs7wvSSDMydwtyNRGcYolT1X1xpFc=;
        b=d5+rL+hicUBGXazYhFic7mrTPAJbR6+sZQPx3QfKMKIA9wChw1Tm2ro/eD7JLWN2J8VhJN
        Mpsf0DEZKqtRODlw10aRzfV/185M+n00hjgb+ulKLab0c6lmSybs+QLKLSoCqtr9fEOBXR
        zIUSmGSjF+Rm/+wIJQORyb23z3ax3IA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-tVrN8PlVMauU2iM980UqiA-1; Fri, 11 Feb 2022 01:07:34 -0500
X-MC-Unique: tVrN8PlVMauU2iM980UqiA-1
Received: by mail-lj1-f200.google.com with SMTP id a13-20020a2eb54d000000b0023f5f64ae4fso3653702ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOs06svCRskfevOs7wvSSDMydwtyNRGcYolT1X1xpFc=;
        b=p1phHJoxOptodANwGOHbojc1v3ziM8jn6ZBQgClbor/vPL/a9TkChFszjMgqumOI+p
         pv3AcCriKEAP/w054bGZ7wm2WQvj3XlHNQToiHq3ekTYjRTG2BHMjyu23oaz2d6hId6B
         oIPeQmHguORMviocP/JmITN6jzOxpaXr9SRbn7BYTjllFzAR8VAqTYlZpdPEzp4r7gwW
         urpKnf8jHYw2wPRulqT2epZ+8ad1XcshphkpaG8InG6Tb1Hr6mAQBCZszz6oLQY8eH9/
         qFbTAEKwHnthM5Su+S0rqC1tONEujagfupYUwaIF/8dq0vRW3deffNHjIwO8y0slu0iN
         tBhQ==
X-Gm-Message-State: AOAM5327+irL8aUnh23egRoxsTYtV1ruGTiI90ShhgwksxqePSb2MQNJ
        QFN6zaNYPPQbSdq8dU+aMKgt0eR+ghyn2+2iilOhZAzpB7FWIxYbNW3Fq5ldIQ1zTc4Ox7lbIzP
        CZp56XXj8uHd0WJ3U8aLzgKK3sARqAw+VX5KMu0zT
X-Received: by 2002:a05:6512:2606:: with SMTP id bt6mr147621lfb.187.1644559653253;
        Thu, 10 Feb 2022 22:07:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoWLii9XxRSj/jXk7N/fLFlqzjSP5PWx4yrCtcPB/EmY7s+7To2p8aZkqI47cuUUV+IBXyzuvMn1WIvmoFkZ8=
X-Received: by 2002:a05:6512:2606:: with SMTP id bt6mr147608lfb.187.1644559653059;
 Thu, 10 Feb 2022 22:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20220208022809.575769-1-leobras@redhat.com>
In-Reply-To: <20220208022809.575769-1-leobras@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Fri, 11 Feb 2022 03:07:21 -0300
Message-ID: <CAJ6HWG6mEssijXC63kTA+ARNG-xupcFsrU_JBibO2d33CTt8vA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/kvm/fpu: Mask guest fpstate->xfeatures with guest_supported_xcr0
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed I forgot to include the EXPORT_SYMBOL() so kvm can have
access to fpu_user_cfg.
Sorry about that.

I will send a v3 shortly.

Best regards,
Leo

