Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2094ED944
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiCaMIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiCaMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:07:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBFE4C7BD
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:06:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so3061611pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=DoQMAhg57Iwj9QRLPIfyxqxqUJPiT17ubOe/gs+XAyZorZBgE6leFUgTZY1kyFbsTn
         vsI7URqxcYEC2pxDtzFp/xu8gnje/C+xIMYHgUo5BvTqB+KcFYvfLs8OmrirjBKLQt0J
         e5ZA0iwW6WMNHEUEkoYbdcr09BGN598PeGRsCTKTj4vHxoc9UozywtmoyigPwc9o1o/6
         QDU9cszOIp+1zbKzqdjjcc7PWB2G1IXRxtFFtNYo4TSeRBXgCHuyy1JXBxUm85RYhUqs
         Vlge+Fp4svEszf6YshAD1fz3kzfZMND7CmED7zfG5SMGKt1Yyqlyfu1DlWQJNdsGn0/9
         cEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=Lq6FLm+gq5oFx9j9V6CbMZ/2tSrww2YvA68CtgoVwlXqrvxCnqksLnTMz1akJOXIz6
         Mg+60T6C/adYUteVRTlQzAT73TgheeCG+bdM9OJJ7fCsc4VG5hlAky7ko/q0RGmV2o0U
         mlNekIqAeCBGvMbNYUTa33vr/NdRDAF2ATpd8Uz/vlKQ28nHQIXBYYgssOlVXxH4Az3s
         YRa8sJ2Zx4hzXzVsg9s9virJaFko8FEqKTQyFjR0cOythHGBUVDRqbymdIJV72upOu9O
         5MUPnNSrhkWrdkSzSHLoHPiuIrjflv5N0amcdEdVjMu9g+2TzGPc+zs0natc5hKcdqkf
         S1Ag==
X-Gm-Message-State: AOAM531tSztlMqkqjdQ0tng5XU2Rw17YL9x2BxioLWXImhJWxk1dogUR
        du/NyPUriVVYUEy/ndNqo/hugvAbhMJFVwN5eapmIXHS5qY=
X-Google-Smtp-Source: ABdhPJzD49qf/qeIM51tj5LJjmvgLfNLnPUv9s4oXejQybKHNZ6BEL4/Ymi9fAnBSZGKhRRHEIoCf/0RqyuSYv4/0n4=
X-Received: by 2002:a17:903:30c4:b0:153:c102:8b9a with SMTP id
 s4-20020a17090330c400b00153c1028b9amr40894149plc.21.1648728362182; Thu, 31
 Mar 2022 05:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220326073326.3389347-1-yangyingliang@huawei.com> <CAJMQK-hA+k8hsQiBq7v9QROQyDkrzy+J40b2uF4AcmrXDe0gKw@mail.gmail.com>
In-Reply-To: <CAJMQK-hA+k8hsQiBq7v9QROQyDkrzy+J40b2uF4AcmrXDe0gKw@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 31 Mar 2022 14:05:51 +0200
Message-ID: <CAG3jFyub2VsKDsiP0gXwEhxSZFrVRjzvuQ_Cb_DcM+YEvm=T7g@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: add missing destroy_workqueue() in anx7625_i2c_probe()
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        xji@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.
