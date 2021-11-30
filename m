Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C036B463F52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbhK3Ufq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhK3Ufp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:35:45 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F42C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:32:26 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r5so21045457pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B+eD0AWbPxjSOvumJqLuOeGMxfPK4HMsAqhFNdXov90=;
        b=Y8unY17G21VVGtvXgLMaiTe0aRZDMVmNcBpHL5Tvibr0/N+lPkYqsBLYBHPo/MIV4e
         IjJfBocLcZ8PH46WvEexLvilRwexBuHTHF6CxXQ8gLDCHByzmptGoDcDUNYF1Yk1GfRr
         0VBAVBc6jRiVRKvHTqfSnJgYMXT0jrBt2f+Q+zX1JdO5GbeRMKVn4xEQocSXLQZuSlA4
         DKqlEvUadJ7ueEQcLaIkJDNMPlYU5EcniJkUmdFLaICbUQyTzUgQI2iGxNsTwmymudOL
         /HFnxJc4vHCryD1Jouh6CPw/5YOsJiStegwB3MT9HlAtj/I4tAN6Dtvkn6CbuS6gwGH+
         0Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+eD0AWbPxjSOvumJqLuOeGMxfPK4HMsAqhFNdXov90=;
        b=BbHOeg/X0jIn8cWSO4t34Ke1VgR/3x1ZttT+rD8NEOFIio59Qs96XVvT9l3Gr5aiAO
         Tfgpfn+gWascO34bOk0alRpUG4L96kQXrpdf9xBrwkw0OimIsKSjZRkNIPqgi5YM7ymo
         DFkOyIxrswmBVDKs3jlS8FlNc5HoEoiNbkibAB9xpTH64nErjOKDJ0fbXWyryTo+DN/1
         FzvqfKdRIjLd6BsO256VdpnKRWvofHkAKdHJZAFi9j2V9Pl1mg1YscPnQ51dTipvkI9V
         6pE6hS1Dr1Tlyly+BrljdkSp8/KbxflY1/7Yk3/eqYyBoV+67HQb9SLmh7H4DhvrXeJe
         LPvg==
X-Gm-Message-State: AOAM5315VjLL6iiczYG/efNRBEP0zDvGcq7GXud2TV27tvWruj1LjCp4
        Lf06uug4idXsKH0Mw28RPdsqmrSGKUCmnw==
X-Google-Smtp-Source: ABdhPJyofkir993EDxQcwXyX/oKLHP9Wy/1ZcLGZ8iP3L8T645GoCvVeVd/SxI0QHz4G0sZTSCBcDA==
X-Received: by 2002:a05:6a00:1305:b0:4a2:75cd:883b with SMTP id j5-20020a056a00130500b004a275cd883bmr1630196pfu.44.1638304345435;
        Tue, 30 Nov 2021 12:32:25 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q1sm22754763pfu.33.2021.11.30.12.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:32:24 -0800 (PST)
Date:   Tue, 30 Nov 2021 20:32:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: VMX: clear vmx_x86_ops.sync_pir_to_irr if APICv is
 disabled
Message-ID: <YaaKVYnM2hNfI4J6@google.com>
References: <20211130123746.293379-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130123746.293379-2-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021, Paolo Bonzini wrote:
> There is nothing to synchronize if APICv is disabled, since neither
> other vCPUs nor assigned devices can set PIR.ON.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
