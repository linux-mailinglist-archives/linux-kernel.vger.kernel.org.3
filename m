Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289EC4D228F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350214AbiCHU2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350180AbiCHU1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:27:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE28650E1D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646771211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMQmtW3v05zKNQrwevDEhtCno7x2QWP4Qsh7pV7OZ5s=;
        b=JP8E4EJqHqi9MDrssfgXrpnSK9Lga7/tsGoZPsR/9QZf/OAXao5ZgZCSEyavXhgaJ1ncrK
        kHKQ7HkRIgjxGpZC08/I15eBu51ortP8cIGKQv3unOUyG1Yex247S/WiPjvBYAxWky7Ni4
        9nFPv6LVTWja+xUNjYSWdGsn05v5TCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-AuOoDE6QMs2jP3u4PPWAJQ-1; Tue, 08 Mar 2022 15:26:50 -0500
X-MC-Unique: AuOoDE6QMs2jP3u4PPWAJQ-1
Received: by mail-wm1-f71.google.com with SMTP id 7-20020a1c1907000000b003471d9bbe8dso1229883wmz.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RMQmtW3v05zKNQrwevDEhtCno7x2QWP4Qsh7pV7OZ5s=;
        b=FPPYOXgdnzRuCmTf+N2DipMSfUrO/zIF2JSwygEYnTtFEDBA6HZK5NCQ7hUoXBOKac
         1U17zE8ijtAirvn/VEJvfCRa3lXQxT2sHVIHgVhQlvXy5vNdl5F7iLtOwCPCDwVSgmvi
         C7522y1BKE8/+8ivM9fDwcGCDNp+00vgADOXg7rJUV1A3Janh+pZqlon/McVxhsgM4MF
         2U8typZ/sdztwWhEWpNa/K4zEfSP95FfTVGdy10mJADrDv70G+ta7u8J84grTmnaQxbn
         J+DYieEO7axuNsCENNhcYlxl5XUX70fg9mr7oWKp2cPXNTxXWuI4WgYy/YKSgjDhdXcv
         jciQ==
X-Gm-Message-State: AOAM531A5kIyjkkUMmS4WkTx9JO8Hj0txD+KVOSkg9OQJLayr+CzWaKc
        Ix7JsW0cir2vm091hEnbmCIV9AzXR00+25U70jtYHXXy8NGj0GhBJrEkrUl6Zgl3HBk7Rkmb0PA
        SmVzwGhs8nh3BYwIG/B8YHzEi
X-Received: by 2002:a5d:6c66:0:b0:1f1:f12d:442d with SMTP id r6-20020a5d6c66000000b001f1f12d442dmr10118538wrz.338.1646771209073;
        Tue, 08 Mar 2022 12:26:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKuAg1VR4l1vd12voS5+qOu/V/59vrX4cDu1pjnI1UYEckpmfcpauj2P20/BvN5ULfcP1YjA==
X-Received: by 2002:a5d:6c66:0:b0:1f1:f12d:442d with SMTP id r6-20020a5d6c66000000b001f1f12d442dmr10118534wrz.338.1646771208868;
        Tue, 08 Mar 2022 12:26:48 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i5-20020a1c3b05000000b00382871cf734sm3175363wma.25.2022.03.08.12.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 12:26:48 -0800 (PST)
Message-ID: <4bb757d3-bb2d-122f-1b13-25cf3ebb4407@redhat.com>
Date:   Tue, 8 Mar 2022 21:26:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm: ssd130x: Fix COM scan direction register mask
Content-Language: en-US
To:     Chen-Yu Tsai <wens@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20220308160758.26060-1-wens@kernel.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220308160758.26060-1-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen-Yu,

Thanks a lot for your patch.

On 3/8/22 17:07, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The SSD130x's command to toggle COM scan direction uses bit 3 and only
> bit 3 to set the direction of the scanout. The driver has an incorrect
> GENMASK(3, 2), causing the setting to be set on bit 2, rendering it
> ineffective.
> 
> Fix the mask to only bit 3, so that the requested setting is applied
> correctly.
>

Sigh, you are correct. I thought that triple checked the datasheet
when writing this but I got it wrong anyways...
 
> Fixes: a61732e80867 ("drm: Add driver for Solomon SSD130x OLED displays")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

