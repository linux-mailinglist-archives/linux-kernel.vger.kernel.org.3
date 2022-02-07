Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20554ABE5F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380148AbiBGMDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 07:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391103AbiBGL6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:58:19 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7444C08E834
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:57:15 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k13so26303597lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 03:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qT4t7C5hlBWUS2Qpnn3V7J8roQL7i/m1ege9fv5/FIY=;
        b=IGC/NdZ5L8zpryzgat9+XnhIju/fpkAY1x6PdYhahuqGvTwQBI2y1U7P6JrD3NGUdu
         ZzYFXb9C9o9ETCpWn6K8MkOqIbEZSm5qyTyWN+MfniSdpmFKNXNY4I9UXSlpL7IW3RwP
         YqH/YkeJRAaEj9cG2upOozsT8gqhV7CwlDHvAE4GyLAvyzZ3O20kQmtBFJo8rcGNz4kQ
         mTD6G9PogIqDyjVRO5K6cL7NwCqAD/cI4SoR4htwwOiTrGnI+ZhmPgJoTlJkiNZ03dY9
         uznqOKX86lSw4kujlsFrj9OZSg6MkBSQZ2HDtJWxPUTCB9q6RmUrKJE+MmbGqjhsBpVv
         yglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qT4t7C5hlBWUS2Qpnn3V7J8roQL7i/m1ege9fv5/FIY=;
        b=3RTH300p1ft6pPR2duznOVwTbbYMzr2VJ15OpG1GpCcUCtToh+E7e02e6TAPUfqBz0
         bWA1UnyTwCKbOcXUu8oPS/KpCJQU26HUnMTlYVdmlCELTd0lMqxmCK6nAtgy3CHhadwc
         9rl0GudcP5OSbrRmlAMwCkbgaduu5y5mBZs2sXbB/eISt7F3zlVn0nhEuxIuRcbBIDgs
         jwsLV5EkK19nCooS0lcoM79/cRvqWq97CG2JhCnkLMrd/6/zJhdDDOq4qiGpq688nEN8
         789Csi0Nhy7LsunB/siPRrQbpbdiLbP3dvkzgEV1rs5BCLMMFo7ECNNt/zyYgnith6lc
         lwVw==
X-Gm-Message-State: AOAM530WQeTZfhSV5Ow/KouQ0c1DZPdWMZPgkcn1BY4d1EN3XAHtzU6y
        8hZ32kmNaF5gkrnzaUwVyvc=
X-Google-Smtp-Source: ABdhPJxN9dwKTdnsmwtngX/qp+mmD/PXm5D2zQAG1HohVxwrQ0CrlsDAYhtoniHUNGpiuZwoX+c+4A==
X-Received: by 2002:ac2:4c4b:: with SMTP id o11mr8200833lfk.253.1644235034111;
        Mon, 07 Feb 2022 03:57:14 -0800 (PST)
Received: from [10.10.10.122] (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id a16sm123991lfb.63.2022.02.07.03.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 03:57:13 -0800 (PST)
Message-ID: <5c916187-8a8c-323a-adb4-8bce141180cc@gmail.com>
Date:   Mon, 7 Feb 2022 06:57:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] i915/gvt: Introduce the mmio_table.c to support VFIO
 new mdev API
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
References: <20220127120508.11330-1-zhi.a.wang@intel.com>
 <20220207073247.GA24327@lst.de>
 <DM4PR11MB5549FE45F8098368114ADE75CA2C9@DM4PR11MB5549.namprd11.prod.outlook.com>
 <20220207083535.GA25345@lst.de> <877da7rlzr.fsf@intel.com>
From:   Zhi Wang <zhi.wang.linux@gmail.com>
In-Reply-To: <877da7rlzr.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 05:48, Jani Nikula wrote:

> On Mon, 07 Feb 2022, Christoph Hellwig <hch@lst.de> wrote:
>> On Mon, Feb 07, 2022 at 08:28:13AM +0000, Wang, Zhi A wrote:
>>> 1) About having the mmio_table.h, I would like to keep the stuff in a
>>> dedicated header as putting them in intel_gvt.h might needs i915 guys
>>> to maintain it.
>>> 2) The other one is about if we should move the mmio_table.c into
>>> i915 folder. I guess we need the some comments from Jani. In the
>>> current version that I am testing, it's still in GVT folder. Guess we
>>> can submit a patch to move it to i915 folder later if Jani is ok
>>> about that.
>> Yes, let's have Jani chime in on these.  They're basically one and the
>> same issue.  This code will have to be built into into the core i915
>> driver even with my planned split, which is kindof the point of this
>> exercise.  I think it makes sense to use the subdirectories as boundaries
>> for where the code ends up and not to declarare maintainership boundaries,
>> but it will be up to the i915 and gvt maintainers to decide that.
> Agreed. If there's going to be a gvt.ko, I think all of gvt/ should be
> part of that module, nothing more, nothing less.
>
> The gvt related files in i915/ should probably be named intel_gvt* or
> something, ditto for function naming, and we'll probably want patches
> touching them be Cc'd to intel-gfx list.
>
> Joonas, Rodrigo, Tvrtko, thoughts?
>
> BR,
> Jani.

Hi Christoph and Jani:

Thanks for the comments. It would be nice that people can achieve a 
agreement. I am OK with both of the options and also moving some files 
into different folders doesn't needs me to do the full test run again. :)


Thanks,

Zhi.

