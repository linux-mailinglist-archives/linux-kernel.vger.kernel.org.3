Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109E359984D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347348AbiHSJGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345743AbiHSJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2913FEE6B9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660899998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0Slx1DKcgKnlcXGqv5kEXSQpwXtWUMVWojFb3cRpXU=;
        b=fLDpsblBLgt0MzoOjbbHuSGXwi7y6d9vCUQLkgHNkfVfY46BAeMCFpRaHmTj7Tj2KwKVqf
        mnUJnH2NyJF1APnrL1O2Rsv4l73/MFrYjatDNmbXWZgWK2iVD610iE9Wv7dVCm9Vxq1dS9
        XG68xXkWTkcliNN8fZ70e4+HFx2GdlI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-520-MQ5jPsDbP66vV3JRfu-Mgg-1; Fri, 19 Aug 2022 05:06:37 -0400
X-MC-Unique: MQ5jPsDbP66vV3JRfu-Mgg-1
Received: by mail-ed1-f69.google.com with SMTP id w5-20020a05640234c500b0043dda025648so2497724edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=R0Slx1DKcgKnlcXGqv5kEXSQpwXtWUMVWojFb3cRpXU=;
        b=gWkQUtoPsGfsyVLwAij59RCrWimCzRRAPExYAT4IQBnZA4VIoMVIB8O8yARpPe8Pw2
         lTAQrSIBEnwpBFnN3RF/g2BUJJgFniw39R6qGbHaj++bbUxeb6/oVPVeNhmxH3bS61Dt
         Oiu14vxvQQOXH8h+EC2QeNC+3zQAbu4v20ZIWPD9ZHqeuEr+coDl4gqSgcuTKs0ZsPhe
         hXolM7gmuTy8dud5qH+a4LBJ8g3f7t7C9Otwe2qFS5RIxDRl1H3HtkbMH+p+gDUWzylT
         iCLzRgnwL47DnBeuUypzMpQKHnOFqIoQOka7iScFnVMUTY4BPARw6Z57YupipLg1YEe5
         JLww==
X-Gm-Message-State: ACgBeo0YFi91dKZerCGD3XcPhXNYe8xV89HDaysnNwmVjsMsQaMcxHYG
        gYatmLxydt89JAh2NPKNgizoMczMSbZhHWONHBw8qNSCk1WCz9KdV2AQz01eMZttiR4G9r8XbVk
        2wjLHGAKt9rqdd71MAmz5uONZ
X-Received: by 2002:a05:6402:415:b0:446:230d:2b82 with SMTP id q21-20020a056402041500b00446230d2b82mr3765981edv.200.1660899995764;
        Fri, 19 Aug 2022 02:06:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5iIcoNNPB6uqme/iA6yUwtAgX+OaDu1Z5NLDXlToy8Aw88ALMoFC2xRIWKIwiF7QVj2WRWRQ==
X-Received: by 2002:a05:6402:415:b0:446:230d:2b82 with SMTP id q21-20020a056402041500b00446230d2b82mr3765972edv.200.1660899995626;
        Fri, 19 Aug 2022 02:06:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b0073c82539183sm1233883ejc.91.2022.08.19.02.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 02:06:34 -0700 (PDT)
Message-ID: <d2f4a83d-6e15-b8ca-0bc6-d3a39915b7ad@redhat.com>
Date:   Fri, 19 Aug 2022 11:06:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/7] staging: rtl8723bs: remove dead functions
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Larry.Finger@lwfinger.net
References: <cover.1660898432.git.namcaov@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cover.1660898432.git.namcaov@gmail.com>
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

On 8/19/22 10:52, Nam Cao wrote:
> Remove some functions in this driver because they are not used anywhere.
> 
> Nam Cao (7):
>   staging: rtl8723bs: remove function rtw_odm_dbg_comp_msg
>   staging: rtl8723bs: remove function rtw_get_ch_setting_union
>   staging: rtl8723bs: remove function rtw_odm_ability_set
>   staging: rtl8723bs: remove function GetFractionValueFromString
>   staging: rtl8723bs: remove function IsCommentString
>   staging: rtl8723bs: remove function rtw_odm_adaptivity_parm_msg
>   staging: rtl8723bs: remove function rtw_odm_dbg_comp_set
> 
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 21 -------
>  drivers/staging/rtl8723bs/core/rtw_odm.c      | 44 ---------------
>  drivers/staging/rtl8723bs/hal/hal_com.c       | 55 -------------------
>  drivers/staging/rtl8723bs/include/hal_com.h   |  5 --
>  .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  1 -
>  drivers/staging/rtl8723bs/include/rtw_odm.h   |  4 --
>  6 files changed, 130 deletions(-)

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

