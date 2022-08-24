Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4838D59FF00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbiHXP6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbiHXP6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776037CABE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661356725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Ff1QmPIlyrYnAdXajfzHu5Yv9RSqOuxoN2Oa3D8Yus=;
        b=bVsXOJeO75JREgZF6nVqLvkr+mST/Hd34Ez2MvRyIFxGBLxiZYLzGCnt9Hi1YYpemGjyMr
        hT1TiyaAuO+BvCkoES6gLeT7nXSpRkDuiJgiaGrAIxf0YDI3XMrh43pIsOo39UhRDdaY2o
        /dyLrAZRwz/dghgSqPRrmBft3xaLJ1U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-9PnprSxSOJujJ_b9xi4N8A-1; Wed, 24 Aug 2022 11:58:43 -0400
X-MC-Unique: 9PnprSxSOJujJ_b9xi4N8A-1
Received: by mail-ej1-f72.google.com with SMTP id ho13-20020a1709070e8d00b00730a655e173so5350602ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=6Ff1QmPIlyrYnAdXajfzHu5Yv9RSqOuxoN2Oa3D8Yus=;
        b=atJF3usrpXakUGLLLUa7WEeTsPxv+hJOt9mJcFUvq9pyTLoj99/9cAbb24lZ19W/wf
         uBFSEO0XFTOXVTtbGiX/jKkceZRWRuOI2fmX+3l+SI1IrRp2k1lDApqsLUlqEtPn2BVB
         ilBf5GsO0IpwU4s1JH+GcRPvgBAGoKfPGGPPueZpq5p89vJt83YxzigaE1sO6TFs5A9E
         TmAwAL5dXDOtOAUjSTXci84xwTA7zBcxYCxlDEotqRJ1ERn0jysdwEFHPQ7HDYI8POhr
         uYnNSzl8/iaXSH1VkH3pISs4xbIGyTlH5dQdOzXVhwxqo+1Dm3Gb95AvE5idWJ5vM7KJ
         YTCA==
X-Gm-Message-State: ACgBeo3bQ4CXSp2mIVMQy6SHnS511WbtxOt1t79xhbIS1vVE1SFHjQm7
        TaRf3hEmyfdzMDKjn6vXFJxZWRmC1RnjOprBcjpcDyJGZt5Q2aagJIrys9jFMg1mB1KOsb1hCOm
        oDPVWe52Ebp/eZoDJ3KpO9liM
X-Received: by 2002:a17:907:60c7:b0:739:52ba:cbd0 with SMTP id hv7-20020a17090760c700b0073952bacbd0mr3379476ejc.152.1661356722619;
        Wed, 24 Aug 2022 08:58:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7GI3i0UedamIoOYIDqmV1E+eiXCyENJwr+fHf8/hxFh8cyg/ZDO32RED6QhINoR/yFqFW+kw==
X-Received: by 2002:a17:907:60c7:b0:739:52ba:cbd0 with SMTP id hv7-20020a17090760c700b0073952bacbd0mr3379471ejc.152.1661356722438;
        Wed, 24 Aug 2022 08:58:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id bm2-20020a0564020b0200b0044604ad8b41sm3318568edb.23.2022.08.24.08.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 08:58:41 -0700 (PDT)
Message-ID: <bd89a246-ee32-7b54-9c9c-7090cc7d51a2@redhat.com>
Date:   Wed, 24 Aug 2022 17:58:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH drm-misc-next v2 2/4] drm/vc4: plane: protect device
 resources after removal
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        tzimmermann@suse.de, linux-kernel@vger.kernel.org
References: <20220819110849.192037-1-dakr@redhat.com>
 <20220819110849.192037-3-dakr@redhat.com>
 <20220824154823.qu3tdwypg5o3ci4z@houat>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20220824154823.qu3tdwypg5o3ci4z@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 8/24/22 17:48, Maxime Ripard wrote:
>> @@ -1252,12 +1261,17 @@ void vc4_plane_async_set_fb(struct drm_plane *plane, struct drm_framebuffer *fb)
>>   	WARN_ON_ONCE(plane->state->crtc_x < 0 || plane->state->crtc_y < 0);
>>   	addr = bo->dma_addr + fb->offsets[0];
>>   
>> +	if (!drm_dev_enter(plane->dev, &idx))
>> +		return;
>> +
>>   	/* Write the new address into the hardware immediately.  The
>>   	 * scanout will start from this address as soon as the FIFO
>>   	 * needs to refill with pixels.
>>   	 */
>>   	writel(addr, &vc4_state->hw_dlist[vc4_state->ptr0_offset]);
>>   
>> +	drm_dev_exit(idx);
>> +
> 
> You did change the CRTC patch, but the comment to protect the entire
> function also applies to this one.

Yes, I changed this one too, but missed this particular function - gonna 
send a v3.

- Danilo

> 
> Maxime

