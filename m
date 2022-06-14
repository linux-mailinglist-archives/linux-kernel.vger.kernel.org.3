Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF41B54B1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiFNNDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiFNNDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 973192C64D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655211827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlgbQ0d3whh0zJEXTO6q7zEd4mBZ0vUay1OEfrGzcmw=;
        b=U9uiWGlgtnPHKazZyK1Hm3hBqdwA6yemajjggMNXnQiFHZsDmtgXlHN1FmQ30l1VT3Y1RB
        sGC4szWkZtt3J4/hggMvrxkA1CJEYiOidi8BrHU+aM7NALbtozoOruPhnnyLfqs5ZWBh4J
        kNtQmS0z/fgbhLZUwfj4c+0Hm0lxlL8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-vN9NYjnNPpy8tzZy9ny91A-1; Tue, 14 Jun 2022 09:03:44 -0400
X-MC-Unique: vN9NYjnNPpy8tzZy9ny91A-1
Received: by mail-wm1-f72.google.com with SMTP id m23-20020a05600c3b1700b0039c6e3c169aso4774699wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mlgbQ0d3whh0zJEXTO6q7zEd4mBZ0vUay1OEfrGzcmw=;
        b=S6jkZ5bMFaKV2J6y94JJad6dZcLSjUjKNLUYP35mMlXNz10u+ZmTptNqCf44aZEn3q
         ExVitcG3aHWaR86Cm5B88oj1y4HIeU69Kpk3UE6WnTL7ARhCQbxnkElGhxa70+HUj/sx
         IHNDJe6luryjmkdSgLcpdx8VGTW0ksaPjvkJ26A8WDHgpjWBceBv7+Wx5ApIVwwF5Yu7
         Sj0idSmAheFZaLbUOOFgTJsek29HJGGmj7HTqn3uhT89LH4edUUn+niajhSYBhXOAxbD
         FrJCs1fXPbMmOUxB2WCrIE+ql4TGVGAINcICJPM3+rZTONtx17h8nyfj5p+xLoarSDrb
         TADg==
X-Gm-Message-State: AJIora/+JrFXXYwosOK0fZfYgch1G+AZjDI6D4rwYdC7c9OSSB/QxlId
        A0rwlvlcWpjO4O/iLkc6Muctns3nkNwqVFytiIkQKPh0pwi+eOyvwLN0zcf3U6Dx7KfGa3i39mZ
        Vad0/gIn1U32UhOl0WvJn8yj3
X-Received: by 2002:a5d:4a4c:0:b0:210:27dd:e57 with SMTP id v12-20020a5d4a4c000000b0021027dd0e57mr4665435wrs.655.1655211823742;
        Tue, 14 Jun 2022 06:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8OOqxbEms0K2jYgdmxNRVT96IUT7mYE8cfIbeBLNLXDRPzxVHiTpZ6UYrmjBsW/c1GIrwAg==
X-Received: by 2002:a5d:4a4c:0:b0:210:27dd:e57 with SMTP id v12-20020a5d4a4c000000b0021027dd0e57mr4665418wrs.655.1655211823520;
        Tue, 14 Jun 2022 06:03:43 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d610d000000b0020c5253d914sm11986843wrt.96.2022.06.14.06.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 06:03:43 -0700 (PDT)
Message-ID: <15dac932-ab2d-1c2e-6438-75e8eda6dd62@redhat.com>
Date:   Tue, 14 Jun 2022 15:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/3] KUnit tests for drm_format_helper
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220613171738.111013-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 19:17, José Expósito wrote:
> Hello everyone,
> 
> Here is the v3 of the series, including the documentation, previously
> sent as a standalone patch [1], and changes suggested during review.
> 
> Thanks a lot,
> José Expósito
> 

Before merging this, could you please reach the folks working on [0] ?

I think that would be good to have some consistency with regard to KUnit
tests from the start to avoid future refactorings. For instance, you are
adding the tests under a `kunit` sub-directory while they are doing it
in a `tests` sub-dir.

Also there may be other things that could be made more consistent, like
the naming conventions for the tests, suites, etc.

[0]: https://lore.kernel.org/all/20220608010709.272962-4-maira.canal@usp.br/T/

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

