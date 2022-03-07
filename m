Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879D34D0151
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbiCGOeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiCGOeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:34:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30DA539805
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646663604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BqBsilqCKDCrxnxeJqaARCUBXf202zo2/T5FUy2wzuY=;
        b=YhG1a/LKoxwSxtbqrRyoyL2pxRPpdPyFeSWNbUEYlP5CLeg3sypO/LxVshhCe6JYX88qCd
        xPWy5HjDzR99+l+RZsMmOWcv/o6lS/8pZBavaKHyLj7GZchvR1tFla+/X0fpJSo8wA3q1F
        Sik3U9S6/r7IjlA6BVzs06TJ13m/bXU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-C9hErc8FOF-1zNM6ZBn-aA-1; Mon, 07 Mar 2022 09:33:21 -0500
X-MC-Unique: C9hErc8FOF-1zNM6ZBn-aA-1
Received: by mail-wr1-f72.google.com with SMTP id a11-20020adffb8b000000b001efe754a488so4618728wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=BqBsilqCKDCrxnxeJqaARCUBXf202zo2/T5FUy2wzuY=;
        b=iV/Ulzc5Yh0zP6uR07dQuSZed9xN6ERA9aANDDHtYB0tyEgGR/ODjpJ1KKubrM8Cqk
         w0h2RB05emMpIzO46n9glghC8nk3UFqyBlLcrK5hyK2I+g5SPiMgy7iTqv/jE+SRjuXT
         mO/p9vssErQhLjM9mqAwLcFarAaym2YZE/WT46oqYXZLIJwvlGgnU6OPoZ1dMvtzrTu5
         LrHN8bCZ8MhQRt3jxpPn7NY2WOuXuU1DlhqrTB0gNIA67s5Jdq6LFl38qt7fRTwMex67
         iy5f8K4ejprJct59mmPJBmUx9tYGDtjINqH36/BNDsFVFIW1kH8BnRgfBeodj+5albvi
         eW5g==
X-Gm-Message-State: AOAM5305WM2TBoil82CDx+OX38/5HBGo7yaTau3XqbPY/fv/JYMmYdZF
        yHjhXrWdG1j8esycPvvB1F6n43qWs4g5J1SB0N0HO/cq0ob4AksFWsUNwN5vQxNmLAs/e29A7Kv
        PcsPkktYYERsj9DJQReVF4u+i
X-Received: by 2002:a7b:c154:0:b0:388:8e6e:ff76 with SMTP id z20-20020a7bc154000000b003888e6eff76mr9711135wmi.191.1646663600074;
        Mon, 07 Mar 2022 06:33:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfRVYkTxAcRn47Pfs4K6l3yvxYBhJf4kPwPZnm8FvG7VYk1WZXxsFh62kxfrGjwDoyNK0tCw==
X-Received: by 2002:a7b:c154:0:b0:388:8e6e:ff76 with SMTP id z20-20020a7bc154000000b003888e6eff76mr9711104wmi.191.1646663599814;
        Mon, 07 Mar 2022 06:33:19 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l18-20020adfe592000000b001f064ae9830sm9837404wrm.37.2022.03.07.06.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:33:19 -0800 (PST)
Message-ID: <9982c5a7-9715-7cdd-59be-8f27a65f32bf@redhat.com>
Date:   Mon, 7 Mar 2022 15:33:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] simpldrm: Enable boot time VESA graphic mode selection.
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     linux-fbdev@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-video@atrey.karlin.mff.cuni.cz,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Maxime Ripard <maxime@cerno.tech>,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Mack <daniel@zonque.org>
References: <20220218093334.24830-1-msuchanek@suse.de>
 <354f3cfd-bfa0-3ebe-3d67-705423d9294e@suse.de>
 <20220302193846.GT3113@kunlun.suse.cz>
 <2ba8497f-ba6d-558b-d782-bb3ee67d23ec@redhat.com>
 <81f87874-4aa8-265d-a0ed-c8a67708a92a@suse.de>
 <8d1c3caf-96ad-ae4c-021e-ac38f179dfcb@redhat.com>
In-Reply-To: <8d1c3caf-96ad-ae4c-021e-ac38f179dfcb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 21:47, Javier Martinez Canillas wrote:
> Hello Thomas,
> 
> On 3/4/22 21:00, Thomas Zimmermann wrote:
>> Hi,
>>
>> I've merged the patches into drm-misc-fixes. Thanks a lot to both of you.
>>
> 
> Ard already picked these through the efi tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/
>

I talked with Ard and he kindly dropped these patches from the efi
tree. So everything is fine.
 
>> Best regards
>> Thomas
>>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

