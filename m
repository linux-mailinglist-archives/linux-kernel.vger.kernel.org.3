Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297F24F515C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1845990AbiDFCCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457431AbiDEQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7AC33EB0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:44:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r10so9681526eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dxEc7R5XnKytFTC0Sj3LjjZYwPlZmbIGr7vPmj4puUA=;
        b=Q0IbgbasFTmTNOLmnCNFSpr1oPbUaD14NmLEU3U5xwG5VU8cQcdy6Cn42fOeQ7shqX
         8CRUrWu+vD5GQPJm6dma7GZsUsU2g9EuSOOsCzhRkOY8GxL2Z+wazjczaQtguPHjOmaR
         nnVqLF7VkO8Tb83Zv6I0kIym4Zqw50b/ycTVpZ6jVxvcyGaV60nZTqzSFJAYmaU6rncc
         7g4np5uhS2mFFHSsWZ3MfbBpjHb+iyj+qSyHHYr8Ikks/xucvOak/U7UARdLL3B6oUur
         j+4w44+UaOWkixltC2x1pOUdBo4qITZ25DOn+GlUk8SrCBboWGD29xfm4m3Ngf/UtVVf
         Dkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dxEc7R5XnKytFTC0Sj3LjjZYwPlZmbIGr7vPmj4puUA=;
        b=Rwb09bToNzKYLRQR9BubjCDMfmEyJGIf0HbqqrnkShJOmqR+TJJMoieST8x0eH0aEK
         Sf3CuM0QvHq/pWV1VKbmPN9VOmGr3Ra247iRWtCZOIHBrJ+cJHU386cK6Ksn8RWDDZPU
         cGz6bZV2+EPqXn1/b/4gfKYiZcf+YgHm/vuTGBD2L1gYcyd/WUeF1xKXnnoMYud3fMtx
         tX0R0ydcP29AtgVIJgJWDwlBKMG/bGl6vTLbYpoP9owOBph4AYfCCqBrQdDXEcUzcTFM
         mxJ7aJMHZAxE4zejh0dtdB+sbAqfFYeNN6AuZl605k4NlRux/Rubmi6eP0mCv1phtbb7
         kMUw==
X-Gm-Message-State: AOAM532rmR6/jBZh9UTeGRYeGrfrWP5j5eYovTCBv1aERbEe9/SDjgHu
        6N0tPISLYiwbGOET4+686BFpwLMMG9/fVg==
X-Google-Smtp-Source: ABdhPJwzc/Q9JzM7RKDnTzgdzPcQbeuUynJbqiZkWcvStWBRTF8AgNp31UgYoMP04/yq4uNSryEQPw==
X-Received: by 2002:aa7:d398:0:b0:419:d011:fe8b with SMTP id x24-20020aa7d398000000b00419d011fe8bmr4299476edq.168.1649173466636;
        Tue, 05 Apr 2022 08:44:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id og13-20020a1709071dcd00b006e7fdf0a687sm1753354ejc.76.2022.04.05.08.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:44:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id EFB8E1FFB7;
        Tue,  5 Apr 2022 16:44:24 +0100 (BST)
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <8b3ce88f65fd11523a4d2daab3c617f7089eb1ce.camel@gmail.com>
User-agent: mu4e 1.7.12; emacs 28.1.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     linux-kernel@vger.kernel.org, maxim.uvarov@linaro.org,
        joakim.bech@linaro.org, ulf.hansson@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Date:   Tue, 05 Apr 2022 16:43:03 +0100
In-reply-to: <8b3ce88f65fd11523a4d2daab3c617f7089eb1ce.camel@gmail.com>
Message-ID: <87r16bk013.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bean Huo <huobean@gmail.com> writes:

> Hi Alex,
>
> Thanks for this unified RPMB interface, I wanted to verify this on our
> UFS, it seems you didn't add the UFS access interface in this version=20
> from your userspace tools, right?

No I didn't but it should be easy enough to add some function pointer
redirection everywhere one of the op_* functions calls a vrpmb_*
function. Do you already have a UFS RPMB device driver?

--=20
Alex Benn=C3=A9e
