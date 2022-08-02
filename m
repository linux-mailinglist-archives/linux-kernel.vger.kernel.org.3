Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF35D587623
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 06:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiHBECh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 00:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiHBECf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 00:02:35 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B415017ABE;
        Mon,  1 Aug 2022 21:02:34 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id h28so6079702pfq.11;
        Mon, 01 Aug 2022 21:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fkUbTgCAMzwmn1NpRQ27lVlofre2gcYc5vaC+Wjw+Ck=;
        b=lLyGl8SHN2oz4EGFb8TQqFhDBNNtttoGBJXGXZcScWnmKYVOj9iAlthUm651dL3WYC
         LTRz9Omi7U8f1AjOL6Q3O3HZvECQkSj2B3gHYEEjYX34jaI0smiB0agkzAXbTOyMtcEg
         Xtm6ed0CCOrbls2Ul7vgYKIsh3E5Bb/9FHGllwdEykDj73VO9EdqjzJiYQ+mLUhwTHcT
         T61B0dFKxCwVXicQwZv0aDwSmXuRs2UP3FcG7NXawP4btLpCm7/f9Kx9Sr+THS2/BMCk
         32z+vkOeUxt0dRiN46uRD+ug8xTjk5TqNB2o/ilYbNgyGb/2CtX0etQIMEzCqEm9M8ch
         Nmvg==
X-Gm-Message-State: AJIora8N4cdZqgIGrK5Ur39YJoKX1aubXooo2fsyRb7+jZV8owkEiGPT
        oyT8kJ4Zrl/2/evYUZ/YW3Q=
X-Google-Smtp-Source: AGRyM1t081JkrfWiz5cAE2T8zXiD6TQMmIk8UQcuACHdpa2XUYFU1mhws7KhKOI83wk1TGMcNnsv/g==
X-Received: by 2002:a05:6a00:198f:b0:52a:dc25:cc78 with SMTP id d15-20020a056a00198f00b0052adc25cc78mr18944092pfl.20.1659412954129;
        Mon, 01 Aug 2022 21:02:34 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0016d2540c098sm10380923pll.231.2022.08.01.21.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 21:02:33 -0700 (PDT)
Message-ID: <d06d9625-8ef9-f385-a9c9-75c306a959ed@acm.org>
Date:   Mon, 1 Aug 2022 21:02:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220802103643.v5.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <c4acb34f-7bba-336f-ddfc-a9c098f2c95f@acm.org>
 <CAONX=-cAW5UX__xu5y7NdtHkZq-YWmh_k=iFa5witdxw3xXkYA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAONX=-cAW5UX__xu5y7NdtHkZq-YWmh_k=iFa5witdxw3xXkYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 20:20, Daniil Lunev wrote:
>> Is the "capabilities" directory a directory with capabilities of the
>> host, with capabilities of the UFS device or perhaps with capabilities
>> of both?
 >
> I would say effective capabilities of the controller-device pair, from the
> semantic that hba->caps field presents. Do you want me to mention it
> anywhere?

Calling this the effective capabilities of the controller-device pair 
sounds good to me. But please do not refer to hba->caps. I'd like to 
rework hba->caps such that it only includes controller capabilities and 
no information related to the WriteBooster. Additionally, several UFS 
device capabilities that may be exported in the future are not 
represented in hba->caps.

Thanks,

Bart.
