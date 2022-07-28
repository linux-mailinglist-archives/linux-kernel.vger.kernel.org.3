Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5DA58426A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiG1O6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiG1O5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D93246A49B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659020195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ow7cxV/Atc87f2QLcR9gN0+95qXSVO5SPHOy85HIOrM=;
        b=TBcVhfDQMIAe+vWG+S3gh0eMhO4+4OMaBPYegSEWMsv8yhW4PRfyrHOTvISxCwAnMoIOHH
        5SBMytCrPPgzu6uFR2ym2JZNUObM83u5HuvsIL2btR9hUP2+rtECq+5d1cEpmvtLwSE5AE
        NCCr3bA/to+96fTNBl0GKmbOzkQ/8v8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-vr3C8Yz4N3Kk8HBTE12YhQ-1; Thu, 28 Jul 2022 10:56:33 -0400
X-MC-Unique: vr3C8Yz4N3Kk8HBTE12YhQ-1
Received: by mail-ej1-f71.google.com with SMTP id qw22-20020a1709066a1600b0072f43c1f59bso706959ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Ow7cxV/Atc87f2QLcR9gN0+95qXSVO5SPHOy85HIOrM=;
        b=1kchiu7ZlgKSgoOYIVSfyahNys+j07gCIX6tFL/90mfpREja0Ov/QSS53yOIo/l6iX
         PqwLl4anaY3thBZsd4ao64ruj+LNFX7oBqjXMU/W2w7vsWxaBRw2d4FQN1WAQrH9yWl/
         byqJofH/CbPRcl4PgyCmdp62ci7929p0sMNdj6CJ+SV/gepRisYffe/jHJupG5gzWLFa
         JssYYspWikBauQFsASOfbVWiw5SSWhJaA4d8hzUwt47QW4wAD9W3Pdr62tyw+7+2Xl1Z
         5/gxgLjoNtOdMEHzhhTTzNaFSH5IrA32aoc0ov5p6boo/IAqagGepb+UlXjmZxGavVzG
         /4gg==
X-Gm-Message-State: AJIora+IsyVgiYcJAEjXzddBt2KtMvdPNimJ3CEtt9wE28TZOSk4TT01
        CwQF4IU+iX8dYji2FZveNwl7tE8ZrJw4Gc+ES5IoAyJitYPFSaQBI5XRm1x6Op1L8XzuIIV9s9o
        CxUg2kp9EXlE1tH/PQm+SbozW
X-Received: by 2002:a05:6402:428a:b0:42e:8f7e:1638 with SMTP id g10-20020a056402428a00b0042e8f7e1638mr27739881edc.228.1659020192255;
        Thu, 28 Jul 2022 07:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tDmdcEEoul6TEaJrWO7TmsyTDEwAQLTQHfD/I1YBrvGdzgxhGW04Dbh9agWYJX6WNHPzo8Kg==
X-Received: by 2002:a05:6402:428a:b0:42e:8f7e:1638 with SMTP id g10-20020a056402428a00b0042e8f7e1638mr27739865edc.228.1659020192019;
        Thu, 28 Jul 2022 07:56:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l24-20020a056402029800b0043a7293a03dsm820031edv.7.2022.07.28.07.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 07:56:31 -0700 (PDT)
Message-ID: <f44b703b-dc53-932a-6701-00d553fe56d0@redhat.com>
Date:   Thu, 28 Jul 2022 16:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/10] drm: use idr_init_base() over idr_init() if
 applicable
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, emma@anholt.net,
        daniel@ffwll.ch, airlied@linux.ie, christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220701185303.284082-1-dakr@redhat.com>
 <165901911294.5946.5075667196143577988.b4-ty@cerno.tech>
 <20220728144413.nebc2js26vlwovr3@penduick>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20220728144413.nebc2js26vlwovr3@penduick>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 16:44, Maxime Ripard wrote:
> On Thu, Jul 28, 2022 at 04:41:41PM +0200, Maxime Ripard wrote:
>> On Fri, 1 Jul 2022 20:52:53 +0200, dakr@redhat.com wrote:
>>> From: Danilo Krummrich <dakr@redhat.com>
>>>
>>> This patch series initializes IDRs with idr_init_base(&idr, 1) rather than
>>> idr_init(&idr) in case for the particular IDR no IDs < 1 are ever requested -
>>> this avoids unnecessary tree walks.
>>>
>>> Danilo Krummrich (10):
>>>    drm/amdgpu: use idr_init_base() to initialize mgr->ctx_handles
>>>    drm/amdgpu: use idr_init_base() to initialize fpriv->bo_list_handles
>>>    drm: use idr_init_base() to initialize master->magic_map
>>>    drm: use idr_init_base() to initialize master->lessee_idr
>>>    drm: use idr_init_base() to initialize mode_config.object_idr
>>>    drm: use idr_init_base() to initialize mode_config.tile_idr
>>>    drm/sis: use idr_init_base() to initialize dev_priv->object_idr
>>>    drm/v3d: use idr_init_base() to initialize v3d_priv->perfmon.idr
>>>    drm/via: use idr_init_base() to initialize dev_priv->object_idr
>>>    drm/todo: remove task for idr_init_base()
>>>
>>> [...]
>>
>> Applied to drm/drm-misc (drm-misc-next).

Thanks.

> 
> The via driver had changed a bit and the patch 9 didn't apply at all.
> I've moved the change to where it looked like it belonged, but you might
> want to double check.

LGTM.

- Danilo
> 
> Maxime

