Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7CD51C081
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379279AbiEENX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiEENXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:23:14 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D381532D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651756774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IW6fOs7e5307KfibthmglvTovnRowFL+yzU/9f+OYUE=;
        b=a+/cQB3/ytrQ4GXerRzjZmwV4PbYFMPOH9cJt2HPMHvavlQb2AVIr9A00uAo/kzkO2BeQ8
        q7u3dzbDRVGpXnfxazuqdFIX+igQotxoEUBagJx8fFlRU3YWQNyTFalS4JYebbfLAGpYgN
        dWtfkS5ppyUlmatIp2znQ1SQDsABk5c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-ZG-mPil3MV-6GXp4zB39yg-1; Thu, 05 May 2022 09:19:33 -0400
X-MC-Unique: ZG-mPil3MV-6GXp4zB39yg-1
Received: by mail-wm1-f70.google.com with SMTP id r186-20020a1c44c3000000b00393f52ed5ceso4477973wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 06:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IW6fOs7e5307KfibthmglvTovnRowFL+yzU/9f+OYUE=;
        b=xQrDlwUMKesR8vMlQ3z7fB6UdG94AJG7GuVbv+jTtdXFTmvxQ5XQubbxRCbE7K7OBY
         vIuORDi/FGXmBdD1tcXuxyp4/ij4ZBiYVepSdnku7G2o5UDLnnzS6iIel/DtuGqhXFCY
         aDqmWVf77Rn0/S39ejBxQXJAmriFZn6TxDz92Upr3XCzrS0DPXScHV6J71xM2B0n9wAb
         aAjSBjbvmUk7YdT2QtU4OI0xw1jVERkvNdtHjlhI8YMrwji/ybdBlNZ/UgrXYlCPlc4V
         XvxyVmRSK0fpI13DXUNPlIzVuLMVwOlSVx7jpEW1V2ziDDe+wSW6MUnRgwA17VA/vShv
         RVIA==
X-Gm-Message-State: AOAM533SlaMuOGpI8HeWWAAk4BOFbxn+yC7pR/D5z9YLtE2u7D1yfsDn
        Qi9rumZuEU+kbtjzf6m5QaoAqd3WL7ii0LlUfCxW5s6ISYISyGP5Fied4dSZWfj5NKFQSif8nWF
        Cnv96q5Pjm8s8xbAiAx66QDTr5oShYvzq8vn+r1eYSrXGLLi5eZTL55RXvWU5sI4uZ5cSj9/7R7
        Q=
X-Received: by 2002:a05:600c:1d18:b0:394:6469:abec with SMTP id l24-20020a05600c1d1800b003946469abecmr4767706wms.89.1651756771955;
        Thu, 05 May 2022 06:19:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznOboZJQssf1bkI3Rw7a6NAaieRAgtKHnzU4znuTG9Om0VUyJQMtC9zyn0YmSBtfpe6zPe9g==
X-Received: by 2002:a05:600c:1d18:b0:394:6469:abec with SMTP id l24-20020a05600c1d1800b003946469abecmr4767666wms.89.1651756771561;
        Thu, 05 May 2022 06:19:31 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c17-20020a7bc011000000b003942a244f40sm6395959wmb.25.2022.05.05.06.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 06:19:31 -0700 (PDT)
Message-ID: <d53319d8-acaf-7b57-20cf-f35cc5969895@redhat.com>
Date:   Thu, 5 May 2022 15:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 4/4] fbdev: vesafb: Cleanup fb_info in .fb_destroy
 rather than .remove
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220505113128.264963-1-javierm@redhat.com>
 <20220505113128.264963-5-javierm@redhat.com>
 <YnPK3RLPdtvFze+8@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnPK3RLPdtvFze+8@phenom.ffwll.local>
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

On 5/5/22 15:02, Daniel Vetter wrote:

[snip]

>>  static void vesafb_destroy(struct fb_info *info)
>>  {
>>  	struct vesafb_par *par = info->par;
>> @@ -187,7 +191,13 @@ static void vesafb_destroy(struct fb_info *info)
>>  	arch_phys_wc_del(par->wc_cookie);
>>  	if (info->screen_base)
>>  		iounmap(info->screen_base);
>> +
>> +	if (((struct vesafb_par *)(info->par))->region)
>> +		release_region(0x3c0, 32);
> 
> This move seems rather iffy, so maybe justify it with "makes the code
> exactly as busted before 27599aacbaef ("fbdev: Hot-unplug firmware fb
> devices on forced removal")"
>

I think that will just drop this change. While being here I wanted the release
order to be the inverse of the order in which the driver acquires them. But I
will only move the framebuffer_release() that is the problematic bit.

Someone if care enough could fix the rest of the driver.
 
> Also same comments as on v1 about adding more details about what/how this
> fixes, with that: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>

Yes, I'll do that too. Thanks again for your comments and feedback.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

