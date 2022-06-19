Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F09E550B48
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 16:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiFSO5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 10:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiFSO5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 10:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D64716266
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655650659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHot+2uLVoFYLq/OdJvXds01VXlhrLpmZp7IRLndQvc=;
        b=YudZK1PMg4GUlOy7CaDHhqJMSQcu+0LfM3phzejY1IBsZOkckYQBc55w2zsgMo7FhGeF/I
        lOQmx+Zr4R1oHfONzrjWFs1JGD0bLEqUtU4oWxKBocdoyeLae1Utg6OxgCy8xZ8OFIr+KZ
        kz39cRsd9qR0lBqv0lbFh5vf7Q0nOyA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-ZOQQVX_bMgijUKm9xjXB5g-1; Sun, 19 Jun 2022 10:57:38 -0400
X-MC-Unique: ZOQQVX_bMgijUKm9xjXB5g-1
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a056402441200b0043564cdf765so4392221eda.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sHot+2uLVoFYLq/OdJvXds01VXlhrLpmZp7IRLndQvc=;
        b=P7hvipD/vu9nCc7TyMqG4SGNxvc0I5VGvRchnfDV7W53P0mG1huVYYAoYowqmryYG1
         UqA+LVzrnzB4m8vwqnp3+KkNTOkk/q5U9yS/9t76wbPqLhgf030z/xSyj1I4PRJcFJ1l
         UN57U9IkfWPRZxoSWbdfNWskfhkHnIW4ISN4X65HExj9oa84FnEe+0WF2bTEEBc5hh/S
         jSkPvUqUp9HEbXUB2jKzrZVJFrxgudFd2RuR1nzGe9RUGDMszdQo1H9TdBFBEFyYYQSP
         eVMXxsedlEuWb6+exoeT/faJEmz+DdmBPWIvsazRBgRRkdTczHFFBY8aCqYc0VfxfntQ
         OipQ==
X-Gm-Message-State: AJIora90jYJ83yP5yyWVIFhBw5AZluB4L6O589btLUa1Fs/cxmMQQ5bQ
        Ol4Sh07fNA+n/mNSZYVeCui8WHffzpicfFg4oL+DxddbsBqBw9mtI+6UciccuV8V6jk7M3pt8Ii
        dR+K+U715wsEzB6dbPqG5cWuL
X-Received: by 2002:a17:907:3e04:b0:6f5:1132:59de with SMTP id hp4-20020a1709073e0400b006f5113259demr17955719ejc.755.1655650656876;
        Sun, 19 Jun 2022 07:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uyrRgJobN9yAkr1LNcjNx+4hHwL0KxM6mJL4iGhGXvgXAW5Y+tbRiU8ZcO8/DRY0Kpr74Qzg==
X-Received: by 2002:a17:907:3e04:b0:6f5:1132:59de with SMTP id hp4-20020a1709073e0400b006f5113259demr17955705ejc.755.1655650656705;
        Sun, 19 Jun 2022 07:57:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id lb21-20020a170907785500b007219c20dcd8sm1925024ejc.196.2022.06.19.07.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 07:57:36 -0700 (PDT)
Message-ID: <9c6cbae0-b890-96a9-1652-529d3b3be91c@redhat.com>
Date:   Sun, 19 Jun 2022 16:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm: panel-orientation-quirks: Add quirk for Aya Neo
 Next
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maccraft123 <maccraft123mc@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220619111952.8487-1-maccraft123mc@gmail.com>
 <cea478bf-ac29-dbdc-e156-5291da4f0318@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cea478bf-ac29-dbdc-e156-5291da4f0318@redhat.com>
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

Hi,

On 6/19/22 13:46, Javier Martinez Canillas wrote:
> Hello Maya,
> 
> On 6/19/22 13:19, Maccraft123 wrote:
>> From: Maya Matuszczyk <maccraft123mc@gmail.com>
>>
>> The device is identified by "NEXT" in board name, however there are
>> different versions of it, "Next Advance" and "Next Pro", that have
>> different DMI board names.
>> Due to a production error a batch or two have their board names prefixed
>> by "AYANEO", this makes it 6 different DMI board names. To save some
>> space in final kernel image DMI_MATCH is used instead of
>> DMI_EXACT_MATCH.
>>
>> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>>
> 
> Patch looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

New version looks good to me too:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I've some upcoming travel, so it would be good if someone
else can push this to drm-misc-fixes.

Regards,

Hans

