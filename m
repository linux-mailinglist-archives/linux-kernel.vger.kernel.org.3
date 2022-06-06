Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13A353EF61
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiFFUQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiFFUQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5867D541BA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654546533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=soh7nshOOI4K9myM3ozv4aem+NBtc61+4Mxmv3KYpHg=;
        b=Fdye2etgum73NkZQqgr5gw6IdIcHcIxVBNaDYnVoqs6lNhkHhEzf1B31y29JEmNbrVVx+I
        PN0VbKLw7WwGWX8wiTMIh2RSOfrl9AO5DKIvNbM/BjXmDjPGkDICqTI2UdnVfxGnPZBpix
        ZKztwLH0hcKosrqscJwbYsmXutykNfY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-MNpj8fXpOJuAJDHhMdA39g-1; Mon, 06 Jun 2022 16:15:32 -0400
X-MC-Unique: MNpj8fXpOJuAJDHhMdA39g-1
Received: by mail-ej1-f69.google.com with SMTP id p7-20020a170906614700b006f87f866117so6651783ejl.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=soh7nshOOI4K9myM3ozv4aem+NBtc61+4Mxmv3KYpHg=;
        b=OQnpWpW7Rd5Qhi6uhdiaL68w9r0H6cOGmuB55ao7N+K8qiOhDQ4IksqJgyV366m/o7
         MUV/xZjSJj+sJFq6MbUNL9MKQtPaxVMYN8HcjGizX5IgaGdKAMH1P9VL3i7sOrUeUi/D
         JtrT7tLvvaZSaNV+fIg59hEoPM7cvumCZYkNWGnHFSReKuZnPFtyTZNDuzqFkkw5qna/
         vjvcZQTwt/lZ+q8prmBhKL3uTGHPyItB2QtGc9C7t3I6rDS2uSVCdSikPIH1HbtfQA8q
         TgjjBwORUNHcg6ZtTB5Z3XW4FZP1R26PoXCxH4sjfIK2kpsB4TWW+8n7tTn1WMjc2C7E
         NycA==
X-Gm-Message-State: AOAM530JzERKHQJeEUsUNKMSM63kNTCW8i74cJe9fTTL12EkzzP5/mb1
        JrXSmsrvVx60BWHNKzmoWaJ7HEjRaJDNfPVgoTJqpwmNFSEMi8pwqGfUlMYexcqsptMDaZXgJ0t
        mS0nxyeM26YrL0AnHRSxnb6IF
X-Received: by 2002:a17:906:ce36:b0:711:d032:e99 with SMTP id sd22-20020a170906ce3600b00711d0320e99mr6336289ejb.242.1654546531193;
        Mon, 06 Jun 2022 13:15:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+R5Eu8yIp0AZcVOEeq1aIzb0Cegxw60TVcu2tMOPSlvbkiSDO4mWQNQcrPYsa2c7zj6yzdQ==
X-Received: by 2002:a17:906:ce36:b0:711:d032:e99 with SMTP id sd22-20020a170906ce3600b00711d0320e99mr6336261ejb.242.1654546530939;
        Mon, 06 Jun 2022 13:15:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906139900b006fe8c831632sm6615148ejc.73.2022.06.06.13.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 13:15:30 -0700 (PDT)
Message-ID: <1c6e4d09-cf7a-2812-fd0d-09a21a275201@redhat.com>
Date:   Mon, 6 Jun 2022 22:15:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/8] drm/panel: Add an API drm_panel_get_orientation()
 to return panel orientation
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>, Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220606152431.1889185-1-hsinyi@chromium.org>
 <20220606152431.1889185-2-hsinyi@chromium.org>
 <Yp5Ti3ov/fnw0xeQ@ravnborg.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yp5Ti3ov/fnw0xeQ@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/6/22 21:20, Sam Ravnborg wrote:
> Hi Hsin-Yi,
> On Mon, Jun 06, 2022 at 11:24:24PM +0800, Hsin-Yi Wang wrote:
>> Panels usually call drm_connector_set_panel_orientation(), which is
>> later than drm/kms driver calling drm_dev_register(). This leads to a
>> WARN().
>>
>> The orientation property is known earlier. For example, some panels
>> parse the property through device tree during probe.
>>
>> Add an API to return the property from panel to drm/kms driver, so the
>> drivers are able to call drm_connector_set_panel_orientation() before
>> drm_dev_register().
>>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> ---
>> v3->v4: Add a blank line.
>> ---
>>  drivers/gpu/drm/drm_panel.c |  9 +++++++++
>>  include/drm/drm_panel.h     | 10 ++++++++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
>> index f634371c717a..e12056cfeca8 100644
>> --- a/drivers/gpu/drm/drm_panel.c
>> +++ b/drivers/gpu/drm/drm_panel.c
>> @@ -223,6 +223,15 @@ int drm_panel_get_modes(struct drm_panel *panel,
>>  }
>>  EXPORT_SYMBOL(drm_panel_get_modes);
>>  
>> +enum drm_panel_orientation drm_panel_get_orientation(struct drm_panel *panel)
> const as mentioned by Stephen.
> 
>> +{
>> +	if (panel && panel->funcs && panel->funcs->get_orientation)
>> +		return panel->funcs->get_orientation(panel);
>> +
>> +	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
>> +}
>> +EXPORT_SYMBOL(drm_panel_get_orientation);
>> +
>>  #ifdef CONFIG_OF
>>  /**
>>   * of_drm_find_panel - look up a panel using a device tree node
>> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
>> index d279ee455f01..5dadbf3b0370 100644
>> --- a/include/drm/drm_panel.h
>> +++ b/include/drm/drm_panel.h
>> @@ -133,6 +133,15 @@ struct drm_panel_funcs {
>>  	 * Allows panels to create panels-specific debugfs files.
>>  	 */
>>  	void (*debugfs_init)(struct drm_panel *panel, struct dentry *root);
>> +
>> +	/**
>> +	 * @get_orientation:
>> +	 *
>> +	 * Return the panel orientation set by device tree or EDID.
>> +	 *
>> +	 * This function is optional.
>> +	 */
>> +	enum drm_panel_orientation (*get_orientation)(struct drm_panel *panel);
> 
> Please move this up so it is together with the other get_* methods, in
> alphabetic order. That is, right after get_modes(), and then this also
> matches the order in the .c file with is extra bonus.

The downside of moving this up is that it will break drivers which don't
use c99 style named-struct-field initializers for there drm_panel_funcs.

I admit that no drivers should be using the old style struct init, but
are we sure that that is the case?

Regards,

Hans



> 
> With the two fixes:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
>>  };
>>  
>>  /**
>> @@ -202,6 +211,7 @@ int drm_panel_enable(struct drm_panel *panel);
>>  int drm_panel_disable(struct drm_panel *panel);
>>  
>>  int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
>> +enum drm_panel_orientation drm_panel_get_orientation(struct drm_panel *panel);
>>  
>>  #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
>>  struct drm_panel *of_drm_find_panel(const struct device_node *np);
>> -- 
>> 2.36.1.255.ge46751e96f-goog
> 

