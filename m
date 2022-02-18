Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17FC4BBE48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbiBRRWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:22:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbiBRRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:22:49 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC95BE4D3E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:22:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i10so7695173plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=LXJHrFcUgfck6T64vbuXER18RsSAh2smjYW7lHXzLuY=;
        b=FqkbDs/H8Ewd7Vcw8fdowTT+8Gz0hPCfAMIeDFtIc8Oe8k6GUaz0GoMPf6SqcHK7f+
         B1PJBCo9pYWM7Gx4PLel0GnvEXYwIXXTgjm0wEI/QHU+ZCygklKm5ia6VpX4e0DXCo/i
         Uwrbt5Lvds/1sKHSezH908ot9BQmjut2mvdiu8tfrxfr5XwvJ3kDhj3mm2X4cFXH5vXe
         t1alDyuWhGr0Dz5eyNxE0FLbsCVbp1J5SzXPXwtzOOoQMTkYlsZPrvLkhdGF7cogPIAb
         Qb4E6DRrX3+UBCgU4Tg2Of3vMusT5jim2T1We197f6bLdK2FFdwrqr1ct8bY1I6c1O4l
         mjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=LXJHrFcUgfck6T64vbuXER18RsSAh2smjYW7lHXzLuY=;
        b=gvZjsF7XHZC2ZSHfDh+fd53J8fgX61P06RbaHUUYrWIcPDQkfyLunNRLBC88r9B8g0
         39qqL9Q41ZPUzfbGBmayTdLzngWuM1Qf/KUstKFiO6yTBXGZH5uBcz9Sa2VCi6wW4Y/t
         eRRGi2bKirbIv1RHag3bi6mmcocsJV9wjTs+mRpLAlOh+/I53CsKWXoIeFiwXOBrwOjf
         i+l6zRzJj+F3ek2RbtdpV8IchyLx/trhPjQ7yefA49XqgqX/mANNb/iTf0x5SBn2GZwQ
         Ka0qyuIo/MZvLFfA6p/rxuTU0Tz/d/EGJ+5404aKZVEsz/DNs12T7JY36U26tT0J0sl0
         W8bw==
X-Gm-Message-State: AOAM530FYX1WzfwQGAyRP4Jjq17oPuKYub1b/8oHLp1XwMfPvVMuDign
        R2rk/+MufHbozHHrWfVLpyGb/w==
X-Google-Smtp-Source: ABdhPJw/c+h/pWxfufvRX4XVAxiKzV6InzDmLsJiZ1+tzlPRN3BtE0+v3cwHUFIJI9frujCWtXiPIQ==
X-Received: by 2002:a17:90a:67c7:b0:1b9:b5ed:3f19 with SMTP id g7-20020a17090a67c700b001b9b5ed3f19mr13463709pjm.90.1645204952281;
        Fri, 18 Feb 2022 09:22:32 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id e4sm10328571pgr.35.2022.02.18.09.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 09:22:31 -0800 (PST)
Message-ID: <3561688b-b52c-8858-3da2-afda7c3e681f@linaro.org>
Date:   Fri, 18 Feb 2022 09:22:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] KVM: x86: Forcibly leave nested virt when SMM state is
 toggled
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+8112db3ab20e70d50c31@syzkaller.appspotmail.com
References: <20220125220358.2091737-1-seanjc@google.com>
 <db8a9edd-533e-3502-aed1-e084d6b55e48@linaro.org>
 <Yg/QKgxotNyZbYAI@google.com>
Content-Language: en-US
In-Reply-To: <Yg/QKgxotNyZbYAI@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 08:58, Sean Christopherson wrote:
> This SMM-specific patch fixes something different, the bug that you are still
> hitting is the FNAME(cmpxchg_gpte) mess.  The uaccess CMPXCHG series[*] that
> properly fixes that issue hasn't been merged yet.
> 
>    ==================================================================
>    BUG: KASAN: use-after-free in ept_cmpxchg_gpte.constprop.0+0x3c3/0x590
>    Write of size 8 at addr ffff888010000000 by task repro/5633
> 
> [*]https://lore.kernel.org/all/20220202004945.2540433-1-seanjc@google.com
> 

Ok, that's good. I will keep an eye on it and give it a try then.
-- 
Thanks,
Tadeusz

