Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3CB4FE1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355181AbiDLNJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357645AbiDLNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C30D2C667
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649767773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aZBKTB5BdnestxMdj/07bW+IS1GqohyMIbIwvT48vw=;
        b=WHuZBdrokSJ+Qlz0hzQYsEXGsa7kr2s522yjSMAuwa9qjSOk7wECwxISIreNbPMPfEt8A+
        /wKABg1B8EstxjGv6qWE2QyiprTU5DfC99i9N+k9IdZ7eRdgFzXLDa4KYNYJmfuAARZktJ
        kbXQ1RP5vRpQEa6KlTItzOuLtt9CI7I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-xWtWqkZgOSegVExJzH6DCg-1; Tue, 12 Apr 2022 08:49:32 -0400
X-MC-Unique: xWtWqkZgOSegVExJzH6DCg-1
Received: by mail-wr1-f70.google.com with SMTP id q4-20020adfc504000000b002079c9cc1bfso1633869wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6aZBKTB5BdnestxMdj/07bW+IS1GqohyMIbIwvT48vw=;
        b=j1GxKvNeKgeNjB2BctDMHc5pM4rMo3txpCDw/KpJSgxwicXAxj2bU08xWXeSK6p3no
         eyxpSV/EN8IMZbrRy2+RVQrQ9soUz+slKYatFxegiXItKz/Wfl8OLqS/ETTv4eOycEth
         mX//t+TgScVxbrm1r1x7WeVJHETfStKnIh/f6PzSpFNbIIYiT9z/y93DNRw8MXp9ZbTy
         8uGU9HHgWe+8P1iGiVPOMeeEQEoo+VFHjCIBEYDDjInLbzo3NMyANTRry9tEZFL7R84r
         6s0toF+Xmceq1WaGIEkpCviKlyWoVIr6KQhc1CsXh1ioAjPjlfCP52tSTXQrVvv5eNdJ
         bapA==
X-Gm-Message-State: AOAM533VNOWOt5SuvO2o4GAnTVR8EVyhXv1x3FjJWGItlm2B1tMbCGdI
        8oNrZG+7n8hSBstV2hyXXE7WPj7TlYy4Vvt+A1TUVPxbMuz/nAUYv0LQtKr5vlLUz+lXN1igg0Y
        dJ+TnG9lTHtsWvgC/CS2XBI49
X-Received: by 2002:a1c:35c2:0:b0:38e:c75d:90a3 with SMTP id c185-20020a1c35c2000000b0038ec75d90a3mr3401927wma.98.1649767771389;
        Tue, 12 Apr 2022 05:49:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygjYoMGC2lgYeBF5Ke4bl1SzKCjpQSFH5jCLjSKYAGIYkoI4H+oTt5pffQRoaBBQWPPpiY7w==
X-Received: by 2002:a1c:35c2:0:b0:38e:c75d:90a3 with SMTP id c185-20020a1c35c2000000b0038ec75d90a3mr3401912wma.98.1649767771190;
        Tue, 12 Apr 2022 05:49:31 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 2-20020a056000154200b00203ee1fd1desm31172443wry.64.2022.04.12.05.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:49:30 -0700 (PDT)
Message-ID: <60bfa30c-35d7-7853-5741-b7a1ec9e0441@redhat.com>
Date:   Tue, 12 Apr 2022 14:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/5] dt-bindings: display: ssd1307fb: Deprecate "-i2c"
 compatible strings
Content-Language: en-US
To:     wens@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-2-javierm@redhat.com>
 <CAGb2v65CBZp3DZFGX0GMTaQQPYMKJTJMNoU2V5u7MxsLN7ONKQ@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAGb2v65CBZp3DZFGX0GMTaQQPYMKJTJMNoU2V5u7MxsLN7ONKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen-Yu,

On 4/12/22 14:07, Chen-Yu Tsai wrote:
> On Tue, Apr 12, 2022 at 5:12 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[snip]

> 
> I think you can just drop this one, since it was just merged and isn't
> part of any release yet. It's not even in -rc.
>

I believe you are correct and we could just drop that one.
 
> ChenYu
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

