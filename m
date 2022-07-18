Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21875784CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiGROHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiGROHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9205224BC2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658153259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tm1Ry/jluPMhvTxNdzuMnvFkG8fBqNb9ar/W3QhslyA=;
        b=afMWUTsagpoHnUyUEP26aymsVXYErvWBCTTYN1wDYgFmihm14Es2J/gSSzuFRV7xOO7nUl
        6JrcWrz++lkaBk62oqiU3kKDjY/dyeBsIwyldajyNZinh7+Fi8FUZgOk54agMoq74hNT6O
        HKxSm8vPs75Z37Vc0A+nUseZsJyPw/o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-uU2DBcy9OPCR_bbjn4y2Vg-1; Mon, 18 Jul 2022 10:07:38 -0400
X-MC-Unique: uU2DBcy9OPCR_bbjn4y2Vg-1
Received: by mail-ed1-f71.google.com with SMTP id z20-20020a05640240d400b0043a82d9d65fso7926078edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Tm1Ry/jluPMhvTxNdzuMnvFkG8fBqNb9ar/W3QhslyA=;
        b=VkF2fhMca6ZDv78j8I4cvA4Hm44tIQHoA1QlSxGYG22HKTucQce9CCqs0l4vCvipxL
         xmnyy0exNScDrOPSIEy/YwWUY8p23YRf8gC43sc3MmHmpwZEWhGNI3hlzYnsb6fg5C04
         ccsKdriNy53TIJBKu4vXMgIUn9qPBjecTbkiDvkPNVzdOmHZ5YlQmwXcT4NVfFeblDtL
         utfvXtG5cy5CfbdgQqXDl80+mJXutW4z38rAMcK+bLqthq1tdQuO950mu8PauVzhc1aH
         KymkLXshLnUP3QG2He/ECTkxvZ4nmSA/epq17GxKw0NLkj0VK8NiP7vx8N9HsDhM37x8
         i11w==
X-Gm-Message-State: AJIora9w9qmu8pzrP0Gz9t5sRalhUYNBRGSp9NEMIXUX2Y5LJBpYuQ0w
        6lOjSJHfRttt70MecRBQKpzr0S1hzwK1JIJzNC25VgFpb6j6ABiPiYAzOkJK9fZZSI1MsvOJagY
        EYq9Z3G44+Y+D1xvbyacadJ0y
X-Received: by 2002:a05:6402:50ce:b0:43a:c86a:b897 with SMTP id h14-20020a05640250ce00b0043ac86ab897mr37499373edb.321.1658153257292;
        Mon, 18 Jul 2022 07:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sAbp20lriLakChepMzAgJe+dxcxb3FumYRDkwcQENNezLWGBdUwpRWJsj+TLyXrZpdnumyJA==
X-Received: by 2002:a05:6402:50ce:b0:43a:c86a:b897 with SMTP id h14-20020a05640250ce00b0043ac86ab897mr37499353edb.321.1658153257143;
        Mon, 18 Jul 2022 07:07:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906297200b00728f6d4d0d7sm5531117ejd.67.2022.07.18.07.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:07:36 -0700 (PDT)
Message-ID: <94a792d5-cae9-27e9-af99-4a002565c08e@redhat.com>
Date:   Mon, 18 Jul 2022 16:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] HID: lg-g15: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>, jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220715054312.9320-1-wangborong@cdjrlc.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220715054312.9320-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/15/22 07:43, Jason Wang wrote:
> The double `with' is duplicated in line 769, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/hid/hid-lg-g15.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> index b2a08233f8d5..c8f82bcbf1ab 100644
> --- a/drivers/hid/hid-lg-g15.c
> +++ b/drivers/hid/hid-lg-g15.c
> @@ -766,7 +766,7 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  	/*
>  	 * Some models have multiple interfaces, we want the interface with
> -	 * with the f000.0000 application input report.
> +	 * the f000.0000 application input report.
>  	 */
>  	rep_enum = &hdev->report_enum[HID_INPUT_REPORT];
>  	list_for_each_entry(rep, &rep_enum->report_list, list) {

