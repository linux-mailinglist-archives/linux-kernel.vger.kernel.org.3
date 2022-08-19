Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8D599D96
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349525AbiHSO01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349567AbiHSO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BAAE990D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660919163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eICnUMCnIldtlbZrl7FbZerwo61fNEIPgGY03g7m9SQ=;
        b=JlyZPpLAvhP7xV63oKAnhGdwPdm8Sj6V4TMNPlDH+CPSBS9wb1S2GfsOajGD3Yx+CsEJ8A
        bP1uPpZNE7lxfBQiM1qI+eMSIJ0UlXRGZw0BYKSY8nah4tLd5tCn53hOsiRKhMSSS1JenB
        zlDm56e+c6l2RxAIr8NUL9qNxym8mQ0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-lpBn-DqLNNm3M5Q5HGjEaA-1; Fri, 19 Aug 2022 10:26:01 -0400
X-MC-Unique: lpBn-DqLNNm3M5Q5HGjEaA-1
Received: by mail-ed1-f70.google.com with SMTP id h8-20020a05640250c800b0044642d29d35so1075575edb.18
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=eICnUMCnIldtlbZrl7FbZerwo61fNEIPgGY03g7m9SQ=;
        b=xXXVXuoLmbvV6/HypXO8ydqLsPEWJ3/wrupB9YG6fe0JnUMQNB+ZHaq4586S1CUTqk
         A0mlFkW4r2mNqPtYX5+CRlCIm9rF4ZriqZ8G6qrjKAeV7hdyjOc8MDyHVmaw5Yo1QzS9
         V/UbB5Vs0RUYr4mB30xDQIBpHGYSPuP0IufwncBJgmNE59kWVoJYtuXamuUjfqalfnhi
         n7fhnoEo7JRHdBxbjO/nqAIlOQSnhq+aMHjCTjpSnm3foQxtDfBY+QhrXbKu2hSQfitp
         yfcsWEgD8C9op4EilyxOtXx+2dZMP3aNKTH5eULNNLcb5eCtuDcsV0yoysF2gD7DWbDa
         JkjA==
X-Gm-Message-State: ACgBeo1nCsvAnhN4F7hIY4ZyfhbSTwTZoiek9YhEZHqMgK+RWeVGau9Z
        Jpiigiru4TmPzVeCyslEvMtSooBzQB5oaXr5OJI9UfWCldd5cHa6N9hPf8dMYbTuIWKJ3UubZf8
        lW5NZbgyqAAOeXWbneM+FSoOy
X-Received: by 2002:a05:6402:22f3:b0:446:39e9:5d0e with SMTP id dn19-20020a05640222f300b0044639e95d0emr2966902edb.300.1660919160746;
        Fri, 19 Aug 2022 07:26:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR63eJLF5q6lph4qaiToW0WKHDqW73GHbf0jK4qlifdLRM1JnNcG7Cu+W7XEKmmCbaYhJF6M5g==
X-Received: by 2002:a05:6402:22f3:b0:446:39e9:5d0e with SMTP id dn19-20020a05640222f300b0044639e95d0emr2966890edb.300.1660919160596;
        Fri, 19 Aug 2022 07:26:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id kw11-20020a170907770b00b0073c9db65819sm1470939ejc.47.2022.08.19.07.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 07:25:59 -0700 (PDT)
Message-ID: <e15d7107-636d-eb55-10a3-24a1e311f7c0@redhat.com>
Date:   Fri, 19 Aug 2022 16:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/8] remove some dead code
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <202208192018.BfgiZyOY-lkp@intel.com>
 <cover.1660916523.git.namcaov@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cover.1660916523.git.namcaov@gmail.com>
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

On 8/19/22 15:49, Nam Cao wrote:
> Remove some unused functions and variables.
> 
> Change in v2: add a new patch to fix kernel test robot's warning
> about unused variable.
> 
> Nam Cao (8):
>   staging: rtl8723bs: remove function rtw_odm_dbg_comp_msg
>   staging: rtl8723bs: remove function rtw_get_ch_setting_union
>   staging: rtl8723bs: remove function rtw_odm_ability_set
>   staging: rtl8723bs: remove function GetFractionValueFromString
>   staging: rtl8723bs: remove function IsCommentString
>   staging: rtl8723bs: remove function rtw_odm_adaptivity_parm_msg
>   staging: rtl8723bs: remove function rtw_odm_dbg_comp_set
>   staging: rtl8723bs: remove static const variable odm_comp_str
> 
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 21 -----
>  drivers/staging/rtl8723bs/core/rtw_odm.c      | 79 -------------------
>  drivers/staging/rtl8723bs/hal/hal_com.c       | 55 -------------
>  drivers/staging/rtl8723bs/include/hal_com.h   |  5 --
>  .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  1 -
>  drivers/staging/rtl8723bs/include/rtw_odm.h   |  4 -
>  6 files changed, 165 deletions(-)

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

