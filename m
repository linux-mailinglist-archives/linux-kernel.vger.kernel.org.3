Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74F6516E6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384703AbiEBKxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384674AbiEBKxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC674DFDE
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651488597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TKyHWDgC93OfXdwv3f/QQ+fWpsgCb5Bjp407TIVwrw=;
        b=W9aUkE1bnSxtGZDw6EH4QhshhIoxLy409jEaJmvf3QAeh5yIz3t6/ttF7ZT4jDEoOVHYVV
        F0UEm+bsoseXG7XhR9fEfgRUggywwGNJwaPuwfaveQ4oQ57lnGOd4+y7JrNtXzfVbBzrvY
        GybOlNCAWpcfYtoU1YBpnJkuPxU/VbM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-UantdxQdPSqzKNgycDEOWQ-1; Mon, 02 May 2022 06:49:56 -0400
X-MC-Unique: UantdxQdPSqzKNgycDEOWQ-1
Received: by mail-wr1-f69.google.com with SMTP id l7-20020adfbd87000000b0020ac0a4d23dso5204732wrh.17
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 03:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3TKyHWDgC93OfXdwv3f/QQ+fWpsgCb5Bjp407TIVwrw=;
        b=I9s2CoROrn4AymC4w8iDMjTd+jVauzYl/o21aCi1gVgjuEp5abwyKsWhWBMt8xCOit
         ZN8aey6FiHOwZ4whJN5NcYxqPM0uRHJFQbFDwyuAYcS8vJ+aXEBIRn2Pd3IqyKZ7LDDw
         YftFnj5ZlFl9mx2rmvE4OkSzrXvWnZt/eHtLt07Fk/cvaOkqzvTYzBDnenidX9iRAfz+
         bpxp0CZfTuKII8aA14BgtBFpFYznGgOdahAzeZyPy21C2brO0ejPreeRaEYvRQ4qUiet
         OMLWeDmLZRiX9REpCJ1960srkdL1fKeW6WbeV1KvvsJuQaC7RwQoJd26JBfurQIBYxBw
         RQgQ==
X-Gm-Message-State: AOAM532sRsbenU3/Bg+i3mdErmbvC3rlhcrOg9gFLID3lGQxcFSYDpkO
        RzYmS3Pgy9AJb7BwDz2CH6mUbbyuH3N8vpUd81lQ5mLQAZdUhX/029jIobbtTYujRpplEi9pdDW
        6Svr88KngXUsQ7IgfmOpcf741
X-Received: by 2002:a5d:5051:0:b0:20a:e005:cca3 with SMTP id h17-20020a5d5051000000b0020ae005cca3mr8676742wrt.560.1651488595399;
        Mon, 02 May 2022 03:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznK7MTrWwTm+wtuLbm1AtWbuZrM/hnsYDFHNU2iLGSqHpPTjz/i73gvAXGyZ+XCXckc/fOrQ==
X-Received: by 2002:a5d:5051:0:b0:20a:e005:cca3 with SMTP id h17-20020a5d5051000000b0020ae005cca3mr8676723wrt.560.1651488595161;
        Mon, 02 May 2022 03:49:55 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w7-20020adf8bc7000000b0020c5253d8f9sm6707583wra.69.2022.05.02.03.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 03:49:54 -0700 (PDT)
Message-ID: <1d2a03f7-d4f6-66ac-6e2e-adbd2eaf7d90@redhat.com>
Date:   Mon, 2 May 2022 12:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Emma Anholt <emma@anholt.net>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@linux.ie>,
        spice-devel@lists.freedesktop.org,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jerome Brunet <jbrunet@baylibre.com>,
        Marek Vasut <marex@denx.de>, Hao Fang <fanghao11@huawei.com>,
        linux-aspeed@lists.ozlabs.org,
        Samuel Holland <samuel@sholland.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Joel Stanley <joel@jms.id.au>,
        Dave Airlie <airlied@redhat.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        virtualization@lists.linux-foundation.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alison Wang <alison.wang@nxp.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-mips@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Alain Volmat <alain.volmat@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-amlogic@lists.infradead.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Yong Wu <yong.wu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        amd-gfx@lists.freedesktop.org, Tomi Valkeinen <tomba@kernel.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-renesas-soc@vger.kernel.org,
        Solomon Chiu <solomon.chiu@amd.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20220502084830.285639-1-javierm@redhat.com>
 <c120e1c4-ac5c-afd5-8dd1-b4b51e0dcca9@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c120e1c4-ac5c-afd5-8dd1-b4b51e0dcca9@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/2/22 12:35, Thomas Zimmermann wrote:
> Hi Javier
> 
> Am 02.05.22 um 10:48 schrieb Javier Martinez Canillas:
>> Hello,
>>
>> This series contain patches suggested by Thomas Zimmermannas a feedback for

Ups, I missed a space here. I meant to write "Zimmermann as a feedback..."

>> "[RFC PATCH v4 00/11] Fix some race between sysfb device registration and
>> drivers probe" [0].
>>
>> Since other changes in [0] were more controversial, I decided to just split
>> this part in a new patch-set and revisit the rest of the patches later.
>>
>> Patch #1 is just a cleanup since when working on this noticed that some DRM
>> drivers were passing as preferred bits per pixel to drm_fbdev_generic_setup()
>> the value that is the default anyways.
>>
>> Patch #2 renames the 'preferred_bpp' drm_fbdev_generic_setup() parameter to
>> 'options', and make this a multi field parameter so that it can be extended
>> later to pass other options as well.
>>
>> Patch #3 finally adds the new DRM_FB_FW option and makes simpledrm to use it
>> so that the registered framebuffer device is also marked as firmware provided.
> 
> For the whole patchset:
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Thanks a lot!
> 

Thanks for the prompt review!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

