Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7191348E733
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiANJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:14:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237505AbiANJOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642151644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pWvo2OEmMNI1tZRpROSSx7Oe7LhQALrcOqQAzgndTM=;
        b=DNaWPwS8TzD6qkX8AhspsImAC8Q4TCFRI1Hj5L1GAXfO1Aaaa52pxDfM6zxHEYLAJrdwwQ
        0CHGuxJ9Vyi587gY/KrVbBczpJd98Ld8ezOOw2rWSF959uVkrc4KF1TkOn2r3QH2A8iIJg
        6ZJOLuxAx/D1Mx2CcV0ZlnPEmiAgDZI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-fA-idSohO9WuTczASIBNLQ-1; Fri, 14 Jan 2022 04:14:03 -0500
X-MC-Unique: fA-idSohO9WuTczASIBNLQ-1
Received: by mail-wr1-f71.google.com with SMTP id j19-20020adfa553000000b001a375e473d8so1572799wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 01:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+pWvo2OEmMNI1tZRpROSSx7Oe7LhQALrcOqQAzgndTM=;
        b=Au0hi/yG0U1vkLp4p7+UfjLbtYH8mA5EC/WhaAyyuMrZYPELZhSOkVFJadAIPSz4N7
         mb0b6d0uwT4TASf3026r/EMy91UAw6BU2E8nU8GFly5I54e20Cnh9yC+cFuQTZpTt5Sx
         Bpr8C7AiZG3MugRoyfmtXJcyq2rJ4pIyz+Kpmu2BY4lZ7opBLXn+m3S+bQAu23Dilhfx
         sMYmoDNeCeVzzLUGKG/t2D/iq188/HqWBFXQmqWAll2/k39UWwEDEHPtjhJBKtPkzlFL
         NHvuj7aoU2l41Hl3p8wxBLXH8h5/eDQlJAlIRKPG/O9Udr7qX8st0vS2kvYPGA+A498U
         6ECg==
X-Gm-Message-State: AOAM533VaHxB0kJZa5CsTP6hJFhteICbjBZ3HhP8SkphcPuSoIyk/PHT
        IAl3tXF+uGyXAjyxV+7p9l1JyvD6fsIyCftUF9xRdusViwt+faSuPJIkzumtF+Ksx+nKgXBSLi4
        yxODnp2jnOy2OeyjcJ8vhZb8=
X-Received: by 2002:adf:e2c4:: with SMTP id d4mr7449728wrj.247.1642151642192;
        Fri, 14 Jan 2022 01:14:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRWSX6LUT9jDBPafrWdsVXhH8natyGtUEoDRAx4Eqym1QjMxZ7ScRzSJ2TMS04IjlUfo2Tyw==
X-Received: by 2002:adf:e2c4:: with SMTP id d4mr7449692wrj.247.1642151641814;
        Fri, 14 Jan 2022 01:14:01 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id d16sm5347116wrq.27.2022.01.14.01.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 01:14:01 -0800 (PST)
Date:   Fri, 14 Jan 2022 09:14:00 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     mcgrof@kernel.org, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com,
        live-patching@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/13] module: Move livepatch support to a
 separate file
Message-ID: <20220114091400.3jyiohxh26bzjzvi@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220106234319.2067842-1-atomlin@redhat.com>
 <20220106234319.2067842-4-atomlin@redhat.com>
 <Yd8HpK44aWhhNI/Q@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yd8HpK44aWhhNI/Q@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-01-12 17:53 +0100, Petr Mladek wrote:
> It would be better to have the two variants close each other. I mean
> to have it somewhere like:
> 
> #ifdef CONFIG_LIVEPATCH
> 
>    variant A
> 
> #else
> 
>    variant B
> 
> #endif

Petr,

I agree. I'll incorporate this approach into RFC PATCH v3.


Kind regards,

-- 
Aaron Tomlin

