Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C341C4F4429
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiDEMzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343838AbiDEJOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA145473AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649149248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSO/TqrwqUyxFxKxwKZYjfIE5/lfFHPLnUnqeq3HIT8=;
        b=IPdPmOQMSEE1XF/C3s3rhtmpiYidgc0eHtQ79DLqtbpk6mmdupX7rgfvsDe7DtZtinAznt
        mPi3/KHQJmXsXwsqiA+Qr6bN8HitF/QH1GI5K3unwMjv0wR3x66P4Kw8ZzS/Q25CRhqNwZ
        PLloOe8O6unm8jHKsK9l1lyhiafqOSQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-F0vFPdh9NFuvtGeoPCMVHQ-1; Tue, 05 Apr 2022 05:00:47 -0400
X-MC-Unique: F0vFPdh9NFuvtGeoPCMVHQ-1
Received: by mail-ej1-f69.google.com with SMTP id qb5-20020a1709077e8500b006e7f59d3cc0so2514943ejc.15
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HSO/TqrwqUyxFxKxwKZYjfIE5/lfFHPLnUnqeq3HIT8=;
        b=FoSVJNI4tf/KLLxHthH4C+9ykWx4IyqL7txeSa5R8rvSenZ9Pn3Bs2+/bxLHohJGjJ
         RswTcef8gKXMXRLOv2zlADJ6YqWnB3fp8TqfqPkOhwbSGUAYSPoin9WZFqjdscueXmjP
         yfwpMi9ma5krbqhdfWvyWnhRP2gsUUSeZcjHaL7Qd0TEx4RkSzAjQyGeJ0+ZyBfpn2Sw
         20ibPh3lSXajZg4s/S4RuAvRlb//iOa3AC25weIpPpr1ANTMr9Fs2PA5Pj4R9/BMSiuQ
         WZQ8hhiDc0p5RTFlip+GVBNkGgXJAQmZ5uvFmbdqcOgpFkw9zu5ddTBJLKlYg1IsNFDI
         1Dag==
X-Gm-Message-State: AOAM533zHOxEETzbVIkuFjESn2UR8NVw7Jmhbyv0iQIe4rw/eRINXJF5
        t7EAbUXDlH5c7pNbuMaWr2JeCIsQkWk/gqn2fRHX3pOVOJNOdKxHdyxEfdToZAoANqUSL+Th9CZ
        k37f4Kx2olxjMjePUoxM1xgNs
X-Received: by 2002:aa7:c946:0:b0:416:226f:f8a6 with SMTP id h6-20020aa7c946000000b00416226ff8a6mr2429358edt.360.1649149245923;
        Tue, 05 Apr 2022 02:00:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoDqgawidQhMilYXxAI8B1jQnINDAvkJZhtA332a2gcFfHYdlmk8fXP+9rXPGfmSTwJsmNSQ==
X-Received: by 2002:aa7:c946:0:b0:416:226f:f8a6 with SMTP id h6-20020aa7c946000000b00416226ff8a6mr2429335edt.360.1649149245754;
        Tue, 05 Apr 2022 02:00:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id gn33-20020a1709070d2100b006dfcce8be86sm5235523ejc.225.2022.04.05.02.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 02:00:45 -0700 (PDT)
Message-ID: <168fe6c3-6a7d-4019-16e3-066caf394b8a@redhat.com>
Date:   Tue, 5 Apr 2022 11:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] Make headphone work on Huawei Matebook D15
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <cover.1649147890.git.mchehab@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cover.1649147890.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 4/5/22 10:44, Mauro Carvalho Chehab wrote:
> At Huawei Matebook D15 two different GPIOs are used to control the output:
> 	- gpio0 controls the speaker output;
> 	- gpio1 controls the headphone output.
> 
> Changing both at the same time cause spurious events that are mis-interpreted
> as input events, causing troubles on apps. So, a delay is needed before turning
> on such gpios.
> 
> With this patch, plugging a headphone causes a jack event to trigger the speaker
> supply, powering down the speaker and powering up the headphone output.
> Removing the headphone also triggers the power supply, powering up the speaker
> and powering down the headphone.
> 
> Mauro Carvalho Chehab (2):
>   ASoC: Intel: sof_es8336: support a separate gpio to control headphone
>   ASoC: Intel: sof_es8336: Huawei Matebook D15 uses a headphone gpio

There is something weird with the patches here, at least for me in Thunderbird
both patches show up as nameless attachments to emails with empty bodies.

After saving the attachments the patches look good to me, so:

Acked-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

