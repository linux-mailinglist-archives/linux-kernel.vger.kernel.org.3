Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C97E53C531
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbiFCGxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiFCGxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44E8E36315
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654239185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PN2E70IcGQYkGbR9w9o/Wmx5ihNGlhc87gRXnC3Yt38=;
        b=PnXJqb24kk8aGfSmARU5eclbAWaRD4nP5JzdDTcTlJ/8bm7gDkBL/GdBxJZhI7t8lqwd+n
        VYG/Us0PWtghU+o9MUPdkBzaQ7ONdJsWce5wIJBgjwLJpeHngW36lV7QzclUn3KtgM81GV
        k8oIiNd0QZwv8t7amNMAaN8EbCvBryI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-LVgC3G9kN-2yjNrINfoFgw-1; Fri, 03 Jun 2022 02:53:03 -0400
X-MC-Unique: LVgC3G9kN-2yjNrINfoFgw-1
Received: by mail-wr1-f72.google.com with SMTP id p10-20020adfaa0a000000b0020c4829af5fso1093307wrd.16
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 23:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PN2E70IcGQYkGbR9w9o/Wmx5ihNGlhc87gRXnC3Yt38=;
        b=p04Oia97fBiKy5n2KoAhkOowoOq1b3Ykb/pMIk6X6KDWtt64hw4QAd+BZ1Rf97UTe0
         iKPBH6VS/qlFeFhEaiDmDJciVc0UaBFjXzGMXaNYSgkfJ4U8sjgpCIScMrR3D9N4PgJy
         KH8VJ67eEJjvOv7tJG9vqFz5nOSP/HE++ssO/SZ39lwX3XXSr5aq0UvWsMXgYBV84uQZ
         JLxZNNnlNZkcv+drKw5YGJHH355glG1zmiDJSy9sMmCCiu2wlUIwbkX8hnSo/UjPgSgW
         E4JZ6Di7awvnQ8O2bSS8Gvd1w7aTZ0vJUKCDt8kiGtTNOOFP4xQ26Bz3yZm628UEbsQU
         vwyA==
X-Gm-Message-State: AOAM5326WAQHsnwDygGcczzRDxFxTy4DMLqD7/LWewmV31uQgFNxg6Q8
        G4M0art3z/JzPawtsZ+1fXTgEy7abnDetJP5YitLHwNk3uG5J20mfiUT6jCBaZ/9pl1yOt3q8Yg
        ELoAfH4N3mixzWUQqXsATKNfj
X-Received: by 2002:adf:db8b:0:b0:20f:fb4f:c3da with SMTP id u11-20020adfdb8b000000b0020ffb4fc3damr6798761wri.163.1654239182678;
        Thu, 02 Jun 2022 23:53:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOLHX0aJ3HCCTE752/lp0TycAuSWmxRG6uJvSvNncgae/lOYbOO4uYkuz3Oo2YI9QFwprQYw==
X-Received: by 2002:adf:db8b:0:b0:20f:fb4f:c3da with SMTP id u11-20020adfdb8b000000b0020ffb4fc3damr6798742wri.163.1654239182453;
        Thu, 02 Jun 2022 23:53:02 -0700 (PDT)
Received: from [172.28.2.131] (163.106.124.80.rev.sfr.net. [80.124.106.163])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b003973435c517sm5418077wmq.0.2022.06.02.23.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 23:53:01 -0700 (PDT)
Message-ID: <722055e6-0bc9-bb70-b729-3e211baee85e@redhat.com>
Date:   Fri, 3 Jun 2022 08:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/8] Add a panel API to return panel orientation
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220601094637.1200634-1-hsinyi@chromium.org>
 <CAD=FV=W+5GAUBh_ZMPeKhqxQXxau2OKCbt3p2QmsDhROf207dA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAD=FV=W+5GAUBh_ZMPeKhqxQXxau2OKCbt3p2QmsDhROf207dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/2/22 23:48, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 1, 2022 at 2:46 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>
>> Panels usually call drm_connector_set_panel_orientation(), which is
>> later than drm/kms driver calling drm_dev_register(). This leads to a
>> WARN()[1].
>>
>> The orientation property is known earlier. For example, some panels
>> parse the property through device tree during probe.
>>
>> The series add a panel API drm_panel_get_orientation() for drm/kms
>> drivers. The drivers can use the API to get panel's orientation, so they
>> can call drm_connector_set_panel_orientation() before drm_dev_register().
>>
>> Panel needs to implement .get_orientation callback to return the property.
>>
>> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220530081910.3947168-2-hsinyi@chromium.org/
>>
>> Hsin-Yi Wang (8):
>>   drm/panel: Add an API drm_panel_get_orientation() to return panel
>>     orientation
>>   drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
>>   drm/panel: panel-edp: Implement .get_orientation callback
>>   drm/panel: lvds: Implement .get_orientation callback
>>   drm/panel: panel-simple: Implement .get_orientation callback
>>   drm/panel: ili9881c: Implement .get_orientation callback
>>   drm/panel: elida-kd35t133: Implement .get_orientation callback
>>   drm/mediatek: Config orientation property if panel provides it
>>
>>  drivers/gpu/drm/drm_panel.c                    |  8 ++++++++
>>  drivers/gpu/drm/mediatek/mtk_dsi.c             | 10 ++++++++++
>>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c |  8 ++++++++
>>  drivers/gpu/drm/panel/panel-edp.c              |  8 ++++++++
>>  drivers/gpu/drm/panel/panel-elida-kd35t133.c   |  8 ++++++++
>>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c  |  8 ++++++++
>>  drivers/gpu/drm/panel/panel-lvds.c             |  8 ++++++++
>>  drivers/gpu/drm/panel/panel-simple.c           |  9 +++++++++
>>  include/drm/drm_panel.h                        | 10 ++++++++++
>>  9 files changed, 77 insertions(+)
> 
> Seems reasonable to me. I added a request to the panel-edp patch that
> probably applies to all of the panel patches requesting a comment next
> to the old calls in get_modes().
> 
> I assume that all but patch #8 ought to land through drm-misc. I'm
> happy to help commit them once everyone is happy. If the Mediatek
> maintainer(s) want to Ack patch #8 I can land that in drm-misc too. If
> we want something fancier like an immutable branch you'll probably
> have to get someone involved that's got a higher drm pay grade than
> me. ;-)

Thanks, patch 8/8 looks good to me now too, so:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Note I'm currently travelling so I cannot push this to drm-mic-next
myself.

Regards,

Hans


