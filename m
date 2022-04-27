Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F33511104
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358041AbiD0GUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358040AbiD0GUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:20:20 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B1B4754E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:17:10 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id e4so987681oif.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/b/feWrZ/lTi9jqBScMUn9yWSLttJFz22wgdAWmkVo=;
        b=T3ufhEUiI/VrSttcStmtXSUMMrkgEXKQruCbrDOukOZyTKP/VLNqOzcoWjZFAVBSGp
         PgbFTviSCvl/G3rN28x8MaN0565EzHJZF698Oyal7seY/NdPtLpvn3wpBZtGxLDolqPr
         7ET6DTHGQ5DppnIbZsi2Wd2fm2xUx0p+PDtmPDofzlD4tiN6QO0XyPVzHxSNY29QUGgF
         cofQK8yabNXR+q5ranpwEaFv5rho/UkopSkgeRqIEeTQtIpzGUvyctU1OTFrQayb0Ynf
         Qxl1HAo9d2dAvTH+nV3RXQEjb7OUX1F0wMBktTnjTiMXlwiFDhua9xwXqdJMNx/6xnjT
         L3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/b/feWrZ/lTi9jqBScMUn9yWSLttJFz22wgdAWmkVo=;
        b=gJ3gwcNl1ufhCxdL+NwRSFYHv+2vDvs/PGKAuV78qMPAwmN1JFDCmE3c2TI4q4Vqob
         6SMaoiXIM+MzqKkDdtz3IjXTb0IC82go5PCaDmUu57I6P5E1aCv/ekqXQ6PmeffFFVtC
         el7wMK8cXxJPAlROdcdsIU1ALatf0EN4D8/aVJT6Tn4R1RPknrBx8M33zJtNyxnTYDW/
         LiFefTYfIQPyhVqBUPFEHjcURyOex9u8/8hl5o0YgaP/IMefzxd3dD0HnW2iqvGUjqH4
         Xog/ReMwN5j2Kxm4xi6BcOz3TSyeEVmLEVJCHGOtd5K54vq7zvvrwsDqk6aBXkZnDgDx
         EzfA==
X-Gm-Message-State: AOAM532JM6eTP+e5TS7a2O2h6WibGdTSbXlZJxBVavO+lXe5Srhw15aq
        cT37fF06/BpMBXYoCN2KHirwwcGYJJKkJIDFG9SoMgwPRVMmeQ==
X-Google-Smtp-Source: ABdhPJyP/exY90ec9Cb2A0p8JqvAKbMZ7FdZHfRcrgFuaLU4lJKresEPLA4s/995M8bg3MguObtbyU05+Tak7YBWY08=
X-Received: by 2002:a05:6808:1645:b0:325:5182:a9ca with SMTP id
 az5-20020a056808164500b003255182a9camr4810368oib.104.1651040229679; Tue, 26
 Apr 2022 23:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220425085127.2009-1-etienne.carriere@linaro.org> <YmgiQmeQSkglljEl@e120937-lin>
In-Reply-To: <YmgiQmeQSkglljEl@e120937-lin>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 27 Apr 2022 08:16:58 +0200
Message-ID: <CAN5uoS-djeP+79Gqsy7cO3RR6p55C=X8Net6jvL98X6P-S3q1g@mail.gmail.com>
Subject: Re: [PATCH v3] firmware: arm_scmi: support optee shared memory in
 optee transport
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 at 18:48, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Mon, Apr 25, 2022 at 10:51:27AM +0200, Etienne Carriere wrote:
> > Adds support for tee shared memory in optee scmi transport. When using
> > tee shared memory, scmi optee transport manages SCMI messages using
> > msg protocol (from msg.c) in shared memory, whereas smt (from shmem.c)
> > protocol is used with static IOMEM shared buffers.
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > Changes since v2:
> > - Select configuration switch ARM_SCMI_HAVE_MSG when
> >   ARM_SCMI_TRANSPORT_OPTEE is enabled.
> > - Don't consider tee_shm in invoke_process_smt_channel() since
> >   this function now assumes TEE shared memory is not used for SMT
> >   based channel.
> >
> > Changes since v1:
> > - Remove call to scmi_rx_callback() in scmi_optee_send_message().
> > ---
>
> LGTM
>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>
> Thanks,

Thanks for the help.

br,
etienne

> Cristian
>
