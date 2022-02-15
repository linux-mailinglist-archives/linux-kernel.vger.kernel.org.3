Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB55D4B7A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244483AbiBOWKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:10:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243913AbiBOWK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:10:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 765AB23BC4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644963016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lpQF/1aozwPXUYPuIRUCyzJVUaZkY7i5LfgQfbgp/4=;
        b=Xw8m5WqnW3PFmVF1QbQu/dqc29BqE40TEK64PM6f/Hk7af1IhOc+vAp/4XykZ0nDuohgm7
        V8fNDuKc8AR0JSSAsIzowwDDM/p1tepFmWjkJZ+4ez+UFll8Xleefn1HpKyC1/yPzhY39O
        MAy7wuCvz3eftGnkw61/exVJjBfLhpM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-n9e2M8DvPcSeJgUY3_0kRg-1; Tue, 15 Feb 2022 17:10:15 -0500
X-MC-Unique: n9e2M8DvPcSeJgUY3_0kRg-1
Received: by mail-wr1-f72.google.com with SMTP id s5-20020adfbc05000000b001e7af4f2231so109757wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/lpQF/1aozwPXUYPuIRUCyzJVUaZkY7i5LfgQfbgp/4=;
        b=cfAL4b7uQYgkd15aQkkSYu7CfJuox2StM6mShd7t7aW4VW94ziL2JWg6wTaO8da3fC
         CeXE8GofoIcAexnDR4ip/4QVBdf7aK2JF7xuZqPfWKEUaZcdumsqpZUgxSYwjp8xsqFy
         SWDG/dwLiJpy2Dl6K+Ea53+1wqB+0UEyH51TZ6RC3wQR7VePvHIfNYXITAXp9ZarpMSU
         8RLaEq/LQ6iguuf6L4UCZZZwBl9F08kPFXaZM6fIGGozPrFeNSjWQozC3MOzkSfIXfff
         uuEfFhCThdp0jgnEyTbHCHRX2wV+9e6H0HLVyYX0lcCmYqh8NJIZsjx8SKJT0XiWOf4E
         cm8A==
X-Gm-Message-State: AOAM533mKU+EUJ3T8umXay9hULt0+PiHB2l97WGwUV7TC3oIQhBMaC+S
        0AC6x8u6JATow9homOZukLOUGvaJJp2zCAtqOqyB3/4A3upGWaqFH3UYo2nBGunZlJf3dEuIhl8
        +NbrhK9Q/mF1Yq1CwDgvcUQcV
X-Received: by 2002:a7b:ce84:0:b0:37c:52fe:a3ff with SMTP id q4-20020a7bce84000000b0037c52fea3ffmr2504362wmj.48.1644963014379;
        Tue, 15 Feb 2022 14:10:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5t5oT/WGZxlEhtAFFuNjdgRZmbAJp74nksVLboadzTM50qN6VJ2Ad4Sqri3UYJkxSujekWQ==
X-Received: by 2002:a7b:ce84:0:b0:37c:52fe:a3ff with SMTP id q4-20020a7bce84000000b0037c52fea3ffmr2504351wmj.48.1644963014221;
        Tue, 15 Feb 2022 14:10:14 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 12sm8773502wry.111.2022.02.15.14.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:10:13 -0800 (PST)
Message-ID: <d875e70c-e9a9-9e4d-7041-f8ff6ee48f4f@redhat.com>
Date:   Tue, 15 Feb 2022 23:10:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] drm/panel-edp: Allow querying the detected panel
 via debugfs
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, robert.foss@linaro.org,
        lschyi@chromium.org, Sam Ravnborg <sam@ravnborg.org>,
        jjsu@chromium.org, David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220205001342.3155839-1-dianders@chromium.org>
 <20220204161245.v2.3.I209d72bcc571e1d7d6b793db71bf15c9c0fc9292@changeid>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220204161245.v2.3.I209d72bcc571e1d7d6b793db71bf15c9c0fc9292@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/22 01:13, Douglas Anderson wrote:
> Recently we added generic "edp-panel"s probed by EDID. To support
> panels in this way we look at the panel ID in the EDID and look up the
> panel in a table that has power sequence timings. If we find a panel
> that's not in the table we will still attempt to use it but we'll use
> conservative timings. While it's likely that these conservative
> timings will work for most nearly all panels, the performance of
> turning the panel off and on suffers.
> 
> We'd like to be able to reliably detect the case that we're using the
> hardcoded timings without relying on parsing dmesg. This allows us to
> implement tests that ensure that no devices get shipped that are
> relying on the conservative timings.
> 
> Let's add a new debugfs entry to panel devices. It will have one of:
> * UNKNOWN - We tried to detect a panel but it wasn't in our table.
> * HARDCODED - We're not using generic "edp-panel" probed by EDID.
> * A panel name - This is the name of the panel from our table.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

