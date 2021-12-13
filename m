Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7484E473236
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbhLMQrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhLMQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:47:37 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFC1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:47:37 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p18so11541596plf.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d7XshzHO0ogGg8acACHycxEJMao7hYdDLYe6OwIM0lk=;
        b=ppJT8y/zHPNyX8MGuhcvnLdOVVkf8u0jny2LsQ8tffQDOkVaRa5+mpRylvJx+6iOUH
         XoCh2rocyZsttBGtI22X7IVSbFUNILcihWiu9WxRfeux6u547SJ6xFatGEa5n3XU2EVy
         nokar6Un+jKll7zVMG8O+fxT/srxlDxTDuh+Jmp04Yci7+2At1elb72Atd7Ses05qhvi
         mn96dUm5tRo8xsBxjMSvVaP66ry9t04pJ5oSinPOzTPet9az8XTrFVLyBMDCULOXNNWy
         T+WmnFmir1JM88oRr1xSBcGg1O9Se+BqG//HcuW4aIR1q7JFITMzacGUDqdGqylVl3tp
         D2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d7XshzHO0ogGg8acACHycxEJMao7hYdDLYe6OwIM0lk=;
        b=kyvaMv/UOB4EDHHWbQWWlcj069vt4/xIYlBTpsuQS39Cxf8qGuAincnTQHNqWURSyR
         xGucVZ3AGzRuYDwCPTtXWSOSFpjRaAcTu/S2luxmpBrOnvM9jWwhELWYQwm7ToGSUJUw
         LtuvbJjJs3ixQ3CQeVgtrvAU9HMJ3v3PGLyC0L7vHkpQ9fSFrkDuh1WupsySL+OmXRiz
         eM/Eqob3tONFoik30BhD6/zjAsgZQhHxYtt3KJagb8hLd3EvY2yu+UR8JwZBj6l8YdsJ
         V8dsoAF2fDwyHHxc4F5Rlp+LajtL5ibx3fyhzljWW+g4aL+9/wh4G0C6Kt7maLMQ2o2q
         nbQw==
X-Gm-Message-State: AOAM532+Iau4Zh6OX71HCUvPuFpT6K7szdZaVCDi09xYxLhuvdpt2Dx6
        9W4B7lz1ALtytelFGRGIJ2cvPQ==
X-Google-Smtp-Source: ABdhPJy0GpHOCW0uHzMRgLmkIPVPTjcQI5Qx6Nr352xJjGzPh1hsDg0X78uF7DEoKjABjY1ij64D7g==
X-Received: by 2002:a17:90b:4b0e:: with SMTP id lx14mr46321531pjb.160.1639414057065;
        Mon, 13 Dec 2021 08:47:37 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id pj12sm7609651pjb.51.2021.12.13.08.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:47:36 -0800 (PST)
Date:   Mon, 13 Dec 2021 16:47:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        bgardon@google.com, dmatlack@google.com, stevensd@chromium.org,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH 0/2] KVM: x86: Fix dangling page reference in TDP MMU
Message-ID: <Ybd5JJ/IZvcW/b2Y@google.com>
References: <20211213112514.78552-1-pbonzini@redhat.com>
 <CALrw=nEM6LEAD8LA1Bd15=8BK=TFwwwAMKy_DWRrDkD=r+1Tqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALrw=nEM6LEAD8LA1Bd15=8BK=TFwwwAMKy_DWRrDkD=r+1Tqg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021, Ignat Korchagin wrote:
> Unfortunately, this patchset does not fix the original issue reported in [1].

Can you provide your kernel config?  And any other version/config info that might
be relevant, e.g. anything in gvisor or runsc?
