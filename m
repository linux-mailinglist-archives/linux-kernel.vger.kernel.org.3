Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F08A478E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhLQOvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbhLQOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:51:22 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0EC061574;
        Fri, 17 Dec 2021 06:51:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i22so4467992wrb.13;
        Fri, 17 Dec 2021 06:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mnebuQGqRVJGN2DsZ9eHW1+KpUOSevBvrqS9hjun5HA=;
        b=ZjTNEfc6zK60plX/MF6o4daNldO/KbO+PvVYiMB+SaIqCvXZ7TyjN1ZuSFyxaBe0ZG
         rGdblOWXBUAlA4vJY9vIHZilZZdkP6G4OQvKA9HBbK+/POhbux6DZV+Xn9aZh+7D25gw
         YsI/wAiMr6cVQl5HhqR6J96714rjxCTwE0QG5DjZLonH69P1U/gTHclxEM49QmKKeu0U
         iqIv5Da3muuv/zmHQ0QMecdPqFGvv/ZIN4VGGVgh4WJstnMFjj3ogLdiDmqH16wu06NS
         1QGuE4q9HejJCgL+FS/XIgsS0/2noHo3BdkBa/ZZu60rQrVxcpJul8pShfrUNGvuJ1S5
         G8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mnebuQGqRVJGN2DsZ9eHW1+KpUOSevBvrqS9hjun5HA=;
        b=c+XghLGBsK/E0hVZJzvvWocizrRT4R0FWyW3fL5bBAgRMHegTqHtbsfaPvyqmE1fTF
         oVVGRwQBtdsh0pmZCSLW9Qghf/cAjdixhLFreC/YSHZU5GAhq2VLaS5AFcmoIwA534xk
         4gE5+mgzGN77okMlZy2V8NRltxcAzD6xGi6M1zcl/d+Fyv6onWN6HiH3ThaG6VBsAbNI
         pgl/hUi7tPZlffyiNew0RBu3o5dz6RHQ+vc8pyV/r4lGzL/w6zKsryFLn3UYblTjedzU
         5oH8jDgqGq4dKo4p9E7s/JsnWpkzOekfd16Z+0FsPJGXZOP2RzfsYT9okVUGAEzXe8V8
         11rQ==
X-Gm-Message-State: AOAM532Axy0IRU8KpVp28j0JW13sJ3lW4gejlnEGzXKyB++9ff2BHz1Y
        OmSnhQs9DIt9yLM8kzqnif4=
X-Google-Smtp-Source: ABdhPJxEcEhIcUYsKzOAN6IqL39vwVjInx/LM/aFur/79bTs0fYRfHfINZo6PTnpTWAnMXXZlNDMJg==
X-Received: by 2002:adf:ca0f:: with SMTP id o15mr2828708wrh.457.1639752680231;
        Fri, 17 Dec 2021 06:51:20 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:48f9:bea:a04c:3dfe? ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
        by smtp.googlemail.com with ESMTPSA id a10sm12136566wmq.27.2021.12.17.06.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 06:51:19 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <ada9b2aa-f1e7-d566-0384-002890441a30@redhat.com>
Date:   Fri, 17 Dec 2021 15:51:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     paulmck <paulmck@kernel.org>, maz <maz@kernel.org>,
        frederic <frederic@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 14:21, Mark Rutland wrote:
> I'm not immediately sure what we*should*  do here. What does x86 do for an IRQ
> taken from a guest mode? I couldn't spot any handling of that case, but I'm not
> familiar enough with the x86 exception model to know if I'm looking in the
> right place.

ARM is missing something like commit 160457140187 ("KVM: x86: Defer 
vtime accounting 'til after IRQ handling", 2021-05-05).

With that change, it would be possible to move guest_exit() in the 
irq-disabled region without breaking time accounting.

RISC-V has the same issue and it would be fixed in the same way, so 
let's Cc Anup too.

Paolo
