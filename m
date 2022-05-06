Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4534751D8C1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392352AbiEFNWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbiEFNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:22:32 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30B5363516
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651843128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6eR4SrDmEoANuYmWC0BJSoz/4Iidosis2CSmMHpx9dc=;
        b=afmGy/yaKbVWbsmokn/UBFB721WxvN2NmZFYNONmm5UjEfQmND9C0k0ADiV5EP5ciZgI8S
        eprrY2akuvJHhY1zDFpbOyQcQ8r/eGdkw195v1i1uHtaU1tRCV7We6kLcGLM7pdLnTL5fs
        ZWGi3Qdig4omzfluN3tmaOXQFmZcO1Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-quDK5d2-Nc-GMZaeACiuqQ-1; Fri, 06 May 2022 09:18:47 -0400
X-MC-Unique: quDK5d2-Nc-GMZaeACiuqQ-1
Received: by mail-wm1-f70.google.com with SMTP id p24-20020a1c5458000000b003945d2ffc6eso2840744wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 06:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6eR4SrDmEoANuYmWC0BJSoz/4Iidosis2CSmMHpx9dc=;
        b=MTsJyT5rZMWpEtIxmmT1wMPgJqMoC/9Z+eCDBWXZqMXTNBsmuhMF+yTtB90h6oCAXD
         KFnPet3MdNyYvB+WIAFd+ilDU+dppJGfsGTR+07SWkYC12y+tlYiib1UmRBRdCP44GSn
         6wJgq8m0bOOrPd2wudNdO1sWEuSfWbxs9zGb2vvu0oQvnnTpxiSJ53B34DbvTZYjfenf
         REGoooV1+LRSbjsqefgJYR9slt71CJ8qxTh4fh5lpFxYkRW0VJxGodkEAqnGwTjLJ4F7
         AtxWW7FbWBOxdYkUN74J4d4F8Z0ltNolnA0T/KFh4iB4Iv3DtI7xPxxch2H6zQi2JeCA
         vKKw==
X-Gm-Message-State: AOAM533B7AyBDc3K1UxXssbN8ataw0VaEgrTXWvdW2Ce8PuiyZCesJJt
        4QdGxrqhDKO6dd6Eb3roIj4m9I6A0SBtQ5YCYKUFKh9I3W7ucvTyIOAtgzGIqSCzJDI+lZijZCn
        zJS4g+ANPMiL70IczH0uxgiNO
X-Received: by 2002:a5d:6d83:0:b0:20c:7329:7c36 with SMTP id l3-20020a5d6d83000000b0020c73297c36mr2784658wrs.518.1651843125834;
        Fri, 06 May 2022 06:18:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFmPqHpFl7IQ0p8a3cDOwPVFVGGBUGfQCaOkK4J9z39w72XOntceMZPP2+b4IAbt9zNBVruA==
X-Received: by 2002:a5d:6d83:0:b0:20c:7329:7c36 with SMTP id l3-20020a5d6d83000000b0020c73297c36mr2784632wrs.518.1651843125512;
        Fri, 06 May 2022 06:18:45 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s6-20020adfea86000000b0020c5253d907sm3671710wrm.83.2022.05.06.06.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 06:18:45 -0700 (PDT)
Message-ID: <00117d58-2a47-4e2b-225b-952e0e98df2f@redhat.com>
Date:   Fri, 6 May 2022 15:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/4] fbdev: efifb: Cleanup fb_info in .fb_destroy
 rather than .remove
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Peter Jones <pjones@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220505215947.364694-1-javierm@redhat.com>
 <20220505220540.366218-1-javierm@redhat.com>
 <ed57ca49-f80e-9bf5-4dc3-59fb62ca4315@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <ed57ca49-f80e-9bf5-4dc3-59fb62ca4315@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrzej,

On 5/6/22 15:07, Andrzej Hajda wrote:
> On 06.05.2022 00:05, Javier Martinez Canillas wrote:

[snip]

>> +
>> +	framebuffer_release(info);
>> +
>>   	if (request_mem_succeeded)
>>   		release_mem_region(info->apertures->ranges[0].base,
>>   				   info->apertures->ranges[0].size);
> 
> You are releasing info, then you are using it.
> 
> I suspect it is responsible for multiple failures of Intel CI [1].
>

Yes, it is :( sorry about the mess. Ville already reported this to me.
I'll post a patch in a minute.
 
I wonder how this didn't happen before since .remove() happens before
.fb_destroy() AFAIU...

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

