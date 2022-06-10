Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E87545C33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346432AbiFJG2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243281AbiFJG1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1B74232D9B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 23:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654842467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fiIJi1XN3u2yapvAO8rmue6g1edc8yr4+ryGhU2WZo=;
        b=Z3LxN2Rr9Snm6PyE9zCJSOc3TVnGlFIwlYZk8W52Iqa4nauEf9rBxArcnE03xikXI2PMi+
        AH+1hRcnXWowc/UGZA3+uMJ8/nqJsP+D/0RSmhAXDMg3CWObpn2+jLNiIpD1g+oGG0NBe0
        WS6x5yEL51CbQ9bLHDl9gufyTjv6nuE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-cf4UTOECN2-HfafOnhrAlA-1; Fri, 10 Jun 2022 02:27:46 -0400
X-MC-Unique: cf4UTOECN2-HfafOnhrAlA-1
Received: by mail-wm1-f70.google.com with SMTP id o3-20020a05600c510300b0039743540ac7so9211509wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 23:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0fiIJi1XN3u2yapvAO8rmue6g1edc8yr4+ryGhU2WZo=;
        b=PnMKc5jBx4c5SykXvBh7ULKHv/yNC1Ci+wPEDuMEB8nElCEsmAfbWiT22856zvzKnB
         IqzqEXeQmRgo/JJKmpAgpUuIo6H7i0vA1xx64PZxdNaJt4xBqObrCgiVl77sKIPWIieE
         dtLgExIOL0FldfG2JqcQy2zzIbNsfLGaZeFxNXhTr1nMNgVptcRLghFdj2OyMTABWggd
         w7GHc+hzxe2iRcqho9xZ0zzir04QSp4uvNRteBoZ59yNCB+2PRy965Aw4dNnr4LMnaLP
         IQS+/Jc7RWIUgkmVIbiTAGcPpFOKdIzy6JaMYqYypgeFaFQFGnh1NL3VtKLdJcw0WYyk
         Gzpg==
X-Gm-Message-State: AOAM533DGxtTqwPGwqYUTRq5fvSOyp8HmTtzuzJlNHwNO7JAwFbhCdPI
        CpING0ckzDTjkBAKqkg6v6cQhYcDAUAGl+265xAfz82zT+73Po0RsSOjD5mUyYJizTCoiEnN196
        xxVgUxuu5e+h5ros8E42PIseg
X-Received: by 2002:a05:600c:2143:b0:39c:5539:c64f with SMTP id v3-20020a05600c214300b0039c5539c64fmr7003649wml.194.1654842465051;
        Thu, 09 Jun 2022 23:27:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7bSYyTOzPUQGah+cD4PKTfYPFiBzgYeM3T3D3Dmf1A8hnIK6ahj1/Ouss0HtAORQ/fNyM8A==
X-Received: by 2002:a05:600c:2143:b0:39c:5539:c64f with SMTP id v3-20020a05600c214300b0039c5539c64fmr7003634wml.194.1654842464847;
        Thu, 09 Jun 2022 23:27:44 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b003973b9d0447sm2131280wmq.36.2022.06.09.23.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 23:27:44 -0700 (PDT)
Message-ID: <7e264ff9-2ada-2413-110e-4105a5aadeae@redhat.com>
Date:   Fri, 10 Jun 2022 08:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 3/4] fat: add renameat2 RENAME_EXCHANGE flag support
Content-Language: en-US
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@verbum.org>,
        Alberto Ruiz <aruiz@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Kellner <ckellner@redhat.com>,
        Carlos Maiolino <cmaiolin@redhat.com>
References: <20220609093638.664034-1-javierm@redhat.com>
 <20220609093638.664034-4-javierm@redhat.com>
 <878rq54pf1.fsf@mail.parknet.co.jp>
 <9d837076-f666-c3c3-dd09-5c3705da23e6@redhat.com>
 <874k0t437f.fsf@mail.parknet.co.jp>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <874k0t437f.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 05:17, OGAWA Hirofumi wrote:
> Javier Martinez Canillas <javierm@redhat.com> writes:
> 
>>>
>>> Looks like unnecessary complex (and comparing raw i_mode, not S_ISDIR(),
>>> better to change before make dir dirty).  How about this change, it is
>>> only tested slightly though? Can you review and test?
>>>
>>
>> Your change looks good to me and indeed the logic is simpler than in mine.
>>
>> I've also tested it and AFAICT it works correctly as well. Do you plan to
>> squash this or should I respin a new revision of the whole patch-set ? If
>> you want to post it as a follow-up I'm also OK with that.
> 
> Could you merge to your patchset, and re-send?
> 

Sure thing, I'll do that.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

