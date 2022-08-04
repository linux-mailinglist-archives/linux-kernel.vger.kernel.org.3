Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA34589A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiHDKT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiHDKTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:19:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB942BCA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:19:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n185so10050067wmn.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=czc1T/pKPyg7RnSQHhci8IuoQWmOJ7tlHwHzQ6eQTjM=;
        b=efxhZZtVUq8SzQ86QyLAe3Ii3McULNSOS5c9BT5DwcnHKqOiy0dK1WigXCDZur6W6O
         1T894PPr1v9wfY7e/JZeNYeiMTZizMj5YM0xVb/o2PBePekrWYUfaiiBuFqkME4+7xwZ
         YoF5i13gxy/24HOc3TXn+FvtSIveiRIPTMGv6X35hydqSepm5Oitvtj2r4QVoMPYZvCO
         YdU65OvtK1aV7lfn1sVHQ14H6GB4jVljU28MddzmvMjyuOiyMuin57o2G/U00ekFeCYu
         5qkdgUCurBKE/EhS5nCCoWWJOGAqt+ywF/VdxCU4U60T2UeABgijsTQfWv4YYf6jUvGT
         yifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=czc1T/pKPyg7RnSQHhci8IuoQWmOJ7tlHwHzQ6eQTjM=;
        b=la5Snsqb47pVFnFWltbPlVSEQAz7n0VkvVlYeRRm6p0SHu4ySfWjpmBAIvisksWWPj
         r97OZMEU24u/zSiZSM6JHsPRhxpMeVA2qnAyE2DPz4g2jS8B2iiDfSAbkmBZU2JU3hsU
         ji7OS8IBPiOinJ1eU8Aqb6afXFGeycZF/eExFHCbVChBntYZ5C8r01ZImekm+fxf9y5C
         YkOrOi3lw60aOcgo0Lk6pSwp2XZz8MRrMO/+nppsnmMRflkqQ6CeQFNUVdqk6DDqZBGX
         zabmfqnOZCoCM7eguC/ybcVO/5KbmWf2+kuyY0m/T4tIbY+W32GLtaGDtK9HGhFQJx+R
         PdbQ==
X-Gm-Message-State: ACgBeo2td4jEoLeGmG19ExQUTZFpAwnQubDcphPU//MZ6oU7Px5ahfr7
        MYm1dAdAZJIG+VzhlkS1CCxmWl+bNNDC0fntCqY=
X-Google-Smtp-Source: AA6agR63hTiBEbRgmBpObKQ8me4eS7iJ8TRUTu6AGt2SC1OW4h8JFmP2UK7duJpdrjCpP1/InOLbxMvArIxT7LoKDH8=
X-Received: by 2002:a05:600c:1ca9:b0:3a5:125:3738 with SMTP id
 k41-20020a05600c1ca900b003a501253738mr4484309wms.161.1659608360199; Thu, 04
 Aug 2022 03:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220622140853.31383-1-pmladek@suse.com> <CAJhGHyDHVFto=UNrVQ5bjc11yGCnNmLKAkPPimtwF-Qa+1g==Q@mail.gmail.com>
In-Reply-To: <CAJhGHyDHVFto=UNrVQ5bjc11yGCnNmLKAkPPimtwF-Qa+1g==Q@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 4 Aug 2022 18:19:08 +0800
Message-ID: <CAJhGHyDfRGOS0v8vA7Lf+W2K80r2_+CndFBz9O-HXd6AtrexQA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Make create_worker() safe against spurious wakeups
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 4:57 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
         ;
>
> There might be some wakeups from wake_up_worker() since it is in
> the idle list.  These wakeups will be "spurious wakeups" in the view
> of the completion subsystem.
>


Oh, sorry, I was wrong. "complete(&worker->ready_to_start);" and
"worker_enter_idle(worker);" are in the same pool lock region.

There are no "spurious wakeups" from "wake_up_worker()" as I have
wrongly described.
