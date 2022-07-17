Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFE957776A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 19:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiGQRBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiGQRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 13:01:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104E5593
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 10:01:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h17so13971957wrx.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 10:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JvphByM1MAOXz82yC0EIJ626FOimB1Or0Bxt+vFezqM=;
        b=m5gwVxLrqgtTyZGq0uOPVFKCxV+A8iJB7uHVBYwSh7LwxhNXaV0UwRO3+pxiPB42WT
         WHd7nQuttN2COBFIcibf2ylp6AqjbZXk1U37vKYVWFPOTVE2qQSCnlRgqjZexfBrdAK/
         AivydN/zND2hHwxExjG44HsaQruFPVNp/npy5Ajcia9rS+T2pejihyxiuPAyjh3ERqF/
         Eg84sugu0/6bKyN9ch6g/Oo5YqvHHaE42KYO1DHGw4Gqd0vs4lRF75+LKIvwIOxXY7XD
         C2AohsAbspO/PkHwyNWvVS8B/Rmse9qtp3l4ZxP5+CZSyd9y04iyBsRdsj6tXstDDKzm
         /92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JvphByM1MAOXz82yC0EIJ626FOimB1Or0Bxt+vFezqM=;
        b=yxExUTd6Nww0mK6W/vihvurE9PeFw5eh52cYph+KVZ3VaNsBHuDI+yAq0mpYPISevH
         44SYfc+ym0TAUTrpCp8RQHAbFrhqTAUyw87vRuzp5N1Jh3HYSIYld7Lwt5bGIvGvVoim
         k+qlvfbZrao7eNq+e3AfEEaYiC2SRVcqhJakKwDJvpNnP8CHnEZ27oB+AvWG4uzCsM4z
         BZ/6mwtjWa8hdAOF+l4jHfvGg0x1SJqCJQOVdvp6JUnlFk02n9Mb3opUDX7yBkgeGq6/
         bCwGSNiO+FsWyDKOGN6/kotG3NtiKFgmsdR/ukMmFoogRlJymIn8+t6i+Ur6bfCc/xXB
         O3iQ==
X-Gm-Message-State: AJIora8pp2JGEEvjyBbu+ME/NrNlV4aqamT/7StJUXmY6Q2HxVKZ5NC5
        X7zK3vqXxobbXoaZzkXQvo4=
X-Google-Smtp-Source: AGRyM1sMJ8cShWVKVwOYfqlYaaIQlHVPbcZr10SqOdTxkgHj2aL4Sk/XNhjomZLJNWKtQsqk8e4y4Q==
X-Received: by 2002:a05:6000:986:b0:21d:a497:c35f with SMTP id by6-20020a056000098600b0021da497c35fmr19960283wrb.24.1658077259497;
        Sun, 17 Jul 2022 10:00:59 -0700 (PDT)
Received: from elementary ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id r129-20020a1c2b87000000b003a2eacc8179sm12509264wmr.27.2022.07.17.10.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 10:00:59 -0700 (PDT)
Date:   Sun, 17 Jul 2022 19:00:54 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        maarten.lankhorst@linux.intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb565()
Message-ID: <20220717170054.GA1028249@elementary>
References: <20220709115837.560877-1-jose.exposito89@gmail.com>
 <20220709115837.560877-5-jose.exposito89@gmail.com>
 <CABVgOSmhOBdXPH_=B_WRcUjMGC-wVPTLBwCdbgZLb0o3-O8pKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSmhOBdXPH_=B_WRcUjMGC-wVPTLBwCdbgZLb0o3-O8pKw@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

José Expósito <jose.exposito89@gmail.com> wrote:
> I already fixed the warning and added the reviewed by tags, however, I
> noticed that rebasing the series on the latest drm-misc-next show this
> error:
> [...]

Sorry for the extra email. I forgot to mention that the error is only
present in UML. Running in other architectures works as expected.
Tested on x86_64 and PowerPC.

Jose
