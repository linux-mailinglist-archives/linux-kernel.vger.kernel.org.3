Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29D1595A41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiHPLe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiHPLdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:33:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358B4F3B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:55:43 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v10so10121607ljh.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CBKTj5rqOn3nvVZvcReemvDBMrFOZ0r/iVEgRvVlj7w=;
        b=Svwnc6Ps2mgT9rljkrmJhSM3ngCsPTTHBKJzpTazCrTqpdidG8FwIHPuGIgyAoVs8a
         HQf+fS7Z8nY+INAGOTIma8iZTmjlJQI6M1kimeObK88koD6bClhAhI3AA+jdy7lAUVjG
         /UzHgVuP1lc+egFn6Tj6VjKaIDM85G1ccfHfakvvt7QDc20ARPnoV91A8nTk8SlcKdvY
         q+1uL/sXiTezwoEdVtr3ENmibRF/kVtU5AHCoz5bvmo2xDCz4H3WhJKBOvFhwIoRt/L9
         ewgVblpBi4+u/eSvyR0Mf1rDOoUV8sYQQfyh00MJD3Ps1jU/IwqksR70UzMOkYqSWLzA
         FoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CBKTj5rqOn3nvVZvcReemvDBMrFOZ0r/iVEgRvVlj7w=;
        b=XZyEUnZhkfBuH6ayPN/D4LZoZxb4Uec2GhNz1HzTwnJejtzVnRIu/Vi6GhOA3cIBPT
         8iKpdZD4mHvdxWLyalqPNgT2mYd/t9LiOk0Rr8f1T5a4XynOUSPJ3AB4k+wvAfXcLct8
         zpt4RwkHVRP6TxT9BkhB7+k2XQVADVRGWgnQsZsSPc3ahZa1WpypAhKyingZmJKdzJnL
         HobmFoNmL5p8CXO9BG2iqYsthbDfCRINJFmXR1ZFn33tFzi+MpbF5PgMGnjPZE9AfNp9
         fMF4q6BVzbEe/IwO3eSwxJX+NXQRvbNZ78sRp2X0sfZKY6YxEDYOeJBXqYm+XOZ1K+DT
         Ws4A==
X-Gm-Message-State: ACgBeo0q+dNvX2antZ2QL7ExeNdEDTkOqzy419roUbtRFSEJlSS4nHdY
        uvO6rvoUJ+Lxzrxou7SQ45pc3g==
X-Google-Smtp-Source: AA6agR7vC+j/ek79i+GD6KzISBYbeOBbqXj7aSllLfYBky7D81Wi0pnmae4dvqzohY1PwIPgyMwKyA==
X-Received: by 2002:a2e:a410:0:b0:25e:4bca:6287 with SMTP id p16-20020a2ea410000000b0025e4bca6287mr6589533ljn.31.1660647341625;
        Tue, 16 Aug 2022 03:55:41 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id s27-20020a056512203b00b0048b4690c78esm1345283lfs.288.2022.08.16.03.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:55:40 -0700 (PDT)
Message-ID: <a9c71f3b-0c7b-ee8f-d350-0ab453018558@linaro.org>
Date:   Tue, 16 Aug 2022 13:55:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 01/14] drm/qaic: Add documentation for AIC100
 accelerator driver
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, airlied@linux.ie,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de
Cc:     quic_carlv@quicinc.com, quic_ajitpals@quicinc.com,
        quic_pkanojiy@quicinc.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1660588956-24027-1-git-send-email-quic_jhugo@quicinc.com>
 <1660588956-24027-2-git-send-email-quic_jhugo@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1660588956-24027-2-git-send-email-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 21:42, Jeffrey Hugo wrote:
> Add documentation covering both the QAIC driver, and the device that it
> drives.

Thank you for your patch. There is something to discuss/improve.


> 
> Change-Id: Iee519cc0a276249c4e8684507d27ae2c33e29aeb

You need to drop all such non-standard tags. Please run
scripts/checkpatch and fix all the warnings.

Best regards,
Krzysztof
