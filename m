Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418CC4F18BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378354AbiDDPqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378213AbiDDPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59FE2C5A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649087036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mwNp5wKi4sCpy/JwyVCVYtgRdExp7ZcRrflxIJ6FsDA=;
        b=Bz1+aDBqBy+aL0xq/nPkTd9n6TmgYi2qzdUFy2/SmP0SjBK4D07mJGIdf3SyvACvIyLnNg
        WhX6bUAa09byNdHKenZ5yw0iZE0GhDtoNk3NIMtGJi5YIxEUhqPTVOr+fi2W1TivIJbGjy
        SnlQKTjXf97YCt5fJJAAuMkkAWoIFKQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-UbuEe_gQNzSXqCpdMwa8FA-1; Mon, 04 Apr 2022 11:43:55 -0400
X-MC-Unique: UbuEe_gQNzSXqCpdMwa8FA-1
Received: by mail-qt1-f199.google.com with SMTP id o15-20020ac8698f000000b002e1db0c88d0so6533527qtq.17
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mwNp5wKi4sCpy/JwyVCVYtgRdExp7ZcRrflxIJ6FsDA=;
        b=b20huPwcK0kEzqEY6zznb2gtk4yuOqxBTJtiCUziyFcCBB+Yo4Z81lnZSejQ4UzVG7
         WFcfTSLnP+jDp4v0HAizPgDJuNIX84NtXHq3q6gRKmKCVBG4hg0FIoXAoSIQ6t3bRyRF
         5T24l3FVUnMcKm90oRpsOXwg64IKGsULtzcgnP6Klp/pFFi0y00xo5uKJ5cnGQ0giJI1
         CUEyi5SQiXce3upUUqeKk+jNUGi/ON1vC04U4a8fY6qddPXUitQVOY3aAcsrb3dqKBXw
         zNT9Ljjv0cYtWdIynDesRhIFCwWa2fhgCNPh5ljEZc4TojSx82mxu6cvXOx6klQpnCtX
         3lbQ==
X-Gm-Message-State: AOAM533qJbDItABRPZN4a/C3phkByFd316tjGGuRFRDI5kPrcwrhduBS
        NKlqnoE2Q8yuqfZqAhUCS4z3mZ0yQAGyWt5jTQrSaJDLG8ghxbwWkWIs4C3Onh8+ypIYYoCFsBM
        B87XNNRlpG+4IAY1oGbSVyLKYiyoUk9cj9uz9XZxLhGu+MYQoMtWsiZaFtEqJqQmPLte2XdM=
X-Received: by 2002:a37:6504:0:b0:67e:3194:db63 with SMTP id z4-20020a376504000000b0067e3194db63mr289803qkb.127.1649087034567;
        Mon, 04 Apr 2022 08:43:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybZ7GEppWMSjwP+Dw95nhG/D+6y4DJjms9Bgretl3gqv1QkhXx47I5wVPODts8wMYZWebucw==
X-Received: by 2002:a37:6504:0:b0:67e:3194:db63 with SMTP id z4-20020a376504000000b0067e3194db63mr289769qkb.127.1649087034272;
        Mon, 04 Apr 2022 08:43:54 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b00680af0db559sm6776261qkb.127.2022.04.04.08.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 08:43:53 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/display: cleanup extern usage in function
 definition
To:     Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, wenjing.liu@amd.com, waynelin@amd.com,
        Anson.Jacob@amd.com, Yu-ting.Shen@amd.com, keescook@chromium.org,
        nicholas.kazlauskas@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220403142137.2234322-1-trix@redhat.com>
 <513a5993-2cc5-54fa-2d6c-f4162d76ab0e@amd.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <462e2f2a-0cc8-2e2e-93b6-504cc12aa768@redhat.com>
Date:   Mon, 4 Apr 2022 08:43:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <513a5993-2cc5-54fa-2d6c-f4162d76ab0e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/22 8:22 AM, Harry Wentland wrote:
>
> On 2022-04-03 10:21, Tom Rix wrote:
>> Smatch reports this issue
>> hdcp1_execution.c:500:29: warning: function
>>    'mod_hdcp_hdcp1_dp_execution' with external linkage
>>    has definition
>>
> Which branch are you using?

linux-next from 4/1

Tom

>
> I don't see the 'extern' on
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
>
> Harry
>
>
>> The storage-class-specifier extern is not needed in a
>> definition, so remove it.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
>> index 6ec918af3bff..1ddb4f5eac8e 100644
>> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
>> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
>> @@ -497,9 +497,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_execution(struct mod_hdcp *hdcp,
>>   	return status;
>>   }
>>   
>> -extern enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
>> -		struct mod_hdcp_event_context *event_ctx,
>> -		struct mod_hdcp_transition_input_hdcp1 *input)
>> +enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
>> +						 struct mod_hdcp_event_context *event_ctx,
>> +						 struct mod_hdcp_transition_input_hdcp1 *input)
>>   {
>>   	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>   

