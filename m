Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11734F95A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiDHM0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiDHM0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:26:20 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00E433D835
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:24:16 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j6so4606426qkp.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8haz9lNrCzMYJFl+uLA+182ZFMIOXnM8/RRm392oPho=;
        b=A4FUn17kyBYqCNR8g2NaFlrL5gKyTS37EeJ/C0tnJUrJwJQVXyrMt3vJQzSiqVSX82
         1h8ngaWW1lEzQP3cvM8NZf47Lk9LYj24h9wpCRDBE5iFFPFAK8cxhX4XNB5NFF+XPLYV
         zLPkSVVyNL0RsrO9Ug3elsaXgOUP/fTNnXHPfkAS8hK9PgmP9KkFfSFkSu2JNzbW9x0I
         auiq/eA/ox6Mndrg5OWilIP/UoAnguOHIuZgC71iPErvRMudjrd5djFIfTNwDIsv6MKl
         VDhHdmQt4lv5IqaFef5ARHcaf427lo5ARxlhOAXTPP9nKBt6OeKGqhnf7FcsgQSpWzmE
         xq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8haz9lNrCzMYJFl+uLA+182ZFMIOXnM8/RRm392oPho=;
        b=pakBLjQxc6bzhU1ulg7mUsc3GAwo+OW7R1Tfg9//9yHEDEr3iJVoVR7XrTpEiWGJvh
         bwafsQ8jWnF8E+anKUCsTtR7tKs9vh5PXmbwNaezgrqpvXTCnK+fh0kAUCN2/63RRhhT
         EsEfVL3P8bjU+uAHh07VfysdUiGT93LOpdHpQ3d+soCcTq9kDg9pnmsTVcZrFC8a1mSK
         9+yEQhRrIw9pPatiCMGeO9FJ1LV5SUPB0GXXRcLMOBsgzGcYFK/y0GL8tvR5/TVR93mm
         lpnpzapFbDEbv2UZH8YGuda6pdHyfzotBg/llf4n6pCl91DIGCNSdyORCQduBsEe2xaD
         0C7w==
X-Gm-Message-State: AOAM530jUZVGguis9RJbLg1yS9qQ09ocYuXoTh6RB621mHMh1uqyQj6X
        IniX5LcH4BeoVBqp6BnXe+rGl37n01Ou4vXy19w=
X-Google-Smtp-Source: ABdhPJxyL5kwNwp3b/oQUiLEGUSzemWHGVaDVlrX2f62Eu8RCDrh/yRXM9YGpnx6ItoAhmghA2furFp3hZuX7EkFFsE=
X-Received: by 2002:a05:620a:1722:b0:67d:8efe:d4e8 with SMTP id
 az34-20020a05620a172200b0067d8efed4e8mr12746119qkb.327.1649420655726; Fri, 08
 Apr 2022 05:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com> <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
In-Reply-To: <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 8 Apr 2022 17:24:04 +0500
Message-ID: <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at drivers/dma-buf/dma-fence-array.c:191
 dma_fence_array_create+0x101/0x120" and some games stopped working.
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Ken.Xue@amd.com, "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        thomas.hellstrom@linux.intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 at 16:13, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:

> I own you a beer.
>
> I still don't know what happens here, but that makes at least a bit more
> sense than a patch which only changes comments :)
>
> Looks like we are missing something here. Can I send you a patch to try
> something later today?

Yes, please feel free to send me a patch for testing.

--=20
Best Regards,
Mike Gavrilov.
