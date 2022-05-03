Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63FD518BAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbiECSB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbiECSBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:01:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335C63E5CB
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:58:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so1838260wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dOYR8QjdZgATKA6UBwH/KUtW42G01p9yge1qLJhO4VA=;
        b=2G4ca3indE4WVUVZdzi1VwxN9ZXpEdj5iSjR/bW/Dk3GfDHM6VgMlBgr+bujomwANF
         kaKEfiYYAdltxC4uzNsDflai41bm6ZSPjKfHsDRKMWJP/Ojc+g+rKwKOApmxcPaoaEBj
         inBaFX4IGDZUoBbPy586HuAusgYgd2YX+gilB2uEqqt9CXWegaQYPexUVpCXTP7BPPFW
         glYqlwpXQ3Q1IzV2JPZFOUT2M9morEg49dRWcHLmXrzx9QP+kqLqJwSZNBgAk/ezbIfk
         rJGb3h8GNM3oQBEampVRVimcWQ+a8WzM/PTU5eR0zIVm03JCPkuwoSjLB1XKF7LoIzKv
         YRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dOYR8QjdZgATKA6UBwH/KUtW42G01p9yge1qLJhO4VA=;
        b=gepy4wEwaQOei3exUhNnGOC7VqCZwbLlrTWZwz6jWX48Tqlye4vTGyvC0aS7rEq02/
         Acjo7jHgcicSXffc8JjXukKrsh6+o+SLIp18fdjStx3k5wu41R4UW+ONgoMdKA4JsGMz
         ZjLtyNTJezZ2kyEN1pia6kYPzcoz43IkNwmZD7735MH4Swdhxp7NLv3IMdL4rZlJcl5f
         9quIWS6oyQphFdnqTN9qOb10xPBoVLpU2ncUQs1EL/hDiVZY1RQfCjrhgjRURur1EBHe
         IPqWIVi99ZPqWTWB0ciMQxGi6MqAwi+QwI8/Of/CWIr34klJUlOcp6bOWZujqi8R0qBZ
         hT/g==
X-Gm-Message-State: AOAM533aGcuYvfFv/TM9Mf0GvltHpmrO9bXnWofxNhOa3qtxdhuj14q8
        JQSqZaSctb83oZinzJIX/1F6jf9KRiQsE7i2EsGD
X-Google-Smtp-Source: ABdhPJwE/egX1BtaNhyp1zi5fvfjg5Q6CYvdmpsadJqS5649ep2o3+2q0v7+JSpbmZLPSy+ow9mN23UBI9y9YrgvbkU=
X-Received: by 2002:a7b:cf02:0:b0:393:fbb0:7189 with SMTP id
 l2-20020a7bcf02000000b00393fbb07189mr4247165wmg.197.1651600700690; Tue, 03
 May 2022 10:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220502004952.3970800-1-tweek@google.com>
In-Reply-To: <20220502004952.3970800-1-tweek@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 13:58:09 -0400
Message-ID: <CAHC9VhQJ1xH4iwSXFdQnCobJMv5Kniam3XWG8-UL=VcmdFwEcg@mail.gmail.com>
Subject: Re: [PATCH v4] firmware_loader: use kernel credentials when reading firmware
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        John Stultz <jstultz@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 1, 2022 at 8:50 PM Thi=C3=A9baud Weksteen <tweek@google.com> wr=
ote:
>
> Device drivers may decide to not load firmware when probed to avoid
> slowing down the boot process should the firmware filesystem not be
> available yet. In this case, the firmware loading request may be done
> when a device file associated with the driver is first accessed. The
> credentials of the userspace process accessing the device file may be
> used to validate access to the firmware files requested by the driver.
> Ensure that the kernel assumes the responsibility of reading the
> firmware.
>
> This was observed on Android for a graphic driver loading their firmware
> when the device file (e.g. /dev/mali0) was first opened by userspace
> (i.e. surfaceflinger). The security context of surfaceflinger was used
> to validate the access to the firmware file (e.g.
> /vendor/firmware/mali.bin).
>
> Previously, Android configurations were not setting up the
> firmware_class.path command line argument and were relying on the
> userspace fallback mechanism. In this case, the security context of the
> userspace daemon (i.e. ueventd) was consistently used to read firmware
> files. More Android devices are now found to set firmware_class.path
> which gives the kernel the opportunity to read the firmware directly
> (via kernel_read_file_from_path_initns). In this scenario, the current
> process credentials were used, even if unrelated to the loading of the
> firmware file.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Cc: <stable@vger.kernel.org> # 5.10
> ---
> v4: Add stable to Cc
> v3:
>         - Add call to put_cred to avoid a memory leak. Confirmed that no =
new
>                 memory leak occurs on a Pixel 4a.
>         - Update commit log.
> v2: Add comment
>
>  drivers/base/firmware_loader/main.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
