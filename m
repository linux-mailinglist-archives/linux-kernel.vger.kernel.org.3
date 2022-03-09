Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801804D2B95
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiCIJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiCIJOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:14:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C7A9986D1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646817224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOG/PAqse9zSZ2yDOcQfN7jOgLfXTKKr0q59fyoMcwk=;
        b=SnLNvXkLc3ZAkrnRXLk1YE1dZ9FdMB1l8OCFROiMK6MKyBpmHoQWfmOalO1KGUiL2fppGU
        QLELloxrO3O5TmEtKOjUdWzUvC1BJ0zWP4BLGjVHwqyyRtGvz6ZVQmkozWTUHpjcfY+Lyw
        I6aLxLs9lCOZpZd4RV7Uq1x+sA1eOOI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-oGiPHFRUPniWP8K0EM3Etg-1; Wed, 09 Mar 2022 04:13:42 -0500
X-MC-Unique: oGiPHFRUPniWP8K0EM3Etg-1
Received: by mail-wr1-f71.google.com with SMTP id n4-20020a5d4844000000b001f1ed76e943so536347wrs.22
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mOG/PAqse9zSZ2yDOcQfN7jOgLfXTKKr0q59fyoMcwk=;
        b=hx6Vo1zFI52ulu0WTzstZmbZVTS0/sn0dqbVJ+Bomznf+GpB6B1ovBTAj0reu4VhoG
         36WehHRdWrTUhFa4HQgnmB82okC/KZ+/igI7c1yuPRwk+VdDJ8cRS/sNkea6twIHMF4I
         oXhzQCV2MhOepDtFlJr4idY+LBHeqZ5a0LyNrd3xdgEgXbZaXKFFHgZ1sYXLp/yz6Pf5
         hE1pst9d7f54B8eyiCwO5CzWUpvE2NJLpdiec5OpKBML2bB4/HLboS1DGi6bFwPNjUw1
         sKj/b0q6guE7pi4Yf8Cf1U4VEub19AJhwJnh5cQPDGareksdjlhxnV/dPqgmc+JCVPWD
         nIDA==
X-Gm-Message-State: AOAM533zwBQs4kttKY1Ck2HDzy0iufk20AD9FutBwu5iNRjXJaaXgw8n
        Z2Pa20oe+csyW+v0krlx7iChrXew8v/sfSjCur7R+hIxz7u7ee31UArWAWVrKbchdItKfbqtCQa
        mScVc8sHmmLhOL1nrin8RtseS
X-Received: by 2002:a05:6000:168e:b0:1f1:faf1:23b7 with SMTP id y14-20020a056000168e00b001f1faf123b7mr9640373wrd.150.1646817221588;
        Wed, 09 Mar 2022 01:13:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweaBimAyyZrv7VWly/q07XyzC7p7a2C8mkUhFK+5TKB0vl3lp2QMtC0tGVt1RE5UTRPIOE3w==
X-Received: by 2002:a05:6000:168e:b0:1f1:faf1:23b7 with SMTP id y14-20020a056000168e00b001f1faf123b7mr9640353wrd.150.1646817221338;
        Wed, 09 Mar 2022 01:13:41 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i8-20020a7bc948000000b003898dfd7990sm1227337wml.29.2022.03.09.01.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:13:40 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Output host build info as normal
 Windows version number
In-Reply-To: <20220308204657.v2xdbtx6qsx6n44s@liuwe-devbox-debian-v2>
References: <1646767364-2234-1-git-send-email-mikelley@microsoft.com>
 <20220308204657.v2xdbtx6qsx6n44s@liuwe-devbox-debian-v2>
Date:   Wed, 09 Mar 2022 10:13:39 +0100
Message-ID: <87ee3ba3p8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> (Cc Vitaly)
>
> On Tue, Mar 08, 2022 at 11:22:44AM -0800, Michael Kelley wrote:
>> Hyper-V provides host version number information that is output in
>> text form by a Linux guest when it boots. For whatever reason, the
>> formatting has historically been non-standard. Change it to output
>> in normal Windows version format for better readability.
>> 
>> Similar code for ARM64 guests already outputs in normal Windows
>> version format.
>> 
>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Works for me, thanks!

>
> Applied to hyperv-next. Thanks.

-- 
Vitaly

