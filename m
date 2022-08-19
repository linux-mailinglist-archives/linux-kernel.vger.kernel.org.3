Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492D65998E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347855AbiHSJlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348182AbiHSJlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFC01D0C9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660902111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QK3tGbhgg9Wc4LaimALsSpNV614pnfrrnLDCexVqWss=;
        b=Y+P3NC2C91KQyokc+CckqPwn6BoEdlI/vcZKxx5PP7OXtmJgbiE8omx/a+TMG+G0P1yFua
        fBXFx0tDRvC66Sy0mAmIhsO+jAtzJiWNQBMU8M6RBbc9bPNnhPGl5+paJvh3R5VM38Muf8
        WvOYYRilSFccOzRa84+1vSvE6jqKUQg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-xDdaZXB-MzSh4V7iMPfhtQ-1; Fri, 19 Aug 2022 05:41:50 -0400
X-MC-Unique: xDdaZXB-MzSh4V7iMPfhtQ-1
Received: by mail-ed1-f71.google.com with SMTP id w17-20020a056402269100b0043da2189b71so2500033edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QK3tGbhgg9Wc4LaimALsSpNV614pnfrrnLDCexVqWss=;
        b=xE2sFg+9t/LTdaL1KKiKKST0vFS4ZMcBJaByMWd2rk3B1Uu4KeiT6J7SzWNAYBGgTh
         JlDioo+di1X/PWjRtsroTfE/AgGGafGfn73cysEVQMUB9ytVtsgcbnoTVteM6kpg1ue8
         hkU2ey//1b81ArJg7NcaawpjBPiWq+qdMGPvc2Egbd9sPub6/VSzKy6UleNMdHaBP9gB
         TaOR470iTsGiSxbIacpURz9h4BE9QHwUaQel/I16E/yUM+LydmAxFxkg5HxyofI86al4
         1lsj6iguEcswVZV4Q+4jMJ8KIIgwkHqwoNAeQsXinr/Y7IWaj9cmbmpnmrLQtjvjr2KQ
         Lv6g==
X-Gm-Message-State: ACgBeo26VpZB/rq/VCivYKuCkznznbEoS5fyam01e1uFrLNr7RB4cq+0
        mlBmSr05IGvrfts7/SXcm/YwU+hUCKvspe9kmVCr78gDDm7H/+Ymtw/nK4hJZcj9EQ+J6ydoOpx
        t9D514k6qLMTZHYxejpD/9yRU
X-Received: by 2002:a05:6402:14c7:b0:445:bb86:3f15 with SMTP id f7-20020a05640214c700b00445bb863f15mr5546114edx.68.1660902109041;
        Fri, 19 Aug 2022 02:41:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5pkXmoWgzYRI0p/MWqkQVQuvYeIE0y/URefg1UTLL6L6RUHk9durJLYXgAFLxmuXHJDELjSQ==
X-Received: by 2002:a05:6402:14c7:b0:445:bb86:3f15 with SMTP id f7-20020a05640214c700b00445bb863f15mr5546101edx.68.1660902108849;
        Fri, 19 Aug 2022 02:41:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906701600b007262a5e2204sm2050079ejj.153.2022.08.19.02.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 02:41:48 -0700 (PDT)
Message-ID: <4f280f1f-7fa1-6e35-657d-6e68c41d9b1b@redhat.com>
Date:   Fri, 19 Aug 2022 11:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/3] staging: rtl8723bs: remove useless files
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Larry.Finger@lwfinger.net
References: <cover.1660901124.git.namcaov@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cover.1660901124.git.namcaov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/22 11:35, Nam Cao wrote:
> Delete odm_NoiseMonitor.c and odm_NoiseMonitor.h because they are
> useless. The first 2 commits are preparation, and the final commit is
> actual removal.
> 
> Nam Cao (3):
>   staging: rtl8723bs: remove unused function ODM_InbandNoise_Monitor
>   staging: rtl8723bs: remove member noise_level from struct dm_odm_t
>   staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c
> 
>  drivers/staging/rtl8723bs/hal/odm.h           |   2 -
>  .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  | 130 ------------------
>  .../staging/rtl8723bs/hal/odm_NoiseMonitor.h  |  39 ------
>  drivers/staging/rtl8723bs/hal/odm_precomp.h   |   1 -
>  4 files changed, 172 deletions(-)
>  delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
>  delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

