Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189BC550A55
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbiFSLqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiFSLqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C77511C33
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655639189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AGhx+KJSkA3X8m8hF6CnNDDwe/d6YcrHu41h3pNbdsg=;
        b=KAo6K29F3EE53wreftIP+I0mtxCAU6XZU+JRYLI4bhpufIHkev3lIGDaIeuSNWlZZHdsju
        Q/Y2YqqLjBuA8vC5ZLpq+x0ypVN6VSO27rH8+VmTNgK62cmo3Wb/Yc1Uz/tG2Bj83YrZNh
        1EyNA43PIDWmaaQRmKpu3OUreyWgJ/M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-MEsddkbxOSiEzw_4RUOgMg-1; Sun, 19 Jun 2022 07:46:27 -0400
X-MC-Unique: MEsddkbxOSiEzw_4RUOgMg-1
Received: by mail-wr1-f69.google.com with SMTP id v8-20020adfa1c8000000b0021b81a553fbso1096762wrv.18
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AGhx+KJSkA3X8m8hF6CnNDDwe/d6YcrHu41h3pNbdsg=;
        b=5iP3VeRQdtORoct5T0IJ0ydvPa12zJfR7JnRs4OKNFXhKOgjJVBdaA8qmoCx/OmG9g
         2s0i5mJk34ptLDXpSXt3umiiUF1TdZXhPUMBvKkdXy8bvez2nKnZsQ8KCJxIzEL2PC0N
         raJMhbldb4Y3F8fjvTk4QETkzrKQXhGPyyK2fdEgsWsNfVCofFoWjxqM7KIvzQBV5iNO
         f9uRL+TPYoGcMmTWtQZlo6AuHuktm80vgiIKebkYNPaVbKyt0yJhIrJwC3HJQSUynFQb
         RVYPH2HEB3uVGbS8zhib3K36asmKBGPX0tiT6ULkeh9uvyRQ0Jv32cZBNecypBqq0i1+
         PaRQ==
X-Gm-Message-State: AJIora+2YXli3Eoc6WUwY8ygpK5p4D21eWnpGo7b45PI71zMGng82nSI
        I4v9LS1XRWiNMc3tr4Z+K4zVFzDOYIQ7N3KYRiiUQO/wWAMCzFGqpiXPmkRunvnBIH2XEwgX/7C
        jx3aJ4IGaxCj7XOALTX7iYXXR
X-Received: by 2002:adf:fd88:0:b0:21a:a547:38b3 with SMTP id d8-20020adffd88000000b0021aa54738b3mr11837143wrr.431.1655639186062;
        Sun, 19 Jun 2022 04:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tA0kjOoP2A9a9UPTNHd18aAPgeQQmXbADdDDkoDrdbNEN7EBtMxlFH7WBKyui90LADamvjEg==
X-Received: by 2002:adf:fd88:0:b0:21a:a547:38b3 with SMTP id d8-20020adffd88000000b0021aa54738b3mr11837131wrr.431.1655639185812;
        Sun, 19 Jun 2022 04:46:25 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4208000000b00219e758ff4fsm10076208wrq.59.2022.06.19.04.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 04:46:24 -0700 (PDT)
Message-ID: <cea478bf-ac29-dbdc-e156-5291da4f0318@redhat.com>
Date:   Sun, 19 Jun 2022 13:46:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] drm: panel-orientation-quirks: Add quirk for Aya Neo
 Next
Content-Language: en-US
To:     Maccraft123 <maccraft123mc@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20220619111952.8487-1-maccraft123mc@gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220619111952.8487-1-maccraft123mc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maya,

On 6/19/22 13:19, Maccraft123 wrote:
> From: Maya Matuszczyk <maccraft123mc@gmail.com>
> 
> The device is identified by "NEXT" in board name, however there are
> different versions of it, "Next Advance" and "Next Pro", that have
> different DMI board names.
> Due to a production error a batch or two have their board names prefixed
> by "AYANEO", this makes it 6 different DMI board names. To save some
> space in final kernel image DMI_MATCH is used instead of
> DMI_EXACT_MATCH.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> 

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

