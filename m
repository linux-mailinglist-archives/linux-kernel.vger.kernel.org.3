Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4700B4C5147
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiBYWMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbiBYWMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:12:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 899B452E3D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645827088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j3VxtWAMog8m5ArNU/BgenbWuy7FcGC+lz0O8q97Sw8=;
        b=Rewd7viwx0OkgPiaqXpobyInoqsiuuerWpBNC106v713Afn/XHSb2peqa4G1s3kaTv7N6p
        uSakCapbVyrMYHknpbg1mpS28HKX2h8xwOz7vET0YP5VWbMG6veipUI+zK7QcfhtqEYJ1l
        8fB44oX7A2E9yFzHgkxII8ap0CAhzNI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662--vWRGJ-PNNyVFdIlm8hRGQ-1; Fri, 25 Feb 2022 17:11:27 -0500
X-MC-Unique: -vWRGJ-PNNyVFdIlm8hRGQ-1
Received: by mail-wm1-f72.google.com with SMTP id ay7-20020a05600c1e0700b003813d7a7d03so1193144wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j3VxtWAMog8m5ArNU/BgenbWuy7FcGC+lz0O8q97Sw8=;
        b=GIWCRR8SEaDK9YfxeaMhtZUi2MIk9/c9Vo06mS1XlOl9IxB6/OeRpjUudxS803t5pd
         GI3fORXLockaibuQ1D63SFTR234d3atr40V8YcUdWWnh5azOwkV48AyaUwJ6y9dDNLzR
         rEXNsI/rIscT5KUSwIPF0Xs0zRNnVKTHtCXx2ibh26yJ4or6XHZ05zzsgj+FziYaczDg
         VUX3KK2DQHq5KfmsPhD2RG31PMyGHMIg2gYRClm8QYZm/I6v5OESyPDqlejjO6Ucvj3K
         mdQr9X+xbumP1GW8lzx8I/pnzGm9QOil5yKTvOYMKWvRJq8wqFs7B/ZSlo5Jahuz4o3A
         MMdg==
X-Gm-Message-State: AOAM530wT88zlzoJhlHAj1AbBc3sA33ZlYSSnQ7veVFb4jbXXdYfC/Gq
        SETu2OfPjbbo7qhP/o9j7VcHH6OKpEHWeesER84Ts3jczhQPG/n/Nv6+75ud5ia3gcxCxitSmBm
        cDDuoR4fNkAYxsXTwXTeKoqrO
X-Received: by 2002:adf:e3d0:0:b0:1ea:9be0:3162 with SMTP id k16-20020adfe3d0000000b001ea9be03162mr7706163wrm.205.1645827086223;
        Fri, 25 Feb 2022 14:11:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpYbnDqQh/prWaTqz6c8tOt2xrJUKB8Clt1MsSwRkjB7ijhcF6OjzqFxBwoqAxNJNzJXwD4g==
X-Received: by 2002:adf:e3d0:0:b0:1ea:9be0:3162 with SMTP id k16-20020adfe3d0000000b001ea9be03162mr7706135wrm.205.1645827086036;
        Fri, 25 Feb 2022 14:11:26 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c1d1a00b00380def7d3desm3652202wms.17.2022.02.25.14.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 14:11:25 -0800 (PST)
Message-ID: <272b6278-b153-1e12-a542-0f9706c592a6@redhat.com>
Date:   Fri, 25 Feb 2022 23:11:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/3] efifb: Remove redundant efifb_setup_from_dmi stub
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Helge Deller <deller@gmx.de>, Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz,
        linux-efi@vger.kernel.org
References: <1f13e6f2-a87c-83ac-7119-8632c8c8ac8e@redhat.com>
 <7416c439d68e9e96068ea5c77e05c99c7df41750.1645822213.git.msuchanek@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <7416c439d68e9e96068ea5c77e05c99c7df41750.1645822213.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 21:51, Michal Suchanek wrote:
> efifb is the only user of efifb_setup_from_dmi which is provided by
> sysfb which is selected by efifb. That makes the stub redundant.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

