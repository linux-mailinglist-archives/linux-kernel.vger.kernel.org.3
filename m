Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A559975A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345603AbiHSIYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiHSIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:24:44 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF98C229B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:24:43 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3321c2a8d4cso103334227b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GridmYqKIl9YhRzWxWOzxfd24n2YkgbOm/HqzMAUhEQ=;
        b=bwNIyABVmu81M7BGPfjuHZ6PjIx00blv/MpdYbhXPXackmXOce8DP2CjV/tCB/03Si
         /FmDOotUt4VGGVOPk7no9TMR+TuGC7n73wb594mU54kKQ+XCvHraCCmCzIVrPJbhPpsm
         jjdZZSO942VUB/CVHr+wodkZPIzhIaTwLheZDB0+BeLUGC1Rmzi+4CYlvzHf9VIlSsaj
         ggHRRVyYDnrW6QmjXK1pmuYAURpmrYSbNORQBd7Hna4JgukZcEaIdFcLAGzLz+g3JBos
         GeCdgmv1eq8LW+Iz3ANUpnfGua4NLHGX62ulRSTOHK0XLfbaRoLxVSMBgzs6JBPA4OgR
         WDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GridmYqKIl9YhRzWxWOzxfd24n2YkgbOm/HqzMAUhEQ=;
        b=llsWfAjmPKsD24ifIjcPJmIFQgeCNI4safWooFYnEkrENSEI5tjMCYFKpWLJYbUC4s
         NtclpxaLSAi3bLg8VoURvP6aEmispBmiDTnvP+nuzFpH1N/HSYnQwxakkWsk0e8Tszib
         MjMUbhHfbmhhiSK+Bn8m3QSLx152UgiadgvNSl3v9AsNrQJxK1mw0tLDlJjDAfpN1jyG
         /gb85F1mQfuV5vLEn1KaVbeUTHdbG8YN54CvWAVQiLEOl4Wzzy3ZtfIGPFvHdVmRmjHQ
         JkZ7fYA5xtNey1UTXqLG1EmsC+WiJYxcOfs87Ki23M0ToF7sSIF/KepaNOBRfLF28Pwx
         1AcQ==
X-Gm-Message-State: ACgBeo3ja1ZTXlef2f3mpFp4EXV8MEqi5VVcYCQ964kgNjAqkm1oiadX
        xZIFXVGKd8ZnjezS3HOaNHG/4HAhnlD+BtPjnjNIgA==
X-Google-Smtp-Source: AA6agR5Xeeq2XXdslKqjNOEIt8ha4tkJ3suR0T/hScDsfaXCZ/KwX1otEr27K/Qwm11NBboU15GFBLmyI/AXH0D6BfA=
X-Received: by 2002:a81:d543:0:b0:325:2240:ce5 with SMTP id
 l3-20020a81d543000000b0032522400ce5mr6410102ywj.210.1660897482275; Fri, 19
 Aug 2022 01:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220812143055.12938-1-olivier.masse@nxp.com>
In-Reply-To: <20220812143055.12938-1-olivier.masse@nxp.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 19 Aug 2022 13:54:31 +0530
Message-ID: <CAFA6WYM89+SrW2Br-fnFke4djt4GgGHXn7JS3=rxvAa7dAAY7w@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] tee: Add tee_shm_register_fd
To:     Olivier Masse <olivier.masse@nxp.com>
Cc:     etienne.carriere@linaro.org, jens.wiklander@linaro.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        op-tee@lists.trustedfirmware.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, clement.faure@nxp.com
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

Hi Olivier,

On Fri, 12 Aug 2022 at 20:01, Olivier Masse <olivier.masse@nxp.com> wrote:
>
> Add a new ioctl called TEE_IOC_SHM_REGISTER_FD to register a
> shared memory from a dmabuf file descriptor.
> This new ioctl will allow the Linux Kernel to register a buffer
> to be used by the Secure Data Path OPTEE OS feature.
>
> Please find more information here:
> https://static.linaro.org/connect/san19/presentations/san19-107.pdf
>
> Patch tested on Hikey 6220.
>

AFAIU, for the OP-TEE SDP feature to work you need to have a DMA-BUF
heap driver for allocating secure buffers through exposed chardev:
"/dev/dma_heap/sdp". Have you tested it with some out-of-tree driver
as I can't find it upstream? Also, do you plan to push that upstream
as well?

BTW, please add a changelog while sending newer patch-set versions.

-Sumit

> Etienne Carriere (1):
>   tee: new ioctl to a register tee_shm from a dmabuf file descriptor
>
>  drivers/tee/tee_core.c   | 38 +++++++++++++++
>  drivers/tee/tee_shm.c    | 99 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/tee_drv.h  | 11 +++++
>  include/uapi/linux/tee.h | 29 ++++++++++++
>  4 files changed, 175 insertions(+), 2 deletions(-)
>
> --
> 2.25.0
>
