Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262255143A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355390AbiD2IKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355381AbiD2IKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AB7FBCB41
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651219619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLGpZkEk0zrBfkXdyDNagV1Ot68Eefe6MnXYNDLKtfw=;
        b=QTjC2iFKVFQk6y/2r2Z7/mQuZ0pwzA7EYrbNajsQi0knxTNti1DXoVLccT/zvelepw4TXK
        U1Rmd6vM3NfSp+pYi/GkXW2y2dgFUYmEw7/AjxGb51vipjfZ6nhD61uLDz0NHHy5RRtf0d
        UBq3DTv7rvNQ64mpvMu1F6IKVoA070I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-1aMCF2p1PKG0uNboecKe9A-1; Fri, 29 Apr 2022 04:06:57 -0400
X-MC-Unique: 1aMCF2p1PKG0uNboecKe9A-1
Received: by mail-wm1-f71.google.com with SMTP id k41-20020a05600c1ca900b0039415d40dbbso1257064wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DLGpZkEk0zrBfkXdyDNagV1Ot68Eefe6MnXYNDLKtfw=;
        b=HMLd0OZ7rKUpyoNTlShrp6xnp1QFjR5xck8rXIJrlPIH4eYGW/fh/FZtaJYbfjdGvL
         rh+IUi5lHlvIHWa4eQmlUoKRypGZa74wNG8X0WAzDJi2pGqK9Lee1mKTkPctQzxZdLAD
         oNw7EZ9EzTvID41G2gBXcN9CfvJVlSLS4YoQxYau3GWcSqnMVbORmP0Esm6W2szwoFPw
         j9qOIOWu00TB+u/iv8EdPf/Lh42iK7x10mo+U+fFg5iEBXWctxXGTLibqLd95xb4EEI7
         HGKdOjdUjIjcu6NYOmWTEmXhz/9HRoRQanRDgLT4FvlicZLhrlwcLG3cjHAsU/u9Spzd
         AxaQ==
X-Gm-Message-State: AOAM533eH8/tKirIeRntI5C9MRrdd7A65HY7oSBUhZkRXd7cC0UqLx/V
        SuCctkdFYpG478w5RBDtXQay2+p9SuMlwDELAfSIemFh/HZj9K0Q9+cW/Is4/mQWmrRnrXG1EQr
        dqyAl8IDNABpUQRUNQV6zHsHP
X-Received: by 2002:a05:600c:4ec6:b0:394:1f35:4c69 with SMTP id g6-20020a05600c4ec600b003941f354c69mr1623983wmq.61.1651219616592;
        Fri, 29 Apr 2022 01:06:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4nhCTQSlkHFSNiSRmvTsdvHGIghcHcLc724I/E5mgFee4F74Ys2EQrG5GMimuyw2I7UjkHA==
X-Received: by 2002:a05:600c:4ec6:b0:394:1f35:4c69 with SMTP id g6-20020a05600c4ec600b003941f354c69mr1623967wmq.61.1651219616352;
        Fri, 29 Apr 2022 01:06:56 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z11-20020a7bc14b000000b0039419dfbb39sm2210341wmi.33.2022.04.29.01.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:06:54 -0700 (PDT)
Message-ID: <97339148-9876-cfc1-8df8-dbb21a9c3c7c@redhat.com>
Date:   Fri, 29 Apr 2022 10:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/5] Fix some race conditions that exists between fbmem
 and sysfb
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yizhuo Zhai <yzhai003@ucr.edu>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20220420085303.100654-1-javierm@redhat.com>
 <535ebbe4-605c-daf5-1afb-f5225e4bb3a8@suse.de>
 <093d742f-4c87-2ff3-e9fe-153cd734f8e4@suse.de>
 <220929be-91c4-d19c-b04f-312c5f7e9e40@redhat.com>
 <YmuYE2t51lPIRT8p@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YmuYE2t51lPIRT8p@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 4/29/22 09:47, Daniel Vetter wrote:

[snip]

>>
>> Exactly, should be done when the device is registered rather than when
>> the driver is registered or a call is made to remove the conflicting FB.
>>
>> I'll rework this series with only the bits for sysfb_disable() and drop
>> the rest. We can go back to the discussion of the remaining parts later
>> if that makes sense (I still think that patch 3/5 is a better approach,
>> but let's defer that for a different series).
> 
> We need to kill sysfb _before_ the driver loads, otherwise you can have
> two drivers fighting over each another. And yes that means you might end
> up with black screen if the driver load goes wrong, but the two drivers
> fighting over each another can also result in black screens. And the
> latter isn't fixable any other way (in general at least) than by making
> sure the fw stuff is gone before driver load starts in earnest.

Yes, you are correct. I didn't realize all the possible cases when agreed
with Thomas about doing this but tried and found that it's not enough.

I've a full patch-set now and will post as a RFC so we can discuss more.

> -Daniel

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

