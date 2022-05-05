Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A8551BFC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377751AbiEEMv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377714AbiEEMv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:51:26 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F78036E1A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651754865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cuDyUYDu6BZPnXeqmhM9u+aCmDXHwJi7/poygMUZqow=;
        b=UM019BJp6l/ffqt3f9CwyMqyjWt4dTOqCyQt0fkBe8HFe5iS5q8/FBYiDprjxTbC2rZcZL
        UfVeXWUUkmLT4DOkcDiEMcuPult5hFdQ2W8CLo71IDrNXB7ZmQ3NiuU3hmFW994ca30vTC
        Tags9r6mlr3X50Pj4qlliBNp6av/12M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-HF2sks_wP4-jYUaY-7P1Cw-1; Thu, 05 May 2022 08:45:40 -0400
X-MC-Unique: HF2sks_wP4-jYUaY-7P1Cw-1
Received: by mail-wm1-f72.google.com with SMTP id p24-20020a1c5458000000b003945d2ffc6eso1662646wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 05:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cuDyUYDu6BZPnXeqmhM9u+aCmDXHwJi7/poygMUZqow=;
        b=6mwr7gUUTTqjgMS332Hgf4NJHbwLm8S6No9coFpdxopWzjiLWK3uMizwGuEUeLK1oE
         8c8yp5mOdQwpfT6Y3914pit2LXo37E9BTRHeTVWgIXf2dM+Gvq7Zn+pMP5yg3F8AiaZQ
         ZrUE0Qa5YLUiC1BS/t5OSxXvxd2XK8R7VjXLwMWbluin3uk6dnZ/FLqSIgjhI683YzVn
         kq55UWRghpJZFJKFwzyxlJq7YjzrU0Ypgw5kSR8BeF1Pob5iMZEyr62P0Krt00b+txWt
         a10HnbUBHLJUCRMpLnGpdHoOgOU21xMDb2aX+B5gSY8MOAfs/b+7m4dugzpScqhm1fJ4
         I5lA==
X-Gm-Message-State: AOAM532w+Z/0//B7zndT2MDnProfZ0pyNdqS73i31OfGZkWohfTnAlzk
        TgLSYmwLxMzM33FhGRmiftMu7GJnyvZwJ8rgtoAQaw7dPKp4htNxRIAEvu/1iXgQsRcqAwoSLfA
        LGTxUVBrdSbab4XpMp8++PxGqEMYW8iAPnh5zbGfThc/HnFhwvO5sA4BgHw9KhM1Fx9Lq/ARgi0
        Y=
X-Received: by 2002:a05:6000:1a88:b0:20c:6811:3176 with SMTP id f8-20020a0560001a8800b0020c68113176mr13613479wry.85.1651754729614;
        Thu, 05 May 2022 05:45:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyvRu5J1/J+IjfMUf7y1AXH1mXJgSjbJfnuViykTVSo8bNb5YhQEJEs4GMNdg8VZpzTMvG9w==
X-Received: by 2002:a05:6000:1a88:b0:20c:6811:3176 with SMTP id f8-20020a0560001a8800b0020c68113176mr13613450wry.85.1651754729239;
        Thu, 05 May 2022 05:45:29 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g6-20020a056000118600b0020c5253d8d6sm1163859wrx.34.2022.05.05.05.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 05:45:28 -0700 (PDT)
Message-ID: <47d3a7f6-24f9-7d54-48bf-09ab9e40e2de@redhat.com>
Date:   Thu, 5 May 2022 14:45:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
References: <20220503071540.471667-1-javierm@redhat.com>
 <20220503071540.471667-4-javierm@redhat.com>
 <YnJcaaDcIsJKhSwQ@phenom.ffwll.local>
 <bfb03d40-a023-12a9-9554-1b6e6c474134@redhat.com>
 <YnO+8hZ0ozPaZUEj@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnO+8hZ0ozPaZUEj@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 5/5/22 14:11, Daniel Vetter wrote:

[snip]

>>
>> And while I agree with you that these midlayer flags are horrible, that is
>> what any other fbdev that makes use of a firmware-provided framebuffer set,
>> so simpledrm emulated fbdev shouldn't be the exception IMO.
> 
> So we discussed this a pile more on irc, and at least my take is that
> people who run simpledrm but want to combine that with fbdev drivers and
> expect it to all work nicely we can probably ignore. At least until all
> this sysfb stuff is nicely unified, and at that point we shouldn't need
> special flags anymore.

I'm OK with this take and happy to just drop this patch-set then. My worry
was just that someone could complain that we broke their uncommon setup [0].

[0]: https://xkcd.com/1172/.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

