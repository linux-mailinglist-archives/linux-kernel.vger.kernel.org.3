Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137E156486F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiGCPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCPgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF2D562C9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656862572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oMrNKP/vCBD/e31gpGg6HfkwO33FSse+0JtWS4WTRVo=;
        b=Zg6yg1qo/YC3m4u+3s//WevzJS18ul2i/m4kaFRBSYUuOJb/bC2P0+hxA4A0BHbz2cHrGa
        TvNiRPEOuZmb5QdMFsOmIp7xLgNah1tp7RbiJc9+LT0lnC6VKauMvATitCla+R0RkVQsYM
        ShOyZ0zvk9JM8RJOS9zI0W5RCwZV/fU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-oigSp4TcNsWwVON067Kw-Q-1; Sun, 03 Jul 2022 11:36:11 -0400
X-MC-Unique: oigSp4TcNsWwVON067Kw-Q-1
Received: by mail-wm1-f71.google.com with SMTP id v184-20020a1cacc1000000b0039c7efa3e95so3297385wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 08:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oMrNKP/vCBD/e31gpGg6HfkwO33FSse+0JtWS4WTRVo=;
        b=IpYEYP8v7r+5czQgxRSQJdqGRswPglJBrxuD+Cp2cwfsVZYdfmlOlEHNNtYjAnYAvp
         6cmGEK4fZtAFFnzAR19sahAbX46ua0fYp0nyidQ9W5iLXM2CIP4O6Tjl3pboI4sPTAGZ
         zWLniJWeoavzb4vbgbtBElqGD2PShC/d6ffeFklBSEmU1Z6nZCkbhATdV1g5zkT8+lbi
         2LrbTJnmo65lRFnck3PkPtmNiinr4XtrxJMdvb5F5qMhhlFCC6pHj3htOxYgRx/CT/qJ
         QbuvuI2NfdlzLDiep2OpZuC6znYXaBj7lxOjc6egBpnW4BKXmnQyudP7zdGYoNwQZ7P8
         jI2w==
X-Gm-Message-State: AJIora8YaFNy24SqFBrH9GhUy6gu2jjiWQHq40J3wZ5vl9BMQxYx2aH+
        /1QSt24VbcGubwdqw/QnQA/OYbjkDrHTI8Rm/RdU00OYRTox5BFNkVWJ1xhUboRPMXn4s2GDYmd
        a6tbTS665FVJf/8eBPLX1/Xk=
X-Received: by 2002:a05:600c:3658:b0:3a0:390e:ea00 with SMTP id y24-20020a05600c365800b003a0390eea00mr26241433wmq.128.1656862569475;
        Sun, 03 Jul 2022 08:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slUbbrZARxOKqEcZqRJ7u3lLS226MuMPP/AWfWU5makabF0z0BDsEcPRojyiptS+6qPf8yiw==
X-Received: by 2002:a05:600c:3658:b0:3a0:390e:ea00 with SMTP id y24-20020a05600c365800b003a0390eea00mr26241418wmq.128.1656862569321;
        Sun, 03 Jul 2022 08:36:09 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000100300b0021b943a50b3sm28301105wrx.85.2022.07.03.08.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 08:36:05 -0700 (PDT)
Date:   Sun, 3 Jul 2022 16:36:04 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, joro@8bytes.org, will@kernel.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, hpa@zytor.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        atomlin@atomlin.com
Subject: Re: [RFC PATCH 3/3] iommu/vt-d: Show region type in
 arch_rmrr_sanity_check()
Message-ID: <20220703153604.pmgdrsaszmcwtpa7@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220611204859.234975-1-atomlin@redhat.com>
 <20220611204859.234975-3-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220611204859.234975-3-atomlin@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-06-11 21:48 +0100, Aaron Tomlin wrote:
> This patch will attempt to describe the region type in the event
> that a given RMRR entry is not within a reserved region.

Any thoughts?


Kind regards,

-- 
Aaron Tomlin

