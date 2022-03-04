Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229AE4CDF5F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiCDUsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiCDUsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:48:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DE5B2359F7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646426881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIKaFpflRd9hwR16NlF6OnU9QoRFMeWutPRp1q0p0c0=;
        b=Kymd+0nor5iFAX8KXPTdCHiaaTy2tUT7Xwzn6cz/MyzOeXekeb/BZ8WUJiWuO8agipjEpn
        U5r6XoDRVoI8QCyDxBiy9eSIJMeAyMPw23qWxWSjlyX6GrJ2512/0s/Bgxh+pyL2Hto/CX
        rKp5yJlOTlnwr/9NWSL0jRfGypW2K0w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-2-6AYZlCN06RKhfgIYbTkg-1; Fri, 04 Mar 2022 15:48:00 -0500
X-MC-Unique: 2-6AYZlCN06RKhfgIYbTkg-1
Received: by mail-wm1-f71.google.com with SMTP id v125-20020a1cac83000000b0037e3d70e7e1so4601680wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fIKaFpflRd9hwR16NlF6OnU9QoRFMeWutPRp1q0p0c0=;
        b=Jn8qusxw8C5YBPbnBOuaW53pFNov2sx++D7SBx5/D/YeIoDiAbjie0Zkc3CGEQXelg
         qFortHMwbIwE3I+f0SsPWt7FNlVvnd+HgqBY7Ij3ZW4e6uu43InrSkcemW/oBhNj/x4o
         DZmJ1f44Vd87QubiBnkHK6N+DmZiLJDrkE9O09Nx4hR0mwDZfI4JiRdA+IoUSTLSqieI
         cEH3nHIMfXmYknR5EMPq0GtHc5QWKt6VadCJNFHURSx7uxmRPZG2dKCBdZoOtu541VdL
         mKTWizevpnvepeTflunjJkWrYeIpGLzSfkB4fRSxCc32D9WOJJoXgfipc85P1OSJ4x1K
         3UEQ==
X-Gm-Message-State: AOAM53280eFMG0zYUt+xX07lAHwz1UdAT8c1TEbdH2mGXjVtgpHez+az
        PN3zdh8K7VuRX9snWJ29iq6RFGElaMQPot8YJ5XtCNZvdk5DgN8LnLCH4fCJD6wd6kT6Oq8xlu4
        RakhiiqBURIY6kvQkllrNRjuA
X-Received: by 2002:a5d:6c66:0:b0:1f0:5fd5:697 with SMTP id r6-20020a5d6c66000000b001f05fd50697mr365424wrz.65.1646426878901;
        Fri, 04 Mar 2022 12:47:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzltMdM718VwuVL5pcJNjWElXTGeJCCvXaeW2MlBTYMP981ds1+0SMQ7OOkDx5SiXxjBKq6wA==
X-Received: by 2002:a5d:6c66:0:b0:1f0:5fd5:697 with SMTP id r6-20020a5d6c66000000b001f05fd50697mr365399wrz.65.1646426878644;
        Fri, 04 Mar 2022 12:47:58 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6b43000000b001e317fb86ecsm5110984wrw.57.2022.03.04.12.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 12:47:58 -0800 (PST)
Message-ID: <8d1c3caf-96ad-ae4c-021e-ac38f179dfcb@redhat.com>
Date:   Fri, 4 Mar 2022 21:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] simpldrm: Enable boot time VESA graphic mode selection.
Content-Language: en-US
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <81f87874-4aa8-265d-a0ed-c8a67708a92a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 3/4/22 21:00, Thomas Zimmermann wrote:
> Hi,
> 
> I've merged the patches into drm-misc-fixes. Thanks a lot to both of you.
> 

Ard already picked these through the efi tree:

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/

> Best regards
> Thomas
> 
-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

