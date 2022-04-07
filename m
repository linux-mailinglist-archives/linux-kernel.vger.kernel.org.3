Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81134F7938
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbiDGIQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiDGIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 325281CA3A7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649319285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Lyv9WEhdyF3oLfvXgOyFMO/pRHVMB4/iOYwuxruItQ=;
        b=IZJOUm0WUtn+O145YRhcr2ybPVKD0H7TfBH1AODXiQkWFPB/lurQWCJZHjsgctqvqoTi/S
        WGCDF4KQup+6Xc8qBQVfDQz/yL5OVgYHrg8wDl+NRl0IeWrKUgRnqheNrZmGVxSRnc5Qke
        8pvi5Vrjyq6EGUIki+AVPk4LPXiCEmM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-GFYXAgSxNnWwZCmI0BlKBA-1; Thu, 07 Apr 2022 04:14:43 -0400
X-MC-Unique: GFYXAgSxNnWwZCmI0BlKBA-1
Received: by mail-wm1-f70.google.com with SMTP id c19-20020a05600c4a1300b0038e6b4a104cso4231827wmp.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 01:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=9Lyv9WEhdyF3oLfvXgOyFMO/pRHVMB4/iOYwuxruItQ=;
        b=lFrbvs6jUc+1FfaskWuNTsnrdi20g/tzmnVAVjMvXQMHUlHHEfe/DJVe0imezl4emz
         TcGA0BJe+7OrhlR22ANQ15bg59rqQonKkzRpd3eC/1Q0p18GTQ4k3ZsqH6M0DKjwOZBi
         zrS0gGhIph8xE4lNcHc3QlPA4vHWym3wb6YucsKeoZXoIfE44An4rZiv5VQXUkEb5vO5
         fiZnOkRt3SDw2sCWMspclVqJs4rKbkwZuQzIHHCAQ8gNKKPOTNCRo6EycrF38TJyPbLR
         C4V4JcMUj/wVcr01tXKCydjqnY7y4AOSaP1Wfnr8ItpfK2K6fEORqYBYf2E/bzRjFYqX
         FXlw==
X-Gm-Message-State: AOAM531qCZlMh4xclcqMVFXdF+5g8aokrm7BvaSebCLQTCmylEeEgHVf
        MHAJR7UA81kHi3VByN28lbxvtY7vgGxEgZfq0ij6V/qE6gnaomKnVFGoUewDeP8cf4SDP9gF3Wh
        mXkUaye7CNiz64Zt3XIB+cFf4
X-Received: by 2002:a05:6000:3:b0:206:1215:d7e9 with SMTP id h3-20020a056000000300b002061215d7e9mr9375167wrx.386.1649319282505;
        Thu, 07 Apr 2022 01:14:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1iPP/kjMynSz3lJrgFtsqgnN7PfQoJzaf/dXuPzi9u5f+qlGqUXNaWIrFVbJf9SbuUzMj5g==
X-Received: by 2002:a05:6000:3:b0:206:1215:d7e9 with SMTP id h3-20020a056000000300b002061215d7e9mr9375145wrx.386.1649319282115;
        Thu, 07 Apr 2022 01:14:42 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0038cbcbcf994sm7369893wmq.36.2022.04.07.01.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 01:14:41 -0700 (PDT)
Message-ID: <d7b928b9-7be1-f129-ff03-6ec9fe083f34@redhat.com>
Date:   Thu, 7 Apr 2022 10:14:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] /dev/[k]mem: make reads and writes interruptible
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20220407001327.109095-1-Jason@zx2c4.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220407001327.109095-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.22 02:13, Jason A. Donenfeld wrote:
> In 8619e5bdeee8 ("/dev/mem: Bail out upon SIGKILL."), /dev/[k]mem became
> killable, and that commit noted:
> 
>   Theoretically, reading/writing /dev/mem and /dev/kmem can become
>   "interruptible". But this patch chose "killable". Future patch will
>   make them "interruptible" so that we can revert to "killable" if
>   some program regressed.
> 
> So now we take the next step in making it "interruptible", by changing
> fatal_signal_pending() into signal_pending().

/dev/kmem is no more. So this should only apply to /dev/mem nowadays.


-- 
Thanks,

David / dhildenb

