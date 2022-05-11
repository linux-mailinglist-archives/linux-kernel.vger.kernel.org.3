Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4301522EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbiEKJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiEKJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:05:58 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3B1C12E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:05:55 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id h13so1679161qvh.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=axM/XiXUKEix0R64dc1cXQCZa3MQHR+yLw+4g0JGvQY=;
        b=SGuwNjk8yN5DuReUTFLczxNcdgVKjgL+MxPoD33ffYUPwAHVtGJtMTv9VzvKaEoqs8
         mYP3utWhoEzEGoz44RuU7t//p2ZLvja+vo09eh7Y5maF+EKjnlYI+YkPBMVCCa/MEG32
         YlP2r6V4B3iPeGnEh/NPXXaHdZ1s4iEIIRzNUhoKsnGLNKLBsirUKxj03GU6is2lex2A
         Scv7BtHmnRBV29wtM6WpazlkohkWWhuUUPOzrMX5ymhg+jPPqgBNUWuKeTsNk7lcFvIv
         uZzMSkOgqrB0INoNPM0etm1K07fOpLVpnbKRJk1q/hCh05S2V4AeQgSccOYQyDfIKAqo
         bzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=axM/XiXUKEix0R64dc1cXQCZa3MQHR+yLw+4g0JGvQY=;
        b=oopTFidjkljMf0GvZo9+5Zm3M+Y3TfvVe9DzCz6h6o/Fk66HhdgFVF9TfNt4H7h7nW
         S3Hrd3R70gHLTx4CcuzegBfUPNuqmGpk3+krbbVYk3TChjQwXpiO/8/Gyie7yWWCETZQ
         OUKRkqY9E01E1QaADYAenbOHFlBybdz7vPA9XRVLYmFEW3wH9uogvf0g9X338zUlGn7B
         H10PPMoBNq3BGePG85X+Qv+3WpVho8PQ9DiLao6rFdsDqxEJI8ebkc+pTOz8IPe1aDFc
         15pyWkACd69S2zDVRizTGMWVCdUpAU7t060syROqCM7xvISM5oIp2c+5Q4IZJQEMVj4t
         /cCw==
X-Gm-Message-State: AOAM533CCezCyq1UYn2eh6l6z9ZmRiVAtG8S1pONlSblmd0QG/CukNX0
        bFtDjxo1nesSwFQGPtfRPgNDfJKmVoDF3FtfJN9Zskgt9tK70tZ5as4=
X-Received: by 2002:ad4:5c88:0:b0:45a:e934:4730 with SMTP id
 o8-20020ad45c88000000b0045ae9344730mt19998535qvh.61.1652259954197; Wed, 11
 May 2022 02:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com> <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com> <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com> <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
 <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com> <CABXGCsP19VFRgTx5yGn68iCK3NxPxi_b9MTq=AmHtFPv9xR5sA@mail.gmail.com>
 <675a2d33-b286-d1d0-e4e7-05d6516026c0@gmail.com>
In-Reply-To: <675a2d33-b286-d1d0-e4e7-05d6516026c0@gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 11 May 2022 14:05:43 +0500
Message-ID: <CABXGCsOqrB5zPFCeLw-VQjePikwDq4EKFQGc9hbOb5f7tGLDgg@mail.gmail.com>
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at drivers/dma-buf/dma-fence-array.c:191
 dma_fence_array_create+0x101/0x120" and some games stopped working.
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,FREEMAIL_FROM,
        MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 1:04 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> No, I just couldn't find time during all that bug fixing :)
>
> Sorry for the delay, going to take a look after the eastern holiday here.
>
> Christian.

The message is just for history. The issue was fixed between
b253435746d9a4a and 5.18rc4.

--=20
Best Regards,
Mike Gavrilov.
