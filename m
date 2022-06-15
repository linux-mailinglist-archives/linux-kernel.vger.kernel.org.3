Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9535A54CD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiFOPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiFOPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:47:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8DF220F9;
        Wed, 15 Jun 2022 08:47:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id be31so19567197lfb.10;
        Wed, 15 Jun 2022 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VTCGWujNv4+ZeNU9inSiK0tI+fyoxm0X3NKXlbOy8Y8=;
        b=GphwJd+LsGEWeN2UG4hGNyGvnzO74SuULFcCInrrgMlqBx8ENwGzXPt2mYReWKHevc
         0XbVfNJOky5MmRd3j4yfAIyRzYLYgHv7/n0cn0R+GFOpDUVDUC81hCn2m1oE1UxPUoWo
         +qgBpWgoy4aIdpBjLJl1r0T+ju62jYqHcOMRTctNqp2bWSn4QS6F2IVeElVNzK99mGrb
         WoIIyfTwWKcNpy2mXR+SKnP/cc6nh07OU48gAhRTmgRycemIPRHP9oukemCczQWi7JJt
         yTgLZ7YWzIi/Z/8M+yheAOjE60UQs2PPXenesWMsQyrdGX7sZMb2PDXbl3/Vz9sxlg/l
         vnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VTCGWujNv4+ZeNU9inSiK0tI+fyoxm0X3NKXlbOy8Y8=;
        b=DEBo60Z4mWTXRCwqSqA78/Xj2d0uFpLPkHmex1g0Uai12vfB5/QBKfoork7JAii79b
         wRZw9U62kNqEuzQwnZ+idOTEyIVSnCHp47uft7Y/DLTtEmnraN5Titdg6UCb3IgP9ck+
         Ox/K5QOT5XR+R02dK7sNbvGQ4WGoQ0TTEZwLkYKF/X0zG7K8l8rQYDpu5NDolQWPxA5o
         qFKgswOTHLspd5NhG+fR2L+hzav9mSVZHPtOS+WQ0rhQ/FofhFfyBxuFfPy22xwrFCDj
         x5HBRlN4mk3vmgX7mZOp8lySjMEL1OnkBbYUO3KBzejTrIu4oCM7G9ZWJG3UJNMBHcFJ
         RtYQ==
X-Gm-Message-State: AJIora+mgFLl9i7pS71BYyacZh6Mp6OMuk9r4mBVkCdMypVr/F563FFF
        L2i/oLrzldSrjTwmZq1yV6s=
X-Google-Smtp-Source: AGRyM1vcCVXtE8TdfCiHOURs9ffWBcnlUTL+yi36mILI8l9ZN3HWHOYcewv5RFV18a3Ky1FRl+oYTA==
X-Received: by 2002:a05:6512:39cb:b0:47d:a4c6:40eb with SMTP id k11-20020a05651239cb00b0047da4c640ebmr62321lfu.597.1655308076206;
        Wed, 15 Jun 2022 08:47:56 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id s15-20020a2e150f000000b0025567cf8633sm1710514ljd.85.2022.06.15.08.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 08:47:55 -0700 (PDT)
Subject: Re: [PATCH] xen: don't require virtio with grants for non-PV guests
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20220615084835.27113-1-jgross@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <6f5b1562-1270-5e83-bf9f-a9a7afc5a725@gmail.com>
Date:   Wed, 15 Jun 2022 18:47:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220615084835.27113-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.06.22 11:48, Juergen Gross wrote:

Hello Juergen

> Commit fa1f57421e0b ("xen/virtio: Enable restricted memory access using
> Xen grant mappings") introduced a new requirement for using virtio
> devices: the backend now needs to support the VIRTIO_F_ACCESS_PLATFORM
> feature.
>
> This is an undue requirement for non-PV guests, as those can be operated
> with existing backends without any problem, as long as those backends
> are running in dom0.
>
> Per default allow virtio devices without grant support for non-PV
> guests.
>
> The setting can be overridden by using the new "xen_virtio_grant"
> command line parameter.
>
> Add a new config item to always force use of grants for virtio.
>
> Fixes: fa1f57421e0b ("xen/virtio: Enable restricted memory access using Xen grant mappings")
> Signed-off-by: Juergen Gross <jgross@suse.com>

Thank you for the fix.


I have tested it on Arm64 guest (XEN_HVM_DOMAIN), it works.

With the "__init" fix (pointed out by Viresh) applied you can add my:

Tested-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com> #Arm64 only


[snip]


-- 
Regards,

Oleksandr Tyshchenko

